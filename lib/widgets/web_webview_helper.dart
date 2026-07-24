import 'dart:convert';
import 'dart:html' as html;
import 'dart:async';
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';

int _webWebViewId = 0;

Widget buildWebWebView(String htmlContent,
    {ValueChanged<String>? onJsError, ValueChanged<String>? onMessage}) {
  return WebWebViewWidget(
      htmlContent: htmlContent, onJsError: onJsError, onMessage: onMessage);
}

class WebWebViewWidget extends StatefulWidget {
  final String htmlContent;
  final ValueChanged<String>? onJsError;
  final ValueChanged<String>? onMessage;

  const WebWebViewWidget({
    super.key,
    required this.htmlContent,
    this.onJsError,
    this.onMessage,
  });

  @override
  State<WebWebViewWidget> createState() => _WebWebViewWidgetState();
}

class _WebWebViewWidgetState extends State<WebWebViewWidget> {
  late final String _viewType;
  StreamSubscription? _msgSub;

  /// Tags this widget's iframe messages so several live webviews (slides,
  /// PDF viewer) don't cross wires — every instance listens on the shared
  /// window.onMessage.
  late final String _instanceTag;

  @override
  void initState() {
    super.initState();
    _webWebViewId++;
    _viewType = 'platform-webview-$_webWebViewId';
    _instanceTag = 'duo-webview-$_webWebViewId';

    // Bridge both app channels to the parent window. Pages written for the
    // native webviews call DuoErrorChannel/DuoMessageChannel.postMessage —
    // the same calls work inside the iframe through window.parent.
    final bridgeScript = '''
      <script>
        window.DuoErrorChannel = {
          postMessage: function (msg) {
            window.parent.postMessage(JSON.stringify({type: 'DuoErrorChannel', tag: '$_instanceTag', message: String(msg)}), '*');
          }
        };
        window.DuoMessageChannel = {
          postMessage: function (msg) {
            window.parent.postMessage(JSON.stringify({type: 'DuoMessageChannel', tag: '$_instanceTag', message: String(msg)}), '*');
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

    if (widget.onJsError != null || widget.onMessage != null) {
      _msgSub = html.window.onMessage.listen((event) {
        try {
          if (event.data is String) {
            final data = json.decode(event.data);
            if (data is! Map) return;
            // Untagged messages predate the tag; accept them for the error
            // channel to stay lenient, but require the tag for completion
            // messages so one slide can't complete another.
            final tag = data['tag']?.toString();
            if (data['type'] == 'DuoErrorChannel' &&
                (tag == null || tag == _instanceTag)) {
              widget.onJsError?.call(data['message']?.toString() ?? '');
            } else if (data['type'] == 'DuoMessageChannel' && tag == _instanceTag) {
              widget.onMessage?.call(data['message']?.toString() ?? '');
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