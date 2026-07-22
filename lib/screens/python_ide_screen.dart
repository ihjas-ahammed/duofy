import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../services/python_runner_service.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';

class NotebookCell {
  String id;
  TextEditingController controller;
  TextEditingController inputsController;
  TextEditingController realtimeInputController;
  PythonExecutionResult? result;
  bool isRunning;
  int? executionCount;
  bool showInputsField;
  bool awaitingRealtimeInput;
  String currentInputPrompt;
  Completer<String>? activeInputCompleter;

  NotebookCell({
    required this.id,
    required String initialCode,
    String initialInputs = '',
    this.result,
    this.isRunning = false,
    this.executionCount,
    this.showInputsField = false,
    this.awaitingRealtimeInput = false,
    this.currentInputPrompt = '',
  })  : controller = TextEditingController(text: initialCode),
        inputsController = TextEditingController(text: initialInputs),
        realtimeInputController = TextEditingController();
}

class PythonIdeScreen extends StatefulWidget {
  const PythonIdeScreen({super.key});

  @override
  State<PythonIdeScreen> createState() => _PythonIdeScreenState();
}

class _PythonIdeScreenState extends State<PythonIdeScreen> {
  final List<NotebookCell> _cells = [];
  int _executionCounter = 0;
  bool _isGlobalRunning = false;

  @override
  void initState() {
    super.initState();
    _seedDefaultNotebook();
  }

  void _seedDefaultNotebook() {
    _cells.addAll([
      NotebookCell(
        id: 'cell_1',
        initialCode: '# Duofy Interactive Real-time Jupyter Input Demo\nname = input("Enter your name: ")\nage = input("Enter your age: ")\nprint(f"Hello {name}! You are {age} years old.")',
        initialInputs: '',
        showInputsField: false,
      ),
      NotebookCell(
        id: 'cell_2',
        initialCode: '''# Matplotlib Inline Graphics Demo
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0, 10, 100)
y = np.sin(x)

plt.figure(figsize=(7, 3.8))
plt.plot(x, y, color='#10B981', linewidth=2.5, label='sin(x)')
plt.plot(x, np.cos(x), color='#3B82F6', linewidth=2.0, linestyle='--', label='cos(x)')
plt.title('Inline Jupyter Plot Rendering', fontsize=14, fontweight='bold')
plt.xlabel('X value')
plt.ylabel('Y value')
plt.grid(True, alpha=0.25)
plt.legend()
plt.tight_layout()
plt.show()''',
      ),
    ]);
  }

  @override
  void dispose() {
    for (final cell in _cells) {
      cell.controller.dispose();
      cell.inputsController.dispose();
      cell.realtimeInputController.dispose();
    }
    super.dispose();
  }

  void _submitRealtimeInput(NotebookCell cell) {
    final inputVal = cell.realtimeInputController.text;
    cell.activeInputCompleter?.complete(inputVal);
    setState(() {
      cell.awaitingRealtimeInput = false;
      cell.currentInputPrompt = '';
      cell.activeInputCompleter = null;
    });
  }

  Future<void> _runCell(NotebookCell cell) async {
    if (cell.isRunning) return;

    setState(() {
      cell.isRunning = true;
      cell.result = null;
      cell.awaitingRealtimeInput = false;
    });

    final rawInputs = cell.inputsController.text;
    final List<String> inputsList = rawInputs.isNotEmpty
        ? rawInputs.split(RegExp(r'\r?\n')).toList()
        : const [];

    final res = await PythonRunnerService.instance.runCode(
      cell.controller.text,
      inputs: inputsList,
      onInputRequest: (prompt) async {
        if (!mounted) return '';
        final completer = Completer<String>();
        setState(() {
          cell.awaitingRealtimeInput = true;
          cell.currentInputPrompt = prompt;
          cell.realtimeInputController.clear();
          cell.activeInputCompleter = completer;
        });
        return await completer.future;
      },
    );

    if (mounted) {
      setState(() {
        _executionCounter++;
        cell.executionCount = _executionCounter;
        cell.isRunning = false;
        cell.awaitingRealtimeInput = false;
        cell.result = res;
      });
    }
  }

