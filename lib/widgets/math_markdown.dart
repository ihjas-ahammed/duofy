import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
import 'package:markdown/markdown.dart' as md;

class MathMarkdown extends StatelessWidget {
  final String data;
  final TextStyle? textStyle;
  final TextAlign textAlign;

  const MathMarkdown({
    super.key, 
    required this.data, 
    this.textStyle,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    // Pre-process strings to fix common spacing issues that break the LaTeX parser.
    // Ensure that $ is padded if it touches punctuation, avoiding parser swallowing.
    String safeData = data
      .replaceAll(r'$.', r'$ .')
      .replaceAll(r'$,', r'$ ,')
      .replaceAll(r'_$', r'_ $')
      .replaceAll(r'-$', r'- $');

    return MarkdownBody(
      data: safeData,
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        p: textStyle ?? const TextStyle(fontSize: 16, color: Colors.white, height: 1.5, fontWeight: FontWeight.w600),
        textAlign: WrapAlignment.start,
      ),
      builders: {
        'latex': LatexElementBuilder(
          textStyle: textStyle?.copyWith(color: Colors.amber) ?? const TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.w800),
        ),
      },
      extensionSet: md.ExtensionSet(
        [LatexBlockSyntax(), ...md.ExtensionSet.gitHubFlavored.blockSyntaxes],
        [LatexInlineSyntax(), ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes],
      ),
    );
  }
}