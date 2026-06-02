import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/generation_manager.dart';
import '../services/progress_service.dart';
import '../services/database_service.dart';
import '../utils/progress_utils.dart';
import '../widgets/bottom_sheets/section_bottom_sheet.dart';
import '../widgets/selectors/module_selector.dart';
import '../widgets/lesson_path.dart';
import '../services/global_state.dart';

class BookDashboardScreen extends StatefulWidget {
  final Book book;
  final Function(Book) onBookUpdated;
  /// Shared with [MainLayoutScreen]/the PYQ tab so the QP extractor follows the
  /// module the user is viewing here. Kept in sync whenever the active module
  /// changes.
  final ValueNotifier<int>? activeModule;

  const BookDashboardScreen({
    super.key,
    required this.book,
    required this.onBookUpdated,
    this.activeModule,
  });

  @override
  State<BookDashboardScreen> createState() => _BookDashboardScreenState();
}

class _BookDashboardScreenState extends State<BookDashboardScreen> {
  List<String> _completedLessons = [];
  bool _hasMissingFiles = false;

  int _activeModuleIdx = 0;
  int _activeSectionIdx = 0;

  @override
  void initState() {
    super.initState();
    _loadProgress();
    _checkMissingFiles();
    _loadLastResumed();
    // Publish the initial module so the PYQ tab is scoped correctly even before
    // the user switches modules (_loadLastResumed updates it asynchronously).
    widget.activeModule?.value = _activeModuleIdx;
    // Refresh completion state whenever progress changes anywhere (a lesson/
    // unit/section/module marked finished or cleared, or a cloud sync merge),
    // so the lesson path always reflects the latest status.
    GlobalState.progressNotifier.addListener(_loadProgress);
  }

  @override
  void dispose() {
    GlobalState.progressNotifier.removeListener(_loadProgress);
    super.dispose();
  }

