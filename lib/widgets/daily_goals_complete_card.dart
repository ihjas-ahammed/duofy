import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/daily_goal.dart';
import '../services/daily_goals_service.dart';
import '../theme/app_theme.dart';
import '../screens/daily_goals_screen.dart';

class DailyGoalsCompleteCard extends StatefulWidget {
  const DailyGoalsCompleteCard({super.key});

  @override
  State<DailyGoalsCompleteCard> createState() => _DailyGoalsCompleteCardState();
}

class _DailyGoalsCompleteCardState extends State<DailyGoalsCompleteCard> {
  late Future<List<DailyGoal>> _goalsFuture;

  @override
  void initState() {
    super.initState();
    _goalsFuture = DailyGoalsService.instance.getTodayGoals();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DailyGoal>>(
      future: _goalsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }

        final goals = snapshot.data ?? [];
        if (goals.isEmpty) return const SizedBox.shrink();

        final hasImprovements = goals.any((g) => g.current > 0);
        if (!hasImprovements) return const SizedBox.shrink();

        final completedCount = goals.where((g) => g.isCompleted).length;
        final totalCount = goals.where((g) => !g.isBonus).length;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.all(16),
          decoration: AppTheme.glassOf(context).copyWith(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppTheme.duoOrange.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.duoOrange.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      LucideIcons.target,
                      color: AppTheme.duoOrange,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DAILY GOALS PROGRESS',
                          style: TextStyle(
                            color: AppTheme.duoOrange,
                            fontWeight: FontWeight.w900,
                            fontSize: 10,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          '$completedCount / $totalCount Completed Today',
                          style: TextStyle(
                            color: context.colors.textPrimary,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DailyGoalsScreen(),
                        ),
                      );
                    },
                    icon: const Icon(LucideIcons.arrowRight, size: 14, color: AppTheme.duoBlue),
                    label: const Text(
                      'View All',
                      style: TextStyle(
                        color: AppTheme.duoBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // List of active objectives with animated progress bars
              for (final goal in goals.take(3)) ...[
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: goal.isCompleted
                        ? AppTheme.duoGreen.withValues(alpha: 0.1)
                        : context.colors.surfaceAlt,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: goal.isCompleted
                          ? AppTheme.duoGreen.withValues(alpha: 0.4)
                          : context.colors.outline,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            goal.isCompleted ? LucideIcons.checkCircle2 : goal.icon,
                            color: goal.isCompleted ? AppTheme.duoGreen : AppTheme.duoOrange,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              goal.title,
                              style: TextStyle(
                                color: context.colors.textPrimary,
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '${goal.current}/${goal.target}',
                            style: TextStyle(
                              color: goal.isCompleted ? AppTheme.duoGreen : context.colors.textFaint,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Animated Progress Bar!
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          height: 6,
                          color: context.colors.surface,
                          child: TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0.0, end: goal.progressRatio),
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeOutCubic,
                            builder: (context, value, child) {
                              return FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: value,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: goal.isCompleted
                                          ? [AppTheme.duoGreen, const Color(0xFF10B981)]
                                          : [AppTheme.duoOrange, const Color(0xFFFF8C00)],
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
