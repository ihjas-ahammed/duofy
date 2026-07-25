import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../models/pyq_models.dart';
import '../services/pyq_exam_service.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/math_markdown.dart';
import 'pyq_exam_screen.dart';

class PyqScoreHistoryScreen extends StatefulWidget {
  final Book book;

  const PyqScoreHistoryScreen({
    super.key,
    required this.book,
  });

  @override
  State<PyqScoreHistoryScreen> createState() => _PyqScoreHistoryScreenState();
}

class _PyqScoreHistoryScreenState extends State<PyqScoreHistoryScreen> {
  List<PyqExamAttempt> _attempts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final list = await PyqExamService.instance.getScoreHistory(widget.book.id);
    if (mounted) {
      setState(() {
        _attempts = list;
        _isLoading = false;
      });
    }
  }

  void _openDetail(PyqExamAttempt attempt) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PyqExamDetailScreen(book: widget.book, attempt: attempt),
      ),
    );
  }

  String _formatDate(int epochMs) {
    final dt = DateTime.fromMillisecondsSinceEpoch(epochMs);
    final hour = dt.hour == 0 ? 12 : (dt.hour > 12 ? dt.hour - 12 : dt.hour);
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    final min = dt.minute.toString().padLeft(2, '0');
    return '${dt.month}/${dt.day}/${dt.year} at $hour:$min $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        title: const Text(
          'Exam Score History',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.duoBlue))
          : _attempts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LucideIcons.trophy, size: 48, color: context.colors.textFaint),
                      const SizedBox(height: 12),
                      Text(
                        'No exam attempts yet',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: context.colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Tap the Play button on Extracted Questions to take your first exam!',
                        style: TextStyle(fontSize: 12, color: context.colors.textFaint),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _attempts.length,
                  itemBuilder: (ctx, i) {
                    final att = _attempts[i];
                    final pct = att.percentage.round();
                    final color = pct >= 80
                        ? AppTheme.duoGreen
                        : pct >= 50
                            ? AppTheme.duoOrange
                            : AppTheme.duoRed;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: context.colors.outline),
                      ),
                      child: ListTile(
                        onTap: () => _openDetail(att),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '$pct%',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: color,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          'Score: ${att.totalScore.toStringAsFixed(1)} / ${att.maxScore.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: context.colors.textPrimary,
                          ),
                        ),
                        subtitle: Text(
                          _formatDate(att.timestamp),
                          style: TextStyle(fontSize: 12, color: context.colors.textFaint),
                        ),
                        trailing: const Icon(LucideIcons.chevronRight, size: 20),
                      ),
                    );
                  },
                ),
    );
  }
}

class PyqExamDetailScreen extends StatelessWidget {
  final Book book;
  final PyqExamAttempt attempt;

  const PyqExamDetailScreen({
    super.key,
    required this.book,
    required this.attempt,
  });

  void _retakeExam(BuildContext context) async {
    final bank = await PyqExamService.instance.getPyqBank(book);
    final questionMap = {for (final q in bank) q.id: q};
    final retakeQuestions = <PyqItem>[];

    for (final ans in attempt.answers) {
      if (questionMap.containsKey(ans.questionId)) {
        retakeQuestions.add(questionMap[ans.questionId]!);
      } else {
        retakeQuestions.add(PyqItem(
          id: ans.questionId,
          title: ans.questionTitle,
          content: ans.content,
          marks: ans.marks,
        ));
      }
    }

    if (!context.mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PyqExamScreen(
          book: book,
          questions: retakeQuestions,
          selectedModuleIds: attempt.moduleIds,
          maxExamScore: attempt.maxScore,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pct = attempt.percentage.round();
    final color = pct >= 80
        ? AppTheme.duoGreen
        : pct >= 50
            ? AppTheme.duoOrange
            : AppTheme.duoRed;

    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        title: const Text(
          'Exam Evaluation Result',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Text(
                      'TOTAL SCORE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: color,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${attempt.totalScore.toStringAsFixed(1)} / ${attempt.maxScore.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: context.colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$pct% Accuracy',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ...attempt.answers.map((ans) => _buildAnswerCard(context, ans)),
              const SizedBox(height: 20),
              DuoButton(
                text: 'RETAKE THIS EXAM',
                color: AppTheme.duoBlue,
                shadowColor: AppTheme.duoBlueDark,
                onPressed: () => _retakeExam(context),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerCard(BuildContext context, PyqQuestionAnswer ans) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: MathMarkdown(
                  data: ans.questionTitle,
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.duoBlue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${ans.aiScore.toStringAsFixed(1)} / ${ans.marks}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.duoBlue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'STUDENT RESPONSE:',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: AppTheme.duoViolet,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ans.textAnswer.isEmpty ? '(No text response provided)' : ans.textAnswer,
            style: TextStyle(
              fontSize: 13,
              color: context.colors.textSecondary,
              height: 1.4,
            ),
          ),
          if (ans.imagePaths.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ans.imagePaths.map((path) {
                final file = File(path);
                if (!file.existsSync()) return const SizedBox.shrink();
                return ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.file(file, width: 60, height: 60, fit: BoxFit.cover),
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.colors.surfaceAlt,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.colors.outline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AI FEEDBACK:',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.duoGreen,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ans.aiFeedback.isNotEmpty ? ans.aiFeedback : 'No feedback available.',
                  style: TextStyle(fontSize: 13, color: context.colors.textPrimary, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
