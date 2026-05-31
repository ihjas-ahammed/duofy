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
    var s = input;

    // Normalise alternative math delimiters → $ / $$ before the markdown
    // parser runs so LatexInlineSyntax always has a consistent delimiter.
    s = s.replaceAll(r'\[', r'$$');
    s = s.replaceAll(r'\]', r'$$');
    s = s.replaceAll(r'\(', r'$');
    s = s.replaceAll(r'\)', r'$');

    // The AI is prompted to double-escape LaTeX (\\frac → \frac in the
    // runtime string). Fix ALL double-escaped commands, not just a handful.
    s = s.replaceAllMapped(
      RegExp(r'\\\\([a-zA-Z]+)'),
      (m) => '\\${m[1]}',
    );

    // HTML entities that occasionally appear in AI output
    s = s.replaceAll('&amp;', '&');
    s = s.replaceAll('&lt;', '<');
    s = s.replaceAll('&gt;', '>');
    s = s.replaceAll('&nbsp;', ' ');

    return s;
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = textStyle ??
        const TextStyle(fontSize: 16, color: Colors.white, height: 1.5, fontWeight: FontWeight.w600);

    final wrapAlign = textAlign == TextAlign.center
        ? WrapAlignment.center
        : textAlign == TextAlign.right
            ? WrapAlignment.end
            : WrapAlignment.start;

    final mathStyle = baseStyle.copyWith(color: Colors.white);

    final inlineSyntaxes = <md.InlineSyntax>[
      _PermissiveLatexInlineSyntax(),
      if (blankController != null) _BlankSyntax(),
      if (customSyntaxes != null) ...customSyntaxes!,
      ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
    ];

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
      data: _sanitize(data),
      selectable: selectable,
      softLineBreak: false,
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
// Permissive inline LaTeX syntax (replaces flutter_markdown_latex's version)
// ---------------------------------------------------------------------------
// The upstream LatexInlineSyntax uses a strict lookahead that only allows
// whitespace and a few punctuation marks after the closing delimiter. This
// means ($4$) or $x$+1 silently fails. Our version drops the lookahead so
// math is recognised regardless of the surrounding characters.
class _PermissiveLatexInlineSyntax extends md.InlineSyntax {
  _PermissiveLatexInlineSyntax() : super(_pattern);

  // Order matters: $$ before $ so the greedy display match is tried first.
  static const _delimiters = [
    (left: r'$$', right: r'$$', display: true),
    (left: r'$',  right: r'$',  display: false),
  ];

  static String _esc(String s) =>
      s.replaceAllMapped(RegExp(r'[-/\\^$*+?.()|[\]{}]'), (m) => '\\${m[0]}');

  static final String _pattern = _delimiters.map((d) {
    final l = _esc(d.left);
    final r = _esc(d.right);
    // Capture the content between delimiters (non-greedy, no unescaped
    // newlines). The outer group lets onMatch retrieve the full match
    // including delimiters.
    return '$l((?:\\\\.|[^\\\\\\n])*?)$r';
  }).join('|');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final raw = match.group(0) ?? '';

    // Determine which delimiter matched.
    var display = false;
    var delimLen = 1;
    for (final d in _delimiters) {
      if (raw.startsWith(d.left) && raw.endsWith(d.right)) {
        display = d.display;
        delimLen = d.left.length;
        break;
      }
    }

    final equation = raw.substring(delimLen, raw.length - delimLen);
    final element = md.Element.text('latex', equation);
    element.attributes['MathStyle'] = display ? 'display' : 'text';
    // Mark math that came from the *inline* syntax so the builder keeps it in
    // the flowing RichText (a WidgetSpan) instead of a SingleChildScrollView.
    // The scroll view is a non-text widget; placing it mid-paragraph splits
    // flutter_markdown's Wrap, turning the surrounding plain text into
    // atomic, non-breakable blocks that wrap as a whole — the spurious "soft
    // break" seen when two math entries are far apart. Block-level `$$…$$`
    // (handled by LatexBlockSyntax) is left unmarked so it still scrolls.
    element.attributes['inline'] = 'true';
    parser.addNode(element);
    return true;
  }
}

