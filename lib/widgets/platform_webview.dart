import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' as wf;
import 'package:webview_cef/webview_cef.dart' as wc;

/// `webview_flutter` doesn't support Linux. On Linux we render the same inline
/// HTML through `webview_cef` (Chromium Embedded Framework). The CEF backend
/// has no loadHtmlString method, so we pack the HTML into a `data:` URL.
///
/// Both backends drop in wherever the app previously embedded a WebView.
/// Callers pass the raw HTML string and the widget owns the controller, the
/// data-URL encoding, and the resize lifecycle.
class PlatformWebView extends StatefulWidget {
  final String html;
  final ValueChanged<String>? onJsError;

  const PlatformWebView({super.key, required this.html, this.onJsError});

  @override
  State<PlatformWebView> createState() => _PlatformWebViewState();
}

bool get _useCef => !kIsWeb && (Platform.isLinux || Platform.isWindows);

class _PlatformWebViewState extends State<PlatformWebView> {
  // webview_flutter path
  wf.WebViewController? _wfController;
  // webview_cef path
  wc.WebViewController? _wcController;
  bool _wcReady = false;

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
    if (_useCef) {
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
    _wcController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_useCef) {
      if (!_wcReady || _wcController == null) {
        return const ColoredBox(
          color: Color(0x00000000),
          child: Center(
              child: SizedBox(
                  width: 24, height: 24, child: CircularProgressIndicator())),
        );
      }
      return _wcController!.webviewWidget;
    }
    return wf.WebViewWidget(controller: _wfController!);
  }
}

/// One-shot global init for [wc.WebviewManager]. Calling [ensureInitialized]
/// is idempotent — the first call awaits CEF's startup handshake and
/// subsequent calls are cheap.
class PlatformWebViewBootstrap {
  static Future<void>? _initFuture;

  static Future<void> ensureInitialized() {
    if (!_useCef) return Future.value();
    return _initFuture ??= wc.WebviewManager().initialize();
  }
}
