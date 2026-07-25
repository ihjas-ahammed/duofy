import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../services/code_storage_service.dart';
import '../../services/ide_settings_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/code_highlighter.dart';
import '../../widgets/ide_config_dialog.dart';
import '../../widgets/platform_webview.dart';

class LatexIdeScreen extends StatefulWidget {
  final IdeProject? existingProject;

  const LatexIdeScreen({super.key, this.existingProject});

  @override
  State<LatexIdeScreen> createState() => _LatexIdeScreenState();
}

class _LatexIdeScreenState extends State<LatexIdeScreen> {
  late String _projectId;
  late TextEditingController _titleController;
  late CodeEditingController _texController;
  bool _showPreview = true;
  bool _isSaving = false;

  final List<Map<String, String>> _mathSymbols = [
    {'label': 'Fraction', 'snippet': r'\frac{a}{b}'},
    {'label': 'Exponent', 'snippet': r'x^{2}'},
    {'label': 'Subscript', 'snippet': r'x_{i}'},
    {'label': 'Square Root', 'snippet': r'\sqrt{x}'},
    {'label': 'Integral', 'snippet': r'\int_{0}^{\infty} f(x) dx'},
    {'label': 'Summation', 'snippet': r'\sum_{n=1}^{\infty} a_n'},
    {'label': 'Limit', 'snippet': r'\lim_{x \to 0}'},
    {'label': 'Matrix', 'snippet': "\\begin{matrix}\n a & b \\\\\n c & d\n\\end{matrix}"},
    {'label': 'Alpha', 'snippet': r'\alpha'},
    {'label': 'Beta', 'snippet': r'\beta'},
    {'label': 'Theta', 'snippet': r'\theta'},
    {'label': 'Pi', 'snippet': r'\pi'},
    {'label': 'Infinity', 'snippet': r'\infty'},
  ];

