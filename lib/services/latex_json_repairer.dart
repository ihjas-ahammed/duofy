import 'dart:convert';

/// Ultra-robust parser and preprocessor for JSON containing raw and escaped LaTeX math.
///
/// Fixes the common JSON backslash collision issues where LaTeX commands like
/// \frac, \beta, \theta, \nabla, \rho, \uparrow, \sum, \int, \alpha, etc.
/// are either unescaped or mis-escaped by LLMs.
class LatexJsonRepairer {
  /// Known LaTeX commands that start with standard JSON escape characters (b, f, n, r, t, u).
  static final RegExp _latexEscapeWordPattern = RegExp(
    r'^[a-zA-Z]+',
  );

  /// Attempts to parse raw AI output text into a valid JSON map,
  /// automatically repairing unescaped LaTeX backslashes and markdown fences.
  static Map<String, dynamic>? parse(String rawText) {
    if (rawText.trim().isEmpty) return null;

    String jsonStr = extractJsonString(rawText);
    if (jsonStr.isEmpty) return null;

    // First attempt direct parse
    try {
      final decoded = jsonDecode(jsonStr);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is List && decoded.isNotEmpty && decoded.first is Map) {
        return {'sections': decoded};
      }
    } catch (_) {
      // Failed direct parse, proceed with specialized LaTeX backslash repair
    }

    // Repair unescaped LaTeX backslashes and JSON formatting errors
    final repaired = repair(jsonStr);

    try {
      final decoded = jsonDecode(repaired);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is List && decoded.isNotEmpty && decoded.first is Map) {
        return {'sections': decoded};
      }
    } catch (e) {
      // Second fallback: clean trailing commas and retry
      try {
        final cleanedTrailing = _removeTrailingCommas(repaired);
        final decoded = jsonDecode(cleanedTrailing);
        if (decoded is Map<String, dynamic>) return decoded;
        if (decoded is List && decoded.isNotEmpty && decoded.first is Map) {
          return {'sections': decoded};
        }
      } catch (e2) {
        print('[LatexJsonRepairer] Failed to decode repaired JSON: $e2');
      }
    }

    return null;
  }

  /// Extracts the outermost JSON string from markdown fences or text.
  static String extractJsonString(String text) {
    String cleaned = text.trim();
    if (cleaned.contains('```json')) {
      cleaned = cleaned.split('```json')[1].split('```')[0];
    } else if (cleaned.contains('```JSON')) {
      cleaned = cleaned.split('```JSON')[1].split('```')[0];
    } else if (cleaned.contains('```')) {
      final parts = cleaned.split('```');
      if (parts.length >= 2) cleaned = parts[1];
    }
    cleaned = cleaned.trim();

    final int startObj = cleaned.indexOf('{');
    final int startArr = cleaned.indexOf('[');

    int start = -1;
    if (startObj != -1 && startArr != -1) {
      start = startObj < startArr ? startObj : startArr;
    } else if (startObj != -1) {
      start = startObj;
    } else if (startArr != -1) {
      start = startArr;
    }

    if (start == -1) return '';

    final isObject = cleaned[start] == '{';
    final end = isObject ? cleaned.lastIndexOf('}') : cleaned.lastIndexOf(']');
    if (end == -1 || end < start) return '';

    return cleaned.substring(start, end + 1);
  }

  /// Scans a JSON string and fixes unescaped backslashes and LaTeX commands.
  static String repair(String json) {
    final StringBuffer out = StringBuffer();
    final int len = json.length;
    bool inString = false;
    int i = 0;

    while (i < len) {
      final char = json[i];

      if (!inString) {
        if (char == '"') {
          inString = true;
          out.write(char);
          i++;
        } else {
          out.write(char);
          i++;
        }
        continue;
      }

      // We are inside a JSON string literal
      if (char == '"') {
        inString = false;
        out.write(char);
        i++;
        continue;
      }

      if (char == '\n') {
        // Raw unescaped newline inside JSON string literal
        out.write(r'\n');
        i++;
        continue;
      }

      if (char == '\r') {
        // Raw unescaped carriage return
        out.write(r'\r');
        i++;
        continue;
      }

      if (char == '\t') {
        // Raw unescaped tab
        out.write(r'\t');
        i++;
        continue;
      }

      if (char == r'\') {
        if (i + 1 >= len) {
          // Dangling backslash at end of file
          out.write(r'\\');
          i++;
          continue;
        }

        final nextChar = json[i + 1];

        // Case 1: Escaped quote \"
        if (nextChar == '"') {
          out.write(r'\"');
          i += 2;
          continue;
        }

        // Case 2: Escaped backslash \\
        if (nextChar == r'\') {
          // Check if this \\ is a LaTeX newline (followed by whitespace/closing or &)
          out.write(r'\\');
          i += 2;
          continue;
        }

        // Case 3: Forward slash \/
        if (nextChar == '/') {
          out.write(r'\/');
          i += 2;
          continue;
        }

        // Case 4: Unicode escape \uXXXX
        if (nextChar == 'u' || nextChar == 'U') {
          if (i + 5 < len) {
            final hex = json.substring(i + 2, i + 6);
            if (RegExp(r'^[0-9a-fA-F]{4}$').hasMatch(hex)) {
              out.write(json.substring(i, i + 6));
              i += 6;
              continue;
            }
          }
          // Not a valid 4-hex unicode escape -> it's a LaTeX command like \uparrow, \bigcup, \underbrace
          out.write(r'\\');
          out.write(nextChar);
          i += 2;
          continue;
        }

        // Case 5: \b, \f, \n, \r, \t
        if (nextChar == 'b' || nextChar == 'f' || nextChar == 'n' || nextChar == 'r' || nextChar == 't') {
          final remainder = json.substring(i + 1);
          final match = _latexEscapeWordPattern.firstMatch(remainder);

          if (match != null && match.group(0)!.length > 1) {
            // It has letters after the initial escape char (e.g. \frac, \beta, \nabla, \rho, \theta, \times, \begin)
            // This is a LaTeX command, so double the backslash!
            out.write(r'\\');
            out.write(nextChar);
            i += 2;
            continue;
          } else {
            // It is a genuine standalone JSON escape (\n, \t, \r, \f, \b followed by non-alpha)
            out.write(r'\');
            out.write(nextChar);
            i += 2;
            continue;
          }
        }

        // Case 6: Any other single backslash (e.g. \alpha, \sum, \int, \sqrt, \partial, \infty, \{, \}, \;, \quad)
        out.write(r'\\');
        out.write(nextChar);
        i += 2;
        continue;
      }

      // Normal character
      out.write(char);
      i++;
    }

    return out.toString();
  }

  /// Removes trailing commas before closing braces and brackets.
  static String _removeTrailingCommas(String json) {
    return json
        .replaceAll(RegExp(r',\s*}'), '}')
        .replaceAll(RegExp(r',\s*]'), ']');
  }
}
