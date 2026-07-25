import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import '../services/bookmark_service.dart';
import '../theme/app_theme.dart';
import '../services/progress_service.dart';
import 'dart:ui';
import 'dart:async';
import '../services/global_state.dart';
import '../services/generation_manager.dart';
import '../utils/progress_utils.dart';
import 'pyq_panel_screen.dart';
import 'section_selection_screen.dart';
import 'main_layout_screen.dart';
import '../services/deadline_service.dart';
import '../services/database_service.dart';
import 'lesson_screen.dart';


class ModuleSelectionScreen extends StatefulWidget {
  final Book book;

  const ModuleSelectionScreen({super.key, required this.book});

  @override
  State<ModuleSelectionScreen> createState() => _ModuleSelectionScreenState();
}

class _ModuleSelectionScreenState extends State<ModuleSelectionScreen> {
  late Book _currentBook;
  StreamSubscription<Book>? _bookUpdatesSub;
  List<String> _completedLessons = [];
  bool _isLoading = true;
  Map<String, dynamic>? _mostUrgentTarget;
  bool _targetButtonExpanded = false;
  Timer? _targetCollapseTimer;
  String? _lastLessonTitle;
  int? _lastModIdx;
  int? _lastSecIdx;

  @override
  void initState() {
    super.initState();
    _currentBook = widget.book;
    _loadProgress();
    _loadLastLessonInfo();
    _refreshBookFromStorage();
    GlobalState.progressNotifier.addListener(_loadProgress);
    GenerationManager.instance.addListener(_onGenManagerChanged);
    _bookUpdatesSub = GenerationManager.instance.bookUpdates.listen((updatedBook) {
      if (updatedBook.id == _currentBook.id && mounted) {
        _refreshBookFromStorage(updatedBook);
      }
    });
  }

  @override
  void dispose() {
    _bookUpdatesSub?.cancel();
    GenerationManager.instance.removeListener(_onGenManagerChanged);
    GlobalState.progressNotifier.removeListener(_loadProgress);
    _targetCollapseTimer?.cancel();
    super.dispose();
  }

  void _onGenManagerChanged() {
    if (mounted) {
      _refreshBookFromStorage();
    }
  }

  Future<void> _refreshBookFromStorage([Book? book]) async {
    final fresh = book ?? await DatabaseService().getBookFromCache(_currentBook.id);
    if (fresh != null && mounted) {
      setState(() {
        _currentBook = fresh;
      });
      _loadProgress();
      _loadLastLessonInfo();
    }
  }

