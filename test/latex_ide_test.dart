import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow/widgets/code_highlighter.dart';

void main() {
  group('LaTeX Syntax Highlighting Tests', () {
    test('Does not treat single quotes or prime derivatives as string literals', () {
      const code = r"Let $f'(x) = 2x$ and $f''(x) = 2$.";
      final spans = CodeHighlighter.spans(code, 'latex', CodeTheme.dark);

      // Verify no span has the string color (0xFFA5D6FF in dark theme)
      final stringSpans = spans.where((s) => s.style?.color == CodeTheme.dark.string).toList();
      expect(stringSpans, isEmpty, reason: "Prime derivatives like f'(x) must not be parsed as strings in LaTeX");
    });

    test('Does not treat double apostrophes (\'\') or quotes as string literals in LaTeX', () {
      const code = r"``This is quoted text'' in LaTeX.";
      final spans = CodeHighlighter.spans(code, 'latex', CodeTheme.dark);

      final stringSpans = spans.where((s) => s.style?.color == CodeTheme.dark.string).toList();
      expect(stringSpans, isEmpty, reason: "LaTeX closing quotes '' must not be parsed as strings");
    });

    test('Highlights LaTeX commands with keyword color', () {
      const code = r"\documentclass{article} \alpha \beta \begin{document}";
      final spans = CodeHighlighter.spans(code, 'latex', CodeTheme.dark);

      final keywordTexts = spans
          .where((s) => s.style?.color == CodeTheme.dark.keyword)
          .map((s) => s.text)
          .toList();

      expect(keywordTexts, contains(r'\documentclass'));
      expect(keywordTexts, contains(r'\alpha'));
      expect(keywordTexts, contains(r'\beta'));
      expect(keywordTexts, contains(r'\begin'));
    });

    test('Highlights LaTeX comments starting with %', () {
      const code = "x = 10\n% This is a LaTeX comment\ny = 20";
      final spans = CodeHighlighter.spans(code, 'latex', CodeTheme.dark);

      final commentSpans = spans.where((s) => s.style?.color == CodeTheme.dark.comment).toList();
      expect(commentSpans, isNotEmpty);
      expect(commentSpans.first.text, equals('% This is a LaTeX comment'));
    });

    test('Highlights LaTeX math delimiters \$ and \$\$', () {
      const code = r"Inline $x^2$ and display $$y^2$$";
      final spans = CodeHighlighter.spans(code, 'latex', CodeTheme.dark);

      final mathDelims = spans
          .where((s) => s.style?.color == CodeTheme.dark.function && (s.text == r'$' || s.text == r'$$'))
          .map((s) => s.text)
          .toList();

      expect(mathDelims, contains(r'$'));
      expect(mathDelims, contains(r'$$'));
    });
  });

  group('LaTeX Online Compiler Payload & Error Parsing Tests', () {
    test('Generates valid JSON POST payload for latex compiler', () {
      const tex = r'\documentclass{article}\begin{document}Hello\end{document}';
      final payload = jsonEncode({
        'compiler': 'pdflatex',
        'resources': [
          {'main': true, 'content': tex}
        ]
      });

      final decoded = jsonDecode(payload) as Map<String, dynamic>;
      expect(decoded['compiler'], equals('pdflatex'));
      expect(decoded['resources'], isA<List>());
      expect((decoded['resources'] as List).first['main'], isTrue);
      expect((decoded['resources'] as List).first['content'], equals(tex));
    });

    test('Extracts pdflatex log file correctly from error JSON', () {
      const errorJson = '''
      {
        "duration": 0.45,
        "error": "COMPILATION_ERROR",
        "log_files": {
          "__main_document__.log": "./__main_document__.tex:3: Undefined control sequence.\\nl.3 \\\\invalidcommand"
        },
        "logs": "Latexmk error output"
      }
      ''';

      final decoded = jsonDecode(errorJson) as Map<String, dynamic>;
      String extracted = '';
      if (decoded['log_files'] is Map && (decoded['log_files'] as Map).isNotEmpty) {
        extracted = (decoded['log_files'] as Map).values.first.toString();
      }

      expect(extracted, contains('Undefined control sequence'));
      expect(extracted, contains(r'\invalidcommand'));
    });
  });
}
