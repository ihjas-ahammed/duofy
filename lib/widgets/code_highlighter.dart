import 'package:flutter/material.dart';

/// A tiny, dependency-free syntax highlighter. It tokenises source with a few
/// regexes (comments, strings, numbers, keywords, decorators/annotations) and
/// returns coloured [TextSpan]s. Not a full parser — deliberately lightweight
/// and good enough for the short snippets shown on programming slides.
class CodeHighlighter {
  /// Language → keyword set. Unknown languages fall back to a generic set so
  /// highlighting degrades gracefully rather than disappearing.
  static const Map<String, Set<String>> _keywords = {
    'python': {
      'False', 'None', 'True', 'and', 'as', 'assert', 'async', 'await',
      'break', 'class', 'continue', 'def', 'del', 'elif', 'else', 'except',
      'finally', 'for', 'from', 'global', 'if', 'import', 'in', 'is', 'lambda',
      'nonlocal', 'not', 'or', 'pass', 'raise', 'return', 'try', 'while',
      'with', 'yield', 'self', 'print', 'range', 'len',
    },
    'javascript': {
      'var', 'let', 'const', 'function', 'return', 'if', 'else', 'for',
      'while', 'do', 'switch', 'case', 'break', 'continue', 'new', 'class',
      'extends', 'super', 'this', 'import', 'export', 'from', 'default',
      'async', 'await', 'try', 'catch', 'finally', 'throw', 'typeof',
      'instanceof', 'null', 'undefined', 'true', 'false', 'console',
    },
    'dart': {
      'var', 'final', 'const', 'void', 'int', 'double', 'String', 'bool',
      'class', 'extends', 'implements', 'with', 'return', 'if', 'else', 'for',
      'while', 'switch', 'case', 'break', 'continue', 'new', 'this', 'super',
      'import', 'export', 'async', 'await', 'try', 'catch', 'finally', 'throw',
      'true', 'false', 'null', 'widget', 'build', 'override',
    },
    'java': {
      'public', 'private', 'protected', 'static', 'final', 'void', 'int',
      'double', 'float', 'boolean', 'char', 'long', 'class', 'interface',
      'extends', 'implements', 'return', 'if', 'else', 'for', 'while',
      'switch', 'case', 'break', 'continue', 'new', 'this', 'super', 'import',
      'package', 'try', 'catch', 'finally', 'throw', 'throws', 'true', 'false',
      'null', 'System',
    },
    'bibtex': {
      'article', 'book', 'inproceedings', 'proceedings', 'techreport', 'manual',
      'mastersthesis', 'phdthesis', 'misc', 'unpublished', 'author', 'title',
      'journal', 'year', 'volume', 'number', 'pages', 'month', 'note',
      'publisher', 'editor', 'institution', 'school', 'address', 'doi', 'url',
      'eprint', 'howpublished', 'abstract', 'keywords',
    },
    'bib': {
      'article', 'book', 'inproceedings', 'proceedings', 'techreport', 'manual',
      'mastersthesis', 'phdthesis', 'misc', 'unpublished', 'author', 'title',
      'journal', 'year', 'volume', 'number', 'pages', 'month', 'note',
      'publisher', 'editor', 'institution', 'school', 'address', 'doi', 'url',
      'eprint', 'howpublished', 'abstract', 'keywords',
    },
  };

  static const Set<String> _generic = {
    'if', 'else', 'for', 'while', 'return', 'function', 'class', 'import',
    'export', 'const', 'let', 'var', 'def', 'true', 'false', 'null', 'void',
    'public', 'private', 'static', 'new', 'this',
  };

  /// Line-comment prefixes per language (block comments handled generically).
  static String _lineComment(String lang) {
    switch (lang) {
      case 'python':
      case 'ruby':
      case 'r':
      case 'bash':
      case 'shell':
        return '#';
      case 'lua':
      case 'sql':
        return '--';
      case 'latex':
      case 'tex':
      case 'bib':
      case 'bibtex':
        return '%';
      default:
        return '//';
    }
  }

