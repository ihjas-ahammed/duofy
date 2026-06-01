import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import 'module_summary_detail_screen.dart';

class SummaryScreen extends StatelessWidget {
  final Book book;

  const SummaryScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    // -------------------------------------------------------------
    // Extract statistics and theory slides
    // -------------------------------------------------------------
    int moduleCount = book.modules.length;
    int lessonCount = 0;
    int practiceQuestionsCount = 0;
    List<Slide> theorySlides = [];

    // Count practice questions directly attached to modules
    for (var m in book.modules) {
      practiceQuestionsCount += m.practiceQuestions.length;
    }

    // Traverse structure to find lessons, theory slides, and interactive slides
    for (var module in book.modules) {
      for (var section in module.sections) {
        for (var unit in section.units) {
          lessonCount += unit.lessons.length;
          for (var lesson in unit.lessons) {
            for (var slide in lesson.slides) {
              if (slide.type == 'theory') {
                theorySlides.add(slide);
              } else {
                practiceQuestionsCount++;
              }
            }
          }
        }
      }
    }

    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // App Bar Title
            SliverAppBar(
              title: const Text(
                'Course Summary',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
              ),
              automaticallyImplyLeading: false,
              floating: true,
              backgroundColor: AppTheme.background.withOpacity(0.8),
            ),
            
            // Statistics Dashboard Grid
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isDesktop ? 4 : 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: isDesktop ? 2.0 : 1.4,
                ),
                delegate: SliverChildListDelegate([
                  _buildStatCard(
                    title: 'Modules',
                    value: '$moduleCount',
                    icon: LucideIcons.bookOpen,
                    color: AppTheme.duoBlue,
                  ),
                  _buildStatCard(
                    title: 'Lessons',
                    value: '$lessonCount',
                    icon: LucideIcons.compass,
                    color: AppTheme.duoViolet,
                  ),
                  _buildStatCard(
                    title: 'Key Concepts',
                    value: '${theorySlides.length}',
                    icon: LucideIcons.sparkles,
                    color: AppTheme.duoOrange,
                  ),
                  _buildStatCard(
                    title: 'Practice Items',
                    value: '$practiceQuestionsCount',
                    icon: LucideIcons.dumbbell,
                    color: AppTheme.duoGreen,
                  ),
                ]),
              ),
            ),

            // Section Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Module Breakdown'.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                    letterSpacing: 1.2,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),

            // Collapsible Module Summaries list
            book.modules.isEmpty
                ? const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        'No content available to summarize.',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 100),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final module = book.modules[index];
                          return _buildModuleSummaryCard(context, module);
                        },
                        childCount: book.modules.length,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: AppTheme.glassDecoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 4,
              child: Container(color: color),
            ),
            Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: const EdgeInsets.only(left: 18, top: 14, right: 14, bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 11,
                              letterSpacing: 0.5,
                              color: Colors.white54,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(icon, color: color, size: 20),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      value,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleSummaryCard(BuildContext context, Module module) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: AppTheme.glassDecoration,
      clipBehavior: Clip.antiAlias,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ModuleSummaryDetailScreen(module: module),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        module.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        module.description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white54,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(
                  LucideIcons.chevronRight,
                  color: Colors.white70,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
