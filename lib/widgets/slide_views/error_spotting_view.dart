import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

/// `error_spotting` slide: a worked solution whose steps contain exactly one
/// flaw ([Slide.errorIndex] into [Slide.proofSteps]). The learner taps the
/// step they believe is wrong; the host validates the selected index.
/// Error-spotting trains evaluation — a higher-order skill than reproducing
/// a correct solution.
class ErrorSpottingView extends StatelessWidget {
  final Slide slide;
  final int? selectedIndex;
  final bool isAnswered;
  final bool isCorrect;
  final void Function(int index) onSelect;
  final Widget? bottomBar;

  const ErrorSpottingView({
    super.key,
    required this.slide,
    required this.selectedIndex,
    required this.isAnswered,
    required this.isCorrect,
    required this.onSelect,
    this.bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    final steps = slide.proofSteps ?? [];
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            LucideIcons.searchX,
                            color: AppTheme.duoOrange,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'FIND THE MISTAKE',
                            style: TextStyle(
                              color: AppTheme.duoOrange,
                              fontWeight: FontWeight.w900,
                              fontSize: 11,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      MathMarkdown(
                        data: slide.content.isNotEmpty
                            ? slide.content
                            : 'One of these steps is wrong. Tap it.',
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: context.colors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                for (var i = 0; i < steps.length; i++)
                  Builder(
                    builder: (context) {
                      Color border = context.colors.outline;
                      if (isAnswered) {
                        if (i == slide.errorIndex) {
                          border =
                              AppTheme.duoGreen; // the actual flaw, revealed
                        } else if (i == selectedIndex) {
                          border = AppTheme.duoRed;
                        }
                      } else if (i == selectedIndex) {
                        border = Colors.amber;
                      }
                      return GestureDetector(
                        onTap: isAnswered ? null : () => onSelect(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: context.colors.surfaceAlt,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: border, width: 2),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${i + 1}.',
                                style: TextStyle(
                                  color: context.colors.textFaint,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: MathMarkdown(
                                  data: steps[i],
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color: context.colors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (isAnswered && i == slide.errorIndex)
                                const Icon(
                                  LucideIcons.badgeAlert,
                                  color: AppTheme.duoGreen,
                                  size: 18,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
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
