import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/responsive_center.dart';
import '../widgets/math_markdown.dart';

class PyqCompleteScreen extends StatelessWidget {
  final List<Map<String, dynamic>> gradedResults;
  final int timeSpentSeconds;
  final int xpEarned;

  const PyqCompleteScreen({
    super.key,
    required this.gradedResults,
    required this.timeSpentSeconds,
    required this.xpEarned,
  });

  String _formatDuration(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    if (m > 0) return '${m}m ${s}s';
    return '${s}s';
  }

  @override
  Widget build(BuildContext context) {
    final correctCount = gradedResults.where((r) => r['isCorrect'] == true).length;
    final totalCount = gradedResults.length;
    final accuracy = totalCount > 0 ? ((correctCount / totalCount) * 100).round() : 100;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: ResponsiveCenter(
        maxWidth: ResponsiveMaxWidth.reading,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      
                      // Celebration Icon
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppTheme.duoGreen.withOpacity(0.15),
                            shape: BoxShape.circle,
                            border: Border.all(color: AppTheme.duoGreen.withOpacity(0.3), width: 3),
                          ),
                          child: const Icon(
                            LucideIcons.partyPopper,
                            size: 50,
                            color: AppTheme.duoGreen,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      const Center(
                        child: Text(
                          'Session Complete!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Quick Stats Grid
                      Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              icon: LucideIcons.zap,
                              iconColor: Colors.amber,
                              value: '+$xpEarned',
                              label: 'XP EARNED',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _StatCard(
                              icon: LucideIcons.target,
                              iconColor: AppTheme.duoBlue,
                              value: '$accuracy%',
                              label: 'ACCURACY',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _StatCard(
                              icon: LucideIcons.clock,
                              iconColor: AppTheme.duoViolet,
                              value: _formatDuration(timeSpentSeconds),
                              label: 'TIME SPENT',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      const Text(
                        'GRADED PYQ RESULTS',
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),

                      if (totalCount == 0)
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: AppTheme.glassDecoration,
                          child: const Center(
                            child: Text(
                              'Only interactive proofs were practiced in this session. They were graded step-by-step.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white54, fontSize: 13),
                            ),
                          ),
                        )
                      else
                        ...gradedResults.map((result) {
                          final isCorrect = result['isCorrect'] == true;
                          final borderCol = isCorrect ? AppTheme.duoGreen : AppTheme.duoRed;
                          final bgCol = isCorrect ? AppTheme.duoGreen.withOpacity(0.06) : AppTheme.duoRed.withOpacity(0.06);

                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: bgCol,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: borderCol.withOpacity(0.3), width: 1.5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      isCorrect ? LucideIcons.checkCircle2 : LucideIcons.xCircle,
                                      color: borderCol,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: MathMarkdown(
                                        data: result['question'] ?? 'Question',
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                const Divider(color: Colors.white10, height: 1),
                                const SizedBox(height: 12),
                                
                                // User Answer
                                Row(
                                  children: [
                                    const Text(
                                      'Your Answer: ',
                                      style: TextStyle(color: Colors.white38, fontSize: 12),
                                    ),
                                    Expanded(
                                      child: Text(
                                        result['userAnswer']?.toString().isNotEmpty == true
                                            ? result['userAnswer']
                                            : '[No Answer]',
                                        style: TextStyle(
                                          color: isCorrect ? AppTheme.duoGreen : AppTheme.duoRed,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                
                                // Correct Answer
                                Row(
                                  children: [
                                    const Text(
                                      'Correct Answer: ',
                                      style: TextStyle(color: Colors.white38, fontSize: 12),
                                    ),
                                    Expanded(
                                      child: Text(
                                        result['correctAnswer'] ?? '',
                                        style: const TextStyle(
                                          color: AppTheme.duoGreen,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                
                                // AI Explanation
                                if (result['explanation'] != null && result['explanation'].toString().isNotEmpty) ...[
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.04),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      result['explanation'],
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                        height: 1.35,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          );
                        }),
                    ],
                  ),
                ),
              ),

              // Bottom Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: DuoButton(
                  text: 'Continue',
                  color: AppTheme.duoBlue,
                  shadowColor: AppTheme.duoBlueDark,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: AppTheme.glassDecoration,
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