  /// Builds highlighted spans for [code]. The blank marker `___` (any run of
  /// 3+ underscores) is emitted verbatim so callers can post-process it into a
  /// fill-in field if they want.
  static List<TextSpan> spans(String code, String language, CodeTheme theme) {
    final lang = language.toLowerCase();
    final keywords = _keywords[lang] ?? _generic;
    final lineComment = _lineComment(lang);

    final out = <TextSpan>[];
    var i = 0;
    final n = code.length;

    void push(String text, Color color, {FontStyle? style}) {
      if (text.isEmpty) return;
      out.add(TextSpan(
        text: text,
        style: TextStyle(color: color, fontStyle: style),
      ));
    }

    bool startsWith(String s) => code.startsWith(s, i);

    while (i < n) {
      final c = code[i];

      // Block comment /* ... */
      if (startsWith('/*')) {
        final end = code.indexOf('*/', i + 2);
        final stop = end == -1 ? n : end + 2;
        push(code.substring(i, stop), theme.comment, style: FontStyle.italic);
        i = stop;
        continue;
      }

      // Line comment
      if (lineComment.isNotEmpty && startsWith(lineComment)) {
        var end = code.indexOf('\n', i);
        if (end == -1) end = n;
        push(code.substring(i, end), theme.comment, style: FontStyle.italic);
        i = end;
        continue;
      }

      // Strings: triple, then single/double, then backtick (disabled for LaTeX/TeX where quotes are not strings)
      final quote = _stringQuoteAt(code, i, lang);
      if (quote != null) {
        final stop = _stringEnd(code, i, quote);
        push(code.substring(i, stop), theme.string);
        i = stop;
        continue;
      }

      // LaTeX math delimiters $ and $$
      if ((lang == 'latex' || lang == 'tex') && c == '\$') {
        if (startsWith('\$\$')) {
          push('\$\$', theme.function);
          i += 2;
        } else {
          push('\$', theme.function);
          i += 1;
        }
        continue;
      }

      // Numbers
      if (_isDigit(c) || (c == '.' && i + 1 < n && _isDigit(code[i + 1]))) {
        var j = i;
        while (j < n && _isNumberChar(code[j])) {
          j++;
        }
        push(code.substring(i, j), theme.number);
        i = j;
        continue;
      }

      // Identifiers / keywords (and the ___ blank marker)
      if (_isIdentStart(c)) {
        var j = i;
        while (j < n && _isIdentPart(code[j])) {
          j++;
        }
        final word = code.substring(i, j);
        if (RegExp(r'^_{3,}$').hasMatch(word)) {
          push(word, theme.plain); // blank marker, left as-is
        } else if (keywords.contains(word)) {
          push(word, theme.keyword);
        } else if (j < n && code[j] == '(') {
          push(word, theme.function); // call target
        } else {
          push(word, theme.plain);
        }
        i = j;
        continue;
      }

      // Decorator / annotation
      if (c == '@') {
        var j = i + 1;
        while (j < n && _isIdentPart(code[j])) {
          j++;
        }
        push(code.substring(i, j), theme.function);
        i = j;
        continue;
      }

      // LaTeX command \command or escaped char (e.g. \documentclass, \alpha, \{, \$, \\)
      if (c == '\\') {
        var j = i + 1;
        if (j < n && _isAlpha(code[j])) {
          while (j < n && _isAlpha(code[j])) {
            j++;
          }
        } else if (j < n) {
          j++; // single non-alpha escaped character
        }
        push(code.substring(i, j), theme.keyword);
        i = j;
        continue;
      }

      push(c, theme.plain);
      i++;
    }
    return out;
  }

  static String? _stringQuoteAt(String s, int i, String lang) {
    // In LaTeX, single quotes (') and double apostrophes ('') and double quotes (")
    // are closing quotation marks, accents, or prime derivatives ($f'(x)$), NOT string literals.
    if (lang == 'latex' || lang == 'tex') return null;

    if (s.startsWith('"""', i)) return '"""';
    if (s.startsWith("'''", i)) return "'''";
    final c = s[i];
    if (c == '"' || c == "'" || c == '`') return c;
    return null;
  }

  static int _stringEnd(String s, int start, String quote) {
    var i = start + quote.length;
    while (i < s.length) {
      if (s[i] == '\\') {
        i += 2;
        continue;
      }
      if (s.startsWith(quote, i)) return i + quote.length;
      i++;
    }
    return s.length;
  }

  static bool _isDigit(String c) => c.codeUnitAt(0) >= 48 && c.codeUnitAt(0) <= 57;
  static bool _isAlpha(String c) {
    final u = c.codeUnitAt(0);
    return (u >= 65 && u <= 90) || (u >= 97 && u <= 122);
  }
  static bool _isNumberChar(String c) =>
      _isDigit(c) || c == '.' || c == 'x' || c == 'e' || c == '_' ||
      (c.toLowerCase().codeUnitAt(0) >= 97 && c.toLowerCase().codeUnitAt(0) <= 102);
  static bool _isIdentStart(String c) {
    final u = c.codeUnitAt(0);
    return (u >= 65 && u <= 90) || (u >= 97 && u <= 122) || c == '_';
  }

  static bool _isIdentPart(String c) => _isIdentStart(c) || _isDigit(c);
}

/// Colour palette for [CodeHighlighter]. Code blocks always render on a dark
/// panel (conventional and high-contrast) regardless of app theme.
class CodeTheme {
  final Color background;
  final Color plain;
  final Color keyword;
  final Color string;
  final Color number;
  final Color comment;
  final Color function;

  const CodeTheme({
    required this.background,
    required this.plain,
    required this.keyword,
    required this.string,
    required this.number,
    required this.comment,
    required this.function,
  });

  /// One Dark-inspired palette.
  static const CodeTheme dark = CodeTheme(
    background: Color(0xFF0D1117),
    plain: Color(0xFFE6EDF3),
    keyword: Color(0xFFFF7B72),
    string: Color(0xFFA5D6FF),
    number: Color(0xFFD2A8FF),
    comment: Color(0xFF8B949E),
    function: Color(0xFFD2A8FF),
  );

  /// GitHub Light-inspired palette for crisp Light Mode highlighting.
  static const CodeTheme light = CodeTheme(
    background: Color(0xFFF8FAFC),
    plain: Color(0xFF0F172A),
    keyword: Color(0xFFCF222E),
    string: Color(0xFF0A3069),
    number: Color(0xFF0550AE),
    comment: Color(0xFF6E7781),
    function: Color(0xFF8250DF),
  );
}

/// A [TextEditingController] that dynamically applies syntax highlighting via [CodeHighlighter]
/// to any editable [TextField] in real time as the user types.
class CodeEditingController extends TextEditingController {
  String language;
  CodeTheme? theme;

  CodeEditingController({
    super.text,
    this.language = 'python',
    this.theme,
  });

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveTheme = theme ?? (isDark ? CodeTheme.dark : CodeTheme.light);
    final spans = CodeHighlighter.spans(text, language, effectiveTheme);
    return TextSpan(
      style: style,
      children: spans,
    );
  }
}