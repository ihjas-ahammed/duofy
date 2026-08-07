/// Converts JSON representation of module study notes into a mobile-first, book-like HTML document.
/// Uses MathJax 3 for math typesetting and textbook monochrome CSS styling matching docs/example_note.html.
class ModuleNotesHtmlBuilder {
  static String buildHtml({
    required String chapterNumber,
    required String chapterTitle,
    required Map<String, dynamic> notesJson,
  }) {
    final sectionsRaw = notesJson['sections'] as List? ?? [];
    final StringBuffer sectionsHtml = StringBuffer();

    int sectionIdx = 1;
    for (var sec in sectionsRaw) {
      if (sec is! Map) continue;
      final secMap = Map<String, dynamic>.from(sec);
      final heading = secMap['sectionHeading'] ?? secMap['title'] ?? 'Section $sectionIdx';
      sectionIdx++;
      
      sectionsHtml.writeln('<section>');
      sectionsHtml.writeln('  <h2 class="section-heading">${_escapeHtml(heading.toString())}</h2>');

      // Paragraphs / Theory
      final paragraphs = secMap['contentParagraphs'] ?? secMap['paragraphs'] ?? secMap['theory'];
      if (paragraphs is List) {
        for (var p in paragraphs) {
          if (p != null && p.toString().trim().isNotEmpty) {
            sectionsHtml.writeln('  <p>${p.toString()}</p>');
          }
        }
      } else if (paragraphs is String && paragraphs.isNotEmpty) {
        sectionsHtml.writeln('  <p>$paragraphs</p>');
      }

      // Warning Boxes
      final warningBoxes = secMap['warningBoxes'] ?? secMap['warnings'];
      if (warningBoxes is List) {
        for (var w in warningBoxes) {
          if (w is Map) {
            final wMap = Map<String, dynamic>.from(w);
            final title = wMap['title'] ?? 'Word of Warning';
            final content = wMap['content'] ?? wMap['description'] ?? '';
            sectionsHtml.writeln('  <div class="warning-box">');
            sectionsHtml.writeln('    <div class="warning-title">${_escapeHtml(title.toString())}</div>');
            if (content is List) {
              sectionsHtml.writeln('    <ul>');
              for (var item in content) {
                if (item != null && item.toString().trim().isNotEmpty) {
                  sectionsHtml.writeln('      <li>${item.toString()}</li>');
                }
              }
              sectionsHtml.writeln('    </ul>');
            } else if (content.toString().isNotEmpty) {
              sectionsHtml.writeln('    <p style="margin:0;">${content.toString()}</p>');
            }
            sectionsHtml.writeln('  </div>');
          }
        }
      }

      // Definitions & Theorems (Env Boxes)
      final definitions = secMap['definitions'] ?? secMap['envBoxes'];
      if (definitions is List) {
        for (var d in definitions) {
          if (d is Map) {
            final dMap = Map<String, dynamic>.from(d);
            final number = dMap['number'] ?? '';
            final title = dMap['title'] ?? 'Definition';
            final tag = dMap['tag'] ?? 'Definition';
            final content = dMap['content'] ?? dMap['description'] ?? '';
            final proof = dMap['proof'];

            final displayTitle = number.toString().isNotEmpty ? '$number $title' : title.toString();

            sectionsHtml.writeln('  <div class="env-box">');
            sectionsHtml.writeln('    <div class="env-title">');
            sectionsHtml.writeln('      <span>${_escapeHtml(displayTitle)}</span>');
            sectionsHtml.writeln('      <span class="env-tag">${_escapeHtml(tag.toString())}</span>');
            sectionsHtml.writeln('    </div>');
            sectionsHtml.writeln('    <p style="margin:0;">${content.toString()}</p>');

            if (proof != null && proof.toString().isNotEmpty) {
              String proofTitle = 'Proof.';
              String proofContent = proof.toString();
              if (proof is Map) {
                final pMap = Map<String, dynamic>.from(proof);
                proofTitle = pMap['title'] ?? 'Proof.';
                proofContent = pMap['content'] ?? '';
              }
              sectionsHtml.writeln('    <div class="proof-block">');
              sectionsHtml.writeln('      <div class="proof-title">${_escapeHtml(proofTitle)}</div>');
              sectionsHtml.writeln('      <p>$proofContent <span class="qedsymbol">\$\\blacksquare\$</span></p>');
              sectionsHtml.writeln('    </div>');
            }

            sectionsHtml.writeln('  </div>');
          }
        }
      }

      // Examples & Counterexamples (Grid)
      final examples = secMap['examples'];
      if (examples is List && examples.isNotEmpty) {
        sectionsHtml.writeln('  <div class="example-grid">');
        for (var ex in examples) {
          if (ex is Map) {
            final exMap = Map<String, dynamic>.from(ex);
            final title = exMap['title'] ?? 'Example';
            final statusTag = exMap['statusTag'] ?? exMap['tag'];
            final statusType = (exMap['statusType'] ?? 'valid').toString().toLowerCase();
            final content = exMap['content'] ?? exMap['description'] ?? '';

            final tagClass = statusType == 'invalid' || statusType.contains('not') 
                ? 'status-invalid' 
                : 'status-valid';

            sectionsHtml.writeln('    <div class="example-card">');
            sectionsHtml.writeln('      <h4>${_escapeHtml(title.toString())}</h4>');
            if (statusTag != null && statusTag.toString().isNotEmpty) {
              sectionsHtml.writeln('      <span class="status-tag $tagClass">${_escapeHtml(statusTag.toString())}</span>');
            }
            sectionsHtml.writeln('      <p style="margin-top:0.4rem;">${content.toString()}</p>');
            sectionsHtml.writeln('    </div>');
          }
        }
        sectionsHtml.writeln('  </div>');
      }

      // Visual Diagrams & Cayley Tables
      final diagrams = secMap['diagrams'];
      if (diagrams is List) {
        for (var diag in diagrams) {
          if (diag is Map) {
            final dMap = Map<String, dynamic>.from(diag);
            final title = dMap['title'] ?? '';
            final svg = dMap['svgContent'] ?? dMap['svg'] ?? '';
            final desc = dMap['description'] ?? '';

            if (title.toString().isNotEmpty) {
              sectionsHtml.writeln('  <p style="margin-top: 1.5rem;"><strong>${_escapeHtml(title.toString())}</strong></p>');
            }
            if (svg.toString().isNotEmpty) {
              sectionsHtml.writeln('  <div class="diagram-box">');
              sectionsHtml.writeln('    ${svg.toString()}');
              sectionsHtml.writeln('  </div>');
            }
            if (desc.toString().isNotEmpty) {
              sectionsHtml.writeln('  <p style="font-size:0.9rem; color:#444;">${desc.toString()}</p>');
            }
          }
        }
      }

      final tables = secMap['tables'];
      if (tables is List) {
        for (var tbl in tables) {
          if (tbl is Map) {
            final tMap = Map<String, dynamic>.from(tbl);
            final title = tMap['title'] ?? '';
            final subtitle = tMap['subtitle'] ?? '';
            final htmlTable = tMap['htmlContent'] ?? tMap['tableHtml'] ?? '';

            if (title.toString().isNotEmpty) {
              sectionsHtml.writeln('  <p style="margin-top: 1.5rem; text-align:center; font-weight:bold;">${_escapeHtml(title.toString())}</p>');
            }
            if (subtitle.toString().isNotEmpty) {
              sectionsHtml.writeln('  <p style="text-align:center; font-size:0.85rem; color:#555;">${_escapeHtml(subtitle.toString())}</p>');
            }
            if (htmlTable.toString().isNotEmpty) {
              sectionsHtml.writeln('  <div class="table-scroll-wrapper">');
              sectionsHtml.writeln('    ${htmlTable.toString()}');
              sectionsHtml.writeln('  </div>');
            }
          }
        }
      }

      sectionsHtml.writeln('</section>');
    }

    return '''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${_escapeHtml(chapterNumber)}: ${_escapeHtml(chapterTitle)} — Study Notes</title>
    
    <!-- MathJax 3 Configuration with Callback -->
    <script>
        MathJax = {
            tex: {
                inlineMath: [['\$', '\$'], ['\\\\(', '\\\\)']],
                displayMath: [['\$\$', '\$\$'], ['\\\\[', '\\\\]']]
            },
            svg: {
                fontCache: 'global'
            },
            startup: {
                pageReady: function() {
                    return MathJax.startup.defaultPageReady().then(function() {
                        if (window.DuoMessageChannel) {
                            try {
                                window.DuoMessageChannel.postMessage(JSON.stringify({
                                    type: 'mathjax_ready',
                                    html: document.documentElement.outerHTML
                                }));
                            } catch (e) {}
                        }
                    });
                }
            }
        };
    </script>
    <script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-svg.js"></script>

    <style>
        /* STRICT STABLE MOBILE-FIRST BOOK STYLING - NO HORIZONTAL OVERFLOW */
        *, *:before, *:after {
            box-sizing: border-box !important;
        }

        html {
            width: 100%;
            max-width: 100vw;
            overflow-x: hidden !important;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Georgia, "Times New Roman", Times, serif;
            font-size: 15px;
            line-height: 1.6;
            color: #111111;
            background-color: #ffffff;
            padding: 0.75rem 0.5rem;
            margin: 0;
            width: 100%;
            max-width: 100vw;
            overflow-x: hidden !important;
            word-wrap: break-word;
            overflow-wrap: break-word;
        }

        .book-container {
            width: 100%;
            max-width: 100%;
            margin: 0 auto;
            background: #ffffff;
            padding: 1rem 0.75rem;
            border: none;
            overflow-x: hidden !important;
        }

        @media (min-width: 768px) {
            body {
                background-color: #f4f4f6;
                padding: 2rem 1rem;
            }
            .book-container {
                max-width: 850px;
                padding: 3rem 3.5rem;
                border: 1px solid #d1d5db;
            }
        }

        /* HEADER / CHAPTER TITLE */
        .chapter-header {
            border-bottom: 2px solid #111111;
            padding-bottom: 0.75rem;
            margin-bottom: 1.5rem;
            width: 100%;
            max-width: 100%;
        }

        .chapter-number {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: #444444;
            margin-bottom: 0.25rem;
        }

        .chapter-title {
            font-size: 1.6rem;
            font-weight: 700;
            color: #000000;
            letter-spacing: -0.02em;
            line-height: 1.25;
            word-break: break-word;
        }

        @media (min-width: 768px) {
            .chapter-title {
                font-size: 2.25rem;
            }
        }

        /* SECTION HEADINGS */
        .section-heading {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            font-size: 1.15rem;
            font-weight: 700;
            color: #111111;
            border-bottom: 1px solid #111111;
            padding-bottom: 0.3rem;
            margin-top: 1.75rem;
            margin-bottom: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            word-break: break-word;
        }

        p {
            margin-bottom: 1rem;
            text-align: left;
            word-break: break-word;
            overflow-wrap: break-word;
        }

        /* LATEX / TEXTBOOK ENVIRONMENT BOXES */
        .env-box {
            border: 1px solid #222222;
            background-color: #fafafa;
            padding: 0.85rem;
            margin: 1rem 0;
            width: 100%;
            max-width: 100%;
            overflow-x: hidden;
        }

        .env-title {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            font-size: 0.85rem;
            font-weight: 700;
            color: #000000;
            margin-bottom: 0.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 0.25rem;
            word-break: break-word;
        }

        .env-tag {
            font-size: 0.65rem;
            font-weight: 600;
            border: 1px solid #000000;
            padding: 0.1rem 0.35rem;
            text-transform: uppercase;
            background: #ffffff;
            white-space: nowrap;
        }

        /* PROOF ENVIRONMENT WITH CLEARFIX */
        .proof-block {
            margin-top: 0.75rem;
            padding-left: 0.75rem;
            border-left: 2px solid #333333;
            font-style: normal;
            position: relative;
            overflow: hidden;
        }

        .proof-block::after {
            content: "";
            clear: both;
            display: table;
        }

        .proof-title {
            font-style: italic;
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .qedsymbol {
            display: inline-block;
            float: right;
            font-size: 1.1rem;
            margin-left: 0.5rem;
        }

        /* WARNING / ALERT BOX */
        .warning-box {
            border: 1px solid #111111;
            border-left: 4px solid #111111;
            background-color: #f5f5f5;
            padding: 0.85rem;
            margin: 1rem 0;
            width: 100%;
            max-width: 100%;
            overflow-x: hidden;
        }

        .warning-title {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            font-weight: 700;
            font-size: 0.85rem;
            margin-bottom: 0.4rem;
            text-transform: uppercase;
            word-break: break-word;
        }

        /* EXAMPLES GRID & LISTS */
        .example-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1rem;
            margin: 1rem 0;
            width: 100%;
            max-width: 100%;
        }

        @media (min-width: 600px) {
            .example-grid {
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            }
        }

        .example-card {
            border: 1px solid #333333;
            padding: 0.85rem;
            background-color: #ffffff;
            width: 100%;
            max-width: 100%;
            overflow-x: hidden;
        }

        .example-card h4 {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            font-size: 0.85rem;
            margin-bottom: 0.4rem;
            border-bottom: 1px solid #dddddd;
            padding-bottom: 0.25rem;
            word-break: break-word;
        }

        .status-tag {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            font-size: 0.65rem;
            font-weight: 700;
            text-transform: uppercase;
            display: inline-block;
            padding: 0.1rem 0.4rem;
            border: 1px solid #111111;
            margin-bottom: 0.4rem;
        }

        .status-valid { background-color: #eeeeee; color: #000000; }
        .status-invalid { background-color: #000000; color: #ffffff; }

        /* TABLES, DIAGRAMS & MATH CONTAINERS */
        mjx-container {
            max-width: 100% !important;
            overflow-x: auto !important;
            overflow-y: hidden !important;
            box-sizing: border-box;
        }

        mjx-container[display="true"] {
            display: block !important;
            margin: 0.75em 0 !important;
            padding: 0.2em 0 !important;
            max-width: 100% !important;
        }

        .mjx-chtml, .mjx-svg, .MathJax, .MathJax_SVG_Display {
            max-width: 100% !important;
            overflow-x: auto !important;
            overflow-y: hidden !important;
        }

        .table-scroll-wrapper {
            width: 100%;
            max-width: 100%;
            overflow-x: auto !important;
            overflow-y: hidden;
            display: flex;
            justify-content: center;
            margin: 1rem 0;
            -webkit-overflow-scrolling: touch;
        }

        .cayley-table {
            border-collapse: collapse;
            margin: 0.5rem auto;
            font-family: "Courier New", Courier, monospace;
            font-size: 0.85rem;
            max-width: 100%;
        }

        .cayley-table td, .cayley-table th {
            border: 1px solid #000000;
            padding: 0.3rem 0.5rem;
            text-align: center;
        }

        .cayley-table th {
            background-color: #e5e5e5;
            font-weight: bold;
        }

        .cayley-table td.highlight {
            background-color: #e0e0e0;
            font-weight: bold;
        }

        .diagram-box {
            border: 1px solid #333333;
            padding: 0.75rem;
            background: #ffffff;
            margin: 1rem 0;
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            max-width: 100%;
            overflow-x: auto !important;
            overflow-y: hidden;
        }

        svg, img {
            max-width: 100% !important;
            height: auto !important;
        }

        ul, ol {
            padding-left: 1.25rem;
            margin: 0.5rem 0;
        }

        li {
            margin-bottom: 0.3rem;
            word-break: break-word;
        }

    </style>
</head>
<body>

<div class="book-container">

    <!-- CHAPTER TITLE -->
    <header class="chapter-header">
        <div class="chapter-number">${_escapeHtml(chapterNumber)}</div>
        <h1 class="chapter-title">${_escapeHtml(chapterTitle)}</h1>
    </header>

    $sectionsHtml

</div>

</body>
</html>
''';
  }

  static String _escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;');
  }
}
