import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../services/bookmark_service.dart';
import '../theme/app_theme.dart';
import '../services/progress_service.dart';
import '../utils/progress_utils.dart';
import 'dart:ui';
import 'dart:async';
import '../services/global_state.dart';
import '../services/generation_manager.dart';
import 'main_layout_screen.dart';
import 'pyq_panel_screen.dart';
import '../services/deadline_service.dart';
import '../services/database_service.dart';
import '../services/module_notes_service.dart';
import 'lesson_screen.dart';
import 'module_notes_viewer_screen.dart';

class SectionSelectionScreen extends StatefulWidget {
  final Book book;
  final int moduleIdx;
  final Module module;
  final int? initialHighlightSectionIdx;

  const SectionSelectionScreen({
    super.key,
    required this.book,
    required this.moduleIdx,
    required this.module,
    this.initialHighlightSectionIdx,
  });

  @override
  State<SectionSelectionScreen> createState() => _SectionSelectionScreenState();
}

class _SectionSelectionScreenState extends State<SectionSelectionScreen> {
  late Book _currentBook;
  late Module _currentModule;
  StreamSubscription<Book>? _bookUpdatesSub;
  List<String> _completedLessons = [];
  bool _isLoading = true;
  Map<int, Map<String, dynamic>> _sectionTargets = {};
  bool _targetButtonExpanded = false;
  Timer? _targetCollapseTimer;
  int? _highlightedSectionIdx;
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _sectionKeys = {};
  bool _hasScrolled = false;
  bool _hasModuleNotes = false;
  String? _moduleNotesPdfPath;

