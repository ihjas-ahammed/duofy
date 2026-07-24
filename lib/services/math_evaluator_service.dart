import 'dart:math' as math;

/// A robust case-insensitive parser and evaluator for mathematical expressions
/// supporting custom functions like permutations (P), combinations (C),
/// factorials (fact), standard trigonometric and logarithmic functions,
/// constants, and operators.
class MathEvaluatorService {
  /// Evaluates the mathematical expression inside [input].
  /// Strips any leading '=' (Excel style) if present.
  /// Returns the double result, or null if the expression is invalid.
  static double? tryEvaluate(String input) {
    String clean = input.trim();
    if (clean.startsWith('=')) {
      clean = clean.substring(1).trim();
    }
    if (clean.isEmpty) return null;
    try {
      final parser = _MathParser(clean);
      final val = parser.parse();
      if (val.isNaN || val.isInfinite) return null;
      return val;
    } catch (e) {
      return null;
    }
  }

  /// Formats the calculated result to a clean string representation.
  /// If it's a whole number, it formats as an integer (e.g. "20").
  /// Otherwise, it shows up to 4 decimal places, stripping trailing zeroes.
  static String? formatResult(String input) {
    final val = tryEvaluate(input);
    if (val == null) return null;
    if (val == val.roundToDouble()) {
      return val.toInt().toString();
    }
    return val.toStringAsFixed(4).replaceAll(RegExp(r'\.?0+$'), '');
  }
}

class _MathParser {
  final String text;
  int pos = 0;

  _MathParser(this.text);

  void _consume() {
    pos++;
  }

  void _skipWhitespace() {
    while (pos < text.length) {
      final code = text.codeUnitAt(pos);
      if (code == 32 || code == 9 || code == 10 || code == 13) {
        pos++;
      } else {
        break;
      }
    }
  }

  double parse() {
    _skipWhitespace();
    final result = _parseExpression();
    _skipWhitespace();
    if (pos < text.length) {
      throw FormatException("Unexpected character at position $pos: ${text[pos]}");
    }
    return result;
  }

  double _parseExpression() {
    double result = _parseTerm();
    while (true) {
      _skipWhitespace();
      if (pos >= text.length) break;
      final code = text.codeUnitAt(pos);
      if (code == 43) { // '+'
        _consume();
        result += _parseTerm();
      } else if (code == 45) { // '-'
        _consume();
        result -= _parseTerm();
      } else {
        break;
      }
    }
    return result;
  }

  double _parseTerm() {
    double result = _parseFactor();
    while (true) {
      _skipWhitespace();
      if (pos >= text.length) break;
      final code = text.codeUnitAt(pos);
      if (code == 42) { // '*'
        _consume();
        result *= _parseFactor();
      } else if (code == 47) { // '/'
        _consume();
        final divisor = _parseFactor();
        if (divisor == 0.0) throw StateError("Division by zero");
        result /= divisor;
      } else if (code == 37) { // '%'
        _consume();
        final divisor = _parseFactor();
        if (divisor == 0.0) throw StateError("Division by zero");
        result %= divisor;
      } else {
        // Implicit multiplication? E.g., 2pi or 2(3+4) or 5sin(pi)
        // Supported if the next token is '(' or a letter
        if (code == 40 || _isLetter(code)) {
          result *= _parseFactor();
        } else {
          break;
        }
      }
    }
    return result;
  }

  double _parseFactor() {
    double result = _parsePower();
    // Factorial suffix '!' (can chain, e.g. 3!! = 6! = 720)
    while (true) {
      _skipWhitespace();
      if (pos >= text.length) break;
      if (text.codeUnitAt(pos) == 33) { // '!'
        _consume();
        result = _factorial(result);
      } else {
        break;
      }
    }
    // Suffix caret '^'
    _skipWhitespace();
    if (pos < text.length && text.codeUnitAt(pos) == 94) { // '^'
      _consume();
      final exponent = _parseFactor(); // Right-associative exponentiation
      result = math.pow(result, exponent).toDouble();
    }
    return result;
  }

  double _parsePower() {
    _skipWhitespace();
    if (pos >= text.length) throw FormatException("Unexpected end of input");
    final code = text.codeUnitAt(pos);
    if (code == 43) { // '+'
      _consume();
      return _parsePower();
    } else if (code == 45) { // '-'
      _consume();
      return -_parsePower();
    }
    return _parsePrimary();
  }

  double _parsePrimary() {
    _skipWhitespace();
    if (pos >= text.length) throw FormatException("Unexpected end of input");
    final code = text.codeUnitAt(pos);

    if (code == 40) { // '('
      _consume();
      final val = _parseExpression();
      _skipWhitespace();
      if (pos >= text.length || text.codeUnitAt(pos) != 41) { // ')'
        throw FormatException("Missing closing parenthesis");
      }
      _consume();
      return val;
    }

    if (_isDigit(code) || code == 46) { // Digit or '.'
      return _parseNumber();
    }

    if (_isLetter(code)) {
      return _parseIdentifierOrFunction();
    }

    throw FormatException("Unexpected character: ${String.fromCharCode(code)}");
  }

  double _parseNumber() {
    final start = pos;
    bool hasDot = false;
    while (pos < text.length) {
      final code = text.codeUnitAt(pos);
      if (_isDigit(code)) {
        pos++;
      } else if (code == 46) { // '.'
        if (hasDot) break;
        hasDot = true;
        pos++;
      } else {
        break;
      }
    }
    final numStr = text.substring(start, pos);
    final val = double.tryParse(numStr);
    if (val == null) throw FormatException("Invalid number format: $numStr");
    return val;
  }

