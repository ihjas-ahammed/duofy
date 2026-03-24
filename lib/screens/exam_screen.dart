import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/generation_manager.dart';
import '../widgets/math_markdown.dart';
import '../widgets/qp_card.dart';
import 'lesson_screen.dart';
import 'generate_qp_screen.dart';

class ExamScreen extends StatelessWidget {
  final Book book;

  const ExamScreen({super.key, required this.book});

  void _openQp(BuildContext context, QuestionPaper qp) {
    final dummyLesson = Lesson(
      id: qp.id,
      title: qp.title,
      description: 'Solved Question Paper',
      icon: 'FileQuestion',
      slides: qp.slides,
    );

    Navigator.push(context, MaterialPageRoute(builder: (_) => LessonScreen(lesson: dummyLesson)));
  }

  @override
  Widget build(BuildContext context) {
    // Gather exam questions from all modules
    List<Slide> moduleExamQuestions = [];
    for (var module in book.modules) {
      moduleExamQuestions.addAll(module.examQuestions);
    }

    return AnimatedBuilder(
      animation: GenerationManager.instance,
      builder: (context, _) {
        final qpTask = GenerationManager.instance.activeQpTasks[book.id];
        final qps = book.questionPapers;

        return Scaffold(
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                title: const Text('Exams', style: TextStyle(fontWeight: FontWeight.w900)),
                automaticallyImplyLeading: false,
                floating: true,
                backgroundColor: AppTheme.background,
              ),
              
              // === PAST PAPERS SECTION ===
              const SliverPadding(
                padding: EdgeInsets.only(top: 16, left: 24, bottom: 8),
                sliver: SliverToBoxAdapter(
                  child: Text('Past Exam Papers', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white)),
                ),
              ),

              if (qpTask != null)
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: AppTheme.glassDecoration.copyWith(
                      border: Border.all(color: qpTask.isError ? AppTheme.duoRed : AppTheme.duoBlue, width: 2)
                    ),
                    child: Row(
                      children: [
                        if (qpTask.isError)
                          const Icon(LucideIcons.alertTriangle, color: AppTheme.duoRed, size: 24)
                        else
                          const SizedBox(
                            width: 24, height: 24, 
                            child: CircularProgressIndicator(color: AppTheme.duoBlue, strokeWidth: 3)
                          ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            qpTask.status, 
                            style: TextStyle(fontWeight: FontWeight.bold, color: qpTask.isError ? AppTheme.duoRed : Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ),
                        if (qpTask.isError)
                          IconButton(
                            icon: const Icon(LucideIcons.x, color: Colors.white54),
                            onPressed: () => GenerationManager.instance.clearQpError(book.id),
                          )
                      ],
                    ),
                  ),
                ),

              if (qps.isEmpty && qpTask == null)
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        Icon(LucideIcons.fileQuestion, size: 40, color: AppTheme.duoBlue.withOpacity(0.5)),
                        const SizedBox(height: 16),
                        const Text('No Past Papers', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white54)),
                        const SizedBox(height: 8),
                        const Text('Upload past exams to solve interactively.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.white38)),
                      ],
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: QpCard(qp: qps[index], onTap: () => _openQp(context, qps[index])),
                        );
                      },
                      childCount: qps.length,
                    ),
                  ),
                ),

              // === MODULE EXAMS SECTION ===
              const SliverPadding(
                padding: EdgeInsets.only(top: 32, left: 24, bottom: 8),
                sliver: SliverToBoxAdapter(
                  child: Text('Module Exam Questions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white)),
                ),
              ),

              if (moduleExamQuestions.isEmpty)
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        Icon(LucideIcons.bookOpenCheck, size: 40, color: AppTheme.duoOrange.withOpacity(0.5)),
                        const SizedBox(height: 16),
                        const Text('No Module Exams Found', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white54)),
                      ],
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final q = moduleExamQuestions[index];

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
                          margin: const EdgeInsets.only(bottom: 12),
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
                                  MathMarkdown(data: q.content, textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                                ],
                              ),
                              childrenPadding: const EdgeInsets.all(16),
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
                                    textStyle: const TextStyle(fontSize: 14, color: Colors.white, height: 1.5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: moduleExamQuestions.length,
                    ),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 120)), // Nav bar padding
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: FloatingActionButton.extended(
              backgroundColor: AppTheme.duoBlue,
              icon: const Icon(LucideIcons.plus, color: Colors.white),
              label: const Text('Add Paper', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => GenerateQpScreen(book: book)));
              },
            ),
          ),
        );
      }
    );
  }
}