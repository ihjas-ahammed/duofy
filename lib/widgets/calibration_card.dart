import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../services/metacognition_service.dart';
import '../theme/app_theme.dart';

/// Analytics card comparing self-rated confidence with actual accuracy —
/// the visible half of the metacognitive loop. Hidden until the learner has
/// rated at least a handful of answers.
class CalibrationCard extends StatelessWidget {
  const CalibrationCard({super.key});

  Widget _bar(
    BuildContext context,
    String label,
    double? accuracy,
    Color color,
  ) {
    final pct = accuracy == null ? null : (accuracy * 100).round();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 76,
            child: Text(
              label,
              style: TextStyle(
                color: context.colors.textFaint,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: accuracy ?? 0,
                minHeight: 10,
                backgroundColor: context.colors.surfaceAlt,
                valueColor: AlwaysStoppedAnimation(
                  accuracy == null ? context.colors.outline : color,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 44,
            child: Text(
              pct == null ? '—' : '$pct%',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CalibrationStats>(
      future: MetacognitionService.calibrationStats(),
      builder: (context, snap) {
        final stats = snap.data;
        if (stats == null || stats.ratedTotal < 5) {
          return const SizedBox.shrink();
        }
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: context.colors.outline,
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFBBF24),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'CALIBRATION — CONFIDENCE VS ACCURACY',
                      style: TextStyle(
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                        letterSpacing: 0.6,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    LucideIcons.brainCircuit,
                    color: context.colors.textFaint,
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: 18),
                  _bar(
                    context,
                    'SURE',
                    stats.confidentAccuracy,
                    AppTheme.duoGreen,
                  ),
                  _bar(
                    context,
                    'UNSURE',
                    stats.unsureAccuracy,
                    AppTheme.duoBlue,
                  ),
                  _bar(
                    context,
                    'GUESSING',
                    stats.guessingAccuracy,
                    AppTheme.duoOrange,
                  ),
                  if (stats.insight != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          LucideIcons.lightbulb,
                          color: Color(0xFFFBBF24),
                          size: 15,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            stats.insight!,
                            style: TextStyle(
                              color: context.colors.textSecondary,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          },
        );
      }
}