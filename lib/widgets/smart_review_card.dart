import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../models/app_models.dart';
import '../screens/lesson_screen.dart';
import '../services/global_state.dart';
import '../services/metacognition_service.dart';
import '../theme/app_theme.dart';

/// "Smart Review (N due)" card: launches a session of the slides the learner
/// got wrong (or guessed) recently, spaced at 1/3/7-day intervals. The
/// session is a synthetic lesson through the normal LessonScreen, so every
/// slide type works and the same answer hook advances the review queue.
/// Renders nothing when nothing is due.
class SmartReviewCard extends StatelessWidget {
  final EdgeInsetsGeometry margin;

  const SmartReviewCard({
    super.key,
    this.margin = const EdgeInsets.fromLTRB(24, 0, 24, 8),
  });

  Future<void> _startSession(BuildContext context) async {
    final slides = await MetacognitionService.resolveDueSlides(limit: 5);
    if (!context.mounted) return;
    if (slides.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nothing left to review — great job!')),
      );
      GlobalState.bumpProgress();
      return;
    }
    final lesson = Lesson(
      id: 'smart-review-${DateTime.now().millisecondsSinceEpoch}',
      title: 'Smart Review',
      description: 'Spaced review of your tricky items',
      icon: 'RefreshCw',
      slides: slides,
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LessonScreen(lesson: lesson)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: GlobalState.progressNotifier,
      builder: (context, _, _) => FutureBuilder<int>(
        future: MetacognitionService.dueCount(),
        builder: (context, snap) {
          final due = snap.data ?? 0;
          if (due == 0) return const SizedBox.shrink();
          return Padding(
            padding: margin,
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => _startSession(context),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppTheme.duoViolet.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppTheme.duoViolet.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.duoViolet.withValues(alpha: 0.16),
                      ),
                      child: Icon(
                        LucideIcons.brain,
                        color: AppTheme.duoViolet,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Smart Review',
                            style: TextStyle(
                              color: context.colors.textPrimary,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '$due item${due == 1 ? '' : 's'} due — 5 minutes well spent',
                            style: TextStyle(
                              color: context.colors.textFaint,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      LucideIcons.chevronRight,
                      color: AppTheme.duoViolet,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}