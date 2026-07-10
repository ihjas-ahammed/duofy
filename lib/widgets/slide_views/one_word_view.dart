import 'package:flutter/material.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

/// Renders a "one word" recall slide: a question with a single free-text input
/// box where the learner types a one-word/short answer. Mirrors
/// [NumericalView] but accepts text instead of a number. The expected answer
/// lives in [Slide.blankAnswer] and is matched case-insensitively by the
/// host screen.
class OneWordView extends StatelessWidget {
  final Slide slide;
  final String value;
  final bool isAnswered;
  final bool isCorrect;
  final Function(String) onChanged;

  final Widget? bottomBar;

  const OneWordView({
    super.key,
    required this.slide,
    required this.value,
    required this.isAnswered,
    required this.isCorrect,
    required this.onChanged,
    this.bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: AppTheme.glassOf(context),
                  child: MathMarkdown(
                    data: slide.content,
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: context.colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: context.colors.surfaceAlt,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isAnswered
                          ? (isCorrect ? AppTheme.duoGreen : AppTheme.duoRed)
                          : context.colors.outline,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'TYPE YOUR ANSWER',
                        style: TextStyle(
                          color: context.colors.textFaint,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        enabled: !isAnswered,
                        onChanged: onChanged,
                        textAlign: TextAlign.center,
                        textCapitalization: TextCapitalization.none,
                        autocorrect: false,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: isAnswered
                              ? (isCorrect
                                    ? AppTheme.duoGreen
                                    : AppTheme.duoRed)
                              : Colors.amber,
                        ),
                        decoration: InputDecoration(
                          hintText: 'answer',
                          hintStyle: TextStyle(color: context.colors.textFaint),
                          filled: true,
                          fillColor: context.colors.surfaceAlt,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.amber,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (bottomBar != null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [const SizedBox(height: 24), bottomBar!],
              ),
            ),
        ],
      ),
    );
  }
}
