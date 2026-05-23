import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:markdown/markdown.dart' as md;

/// GitHub-flavored markdown with inline KaTeX-style math, rendered natively.
///
/// Math delimiters: `$inline$` and `$$display$$` (same as GitHub's math support).
/// For fill-in-the-blank slides supply [blankController] + [onBlankChanged];
/// any `___` (3+ underscores) becomes an inline text field.
class MathMarkdown extends StatelessWidget {
  final String data;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final bool selectable;

  /// Fill-in-the-blank bridge. When provided, `___` renders as an inline input.
  final TextEditingController? blankController;
  final bool blankAnswered;
  final bool blankCorrect;
  final ValueChanged<String>? onBlankChanged;

  /// Legacy API kept for source-level compatibility — forwarded through.
  final List<md.InlineSyntax>? customSyntaxes;
  final Map<String, MarkdownElementBuilder>? customBuilders;

  const MathMarkdown({
    super.key,
    required this.data,
    this.textStyle,
    this.textAlign = TextAlign.left,
    this.selectable = true,
    this.blankController,
    this.blankAnswered = false,
    this.blankCorrect = false,
    this.onBlankChanged,
    this.customSyntaxes,
    this.customBuilders,
  });

  String _sanitize(String input) {
    return input
        .replaceAll(r'\$', r'$')
        .replaceAll(r'\[', r'$$')
        .replaceAll(r'\]', r'$$')
        .replaceAll(r'\(', r'$')
        .replaceAll(r'\)', r'$')
        .replaceAll(r'\\frac', r'\frac')
        .replaceAll(r'\\sqrt', r'\sqrt')
        .replaceAll(r'\\text', r'\text')
        .replaceAll(r'\\cdot', r'\cdot')
        .replaceAll(r'\\Delta', r'\Delta')
        .replaceAll(r'\\pi', r'\pi');
  }

  @override
  Widget build(BuildContext context) {
    final safeData = _sanitize(data);
    final baseStyle = textStyle ??
        const TextStyle(fontSize: 16, color: Colors.white, height: 1.5, fontWeight: FontWeight.w600);

    final wrapAlign = textAlign == TextAlign.center
        ? WrapAlignment.center
        : textAlign == TextAlign.right
            ? WrapAlignment.end
            : WrapAlignment.start;

    final mathStyle = baseStyle.copyWith(color: Colors.white);

    // Build the inline syntaxes list.
    final inlineSyntaxes = <md.InlineSyntax>[
      LatexInlineSyntax(),
      if (blankController != null) _BlankSyntax(),
      if (customSyntaxes != null) ...customSyntaxes!,
      ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
    ];

    // Build the element builders map.
    final builders = <String, MarkdownElementBuilder>{
      'latex': _MathBuilder(textStyle: mathStyle),
      if (blankController != null)
        'blank': _BlankBuilder(
          controller: blankController!,
          isAnswered: blankAnswered,
          isCorrect: blankCorrect,
          onChanged: onBlankChanged ?? (_) {},
        ),
      if (customBuilders != null) ...customBuilders!,
    };

    return MarkdownBody(
      data: safeData,
      selectable: selectable,
      styleSheet: MarkdownStyleSheet(
        p: baseStyle,
        textAlign: wrapAlign,
        h1: baseStyle.copyWith(fontSize: (baseStyle.fontSize ?? 16) * 1.6, fontWeight: FontWeight.w900),
        h2: baseStyle.copyWith(fontSize: (baseStyle.fontSize ?? 16) * 1.4, fontWeight: FontWeight.w800),
        h3: baseStyle.copyWith(fontSize: (baseStyle.fontSize ?? 16) * 1.2, fontWeight: FontWeight.w700),
        strong: baseStyle.copyWith(fontWeight: FontWeight.w900),
        em: baseStyle.copyWith(fontStyle: FontStyle.italic),
        code: baseStyle.copyWith(
          fontFamily: 'monospace',
          fontSize: (baseStyle.fontSize ?? 16) * 0.92,
          backgroundColor: Colors.white.withValues(alpha: 0.08),
        ),
        codeblockDecoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
        ),
        blockquoteDecoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.white.withValues(alpha: 0.25), width: 3)),
        ),
        blockquote: baseStyle.copyWith(color: Colors.white.withValues(alpha: 0.85)),
        listBullet: baseStyle,
        tableBody: baseStyle,
        tableHead: baseStyle.copyWith(fontWeight: FontWeight.w800),
        tableBorder: TableBorder.all(color: Colors.white.withValues(alpha: 0.15)),
        tableHeadAlign: TextAlign.left,
      ),
      builders: builders,
      extensionSet: md.ExtensionSet(
        [LatexBlockSyntax(), ...md.ExtensionSet.gitHubFlavored.blockSyntaxes],
        inlineSyntaxes,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Math builder (mirrors the old inline_math_builder.dart)
// ---------------------------------------------------------------------------
class _MathBuilder extends MarkdownElementBuilder {
  _MathBuilder({this.textStyle});
  final TextStyle? textStyle;

  @override
  Widget visitElementAfterWithContext(
    BuildContext context,
    md.Element element,
    TextStyle? preferredStyle,
    TextStyle? parentStyle,
  ) {
    final text = element.textContent;
    if (text.isEmpty) return const SizedBox.shrink();

    final isDisplay = element.attributes['MathStyle'] == 'display';
    final mathStyle = isDisplay ? MathStyle.display : MathStyle.text;

    final math = Math.tex(
      text,
      textStyle: textStyle,
      mathStyle: mathStyle,
      onErrorFallback: (err) {
        // Just render as normal text to prevent layout breaking
        final String fallbackText = isDisplay ? '\$\$$text\$\$' : '\$$text\$';
        return Text(
          fallbackText,
          style: textStyle,
        );
      },
    );

    if (isDisplay) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.antiAlias,
        child: math,
      );
    }

    return math;
  }
}

