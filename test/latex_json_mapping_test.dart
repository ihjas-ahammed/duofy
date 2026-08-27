import 'package:flutter_test/flutter_test.dart';
import 'package:flow/services/latex_json_repairer.dart';
import 'package:flow/services/module_notes_html_builder.dart';

void main() {
  group('LatexJsonRepairer & MathJax JSON Mapping 10-Test Suite', () {
    // TEST 1: \f collisions (\frac, \forall, \varphi, \flat)
    test('Test 1: Repairs unescaped \\f LaTeX commands (\\frac, \\forall, \\varphi)', () {
      // In raw AI JSON, \frac is often emitted as single \frac, which standard JSON reads as \f (form-feed) + rac
      const rawAiJson = '''
      {
        "sectionHeading": "Calculus 1",
        "keyConcepts": [
          "Derivative limit: \$\\lim_{h \\to 0} \\frac{f(x+h) - f(x)}{h}\$",
          "Quantifier: \$\\forall x \\in \\mathbb{R}, \\varphi(x) > 0\$"
        ]
      }
      ''';

      final parsed = LatexJsonRepairer.parse(rawAiJson);
      expect(parsed, isNotNull, reason: 'Failed to parse unescaped \\f commands');
      final concepts = parsed!['keyConcepts'] as List;
      expect(concepts[0], contains(r'\frac{f(x+h) - f(x)}{h}'));
      expect(concepts[1], contains(r'\forall x'));
      expect(concepts[1], contains(r'\varphi(x)'));
    });

    // TEST 2: \b collisions (\mathbb, \beta, \binom, \begin, \mathbf, \blacksquare)
    test('Test 2: Repairs unescaped \\b LaTeX commands (\\mathbb, \\beta, \\binom, \\begin, \\blacksquare)', () {
      // In raw JSON, \b is backspace escape
      const rawAiJson = '''
      {
        "sectionHeading": "Abstract Algebra",
        "definitions": [
          {
            "title": "Field \\mathbb{F}",
            "content": "For all \\beta in \\mathbb{R}, the binomial term is \\binom{n}{k}.",
            "proof": {
              "title": "Proof.",
              "content": "Step 1: Compute \\mathbf{v}. Thus proved. \\blacksquare"
            }
          }
        ]
      }
      ''';

      final parsed = LatexJsonRepairer.parse(rawAiJson);
      expect(parsed, isNotNull, reason: 'Failed to parse unescaped \\b commands');
      final defs = parsed!['definitions'] as List;
      final d = defs[0] as Map;
      expect(d['title'], contains(r'\mathbb{F}'));
      expect(d['content'], contains(r'\beta'));
      expect(d['content'], contains(r'\binom{n}{k}'));
      expect(d['proof']['content'], contains(r'\blacksquare'));
    });

    // TEST 3: \n collisions (\nabla, \neq, \neg, \notin, \nu, \norm)
    test('Test 3: Repairs unescaped \\n LaTeX commands (\\nabla, \\neq, \\notin, \\neg)', () {
      // In raw JSON, \n is newline escape
      const rawAiJson = '''
      {
        "sectionHeading": "Vector Calculus & Set Theory",
        "contentParagraphs": [
          "Gradient operator is defined by \$\\nabla f = \\left(\\frac{\\partial f}{\\partial x}, \\frac{\\partial f}{\\partial y}\\right)\$.",
          "Condition: if \$x \\neq 0\$ and \$x \\notin S\$, then statement \$\\neg P\$ holds."
        ]
      }
      ''';

      final parsed = LatexJsonRepairer.parse(rawAiJson);
      expect(parsed, isNotNull, reason: 'Failed to parse unescaped \\n commands');
      final paragraphs = parsed!['contentParagraphs'] as List;
      expect(paragraphs[0], contains(r'\nabla f'));
      expect(paragraphs[1], contains(r'\neq 0'));
      expect(paragraphs[1], contains(r'\notin S'));
      expect(paragraphs[1], contains(r'\neg P'));
    });

    // TEST 4: \t collisions (\theta, \times, \to, \tau, \top, \text, \tilde)
    test('Test 4: Repairs unescaped \\t LaTeX commands (\\theta, \\times, \\to, \\text, \\tau)', () {
      // In raw JSON, \t is tab escape
      const rawAiJson = '''
      {
        "sectionHeading": "Trigonometry & Mappings",
        "keyConcepts": [
          "Mapping: \$f: A \\to B\$ with cross product \$\\mathbf{u} \\times \\mathbf{v}\$.",
          "Angle: \$\\theta = \\frac{\\pi}{2}\$ and \$\\tau = 2\\pi\$.",
          "Display formula: \$\$\\text{Span}(S) = \\{ \\sum c_i v_i \\}\$\$"
        ]
      }
      ''';

      final parsed = LatexJsonRepairer.parse(rawAiJson);
      expect(parsed, isNotNull, reason: 'Failed to parse unescaped \\t commands');
      final concepts = parsed!['keyConcepts'] as List;
      expect(concepts[0], contains(r'A \to B'));
      expect(concepts[0], contains(r'\mathbf{u} \times \mathbf{v}'));
      expect(concepts[1], contains(r'\theta'));
      expect(concepts[1], contains(r'\tau'));
      expect(concepts[2], contains(r'\text{Span}'));
    });

    // TEST 5: \r collisions (\rho, \right, \rangle, \Re)
    test('Test 5: Repairs unescaped \\r LaTeX commands (\\rho, \\right, \\rangle, \\Re)', () {
      // In raw JSON, \r is carriage return escape
      const rawAiJson = '''
      {
        "sectionHeading": "Quantum Mechanics & Inner Products",
        "contentParagraphs": [
          "Density matrix \$\\rho\$ satisfies \$\\left| \\psi \\right\\rangle\$ inner product \$\\langle u, v \\rangle\$.",
          "Real part: \$\\Re(z) = \\frac{z + \\bar{z}}{2}\$."
        ]
      }
      ''';

      final parsed = LatexJsonRepairer.parse(rawAiJson);
      expect(parsed, isNotNull, reason: 'Failed to parse unescaped \\r commands');
      final paragraphs = parsed!['contentParagraphs'] as List;
      expect(paragraphs[0], contains(r'\rho'));
      expect(paragraphs[0], contains(r'\right\rangle'));
      expect(paragraphs[0], contains(r'\langle u, v \rangle'));
      expect(paragraphs[1], contains(r'\Re(z)'));
    });

    // TEST 6: \u collisions (\uparrow, \underbrace, \upsilon, \bigcup)
    test('Test 6: Repairs unescaped \\u LaTeX commands (\\uparrow, \\underbrace, \\bigcup)', () {
      // In raw JSON, \u expects 4 hex digits (\uXXXX) and crashes standard jsonDecode if followed by non-hex
      const rawAiJson = '''
      {
        "sectionHeading": "Advanced Operators",
        "keyConcepts": [
          "Sequence limit: \$x_n \\uparrow x\$ as \$n \\to \\infty\$.",
          "Union over family: \$\\bigcup_{i=1}^n A_i\$.",
          "Underbrace: \$\\underbrace{x + x + \\dots + x}_{n \\text{ times}} = nx\$."
        ]
      }
      ''';

      final parsed = LatexJsonRepairer.parse(rawAiJson);
      expect(parsed, isNotNull, reason: 'Failed to parse unescaped \\u commands');
      final concepts = parsed!['keyConcepts'] as List;
      expect(concepts[0], contains(r'\uparrow x'));
      expect(concepts[1], contains(r'\bigcup_{i=1}^n'));
      expect(concepts[2], contains(r'\underbrace{x + x'));
    });

    // TEST 7: Single backslashes on non-JSON escape characters (\alpha, \sum, \int, \sqrt, \partial, \infty, \Delta)
    test('Test 7: Repairs arbitrary non-standard LaTeX escapes (\\alpha, \\sum, \\int, \\sqrt, \\partial, \\infty)', () {
      const rawAiJson = '''
      {
        "sectionHeading": "Multivariable Calculus",
        "definitions": [
          {
            "title": "Stokes Theorem",
            "content": "\$\\int_{\\partial \\Sigma} \\mathbf{F} \\cdot d\\mathbf{r} = \\iint_{\\Sigma} (\\nabla \\times \\mathbf{F}) \\cdot d\\mathbf{S}\$",
            "proof": {
              "title": "Proof.",
              "content": "Sum over all tiles \$\\sum_{i=1}^\\infty \\Delta A_i\$ as \$\\Delta A_i \\to 0\$. Hence integral converges to \$\\sqrt{\\pi}\$. \$\\blacksquare\$"
            }
          }
        ]
      }
      ''';

      final parsed = LatexJsonRepairer.parse(rawAiJson);
      expect(parsed, isNotNull, reason: 'Failed to parse single-escaped standard math commands');
      final defs = parsed!['definitions'] as List;
      final d = defs[0] as Map;
      expect(d['content'], contains(r'\int_{\partial \Sigma}'));
      expect(d['content'], contains(r'\iint_{\Sigma}'));
      expect(d['proof']['content'], contains(r'\sum_{i=1}^\infty'));
      expect(d['proof']['content'], contains(r'\sqrt{\pi}'));
    });

    // TEST 8: Matrices, Aligned Environments, and Line Breaks (\\) in JSON
    test('Test 8: Handles matrix and multi-line aligned LaTeX environments with row breaks', () {
      const rawAiJson = '''
      {
        "sectionHeading": "Linear Algebra Matrices",
        "examples": [
          {
            "title": "Matrix Multiplication Example",
            "content": "\$\$\\begin{bmatrix} a & b \\\\ c & d \\end{bmatrix} \\begin{bmatrix} x \\\\ y \\end{bmatrix} = \\begin{bmatrix} ax + by \\\\ cx + dy \\end{bmatrix}\$\$",
            "statusTag": "Worked Solution",
            "statusType": "valid"
          }
        ]
      }
      ''';

      final parsed = LatexJsonRepairer.parse(rawAiJson);
      expect(parsed, isNotNull, reason: 'Failed to parse matrix environments');
      final examples = parsed!['examples'] as List;
      final ex = examples[0] as Map;
      expect(ex['content'], contains(r'\begin{bmatrix}'));
      expect(ex['content'], contains(r'\end{bmatrix}'));
    });

    // TEST 9: Raw Markdown Code Block Fences with Unescaped Quotes and Trailing Commas
    test('Test 9: Extracts and repairs JSON wrapped in markdown fences with trailing commas', () {
      const rawAiResponse = '''
      Here is the generated study notes JSON:
      ```json
      {
        "sectionHeading": "Section 4: Group Homomorphisms",
        "keyConcepts": [
          "Homomorphism property: \$\\phi(a * b) = \\phi(a) \\cdot \\phi(b)\$",
          "Kernel: \$\\ker(\\phi) = \\{ x \\in G \\mid \\phi(x) = e_H \\}\$",
        ],
        "contentParagraphs": [
          "A homomorphism preserves the algebraic structure between groups.",
        ],
      }
      ```
      Hope this helps!
      ''';

      final parsed = LatexJsonRepairer.parse(rawAiResponse);
      expect(parsed, isNotNull, reason: 'Failed to extract and clean markdown-fenced JSON with trailing commas');
      expect(parsed!['sectionHeading'], equals('Section 4: Group Homomorphisms'));
      final concepts = parsed['keyConcepts'] as List;
      expect(concepts.length, equals(2));
      expect(concepts[0], contains(r'\phi(a * b)'));
      expect(concepts[1], contains(r'\ker(\phi)'));
    });

    // TEST 10: End-to-End JSON to HTML Pipeline matching MathJax Reference Structure
    test('Test 10: End-to-end generation from repaired JSON to valid MathJax HTML without errors', () {
      const rawAiJson = '''
      {
        "sectionHeading": "Section 1: Complex Analysis & Cauchy-Riemann",
        "keyConcepts": [
          "Holomorphic function: \$f(z) = u(x,y) + i v(x,y)\$",
          "Cauchy-Riemann equations: \$\\frac{\\partial u}{\\partial x} = \\frac{\\partial v}{\\partial y}\$ and \$\\frac{\\partial u}{\\partial y} = -\\frac{\\partial v}{\\partial x}\$"
        ],
        "contentParagraphs": [
          "If \$f\$ is complex differentiable at \$z_0\$, its real and imaginary parts satisfy the Cauchy-Riemann system."
        ],
        "definitions": [
          {
            "number": "1.1",
            "title": "Cauchy Integral Formula",
            "tag": "Theorem",
            "content": "For a holomorphic function \$f\$ inside and on a simple closed contour \$\\gamma\$, \$\$f(a) = \\frac{1}{2\\pi i} \\oint_\\gamma \\frac{f(z)}{z - a} \\, dz\$\$",
            "proof": {
              "title": "Proof.",
              "content": "Apply Green's Theorem to the real and imaginary differential forms. \$\\blacksquare\$"
            }
          }
        ],
        "diagrams": [
          {
            "title": "Contour Diagram",
            "svgContent": "<svg viewBox=\\"0 0 300 150\\" xmlns=\\"http://www.w3.org/2000/svg\\"><circle cx=\\"150\\" cy=\\"75\\" r=\\"50\\" fill=\\"#dbeafe\\" stroke=\\"#2563eb\\" stroke-width=\\"2\\"/><circle cx=\\"150\\" cy=\\"75\\" r=\\"3\\" fill=\\"#dc2626\\"/><text x=\\"155\\" y=\\"70\\" font-size=\\"12\\">a</text><text x=\\"210\\" y=\\"75\\" font-size=\\"12\\" fill=\\"#2563eb\\">&gamma;</text></svg>",
            "description": "Closed curve &gamma; enclosing point a."
          }
        ]
      }
      ''';

      final parsed = LatexJsonRepairer.parse(rawAiJson);
      expect(parsed, isNotNull);

      final html = ModuleNotesHtmlBuilder.buildHtml(
        chapterNumber: 'Module 1',
        chapterTitle: 'Complex Analysis',
        notesJson: {'sections': [parsed!]},
      );

      // Verify HTML structure
      expect(html, contains('<!DOCTYPE html>'));
      expect(html, contains('MathJax = {'));
      expect(html, contains('tex-svg.js'));
      expect(html, contains('Section 1: Complex Analysis &amp; Cauchy-Riemann'));
      expect(html, contains(r'\frac{\partial u}{\partial x}'));
      expect(html, contains(r'\oint_\gamma \frac{f(z)}{z - a}'));
      expect(html, contains(r'\blacksquare'));
      expect(html, contains('<svg viewBox="0 0 300 150"'));
      expect(html, contains('Contour Diagram'));
    });
  });
}