// ---------------------------------------------------------------------------
// Math builder with auto-fix pipeline
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
    final isInline = element.attributes['inline'] == 'true';
    final mathStyle = isDisplay ? MathStyle.display : MathStyle.text;
    final effectiveStyle = textStyle ?? parentStyle ?? preferredStyle;

    // Only *block* display math gets the horizontal scroll view (it sits on
    // its own line, so being a non-text widget is fine, and scrolling lets
    // wide equations be read in full).
    if (isDisplay && !isInline) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.antiAlias,
        child: _buildMath(text, effectiveStyle, mathStyle),
      );
    }

    // Inline math flows as a WidgetSpan inside a Text so flutter_markdown can
    // merge it into the paragraph's single RichText and wrap the surrounding
    // text. The equation itself is one atomic box that flutter_math_fork won't
    // wrap, so a long one would overflow the line. Wrapping it in a horizontal
    // SingleChildScrollView fixes that: the scroll view shrink-wraps to the
    // equation's natural width but is clamped to the line width by the
    // placeholder constraints (RenderParagraph lays out WidgetSpan children
    // with loose constraints, and the viewport sizes to
    // `constraints.constrain(child.size)`). So short math stays inline
    // untouched, while an over-long equation caps at the line width and
    // scrolls horizontally instead of overflowing.
    return Text.rich(
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          clipBehavior: Clip.antiAlias,
          child: _buildMath(text, effectiveStyle, mathStyle),
        ),
      ),
      style: effectiveStyle,
    );
  }

  /// Builds a single equation widget with the two-stage auto-fix fallback.
  Widget _buildMath(String text, TextStyle? style, MathStyle mathStyle) {
    return Math.tex(
      text,
      textStyle: style,
      mathStyle: mathStyle,
      onErrorFallback: (_) {
        // First failure — run the fix pipeline and retry once.
        final fixed = _fixLatex(text);
        return Math.tex(
          fixed,
          textStyle: style,
          mathStyle: mathStyle,
          onErrorFallback: (_) {
            // Still broken — render readable plain text.
            return Text(
              _latexToPlainText(text),
              style: style?.copyWith(
                fontStyle: FontStyle.italic,
                color: style.color?.withOpacity(0.85),
              ),
            );
          },
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// LaTeX auto-fix pipeline (offline, no network)
// ---------------------------------------------------------------------------

/// Applies a series of heuristic fixes to malformed LaTeX so that
/// flutter_math_fork can parse it. Each fix is intentionally narrow
/// so multiple fixes compose safely.
String _fixLatex(String tex) {
  var s = tex;

  // ── 1. HTML entities that sneak in from AI output ──
  s = s.replaceAll('&amp;', '&');
  s = s.replaceAll('&lt;', '<');
  s = s.replaceAll('&gt;', '>');
  s = s.replaceAll('&nbsp;', ' ');

  // ── 2. Double-escaped commands (\\frac → \frac) ──
  s = s.replaceAllMapped(
    RegExp(r'\\\\([a-zA-Z]+)'),
    (m) => '\\${m[1]}',
  );

  // ── 3. Bare well-known commands missing the leading backslash ──
  const knownCmds = [
    'frac', 'sqrt', 'text', 'mathrm', 'mathbf', 'mathit', 'mathbb',
    'cdot', 'times', 'div', 'pm', 'mp', 'leq', 'geq', 'neq', 'approx',
    'infty', 'sum', 'prod', 'int', 'lim', 'sin', 'cos', 'tan', 'log',
    'ln', 'exp', 'max', 'min', 'sup', 'inf', 'det', 'gcd',
    'alpha', 'beta', 'gamma', 'delta', 'epsilon', 'theta', 'lambda',
    'mu', 'pi', 'sigma', 'omega', 'phi', 'psi', 'rho', 'tau', 'chi',
    'Delta', 'Gamma', 'Lambda', 'Sigma', 'Omega', 'Phi', 'Psi', 'Theta',
    'to', 'rightarrow', 'leftarrow', 'Rightarrow', 'Leftarrow',
    'quad', 'qquad', 'space', 'not', 'in', 'notin', 'subset', 'subseteq',
    'cup', 'cap', 'forall', 'exists', 'partial', 'nabla',
    'binom', 'choose', 'over', 'atop',
  ];
  final cmdPattern = knownCmds.join('|');
  s = s.replaceAllMapped(
    RegExp('(?<!\\\\)\\b($cmdPattern)(?=\\b|[{(\\[^_])'),
    (m) => '\\${m[1]}',
  );

  // ── 4. Balance curly braces ──
  int depth = 0;
  for (final c in s.codeUnits) {
    if (c == 0x7B) depth++;  // {
    if (c == 0x7D) depth--;  // }
  }
  if (depth > 0) s += '}' * depth;
  if (depth < 0) s = '{' * (-depth) + s;

  // ── 5. \left / \right balance ──
  final nLeft  = RegExp(r'\\left[\s]*[(.|\[{|]').allMatches(s).length;
  final nRight = RegExp(r'\\right[\s]*[).|\]}|]').allMatches(s).length;
  if (nLeft > nRight) s += r'\right.' * (nLeft - nRight);
  if (nRight > nLeft) s = r'\left.' * (nRight - nLeft) + s;

  // ── 6. \begin without matching \end ──
  for (final m in RegExp(r'\\begin\{(\w+)\}').allMatches(s).toList()) {
    final env = m.group(1)!;
    final opens  = RegExp('\\\\begin\\{$env\\}').allMatches(s).length;
    final closes = RegExp('\\\\end\\{$env\\}').allMatches(s).length;
    if (opens > closes) {
      for (var i = 0; i < opens - closes; i++) s += '\\end{$env}';
    }
  }

  // ── 7. Remove commands flutter_math_fork doesn't support ──
  s = s.replaceAll(RegExp(r'\\(color|textcolor|colorbox)\{[^}]*\}\{'), '{');
  s = s.replaceAll(RegExp(r'\\(color|textcolor|colorbox)\{[^}]*\}'), '');
  s = s.replaceAll(RegExp(r'\\(hspace|vspace|phantom|hphantom|vphantom)\{[^}]*\}'), ' ');
  s = s.replaceAll(RegExp(r'\\(label|tag|ref|eqref|nonumber|notag)\{[^}]*\}'), '');
  s = s.replaceAll(RegExp(r'\\(label|tag|ref|eqref|nonumber|notag)\b'), '');
  s = s.replaceAll(RegExp(r'\\(displaystyle|textstyle|scriptstyle)\s*'), '');
  s = s.replaceAll(RegExp(r'\\(boxed)\{'), '{');

  // ── 8. Empty superscript / subscript (^ or _ not followed by { or a char) ──
  s = s.replaceAll(RegExp(r'\^(?=[+\-*/=\s}\\]|$)'), '');
  s = s.replaceAll(RegExp(r'_(?=[+\-*/=\s}\\]|$)'), '');

  // ── 9. Fix \text{} containing nested $ math delimiters (strip the $) ──
  s = s.replaceAllMapped(
    RegExp(r'\\text\{([^}]*)\}'),
    (m) => '\\text{${m[1]!.replaceAll(r'$', '')}}',
  );

  // ── 10. Fix common typos ──
  s = s.replaceAll(r'\fracr', r'\frac');
  s = s.replaceAll(r'\sqrtr', r'\sqrt');
  s = s.replaceAll(r'\overwithdelims', r'\over');
  s = s.replaceAll(RegExp(r'\\limits\s*_'), '_');
  s = s.replaceAll(RegExp(r'\\limits\s*\^'), '^');

  return s;
}

/// Best-effort conversion of LaTeX to readable plain text for the final
/// fallback when all fix attempts fail.
String _latexToPlainText(String tex) {
  var s = tex;
  // \frac{a}{b} → (a)/(b)
  s = s.replaceAllMapped(RegExp(r'\\frac\s*\{([^}]*)\}\s*\{([^}]*)\}'), (m) => '(${m[1]})/(${m[2]})');
  // \sqrt{x} → √(x)
  s = s.replaceAllMapped(RegExp(r'\\sqrt\s*\{([^}]*)\}'), (m) => '√(${m[1]})');
  // \text{...} → ...
  s = s.replaceAllMapped(RegExp(r'\\(?:text|mathrm|mathit|mathbf|mathbb)\s*\{([^}]*)\}'), (m) => m[1]!);
  // Symbol commands → unicode
  const symbols = {
    r'\cdot': '·', r'\times': '×', r'\div': '÷',
    r'\pm': '±', r'\mp': '∓', r'\leq': '≤', r'\geq': '≥',
    r'\neq': '≠', r'\approx': '≈', r'\infty': '∞',
    r'\alpha': 'α', r'\beta': 'β', r'\gamma': 'γ',
    r'\delta': 'δ', r'\epsilon': 'ε', r'\theta': 'θ',
    r'\lambda': 'λ', r'\mu': 'μ', r'\pi': 'π',
    r'\sigma': 'σ', r'\omega': 'ω', r'\phi': 'φ',
    r'\psi': 'ψ', r'\rho': 'ρ', r'\tau': 'τ',
    r'\chi': 'χ', r'\Delta': 'Δ', r'\Gamma': 'Γ',
    r'\Lambda': 'Λ', r'\Sigma': 'Σ', r'\Omega': 'Ω',
    r'\Phi': 'Φ', r'\Psi': 'Ψ', r'\Theta': 'Θ',
    r'\rightarrow': '→', r'\leftarrow': '←', r'\to': '→',
    r'\Rightarrow': '⇒', r'\Leftarrow': '⇐',
    r'\forall': '∀', r'\exists': '∃', r'\partial': '∂',
    r'\nabla': '∇', r'\in': '∈', r'\notin': '∉',
    r'\subset': '⊂', r'\subseteq': '⊆',
    r'\cup': '∪', r'\cap': '∩',
    r'\sum': 'Σ', r'\prod': 'Π', r'\int': '∫',
    r'\quad': '  ', r'\qquad': '    ', r'\,': ' ',
    r'\;': ' ', r'\!': '',
    r'\left': '', r'\right': '',
  };
  symbols.forEach((cmd, char) => s = s.replaceAll(cmd, char));
  // Remaining \command → command
  s = s.replaceAllMapped(RegExp(r'\\([a-zA-Z]+)'), (m) => m[1]!);
  // Strip structural braces
  s = s.replaceAll('{', '').replaceAll('}', '');
  // Collapse whitespace
  s = s.replaceAll(RegExp(r'\s+'), ' ').trim();
  return s;
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
