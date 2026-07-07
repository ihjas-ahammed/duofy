import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../duo_button.dart';
import '../math_markdown.dart';

/// `flashcard` slide: active recall with self-grading. Front = the prompt
/// ([Slide.content]), back = the answer ([Slide.blankAnswer]). The learner
/// recalls, flips, then honestly grades themselves — "Again" feeds the
/// spaced-review queue via the host's [onSelfGrade].
class FlashcardView extends StatefulWidget {
  final Slide slide;
  final void Function(bool remembered) onSelfGrade;

  const FlashcardView({super.key, required this.slide, required this.onSelfGrade});

  @override
  State<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<FlashcardView> {
  bool _flipped = false;
  bool _graded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () => setState(() => _flipped = !_flipped),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: _flipped ? 1 : 0),
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                  builder: (context, t, _) {
                    final showBack = t > 0.5;
                    final angle = t * math.pi;
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.0012)
                        ..rotateY(angle),
                      child: Transform(
                        alignment: Alignment.center,
                        // Un-mirror the back face.
                        transform: Matrix4.identity()..rotateY(showBack ? math.pi : 0),
                        child: Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(minHeight: 260),
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: showBack
                                ? AppTheme.duoGreen.withOpacity(0.08)
                                : Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: showBack
                                  ? AppTheme.duoGreen.withOpacity(0.5)
                                  : AppTheme.duoBlue.withOpacity(0.4),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                showBack ? 'ANSWER' : 'RECALL, THEN TAP TO FLIP',
                                style: TextStyle(
                                  color: showBack ? AppTheme.duoGreen : Colors.white38,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 10,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 16),
                              MathMarkdown(
                                data: showBack
                                    ? (widget.slide.blankAnswer ?? '')
                                    : widget.slide.content,
                                textStyle: const TextStyle(
                                    fontSize: 19,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              if (!showBack) ...[
                                const SizedBox(height: 20),
                                const Icon(LucideIcons.refreshCw,
                                    color: Colors.white24, size: 18),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _flipped && !_graded
                ? Row(
                    key: const ValueKey('grade_buttons'),
                    children: [
                      Expanded(
                        child: DuoButton(
                          text: 'Again',
                          color: AppTheme.duoRed,
                          shadowColor: AppTheme.duoRedDark,
                          isOutline: true,
                          onPressed: () {
                            setState(() => _graded = true);
                            widget.onSelfGrade(false);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DuoButton(
                          text: 'Got it',
                          color: AppTheme.duoGreen,
                          shadowColor: AppTheme.duoGreenDark,
                          onPressed: () {
                            setState(() => _graded = true);
                            widget.onSelfGrade(true);
                          },
                        ),
                      ),
                    ],
                  )
                : const SizedBox(height: 56, key: ValueKey('grade_placeholder')),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