  @override
  void initState() {
    super.initState();
    _currentBook = widget.book;
    _currentModule = widget.module;
    _loadProgress();
    _checkNotesStatus();
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
    _scrollController.dispose();
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
        if (widget.moduleIdx >= 0 && widget.moduleIdx < fresh.modules.length) {
          _currentModule = fresh.modules[widget.moduleIdx];
        }
      });
      _loadDeadlines();
      _checkNotesStatus();
    }
  }

  Future<void> _checkNotesStatus() async {
    final hasNotes = await ModuleNotesService.instance.hasNotes(_currentBook.id, _currentModule.id);
    final pdfPath = hasNotes ? await ModuleNotesService.instance.getNotesPdfPath(_currentBook.id, _currentModule.id) : null;
    if (mounted) {
      setState(() {
        _hasModuleNotes = hasNotes;
        _moduleNotesPdfPath = pdfPath;
      });
    }
  }

  void _openNotes() async {
    final pdfPath = _moduleNotesPdfPath ?? await ModuleNotesService.instance.getNotesPdfPath(_currentBook.id, _currentModule.id);
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ModuleNotesViewerScreen(
            book: _currentBook,
            module: _currentModule,
            moduleIndex: widget.moduleIdx,
            pdfPath: pdfPath,
            onRegenerateRequested: () {
              Navigator.pop(context);
              _startNoteGen();
            },
          ),
        ),
      ).then((_) => _checkNotesStatus());
    }
  }


  void _startNoteGen() {
    ModuleNotesService.instance.startBackgroundNotesGeneration(
      book: _currentBook,
      module: _currentModule,
      moduleIndex: widget.moduleIdx,
    );

    final job = ModuleNotesService.instance.getJob(_currentBook.id, _currentModule.id);
    if (job != null) {
      void onJobUpdate() {
        if (!mounted) return;
        setState(() {});
        if (job.isCompleted) {
          job.removeListener(onJobUpdate);
          _checkNotesStatus();
        } else if (job.isFailed) {
          job.removeListener(onJobUpdate);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Note Generation Failed: ${job.status}')),
          );
        }
      }
      job.addListener(onJobUpdate);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Started background note generation for "${_currentModule.title}". Progress notifications active!'),
        duration: const Duration(seconds: 3),
      ),
    );
  }


  Future<void> _loadProgress() async {
    try {
      final completed = await ProgressService.getCompletedLessons();
      if (mounted) {
        setState(() {
          _completedLessons = completed;
        });
      }
      await _loadDeadlines();
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      if (widget.initialHighlightSectionIdx != null && !_hasScrolled) {
        _hasScrolled = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(milliseconds: 400), () {
            if (mounted) {
              _scrollToAndHighlight(widget.initialHighlightSectionIdx!);
            }
          });
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _loadDeadlines() async {
    final targets = <int, Map<String, dynamic>>{};
    for (var sIdx = 0; sIdx < _currentModule.sections.length; sIdx++) {
      final totalLessons = _currentBook.getEstimatedLessonsUpToSection(widget.moduleIdx, sIdx);
      final completedInSec = _currentBook.getCompletedLessonsUpToSection(widget.moduleIdx, sIdx, _completedLessons);

      final metrics = await DeadlineService.instance.calculateSectionTarget(
        bookId: _currentBook.id,
        moduleIdx: widget.moduleIdx,
        sectionIdx: sIdx,
        totalLessons: totalLessons,
        currentCompleted: completedInSec,
      );
      targets[sIdx] = metrics;
    }
    if (mounted) {
      setState(() {
        _sectionTargets = targets;
      });
    }
  }

  void _scrollToAndHighlight(int sectionIdx) {
    final key = _sectionKeys[sectionIdx];
    if (key == null) return;
    final context = key.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
    setState(() {
      _highlightedSectionIdx = sectionIdx;
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _highlightedSectionIdx = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        title: Text(
          'Select Section',
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
                  builder: (_) => PyqPanelScreen(book: widget.book),
                ),
              );
            },
            tooltip: 'PYQ Panel',
          ),
          IconButton(
            icon: const Icon(LucideIcons.bookmark),
            onPressed: () => _showBookmarksDialog(context),
            tooltip: 'Module Bookmarks',
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
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: context.colors.surfaceAlt,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: context.colors.outline),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MODULE ${widget.moduleIdx + 1}',
                            style: TextStyle(
                              color: AppTheme.duoBlue,
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _currentModule.title,
                            style: TextStyle(
                              color: context.colors.textPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            _currentModule.description,
                            style: TextStyle(
                              color: context.colors.textFaint,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              if (!_hasModuleNotes)
                                Expanded(
                                  child: OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                      side: const BorderSide(color: AppTheme.duoBlue, width: 1.5),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    icon: const Icon(LucideIcons.sparkles, size: 16, color: AppTheme.duoBlue),
                                    label: const Text(
                                      'Quick Generate Module Notes',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900,
                                        color: AppTheme.duoBlue,
                                      ),
                                    ),
                                    onPressed: _startNoteGen,
                                  ),
                                )
                              else
                                Expanded(
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.duoBlue,
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      elevation: 0,
                                    ),
                                    icon: const Icon(LucideIcons.bookOpenCheck, size: 16, color: Colors.white),
                                    label: const Text(
                                      'Open Module Notes (PDF)',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: _openNotes,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'SECTIONS IN THIS MODULE',
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 12),
                    _currentModule.sections.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: Text(
                                'No sections generated yet.',
                                style: TextStyle(
                                  color: context.colors.textFaint,
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _currentModule.sections.length,
                            itemBuilder: (context, index) {
                              final section = _currentModule.sections[index];
                              final Color sectionColor = SectionColors.base(
                                section.color,
                              );

                              final progress = calculateSectionProgressDouble(section, _completedLessons);
                              final totalLessons = _currentBook.getEstimatedLessonsForSection(section);
                              final totalUnits = _currentBook.getEstimatedUnitsForSection(section);

                              _sectionKeys.putIfAbsent(index, () => GlobalKey());
                              final key = _sectionKeys[index]!;
                              final isHighlighted = _highlightedSectionIdx == index;

                              final metrics = _sectionTargets[index] ?? {'hasDeadline': false};
                              final hasDeadline = metrics['hasDeadline'] == true;
                              final daysLeft = metrics['daysLeft'] as int? ?? 0;
                              final targetLeft = metrics['targetLeftToday'] as int? ?? 0;

                              return TweenAnimationBuilder<double>(
                                tween: Tween<double>(
                                  begin: 1.0,
                                  end: isHighlighted ? 1.05 : 1.0,
                                ),
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                builder: (context, scale, child) {
                                  return Transform.scale(
                                    scale: scale,
                                    child: child,
                                  );
                                },
                                child: Container(
                                  key: key,
                                  margin: EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    color: context.colors.surfaceAlt,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: isHighlighted ? AppTheme.duoViolet : context.colors.outline,
                                      width: isHighlighted ? 2 : 1,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => MainLayoutScreen(
                                            book: _currentBook,
                                            initialModuleIdx: widget.moduleIdx,
                                            initialSectionIdx: index,
                                          ),
                                        ),
                                      ).then((_) => _refreshBookFromStorage());
                                    },
                                    onLongPress: () =>
                                        _showSectionLongPressMenu(widget.moduleIdx, index),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                      color: sectionColor
                                                          .withValues(alpha: 0.4),
                                                      blurRadius: 8,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  section.title,
                                                  style: TextStyle(
                                                    color: context
                                                        .colors
                                                        .textPrimary,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                              if (progress >= 1.0)
                                                const Icon(
                                                  LucideIcons.checkCircle2,
                                                  color: AppTheme.duoGreen,
                                                  size: 20,
                                                ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            section.description,
                                            style: TextStyle(
                                              color: context.colors.textSecondary,
                                              fontSize: 13,
                                              height: 1.4,
                                            ),
                                          ),
                                          if (section.units.isNotEmpty) ...[
                                            SizedBox(height: 16),
                                            Container(
                                              padding: EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: context.colors.background,
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: context.colors.outline,
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'UNITS IN THIS SECTION:',
                                                    style: TextStyle(
                                                      color: context
                                                          .colors
                                                          .textFaint,
                                                      fontSize: 9,
                                                      fontWeight: FontWeight.w900,
                                                      letterSpacing: 1.1,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  ...section.units.map((unit) {
                                                    final unitProgress =
                                                        unit.lessons.isEmpty
                                                        ? 0.0
                                                        : (unit.lessons
                                                                  .where(
                                                                    (l) => _completedLessons.contains(l.id),
                                                                  )
                                                                  .length /
                                                              unit.lessons.length);
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            bottom: 6,
                                                          ),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            unitProgress >= 1.0
                                                                ? LucideIcons.checkCircle2
                                                                : LucideIcons.circle,
                                                            color:
                                                                unitProgress >= 1.0
                                                                ? AppTheme.duoGreen
                                                                : context.colors.textFaint,
                                                            size: 14,
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              unit.title,
                                                              style: TextStyle(
                                                                color: context
                                                                    .colors
                                                                    .textSecondary,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
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
                                          if (hasDeadline && progress < 1.0) ...[
                                            SizedBox(height: 12),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                              decoration: BoxDecoration(
                                                color: AppTheme.duoViolet.withValues(alpha: 0.1),
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: AppTheme.duoViolet.withValues(alpha: 0.2)),
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(LucideIcons.calendarClock, color: AppTheme.duoViolet, size: 16),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Deadline: ${metrics['deadline'].toLocal().toString().substring(0, 10)} ($daysLeft days left)',
                                                          style: const TextStyle(
                                                            color: AppTheme.duoViolet,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 11,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 2),
                                                        Text(
                                                           targetLeft > 0 
                                                               ? "Today's Target: $targetLeft left (Daily: ${metrics['todayTarget']} | Tomorrow: ${metrics['tomorrowTarget'] ?? 0})"
                                                               : "Today's Target Completed! 🎉 (Tomorrow: ${metrics['tomorrowTarget'] ?? 0})",
                                                           style: TextStyle(
                                                             color: targetLeft > 0 ? context.colors.textPrimary : AppTheme.duoGreen,
                                                             fontSize: 10,
                                                             fontWeight: FontWeight.w600,
                                                           ),
                                                         ),
                                                      ],
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(LucideIcons.edit2, size: 14),
                                                    onPressed: () => _showDeadlineMenu(index),
                                                    padding: EdgeInsets.zero,
                                                    constraints: BoxConstraints(),
                                                    color: context.colors.textFaint,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ] else if (progress < 1.0) ...[
                                            SizedBox(height: 12),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: TextButton.icon(
                                                style: TextButton.styleFrom(
                                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                  minimumSize: Size.zero,
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                ),
                                                icon: Icon(LucideIcons.calendarPlus, size: 14, color: context.colors.textFaint),
                                                label: Text(
                                                  'Set Deadline',
                                                  style: TextStyle(color: context.colors.textFaint, fontSize: 11, fontWeight: FontWeight.bold),
                                                ),
                                                onPressed: () => _showDeadlineMenu(index),
                                              ),
                                            ),
                                          ],
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '$totalUnits Units • $totalLessons Lessons',
                                                style: TextStyle(
                                                  color: context.colors.textFaint,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '${(progress * 100).toInt()}% Done',
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

  Future<void> _selectSectionDeadline(BuildContext context, int sectionIdx) async {
    final currentDeadline = await DeadlineService.instance.getSectionDeadline(
      widget.book.id,
      widget.moduleIdx,
      sectionIdx,
    );

    if (!mounted) return;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDeadline ?? DateTime.now().add(Duration(days: 7)),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppTheme.duoViolet,
              onPrimary: Colors.white,
              surface: context.colors.surface,
              onSurface: context.colors.textPrimary,
            ), dialogTheme: DialogThemeData(backgroundColor: context.colors.surface),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      await DeadlineService.instance.setSectionDeadline(
        _currentBook.id,
        widget.moduleIdx,
        sectionIdx,
        picked,
      );
      await _loadDeadlines();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Deadline set to ${picked.toLocal().toString().substring(0, 10)}')),
      );
    }
  }

  Future<void> _showDeadlineMenu(int sectionIdx) async {
    final metrics = _sectionTargets[sectionIdx];
    final hasDeadline = metrics != null && metrics['hasDeadline'] == true;

    if (!hasDeadline) {
      await _selectSectionDeadline(context, sectionIdx);
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: context.colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(LucideIcons.calendarRange, color: AppTheme.duoViolet),
                title: const Text('Change Deadline'),
                onTap: () {
                  Navigator.pop(context);
                  _selectSectionDeadline(this.context, sectionIdx);
                },
              ),
              ListTile(
                leading: const Icon(LucideIcons.trash2, color: AppTheme.duoRed),
                title: const Text('Clear Deadline'),
                onTap: () async {
                  Navigator.pop(context);
                  await DeadlineService.instance.clearSectionDeadline(
                    widget.book.id,
                    widget.moduleIdx,
                    sectionIdx,
                  );
                  await _loadDeadlines();
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    const SnackBar(content: Text('Deadline cleared')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<List<_BookmarkMatch>> _getMatches() async {
    final bookmarks = await BookmarkService.getBookmarks();
    final List<_BookmarkMatch> matches = [];

    for (var bm in bookmarks) {
      if (bm.bookId != _currentBook.id) continue;
      bool found = false;
      for (int m = 0; m < _currentBook.modules.length; m++) {
        if (m != widget.moduleIdx) continue;
        final module = _currentBook.modules[m];
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
                        child: CircularProgressIndicator(color: AppTheme.duoViolet),
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
                        Icon(LucideIcons.bookmark, color: AppTheme.duoViolet),
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

                // Group by section
                final Map<Section, List<_BookmarkMatch>> grouped = {};
                for (var match in matches) {
                  grouped.putIfAbsent(match.section, () => []).add(match);
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
                            Icon(LucideIcons.bookmark, color: AppTheme.duoViolet),
                            const SizedBox(width: 8),
                            Text(
                              'Module Bookmarks',
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
                              final section = entry.key;
                              final sMatches = entry.value;
                              final sectionColor = SectionColors.base(section.color);

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      section.title.toUpperCase(),
                                      style: TextStyle(
                                        color: sectionColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 11,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ),
                                  ...sMatches.map((match) {
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
    Map<String, dynamic>? currentModuleTarget;
    int? currentSecIdx;

    for (var sIdx = 0; sIdx < widget.module.sections.length; sIdx++) {
      final metrics = _sectionTargets[sIdx];
      if (metrics != null && metrics['hasDeadline'] == true && metrics['lessonsLeft'] > 0) {
        currentModuleTarget = metrics;
        currentSecIdx = sIdx;
        break;
      }
    }

    if (currentModuleTarget == null) return null;

    final targetLeft = currentModuleTarget['targetLeftToday'] as int;
    final color = SectionColors.base(widget.module.sections[currentSecIdx!].color);

    final int todayTarget = currentModuleTarget['todayTarget'] as int? ?? 0;
    final int completedToday = currentModuleTarget['completedToday'] as int? ?? 0;

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
                _scrollToAndHighlight(currentSecIdx!);
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

  void _showSectionLongPressMenu(int modIdx, int secIdx) {
    final section = widget.book.modules[modIdx].sections[secIdx];
    final totalLessons = widget.book.getEstimatedLessonsForSection(section);
    int completedCount = 0;
    for (var u in section.units) {
      for (var l in u.lessons) {
        if (_completedLessons.contains(l.id)) {
          completedCount++;
        }
      }
    }
    int incompleteCount = 0;
    if (totalLessons == 0) {
      final isCompleted = _completedLessons.contains(section.id);
      completedCount = isCompleted ? 1 : 0;
      incompleteCount = isCompleted ? 0 : 1;
    } else {
      incompleteCount = (totalLessons - completedCount).clamp(0, totalLessons);
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return _buildLongPressMenu(
          title: section.title,
          subtitle: 'Section Menu',
          icon: LucideIcons.layers,
          color: SectionColors.base(section.color),
          items: [
            _MenuActionItem(
              icon: LucideIcons.calendarClock,
              title: 'Set Target Deadline',
              subtitle: 'Set a completion target date for this section',
              iconColor: AppTheme.duoViolet,
              onTap: () {
                Navigator.pop(ctx);
                _showDeadlineMenu(secIdx);
              },
            ),
            _MenuActionItem(
              icon: LucideIcons.play,
              title: 'Generate Contents',
              subtitle: 'Plan manifest and generate all lessons now',
              iconColor: AppTheme.duoGreen,
              onTap: () {
                Navigator.pop(ctx);
                _promptGenerateOrScheduleSection(
                  modIdx,
                  secIdx,
                  isScheduled: false,
                );
              },
            ),
            if (GlobalState.advancedModeNotifier.value)
              _MenuActionItem(
                icon: LucideIcons.calendar,
                title: 'Schedule Generation',
                subtitle: 'Queue for auto schedule hours',
                iconColor: AppTheme.duoViolet,
                onTap: () {
                  Navigator.pop(ctx);
                  _promptGenerateOrScheduleSection(
                    modIdx,
                    secIdx,
                    isScheduled: true,
                  );
                },
              ),
            if (incompleteCount > 0)
              _MenuActionItem(
                icon: LucideIcons.checkCircle,
                title: 'Mark Section as Finished',
                subtitle:
                    'Mark all $incompleteCount remaining lesson(s) (+${incompleteCount * 20} XP)',
                iconColor: AppTheme.duoGreen,
                onTap: () async {
                  Navigator.pop(ctx);
                  await ProgressService.markSectionCompleted(
                    section,
                    widget.book.id,
                  );
                  await _loadProgress();
                },
              ),
            if (completedCount > 0)
              _MenuActionItem(
                icon: LucideIcons.xCircle,
                title: 'Clear Section Progress',
                subtitle:
                    'Lock and clear $completedCount completed lesson(s) (-${completedCount * 20} XP)',
                iconColor: AppTheme.duoRed,
                onTap: () async {
                  Navigator.pop(ctx);
                  await ProgressService.clearSectionProgress(
                    section,
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

  Future<void> _promptGenerateOrScheduleSection(
    int modIdx,
    int secIdx, {
    required bool isScheduled,
  }) async {
    final wantsGraphics = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        title: Text(
          isScheduled ? 'Schedule Section Generation' : 'Generate Section Contents',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Choose what kind of content to generate for all units in this section.',
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

    GenerationManager.instance.startSectionGeneration(
      widget.book,
      modIdx,
      secIdx,
      generateGraphics: wantsGraphics,
      isScheduled: isScheduled,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: context.colors.surface,
        content: Text(
          isScheduled
              ? 'Section generation scheduled!'
              : 'Section generation queued!',
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