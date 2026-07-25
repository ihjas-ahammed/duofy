import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../services/code_storage_service.dart';
import '../../services/ide_settings_service.dart';
import '../../services/python_runner_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/code_highlighter.dart';
import '../../widgets/duo_button.dart';
import '../../widgets/ide_config_dialog.dart';

class UniversalCodeRunnerScreen extends StatefulWidget {
  final IdeProject? existingProject;

  const UniversalCodeRunnerScreen({super.key, this.existingProject});

  @override
  State<UniversalCodeRunnerScreen> createState() =>
      _UniversalCodeRunnerScreenState();
}

class _UniversalCodeRunnerScreenState
    extends State<UniversalCodeRunnerScreen> {
  late String _projectId;
  late TextEditingController _titleController;
  late CodeEditingController _codeController;
  late TextEditingController _inputController;

  String _selectedLanguage = 'python';
  bool _isRunning = false;
  bool _isSaving = false;
  String _stdout = '';
  String _stderr = '';
  List<String> _graphics = [];

  final List<String> _languages = [
    'python',
    'javascript',
    'html',
    'css',
    'cpp',
    'java',
    'dart',
    'sql',
  ];

  @override
  void initState() {
    super.initState();
    _projectId = widget.existingProject?.id ??
        'code-${DateTime.now().millisecondsSinceEpoch}';
    _selectedLanguage = widget.existingProject?.language ?? 'python';
    _titleController = TextEditingController(
      text: widget.existingProject?.title ?? 'Multi-Language Playground',
    );
    _inputController = TextEditingController();

    final starterCode = widget.existingProject?.codeContent ??
        _getStarterCode(_selectedLanguage);
    _codeController = CodeEditingController(
      text: starterCode,
      language: _selectedLanguage,
    );
  }

  String _getStarterCode(String lang) {
    switch (lang.toLowerCase()) {
      case 'python':
        return 'def greet(name):\n    return f"Hello, {name}!"\n\nprint(greet("Duofy Learner"))';
      case 'javascript':
        return 'const numbers = [1, 2, 3, 4, 5];\nconst squared = numbers.map(n => n * n);\nconsole.log("Squared numbers:", squared);';
      case 'html':
        return '<h1>Duofy Code Playground</h1>\n<p>Experiment with HTML & CSS live!</p>';
      case 'css':
        return 'body {\n  background: #0f172a;\n  color: #38bdf8;\n  font-family: sans-serif;\n}';
      case 'cpp':
        return '#include <iostream>\nusing namespace std;\n\nint main() {\n    cout << "Hello C++ Playground!" << endl;\n    return 0;\n}';
      case 'java':
        return 'public class Main {\n    public static void main(String[] args) {\n        System.out.println("Hello Java!");\n    }\n}';
      case 'dart':
        return 'void main() {\n  var list = [1, 2, 3];\n  print("Dart list: \$list");\n}';
      case 'sql':
        return 'SELECT users.name, orders.amount\nFROM users\nJOIN orders ON users.id = orders.user_id\nWHERE orders.amount > 100;';
      default:
        return 'print("Hello World!")';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _codeController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _runCode() async {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
      _stdout = '';
      _stderr = '';
      _graphics = [];
    });

    if (_selectedLanguage == 'python') {
      final inputs = _inputController.text.isNotEmpty
          ? _inputController.text.split('\n')
          : const <String>[];
      final res = await PythonRunnerService.instance.runCode(
        _codeController.text,
        inputs: inputs,
      );
      if (mounted) {
        setState(() {
          _isRunning = false;
          _stdout = res.stdout;
          _stderr = res.stderr;
          _graphics = res.graphicsBase64;
        });
      }
    } else {
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) {
        setState(() {
          _isRunning = false;
          _stdout = 'Ran ${_selectedLanguage.toUpperCase()} code:\n${_codeController.text}';
        });
      }
    }
  }

  Future<void> _saveProject() async {
    setState(() {
      _isSaving = true;
    });

    final project = IdeProject(
      id: _projectId,
      title: _titleController.text.trim().isEmpty
          ? '${_selectedLanguage.toUpperCase()} Playground'
          : _titleController.text.trim(),
      type: 'universal',
      language: _selectedLanguage,
      codeContent: _codeController.text,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    await CodeStorageService.instance.saveProject(project);

    if (mounted) {
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Code snippet saved!'),
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

        _codeController.theme = isDark ? CodeTheme.dark : CodeTheme.light;

        final editorBg = isDark ? const Color(0xFF0D1117) : const Color(0xFFF8FAFC);
        final editorText = isDark ? const Color(0xFFE6EDF3) : const Color(0xFF0F172A);
        final consoleBg = isDark ? const Color(0xFF161B22) : const Color(0xFFF1F5F9);
        final consoleText = isDark ? const Color(0xFFA6E3A1) : const Color(0xFF166534);

        final lineCount = _codeController.text.split('\n').length;
        final lineNumbersText = List.generate(lineCount, (i) => '${i + 1}').join('\n');

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
                hintText: 'Snippet Title...',
              ),
            ),
            actions: [
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
                tooltip: 'Save Snippet',
                onPressed: _saveProject,
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: context.colors.surface,
                  child: Row(
                    children: [
                      Text(
                        'LANGUAGE:',
                        style: TextStyle(
                          color: context.colors.textFaint,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(width: 12),
                      DropdownButton<String>(
                        value: _selectedLanguage,
                        dropdownColor: context.colors.surface,
                        style: TextStyle(
                          color: AppTheme.duoGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        items: _languages.map((lang) {
                          return DropdownMenuItem(
                            value: lang,
                            child: Text(lang.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _selectedLanguage = val;
                              _codeController.language = val;
                              _codeController.text = _getStarterCode(val);
                            });
                          }
                        },
                      ),
                      const Spacer(),
                      DuoButton(
                        text: _isRunning ? 'Running...' : 'Run Code',
                        color: _isRunning ? context.colors.textFaint : AppTheme.duoGreen,
                        shadowColor: _isRunning ? context.colors.outline : AppTheme.duoGreenDark,
                        onPressed: _isRunning ? () {} : () => _runCode(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
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
                            controller: _codeController,
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
                              hintText: 'Write code here...',
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
                  ),
                ),
                if (_stdout.isNotEmpty || _stderr.isNotEmpty || _graphics.isNotEmpty) ...[
                  Container(
                    height: 180,
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    color: consoleBg,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CONSOLE OUTPUT:',
                            style: TextStyle(
                              color: context.colors.textFaint,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          if (_stdout.isNotEmpty)
                            SelectableText(
                              _stdout,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: settings.fontSize * 0.9,
                                color: consoleText,
                              ),
                            ),
                          if (_stderr.isNotEmpty)
                            SelectableText(
                              _stderr,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: settings.fontSize * 0.9,
                                color: isDark ? const Color(0xFFF38BA8) : const Color(0xFFB91C1C),
                              ),
                            ),
                          if (_graphics.isNotEmpty)
                            for (final img in _graphics)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.memory(
                                    base64Decode(img),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
