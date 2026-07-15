import 'package:flutter/material.dart';

import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/duo_button.dart';
import '../../widgets/slide_views/code_runner_view.dart';
import '../../widgets/slide_views/program_view.dart';

/// Developer-only gallery of the programming slide family: `program` fill-in
/// slides (syntax-highlighted) and `try_yourself` live code runners. Grouped
/// separately from the standard slide types so it's easy to eyeball each one
/// in isolation. Reached from Settings → Developer mode.
class ProgrammingSlidesScreen extends StatelessWidget {
  const ProgrammingSlidesScreen({super.key});

  static final List<Slide> _programSamples = [
    Slide(
      id: 'p_py',
      type: 'program',
      title: 'Python — print',
      content: 'Complete the line so it greets the user.',
      language: 'python',
      code: 'name = "Ada"\n___(f"Hello, {name}!")',
      blankAnswer: 'print',
      blankDistractors: const ['echo', 'printf', 'console.log'],
    ),
    Slide(
      id: 'p_js',
      type: 'program',
      title: 'JavaScript — const',
      content: 'Which keyword declares a value that never changes?',
      language: 'javascript',
      code: '___ PI = 3.14159;\nconsole.log(PI);',
      blankAnswer: 'const',
      blankDistractors: const ['var', 'let', 'final'],
    ),
  ];

  static final List<Slide> _runnerSamples = [
    Slide(
      id: 'r_py',
      type: 'try_yourself',
      title: 'Python runner',
      content: 'Edit and Run — output appears below.',
      language: 'python',
      code: 'for i in range(3):\n    print("row", i)\n',
    ),
    Slide(
      id: 'r_py_np',
      type: 'try_yourself',
      title: 'Python + Matplotlib',
      content: 'Preloads numpy & matplotlib, then plots.',
      language: 'python',
      packages: const ['numpy', 'matplotlib'],
      code:
          'import numpy as np\nimport matplotlib.pyplot as plt\nx = np.linspace(0, 6.28, 100)\nplt.plot(x, np.sin(x))\nplt.show()\n',
    ),
    Slide(
      id: 'r_web',
      type: 'try_yourself',
      title: 'HTML live preview',
      content: 'Renders the markup in a sandboxed frame.',
      language: 'html',
      code: '<h2 style="color:teal">Hello!</h2>\n<p>Edit me and press Run.</p>',
    ),
    Slide(
      id: 'r_latex',
      type: 'try_yourself',
      title: 'LaTeX preview',
      content: 'Typeset with LaTeX.js.',
      language: 'latex',
      code: r'The quadratic formula: $x = \frac{-b \pm \sqrt{b^2-4ac}}{2a}$.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Programming Slides',
            style: TextStyle(fontWeight: FontWeight.w900)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _header(context, 'Program (fill-in + syntax highlight)'),
          for (final s in _programSamples) _ProgramCard(slide: s),
          const SizedBox(height: 24),
          _header(context, 'Try Yourself (live runners)'),
          for (final s in _runnerSamples) _RunnerCard(slide: s),
          const SizedBox(height: 24),
          _header(context, 'Programming lesson formats'),
          _formatInfo(context, 'Code Walkthrough',
              'theory → program (fill-in) → try_yourself — read, complete, then run.'),
          _formatInfo(context, 'Data Science Notebook',
              'theory → try_yourself with numpy/pandas/matplotlib preloaded.'),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _header(BuildContext context, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 12, top: 4),
        child: Text(text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: context.colors.textPrimary)),
      );

  Widget _formatInfo(BuildContext context, String name, String desc) =>
      Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: AppTheme.glassOf(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: context.colors.textPrimary)),
            const SizedBox(height: 4),
            Text(desc,
                style:
                    TextStyle(fontSize: 12, color: context.colors.textSecondary)),
          ],
        ),
      );
}

/// Hosts a single `program` slide with local answer state and a check button.
class _ProgramCard extends StatefulWidget {
  final Slide slide;
  const _ProgramCard({required this.slide});

  @override
  State<_ProgramCard> createState() => _ProgramCardState();
}

class _ProgramCardState extends State<_ProgramCard> {
  String _value = '';
  bool _answered = false;

  bool get _correct =>
      _value.trim().toLowerCase() ==
      (widget.slide.blankAnswer ?? '').trim().toLowerCase();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
      ),
      clipBehavior: Clip.antiAlias,
      child: ProgramView(
        slide: widget.slide,
        value: _value,
        isAnswered: _answered,
        isCorrect: _correct,
        onChanged: (v) => setState(() => _value = v),
        onSubmit: () => setState(() => _answered = true),
        bottomBar: Padding(
          padding: const EdgeInsets.all(12),
          child: DuoButton(
            text: _answered ? (_correct ? 'CORRECT ✓' : 'TRY AGAIN') : 'CHECK',
            color: _answered
                ? (_correct ? AppTheme.duoGreen : AppTheme.duoRed)
                : AppTheme.duoBlue,
            shadowColor: AppTheme.duoBlueDark,
            onPressed: () => setState(() => _answered = !_answered),
          ),
        ),
      ),
    );
  }
}

/// Hosts a single `try_yourself` runner at a fixed height.
class _RunnerCard extends StatelessWidget {
  final Slide slide;
  const _RunnerCard({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 520,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
      ),
      clipBehavior: Clip.antiAlias,
      child: CodeRunnerView(
        slide: slide,
        onComplete: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Runner completed (dev preview)')),
        ),
      ),
    );
  }
}
