import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/math_markdown.dart';
import '../widgets/responsive_center.dart';

class QpDetailScreen extends StatelessWidget {
  final QuestionPaper qp;

  const QpDetailScreen({super.key, required this.qp});

  Widget _buildQuestionCard(BuildContext context, QpQuestion q, int sIdx, int qIdx) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
      decoration: AppTheme.glassOf(context).copyWith(
        border: Border.all(color: AppTheme.duoBlue.withOpacity(0.3), width: 2),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: AppTheme.duoOrange,
          collapsedIconColor: context.colors.textFaint,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          childrenPadding: const EdgeInsets.all(16),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(LucideIcons.helpCircle, size: 16, color: AppTheme.duoBlue),
                  const SizedBox(width: 8),
                  Text(
                    'QUESTION ${qIdx + 1}',
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppTheme.duoBlue, letterSpacing: 1.2),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              MathMarkdown(data: q.questionText, textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: context.colors.textPrimary)),
            ],
          ),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.duoOrange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.duoOrange.withOpacity(0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(LucideIcons.lightbulb, size: 16, color: AppTheme.duoOrange),
                      const SizedBox(width: 8),
                      Text(
                        'SOLUTION',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppTheme.duoOrange.withOpacity(0.8), letterSpacing: 1.2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  MathMarkdown(
                    data: q.solutionText,
                    textStyle: TextStyle(fontSize: 15, color: context.colors.textPrimary, height: 1.5),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveCenter(
        child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text(
              qp.title, 
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
            ),
            backgroundColor: context.colors.background,
          ),
          if (qp.sections.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Text('No questions found in this paper.', style: TextStyle(color: context.colors.textFaint)),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, sIdx) {
                  final section = qp.sections[sIdx];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                        child: Text(
                          section.title.toUpperCase(),
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppTheme.duoOrange, letterSpacing: 1.2),
                        ),
                      ),
                      ...section.questions.asMap().entries.map((entry) {
                        return _buildQuestionCard(context, entry.value, sIdx, entry.key);
                      }),
                      if (sIdx == qp.sections.length - 1)
                        const SizedBox(height: 80),
                    ],
                  );
                },
                childCount: qp.sections.length,
              ),
            ),
        ],
      ),
      ),
    );
  }
}