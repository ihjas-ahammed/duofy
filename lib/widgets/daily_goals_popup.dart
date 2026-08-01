import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/daily_goal.dart';
import '../services/daily_goals_service.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../screens/daily_goals_screen.dart';

class DailyGoalsPopup extends StatelessWidget {
  final List<DailyGoal> goals;

  const DailyGoalsPopup({super.key, required this.goals});

  static Future<void> checkAndShow(BuildContext context) async {
    final isFirst = await DailyGoalsService.instance.isFirstLaunchToday();
    if (!isFirst) return;

    final goals = await DailyGoalsService.instance.getTodayGoals();
    final hasImprovements = goals.any((g) => g.current > 0);
    if (!hasImprovements) return;

    await DailyGoalsService.instance.markFirstLaunchSeen();

    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => DailyGoalsPopup(goals: goals),
    );
  }

  @override
  Widget build(BuildContext context) {
    HapticFeedback.lightImpact();

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: context.colors.outline),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: context.colors.isDark ? 0.4 : 0.15),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: context.colors.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.duoBlue.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.duoBlue.withValues(alpha: 0.3),
                  ),
                ),
                child: const Icon(
                  LucideIcons.target,
                  color: AppTheme.duoBlue,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(LucideIcons.sun, color: AppTheme.duoOrange, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          'WELCOME BACK',
                          style: TextStyle(
                            color: AppTheme.duoOrange,
                            fontWeight: FontWeight.w900,
                            fontSize: 11,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Today\'s Daily Goals',
                      style: TextStyle(
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Complete your objectives today to build your streak and earn extra XP rewards!',
            style: TextStyle(
              color: context.colors.textSecondary,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          // List of objectives for today with animated progress bars
          for (final goal in goals.take(3)) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: context.colors.surfaceAlt,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.colors.outline),
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          goal.icon,
                          color: AppTheme.duoOrange,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              goal.title,
                              style: TextStyle(
                                color: context.colors.textPrimary,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Progress: ${goal.current} / ${goal.target}',
                              style: TextStyle(
                                color: context.colors.textFaint,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.duoYellow.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppTheme.duoYellow.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(LucideIcons.zap,
                                color: AppTheme.duoYellow, size: 12),
                            const SizedBox(width: 4),
                            Text(
                              '+${goal.rewardXp}',
                              style: TextStyle(
                                color: AppTheme.duoYellow,
                                fontWeight: FontWeight.w900,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Animated Progress Bar for each objective
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      height: 6,
                      color: context.colors.surface,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0.0, end: goal.progressRatio),
                        duration: const Duration(milliseconds: 700),
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
                                borderRadius: BorderRadius.circular(6),
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
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DailyGoalsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    LucideIcons.layoutGrid,
                    size: 16,
                    color: AppTheme.duoBlue,
                  ),
                  label: const Text(
                    'View Details',
                    style: TextStyle(
                      color: AppTheme.duoBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DuoButton(
                  text: 'LET\'S GO',
                  color: AppTheme.duoBlue,
                  shadowColor: AppTheme.duoBlueDark,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