  Future<void> _loadLastResumed() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final modIdx = prefs.getInt('last_mod_idx_${widget.book.id}');
      final secIdx = prefs.getInt('last_sec_idx_${widget.book.id}');
      if (modIdx != null && secIdx != null) {
        if (modIdx >= 0 && modIdx < widget.book.modules.length) {
          final module = widget.book.modules[modIdx];
          if (secIdx >= 0 && secIdx < module.sections.length) {
            if (mounted) {
              setState(() {
                _activeModuleIdx = modIdx;
                _activeSectionIdx = secIdx;
              });
              widget.activeModule?.value = _activeModuleIdx;
            }
          }
        }
      }
    } catch (e) {
      print('Error loading last resumed position: $e');
    }
  }

  @override
  void didUpdateWidget(BookDashboardScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.book.id != widget.book.id || oldWidget.book.updatedAt != widget.book.updatedAt) {
      _checkMissingFiles();
    }
  }

  Future<void> _checkMissingFiles() async {
    if (kIsWeb) {
      if (mounted) setState(() => _hasMissingFiles = false);
      return;
    }
    bool missing = false;
    for (final m in widget.book.modules) {
      for (final s in m.sections) {
        // New-flow: section owns the PDF chunk.
        if (s.startPage != null && s.endPage != null) {
          if (s.pdfPath == null || !File(s.pdfPath!).existsSync()) {
            missing = true;
            break;
          }
          continue;
        }
        // Old-flow: each unit owns its chunk.
        for (final u in s.units) {
          if (u.startPage != null && u.endPage != null) {
            if (u.pdfPath == null || !File(u.pdfPath!).existsSync()) {
              missing = true;
              break;
            }
          }
        }
        if (missing) break;
      }
      if (missing) break;
    }
    if (mounted) setState(() => _hasMissingFiles = missing);
  }

  Future<void> _loadProgress() async {
    final comp = await ProgressService.getCompletedLessons();
    if (mounted) setState(() => _completedLessons = comp);
  }

  void _onClearUnit(Unit unit, int modIdx, int secIdx, int unitIdx) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Regenerate Unit?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text(
          'This will permanently delete the AI-generated lessons for this unit, allowing you to generate it fresh.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              for (var l in unit.lessons) {
                await ProgressService.clearLessonProgress(l.id);
              }
              final List<Unit> updatedUnits = List.from(widget.book.modules[modIdx].sections[secIdx].units);
              updatedUnits[unitIdx] = unit.copyWith(isGenerated: false, lessons: []);

              final List<Section> updatedSecs = List.from(widget.book.modules[modIdx].sections);
              updatedSecs[secIdx] = updatedSecs[secIdx].copyWith(units: updatedUnits);

              final List<Module> updatedMods = List.from(widget.book.modules);
              updatedMods[modIdx] = updatedMods[modIdx].copyWith(sections: updatedSecs);

              final newBook = widget.book.copyWith(modules: updatedMods);
              await DatabaseService().saveGeneratedBook(newBook);
              widget.onBookUpdated(newBook);
            },
            child: const Text('Regenerate', style: TextStyle(color: AppTheme.duoOrange, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  /// Long-press handler on a lesson node — asks the user to confirm, then
  /// regenerates JUST that one lesson (preserving its slot and id). Diagrams
  /// are re-rendered too when the user opts in. The previous lesson is kept
  /// if every model/key fails.
  Future<void> _promptRegenerateLesson(int modIdx, int secIdx, int unitIdx, int lessonIdx, Lesson lesson) async {
    final wantsGraphics = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Regenerate lesson?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Text(
          'The AI will replace "${lesson.title}" with a fresh take using the source PDF. The lesson\'s slot in the unit is kept.',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Text only', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('With diagrams', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
    if (wantsGraphics == null) return;
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.surface,
        content: Text('Regenerating "${lesson.title}"…', style: const TextStyle(color: Colors.white)),
        duration: const Duration(seconds: 3),
      ),
    );
    GenerationManager.instance.regenerateLesson(
      book: widget.book,
      modIdx: modIdx,
      secIdx: secIdx,
      unitIdx: unitIdx,
      lessonIdx: lessonIdx,
      generateGraphics: wantsGraphics,
      errorSink: (msg) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppTheme.duoRed.withOpacity(0.85),
            content: Text(msg, style: const TextStyle(color: Colors.white)),
          ),
        );
      },
    );
  }

  /// Asks whether to also render diagrams for this unit, then kicks off
  /// generation. Graphics are optional (and slower), so we let the user
  /// decide per unit instead of always generating them.
  Future<void> _promptAndGenerateUnit(Unit unit, int modIdx, int secIdx, int unitIdx) async {
    final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Generate Lesson', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text(
          'Choose when and how to generate lessons for this unit.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          PopupMenuButton<Map<String, dynamic>>(
            onSelected: (val) => Navigator.pop(ctx, val),
            style: TextButton.styleFrom(foregroundColor: AppTheme.duoGreen),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text('Generate Now', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: {'scheduled': false, 'graphics': false},
                child: Text('Text only'),
              ),
              const PopupMenuItem(
                value: {'scheduled': false, 'graphics': true},
                child: Text('With diagrams'),
              ),
            ],
          ),
          PopupMenuButton<Map<String, dynamic>>(
            onSelected: (val) => Navigator.pop(ctx, val),
            style: TextButton.styleFrom(foregroundColor: AppTheme.duoViolet),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text('Schedule', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: {'scheduled': true, 'graphics': false},
                child: Text('Text only'),
              ),
              const PopupMenuItem(
                value: {'scheduled': true, 'graphics': true},
                child: Text('With diagrams'),
              ),
            ],
          ),
        ],
      ),
    );
    if (result == null) return;
    final bool graphics = result['graphics'] as bool;
    final bool scheduled = result['scheduled'] as bool;
    
    GenerationManager.instance.startUnitGeneration(
      unit, widget.book, modIdx, secIdx, unitIdx,
      generateGraphics: graphics,
      isScheduled: scheduled,
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.surface,
        content: Text(scheduled ? 'Lesson generation scheduled!' : 'Lesson generation queued!'),
      ),
    );
  }

  void _openModuleSelector() {
    ModuleSelectorSheet.show(
      context: context,
      modules: widget.book.modules,
      activeModuleIdx: _activeModuleIdx,
      completedLessons: _completedLessons,
      onSelect: (idx) {
        setState(() {
          _activeModuleIdx = idx;
          _activeSectionIdx = 0;
        });
        widget.activeModule?.value = _activeModuleIdx;
      },
      onModuleLongPress: (idx) {
        _showModuleLongPressMenu(idx);
      },
    );
  }

  void _openSectionSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.25 + 0.2*(widget.book.modules[_activeModuleIdx].sections.length < 2 ? widget.book.modules[_activeModuleIdx].sections.length: 2),
        child: SectionBottomSheet(
          book: widget.book,
          activeModuleIdx: _activeModuleIdx,
          activeSectionIdx: _activeSectionIdx,
          completedLessons: _completedLessons,
          onSelect: (modIdx, secIdx) {
            setState(() {
              _activeModuleIdx = modIdx;
              _activeSectionIdx = secIdx;
            });
            widget.activeModule?.value = _activeModuleIdx;
          },
          onSectionLongPress: (modIdx, secIdx) {
            _showSectionLongPressMenu(modIdx, secIdx);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.book.modules.isEmpty) {
      return const Scaffold(
        backgroundColor: AppTheme.background,
        body: Center(child: Text('This book is empty.', style: TextStyle(color: Colors.white54))),
      );
    }

    final mIdx = _activeModuleIdx.clamp(0, widget.book.modules.length - 1);
    final activeMod = widget.book.modules[mIdx];

    final sectionsCount = activeMod.sections.length;
    final sIdx = sectionsCount == 0 ? 0 : _activeSectionIdx.clamp(0, sectionsCount - 1);
    final activeSec = sectionsCount > 0 ? activeMod.sections[sIdx] : null;

    final Color sectionColor =
        activeSec != null ? SectionColors.base(activeSec.color) : AppTheme.duoBlue;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Lesson path content
          Positioned.fill(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 72),
                Expanded(
                  child: AnimatedBuilder(
                    animation: GenerationManager.instance,
                    builder: (context, _) {
                      if (activeSec == null) {
                        return const Center(
                          child: Text('No sections available.', style: TextStyle(color: Colors.white54)),
                        );
                      }
                      // New-flow sections carry their own PDF chunk but don't
                      // have units yet. Planning is now user-triggered from the
                      // manifest panel (so they can tweak the planner
                      // instructions first) rather than auto-firing here.
                      final manifestTask = GenerationManager.instance.activeSectionManifests[activeSec.id];
                      return LessonPath(
                        section: activeSec,
                        book: widget.book,
                        modIdx: mIdx,
                        secIdx: sIdx,
                        loadingUnitStatuses: GenerationManager.instance.activeUnitGenerations,
                        sectionManifestStatus: manifestTask,
                        completedLessons: _completedLessons,
                        hasMissingFiles: _hasMissingFiles,
                        onLessonFinished: () {
                          _loadProgress();
                          widget.onBookUpdated(widget.book);
                        },
                        onGenerateUnit: (unit, unitIdx) {
                          _promptAndGenerateUnit(unit, mIdx, sIdx, unitIdx);
                        },
                        onClearUnit: (unit, unitIdx) {
                          _onClearUnit(unit, mIdx, sIdx, unitIdx);
                        },
                        onRegenerateLesson: (unitIdx, lessonIdx, lesson) {
                          _showLessonLongPressMenu(mIdx, sIdx, unitIdx, lessonIdx, lesson);
                        },
                        onUnitLongPress: (unitIdx, unit) {
                          _showUnitLongPressMenu(mIdx, sIdx, unitIdx, unit);
                        },
                        onPlanManifest: (instructions, saveGlobally) {
                          GenerationManager.instance.clearSectionManifestError(activeSec.id);
                          GenerationManager.instance.startSectionUnitManifest(
                            widget.book, mIdx, sIdx,
                            instructions: instructions,
                            saveGlobally: saveGlobally,
                          );
                        },
                        onConfirmFormats: (confirmedUnits) async {
                          // User signed off on per-unit format assignments.
                          // Persist them and flip the section\'s confirmation
                          // flag so the lesson path opens up.
                          final modules = List<Module>.from(widget.book.modules);
                          final secs = List<Section>.from(modules[mIdx].sections);
                          secs[sIdx] = secs[sIdx].copyWith(
                            units: confirmedUnits,
                            unitFormatsConfirmed: true,
                          );
                          modules[mIdx] = modules[mIdx].copyWith(sections: secs);
                          final newBook = widget.book.copyWith(modules: modules);
                          await DatabaseService().saveGeneratedBook(newBook);
                          widget.onBookUpdated(newBook);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Floating glass header bar (matches React: glass-panel rounded-b-2xl)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.03),
                            border: Border(
                              left: BorderSide(color: Colors.white.withOpacity(0.08)),
                              right: BorderSide(color: Colors.white.withOpacity(0.08)),
                              bottom: BorderSide(color: Colors.white.withOpacity(0.08)),
                            ),
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 30, offset: const Offset(0, 4)),
                            ],
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              // Module book icon with chevron badge
                              _IconHeaderButton(
                                onTap: _openModuleSelector,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    const Icon(LucideIcons.bookOpen, color: AppTheme.duoBlue, size: 26),
                                    Positioned(
                                      bottom: -4,
                                      right: -4,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF1E293B),
                                          shape: BoxShape.circle,
                                          border: Border.all(color: const Color(0xFF475569), width: 1),
                                        ),
                                        child: const Icon(LucideIcons.chevronDown, size: 10, color: Color(0xFFCBD5E1)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),

                              // Section pill — flex-grow, border-b-2 in section color
                              if (activeSec != null)
                                Expanded(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: _openSectionSelector,
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.05),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border(
                                            bottom: BorderSide(color: sectionColor, width: 2),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                activeSec.title.toUpperCase(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w900,
                                                  letterSpacing: 1.6,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            const Icon(LucideIcons.chevronDown, size: 16, color: Color(0xFFCBD5E1)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              else
                                const Expanded(child: SizedBox.shrink()),
                              const SizedBox(width: 8),

                              // XP chip
                              ValueListenableBuilder<int>(
                                valueListenable: GlobalState.xpNotifier,
                                builder: (context, xp, _) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(LucideIcons.zap, size: 14, color: Color(0xFFFBBF24)),
                                        const SizedBox(width: 4),
                                        Text(
                                          '$xp',
                                          style: const TextStyle(
                                            color: Color(0xFFFBBF24),
                                            fontWeight: FontWeight.w900,
                                            fontSize: 13,
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
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLessonLongPressMenu(int modIdx, int secIdx, int unitIdx, int lessonIdx, Lesson lesson) {
    final isCompleted = _completedLessons.contains(lesson.id);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return _buildLongPressMenu(
          title: lesson.title,
          subtitle: 'Lesson Menu',
          icon: LucideIcons.bookOpen,
          color: AppTheme.duoBlue,
          items: [
            if (!isCompleted)
              _MenuActionItem(
                icon: LucideIcons.checkCircle,
                title: 'Mark as Finished',
                subtitle: 'Unlock progress (+20 XP)',
                iconColor: AppTheme.duoGreen,
                onTap: () async {
                  Navigator.pop(ctx);
                  await ProgressService.markLessonCompleted(lesson.id);
                  await _loadProgress();
                  widget.onBookUpdated(widget.book);
                },
              ),
            if (isCompleted)
              _MenuActionItem(
                icon: LucideIcons.xCircle,
                title: 'Clear Progress',
                subtitle: 'Lock and clear status (-20 XP)',
                iconColor: AppTheme.duoRed,
                onTap: () async {
                  Navigator.pop(ctx);
                  await ProgressService.clearLessonProgress(lesson.id);
                  await _loadProgress();
                  widget.onBookUpdated(widget.book);
                },
              ),
            _MenuActionItem(
              icon: LucideIcons.refreshCw,
              title: 'Regenerate Lesson',
              subtitle: 'Re-generate lesson from PDF chunk',
              iconColor: AppTheme.duoOrange,
              onTap: () {
                Navigator.pop(ctx);
                _promptRegenerateLesson(modIdx, secIdx, unitIdx, lessonIdx, lesson);
              },
            ),
          ],
        );
      },
    );
  }

  void _showUnitLongPressMenu(int modIdx, int secIdx, int unitIdx, Unit unit) {
    int totalLessons = unit.lessons.length;
    int completedCount = unit.lessons.where((l) => _completedLessons.contains(l.id)).length;
    int incompleteCount = totalLessons - completedCount;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return _buildLongPressMenu(
          title: unit.title,
          subtitle: 'Unit Menu',
          icon: LucideIcons.bookmark,
          color: AppTheme.duoViolet,
          items: [
            if (incompleteCount > 0)
              _MenuActionItem(
                icon: LucideIcons.checkCircle,
                title: 'Mark Unit as Finished',
                subtitle: 'Mark all $incompleteCount remaining lesson(s) (+${incompleteCount * 20} XP)',
                iconColor: AppTheme.duoGreen,
                onTap: () async {
                  Navigator.pop(ctx);
                  await ProgressService.markUnitCompleted(unit);
                  await _loadProgress();
                  widget.onBookUpdated(widget.book);
                },
              ),
            if (completedCount > 0)
              _MenuActionItem(
                icon: LucideIcons.xCircle,
                title: 'Clear Unit Progress',
                subtitle: 'Lock and clear $completedCount completed lesson(s) (-${completedCount * 20} XP)',
                iconColor: AppTheme.duoRed,
                onTap: () async {
                  Navigator.pop(ctx);
                  await ProgressService.clearUnitProgress(unit);
                  await _loadProgress();
                  widget.onBookUpdated(widget.book);
                },
              ),
            if (unit.isGenerated && unit.lessons.isNotEmpty)
              _MenuActionItem(
                icon: LucideIcons.refreshCcw,
                title: 'Delete Unit',
                subtitle: 'Clear AI lessons to allow regenerating',
                iconColor: AppTheme.duoOrange,
                onTap: () {
                  Navigator.pop(ctx);
                  _onClearUnit(unit, modIdx, secIdx, unitIdx);
                },
              ),
          ],
        );
      },
    );
  }

  void _showSectionLongPressMenu(int modIdx, int secIdx) {
    final section = widget.book.modules[modIdx].sections[secIdx];
    int totalLessons = 0;
    int completedCount = 0;
    for (var u in section.units) {
      for (var l in u.lessons) {
        totalLessons++;
        if (_completedLessons.contains(l.id)) {
          completedCount++;
        }
      }
    }
    int incompleteCount = totalLessons - completedCount;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return _buildLongPressMenu(
          title: section.title,
          subtitle: 'Section Menu',
          icon: LucideIcons.layers,
          color: SectionColors.base(section.color),
          items: [
            _MenuActionItem(
              icon: LucideIcons.play,
              title: 'Generate Contents',
              subtitle: 'Plan manifest and generate all lessons now',
              iconColor: AppTheme.duoGreen,
              onTap: () {
                Navigator.pop(ctx);
                _promptGenerateOrScheduleSection(modIdx, secIdx, isScheduled: false);
              },
            ),
            _MenuActionItem(
              icon: LucideIcons.calendar,
              title: 'Schedule Generation',
              subtitle: 'Queue for auto schedule hours',
              iconColor: AppTheme.duoViolet,
              onTap: () {
                Navigator.pop(ctx);
                _promptGenerateOrScheduleSection(modIdx, secIdx, isScheduled: true);
              },
            ),
            if (incompleteCount > 0)
              _MenuActionItem(
                icon: LucideIcons.checkCircle,
                title: 'Mark Section as Finished',
                subtitle: 'Mark all $incompleteCount remaining lesson(s) (+${incompleteCount * 20} XP)',
                iconColor: AppTheme.duoGreen,
                onTap: () async {
                  Navigator.pop(ctx);
                  await ProgressService.markSectionCompleted(section);
                  await _loadProgress();
                  widget.onBookUpdated(widget.book);
                },
              ),
            if (completedCount > 0)
              _MenuActionItem(
                icon: LucideIcons.xCircle,
                title: 'Clear Section Progress',
                subtitle: 'Lock and clear $completedCount completed lesson(s) (-${completedCount * 20} XP)',
                iconColor: AppTheme.duoRed,
                onTap: () async {
                  Navigator.pop(ctx);
                  await ProgressService.clearSectionProgress(section);
                  await _loadProgress();
                  widget.onBookUpdated(widget.book);
                },
              ),
          ],
        );
      },
    );
  }

  Future<void> _promptGenerateOrScheduleSection(int modIdx, int secIdx, {required bool isScheduled}) async {
    final wantsGraphics = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: Text(isScheduled ? 'Schedule Section Generation' : 'Generate Section Contents', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text(
          'Choose what kind of content to generate. This will automatically plan the section units and generate them sequentially.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Text only', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('With diagrams', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold)),
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
        backgroundColor: AppTheme.surface,
        content: Text(isScheduled ? 'Section generation scheduled!' : 'Section generation queued!'),
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
    int incompleteCount = totalLessons - completedCount;

    showModalBottomSheet(
      context: context,
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
                subtitle: 'Mark all $incompleteCount remaining lesson(s) (+${incompleteCount * 20} XP)',
                iconColor: AppTheme.duoGreen,
                onTap: () async {
                  Navigator.pop(ctx);
                  await ProgressService.markModuleCompleted(module);
                  await _loadProgress();
                  widget.onBookUpdated(widget.book);
                },
              ),
            if (completedCount > 0)
              _MenuActionItem(
                icon: LucideIcons.xCircle,
                title: 'Clear Module Progress',
                subtitle: 'Lock and clear $completedCount completed lesson(s) (-${completedCount * 20} XP)',
                iconColor: AppTheme.duoRed,
                onTap: () async {
                  Navigator.pop(ctx);
                  await ProgressService.clearModuleProgress(module);
                  await _loadProgress();
                  widget.onBookUpdated(widget.book);
                },
              ),
          ],
        );
      },
    );
  }

  Future<void> _promptGenerateOrScheduleModule(int modIdx, {required bool isScheduled}) async {
    final wantsGraphics = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: Text(isScheduled ? 'Schedule Module Generation' : 'Generate Module Contents', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text(
          'Choose what kind of content to generate for all sections in this module.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Text only', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('With diagrams', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold)),
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
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.surface,
        content: Text(isScheduled ? 'Module generation scheduled!' : 'Module generation queued!'),
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
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: color.withOpacity(0.4)),
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
                          style: const TextStyle(
                            color: Colors.white,
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
              const SizedBox(height: 20),
              ...items.map((item) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: item.onTap,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Row(
                          children: [
                            Icon(item.icon, color: item.iconColor, size: 22),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item.subtitle,
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(LucideIcons.chevronRight, size: 16, color: Colors.white24),
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

class _IconHeaderButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const _IconHeaderButton({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: child,
        ),
      ),
    );
  }
}
