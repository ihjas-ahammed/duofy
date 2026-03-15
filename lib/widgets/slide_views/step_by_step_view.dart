import 'package:flutter/material.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';
import '../duo_button.dart';
import 'interactive_proof_view.dart';

class StepByStepView extends StatefulWidget {
  final Slide slide;
  final VoidCallback onComplete;

  const StepByStepView({
    super.key,
    required this.slide,
    required this.onComplete,
  });

  @override
  State<StepByStepView> createState() => _StepByStepViewState();
}

class _StepByStepViewState extends State<StepByStepView> {
  bool _started = false;

  @override
  Widget build(BuildContext context) {
    if (!_started) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: AppTheme.glassDecoration,
              child: MathMarkdown(data: widget.slide.content, textStyle: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 32),
            DuoButton(
              text: 'I have tried, show steps',
              color: AppTheme.duoOrange,
              shadowColor: AppTheme.duoOrangeDark,
              onPressed: () => setState(() => _started = true),
            )
          ],
        ),
      );
    }
    return InteractiveProofView(slide: widget.slide, onComplete: widget.onComplete);
  }
}