  double _parseIdentifierOrFunction() {
    final start = pos;
    while (pos < text.length && (_isLetter(text.codeUnitAt(pos)) || _isDigit(text.codeUnitAt(pos)))) {
      pos++;
    }
    final id = text.substring(start, pos).toLowerCase();
    _skipWhitespace();

    // Check if it's a function call (has a '(' next)
    if (pos < text.length && text.codeUnitAt(pos) == 40) { // '('
      _consume(); // consume '('
      final args = <double>[];
      if (pos < text.length && text.codeUnitAt(pos) != 41) { // not ')'
        args.add(_parseExpression());
        while (true) {
          _skipWhitespace();
          if (pos < text.length && text.codeUnitAt(pos) == 44) { // ','
            _consume();
            args.add(_parseExpression());
          } else {
            break;
          }
        }
      }
      _skipWhitespace();
      if (pos >= text.length || text.codeUnitAt(pos) != 41) {
        throw FormatException("Missing closing parenthesis for function $id");
      }
      _consume(); // consume ')'
      return _callFunction(id, args);
    }

    // Otherwise, check if it's a constant
    if (id == 'pi') return math.pi;
    if (id == 'e') return math.e;

    throw FormatException("Unknown identifier: $id");
  }

  double _callFunction(String name, List<double> args) {
    switch (name) {
      // Custom permutation & combination
      case 'p':
        if (args.length != 2) throw ArgumentError("P(n, r) requires exactly 2 arguments");
        return _permutation(args[0], args[1]);
      case 'c':
        if (args.length != 2) throw ArgumentError("C(n, r) requires exactly 2 arguments");
        return _combination(args[0], args[1]);
      case 'fact':
        if (args.length != 1) throw ArgumentError("fact(n) requires exactly 1 argument");
        return _factorial(args[0]);

      // Standard math functions
      case 'sin':
        if (args.length != 1) throw ArgumentError("sin(x) requires 1 argument");
        return math.sin(args[0]);
      case 'cos':
        if (args.length != 1) throw ArgumentError("cos(x) requires 1 argument");
        return math.cos(args[0]);
      case 'tan':
        if (args.length != 1) throw ArgumentError("tan(x) requires 1 argument");
        return math.tan(args[0]);
      case 'asin':
        if (args.length != 1) throw ArgumentError("asin(x) requires 1 argument");
        return math.asin(args[0]);
      case 'acos':
        if (args.length != 1) throw ArgumentError("acos(x) requires 1 argument");
        return math.acos(args[0]);
      case 'atan':
        if (args.length != 1) throw ArgumentError("atan(x) requires 1 argument");
        return math.atan(args[0]);
      case 'sqrt':
        if (args.length != 1) throw ArgumentError("sqrt(x) requires 1 argument");
        return math.sqrt(args[0]);
      case 'cbrt':
        if (args.length != 1) throw ArgumentError("cbrt(x) requires 1 argument");
        final x = args[0];
        return x >= 0 ? math.pow(x, 1.0 / 3.0).toDouble() : -math.pow(-x, 1.0 / 3.0).toDouble();
      case 'abs':
        if (args.length != 1) throw ArgumentError("abs(x) requires 1 argument");
        return args[0].abs();
      case 'ceil':
        if (args.length != 1) throw ArgumentError("ceil(x) requires 1 argument");
        return args[0].ceilToDouble();
      case 'floor':
        if (args.length != 1) throw ArgumentError("floor(x) requires 1 argument");
        return args[0].floorToDouble();
      case 'round':
        if (args.length != 1) throw ArgumentError("round(x) requires 1 argument");
        return args[0].roundToDouble();
      case 'log':
        if (args.length == 1) {
          return math.log(args[0]) / math.ln10;
        } else if (args.length == 2) {
          return math.log(args[0]) / math.log(args[1]);
        }
        throw ArgumentError("log requires 1 or 2 arguments");
      case 'ln':
        if (args.length != 1) throw ArgumentError("ln(x) requires 1 argument");
        return math.log(args[0]);
      case 'exp':
        if (args.length != 1) throw ArgumentError("exp(x) requires 1 argument");
        return math.exp(args[0]);
      case 'pow':
        if (args.length != 2) throw ArgumentError("pow(x, y) requires exactly 2 arguments");
        return math.pow(args[0], args[1]).toDouble();
      case 'min':
        if (args.isEmpty) throw ArgumentError("min requires at least 1 argument");
        return args.reduce(math.min);
      case 'max':
        if (args.isEmpty) throw ArgumentError("max requires at least 1 argument");
        return args.reduce(math.max);
      default:
        throw FormatException("Unknown function: $name");
    }
  }

  bool _isDigit(int code) => code >= 48 && code <= 57;
  bool _isLetter(int code) => (code >= 65 && code <= 90) || (code >= 97 && code <= 122) || code == 95; // A-Z, a-z, _
}

double _factorial(double n) {
  if (n < 0) throw ArgumentError("Factorial of negative number is undefined");
  int val = n.round();
  double result = 1.0;
  for (int i = 2; i <= val; i++) {
    result *= i;
  }
  return result;
}

double _permutation(double n, double r) {
  int ni = n.round();
  int ri = r.round();
  if (ni < 0 || ri < 0 || ni < ri) return 0.0;
  double result = 1.0;
  for (int i = ni - ri + 1; i <= ni; i++) {
    result *= i;
  }
  return result;
}

double _combination(double n, double r) {
  int ni = n.round();
  int ri = r.round();
  if (ni < 0 || ri < 0 || ni < ri) return 0.0;
  if (ri == 0 || ni == ri) return 1.0;
  if (ri > ni - ri) {
    ri = ni - ri;
  }
  double result = 1.0;
  for (int i = 1; i <= ri; i++) {
    result *= (ni - ri + i) / i;
  }
  return result;
}