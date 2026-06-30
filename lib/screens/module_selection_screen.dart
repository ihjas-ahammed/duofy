import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/progress_service.dart';
import 'section_selection_screen.dart';
import 'main_layout_screen.dart';

class ModuleSelectionScreen extends StatefulWidget {
  final Book book;

  const ModuleSelectionScreen({super.key, required this.book});

  @override
  State<ModuleSelectionScreen> createState() => _ModuleSelectionScreenState();
}

class _ModuleSelectionScreenState extends State<ModuleSelectionScreen> {
  List<String> _completedLessons = [];
  bool _isLoading = true;
  String? _lastLessonTitle;
  int? _lastModIdx;
  int? _lastSecIdx;

  @override
  void initState() {
    super.initState();
    _loadProgress();
    _loadLastLessonInfo();
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

  Future<void> _loadLastLessonInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lessonId = prefs.getString('last_lesson_id_${widget.book.id}');
      final modIdx = prefs.getInt('last_mod_idx_${widget.book.id}');
      final secIdx = prefs.getInt('last_sec_idx_${widget.book.id}');

      if (lessonId != null && modIdx != null && secIdx != null) {
        if (modIdx >= 0 && modIdx < widget.book.modules.length) {
          final module = widget.book.modules[modIdx];
          if (secIdx >= 0 && secIdx < module.sections.length) {
            final section = module.sections[secIdx];
            for (final unit in section.units) {
              for (final lesson in unit.lessons) {
                if (lesson.id == lessonId) {
                  if (mounted) {
                    setState(() {
                      _lastLessonTitle = lesson.title;
                      _lastModIdx = modIdx;
                      _lastSecIdx = secIdx;
                    });
                  }
                  return;
                }
              }
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error loading last lesson info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Select Module', style: TextStyle(fontWeight: FontWeight.w900)),
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
                    // Book Hero Header
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppTheme.duoBlue.withValues(alpha: 0.15), Colors.transparent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppTheme.duoBlue,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.duoBlue.withValues(alpha: 0.3),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const Icon(LucideIcons.bookOpen, color: Colors.white, size: 30),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.book.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.book.description,
                                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Resume Learning Card
                    if (_lastLessonTitle != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.duoGreen.withValues(alpha: 0.15),
                              AppTheme.duoGreen.withValues(alpha: 0.02),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppTheme.duoGreen.withValues(alpha: 0.3)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MainLayoutScreen(
                                    book: widget.book,
                                    initialModuleIdx: _lastModIdx,
                                    initialSectionIdx: _lastSecIdx,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: AppTheme.duoGreen.withValues(alpha: 0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(LucideIcons.play, color: AppTheme.duoGreen, size: 20),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'RESUME LEARNING',
                                          style: TextStyle(
                                            color: AppTheme.duoGreen,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          _lastLessonTitle!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Module ${_lastModIdx! + 1} • Section ${_lastSecIdx! + 1}',
                                          style: const TextStyle(
                                            color: Colors.white38,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(LucideIcons.chevronRight, color: Colors.white30, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),

                    const Text(
                      'COURSE MODULES',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Module Cards List
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.book.modules.length,
                      itemBuilder: (context, index) {
                        final module = widget.book.modules[index];

                        // Calculate totals
                        int totalLessons = 0;
                        int completedCount = 0;
                        int totalUnits = 0;
                        for (final sec in module.sections) {
                          totalUnits += sec.units.length;
                          for (final unit in sec.units) {
                            totalLessons += unit.lessons.length;
                            for (final lesson in unit.lessons) {
                              if (_completedLessons.contains(lesson.id)) {
                                completedCount++;
                              }
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
                                  builder: (_) => SectionSelectionScreen(
                                    book: widget.book,
                                    moduleIdx: index,
                                    module: module,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: AppTheme.duoBlue.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          'MODULE ${index + 1}',
                                          style: const TextStyle(
                                            color: AppTheme.duoBlue,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${module.sections.length} Sections • $totalUnits Units',
                                        style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    module.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    module.description,
                                    style: const TextStyle(color: Colors.white54, fontSize: 12, height: 1.4),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 20),

                                  // Progress Bar
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(6),
                                          child: LinearProgressIndicator(
                                            value: progress,
                                            backgroundColor: Colors.white10,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              progress >= 1.0 ? AppTheme.duoGreen : AppTheme.duoBlue,
                                            ),
                                            minHeight: 6,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        '${(progress * 100).toInt()}%',
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
