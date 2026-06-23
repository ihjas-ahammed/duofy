import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' as wf;
import 'package:webview_cef/webview_cef.dart' as wc;
import 'package:webview_windows/webview_windows.dart' as ww;
import 'web_webview_stub.dart' if (dart.library.html) 'web_webview_helper.dart';

/// `webview_flutter` doesn't support Linux or Windows, so each desktop OS gets
/// its own backend:
///   - Linux  -> `webview_cef` (Chromium Embedded Framework). CEF has no
///     loadHtmlString, so we pack the HTML into a `data:` URL.
///   - Windows -> `webview_windows` (WebView2). It loads HTML strings directly
///     and is the only backend that compiles cleanly for us on Windows —
///     `webview_cef`'s Windows native code is excluded from the build (see the
///     plugin platforms block in packages/webview_cef/pubspec.yaml).
///   - Everything else (Android/iOS/macOS/web) -> `webview_flutter`.
///
/// All backends drop in wherever the app previously embedded a WebView.
/// Callers pass the raw HTML string and the widget owns the controller, any
/// data-URL encoding, and the resize lifecycle.
class PlatformWebViewController {
  final void Function(String js)? runJavaScript;
  PlatformWebViewController({this.runJavaScript});
}

class PlatformWebView extends StatefulWidget {
  final String html;
  final ValueChanged<String>? onJsError;
  final ValueChanged<String>? onMessage;
  final void Function(PlatformWebViewController)? onControllerCreated;

  const PlatformWebView({
    super.key,
    required this.html,
    this.onJsError,
    this.onMessage,
    this.onControllerCreated,
  });

  @override
  State<PlatformWebView> createState() => _PlatformWebViewState();
}

bool get _useCef => !kIsWeb && Platform.isLinux;
bool get _useWindows => !kIsWeb && Platform.isWindows;

