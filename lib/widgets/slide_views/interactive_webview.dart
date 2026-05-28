import 'package:flutter/material.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';
import '../platform_webview.dart';

class InteractiveWebview extends StatelessWidget {
  final Slide slide;

  const InteractiveWebview({super.key, required this.slide});

  String _wrapHtml() => '''
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
        ${slide.interactiveCanvasHtml ?? '<p style="color:white; font-family:sans-serif;">No Canvas Data</p>'}
      </body>
      </html>
    ''';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (slide.content.isNotEmpty)
          Container(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.35),
            decoration: BoxDecoration(
              color: AppTheme.surface.withOpacity(0.5),
              border: const Border(bottom: BorderSide(color: Colors.white12, width: 2)),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: MathMarkdown(data: slide.content),
            ),
          ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white12, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            ),
            clipBehavior: Clip.hardEdge,
            child: PlatformWebView(html: _wrapHtml()),
          ),
        ),
      ],
    );
  }
}