import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/generation_manager.dart';
import '../widgets/qp_card.dart';
import '../widgets/responsive_center.dart';
import 'generate_qp_screen.dart';
import 'qp_detail_screen.dart';

class ExamScreen extends StatelessWidget {
  final Book book;

  const ExamScreen({super.key, required this.book});

  void _openQp(BuildContext context, QuestionPaper qp) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => QpDetailScreen(qp: qp)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: GenerationManager.instance,
      builder: (context, _) {
        final qpTask = GenerationManager.instance.activeQpTasks[book.id];
        final qps = book.questionPapers;

        return Scaffold(
          body: ResponsiveCenter(
            child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                title: const Text('Exams', style: TextStyle(fontWeight: FontWeight.w900)),
                automaticallyImplyLeading: false,
                floating: true,
                backgroundColor: AppTheme.background,
              ),
              
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

              const SliverToBoxAdapter(child: SizedBox(height: 120)), // Nav bar padding
            ],
          ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: FloatingActionButton.extended(
              heroTag: 'exam_fab',
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