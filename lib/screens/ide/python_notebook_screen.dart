import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../services/code_storage_service.dart';
import '../../services/ide_settings_service.dart';
import '../../services/python_runner_service.dart';
import '../../theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/code_highlighter.dart';
import '../../widgets/duo_button.dart';
import '../../widgets/ide_config_dialog.dart';
import '../../widgets/math_markdown.dart';

class PythonNotebookScreen extends StatefulWidget {
  final IdeProject? existingProject;

  const PythonNotebookScreen({super.key, this.existingProject});

  @override
  State<PythonNotebookScreen> createState() => _PythonNotebookScreenState();
}

class _PythonNotebookScreenState extends State<PythonNotebookScreen> {
  late String _projectId;
  late TextEditingController _titleController;
  final List<NotebookCell> _cells = [];
  final Map<String, CodeEditingController> _codeControllers = {};
  final Map<String, TextEditingController> _mdControllers = {};
  final Map<String, bool> _runningState = {};
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _projectId = widget.existingProject?.id ??
        'nb-${DateTime.now().millisecondsSinceEpoch}';
    _titleController = TextEditingController(
      text: widget.existingProject?.title ?? 'Python Notebook',
    );

    if (widget.existingProject != null &&
        widget.existingProject!.notebookCells.isNotEmpty) {
      _cells.addAll(widget.existingProject!.notebookCells);
    } else {
      // Starter default cells
      _cells.add(
        NotebookCell(
          id: 'c1',
          cellType: 'markdown',
          content: '# Python Data Science Notebook\nRun interactive Python code, use NumPy array calculations, handle `input()`, and render live Matplotlib charts!',
        ),
      );
      _cells.add(
        NotebookCell(
          id: 'c2',
          cellType: 'code',
          content: '''import numpy as np
import matplotlib.pyplot as plt

print("Testing NumPy array calculation...")
x = np.linspace(0, 10, 100)
y = np.sin(x)

plt.plot(x, y, color='blue', label='sin(x)')
plt.title("NumPy & Matplotlib Live Sine Wave")
plt.xlabel("x")
plt.ylabel("sin(x)")
plt.legend()
plt.grid(True)
plt.show()''',
        ),
      );
      _cells.add(
        NotebookCell(
          id: 'c3',
          cellType: 'code',
          content: '''import numpy as np
import matplotlib.pyplot as plt

amp = float(input("Enter wave amplitude (e.g. 5): "))
freq = float(input("Enter wave frequency (e.g. 2): "))

x = np.linspace(0, 10, 100)
y = amp * np.cos(freq * x)

plt.plot(x, y, color='red', label='Interactive Cosine')
plt.title(f"Interactive Cosine Wave (Amp={amp}, Freq={freq})")
plt.xlabel("x")
plt.ylabel("y")
plt.legend()
plt.grid(True)
plt.show()''',
        ),
      );
    }

