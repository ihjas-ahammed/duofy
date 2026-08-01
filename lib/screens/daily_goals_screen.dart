import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/daily_goal.dart';
import '../services/daily_goals_service.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';

class DailyGoalsScreen extends StatefulWidget {
  const DailyGoalsScreen({super.key});

  @override
  State<DailyGoalsScreen> createState() => _DailyGoalsScreenState();
}

class _DailyGoalsScreenState extends State<DailyGoalsScreen>
    with SingleTickerProviderStateMixin {
  late Future<List<DailyGoal>> _goalsFuture;
  Map<String, int> _allTimeStats = {'completed': 0, 'xpEarned': 0};

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _goalsFuture = DailyGoalsService.instance.getTodayGoals();
    });
    DailyGoalsService.instance.getStats().then((stats) {
      if (mounted) {
        setState(() {
          _allTimeStats = stats;
        });
      }
    });
  }

  Future<void> _claimReward(DailyGoal goal) async {
    HapticFeedback.mediumImpact();
    await DailyGoalsService.instance.claimReward(goal);
    _refresh();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(LucideIcons.zap, color: AppTheme.duoYellow, size: 18),
            const SizedBox(width: 8),
            Text(
              'Claimed +${goal.rewardXp} XP reward for "${goal.title}"!',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: AppTheme.duoGreen,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.target, color: AppTheme.duoOrange, size: 22),
            const SizedBox(width: 8),
            Text(
              'Daily Goals',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: context.colors.textPrimary,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<DailyGoal>>(
        future: _goalsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final goals = snapshot.data ?? [];
          final completedCount = goals.where((g) => g.isCompleted).length;
          final totalCount = goals.where((g) => !g.isBonus).length;
          final allMainCompleted = completedCount >= totalCount;

          return RefreshIndicator(
            onRefresh: () async => _refresh(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Hero Header Card
                  _buildHeroHeaderCard(completedCount, totalCount),

                  const SizedBox(height: 20),

                  // Section Title
                  Row(
                    children: [
                      Icon(LucideIcons.flame, color: AppTheme.duoOrange, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Today\'s Objectives',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: context.colors.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '$completedCount/$totalCount Completed',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.duoOrange,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // List of Daily Goals
                  for (final goal in goals) ...[
                    _buildGoalItemCard(goal),
                    const SizedBox(height: 12),
                  ],

                  if (allMainCompleted) ...[
                    const SizedBox(height: 12),
                    _buildInfiniteBonusBanner(),
                  ],

                  const SizedBox(height: 24),

                  // All-time Stats Summary
                  _buildAllTimeStatsCard(),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroHeaderCard(int completed, int total) {
    final ratio = total > 0 ? (completed / total).clamp(0.0, 1.0) : 0.0;
    final isFull = completed >= total;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isFull
              ? [const Color(0xFF059669), const Color(0xFF10B981)]
              : [AppTheme.duoOrange, const Color(0xFFFF8C00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: (isFull ? AppTheme.duoGreen : AppTheme.duoOrange)
                .withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(LucideIcons.gift, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isFull ? 'Chest Ready to Open!' : 'Daily Goal Streak',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      isFull
                          ? 'All daily objectives completed for today!'
                          : 'Complete $total objectives every day to earn bonus rewards',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 10,
              color: Colors.black.withValues(alpha: 0.2),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: ratio,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today\'s Progress',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${(ratio * 100).round()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoalItemCard(DailyGoal goal) {
    final isDone = goal.isCompleted;
    final isClaimed = goal.isClaimed;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.glassOf(context).copyWith(
        border: Border.all(
          color: goal.isBonus
              ? AppTheme.duoViolet
              : isDone
                  ? AppTheme.duoGreen.withValues(alpha: 0.6)
                  : context.colors.outline,
          width: goal.isBonus || isDone ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (isDone ? AppTheme.duoGreen : AppTheme.duoOrange)
                      .withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  goal.icon,
                  color: isDone ? AppTheme.duoGreen : AppTheme.duoOrange,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (goal.isBonus) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.duoViolet.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'INFINITE BONUS',
                              style: TextStyle(
                                color: AppTheme.duoViolet,
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                        ],
                        Expanded(
                          child: Text(
                            goal.title,
                            style: TextStyle(
                              color: context.colors.textPrimary,
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      goal.description,
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // XP Reward Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.duoYellow.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.duoYellow.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(LucideIcons.zap,
                        color: AppTheme.duoYellow, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '+${goal.rewardXp}',
                      style: TextStyle(
                        color: AppTheme.duoYellow,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Progress Bar & Claim Button
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        height: 8,
                        color: context.colors.surfaceAlt,
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: goal.progressRatio,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isDone
                                    ? [
                                        AppTheme.duoGreen,
                                        const Color(0xFF10B981)
                                      ]
                                    : [
                                        AppTheme.duoOrange,
                                        const Color(0xFFFF8C00)
                                      ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${goal.current} / ${goal.target}',
                      style: TextStyle(
                        color: context.colors.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              if (isDone)
                isClaimed
                    ? Row(
                        children: const [
                          Icon(LucideIcons.checkCircle2,
                              color: AppTheme.duoGreen, size: 18),
                          SizedBox(width: 4),
                          Text(
                            'Claimed',
                            style: TextStyle(
                              color: AppTheme.duoGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    : DuoButton(
                        text: 'Claim',
                        color: AppTheme.duoGreen,
                        shadowColor: AppTheme.duoGreenDark,
                        onPressed: () => _claimReward(goal),
                      ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfiniteBonusBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.duoViolet.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.duoViolet.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.sparkles, color: AppTheme.duoViolet, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Infinite Mode Unlocked! Completing goals dynamically generates new infinite bonus challenges.',
              style: TextStyle(
                color: context.colors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllTimeStatsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.glassOf(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.trophy, color: AppTheme.duoYellow, size: 18),
              const SizedBox(width: 8),
              Text(
                'All-Time Daily Goal Achievements',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildStatMiniTile(
                  label: 'Goals Completed',
                  value: '${_allTimeStats['completed'] ?? 0}',
                  icon: LucideIcons.checkCheck,
                  accentColor: AppTheme.duoGreen,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildStatMiniTile(
                  label: 'Bonus XP Earned',
                  value: '${_allTimeStats['xpEarned'] ?? 0}',
                  icon: LucideIcons.zap,
                  accentColor: AppTheme.duoYellow,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatMiniTile({
    required String label,
    required String value,
    required IconData icon,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colors.surfaceAlt,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accentColor, size: 18),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: context.colors.textFaint,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
