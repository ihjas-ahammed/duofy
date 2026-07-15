import 'dart:convert';

import 'package:flutter/material.dart';

import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../duo_button.dart';
import '../math_markdown.dart';
import '../platform_webview.dart';

/// A `try_yourself` slide: an in-app code playground. A WebView hosts a
/// language-specific runtime (Python via Pyodide, or a live web/LaTeX preview)
/// seeded with the slide's starter [Slide.code] and [Slide.packages]. The
/// runtime boots as soon as the slide mounts. Learning-by-doing, so there's no
/// right answer — a Continue button advances the lesson.
class CodeRunnerView extends StatefulWidget {
  final Slide slide;
  final VoidCallback onComplete;

  const CodeRunnerView({
    super.key,
    required this.slide,
    required this.onComplete,
  });

  @override
  State<CodeRunnerView> createState() => _CodeRunnerViewState();
}

class _CodeRunnerViewState extends State<CodeRunnerView> {
  String get _language => (widget.slide.language ?? 'python').toLowerCase();
  String get _code =>
      (widget.slide.code?.trim().isNotEmpty ?? false)
          ? widget.slide.code!
          : widget.slide.content;

  @override
  Widget build(BuildContext context) {
    final html = CodeRunnerHtml.build(
      language: _language,
      code: _code,
      packages: widget.slide.packages ?? const [],
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.slide.title.trim().isNotEmpty ||
            widget.slide.content.trim().isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.slide.title.trim().isNotEmpty)
                  Text(
                    widget.slide.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: context.colors.textPrimary,
                    ),
                  ),
                if (widget.slide.content.trim().isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: MathMarkdown(data: widget.slide.content),
                  ),
              ],
            ),
          ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: PlatformWebView(html: html),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          child: DuoButton(
            text: 'CONTINUE',
            color: AppTheme.duoGreen,
            shadowColor: AppTheme.duoGreenDark,
            onPressed: widget.onComplete,
          ),
        ),
      ],
    );
  }
}

/// Builds the self-contained HTML playground for a [CodeRunnerView], picking a
/// runtime by language. Kept separate so it's unit-testable without a WebView.
class CodeRunnerHtml {
  static const String pyodideVersion = 'v0.26.2';

  static String build({
    required String language,
    required String code,
    required List<String> packages,
  }) {
    switch (language) {
      case 'python':
        return _python(code, packages);
      case 'html':
      case 'css':
      case 'javascript':
      case 'js':
        return _web(language, code);
      case 'latex':
        return _latex(code);
      default:
        return _unsupported(language, code);
    }
  }

  /// Shared dark editor chrome + a JSON-injected starter program.
  static String _shell(String bodyHtml, String scriptJs, String code) {
    final codeJson = jsonEncode(code);
    return '''
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<style>
  :root { color-scheme: dark; }
  * { box-sizing: border-box; }
  html, body { margin:0; height:100%; background:#0d1117; color:#e6edf3;
    font-family: -apple-system, system-ui, sans-serif; }
  #wrap { display:flex; flex-direction:column; height:100%; }
  .bar { display:flex; align-items:center; gap:8px; padding:8px 10px;
    background:#161b22; border-bottom:1px solid #21262d; }
  .bar .lang { font-size:11px; font-weight:800; letter-spacing:1px; color:#8b949e; }
  .bar .status { font-size:11px; color:#8b949e; margin-left:auto; }
  button.run { background:#238636; color:#fff; border:none; border-radius:8px;
    padding:8px 16px; font-weight:800; font-size:13px; }
  button.run:disabled { opacity:.5; }
  textarea { flex: 1 1 45%; width:100%; border:none; resize:none; outline:none;
    background:#0d1117; color:#e6edf3; padding:12px;
    font-family: ui-monospace, Menlo, Consolas, monospace; font-size:13px; line-height:1.55; }
  .out { flex: 1 1 40%; overflow:auto; padding:12px; background:#010409;
    border-top:1px solid #21262d; font-family: ui-monospace, monospace;
    font-size:12.5px; white-space:pre-wrap; color:#c9d1d9; }
  .out img { max-width:100%; border-radius:8px; margin-top:8px; }
  iframe { flex:1; width:100%; border:none; background:#fff; }
</style>
$scriptJs
</head>
<body>
<div id="wrap">
$bodyHtml
</div>
<script>
  window.__STARTER__ = $codeJson;
  document.addEventListener('DOMContentLoaded', function(){
    if (window.__initRunner) window.__initRunner();
  });
</script>
</body>
</html>
''';
  }

