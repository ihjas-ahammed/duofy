import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../models/app_models.dart';
import '../../services/python_runner_service.dart';
import '../../theme/app_theme.dart';
import '../code_highlighter.dart';
import '../math_markdown.dart';
import '../platform_webview.dart';

/// Python Code Sandbox & Interactive Runner View matching docs/new-theme/slide-p/python-run.html
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
  late CodeEditingController _controller;
  late TextEditingController _inputsController;
  late TextEditingController _realtimeInputController;

  PythonExecutionResult? _result;
  bool _isRunning = false;
  bool _showInputsField = false;
  bool _awaitingRealtimeInput = false;
  String _currentInputPrompt = '';
  Completer<String>? _activeInputCompleter;

  String get _language => (widget.slide.language ?? 'python').toLowerCase();
  String get _initialCode =>
      (widget.slide.code?.trim().isNotEmpty ?? false)
          ? widget.slide.code!
          : widget.slide.content;

  static const List<String> _accessoryKeys = [
    'Tab',
    ':',
    '()',
    '[]',
    '""',
    '=',
    '@',
    'def',
  ];

  @override
  void initState() {
    super.initState();
    _controller = CodeEditingController(text: _initialCode, language: _language);
    _inputsController = TextEditingController();
    _realtimeInputController = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _inputsController.dispose();
    _realtimeInputController.dispose();
    super.dispose();
  }

  void _insertKey(String key) {
    HapticFeedback.selectionClick();
    final text = _controller.text;
    final selection = _controller.selection;

    String insertion = key;
    if (key == 'Tab') insertion = '    ';

    if (selection.isValid && selection.start >= 0) {
      final newText = text.replaceRange(selection.start, selection.end, insertion);
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: selection.start + insertion.length,
        ),
      );
    } else {
      _controller.text += insertion;
    }
  }

  void _submitRealtimeInput() {
    final val = _realtimeInputController.text;
    _activeInputCompleter?.complete(val);
    setState(() {
      _awaitingRealtimeInput = false;
      _currentInputPrompt = '';
      _activeInputCompleter = null;
    });
  }

  Future<void> _runCode() async {
    if (_isRunning) return;
    HapticFeedback.mediumImpact();

    setState(() {
      _isRunning = true;
      _result = null;
      _awaitingRealtimeInput = false;
    });

    final rawInputs = _inputsController.text;
    final List<String> inputsList = rawInputs.isNotEmpty
        ? rawInputs.split(RegExp(r'\r?\n')).toList()
        : const [];

    final res = await PythonRunnerService.instance.runCode(
      _controller.text,
      inputs: inputsList,
      onInputRequest: (prompt) async {
        if (!mounted) return '';
        final completer = Completer<String>();
        setState(() {
          _awaitingRealtimeInput = true;
          _currentInputPrompt = prompt;
          _realtimeInputController.clear();
          _activeInputCompleter = completer;
        });
        return await completer.future;
      },
    );

    if (mounted) {
      setState(() {
        _isRunning = false;
        _awaitingRealtimeInput = false;
        _result = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    if (_language != 'python') {
      final html = CodeRunnerHtml.build(
        language: _language,
        code: _initialCode,
        packages: widget.slide.packages ?? const [],
      );
      return _buildWebViewLayout(context, html);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Header Information (if title or content is non-code)
          if (widget.slide.title.trim().isNotEmpty ||
              (widget.slide.content.trim().isNotEmpty &&
                  widget.slide.content != _initialCode))
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 2, right: 2),
              child: Container(
                decoration: BoxDecoration(
                  color: colors.cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.cardBorder),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.slide.title.trim().isNotEmpty)
                      MathMarkdown(
                        data: widget.slide.title,
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: colors.textMain,
                        ),
                      ),
                    if (widget.slide.content.trim().isNotEmpty &&
                        widget.slide.content != _initialCode)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: MathMarkdown(
                          data: widget.slide.content,
                          textStyle: TextStyle(
                            fontSize: 12,
                            color: colors.textMuted,
                            height: 1.3,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

          // 2. Editor & Terminal Workspace
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Code Editor Card
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A1120),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: _isRunning
                                ? colors.accentGreen
                                : colors.cardBorder,
                            width: _isRunning ? 1.8 : 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.35),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Tab Header
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: const BoxDecoration(
                                color: Color(0xFF0E172A),
                                border: Border(
                                  bottom: BorderSide(color: Color(0xFF1E293B)),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 7,
                                    height: 7,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colors.accentGreen,
                                      boxShadow: [
                                        BoxShadow(
                                          color: colors.accentGreen
                                              .withValues(alpha: 0.8),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'main.py',
                                    style: TextStyle(
                                      color: Color(0xFFF8FAFC),
                                      fontFamily: 'monospace',
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _showInputsField = !_showInputsField;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _showInputsField
                                            ? colors.primaryBlueLight
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            LucideIcons.terminal,
                                            size: 13,
                                            color: _showInputsField
                                                ? colors.primaryBlue
                                                : const Color(0xFF94A3B8),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'STDIN',
                                            style: TextStyle(
                                              fontSize: 9.5,
                                              fontWeight: FontWeight.w800,
                                              color: _showInputsField
                                                  ? colors.primaryBlue
                                                  : const Color(0xFF94A3B8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Multi-line code editor TextField
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextField(
                                controller: _controller,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                autocorrect: false,
                                enableSuggestions: false,
                                style: const TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 13,
                                  height: 1.5,
                                  color: Color(0xFFF8FAFC),
                                ),
                                decoration: const InputDecoration(
                                  filled: false,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                            // Optional Standard Input Field
                            if (_showInputsField)
                              Container(
                                margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF060B16),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'INPUT STREAM (one line per input())',
                                      style: TextStyle(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF38BDF8),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    TextField(
                                      controller: _inputsController,
                                      maxLines: 2,
                                      minLines: 1,
                                      style: const TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 12,
                                        color: Color(0xFF38BDF8),
                                      ),
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        hintText: 'Feed inputs here...',
                                        hintStyle: TextStyle(
                                          color: Color(0xFF475569),
                                          fontSize: 11,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      // 3. Accessory Keys Quick Row
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: _accessoryKeys.map((k) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: GestureDetector(
                                onTap: () => _insertKey(k),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 11,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colors.cardBg,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: colors.cardBorder,
                                    ),
                                  ),
                                  child: Text(
                                    k,
                                    style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: colors.textMain,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // 4. Real-time Interactive Input Prompt
                      if (_awaitingRealtimeInput) ...[
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: colors.cardBg,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: colors.accentGreen,
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 12,
                                    height: 12,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: colors.accentGreen,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _currentInputPrompt.isNotEmpty
                                        ? _currentInputPrompt
                                        : 'Input required:',
                                    style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: colors.accentGreen,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _realtimeInputController,
                                      autofocus: true,
                                      style: TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 12.5,
                                        color: colors.textMain,
                                      ),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: 'Type input and press Enter...',
                                        hintStyle: TextStyle(
                                          color: colors.textSubtle,
                                          fontSize: 11.5,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 6,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: colors.cardBorder,
                                          ),
                                        ),
                                      ),
                                      onSubmitted: (_) =>
                                          _submitRealtimeInput(),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  IconButton(
                                    icon: Icon(
                                      LucideIcons.send,
                                      color: colors.accentGreen,
                                      size: 18,
                                    ),
                                    tooltip: 'Submit',
                                    onPressed: _submitRealtimeInput,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],

                      // 5. Output Console Pane
                      if (_result != null) _buildResultPane(context, _result!),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 6. Bottom Run CTA Button
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _isRunning ? null : _runCode,
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colors.accentGreen,
                            const Color(0xFF059669),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: colors.accentGreen.withValues(alpha: 0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_isRunning)
                            const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          else
                            const Icon(
                              LucideIcons.play,
                              color: Colors.white,
                              size: 16,
                            ),
                          const SizedBox(width: 8),
                          Text(
                            _isRunning ? 'EXECUTING...' : 'RUN PYTHON SCRIPT',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: widget.onComplete,
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: colors.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: colors.cardBorder),
                    ),
                    child: Center(
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(
                          color: colors.textMain,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultPane(BuildContext context, PythonExecutionResult res) {
    final colors = context.colors;
    final hasStdout = res.stdout.trim().isNotEmpty;
    final hasStderr = res.stderr.trim().isNotEmpty;
    final hasGraphics = res.graphicsBase64.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A1120),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: res.exitCode == 0 ? colors.accentGreen : AppTheme.duoRed,
          width: 1.2,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                res.exitCode == 0
                    ? LucideIcons.checkCircle
                    : LucideIcons.alertTriangle,
                size: 14,
                color: res.exitCode == 0 ? colors.accentGreen : AppTheme.duoRed,
              ),
              const SizedBox(width: 6),
              Text(
                'Output (${res.duration.inMilliseconds}ms)',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color:
                      res.exitCode == 0 ? colors.accentGreen : AppTheme.duoRed,
                ),
              ),
            ],
          ),
          if (hasStdout) ...[
            const SizedBox(height: 6),
            SelectableText(
              res.stdout,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFFF8FAFC),
              ),
            ),
          ],
          if (hasStderr) ...[
            const SizedBox(height: 6),
            SelectableText(
              res.stderr,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFFF87171),
              ),
            ),
          ],
          if (hasGraphics) ...[
            const SizedBox(height: 8),
            for (final base64Img in res.graphicsBase64)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    base64Decode(base64Img),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildWebViewLayout(BuildContext context, String html) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.slide.title.trim().isNotEmpty ||
              widget.slide.content.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: colors.cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.cardBorder),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.slide.title.trim().isNotEmpty)
                      MathMarkdown(
                        data: widget.slide.title,
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: colors.textMain,
                        ),
                      ),
                    if (widget.slide.content.trim().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: MathMarkdown(data: widget.slide.content),
                      ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: PlatformWebView(html: html),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: GestureDetector(
              onTap: widget.onComplete,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: colors.accentGreen,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    'CONTINUE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Builds the self-contained HTML playground for a [CodeRunnerView], picking a
/// runtime by language.
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
window.onerror = function(message, source, lineno, colno, error) {
  var errLog = 'Script error: ' + message;
  if (source) errLog += ' at ' + source.split('/').last();
  if (lineno) errLog += ':' + lineno;
  if (error && error.stack) errLog += '\\nStack: ' + error.stack;
  console.error(errLog);
  var outEl = document.getElementById('out');
  if (outEl) {
    outEl.innerText = (outEl.innerText || '') + '\\n' + errLog;
  }
};

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
    if (typeof WebAssembly === 'undefined') {
      throw new Error("WebAssembly is not supported or enabled in this browser/WebView.");
    }

    let getLoadPyodide = function() {
      if (typeof window.loadPyodide === 'function') return window.loadPyodide;
      if (typeof globalThis !== 'undefined' && typeof globalThis.loadPyodide === 'function') return globalThis.loadPyodide;
      if (typeof self !== 'undefined' && typeof self.loadPyodide === 'function') return self.loadPyodide;
      if (typeof loadPyodide === 'function') return loadPyodide;
      return null;
    };
    let loader = getLoadPyodide();
    if (!loader) { await loadScript(PYODIDE_URL); }
    let retries = 0;
    loader = getLoadPyodide();
    while (!loader && retries < 100) {
      await new Promise(function(resolve){ setTimeout(resolve, 50); });
      loader = getLoadPyodide();
      retries++;
    }
    if (!loader) {
      throw new Error("loadPyodide is not registered on window or global scope.");
    }
    pyodide = await loader({
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

  static String _web(String language, String code) {
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
<script src="https://cdn.jsdelivr.net/npm/katex/dist/contrib/auto-render.min.js"></script>
<script>
function \$(id){ return document.getElementById(id); }
window.__initRunner = function(){
  \$('editor').value = window.__STARTER__ || '';
  \$('run').onclick = render; render();
};
function render(){
  try {
    const raw = \$('editor').value;
    let html = raw.replace(/\\\\section\\*?\\{([^}]+)\\}/g, '<h2 style="font-size:18px;margin:12px 0;">\$1</h2>')
                  .replace(/\\\\subsection\\*?\\{([^}]+)\\}/g, '<h3 style="font-size:15px;margin:10px 0;">\$1</h3>')
                  .replace(/\\\\textbf\\{([^}]+)\\}/g, '<b>\$1</b>')
                  .replace(/\\\\textit\\{([^}]+)\\}/g, '<i>\$1</i>');
    \$('out').innerHTML = html;
    if (window.renderMathInElement) {
      renderMathInElement(\$('out'));
    }
  } catch (e) { \$('out').textContent = String(e); }
}
</script>
''';
    return _shell(body, script, code);
  }

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