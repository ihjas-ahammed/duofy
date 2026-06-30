import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/progress_service.dart';
import '../utils/progress_utils.dart';
import 'main_layout_screen.dart';

class SectionSelectionScreen extends StatefulWidget {
  final Book book;
  final int moduleIdx;
  final Module module;

  const SectionSelectionScreen({
    super.key,
    required this.book,
    required this.moduleIdx,
    required this.module,
  });

  @override
  State<SectionSelectionScreen> createState() => _SectionSelectionScreenState();
}

class _SectionSelectionScreenState extends State<SectionSelectionScreen> {
  List<String> _completedLessons = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    try {
      final completed = await ProgressService.getCompletedLessons();
      if (mounted) {
        setState(() {
          _completedLessons = completed;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Select Section', style: TextStyle(fontWeight: FontWeight.w900)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.duoBlue))
          : SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Module Header Info
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.02),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MODULE ${widget.moduleIdx + 1}',
                            style: const TextStyle(
                              color: AppTheme.duoBlue,
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.module.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.module.description,
                            style: const TextStyle(color: Colors.white54, fontSize: 13, height: 1.4),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      'SECTIONS IN THIS MODULE',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Section Cards List
                    widget.module.sections.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: Text('No sections generated yet.', style: TextStyle(color: Colors.white38)),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.module.sections.length,
                            itemBuilder: (context, index) {
                              final section = widget.module.sections[index];
                              final Color sectionColor = SectionColors.base(section.color);

                              // Calculate progress for this section
                              int totalLessons = 0;
                              int completedCount = 0;
                              for (final unit in section.units) {
                                totalLessons += unit.lessons.length;
                                for (final lesson in unit.lessons) {
                                  if (_completedLessons.contains(lesson.id)) {
                                    completedCount++;
                                  }
                                }
                              }

                              final progress = totalLessons > 0 ? (completedCount / totalLessons) : 0.0;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.03),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white10),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => MainLayoutScreen(
                                          book: widget.book,
                                          initialModuleIdx: widget.moduleIdx,
                                          initialSectionIdx: index,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 12,
                                              height: 12,
                                              decoration: BoxDecoration(
                                                color: sectionColor,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: sectionColor.withValues(alpha: 0.4),
                                                    blurRadius: 8,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                section.title,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ),
                                            if (progress >= 1.0)
                                              const Icon(LucideIcons.checkCircle2, color: AppTheme.duoGreen, size: 20),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          section.description,
                                          style: const TextStyle(color: Colors.white54, fontSize: 12, height: 1.4),
                                        ),

                                        // Display units inside the section (so the user knows there are multiple units!)
                                        if (section.units.isNotEmpty) ...[
                                          const SizedBox(height: 16),
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: Colors.black12,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'UNITS IN THIS SECTION:',
                                                  style: TextStyle(
                                                    color: Colors.white30,
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.w900,
                                                    letterSpacing: 1.1,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                ...section.units.map((unit) {
                                                  final unitProgress = unit.lessons.isEmpty
                                                      ? 0.0
                                                      : (unit.lessons.where((l) => _completedLessons.contains(l.id)).length / unit.lessons.length);
                                                  return Padding(
                                                    padding: const EdgeInsets.only(bottom: 6),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          unitProgress >= 1.0 ? LucideIcons.checkCircle2 : LucideIcons.circle,
                                                          color: unitProgress >= 1.0 ? AppTheme.duoGreen : Colors.white24,
                                                          size: 14,
                                                        ),
                                                        const SizedBox(width: 8),
                                                        Expanded(
                                                          child: Text(
                                                            unit.title,
                                                            style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                              ],
                                            ),
                                          ),
                                        ],

                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${section.units.length} Units • $totalLessons Lessons',
                                              style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '${(progress * 100).toInt()}% Done',
                                              style: TextStyle(
                                                color: progress >= 1.0 ? AppTheme.duoGreen : Colors.white70,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
