import 'dart:convert';
import 'dart:html' as html;
import 'dart:async';
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';

int _webWebViewId = 0;

Widget buildWebWebView(String htmlContent, {ValueChanged<String>? onJsError}) {
  return WebWebViewWidget(htmlContent: htmlContent, onJsError: onJsError);
}

class WebWebViewWidget extends StatefulWidget {
  final String htmlContent;
  final ValueChanged<String>? onJsError;

  const WebWebViewWidget({
    super.key,
    required this.htmlContent,
    this.onJsError,
  });

  @override
  State<WebWebViewWidget> createState() => _WebWebViewWidgetState();
}

class _WebWebViewWidgetState extends State<WebWebViewWidget> {
  late final String _viewType;
  StreamSubscription? _msgSub;

  @override
  void initState() {
    super.initState();
    _webWebViewId++;
    _viewType = 'platform-webview-$_webWebViewId';

    // Bridge the parent message system
    const bridgeScript = '''
      <script>
        window.DuoErrorChannel = {
          postMessage: function (msg) {
            window.parent.postMessage(JSON.stringify({type: 'DuoErrorChannel', message: msg}), '*');
          }
        };
      </script>
    ''';

    // Inject bridge script before anything else in head/body
    String content = widget.htmlContent;
    if (content.contains('<head>')) {
      content = content.replaceFirst('<head>', '<head>$bridgeScript');
    } else if (content.contains('<html>')) {
      content = content.replaceFirst('<html>', '<html>$bridgeScript');
    } else {
      content = bridgeScript + content;
    }

    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      final iframe = html.IFrameElement()
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..srcdoc = content;
      return iframe;
    });

    if (widget.onJsError != null) {
      _msgSub = html.window.onMessage.listen((event) {
        try {
          if (event.data is String) {
            final data = json.decode(event.data);
            if (data is Map && data['type'] == 'DuoErrorChannel') {
              widget.onJsError?.call(data['message']?.toString() ?? '');
            }
          }
        } catch (_) {}
      });
    }
  }

  @override
  void dispose() {
    _msgSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewType);
  }
}