    _initControllers();
  }

  void _initControllers() {
    for (final cell in _cells) {
      if (cell.cellType == 'code') {
        _codeControllers[cell.id] ??= CodeEditingController(
          text: cell.content,
          language: 'python',
        );
      } else {
        _mdControllers[cell.id] ??= TextEditingController(text: cell.content);
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    for (final c in _codeControllers.values) {
      c.dispose();
    }
    for (final c in _mdControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _addCell(String type) {
    final cellId = 'cell-${DateTime.now().millisecondsSinceEpoch}';
    final newCell = NotebookCell(
      id: cellId,
      cellType: type,
      content: type == 'code' ? 'print("Hello Python!")' : '### New Notes',
    );

    setState(() {
      _cells.add(newCell);
      if (type == 'code') {
        _codeControllers[cellId] = CodeEditingController(
          text: newCell.content,
          language: 'python',
        );
      } else {
        _mdControllers[cellId] = TextEditingController(text: newCell.content);
      }
    });
  }

  void _deleteCell(int index) {
    final id = _cells[index].id;
    setState(() {
      _codeControllers[id]?.dispose();
      _codeControllers.remove(id);
      _mdControllers[id]?.dispose();
      _mdControllers.remove(id);
      _cells.removeAt(index);
    });
  }

  Future<void> _runCell(NotebookCell cell) async {
    final code = _codeControllers[cell.id]?.text ?? cell.content;
    setState(() {
      _runningState[cell.id] = true;
      cell.outputStdout = null;
      cell.outputStderr = null;
      cell.graphicsBase64 = null;
    });

    final res = await PythonRunnerService.instance.runCode(
      code,
      onInputRequest: (prompt) async {
        final inputCtrl = TextEditingController();
        String result = '';
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            backgroundColor: context.colors.surface,
            title: Row(
              children: [
                const Icon(LucideIcons.terminal, color: AppTheme.duoBlue, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Python Input Request',
                  style: TextStyle(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prompt.trim().isNotEmpty ? prompt : 'Python script is asking for input:',
                  style: TextStyle(fontSize: 13, color: context.colors.textPrimary),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: inputCtrl,
                  autofocus: true,
                  style: TextStyle(color: context.colors.textPrimary, fontFamily: 'monospace'),
                  decoration: InputDecoration(
                    hintText: 'Enter value...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onSubmitted: (val) {
                    result = val;
                    Navigator.pop(ctx);
                  },
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.duoBlue),
                onPressed: () {
                  result = inputCtrl.text;
                  Navigator.pop(ctx);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        );
        return result;
      },
    );

    if (mounted) {
      setState(() {
        _runningState[cell.id] = false;
        cell.outputStdout = res.stdout;
        cell.outputStderr = res.stderr;
        cell.graphicsBase64 = res.graphicsBase64;
      });
    }
  }

  Future<void> _saveNotebook() async {
    setState(() {
      _isSaving = true;
    });

    for (final cell in _cells) {
      if (cell.cellType == 'code') {
        cell.content = _codeControllers[cell.id]?.text ?? cell.content;
      } else {
        cell.content = _mdControllers[cell.id]?.text ?? cell.content;
      }
    }

    final project = IdeProject(
      id: _projectId,
      title: _titleController.text.trim().isEmpty ? 'Python Notebook' : _titleController.text.trim(),
      type: 'python_notebook',
      language: 'python',
      codeContent: _cells.where((c) => c.cellType == 'code').map((c) => c.content).join('\n\n'),
      notebookCells: _cells,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    await CodeStorageService.instance.saveProject(project);

    if (mounted) {
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notebook saved successfully!'),
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
                hintText: 'Notebook Title...',
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
                tooltip: 'Save Notebook',
                onPressed: _saveNotebook,
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    itemCount: _cells.length,
                    itemBuilder: (ctx, idx) {
                      final cell = _cells[idx];
                      return _buildCellCard(cell, idx, isDark, settings);
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    border: Border(top: BorderSide(color: context.colors.outline)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: DuoButton(
                          text: '+ Code Cell',
                          color: AppTheme.duoBlue,
                          shadowColor: AppTheme.duoBlueDark,
                          onPressed: () => _addCell('code'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DuoButton(
                          text: '+ Text Cell',
                          color: AppTheme.duoViolet,
                          shadowColor: AppTheme.duoVioletDark,
                          onPressed: () => _addCell('markdown'),
                        ),
                      ),
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

  Widget _buildCellCard(NotebookCell cell, int index, bool isDark, IdeSettings settings) {
    final isRunning = _runningState[cell.id] ?? false;

    final editorBg = isDark ? const Color(0xFF0D1117) : const Color(0xFFF8FAFC);
    final editorText = isDark ? const Color(0xFFE6EDF3) : const Color(0xFF0F172A);
    final consoleBg = isDark ? const Color(0xFF161B22) : const Color(0xFFF1F5F9);
    final consoleText = isDark ? const Color(0xFFA6E3A1) : const Color(0xFF166534);

    if (cell.cellType == 'markdown') {
      final mdCtrl = _mdControllers[cell.id]!;
      return Card(
        margin: const EdgeInsets.only(bottom: 8),
        color: context.colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: context.colors.outline),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(LucideIcons.fileText, color: AppTheme.duoViolet, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        'TEXT CELL [${index + 1}]',
                        style: TextStyle(
                          color: AppTheme.duoViolet,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(LucideIcons.trash2, color: AppTheme.duoRed, size: 14),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => _deleteCell(index),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              TextField(
                controller: mdCtrl,
                maxLines: null,
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontSize: settings.fontSize,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type markdown / notes here...',
                  isDense: true,
                ),
                onChanged: (val) {
                  setState(() {
                    cell.content = val;
                  });
                },
              ),
              if (mdCtrl.text.isNotEmpty) ...[
                const Divider(height: 12),
                MathMarkdown(data: mdCtrl.text),
              ],
            ],
          ),
        ),
      );
    }

    final codeCtrl = _codeControllers[cell.id]!;
    codeCtrl.theme = isDark ? CodeTheme.dark : CodeTheme.light;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: context.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: context.colors.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(LucideIcons.code2, color: AppTheme.duoBlue, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'PYTHON CELL [${index + 1}]',
                      style: TextStyle(
                        color: AppTheme.duoBlue,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: isRunning
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Icon(LucideIcons.play, color: AppTheme.duoGreen, size: 18),
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(),
                      onPressed: isRunning ? null : () => _runCell(cell),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(LucideIcons.trash2, color: AppTheme.duoRed, size: 14),
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(),
                      onPressed: () => _deleteCell(index),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              decoration: BoxDecoration(
                color: editorBg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: context.colors.outline),
              ),
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: codeCtrl,
                maxLines: settings.wordWrap ? null : 1,
                strutStyle: StrutStyle(
                  fontFamily: 'monospace',
                  fontSize: settings.fontSize,
                  height: 1.4,
                  forceStrutHeight: true,
                ),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: settings.fontSize,
                  color: editorText,
                  height: 1.4,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
                onChanged: (val) {
                  setState(() {
                    cell.content = val;
                  });
                },
              ),
            ),
            if (cell.outputStdout != null || cell.outputStderr != null || (cell.graphicsBase64 != null && cell.graphicsBase64!.isNotEmpty)) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: consoleBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: context.colors.outline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OUTPUT:',
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (cell.outputStdout != null && cell.outputStdout!.isNotEmpty)
                      SelectableText(
                        cell.outputStdout!,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: settings.fontSize * 0.9,
                          color: consoleText,
                        ),
                      ),
                    if (cell.outputStderr != null && cell.outputStderr!.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF2A1215) : const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.redAccent.withValues(alpha: 0.5)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(LucideIcons.alertTriangle, color: Colors.redAccent, size: 14),
                                const SizedBox(width: 6),
                                Text(
                                  'ERROR / TRACEBACK:',
                                  style: TextStyle(
                                    color: isDark ? const Color(0xFFFCA5A5) : const Color(0xFF991B1B),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            SelectableText(
                              cell.outputStderr!,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: settings.fontSize * 0.9,
                                color: isDark ? const Color(0xFFF87171) : const Color(0xFFB91C1C),
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (cell.graphicsBase64 != null)
                      for (final img in cell.graphicsBase64!)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: _buildGraphicWidget(img),
                          ),
                        ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGraphicWidget(String rawBase64) {
    try {
      final decodedBytes = base64Decode(rawBase64);
      final decodedStr = utf8.decode(decodedBytes, allowMalformed: true);
      if (decodedStr.contains('<svg')) {
        return SvgPicture.string(
          decodedStr,
          fit: BoxFit.contain,
        );
      }
      return Image.memory(
        decodedBytes,
        fit: BoxFit.contain,
      );
    } catch (_) {
      return Image.memory(
        base64Decode(rawBase64),
        fit: BoxFit.contain,
      );
    }
  }
}
