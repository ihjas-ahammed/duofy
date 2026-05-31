import 'package:flutter/material.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

class PyqOneWordView extends StatefulWidget {
  final Slide slide;
  final Map<int, String> values;
  final Function(int, String) onChanged;

  const PyqOneWordView({
    super.key,
    required this.slide,
    required this.values,
    required this.onChanged,
  });

  @override
  State<PyqOneWordView> createState() => _PyqOneWordViewState();
}

class _PyqOneWordViewState extends State<PyqOneWordView> {
  final Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  @override
  void didUpdateWidget(PyqOneWordView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.slide.id != widget.slide.id) {
      _disposeControllers();
      _initControllers();
    }
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _initControllers() {
    final steps = widget.slide.interactiveSteps ?? [];
    for (int i = 0; i < steps.length; i++) {
      _controllers[i] = TextEditingController(text: widget.values[i] ?? '');
    }
  }

  void _disposeControllers() {
    _controllers.forEach((_, ctrl) => ctrl.dispose());
    _controllers.clear();
  }

  @override
  Widget build(BuildContext context) {
    final steps = widget.slide.interactiveSteps ?? [];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.slide.title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                widget.slide.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          if (widget.slide.content.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: AppTheme.glassDecoration,
              child: MathMarkdown(
                data: widget.slide.content,
                textStyle: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          const SizedBox(height: 24),
          const Text(
            'FILL IN YOUR ANSWERS BELOW',
            style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.5),
          ),
          const SizedBox(height: 12),
          
          if (steps.isEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    'Solve the question below:',
                    style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _controllers[0] ??= TextEditingController(),
                    onChanged: (val) => widget.onChanged(0, val),
                    style: const TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: 'Type answer',
                      hintStyle: const TextStyle(color: Colors.white24),
                      filled: true,
                      fillColor: Colors.black38,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  )
                ],
              ),
            )
          else
            ...List.generate(steps.length, (idx) {
              final step = steps[idx];
              final ctrl = _controllers[idx] ??= TextEditingController();
              
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Q${idx + 1}',
                            style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: MathMarkdown(
                            data: step.prompt ?? widget.slide.content,
                            textStyle: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: ctrl,
                      onChanged: (val) => widget.onChanged(idx, val),
                      style: const TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'type answer here',
                        hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
                        filled: true,
                        fillColor: Colors.black26,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                  ],
                ),
              );
            })
        ],
      ),
    );
  }
}