  Future<void> _runAllCells() async {
    if (_isGlobalRunning) return;
    setState(() => _isGlobalRunning = true);

    for (final cell in _cells) {
      await _runCell(cell);
    }

    if (mounted) {
      setState(() => _isGlobalRunning = false);
    }
  }

  void _addCell() {
    setState(() {
      _cells.add(
        NotebookCell(
          id: 'cell_${DateTime.now().millisecondsSinceEpoch}',
          initialCode: '# Write Python code here\n',
        ),
      );
    });
  }

  void _clearOutputs() {
    setState(() {
      for (final cell in _cells) {
        cell.result = null;
        cell.executionCount = null;
      }
    });
  }

  void _deleteCell(int index) {
    if (_cells.length <= 1) return;
    setState(() {
      _cells[index].controller.dispose();
      _cells.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(LucideIcons.terminal, color: AppTheme.duoGreen, size: 22),
            const SizedBox(width: 10),
            const Text(
              'Python IDE & Jupyter',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppTheme.duoGreen.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppTheme.duoGreen.withValues(alpha: 0.4)),
              ),
              child: const Text(
                'SeriousPython',
                style: TextStyle(
                  color: AppTheme.duoGreen,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Run All Cells',
            icon: _isGlobalRunning
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.duoGreen),
                  )
                : const Icon(LucideIcons.playCircle, color: AppTheme.duoGreen),
            onPressed: _isGlobalRunning ? null : _runAllCells,
          ),
          IconButton(
            tooltip: 'Clear Outputs',
            icon: const Icon(LucideIcons.eraser),
            onPressed: _clearOutputs,
          ),
          IconButton(
            tooltip: 'Add Cell',
            icon: const Icon(LucideIcons.plusCircle),
            onPressed: _addCell,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: AppTheme.glassOf(context),
                child: Row(
                  children: [
                    const Icon(LucideIcons.code, color: AppTheme.duoBlue, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Embedded CPython runtime with Jupyter Notebook inline matplotlib graphics & plot rendering.',
                        style: TextStyle(
                          color: context.colors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildCellCard(context, _cells[index], index),
                childCount: _cells.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              child: DuoButton(
                text: '+ ADD CODE CELL',
                color: AppTheme.duoBlue,
                shadowColor: AppTheme.duoBlueDark,
                onPressed: _addCell,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCellCard(BuildContext context, NotebookCell cell, int index) {
    final execLabel = cell.isRunning
        ? '[*]:'
        : (cell.executionCount != null ? '[${cell.executionCount}]:' : '[ ]:');

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: cell.isRunning
              ? AppTheme.duoGreen
              : context.colors.textFaint.withValues(alpha: 0.2),
          width: cell.isRunning ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Cell Header Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: context.colors.surfaceAlt,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Row(
              children: [
                Text(
                  execLabel,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    color: cell.isRunning
                        ? AppTheme.duoGreen
                        : context.colors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Python Cell ${index + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: context.colors.textSecondary,
                  ),
                ),
                const Spacer(),
                IconButton(
                  iconSize: 18,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  icon: Icon(
                    LucideIcons.terminal,
                    color: cell.showInputsField ? AppTheme.duoBlue : context.colors.textSecondary,
                  ),
                  tooltip: 'Configure Inputs (for input() calls)',
                  onPressed: () {
                    setState(() {
                      cell.showInputsField = !cell.showInputsField;
                    });
                  },
                ),
                IconButton(
                  iconSize: 18,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  icon: cell.isRunning
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.duoGreen),
                        )
                      : const Icon(LucideIcons.play, color: AppTheme.duoGreen),
                  tooltip: 'Run Cell',
                  onPressed: cell.isRunning ? null : () => _runCell(cell),
                ),
                if (_cells.length > 1)
                  IconButton(
                    iconSize: 18,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    icon: const Icon(LucideIcons.trash2, color: AppTheme.duoRed),
                    tooltip: 'Delete Cell',
                    onPressed: () => _deleteCell(index),
                  ),
              ],
            ),
          ),
          // Code Editor Field
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: cell.controller,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              autocorrect: false,
              enableSuggestions: false,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.5,
                height: 1.5,
                color: Color(0xFFE2E8F0),
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF0F172A),
                contentPadding: const EdgeInsets.all(14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Optional Standard Input Field (for input() calls)
          if (cell.showInputsField)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.duoBlue.withValues(alpha: 0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(LucideIcons.terminal, color: AppTheme.duoBlue, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          'STANDARD INPUT (one value per line for input() calls)',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: context.colors.textSecondary,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: cell.inputsController,
                      maxLines: 3,
                      minLines: 1,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.5,
                        color: Color(0xFF38BDF8),
                      ),
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Enter inputs here (e.g. Alice\\n25)',
                        hintStyle: TextStyle(color: Colors.white30, fontSize: 12),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // Real-time Interactive Jupyter Input Prompt Widget
          if (cell.awaitingRealtimeInput)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.duoGreen, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.duoGreen),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          cell.currentInputPrompt.isNotEmpty
                              ? cell.currentInputPrompt
                              : 'Input required:',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.duoGreen,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: cell.realtimeInputController,
                            autofocus: true,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 13,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Type input and press Enter...',
                              hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
                              filled: true,
                              fillColor: const Color(0xFF1E293B),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onSubmitted: (_) => _submitRealtimeInput(cell),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(LucideIcons.send, color: AppTheme.duoGreen),
                          tooltip: 'Submit Input',
                          onPressed: () => _submitRealtimeInput(cell),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          // Cell Execution Output
          if (cell.result != null) _buildCellOutput(context, cell.result!),
        ],
      ),
    );
  }

  Widget _buildCellOutput(BuildContext context, PythonExecutionResult res) {
    final hasStdout = res.stdout.trim().isNotEmpty;
    final hasStderr = res.stderr.trim().isNotEmpty;
    final hasGraphics = res.graphicsBase64.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF020617),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
        border: Border(
          top: BorderSide(color: context.colors.textFaint.withValues(alpha: 0.15)),
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Execution Meta
          Row(
            children: [
              Icon(
                res.exitCode == 0 ? LucideIcons.checkCircle2 : LucideIcons.alertCircle,
                size: 14,
                color: res.exitCode == 0 ? AppTheme.duoGreen : AppTheme.duoRed,
              ),
              const SizedBox(width: 6),
              Text(
                res.exitCode == 0 ? 'Output' : 'Execution Failed',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: res.exitCode == 0 ? AppTheme.duoGreen : AppTheme.duoRed,
                ),
              ),
              const Spacer(),
              Text(
                '${res.duration.inMilliseconds} ms',
                style: TextStyle(
                  fontSize: 10,
                  color: context.colors.textFaint,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          if (hasStdout) ...[
            const SizedBox(height: 10),
            SelectableText(
              res.stdout,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                height: 1.45,
                color: Color(0xFFCBD5E1),
              ),
            ),
          ],
          if (hasStderr) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.duoRed.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.duoRed.withValues(alpha: 0.3)),
              ),
              child: SelectableText(
                res.stderr,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Color(0xFFFCA5A5),
                ),
              ),
            ),
          ],
          if (hasGraphics) ...[
            const SizedBox(height: 12),
            const Text(
              'Jupyter Graphics & Plots:',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppTheme.duoGreen,
              ),
            ),
            const SizedBox(height: 8),
            ...res.graphicsBase64.map((b64) {
              final imageBytes = base64Decode(b64);
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: Image.memory(
                      imageBytes,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}
