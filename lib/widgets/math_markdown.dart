import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
import 'package:markdown/markdown.dart' as md;

class MathMarkdown extends StatelessWidget {
  final String data;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final bool selectable;
  final List<md.InlineSyntax>? customSyntaxes;
  final Map<String, MarkdownElementBuilder>? customBuilders;

  const MathMarkdown({
    super.key, 
    required this.data, 
    this.textStyle,
    this.textAlign = TextAlign.left,
    this.selectable = true,
    this.customSyntaxes,
    this.customBuilders,
  });

  @override
  Widget build(BuildContext context) {
    // Aggressive sanitization of common AI Markdown/LaTeX generation issues
    String safeData = data
      .replaceAll(r'\$', r'$')
      .replaceAll(r'\[', r'$$')
      .replaceAll(r'\]', r'$$')
      .replaceAll(r'\(', r'$')
      .replaceAll(r'\)', r'$')
      .replaceAll(r'$.', r'$ .')
      .replaceAll(r'$,', r'$ ,')
      .replaceAll(r'_$', r'_ $')
      .replaceAll(r'-$', r'- $')
      // Clean up common double escaped literal outputs from the UI side if JSON parsing passed them raw
      .replaceAll(r'\\frac', r'\frac')
      .replaceAll(r'\\sqrt', r'\sqrt')
      .replaceAll(r'\\text', r'\text')
      .replaceAll(r'\\cdot', r'\cdot')
      .replaceAll(r'\\Delta', r'\Delta')
      .replaceAll(r'\\pi', r'\pi');

    return MarkdownBody(
      data: safeData,
      selectable: selectable,
      styleSheet: MarkdownStyleSheet(
        p: textStyle ?? const TextStyle(fontSize: 16, color: Colors.white, height: 1.5, fontWeight: FontWeight.w600),
        textAlign: textAlign == TextAlign.center ? WrapAlignment.center : WrapAlignment.start,
      ),
      builders: {
        'latex': LatexElementBuilder(
          textStyle: textStyle?.copyWith(color: Colors.white) ?? const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
        ),
        if (customBuilders != null) ...customBuilders!,
      },
      extensionSet: md.ExtensionSet(
        [LatexBlockSyntax(), ...md.ExtensionSet.gitHubFlavored.blockSyntaxes],
        [
          LatexInlineSyntax(), 
          if (customSyntaxes != null) ...customSyntaxes!,
          ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
        ],
      ),
    );
  }
}