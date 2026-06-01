import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/math_markdown.dart';

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
    // Gather all theory slides for this module to show under "Key Notes"
    List<Slide> moduleTheorySlides = [];
    for (var section in module.sections) {
      for (var unit in section.units) {
        for (var lesson in unit.lessons) {
          for (var slide in lesson.slides) {
            if (slide.type == 'theory') {
              moduleTheorySlides.add(slide);
            }
          }
        }
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: AppTheme.glassDecoration,
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: ExpansionTile(
          collapsedIconColor: Colors.white70,
          iconColor: AppTheme.duoBlue,
          title: Text(
            module.title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              module.description,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white54,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          childrenPadding: const EdgeInsets.all(16),
          children: [
            Container(
              height: 1,
              color: Colors.white.withOpacity(0.08),
              margin: const EdgeInsets.only(bottom: 16),
            ),
            
            // Sub-sections outline
            if (module.sections.isNotEmpty) ...[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'COURSE OUTLINE',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 11,
                    letterSpacing: 0.8,
                    color: AppTheme.duoBlue,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ...module.sections.map((sec) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8, left: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Icon(LucideIcons.arrowRight, size: 12, color: Colors.white30),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sec.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                            if (sec.description.isNotEmpty)
                              Text(
                                sec.description,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white54,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),
            ],

            // Module theory notes
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'CORE CONCEPTS SUMMARY',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                  letterSpacing: 0.8,
                  color: AppTheme.duoViolet,
                ),
              ),
            ),
            const SizedBox(height: 12),
            moduleTheorySlides.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'No key concept notes generated for this module yet.',
                      style: TextStyle(color: Colors.white38, fontSize: 13, fontStyle: FontStyle.italic),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: moduleTheorySlides.length,
                    itemBuilder: (context, idx) {
                      final slide = moduleTheorySlides[idx];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.02),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withOpacity(0.04)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(LucideIcons.sparkles, color: AppTheme.duoViolet, size: 14),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    slide.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: AppTheme.duoViolet,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            MathMarkdown(
                              data: slide.content,
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
