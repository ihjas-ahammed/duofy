import '../models/app_models.dart';

/// Utility to find and fix unclosed dollar signs, missing LaTeX math closures,
/// and bare un-wrapped LaTeX commands in markdown text and slide models.
class LatexUtils {
  LatexUtils._();

  /// Known LaTeX commands used to detect bare un-wrapped LaTeX expressions.
  static const Set<String> _knownLatexCmds = {
    'frac', 'sqrt', 'int', 'sum', 'prod', 'lim', 'vec', 'hat', 'bar', 'dot', 'ddot',
    'overline', 'underline', 'mathbf', 'mathrm', 'mathit', 'mathbb', 'text',
    'alpha', 'beta', 'gamma', 'delta', 'epsilon', 'theta', 'lambda', 'mu', 'pi',
    'sigma', 'omega', 'phi', 'psi', 'rho', 'tau', 'chi', 'Delta', 'Gamma', 'Lambda',
    'Sigma', 'Omega', 'Phi', 'Psi', 'Theta', 'cdot', 'times', 'div', 'pm', 'mp',
    'leq', 'geq', 'neq', 'approx', 'infty', 'partial', 'nabla', 'rightarrow',
    'leftarrow', 'Rightarrow', 'Leftarrow', 'to', 'in', 'notin', 'subset', 'subseteq',
    'cup', 'cap', 'forall', 'exists', 'binom', 'matrix', 'pmatrix', 'bmatrix',
    'vmatrix', 'Vmatrix', 'cases', 'align', 'aligned', 'equation', 'gather'
  };

  /// Fixes unclosed dollar signs, missing dollar closures, and bare LaTeX commands in [text].
  static String fixUnclosedLatex(String text) {
    if (text.isEmpty) return text;
    var s = text;

    // 1. Normalise alternative math delimiters \( \) and \[ \] -> $ and $$
    s = s.replaceAll(r'\[', r'$$');
    s = s.replaceAll(r'\]', r'$$');
    s = s.replaceAll(r'\(', r'$');
    s = s.replaceAll(r'\)', r'$');

    // 2. Fix double backslashes in JSON strings (e.g. \\frac -> \frac)
    s = s.replaceAllMapped(RegExp(r'\\\\([a-zA-Z]+)'), (m) => '\\${m[1]}');

    // 3. Fix unclosed $$ block math
    s = _fixUnclosedDisplayMath(s);

    // 4. Fix unclosed $ inline math
    s = _fixUnclosedInlineMath(s);

    // 5. Detect and wrap bare LaTeX commands not enclosed in $ or $$
    s = _wrapBareLatexCommands(s);

    return s;
  }

  /// Fixes unclosed $$ display math blocks.
  static String _fixUnclosedDisplayMath(String input) {
    final matches = RegExp(r'\$\$').allMatches(input).toList();
    if (matches.length % 2 != 0) {
      final lastIdx = matches.last.start;
      final rest = input.substring(lastIdx + 2);
      if (!rest.contains(r'$$')) {
        final newlineIdx = rest.indexOf('\n\n');
        if (newlineIdx != -1) {
          final prefix = input.substring(0, lastIdx + 2 + newlineIdx);
          final suffix = input.substring(lastIdx + 2 + newlineIdx);
          return '$prefix\$\$$suffix';
        } else {
          return '$input\$\$';
        }
      }
    }
    return input;
  }

  /// Fixes unclosed $ inline math delimiters.
  static String _fixUnclosedInlineMath(String input) {
    var s = input;
    final lines = s.split('\n');
    final fixedLines = <String>[];

    for (var line in lines) {
      var count = 0;
      for (var i = 0; i < line.length; i++) {
        if (line[i] == '\$') {
          final isPrevDollar = i > 0 && line[i - 1] == '\$';
          final isNextDollar = i + 1 < line.length && line[i + 1] == '\$';
          if (!isPrevDollar && !isNextDollar) {
            count++;
          }
        }
      }

      if (count % 2 != 0) {
        final lastDollar = line.lastIndexOf('\$');
        if (lastDollar != -1) {
          final after = line.substring(lastDollar + 1);
          final matchPunct = RegExp(r'[.,;!?\)]').firstMatch(after);
          if (matchPunct != null) {
            final insertAt = lastDollar + 1 + matchPunct.start;
            final prefix = line.substring(0, insertAt);
            final suffix = line.substring(insertAt);
            line = '$prefix\$$suffix';
          } else {
            line = '$line\$';
          }
        }
      }
      fixedLines.add(line);
    }

    return fixedLines.join('\n');
  }

