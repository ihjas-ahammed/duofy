import 'dart:async';
import 'dart:convert';
import '../platform/io_shim.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_cef/webview_cef.dart' as wc;
import 'package:webview_windows/webview_windows.dart' as ww;

import 'platform_webview.dart' show PlatformWebViewController;

/// Desktop webview backends (conditionally imported by platform_webview.dart;
/// desktop_webview_stub.dart replaces this on web so webview_cef /
/// webview_windows never enter the web build):
///   - Linux   -> `webview_cef` (Chromium Embedded Framework). CEF has no
///     loadHtmlString, so the HTML is written to a temp file.
///   - Windows -> `webview_windows` (WebView2), which loads HTML strings
///     directly.
bool get useDesktopWebView => !kIsWeb && (Platform.isLinux || Platform.isWindows);

bool get _useCef => !kIsWeb && Platform.isLinux;
bool get _useWindows => !kIsWeb && Platform.isWindows;

/// One-shot global init for [wc.WebviewManager] (Linux only). Idempotent —
/// the first call awaits CEF's startup handshake, later calls are cheap.
Future<void> desktopWebViewEnsureInitialized() {
  if (!_useCef) return Future.value();
  return _DesktopWebViewState._initFuture ??= wc.WebviewManager().initialize();
}

class DesktopWebView extends StatefulWidget {
  final String html;
  final ValueChanged<String>? onJsError;
  final ValueChanged<String>? onMessage;
  final void Function(PlatformWebViewController)? onControllerCreated;

  const DesktopWebView({
    super.key,
    required this.html,
    this.onJsError,
    this.onMessage,
    this.onControllerCreated,
  });

  @override
  State<DesktopWebView> createState() => _DesktopWebViewState();
}

class _DesktopWebViewState extends State<DesktopWebView> {
  static Future<void>? _initFuture;

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
  void didUpdateWidget(DesktopWebView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.html != widget.html) _load();
  }

  void _load() {
    if (_useWindows) {
      _loadWindows();
    } else if (_useCef) {
      _loadCef();
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
    await desktopWebViewEnsureInitialized();

    // Write HTML content to a temporary file to bypass opaque data URI security restrictions
    final tempDir = Directory.systemTemp;
    final tempFile = File('${tempDir.path}/duofy_webview_${widget.html.hashCode}.html');
    if (!await tempFile.exists()) {
      await tempFile.writeAsString(widget.html);
    }
    final fileUrl = 'file://${tempFile.path}';
    debugPrint('[DesktopWebView] CEF fileUrl: $fileUrl');

    if (_wcController == null) {
      final c = wc.WebviewManager().createWebView();

      // Register listener to inject JS channels on every V8 context change (navigation)
      c.setWebviewListener(wc.WebviewEventsListener(
        onUrlChanged: (url) {
          if (!c.value) {
            debugPrint('[DesktopWebView] CEF onUrlChanged: $url (ignored, browser not ready yet)');
            return;
          }
          debugPrint('[DesktopWebView] CEF onUrlChanged: $url. Injected channels.');
          c.setJavaScriptChannels({
            wc.JavascriptChannel(
              name: 'DuoErrorChannel',
              onMessageReceived: (wc.JavascriptMessage message) {
                debugPrint('[DesktopWebView] CEF DuoErrorChannel: ${message.message}');
                String msg = message.message;
                try {
                  final decoded = jsonDecode(msg);
                  if (decoded is String) {
                    msg = decoded;
                  }
                } catch (_) {
                  if (msg.startsWith('"') && msg.endsWith('"') && msg.length >= 2) {
                    msg = msg.substring(1, msg.length - 1);
                  }
                }
                if (mounted) widget.onJsError?.call(msg);
              },
            ),
            wc.JavascriptChannel(
              name: 'DuoMessageChannel',
              onMessageReceived: (wc.JavascriptMessage message) {
                debugPrint('[DesktopWebView] CEF DuoMessageChannel: ${message.message}');
                String msg = message.message;
                try {
                  final decoded = jsonDecode(msg);
                  if (decoded is String) {
                    msg = decoded;
                  }
                } catch (_) {
                  if (msg.startsWith('"') && msg.endsWith('"') && msg.length >= 2) {
                    msg = msg.substring(1, msg.length - 1);
                  }
                }
                if (mounted) widget.onMessage?.call(msg);
              },
            ),
          });
        },
        onLoadEnd: (controller, url) {
          debugPrint('[DesktopWebView] CEF onLoadEnd: $url');
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
          debugPrint('[DesktopWebView] CEF runJavaScript length: ${js.length}');
          _wcController?.executeJavaScript(js);
        },
      ));
      debugPrint('[DesktopWebView] Loading fileUrl...');
      await _wcController!.loadUrl(fileUrl);
    } else {
      debugPrint('[DesktopWebView] Loading updated fileUrl...');
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
    if (_useWindows) {
      if (!_winReady || _winController == null) {
        return _loadingPlaceholder();
      }
      return ww.Webview(_winController!);
    }
    if (!_wcReady || _wcController == null) {
      return _loadingPlaceholder();
    }
    return _wcController!.webviewWidget;
  }

  Widget _loadingPlaceholder() => const ColoredBox(
        color: Color(0x00000000),
        child: Center(
            child: SizedBox(
                width: 24, height: 24, child: CircularProgressIndicator())),
      );
}
