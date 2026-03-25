import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';

class QpCard extends StatelessWidget {
  final QuestionPaper qp;
  final VoidCallback onTap;

  const QpCard({super.key, required this.qp, required this.onTap});

  @override
  Widget build(BuildContext context) {
    int totalQuestions = qp.sections.fold<int>(0, (sum, sec) => sum + sec.questions.length);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.duoBlue.withOpacity(0.3), width: 2),
          boxShadow: [
            BoxShadow(
              color: AppTheme.duoBlue.withOpacity(0.1),
              offset: const Offset(0, 4),
              blurRadius: 10,
            )
          ]
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.duoBlue.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.fileSignature, size: 24, color: AppTheme.duoBlue),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    qp.title,
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$totalQuestions Solved Questions',
                    style: const TextStyle(fontSize: 12, color: Colors.white54, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Icon(LucideIcons.chevronRight, color: AppTheme.duoBlue.withOpacity(0.5))
          ],
        ),
      ),
    );
  }
}