  /// Wraps bare LaTeX commands (e.g. \frac{a}{b}, \sqrt{x}, \alpha + \beta) outside $ / $$ in $...$.
  static String _wrapBareLatexCommands(String input) {
    final parts = _splitByMathDelimiters(input);
    final buffer = StringBuffer();

    for (final part in parts) {
      if (part.isMath) {
        buffer.write(part.text);
      } else {
        buffer.write(_autoWrapBareLatexInSegment(part.text));
      }
    }

    return buffer.toString();
  }

  static String _autoWrapBareLatexInSegment(String segment) {
    if (!segment.contains('\\')) return segment;

    var result = segment.replaceAllMapped(
      RegExp(r'(\\begin\{[a-zA-Z]+\}.*?\\end\{[a-zA-Z]+\})', dotAll: true),
      (m) => '\$\$\n${m[1]}\n\$\$',
    );

    final cmdPattern = _knownLatexCmds.join('|');
    final bareRegex = RegExp(
      '(\\\\(?:$cmdPattern)(?:\\{[^}]*\\}|\\[[^\\]]*\\]|_[^{}\\s]+|\\^[^{}\\s]+|\\s|\\+|-|=|\\*|/|\\(|\\)|[a-zA-Z0-9])*)',
    );

    result = result.replaceAllMapped(bareRegex, (m) {
      final match = m[1] ?? '';
      if (match.trim().isEmpty) return match;
      return '\$${match.trim()}\$';
    });

    return result;
  }

  static List<_TextPart> _splitByMathDelimiters(String input) {
    final parts = <_TextPart>[];
    final regex = RegExp(r'(\$\$.*?\$\$|\$.*?\$)', dotAll: true);
    int lastEnd = 0;

    for (final match in regex.allMatches(input)) {
      if (match.start > lastEnd) {
        parts.add(_TextPart(input.substring(lastEnd, match.start), false));
      }
      parts.add(_TextPart(match.group(0)!, true));
      lastEnd = match.end;
    }

    if (lastEnd < input.length) {
      parts.add(_TextPart(input.substring(lastEnd), false));
    }

    return parts;
  }

  /// Sanitizes all text fields of a [Slide] object by applying [fixUnclosedLatex].
  static Slide fixSlideLatex(Slide slide) {
    final updatedContent = fixUnclosedLatex(slide.content);

    List<QuizOption>? updatedOptions;
    if (slide.options != null) {
      updatedOptions = slide.options!.map((opt) {
        return QuizOption(
          id: opt.id,
          text: fixUnclosedLatex(opt.text),
          isCorrect: opt.isCorrect,
          explanation: fixUnclosedLatex(opt.explanation),
        );
      }).toList();
    }

    List<MatchPair>? updatedPairs;
    if (slide.matchPairs != null) {
      updatedPairs = slide.matchPairs!.map((pair) {
        return MatchPair(
          left: fixUnclosedLatex(pair.left),
          right: fixUnclosedLatex(pair.right),
        );
      }).toList();
    }

    List<String>? updatedOrdered;
    if (slide.orderItems != null) {
      updatedOrdered = slide.orderItems!.map((item) => fixUnclosedLatex(item)).toList();
    }

    List<String>? updatedProof;
    if (slide.proofSteps != null) {
      updatedProof = slide.proofSteps!.map((step) => fixUnclosedLatex(step)).toList();
    }

    return slide.copyWith(
      content: updatedContent,
      options: updatedOptions,
      matchPairs: updatedPairs,
      orderItems: updatedOrdered,
      proofSteps: updatedProof,
    );
  }

  /// Sanitizes all slides in a [Lesson] object by applying [fixSlideLatex].
  static Lesson fixLessonLatex(Lesson lesson) {
    if (lesson.slides.isEmpty) return lesson;
    final fixedSlides = lesson.slides.map(fixSlideLatex).toList();
    return lesson.copyWith(slides: fixedSlides);
  }
}

class _TextPart {
  final String text;
  final bool isMath;
  _TextPart(this.text, this.isMath);
}
