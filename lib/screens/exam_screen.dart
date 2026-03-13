import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/math_markdown.dart';

class ExamScreen extends StatelessWidget {
  final Book book;

  const ExamScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    // Gather exam questions from all modules
    List<Slide> examQuestions = [];
    for (var module in book.modules) {
      examQuestions.addAll(module.examQuestions);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Reference', style: TextStyle(fontWeight: FontWeight.w900)),
        automaticallyImplyLeading: false,
      ),
      body: examQuestions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.bookOpenCheck, size: 80, color: AppTheme.duoGreen.withOpacity(0.5)),
                  const SizedBox(height: 24),
                  const Text(
                    'No Exam Questions Found',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 120), // Padding for bottom nav
              itemCount: examQuestions.length,
              itemBuilder: (context, index) {
                final q = examQuestions[index];

                String answerText = '';
                if (q.type == 'quiz') {
                  final correctOpt = q.options?.firstWhere((o) => o.isCorrect, orElse: () => q.options!.first);
                  answerText = r'**Answer:** ' + (correctOpt?.text ?? '') + r'\n\n*Explanation:* ' + (correctOpt?.explanation ?? '');
                } else if (q.type == 'fill_in_blank') {
                  answerText = r'**Answer:** $$' + (q.blankAnswer ?? '') + r'$$';
                } else if (q.type == 'numerical') {
                  answerText = r'**Answer:** ' + (q.numericAnswer?.toString() ?? '');
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: AppTheme.glassDecoration.copyWith(
                    border: Border.all(color: AppTheme.duoOrange.withOpacity(0.3), width: 2),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      iconColor: AppTheme.duoOrange,
                      collapsedIconColor: Colors.white54,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            q.title.toUpperCase(),
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppTheme.duoOrange, letterSpacing: 1.2),
                          ),
                          const SizedBox(height: 8),
                          MathMarkdown(data: q.content, textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                        ],
                      ),
                      childrenPadding: const EdgeInsets.all(20),
                      expandedAlignment: Alignment.centerLeft,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.duoOrange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppTheme.duoOrange.withOpacity(0.5)),
                          ),
                          child: MathMarkdown(
                            data: answerText,
                            textStyle: const TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}