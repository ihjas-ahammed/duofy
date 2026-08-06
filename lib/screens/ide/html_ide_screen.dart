import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../services/code_storage_service.dart';
import '../../services/ide_settings_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/code_highlighter.dart';
import '../../widgets/ide_config_dialog.dart';
import '../../widgets/platform_webview.dart';

class HtmlIdeScreen extends StatefulWidget {
  final IdeProject? existingProject;

  const HtmlIdeScreen({super.key, this.existingProject});

  @override
  State<HtmlIdeScreen> createState() => _HtmlIdeScreenState();
}

class _HtmlIdeScreenState extends State<HtmlIdeScreen>
    with SingleTickerProviderStateMixin {
  late String _projectId;
  late TextEditingController _titleController;
  late CodeEditingController _htmlController;
  late CodeEditingController _cssController;
  late CodeEditingController _jsController;
  late TabController _tabController;

  bool _showPreview = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _projectId = widget.existingProject?.id ??
        'html-${DateTime.now().millisecondsSinceEpoch}';
    _titleController = TextEditingController(
      text: widget.existingProject?.title ?? 'HTML/CSS Studio',
    );

    final existingCode = widget.existingProject?.codeContent ?? '';
    _htmlController = CodeEditingController(
      text: existingCode.isNotEmpty
          ? existingCode
          : '''<div class="card">
  <h1>Interactive Web Canvas</h1>
  <p>Modify HTML, CSS, and JS to see live changes instantly!</p>
  <button onclick="changeColor()">Click Me!</button>
</div>''',
      language: 'html',
    );

    _cssController = CodeEditingController(
      text: '''body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background: #0f172a;
  color: #f8fafc;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  margin: 0;
}
.card {
  background: #1e293b;
  padding: 30px;
  border-radius: 20px;
  box-shadow: 0 10px 25px rgba(0,0,0,0.5);
  text-align: center;
  border: 1px solid #334155;
}
h1 { color: #38bdf8; font-size: 22px; }
button {
  background: #38bdf8;
  color: #0f172a;
  border: none;
  padding: 12px 24px;
  border-radius: 12px;
  font-weight: bold;
  cursor: pointer;
  margin-top: 15px;
}''',
      language: 'css',
    );

    _jsController = CodeEditingController(
      text: '''function changeColor() {
  const card = document.querySelector('.card');
  const colors = ['#1e293b', '#312e81', '#064e3b', '#701a75'];
  const randomColor = colors[Math.floor(Math.random() * colors.length)];
  card.style.backgroundColor = randomColor;
}''',
      language: 'javascript',
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _titleController.dispose();
    _htmlController.dispose();
    _cssController.dispose();
    _jsController.dispose();
    super.dispose();
  }

  String get _fullHtml {
    return '''<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
${_cssController.text}
  </style>
</head>
<body>
${_htmlController.text}
  <script>
${_jsController.text}
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
          ? 'HTML Studio'
          : _titleController.text.trim(),
      type: 'html_ide',
      language: 'html',
      codeContent: _htmlController.text,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    await CodeStorageService.instance.saveProject(project);

    if (mounted) {
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('HTML Project saved!'),
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

        _htmlController.theme = isDark ? CodeTheme.dark : CodeTheme.light;
        _cssController.theme = isDark ? CodeTheme.dark : CodeTheme.light;
        _jsController.theme = isDark ? CodeTheme.dark : CodeTheme.light;

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
                hintText: 'HTML Project Title...',
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  _showPreview ? LucideIcons.eyeOff : LucideIcons.eye,
                  color: AppTheme.duoBlue,
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
                tooltip: 'Save Project',
                onPressed: _saveProject,
              ),
            ],
          ),
          body: SafeArea(
            child: isDesktopOrWide
                ? Row(
                    children: [
                      Expanded(child: _buildEditorView(isDark, settings)),
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
                        child: _buildEditorView(isDark, settings),
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
        );
      },
    );
  }

  Widget _buildEditorView(bool isDark, IdeSettings settings) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.duoBlue,
          labelColor: AppTheme.duoBlue,
          unselectedLabelColor: context.colors.textFaint,
          tabs: const [
            Tab(text: 'HTML'),
            Tab(text: 'CSS'),
            Tab(text: 'JS'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildCodeInput(_htmlController, 'HTML Code...', isDark, settings),
              _buildCodeInput(_cssController, 'CSS Code...', isDark, settings),
              _buildCodeInput(_jsController, 'JavaScript Code...', isDark, settings),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCodeInput(
    CodeEditingController controller,
    String hint,
    bool isDark,
    IdeSettings settings,
  ) {
    final editorBg = isDark ? const Color(0xFF0D1117) : const Color(0xFFF8FAFC);
    final editorText = isDark ? const Color(0xFFE6EDF3) : const Color(0xFF0F172A);

    final lineCount = controller.text.split('\n').length;
    final lineNumbersText = List.generate(lineCount, (i) => '${i + 1}').join('\n');

    final strut = StrutStyle(
      fontFamily: 'monospace',
      fontSize: settings.fontSize,
      height: 1.4,
      forceStrutHeight: true,
    );

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
                strutStyle: strut,
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
              controller: controller,
              maxLines: settings.wordWrap ? null : 1,
              expands: settings.wordWrap,
              strutStyle: strut,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: settings.fontSize,
                color: editorText,
                height: 1.4,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
                hintText: hint,
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
                Icon(LucideIcons.globe, size: 14, color: AppTheme.duoGreen),
                const SizedBox(width: 6),
                Text(
                  'LIVE CANVAS PREVIEW',
                  style: TextStyle(
                    color: AppTheme.duoGreen,
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
              html: _fullHtml,
            ),
          ),
        ],
      ),
    );
  }
}
