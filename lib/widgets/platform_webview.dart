import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' as wf;
import 'package:webview_cef/webview_cef.dart' as wc;
import 'package:webview_windows/webview_windows.dart' as ww;

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
class PlatformWebView extends StatefulWidget {
  final String html;
  final ValueChanged<String>? onJsError;

  const PlatformWebView({super.key, required this.html, this.onJsError});

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
        ..loadHtmlString(widget.html);
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
      // Bridge the page's `window.DuoErrorChannel.postMessage(...)` calls onto
      // WebView2's native message pipe so onJsError fires the same way it does
      // on the webview_flutter/webview_cef backends.
      await c.addScriptToExecuteOnDocumentCreated(
        'window.DuoErrorChannel = { postMessage: function (m) { window.chrome.webview.postMessage(String(m)); } };',
      );
      _winMsgSub = c.webMessage.listen((msg) {
        if (mounted) widget.onJsError?.call(msg.toString());
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
    } else {
      await _winController!.loadStringContent(widget.html);
    }
  }

  Future<void> _loadCef() async {
    // First-use init of the global manager. Safe to call repeatedly because
    // the manager is a singleton and `initialize()` is guarded internally.
    await PlatformWebViewBootstrap.ensureInitialized();
    final dataUrl =
        'data:text/html;charset=utf-8;base64,${base64.encode(utf8.encode(widget.html))}';
    if (_wcController == null) {
      final c = wc.WebviewManager().createWebView();
      await c.initialize(dataUrl);
      if (!mounted) {
        c.dispose();
        return;
      }
      c.setJavaScriptChannels({
        wc.JavascriptChannel(
          name: 'DuoErrorChannel',
          onMessageReceived: (wc.JavascriptMessage message) {
            if (mounted) widget.onJsError?.call(message.message);
          },
        ),
      });
      setState(() {
        _wcController = c;
        _wcReady = true;
      });
    } else {
      _wcController!.setJavaScriptChannels({
        wc.JavascriptChannel(
          name: 'DuoErrorChannel',
          onMessageReceived: (wc.JavascriptMessage message) {
            if (mounted) widget.onJsError?.call(message.message);
          },
        ),
      });
      await _wcController!.loadUrl(dataUrl);
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
