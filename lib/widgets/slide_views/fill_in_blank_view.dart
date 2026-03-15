import 'package:flutter/material.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

class BlankSyntax extends md.InlineSyntax {
  BlankSyntax() : super(r'___+'); // Matches 3 or more underscores
  @override
  bool onMatch(md.InlineParser parser, Match match) {
    parser.addNode(md.Element.empty('blank'));
    return true;
  }
}

class BlankBuilder extends MarkdownElementBuilder {
  final String value;
  final bool isAnswered;
  final bool isCorrect;
  final Function(String) onChanged;

  BlankBuilder({required this.value, required this.isAnswered, required this.isCorrect, required this.onChanged});

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return Container(
      width: 100,
      height: 35,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: TextField(
        enabled: !isAnswered,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isAnswered ? (isCorrect ? AppTheme.duoGreen : AppTheme.duoRed) : Colors.amber,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 12),
          filled: true,
          fillColor: Colors.black45,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

class FillInBlankView extends StatelessWidget {
  final Slide slide;
  final String value;
  final bool isAnswered;
  final bool isCorrect;
  final Function(String) onChanged;

  const FillInBlankView({
    super.key, 
    required this.slide, 
    required this.value, 
    required this.isAnswered, 
    required this.isCorrect, 
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    bool hasInlineBlank = slide.content.contains('___');

    if (hasInlineBlank) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: AppTheme.glassDecoration,
          child: MathMarkdown(
            data: slide.content,
            customSyntaxes: [BlankSyntax()],
            customBuilders: {
              'blank': BlankBuilder(
                value: value,
                isAnswered: isAnswered,
                isCorrect: isCorrect,
                onChanged: onChanged,
              )
            },
          ),
        ),
      );
    }

    // Fallback: Standard block input logic if not written inline
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.glassDecoration,
            child: MathMarkdown(data: slide.content, textStyle: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isAnswered ? (isCorrect ? AppTheme.duoGreen : AppTheme.duoRed) : Colors.white12, width: 2),
            ),
            child: Column(
              children: [
                const Text('YOUR ANSWER', style: TextStyle(color: Colors.white54, fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 1.5)),
                const SizedBox(height: 12),
                TextField(
                  enabled: !isAnswered,
                  onChanged: onChanged,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.w900,
                    color: isAnswered ? (isCorrect ? AppTheme.duoGreen : AppTheme.duoRed) : Colors.amber,
                  ),
                  decoration: InputDecoration(
                    hintText: '___',
                    hintStyle: const TextStyle(color: Colors.white24),
                    filled: true,
                    fillColor: Colors.black45,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.amber, width: 2)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}