  static String _python(String code, List<String> packages) {
    final pkgsJson = jsonEncode(packages);
    final body = '''
<div class="bar">
  <span class="lang">PYTHON</span>
  <span class="status" id="status">Loading Python…</span>
  <button class="run" id="run" disabled>Run ▶</button>
</div>
<textarea id="editor" spellcheck="false"></textarea>
<div class="out" id="out"></div>
''';
    final script = '''
<script>
const PACKAGES = $pkgsJson;
const PYODIDE_URL = 'https://cdn.jsdelivr.net/pyodide/$pyodideVersion/full/pyodide.js';
let pyodide = null;
function \$(id){ return document.getElementById(id); }
function loadScript(src){
  return new Promise(function(resolve, reject){
    var s = document.createElement('script');
    s.src = src; s.async = true;
    s.onload = function(){ resolve(); };
    s.onerror = function(){ reject(new Error('Failed to load ' + src)); };
    document.head.appendChild(s);
  });
}
window.__initRunner = async function(){
  \$('editor').value = window.__STARTER__ || '';
  \$('run').onclick = runCode;
  try {
    // Load Pyodide dynamically and wait for it — a plain <script src> in the
    // head isn't reliably ready in loadHtmlString webviews (loadPyodide would
    // be undefined → "loadPyodide is not a function").
    if (typeof loadPyodide !== 'function') { await loadScript(PYODIDE_URL); }
    pyodide = await loadPyodide({
      indexURL: 'https://cdn.jsdelivr.net/pyodide/$pyodideVersion/full/'
    });
    if (PACKAGES.length) await pyodide.loadPackage(PACKAGES);
    await pyodide.runPythonAsync(`
import sys, io, base64
from io import BytesIO
try:
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt
    def _capture_plot():
        if plt.get_fignums():
            buf = BytesIO(); plt.savefig(buf, format='png', bbox_inches='tight')
            buf.seek(0); data = base64.b64encode(buf.read()).decode('ascii')
            plt.close('all'); return data
        return ''
except Exception:
    def _capture_plot(): return ''
`);
    \$('status').textContent = 'Ready';
    \$('run').disabled = false;
  } catch (e) {
    \$('status').textContent = 'Load failed';
    \$('out').textContent = 'Could not start Python runtime.\\n' + e;
  }
};
async function runCode(){
  if (!pyodide) return;
  \$('run').disabled = true; \$('status').textContent = 'Running…';
  \$('out').innerHTML = '';
  try {
    pyodide.runPython("import sys, io\\nsys.stdout = io.StringIO()\\nsys.stderr = sys.stdout");
    await pyodide.runPythonAsync(\$('editor').value);
    const text = pyodide.runPython("sys.stdout.getvalue()");
    const png = pyodide.runPython("_capture_plot()");
    \$('out').textContent = text || 'Done — no output.';
    if (png) { const img = document.createElement('img'); img.src = 'data:image/png;base64,' + png; \$('out').appendChild(img); }
  } catch (e) {
    \$('out').textContent = String(e);
  } finally {
    \$('run').disabled = false; \$('status').textContent = 'Ready';
  }
}
</script>
''';
    return _shell(body, script, code);
  }

  /// HTML/CSS/JS: render the snippet live in a sandboxed iframe.
  static String _web(String language, String code) {
    // Wrap CSS/JS-only snippets so they still produce a visible page.
    final body = '''
<div class="bar">
  <span class="lang">${language.toUpperCase()}</span>
  <span class="status">Live preview</span>
  <button class="run" id="run">Run ▶</button>
</div>
<textarea id="editor" spellcheck="false"></textarea>
<iframe id="frame" sandbox="allow-scripts"></iframe>
''';
    final wrapPre = language == 'css'
        ? '<style>'
        : (language == 'javascript' || language == 'js')
            ? '<body><script>'
            : '';
    final wrapPost = language == 'css'
        ? '</style><div class="demo">CSS applied to this box.</div>'
        : (language == 'javascript' || language == 'js')
            ? '<\\/script></body>'
            : '';
    final script = '''
<script>
function \$(id){ return document.getElementById(id); }
window.__initRunner = function(){
  \$('editor').value = window.__STARTER__ || '';
  \$('run').onclick = render;
  render();
};
function render(){
  const doc = ${jsonEncode(wrapPre)} + \$('editor').value + ${jsonEncode(wrapPost)};
  \$('frame').srcdoc = doc;
}
</script>
''';
    return _shell(body, script, code);
  }

  /// LaTeX: typeset with LaTeX.js from CDN.
  static String _latex(String code) {
    final body = '''
<div class="bar"><span class="lang">LATEX</span>
  <span class="status">Preview</span>
  <button class="run" id="run">Render ▶</button></div>
<textarea id="editor" spellcheck="false"></textarea>
<div class="out" id="out" style="background:#fff;color:#111;padding:16px;"></div>
''';
    final script = '''
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex/dist/katex.min.css">
<script src="https://cdn.jsdelivr.net/npm/katex/dist/katex.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/latex.js/dist/latex.min.js"></script>
<script>
function \$(id){ return document.getElementById(id); }
window.__initRunner = function(){
  \$('editor').value = window.__STARTER__ || '';
  \$('run').onclick = render; render();
};
function render(){
  try {
    const gen = latexjs.parse(\$('editor').value, { generator: new latexjs.HtmlGenerator({ hyphenate:false }) });
    \$('out').innerHTML = '';
    \$('out').appendChild(gen.domFragment());
    
    // Inject LaTeX.js document styling (Computer Modern font, layout, etc.) dynamically
    const oldStyles = document.getElementById('latex-styles');
    if (oldStyles) { oldStyles.remove(); }
    const container = document.createElement('div');
    container.id = 'latex-styles';
    container.appendChild(gen.stylesAndScripts("https://cdn.jsdelivr.net/npm/latex.js/dist/"));
    document.head.appendChild(container);
  } catch (e) { \$('out').textContent = String(e); }
}
</script>
''';
    return _shell(body, script, code);
  }

  /// Languages we can't run on-device yet: show the code read-only with a note.
  static String _unsupported(String language, String code) {
    final body = '''
<div class="bar"><span class="lang">${language.toUpperCase()}</span>
  <span class="status">Read-only</span></div>
<textarea id="editor" spellcheck="false" readonly></textarea>
<div class="out">On-device execution for ${language.toUpperCase()} is coming soon. Read and edit the code above.</div>
''';
    const script = '''
<script>
window.__initRunner = function(){
  document.getElementById('editor').value = window.__STARTER__ || '';
};
</script>
''';
    return _shell(body, script, code);
  }
}
