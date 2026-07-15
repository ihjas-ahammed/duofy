import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' as wf;

import 'desktop_webview_io.dart' if (dart.library.html) 'desktop_webview_stub.dart';
import 'web_webview_stub.dart' if (dart.library.html) 'web_webview_helper.dart';

/// Cross-platform HTML host. Backends per platform:
///   - Web              -> sandboxed iframe (web_webview_helper.dart)
///   - Linux / Windows  -> CEF / WebView2 (desktop_webview_io.dart,
///                         conditionally imported so those native packages
///                         never enter the web build)
///   - Android/iOS/macOS-> `webview_flutter`
///
/// All backends drop in wherever the app embeds a WebView. Callers pass the
/// raw HTML string and the widget owns the controller, any data-URL/temp-file
/// encoding, and the resize lifecycle.
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

class _PlatformWebViewState extends State<PlatformWebView> {
  // webview_flutter path (Android / iOS / macOS)
  wf.WebViewController? _wfController;

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
    if (kIsWeb || useDesktopWebView) return; // handled by their own widgets
    
    bool created = false;
    if (_wfController == null) {
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
        );
      created = true;
    }

    _wfController!.loadHtmlString(widget.html);

    if (created) {
      widget.onControllerCreated?.call(PlatformWebViewController(
        runJavaScript: (js) => _wfController?.runJavaScript(js),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return buildWebWebView(
        widget.html,
        onJsError: widget.onJsError,
        onMessage: widget.onMessage,
      );
    }
    if (useDesktopWebView) {
      return DesktopWebView(
        html: widget.html,
        onJsError: widget.onJsError,
        onMessage: widget.onMessage,
        onControllerCreated: widget.onControllerCreated,
      );
    }
    return wf.WebViewWidget(controller: _wfController!);
  }
}

/// One-shot global init for the desktop webview backend (CEF on Linux).
/// Idempotent and a no-op everywhere else.
class PlatformWebViewBootstrap {
  static Future<void> ensureInitialized() => desktopWebViewEnsureInitialized();
}