  Future<void> _loadProgress() async {
    try {
      final completed = await ProgressService.getCompletedLessons();
      if (mounted) {
        setState(() {
          _completedLessons = completed;
        });
      }
      final urgent = await DeadlineService.instance.getMostUrgentActiveTarget(
        _currentBook.id,
        _currentBook,
        _completedLessons,
      );
      if (mounted) {
        setState(() {
          _mostUrgentTarget = urgent;
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
      final lessonId = prefs.getString('last_lesson_id_${_currentBook.id}');
      final modIdx = prefs.getInt('last_mod_idx_${_currentBook.id}');
      final secIdx = prefs.getInt('last_sec_idx_${_currentBook.id}');

      if (lessonId != null && modIdx != null && secIdx != null) {
        if (modIdx >= 0 && modIdx < _currentBook.modules.length) {
          final module = _currentBook.modules[modIdx];
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
      backgroundColor: context.colors.background,
      appBar: AppBar(
        title: Text(
          'Select Module',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.fileQuestion),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PyqPanelScreen(book: _currentBook),
                ),
              );
            },
            tooltip: 'PYQ Panel',
          ),
          IconButton(
            icon: const Icon(LucideIcons.bookmark),
            onPressed: () => _showBookmarksDialog(context),
            tooltip: 'Course Bookmarks',
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: _buildFloatingTargetButton(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.duoBlue),
            )
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
                          colors: [
                            AppTheme.duoBlue.withValues(alpha: 0.15),
                            Colors.transparent,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: context.colors.outline),
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
                                  color: AppTheme.duoBlue.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 16,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              LucideIcons.bookOpen,
                              color: context.colors.textPrimary,
                              size: 30,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.book.title,
                                  style: TextStyle(
                                    color: context.colors.textPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  widget.book.description,
                                  style: TextStyle(
                                    color: context.colors.textFaint,
                                    fontSize: 12,
                                  ),
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
                          border: Border.all(
                            color: AppTheme.duoGreen.withValues(alpha: 0.3),
                          ),
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
                                      color: AppTheme.duoGreen.withValues(
                                        alpha: 0.2,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      LucideIcons.play,
                                      color: AppTheme.duoGreen,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          style: TextStyle(
                                            color: context.colors.textPrimary,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          'Module ${_lastModIdx! + 1} • Section ${_lastSecIdx! + 1}',
                                          style: TextStyle(
                                            color: context.colors.textFaint,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    LucideIcons.chevronRight,
                                    color: context.colors.textFaint,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: 24),

                    Text(
                      'COURSE MODULES',
                      style: TextStyle(
                        color: context.colors.textFaint,
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
                      itemCount: _currentBook.modules.length,
                      itemBuilder: (context, index) {
                        final module = _currentBook.modules[index];

                        // Calculate totals
                        final progress = calculateModuleProgressDouble(module, _completedLessons);
                        final totalUnits = module.sections.fold<int>(0, (sum, sec) => sum + sec.units.length);

                        return Container(
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: context.colors.surfaceAlt,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: context.colors.outline),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SectionSelectionScreen(
                                    book: _currentBook,
                                    moduleIdx: index,
                                    module: module,
                                  ),
                                ),
                              ).then((_) => _refreshBookFromStorage());
                            },
                            onLongPress: () => _showModuleLongPressMenu(index),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppTheme.duoBlue.withValues(
                                            alpha: 0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          'MODULE ${index + 1}',
                                          style: TextStyle(
                                            color: AppTheme.duoBlue,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${module.sections.length} Sections • $totalUnits Units',
                                        style: TextStyle(
                                          color: context.colors.textFaint,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    module.title,
                                    style: TextStyle(
                                      color: context.colors.textPrimary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    module.description,
                                    style: TextStyle(
                                      color: context.colors.textFaint,
                                      fontSize: 12,
                                      height: 1.4,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 20),

                                  // Progress Bar
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          child: LinearProgressIndicator(
                                            value: progress,
                                            backgroundColor:
                                                context.colors.outline,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  progress >= 1.0
                                                      ? AppTheme.duoGreen
                                                      : AppTheme.duoBlue,
                                                ),
                                            minHeight: 6,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        '${(progress * 100).toInt()}%',
                                        style: TextStyle(
                                          color: progress >= 1.0
                                              ? AppTheme.duoGreen
                                              : context.colors.textSecondary,
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

  void _showModuleLongPressMenu(int modIdx) {
    final module = widget.book.modules[modIdx];
    int totalLessons = 0;
    int completedCount = 0;
    for (var s in module.sections) {
      for (var u in s.units) {
        for (var l in u.lessons) {
          totalLessons++;
          if (_completedLessons.contains(l.id)) {
            completedCount++;
          }
        }
      }
    }
    int incompleteCount = 0;
    if (totalLessons == 0) {
      final isCompleted = _completedLessons.contains(module.id);
      completedCount = isCompleted ? 1 : 0;
      incompleteCount = isCompleted ? 0 : 1;
    } else {
      incompleteCount = totalLessons - completedCount;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return _buildLongPressMenu(
          title: module.title,
          subtitle: 'Module Menu',
          icon: LucideIcons.package,
          color: AppTheme.duoBlue,
          items: [
            _MenuActionItem(
              icon: LucideIcons.play,
              title: 'Generate Module Contents',
              subtitle: 'Plan & generate all sections in this module now',
              iconColor: AppTheme.duoGreen,
              onTap: () {
                Navigator.pop(ctx);
                _promptGenerateOrScheduleModule(modIdx, isScheduled: false);
              },
            ),
            if (GlobalState.advancedModeNotifier.value)
              _MenuActionItem(
                icon: LucideIcons.calendar,
                title: 'Schedule Module Generation',
                subtitle: 'Queue for auto schedule hours',
                iconColor: AppTheme.duoViolet,
                onTap: () {
                  Navigator.pop(ctx);
                  _promptGenerateOrScheduleModule(modIdx, isScheduled: true);
                },
              ),
            if (incompleteCount > 0)
              _MenuActionItem(
                icon: LucideIcons.checkCircle,
                title: 'Mark Module as Finished',
                subtitle:
                    'Mark all $incompleteCount remaining lesson(s) (+${incompleteCount * 20} XP)',
                iconColor: AppTheme.duoGreen,
                onTap: () async {
                  Navigator.pop(ctx);
                  await ProgressService.markModuleCompleted(
                    module,
                    widget.book.id,
                  );
                  await _loadProgress();
                },
              ),
            if (completedCount > 0)
              _MenuActionItem(
                icon: LucideIcons.xCircle,
                title: 'Clear Module Progress',
                subtitle:
                    'Lock and clear $completedCount completed lesson(s) (-${completedCount * 20} XP)',
                iconColor: AppTheme.duoRed,
                onTap: () async {
                  Navigator.pop(ctx);
                  await ProgressService.clearModuleProgress(
                    module,
                    widget.book.id,
                  );
                  await _loadProgress();
                },
              ),
          ],
        );
      },
    );
  }

  Future<void> _promptGenerateOrScheduleModule(
    int modIdx, {
    required bool isScheduled,
  }) async {
    final wantsGraphics = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        title: Text(
          isScheduled
              ? 'Schedule Module Generation'
              : 'Generate Module Contents',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Choose what kind of content to generate for all sections in this module.',
          style: TextStyle(color: context.colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'Text only',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'With diagrams',
              style: TextStyle(
                color: AppTheme.duoBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    if (wantsGraphics == null) return;

    GenerationManager.instance.startModuleGeneration(
      widget.book,
      modIdx,
      generateGraphics: wantsGraphics,
      isScheduled: isScheduled,
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: context.colors.surface,
        content: Text(
          isScheduled
              ? 'Module generation scheduled!'
              : 'Module generation queued!',
          style: TextStyle(color: context.colors.textPrimary),
        ),
      ),
    );
  }

  Widget _buildLongPressMenu({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required List<_MenuActionItem> items,
  }) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            decoration: BoxDecoration(
              color: context.colors.glassStrong,
              border: Border.all(color: context.colors.outline),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: color.withValues(alpha: 0.4)),
                        ),
                        child: Icon(icon, color: color, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subtitle.toUpperCase(),
                              style: TextStyle(
                                color: color,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              title,
                              style: TextStyle(
                                color: context.colors.textPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ...items.map((item) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: item.onTap,
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: context.colors.surfaceAlt,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: context.colors.outline),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  item.icon,
                                  color: item.iconColor,
                                  size: 22,
                                ),
                                SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        style: TextStyle(
                                          color: context.colors.textPrimary,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        item.subtitle,
                                        style: TextStyle(
                                          color: context.colors.textFaint,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  LucideIcons.chevronRight,
                                  size: 16,
                                  color: context.colors.textFaint,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 3),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<List<_BookmarkMatch>> _getMatches() async {
    final bookmarks = await BookmarkService.getBookmarks();
    final List<_BookmarkMatch> matches = [];

    for (var bm in bookmarks) {
      if (bm.bookId != widget.book.id) continue;
      bool found = false;
      for (int m = 0; m < widget.book.modules.length; m++) {
        final module = widget.book.modules[m];
        for (int s = 0; s < module.sections.length; s++) {
          final section = module.sections[s];
          for (int u = 0; u < section.units.length; u++) {
            final unit = section.units[u];
            for (int l = 0; l < unit.lessons.length; l++) {
              final lesson = unit.lessons[l];
              if (lesson.id == bm.lessonId) {
                matches.add(_BookmarkMatch(
                  bookmark: bm,
                  module: module,
                  section: section,
                  unit: unit,
                  lesson: lesson,
                  moduleIdx: m,
                  sectionIdx: s,
                  unitIdx: u,
                  lessonIdx: l,
                ));
                found = true;
                break;
              }
            }
            if (found) break;
          }
          if (found) break;
        }
        if (found) break;
      }
    }
    return matches;
  }

  void _showBookmarksDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return FutureBuilder<List<_BookmarkMatch>>(
              future: _getMatches(),
              builder: (context, snapshot) {
                final colors = context.colors;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return AlertDialog(
                    backgroundColor: colors.surface,
                    content: const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(color: AppTheme.duoBlue),
                      ),
                    ),
                  );
                }

                final matches = snapshot.data ?? [];
                if (matches.isEmpty) {
                  return AlertDialog(
                    backgroundColor: colors.surface,
                    title: Row(
                      children: [
                        Icon(LucideIcons.bookmark, color: AppTheme.duoBlue),
                        const SizedBox(width: 8),
                        Text(
                          'Bookmarks',
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16),
                        Icon(
                          LucideIcons.bookmark,
                          size: 48,
                          color: colors.textFaint,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No Bookmarks Yet',
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap the bookmark icon while studying a lesson to save it here.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Close',
                          style: TextStyle(color: colors.textPrimary),
                        ),
                      ),
                    ],
                  );
                }

                // Group by module
                final Map<Module, List<_BookmarkMatch>> grouped = {};
                for (var match in matches) {
                  grouped.putIfAbsent(match.module, () => []).add(match);
                }

                return Dialog(
                  backgroundColor: colors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 500),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Icon(LucideIcons.bookmark, color: AppTheme.duoBlue),
                            const SizedBox(width: 8),
                            Text(
                              'Course Bookmarks',
                              style: TextStyle(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            children: grouped.entries.map((entry) {
                              final module = entry.key;
                              final mMatches = entry.value;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      module.title.toUpperCase(),
                                      style: const TextStyle(
                                        color: AppTheme.duoBlue,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 11,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ),
                                  ...mMatches.map((match) {
                                    return Card(
                                      color: colors.surfaceAlt,
                                      margin: const EdgeInsets.only(bottom: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                        title: Text(
                                          match.lesson.title,
                                          style: TextStyle(
                                            color: colors.textPrimary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                        subtitle: Text(
                                          match.unit.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: colors.textSecondary,
                                            fontSize: 11,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(
                                            LucideIcons.trash2,
                                            size: 18,
                                            color: colors.textFaint,
                                          ),
                                          onPressed: () async {
                                            await BookmarkService.remove(match.bookmark.lessonId);
                                            setStateDialog(() {});
                                          },
                                        ),
                                        onTap: () async {
                                          Navigator.pop(context); // Close dialog
                                          await BookmarkService.markOpened(match.bookmark.lessonId);
                                          if (!context.mounted) return;
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => LessonScreen(
                                                lesson: match.lesson,
                                                book: widget.book,
                                                modIdx: match.moduleIdx,
                                                secIdx: match.sectionIdx,
                                                unitIdx: match.unitIdx,
                                                lessonIdx: match.lessonIdx,
                                              ),
                                            ),
                                          );
                                          _loadProgress();
                                        },
                                      ),
                                    );
                                  }),
                                  const Divider(height: 24),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Close',
                              style: TextStyle(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget? _buildFloatingTargetButton() {
    if (_mostUrgentTarget == null) return null;

    final metrics = _mostUrgentTarget!['metrics'] as Map<String, dynamic>;
    final targetLeft = _mostUrgentTarget!['totalTargetLeftToday'] as int? ?? (metrics['targetLeftToday'] as int);
    final moduleIdx = _mostUrgentTarget!['moduleIdx'] as int;
    final sectionIdx = _mostUrgentTarget!['sectionIdx'] as int;

    final section = widget.book.modules[moduleIdx].sections[sectionIdx];
    final color = SectionColors.base(section.color);

    final int todayTarget = metrics['todayTarget'] as int? ?? 0;
    final int completedToday = metrics['completedToday'] as int? ?? 0;

    final double progress = todayTarget > 0 
        ? (completedToday / todayTarget).clamp(0.0, 1.0) 
        : 1.0;

    final String expandedText = targetLeft > 0 ? "$targetLeft left" : "Done! 🎉";

    final double buttonWidth = _targetButtonExpanded
        ? (targetLeft > 0 ? 116.0 : 124.0)
        : 48.0; // Perfect circle!

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      height: 48,
      width: buttonWidth,
      decoration: BoxDecoration(
        color: context.colors.isDark
            ? color.withValues(alpha: 0.15)
            : Colors.white.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _targetButtonExpanded
              ? color.withValues(alpha: 0.4)
              : (context.colors.isDark ? color.withValues(alpha: 0.2) : color.withValues(alpha: 0.3)),
          width: _targetButtonExpanded ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: InkWell(
            onTap: () {
              if (!_targetButtonExpanded) {
                setState(() {
                  _targetButtonExpanded = true;
                });
                _targetCollapseTimer?.cancel();
                _targetCollapseTimer = Timer(const Duration(seconds: 4), () {
                  if (mounted) {
                    setState(() {
                      _targetButtonExpanded = false;
                    });
                  }
                });
              } else {
                _targetCollapseTimer?.cancel();
                setState(() {
                  _targetButtonExpanded = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SectionSelectionScreen(
                      book: widget.book,
                      moduleIdx: moduleIdx,
                      module: widget.book.modules[moduleIdx],
                      initialHighlightSectionIdx: sectionIdx,
                    ),
                  ),
                ).then((_) => _loadProgress());
              }
            },
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                // The Circular Progress Border surrounding the target icon
                AnimatedAlign(
                  duration: Duration(milliseconds: 350),
                  curve: Curves.easeOutCubic,
                  alignment: _targetButtonExpanded ? Alignment.centerLeft : Alignment.center,
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutCubic,
                    padding: EdgeInsets.only(left: _targetButtonExpanded ? 2.0 : 0.0),
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 3.5,
                            backgroundColor: color.withValues(alpha: 0.15),
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                          ),
                          Icon(
                            LucideIcons.target,
                            color: color,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // The expanded text view
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 54.0),
                    child: AnimatedOpacity(
                      opacity: _targetButtonExpanded ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      child: Text(
                        expandedText,
                        maxLines: 1,
                        style: TextStyle(
                          color: context.colors.textPrimary,
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuActionItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;

  _MenuActionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
  });
}

class _BookmarkMatch {
  final Bookmark bookmark;
  final Module module;
  final Section section;
  final Unit unit;
  final Lesson lesson;
  final int moduleIdx;
  final int sectionIdx;
  final int unitIdx;
  final int lessonIdx;

  _BookmarkMatch({
    required this.bookmark,
    required this.module,
    required this.section,
    required this.unit,
    required this.lesson,
    required this.moduleIdx,
    required this.sectionIdx,
    required this.unitIdx,
    required this.lessonIdx,
  });
}