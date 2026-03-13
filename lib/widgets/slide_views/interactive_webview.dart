import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../models/app_models.dart';
import '../math_markdown.dart';

class InteractiveWebview extends StatefulWidget {
  final Slide slide;

  const InteractiveWebview({super.key, required this.slide});

  @override
  State<InteractiveWebview> createState() => _InteractiveWebviewState();
}

class _InteractiveWebviewState extends State<InteractiveWebview> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    
    final htmlWrapper = '''
      <!DOCTYPE html>
      <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <style>
          body { margin: 0; padding: 0; background-color: transparent; overflow: hidden; display: flex; justify-content: center; align-items: center; height: 100vh; }
          canvas { max-width: 100%; max-height: 100%; border-radius: 16px; display: block; }
        </style>
      </head>
      <body>
        ${widget.slide.interactiveCanvasHtml ?? '<p style="color:white; font-family:sans-serif;">No Canvas Data</p>'}
      </body>
      </html>
    ''';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadHtmlString(htmlWrapper);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.slide.content.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: MathMarkdown(data: widget.slide.content),
          ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white12, width: 2),
            ),
            clipBehavior: Clip.hardEdge,
            child: WebViewWidget(controller: _controller),
          ),
        ),
      ],
    );
  }
}