// ---------------------------------------------------------------------------
// Blank-field syntax + builder (inline text input inside markdown)
// ---------------------------------------------------------------------------
class _BlankSyntax extends md.InlineSyntax {
  _BlankSyntax() : super(r'___+');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    parser.addNode(md.Element.empty('blank'));
    return true;
  }
}

class _BlankBuilder extends MarkdownElementBuilder {
  _BlankBuilder({
    required this.controller,
    required this.isAnswered,
    required this.isCorrect,
    required this.onChanged,
  });

  final TextEditingController controller;
  final bool isAnswered;
  final bool isCorrect;
  final ValueChanged<String> onChanged;

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: _InlineBlankField(
        controller: controller,
        isAnswered: isAnswered,
        isCorrect: isCorrect,
        onChanged: onChanged,
      ),
    );
  }
}

// Compact auto-sizing inline text field.
class _InlineBlankField extends StatefulWidget {
  const _InlineBlankField({
    required this.controller,
    required this.isAnswered,
    required this.isCorrect,
    required this.onChanged,
  });

  final TextEditingController controller;
  final bool isAnswered;
  final bool isCorrect;
  final ValueChanged<String> onChanged;

  @override
  State<_InlineBlankField> createState() => _InlineBlankFieldState();
}

class _InlineBlankFieldState extends State<_InlineBlankField> {
  static const double _minWidth = 64.0;
  static const double _maxWidth = 220.0;
  static const double _hPad = 10.0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onText);
  }

  @override
  void didUpdateWidget(covariant _InlineBlankField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onText);
      widget.controller.addListener(_onText);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onText);
    super.dispose();
  }

  void _onText() {
    if (mounted) setState(() {});
  }

  double _measure(String text, TextStyle style) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    return tp.width;
  }

  @override
  Widget build(BuildContext context) {
    final Color answerColor = widget.isAnswered
        ? (widget.isCorrect ? const Color(0xFF58CC02) : const Color(0xFFFF4B4B))
        : const Color(0xFFFBBF24);

    final style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: answerColor,
    );

    final width = (_measure(widget.controller.text, style) + _hPad * 2 + 6)
        .clamp(_minWidth, _maxWidth)
        .toDouble();

    return SizedBox(
      width: width,
      height: 28,
      child: TextField(
        controller: widget.controller,
        enabled: !widget.isAnswered,
        onChanged: widget.onChanged,
        textAlign: TextAlign.center,
        maxLines: 1,
        style: style,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: _hPad, vertical: 4),
          filled: true,
          fillColor: Colors.black45,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