class _PlatformWebViewState extends State<PlatformWebView> {
  // webview_flutter path
  wf.WebViewController? _wfController;
  // webview_cef path (Linux)
  wc.WebViewController? _wcController;
  bool _wcReady = false;
  // webview_windows path (Windows)
  ww.WebviewController? _winController;
  bool _winReady = false;
  StreamSubscription<dynamic>? _winMsgSub;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(PlatformWebView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.html != widget.html) _load();
  }

  void _load() {
    if (kIsWeb) return;
    if (_useWindows) {
      _loadWindows();
    } else if (_useCef) {
      _loadCef();
    } else {
      _wfController = wf.WebViewController()
        ..setJavaScriptMode(wf.JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..addJavaScriptChannel(
          'DuoErrorChannel',
          onMessageReceived: (wf.JavaScriptMessage message) {
            widget.onJsError?.call(message.message);
          },
        )
        ..addJavaScriptChannel(
          'DuoMessageChannel',
          onMessageReceived: (wf.JavaScriptMessage message) {
            widget.onMessage?.call(message.message);
          },
        )
        ..loadHtmlString(widget.html);
      
      widget.onControllerCreated?.call(PlatformWebViewController(
        runJavaScript: (js) => _wfController?.runJavaScript(js),
      ));
    }
  }

  Future<void> _loadWindows() async {
    if (_winController == null) {
      final c = ww.WebviewController();
      await c.initialize();
      if (!mounted) {
        c.dispose();
        return;
      }
      await c.setBackgroundColor(const Color(0x00000000));
      await c.setPopupWindowPolicy(ww.WebviewPopupWindowPolicy.deny);
      // Bridge the page's `window.DuoErrorChannel.postMessage(...)` and
      // `window.DuoMessageChannel.postMessage(...)` calls onto
      // WebView2's native message pipe so they fire the same way they do
      // on the webview_flutter/webview_cef backends.
      await c.addScriptToExecuteOnDocumentCreated(
        'window.DuoErrorChannel = { postMessage: function (m) { window.chrome.webview.postMessage(JSON.stringify({channel: "error", message: String(m)})); } };'
        'window.DuoMessageChannel = { postMessage: function (m) { window.chrome.webview.postMessage(JSON.stringify({channel: "message", message: String(m)})); } };',
      );
      _winMsgSub = c.webMessage.listen((msg) {
        if (mounted) {
          final str = msg.toString();
          if (str.startsWith('{')) {
            try {
              final data = jsonDecode(str);
              if (data['channel'] == 'message') {
                widget.onMessage?.call(data['message']);
                return;
              } else if (data['channel'] == 'error') {
                widget.onJsError?.call(data['message']);
                return;
              }
            } catch (_) {}
          }
          widget.onJsError?.call(str);
        }
      });
      await c.loadStringContent(widget.html);
      if (!mounted) {
        c.dispose();
        return;
      }
      setState(() {
        _winController = c;
        _winReady = true;
      });
      widget.onControllerCreated?.call(PlatformWebViewController(
        runJavaScript: (js) => _winController?.executeScript(js),
      ));
    } else {
      await _winController!.loadStringContent(widget.html);
    }
  }

  Future<void> _loadCef() async {
    // First-use init of the global manager. Safe to call repeatedly because
    // the manager is a singleton and `initialize()` is guarded internally.
    await PlatformWebViewBootstrap.ensureInitialized();
    
    // Write HTML content to a temporary file to bypass opaque data URI security restrictions
    final tempDir = Directory.systemTemp;
    final tempFile = File('${tempDir.path}/duofy_webview_${widget.html.hashCode}.html');
    if (!await tempFile.exists()) {
      await tempFile.writeAsString(widget.html);
    }
    final fileUrl = 'file://${tempFile.path}';
    debugPrint('[PlatformWebView] CEF fileUrl: $fileUrl');

    if (_wcController == null) {
      final c = wc.WebviewManager().createWebView();
      
      // Register listener to inject JS channels on every V8 context change (navigation)
      c.setWebviewListener(wc.WebviewEventsListener(
        onUrlChanged: (url) {
          if (!c.value) {
            debugPrint('[PlatformWebView] CEF onUrlChanged: $url (ignored, browser not ready yet)');
            return;
          }
          debugPrint('[PlatformWebView] CEF onUrlChanged: $url. Injected channels.');
          c.setJavaScriptChannels({
            wc.JavascriptChannel(
              name: 'DuoErrorChannel',
              onMessageReceived: (wc.JavascriptMessage message) {
                debugPrint('[PlatformWebView] CEF DuoErrorChannel: ${message.message}');
                if (mounted) widget.onJsError?.call(message.message);
              },
            ),
            wc.JavascriptChannel(
              name: 'DuoMessageChannel',
              onMessageReceived: (wc.JavascriptMessage message) {
                debugPrint('[PlatformWebView] CEF DuoMessageChannel: ${message.message}');
                if (mounted) widget.onMessage?.call(message.message);
              },
            ),
          });
        },
        onLoadEnd: (controller, url) {
          debugPrint('[PlatformWebView] CEF onLoadEnd: $url');
        },
      ));

      await c.initialize('about:blank');
      if (!mounted) {
        c.dispose();
        return;
      }

      setState(() {
        _wcController = c;
        _wcReady = true;
      });
      widget.onControllerCreated?.call(PlatformWebViewController(
        runJavaScript: (js) {
          debugPrint('[PlatformWebView] CEF runJavaScript length: ${js.length}');
          _wcController?.executeJavaScript(js);
        },
      ));
      debugPrint('[PlatformWebView] Loading fileUrl...');
      await _wcController!.loadUrl(fileUrl);
    } else {
      debugPrint('[PlatformWebView] Loading updated fileUrl...');
      await _wcController!.loadUrl(fileUrl);
    }
  }

  @override
  void dispose() {
    _winMsgSub?.cancel();
    _winController?.dispose();
    _wcController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return buildWebWebView(widget.html, onJsError: widget.onJsError);
    }
    if (_useWindows) {
      if (!_winReady || _winController == null) {
        return _loadingPlaceholder();
      }
      return ww.Webview(_winController!);
    }
    if (_useCef) {
      if (!_wcReady || _wcController == null) {
        return _loadingPlaceholder();
      }
      return _wcController!.webviewWidget;
    }
    return wf.WebViewWidget(controller: _wfController!);
  }

  Widget _loadingPlaceholder() => const ColoredBox(
        color: Color(0x00000000),
        child: Center(
            child: SizedBox(
                width: 24, height: 24, child: CircularProgressIndicator())),
      );
}

/// One-shot global init for [wc.WebviewManager] (Linux only). Calling
/// [ensureInitialized] is idempotent — the first call awaits CEF's startup
/// handshake and subsequent calls are cheap. On non-Linux platforms it is a
/// no-op.
class PlatformWebViewBootstrap {
  static Future<void>? _initFuture;

  static Future<void> ensureInitialized() {
    if (!_useCef) return Future.value();
    return _initFuture ??= wc.WebviewManager().initialize();
  }
}