  @override
  void initState() {
    super.initState();
    _projectId = widget.existingProject?.id ??
        'tex-${DateTime.now().millisecondsSinceEpoch}';
    _titleController = TextEditingController(
      text: widget.existingProject?.title ?? 'LaTeX Studio',
    );

    final existingCode = widget.existingProject?.codeContent ?? '';
    _texController = CodeEditingController(
      text: existingCode.isNotEmpty
          ? existingCode
          : r'''\documentclass{article}
\begin{document}

\title{LaTeX Document Studio}
\author{Duofy Learner}
\maketitle

\section{Introduction}
Welcome to the in-built LaTeX IDE! Write mathematical formulas and formal documents live.

\section{Mathematics}
Here is the famous Euler's identity:
\[ e^{i\pi} + 1 = 0 \]

And the quadratic formula:
\[ x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a} \]

\section{Matrices}
\[
\begin{matrix}
 1 & 0 & 0 \\
 0 & 1 & 0 \\
 0 & 0 & 1
\end{matrix}
\]

\end{document}''',
      language: 'latex',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _texController.dispose();
    super.dispose();
  }

  void _insertSnippet(String snippet) {
    final text = _texController.text;
    final selection = _texController.selection;
    final start = selection.start >= 0 ? selection.start : text.length;
    final end = selection.end >= 0 ? selection.end : text.length;
    final newText = text.replaceRange(start, end, snippet);
    _texController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: start + snippet.length),
    );
    setState(() {});
  }

  String get _htmlLatexPreview {
    return '''<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <script src="https://cdn.jsdelivr.net/npm/latex.js/dist/latex.min.js"></script>
  <style>
    body { background: #0f172a; color: #f8fafc; padding: 20px; font-family: sans-serif; }
    #output { background: #1e293b; padding: 25px; border-radius: 16px; border: 1px solid #334155; }
  </style>
</head>
<body>
  <div id="output">Rendering LaTeX...</div>
  <script>
    try {
      const code = ${jsonEncode(_texController.text)};
      const generator = new latexjs.HtmlGenerator({ hyphenate: false });
      const doc = latexjs.parse(code, { generator: generator });
      document.getElementById('output').innerHTML = '';
      document.getElementById('output').appendChild(doc.domFragment());
    } catch(e) {
      document.getElementById('output').innerHTML = '<pre style="color:#f87171;">LaTeX Render Error:\\n' + e.message + '</pre>';
    }
  </script>
</body>
</html>''';
  }

  Future<void> _saveProject() async {
    setState(() {
      _isSaving = true;
    });

    final project = IdeProject(
      id: _projectId,
      title: _titleController.text.trim().isEmpty
          ? 'LaTeX Studio'
          : _titleController.text.trim(),
      type: 'latex_ide',
      language: 'latex',
      codeContent: _texController.text,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    await CodeStorageService.instance.saveProject(project);

    if (mounted) {
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('LaTeX Project saved!'),
          backgroundColor: AppTheme.duoGreen,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: IdeSettingsService.instance,
      builder: (context, _) {
        final settings = IdeSettingsService.instance.settings;
        final appIsDark = context.colors.isDark;
        final isDark = settings.forceDarkMode ?? appIsDark;

        final isDesktopOrWide = MediaQuery.of(context).size.width > 700;
        _texController.theme = isDark ? CodeTheme.dark : CodeTheme.light;

        return Scaffold(
          appBar: AppBar(
            title: TextField(
              controller: _titleController,
              style: TextStyle(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'LaTeX Project Title...',
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  _showPreview ? LucideIcons.eyeOff : LucideIcons.eye,
                  color: AppTheme.duoViolet,
                ),
                tooltip: _showPreview ? 'Hide Preview' : 'Show Preview',
                onPressed: () {
                  setState(() {
                    _showPreview = !_showPreview;
                  });
                },
              ),
              IconButton(
                icon: const Icon(LucideIcons.slidersHorizontal),
                tooltip: 'Editor Settings',
                onPressed: () => IdeConfigDialog.show(context),
              ),
              IconButton(
                icon: _isSaving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(LucideIcons.save),
                tooltip: 'Save Document',
                onPressed: _saveProject,
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Symbol Toolbar
                SizedBox(
                  height: 48,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    itemCount: _mathSymbols.length,
                    itemBuilder: (ctx, i) {
                      final sym = _mathSymbols[i];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ActionChip(
                          backgroundColor: context.colors.glassStrong,
                          side: BorderSide(color: context.colors.outline),
                          label: Text(
                            sym['label']!,
                            style: TextStyle(
                              color: AppTheme.duoViolet,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () => _insertSnippet(sym['snippet']!),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: isDesktopOrWide
                      ? Row(
                          children: [
                            Expanded(child: _buildCodeInput(isDark, settings)),
                            if (_showPreview) ...[
                              const VerticalDivider(width: 1),
                              Expanded(child: _buildPreviewView()),
                            ],
                          ],
                        )
                      : Column(
                          children: [
                            Expanded(
                              flex: _showPreview ? 1 : 2,
                              child: _buildCodeInput(isDark, settings),
                            ),
                            if (_showPreview) ...[
                              const Divider(height: 1),
                              Expanded(
                                flex: 1,
                                child: _buildPreviewView(),
                              ),
                            ],
                          ],
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCodeInput(bool isDark, IdeSettings settings) {
    final editorBg = isDark ? const Color(0xFF0D1117) : const Color(0xFFF8FAFC);
    final editorText = isDark ? const Color(0xFFE6EDF3) : const Color(0xFF0F172A);

    final lineCount = _texController.text.split('\n').length;
    final lineNumbersText = List.generate(lineCount, (i) => '${i + 1}').join('\n');

    return Container(
      color: editorBg,
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (settings.showLineNumbers) ...[
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                lineNumbersText,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: settings.fontSize,
                  color: isDark ? const Color(0xFF6E7781) : const Color(0xFF8C959F),
                  height: 1.4,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Container(
              width: 1,
              height: (lineCount * (settings.fontSize * 1.4)).clamp(24, 600),
              color: context.colors.outline.withValues(alpha: 0.5),
            ),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: TextField(
              controller: _texController,
              maxLines: settings.wordWrap ? null : 1,
              expands: settings.wordWrap,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: settings.fontSize,
                color: editorText,
                height: 1.4,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Type LaTeX code...',
                hintStyle: TextStyle(
                  color: isDark ? const Color(0xFF6E7781) : const Color(0xFF8C959F),
                ),
              ),
              onChanged: (_) {
                if (mounted) setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewView() {
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: context.colors.surface,
            child: Row(
              children: [
                Icon(LucideIcons.fileCode, size: 14, color: AppTheme.duoViolet),
                const SizedBox(width: 6),
                Text(
                  'LATEX PREVIEW CANVAS',
                  style: TextStyle(
                    color: AppTheme.duoViolet,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PlatformWebView(
              html: _htmlLatexPreview,
            ),
          ),
        ],
      ),
    );
  }
}
