import 'package:flow/services/ai_service.dart';

import '../platform/io_shim.dart';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/safe_pdf_viewer.dart';
import 'source_pdf_upload_screen.dart';
import 'reference_pdf_viewer_screen.dart';
import 'course_settings_screen.dart';
import '../services/b2_service.dart';
import 'package:file_picker/file_picker.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/generation_manager.dart';
import '../services/ai_service.dart';
import '../services/progress_service.dart';
import '../services/database_service.dart';
import '../utils/progress_utils.dart';
import '../widgets/bottom_sheets/section_bottom_sheet.dart';
import '../widgets/selectors/module_selector.dart';
import '../widgets/lesson_path.dart';
import '../services/global_state.dart';
import '../services/walkthrough_service.dart';
import '../widgets/coach_mark.dart';
import '../widgets/quick_review_sheet.dart';
import 'main_layout_screen.dart';
import '../services/deadline_service.dart';

class BookDashboardScreen extends StatefulWidget {
  final Book book;
  final Function(Book) onBookUpdated;

  /// Shared with [MainLayoutScreen]/the PYQ tab so the QP extractor follows the
  /// module the user is viewing here. Kept in sync whenever the active module
  /// changes.
  final ValueNotifier<int>? activeModule;
  final ValueNotifier<int>? activeSection;
  final int? initialModuleIdx;
  final int? initialSectionIdx;

  const BookDashboardScreen({
    super.key,
    required this.book,
    required this.onBookUpdated,
    this.activeModule,
    this.activeSection,
    this.initialModuleIdx,
    this.initialSectionIdx,
  });

  @override
  State<BookDashboardScreen> createState() => _BookDashboardScreenState();
}

class _BookDashboardScreenState extends State<BookDashboardScreen> {
  late Book _currentBook;
  StreamSubscription<Book>? _bookUpdatesSub;
  List<String> _completedLessons = [];
  bool _hasMissingFiles = false;

  int _activeModuleIdx = 0;
  int _activeSectionIdx = 0;
  Map<String, dynamic>? _mostUrgentTarget;
  bool _targetButtonExpanded = false;
  Timer? _targetCollapseTimer;

  final GlobalKey _coachModuleKey = GlobalKey();
  final GlobalKey _coachSectionKey = GlobalKey();
  final GlobalKey _coachReviewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _currentBook = widget.book;
    _activeModuleIdx = widget.initialModuleIdx ?? 0;
    _activeSectionIdx = widget.initialSectionIdx ?? 0;
    _loadProgress();
    _checkMissingFiles();
    _loadLastResumed();
    _refreshBookFromStorage();

    widget.activeModule?.value = _activeModuleIdx;
    widget.activeSection?.value = _activeSectionIdx;

    GlobalState.progressNotifier.addListener(_loadProgress);
    GenerationManager.instance.addListener(_onGenManagerChanged);
    _bookUpdatesSub = GenerationManager.instance.bookUpdates.listen((updatedBook) {
      if (updatedBook.id == _currentBook.id && mounted) {
        _refreshBookFromStorage(updatedBook);
      }
    });

    final walk = WalkthroughService.instance;
    if (walk.step.value == WalkStep.openCourse &&
        _currentBook.id == walk.seededBookId) {
      walk.advanceTo(WalkStep.tryUnit);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 600), () {
        if (!mounted) return;
        CoachMarkController.maybeShow(
          context,
          prefsKey: 'coach_marks_dashboard_done',
          marks: [
            CoachMark(
              targetKey: _coachModuleKey,
              title: 'Switch modules',
              body:
                  'Your course is split into modules (chapters). Tap here to jump between them.',
            ),
            CoachMark(
              targetKey: _coachSectionKey,
              title: 'Pick a section',
              body:
                  'Each module has sections. The lesson path below always shows the selected section — tap a node to start learning.',
            ),
            CoachMark(
              targetKey: _coachReviewKey,
              title: 'Quick review',
              body:
                  'Short on time? Get the key statements and formulas of this module in one tap.',
            ),
          ],
        );
      });
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
      widget.onBookUpdated(fresh);
      _loadProgress();
    }
  }

  Future<void> _loadLastResumed() async {
    if (widget.initialModuleIdx != null || widget.initialSectionIdx != null) {
      return;
    }
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
              widget.activeSection?.value = _activeSectionIdx;
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
    if (oldWidget.book.id != widget.book.id ||
        oldWidget.book.updatedAt != widget.book.updatedAt) {
      _currentBook = widget.book;
      _refreshBookFromStorage();
      _checkMissingFiles();
    }
  }

  Future<void> _checkMissingFiles() async {
    if (kIsWeb) {
      if (mounted) setState(() => _hasMissingFiles = false);
      return;
    }
    bool missing = false;
    for (final m in _currentBook.modules) {
      for (final s in m.sections) {
        // New-flow: section owns the PDF chunk.
        if (s.startPage != null && s.endPage != null) {
          if (s.pdfPath == null || !await File(s.pdfPath!).exists()) {
            missing = true;
            break;
          }
          continue;
        }
        // Old-flow: each unit owns its chunk.
        for (final u in s.units) {
          if (u.startPage != null && u.endPage != null) {
            if (u.pdfPath == null || !await File(u.pdfPath!).exists()) {
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
    final courseXp = await ProgressService.getXpForCourse(_currentBook.id);
    GlobalState.xpNotifier.value = courseXp;
    if (mounted) setState(() => _completedLessons = comp);
    final urgent = await DeadlineService.instance.getMostUrgentActiveTarget(
      _currentBook.id,
      _currentBook,
      comp,
    );
    if (mounted) {
      setState(() {
        _mostUrgentTarget = urgent;
      });
    }
  }

  Widget? _buildFloatingTargetButton() {
    if (_mostUrgentTarget == null) return null;

    final metrics = _mostUrgentTarget!['metrics'] as Map<String, dynamic>;
    final targetLeft = _mostUrgentTarget!['totalTargetLeftToday'] as int? ?? (metrics['targetLeftToday'] as int);
    final moduleIdx = _mostUrgentTarget!['moduleIdx'] as int;
    final sectionIdx = _mostUrgentTarget!['sectionIdx'] as int;

    final mIdx = _activeModuleIdx.clamp(0, _currentBook.modules.length - 1);
    final activeMod = _currentBook.modules[mIdx];
    final sIdx = activeMod.sections.isEmpty 
        ? 0 
        : _activeSectionIdx.clamp(0, activeMod.sections.length - 1);
    final activeSec = activeMod.sections.isNotEmpty ? activeMod.sections[sIdx] : null;
    final color = activeSec != null
        ? SectionColors.base(activeSec.color)
        : AppTheme.duoBlue;

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
                if (_activeModuleIdx != moduleIdx || _activeSectionIdx != sectionIdx) {
                  setState(() {
                    _activeModuleIdx = moduleIdx;
                    _activeSectionIdx = sectionIdx;
                  });
                  widget.activeModule?.value = moduleIdx;
                  widget.activeSection?.value = sectionIdx;
                }
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

  void _onClearUnit(Unit unit, int modIdx, int secIdx, int unitIdx) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        title: Text(
          'Regenerate Unit?',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'This will permanently delete the AI-generated lessons for this unit, allowing you to generate it fresh.',
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
            onPressed: () async {
              Navigator.pop(ctx);
              for (var l in unit.lessons) {
                await ProgressService.clearLessonProgress(l.id, widget.book.id);
              }
              final List<Unit> updatedUnits = List.from(
                widget.book.modules[modIdx].sections[secIdx].units,
              );
              updatedUnits[unitIdx] = unit.copyWith(
                isGenerated: false,
                lessons: [],
              );

              final List<Section> updatedSecs = List.from(
                widget.book.modules[modIdx].sections,
              );
              updatedSecs[secIdx] = updatedSecs[secIdx].copyWith(
                units: updatedUnits,
              );

              final List<Module> updatedMods = List.from(widget.book.modules);
              updatedMods[modIdx] = updatedMods[modIdx].copyWith(
                sections: updatedSecs,
              );

              final newBook = widget.book.copyWith(modules: updatedMods);
              await DatabaseService().saveGeneratedBook(newBook);
              widget.onBookUpdated(newBook);
            },
            child: const Text(
              'Regenerate',
              style: TextStyle(
                color: AppTheme.duoOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Long-press handler on a lesson node — asks the user to confirm, then
  /// regenerates JUST that one lesson (preserving its slot and id). Diagrams
  /// are re-rendered too when the user opts in. The previous lesson is kept
  /// if every model/key fails.
  Future<void> _promptRegenerateLesson(
    int modIdx,
    int secIdx,
    int unitIdx,
    int lessonIdx,
    Lesson lesson,
  ) async {
    final customPromptController = TextEditingController();
    final section = widget.book.modules[modIdx].sections[secIdx];
    final sectionFormats = widget.book.formatsForSection(section);
    String selectedFormatId = lesson.formatId ?? widget.book.defaultFormatId;

    // Ensure selectedFormatId is valid in the section's formats
    final bool isValidFormat = sectionFormats.any(
      (f) => f.id == selectedFormatId,
    );
    if (!isValidFormat && sectionFormats.isNotEmpty) {
      selectedFormatId = sectionFormats.first.id;
    }

    bool generateGraphics = true;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: context.colors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              title: Text(
                'Regenerate Lesson',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Replace "${lesson.title}" with a fresh version generated from the source PDF.',
                      style: TextStyle(
                        color: context.colors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'CUSTOM INSTRUCTIONS (OPTIONAL)',
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 6),
                    TextField(
                      controller: customPromptController,
                      maxLines: 3,
                      style: TextStyle(
                        color: context.colors.textPrimary,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText:
                            'e.g. Focus more on proofs, make explanation simpler, add more examples...',
                        hintStyle: TextStyle(
                          color: context.colors.textFaint,
                          fontSize: 13,
                        ),
                        filled: true,
                        fillColor: context.colors.surfaceAlt,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'LESSON FORMAT',
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 6),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: context.colors.surfaceAlt,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedFormatId,
                          dropdownColor: context.colors.surface,
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: context.colors.textFaint,
                          ),
                          style: TextStyle(
                            color: context.colors.textPrimary,
                            fontSize: 14,
                          ),
                          items: sectionFormats.map((f) {
                            return DropdownMenuItem<String>(
                              value: f.id,
                              child: Text('${f.name} (${f.description})'),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                selectedFormatId = val;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Generate diagrams',
                          style: TextStyle(
                            color: context.colors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Switch(
                          value: generateGraphics,
                          activeThumbColor: AppTheme.duoBlue,
                          onChanged: (val) {
                            setState(() {
                              generateGraphics = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
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
                  onPressed: () {
                    Navigator.pop(ctx, {
                      'customPrompt': customPromptController.text,
                      'newFormatId': selectedFormatId,
                      'generateGraphics': generateGraphics,
                    });
                  },
                  child: const Text(
                    'Regenerate',
                    style: TextStyle(
                      color: AppTheme.duoOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    if (result == null) return;
    if (!mounted) return;

    final String customPrompt = result['customPrompt'] as String;
    final String newFormatId = result['newFormatId'] as String;
    final bool genGraphics = result['generateGraphics'] as bool;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: context.colors.surface,
        content: Text(
          'Regenerating "${lesson.title}"…',
          style: TextStyle(color: context.colors.textPrimary),
        ),
        duration: const Duration(seconds: 3),
      ),
    );

    GenerationManager.instance.regenerateLesson(
      book: widget.book,
      modIdx: modIdx,
      secIdx: secIdx,
      unitIdx: unitIdx,
      lessonIdx: lessonIdx,
      generateGraphics: genGraphics,
      customPrompt: customPrompt.trim().isEmpty ? null : customPrompt.trim(),
      newFormatId: newFormatId,
      errorSink: (msg) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppTheme.duoRed.withValues(alpha: 0.85),
            content: Text(
              msg,
              style: TextStyle(color: context.colors.textPrimary),
            ),
          ),
        );
      },
    );
  }

  /// Asks whether to also render diagrams for this unit, then kicks off
  /// generation. Graphics are optional (and slower), so we let the user
  /// decide per unit instead of always generating them.
  Future<void> _promptAndGenerateUnit(
    Unit unit,
    int modIdx,
    int secIdx,
    int unitIdx,
  ) async {
    final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        title: Text(
          'Generate Lesson',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Choose when and how to generate lessons for this unit.',
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
          PopupMenuButton<Map<String, dynamic>>(
            onSelected: (val) => Navigator.pop(ctx, val),
            style: TextButton.styleFrom(foregroundColor: AppTheme.duoGreen),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                'Generate Now',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
          if (GlobalState.advancedModeNotifier.value)
            PopupMenuButton<Map<String, dynamic>>(
              onSelected: (val) => Navigator.pop(ctx, val),
              style: TextButton.styleFrom(foregroundColor: AppTheme.duoViolet),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  'Schedule',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
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
      unit,
      widget.book,
      modIdx,
      secIdx,
      unitIdx,
      generateGraphics: graphics,
      isScheduled: scheduled,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: context.colors.surface,
        content: Text(
          scheduled
              ? 'Lesson generation scheduled!'
              : 'Lesson generation queued!',
          style: TextStyle(color: context.colors.textPrimary),
        ),
      ),
    );
  }

  void _openQuickReview() {
    final mIdx = _activeModuleIdx.clamp(0, widget.book.modules.length - 1);
    final activeMod = widget.book.modules[mIdx];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return QuickReviewSheet(
          book: widget.book,
          modIdx: mIdx,
          module: activeMod,
          onBookUpdated: widget.onBookUpdated,
        );
      },
    );
  }

  void _openModuleSelector() {
    ModuleSelectorSheet.show(
      context: context,
      modules: widget.book.modules,
      activeModuleIdx: _activeModuleIdx,
      completedLessons: _completedLessons,
      onSelect: (idx) async {
        setState(() {
          _activeModuleIdx = idx;
          _activeSectionIdx = 0;
        });
        widget.activeModule?.value = _activeModuleIdx;
        widget.activeSection?.value = 0;
        try {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt(
            'last_mod_idx_${widget.book.id}',
            _activeModuleIdx,
          );
          await prefs.setInt(
            'last_sec_idx_${widget.book.id}',
            _activeSectionIdx,
          );
        } catch (e) {
          print('Error saving last resumed position: $e');
        }
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
        heightFactor:
            0.25 +
            0.2 *
                (widget.book.modules[_activeModuleIdx].sections.length < 2
                    ? widget.book.modules[_activeModuleIdx].sections.length
                    : 2),
        child: SectionBottomSheet(
          book: widget.book,
          activeModuleIdx: _activeModuleIdx,
          activeSectionIdx: _activeSectionIdx,
          completedLessons: _completedLessons,
          onSelect: (modIdx, secIdx) async {
            setState(() {
              _activeModuleIdx = modIdx;
              _activeSectionIdx = secIdx;
            });
            widget.activeModule?.value = _activeModuleIdx;
            widget.activeSection?.value = _activeSectionIdx;
            try {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setInt(
                'last_mod_idx_${widget.book.id}',
                _activeModuleIdx,
              );
              await prefs.setInt(
                'last_sec_idx_${widget.book.id}',
                _activeSectionIdx,
              );
            } catch (e) {
              print('Error saving last resumed position: $e');
            }
          },
          onSectionLongPress: (modIdx, secIdx) {
            _showSectionLongPressMenu(modIdx, secIdx);
          },
        ),
      ),
    );
  }

  bool _isSectionPdfMissing(Section sec) {
    if (kIsWeb) return true;
    final p = sec.pdfPath;
    if (p == null || p.isEmpty) return true;
    return !File(p).existsSync();
  }

  void _onSectionPdfPressed(Section sec) {
    if (!_isSectionPdfMissing(sec)) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) =>
              ReferencePdfViewerScreen(book: widget.book, initialSection: sec),
        ),
      );
    } else {
      _showMissingPdfDialog(sec);
    }
  }

  void _showMissingPdfDialog([Section? sec]) {
    final chunkError = sec?.chunkError;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            Icon(
              LucideIcons.fileWarning,
              color: AppTheme.duoOrange,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              chunkError != null
                  ? 'Section PDF Failed'
                  : 'Missing Reference PDF',
              style: TextStyle(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: Text(
          chunkError != null
              ? 'This section\'s PDF could not be created: $chunkError\n\nRestore the source PDF(s) to re-split, or use "Repair Page Alignment" in course settings if pages look shifted.'
              : 'The source PDF file for this section is missing on this device. Would you like to select and restore the source PDF(s) to view it?',
          style: TextStyle(color: context.colors.textSecondary, fontSize: 14),
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
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SourcePdfUploadScreen(book: widget.book),
                ),
              );
            },
            child: const Text(
              'Restore PDF(s)',
              style: TextStyle(
                color: AppTheme.duoBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionPdfBar(Section sec) {
    final isMissing = _isSectionPdfMissing(sec);
    // Knowledge-only sections never had a reference PDF — showing a
    // "missing reference" warning for them would be wrong.
    final hasReference = sec.hasSourceMapping;
    final hasSyllabus =
        widget.book.syllabusPath != null &&
        widget.book.syllabusPath!.isNotEmpty;
    final syllabusAvailable =
        hasSyllabus && File(widget.book.syllabusPath!).existsSync();

    if (!hasReference && !syllabusAvailable && !hasSyllabus) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          if (hasReference)
            Expanded(
              child: InkWell(
                onTap: () => _onSectionPdfPressed(sec),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: (isMissing ? AppTheme.duoOrange : AppTheme.duoBlue)
                        .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: (isMissing ? AppTheme.duoOrange : AppTheme.duoBlue)
                          .withValues(alpha: 0.35),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isMissing
                            ? LucideIcons.fileWarning
                            : LucideIcons.fileText,
                        size: 16,
                        color: isMissing
                            ? AppTheme.duoOrange
                            : AppTheme.duoBlue,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isMissing ? 'MISSING REFERENCE' : 'VIEW REFERENCE',
                        style: TextStyle(
                          color: isMissing
                              ? AppTheme.duoOrange
                              : AppTheme.duoBlue,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (syllabusAvailable) ...[
            if (hasReference) const SizedBox(width: 8),
            _buildSyllabusButton(expand: !hasReference),
          ] else if (hasSyllabus) ...[
            if (hasReference) const SizedBox(width: 8),
            _buildRestoreSyllabusButton(expand: !hasReference),
          ],
        ],
      ),
    );
  }

  Future<void> _handleRestoreSyllabus() async {
    final choice = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ctx.colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Restore Syllabus PDF',
          style: TextStyle(
            color: ctx.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Would you like to import the syllabus from your local device or search the cloud Document Store?',
          style: TextStyle(color: ctx.colors.textSecondary, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, 'device'),
            child: const Text(
              'Upload from Device',
              style: TextStyle(color: AppTheme.duoBlue),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, 'store'),
            child: const Text(
              'Document Store',
              style: TextStyle(
                color: AppTheme.duoGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (choice == 'device') {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );
        if (result != null && result.files.single.path != null) {
          final pickedFile = File(result.files.single.path!);
          final targetFile = File(widget.book.syllabusPath!);
          await targetFile.parent.create(recursive: true);
          await pickedFile.copy(targetFile.path);
          setState(() {});
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Syllabus PDF restored successfully!')),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to restore syllabus: $e')),
          );
        }
      }
    } else if (choice == 'store') {
      final configured = await B2Service.instance.isConfigured();
      if (!configured) {
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: ctx.colors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              'Cloud Storage Required',
              style: TextStyle(
                color: ctx.colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Backblaze B2 is not configured. Please setup cloud storage in the Document Store tab first.',
              style: TextStyle(color: ctx.colors.textSecondary),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: AppTheme.duoGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
        return;
      }

      if (!mounted) return;
      final B2Object? selected = await showDialog<B2Object>(
        context: context,
        builder: (ctx) => const DocumentStorePickerDialog(forSyllabus: true),
      );

      if (selected != null && mounted) {
        final File? downloadedFile = await showDialog<File>(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => DownloadProgressDialog(b2Obj: selected),
        );

        if (downloadedFile != null && downloadedFile.existsSync() && mounted) {
          final targetFile = File(widget.book.syllabusPath!);
          await targetFile.parent.create(recursive: true);
          await downloadedFile.copy(targetFile.path);
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Syllabus PDF restored from Document Store successfully!')),
          );
        }
      }
    }
  }

  Widget _buildRestoreSyllabusButton({required bool expand}) {
    final button = InkWell(
      onTap: _handleRestoreSyllabus,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: AppTheme.duoOrange.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.duoOrange.withValues(alpha: 0.35)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.fileWarning,
              size: 16,
              color: AppTheme.duoOrange,
            ),
            const SizedBox(width: 8),
            Text(
              'RESTORE SYLLABUS',
              style: TextStyle(
                color: AppTheme.duoOrange,
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );

    return expand ? Expanded(child: button) : button;
  }

  Widget _buildSyllabusButton({required bool expand}) {
    final button = InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(
                  '${widget.book.title} - Syllabus',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: context.colors.background,
              ),
              body: SafePdfViewer(file: File(widget.book.syllabusPath!)),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: AppTheme.duoGreen.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.duoGreen.withValues(alpha: 0.35)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.scroll, size: 16, color: AppTheme.duoGreen),
            SizedBox(width: 8),
            Text(
              'SYLLABUS',
              style: TextStyle(
                color: AppTheme.duoGreen,
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
    return expand ? Expanded(child: button) : button;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.book.modules.isEmpty) {
      return Scaffold(
        backgroundColor: context.colors.background,
        body: Center(
          child: Text(
            'This book is empty.',
            style: TextStyle(color: context.colors.textFaint),
          ),
        ),
      );
    }

    final mIdx = _activeModuleIdx.clamp(0, widget.book.modules.length - 1);
    final activeMod = widget.book.modules[mIdx];

    final sectionsCount = activeMod.sections.length;
    final sIdx = sectionsCount == 0
        ? 0
        : _activeSectionIdx.clamp(0, sectionsCount - 1);
    final activeSec = sectionsCount > 0 ? activeMod.sections[sIdx] : null;

    final Color sectionColor = activeSec != null
        ? SectionColors.base(activeSec.color)
        : AppTheme.duoBlue;

    return Scaffold(
      backgroundColor: context.colors.background,
      floatingActionButton: _buildFloatingTargetButton(),
      floatingActionButtonLocation: _CustomFloatingActionButtonLocation(
        FloatingActionButtonLocation.endFloat,
        offsetX: -12,
        offsetY: -93,
      ),
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
                        return Center(
                          child: Text(
                            'No sections available.',
                            style: TextStyle(color: context.colors.textFaint),
                          ),
                        );
                      }
                      // New-flow sections carry their own PDF chunk but don't
                      // have units yet. Planning is now user-triggered from the
                      // manifest panel (so they can tweak the planner
                      // instructions first) rather than auto-firing here.
                      final manifestTask = GenerationManager
                          .instance
                          .activeSectionManifests[activeSec.id];
                      return LessonPath(
                        section: activeSec,
                        book: widget.book,
                        modIdx: mIdx,
                        secIdx: sIdx,
                        loadingUnitStatuses:
                            GenerationManager.instance.activeUnitGenerations,
                        sectionManifestStatus: manifestTask,
                        completedLessons: _completedLessons,
                        hasMissingFiles: _hasMissingFiles,
                        topHeader: _buildSectionPdfBar(activeSec),
                        onLessonFinished: () {
                          _loadProgress();
                          widget.onBookUpdated(widget.book);
                        },
                        onMoveToNextSection: () {
                          final activeMod = widget.book.modules[_activeModuleIdx];
                          if (_activeSectionIdx + 1 < activeMod.sections.length) {
                            setState(() {
                              _activeSectionIdx++;
                            });
                            widget.activeSection?.value = _activeSectionIdx;
                          } else if (_activeModuleIdx + 1 < widget.book.modules.length) {
                            setState(() {
                              _activeModuleIdx++;
                              _activeSectionIdx = 0;
                            });
                            widget.activeModule?.value = _activeModuleIdx;
                            widget.activeSection?.value = _activeSectionIdx;
                          }
                        },
                        onGenerateUnit: (unit, unitIdx) {
                          _promptAndGenerateUnit(unit, mIdx, sIdx, unitIdx);
                        },
                        onClearUnit: (unit, unitIdx) {
                          _onClearUnit(unit, mIdx, sIdx, unitIdx);
                        },
                        onRegenerateLesson: (unitIdx, lessonIdx, lesson) {
                          _showLessonLongPressMenu(
                            mIdx,
                            sIdx,
                            unitIdx,
                            lessonIdx,
                            lesson,
                          );
                        },
                        onUnitLongPress: (unitIdx, unit) {
                          _showUnitLongPressMenu(mIdx, sIdx, unitIdx, unit);
                        },
                        onPlanManifest:
                            (instructions, selectedQuestions, saveGlobally) {
                              GenerationManager.instance
                                  .clearSectionManifestError(activeSec.id);
                              GenerationManager.instance
                                  .startSectionUnitManifest(
                                    widget.book,
                                    mIdx,
                                    sIdx,
                                    instructions: instructions,
                                    selectedQuestions: selectedQuestions,
                                    saveGlobally: saveGlobally,
                                  );
                            },
                        onEditFormats: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CourseSettingsScreen(
                                book: widget.book,
                                section: activeSec,
                                modIdx: mIdx,
                                secIdx: sIdx,
                              ),
                            ),
                          );
                          final freshest = await DatabaseService()
                              .getBookFromCache(widget.book.id);
                          if (freshest != null && mounted) {
                            widget.onBookUpdated(freshest);
                          }
                        },
                        onResetFormats: () async {
                          _showResetFormatsDialog(activeSec, mIdx, sIdx);
                        },
                        onConfirmFormats: (confirmedUnits) async {
                          // User signed off on per-unit format assignments.
                          // Persist them and flip the section's confirmation
                          // flag so the lesson path opens up.
                          final modules = List<Module>.from(
                            widget.book.modules,
                          );
                          final secs = List<Section>.from(
                            modules[mIdx].sections,
                          );
                          secs[sIdx] = secs[sIdx].copyWith(
                            units: confirmedUnits,
                            unitFormatsConfirmed: true,
                          );
                          modules[mIdx] = modules[mIdx].copyWith(
                            sections: secs,
                          );
                          final newBook = widget.book.copyWith(
                            modules: modules,
                          );
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
                  constraints: BoxConstraints(maxWidth: 720),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.colors.surfaceAlt,
                            border: Border(
                              left: BorderSide(color: context.colors.outline),
                              right: BorderSide(color: context.colors.outline),
                              bottom: BorderSide(color: context.colors.outline),
                            ),
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: context.colors.shadow,
                                blurRadius: 30,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              // Module book icon with chevron badge
                              _IconHeaderButton(
                                key: _coachModuleKey,
                                onTap: _openModuleSelector,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    const Icon(
                                      LucideIcons.bookOpen,
                                      color: AppTheme.duoBlue,
                                      size: 26,
                                    ),
                                    Positioned(
                                      bottom: -4,
                                      right: -4,
                                      child: Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: context.colors.surfaceAlt,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: context.colors.outline,
                                            width: 1,
                                          ),
                                        ),
                                        child: Icon(
                                          LucideIcons.chevronDown,
                                          size: 10,
                                          color: context.colors.textSecondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8),

                              // Section pill — flex-grow, border-b-2 in section color
                              if (activeSec != null)
                                Expanded(
                                  child: Material(
                                    key: _coachSectionKey,
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: _openSectionSelector,
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: context.colors.surfaceAlt,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border(
                                            bottom: BorderSide(
                                              color: sectionColor,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                activeSec.title.toUpperCase(),
                                                style: TextStyle(
                                                  color: context
                                                      .colors
                                                      .textPrimary,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w900,
                                                  letterSpacing: 1.6,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            Icon(
                                              LucideIcons.chevronDown,
                                              size: 16,
                                              color: context.colors.textSecondary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              else
                                Expanded(child: SizedBox.shrink()),
                              const SizedBox(width: 8),

                              // Quick Review Button
                              _IconHeaderButton(
                                key: _coachReviewKey,
                                onTap: _openQuickReview,
                                child: const Icon(
                                  LucideIcons.sparkles,
                                  color: AppTheme.duoGreen,
                                  size: 22,
                                ),
                              ),

                              const SizedBox(width: 8),

                              // XP chip
                              ValueListenableBuilder<int>(
                                valueListenable: GlobalState.xpNotifier,
                                builder: (context, xp, _) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: context.colors.surfaceAlt,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          LucideIcons.zap,
                                          size: 14,
                                          color: Color(0xFFFBBF24),
                                        ),
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

  void _showLessonLongPressMenu(
    int modIdx,
    int secIdx,
    int unitIdx,
    int lessonIdx,
    Lesson lesson,
  ) {
    final isCompleted = _completedLessons.contains(lesson.id);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
                  await ProgressService.markLessonCompleted(
                    lesson.id,
                    widget.book.id,
                  );
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
                  await ProgressService.clearLessonProgress(
                    lesson.id,
                    widget.book.id,
                  );
                  await _loadProgress();
                  widget.onBookUpdated(widget.book);
                },
              ),
            if (GlobalState.developerModeNotifier.value)
              _MenuActionItem(
                icon: LucideIcons.refreshCw,
                title: 'Regenerate Lesson',
                subtitle: 'Re-generate lesson from PDF chunk',
                iconColor: AppTheme.duoOrange,
                onTap: () {
                  Navigator.pop(ctx);
                  _promptRegenerateLesson(
                    modIdx,
                    secIdx,
                    unitIdx,
                    lessonIdx,
                    lesson,
                  );
                },
              ),
          ],
        );
      },
    );
  }

  void _showUnitLongPressMenu(
    int modIdx,
    int secIdx,
    int unitIdx,
    Unit unit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = 'prereqs_of_unit_${widget.book.id}_${unit.id}';
    final hasCache = prefs.containsKey(cacheKey);
    final cachedList = prefs.getStringList(cacheKey) ?? [];

    int totalLessons = unit.lessons.length;
    int completedCount = 0;
    int incompleteCount = 0;
    if (!unit.isGenerated || unit.lessons.isEmpty) {
      final isCompleted = _completedLessons.contains(unit.id);
      completedCount = isCompleted ? 1 : 0;
      incompleteCount = isCompleted ? 0 : 1;
    } else {
      completedCount = unit.lessons
          .where((l) => _completedLessons.contains(l.id))
          .length;
      incompleteCount = totalLessons - completedCount;
    }

    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return _buildLongPressMenu(
          title: unit.title,
          subtitle: 'Unit Menu',
          icon: LucideIcons.bookmark,
          color: AppTheme.duoViolet,
          items: [
            if (GlobalState.advancedModeNotifier.value)
              _MenuActionItem(
                icon: hasCache ? LucideIcons.gitMerge : LucideIcons.search,
                title: hasCache ? 'View Dependencies' : 'Search Dependencies',
                subtitle: hasCache
                    ? 'Show prerequisite units to study first'
                    : 'Scan all courses for prerequisites',
                iconColor: AppTheme.duoViolet,
                onTap: () {
                  Navigator.pop(ctx);
                  if (hasCache) {
                    _showPrerequisitesDialog(unit, cachedList);
                  } else {
                    _runDependencySearch(unit);
                  }
                },
              ),
            if (GlobalState.advancedModeNotifier.value)
              _MenuActionItem(
                icon: LucideIcons.plusCircle,
                title: 'Create Lesson',
                subtitle: 'Manually create a custom lesson under this unit',
                iconColor: AppTheme.duoBlue,
                onTap: () {
                  Navigator.pop(ctx);
                  _showCreateCustomLessonDialog(modIdx, secIdx, unitIdx, unit);
                },
              ),
            if (incompleteCount > 0)
              _MenuActionItem(
                icon: LucideIcons.checkCircle,
                title: 'Mark Unit as Finished',
                subtitle:
                    'Mark all $incompleteCount remaining lesson(s) (+${incompleteCount * 20} XP)',
                iconColor: AppTheme.duoGreen,
                onTap: () async {
                  Navigator.pop(ctx);
                  await ProgressService.markUnitCompleted(unit, widget.book.id);
                  await _loadProgress();
                  widget.onBookUpdated(widget.book);
                },
              ),
            if (completedCount > 0)
              _MenuActionItem(
                icon: LucideIcons.xCircle,
                title: 'Clear Unit Progress',
                subtitle:
                    'Lock and clear $completedCount completed lesson(s) (-${completedCount * 20} XP)',
                iconColor: AppTheme.duoRed,
                onTap: () async {
                  Navigator.pop(ctx);
                  await ProgressService.clearUnitProgress(unit, widget.book.id);
                  await _loadProgress();
                  widget.onBookUpdated(widget.book);
                },
              ),
            if (GlobalState.developerModeNotifier.value &&
                unit.isGenerated &&
                unit.lessons.isNotEmpty)
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

  Future<void> _showCreateCustomLessonDialog(
    int modIdx,
    int secIdx,
    int unitIdx,
    Unit unit,
  ) async {
    final promptController = TextEditingController();
    final List<File> selectedFiles = [];
    final section = widget.book.modules[modIdx].sections[secIdx];
    final sectionFormats = widget.book.formatsForSection(section);
    LessonFormat? selectedFormat = sectionFormats.isNotEmpty
        ? sectionFormats.first
        : null;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: context.colors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              title: Text(
                'Create Custom Lesson',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LESSON INSTRUCTIONS & TOPIC',
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 6),
                    TextField(
                      controller: promptController,
                      maxLines: 3,
                      style: TextStyle(
                        color: context.colors.textPrimary,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: 'What should this custom lesson cover?',
                        hintStyle: TextStyle(
                          color: context.colors.textFaint,
                          fontSize: 13,
                        ),
                        filled: true,
                        fillColor: context.colors.surfaceAlt,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'REFERENCE FILES (PDF/IMAGES)',
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectedFiles.isEmpty
                                ? 'No files selected'
                                : '${selectedFiles.length} file(s) added',
                            style: TextStyle(
                              color: selectedFiles.isEmpty
                                  ? context.colors.textFaint
                                  : AppTheme.duoGreen,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            final pickerResult = await FilePicker.platform
                                .pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: [
                                    'pdf',
                                    'png',
                                    'jpg',
                                    'jpeg',
                                  ],
                                  allowMultiple: true,
                                );
                            if (pickerResult != null) {
                              setState(() {
                                final newFiles = pickerResult.paths
                                    .where((p) => p != null)
                                    .map((p) => File(p!))
                                    .toList();
                                selectedFiles.addAll(newFiles);
                              });
                            }
                          },
                          icon: Icon(
                            LucideIcons.paperclip,
                            size: 16,
                            color: AppTheme.duoBlue,
                          ),
                          label: const Text(
                            'Add',
                            style: TextStyle(color: AppTheme.duoBlue),
                          ),
                        ),
                      ],
                    ),
                    if (selectedFiles.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Container(
                        constraints: BoxConstraints(maxHeight: 120),
                        decoration: BoxDecoration(
                          color: context.colors.surfaceAlt,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: selectedFiles.length,
                          itemBuilder: (context, idx) {
                            final f = selectedFiles[idx];
                            final name = f.path.split('/').last;
                            return ListTile(
                              dense: true,
                              title: Text(
                                name,
                                style: TextStyle(
                                  color: context.colors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  LucideIcons.trash2,
                                  size: 14,
                                  color: AppTheme.duoRed,
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedFiles.removeAt(idx);
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    SizedBox(height: 16),
                    Text(
                      'SLIDES FORMAT',
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: context.colors.surfaceAlt,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<LessonFormat>(
                                value: selectedFormat,
                                dropdownColor: context.colors.surface,
                                isExpanded: true,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: context.colors.textFaint,
                                ),
                                style: TextStyle(
                                  color: context.colors.textPrimary,
                                  fontSize: 13,
                                ),
                                items: sectionFormats.map((f) {
                                  return DropdownMenuItem<LessonFormat>(
                                    value: f,
                                    child: Text(
                                      f.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      selectedFormat = val;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        TextButton.icon(
                          onPressed: () async {
                            final newFormat = LessonFormat(
                              id: 'format-custom-${DateTime.now().millisecondsSinceEpoch}',
                              name: 'Custom Format',
                              description: 'Custom slide structure',
                              slides: List.of(SlideTemplate.defaultTemplate),
                            );
                            final edited = await Navigator.of(context)
                                .push<LessonFormat>(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        FormatEditorScreen(format: newFormat),
                                  ),
                                );
                            if (edited != null) {
                              final base = widget.book;
                              final updatedFormats = List<LessonFormat>.from(
                                base.formatsForSection(section),
                              )..add(edited);

                              final modules = List<Module>.from(base.modules);
                              final sections = List<Section>.from(
                                modules[modIdx].sections,
                              );
                              sections[secIdx] = sections[secIdx].copyWith(
                                lessonFormats: updatedFormats,
                              );
                              modules[modIdx] = modules[modIdx].copyWith(
                                sections: sections,
                              );
                              final newBook = base.copyWith(modules: modules);

                              await DatabaseService().saveGeneratedBook(
                                newBook,
                              );
                              widget.onBookUpdated(newBook);

                              setState(() {
                                selectedFormat = edited;
                              });
                            }
                          },
                          icon: Icon(
                            LucideIcons.plus,
                            size: 16,
                            color: AppTheme.duoBlue,
                          ),
                          label: const Text(
                            'New',
                            style: TextStyle(color: AppTheme.duoBlue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                  onPressed: () {
                    final prompt = promptController.text.trim();
                    if (prompt.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a lesson prompt.'),
                        ),
                      );
                      return;
                    }
                    if (selectedFormat == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a lesson format.'),
                        ),
                      );
                      return;
                    }
                    Navigator.pop(ctx, {
                      'prompt': prompt,
                      'files': selectedFiles,
                      'format': selectedFormat,
                    });
                  },
                  child: const Text(
                    'Create',
                    style: TextStyle(
                      color: AppTheme.duoGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    if (result == null) return;
    if (!mounted) return;

    final String prompt = result['prompt'] as String;
    final List<File> files = result['files'] as List<File>;
    final LessonFormat format = result['format'] as LessonFormat;

    final customLessonId =
        'lesson_custom_${DateTime.now().millisecondsSinceEpoch}';

    final customLesson = Lesson(
      id: customLessonId,
      title: 'Generating custom lesson...',
      description: prompt,
      icon: 'BookOpen',
      slides: [],
      formatId: format.id,
    );

    final base =
        (await DatabaseService().getBookFromCache(widget.book.id)) ??
        widget.book;
    final mods = List<Module>.from(base.modules);
    final secs = List<Section>.from(mods[modIdx].sections);
    final uns = List<Unit>.from(secs[secIdx].units);
    final lessons = List<Lesson>.from(uns[unitIdx].lessons)..add(customLesson);

    uns[unitIdx] = uns[unitIdx].copyWith(lessons: lessons, isGenerated: true);
    secs[secIdx] = secs[secIdx].copyWith(units: uns);
    mods[modIdx] = mods[modIdx].copyWith(sections: secs);
    final newBook = base.copyWith(modules: mods);

    await DatabaseService().saveGeneratedBook(newBook);
    widget.onBookUpdated(newBook);

    final size = MediaQuery.of(context).size;
    final screenSizeInfo =
        'Screen Width: ${size.width.toStringAsFixed(0)}px, Screen Height: ${size.height.toStringAsFixed(0)}px';

    await GenerationManager.instance.startCustomLessonGeneration(
      book: newBook,
      modIdx: modIdx,
      secIdx: secIdx,
      unitIdx: unitIdx,
      prompt: prompt,
      selectedFiles: files,
      format: format,
      lessonId: customLessonId,
      screenSizeInfo: screenSizeInfo,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: context.colors.surface,
        content: Text(
          'Custom lesson queued with top priority...',
          style: TextStyle(color: context.colors.textPrimary),
        ),
        duration: const Duration(seconds: 3),
      ),
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
                  widget.onBookUpdated(widget.book);
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
                  widget.onBookUpdated(widget.book);
                },
              ),
            if (section.units.isNotEmpty || section.unitsGenerated)
              _MenuActionItem(
                icon: LucideIcons.trash2,
                title: 'Remove Section Plan',
                subtitle: 'Delete all units & lessons to bring section back to planning stage',
                iconColor: AppTheme.duoRed,
                onTap: () async {
                  Navigator.pop(ctx);
                  await _confirmAndResetSectionPlan(modIdx, secIdx);
                },
              ),
          ],
        );
      },
    );
  }

  Future<void> _confirmAndResetSectionPlan(int modIdx, int secIdx) async {
    final section = widget.book.modules[modIdx].sections[secIdx];
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        title: Text(
          'Remove Section Plan?',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'This will delete all units, lessons, and custom formats for "${section.title}" and bring it back to the planning stage. Any lesson progress will be cleared.',
          style: TextStyle(color: context.colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Remove Plan',
              style: TextStyle(
                color: AppTheme.duoRed,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      // 1. Clear completed lessons/progress for this section
      await ProgressService.clearSectionProgress(section, widget.book.id);

      // 2. Clear units, unit flags, and custom formats
      final modules = List<Module>.from(widget.book.modules);
      final sections = List<Section>.from(modules[modIdx].sections);
      sections[secIdx] = sections[secIdx].copyWith(
        units: [],
        unitsGenerated: false,
        unitFormatsConfirmed: false,
        lessonFormats: [],
      );
      modules[modIdx] = modules[modIdx].copyWith(sections: sections);
      final newBook = widget.book.copyWith(modules: modules);

      // 3. Save and notify
      await DatabaseService().saveGeneratedBook(newBook);
      await _loadProgress(); // Reload local completedLessons set
      widget.onBookUpdated(newBook);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Section "${section.title}" plan removed and returned to planning stage.'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to reset section: $e')));
      }
    }
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
          isScheduled
              ? 'Schedule Section Generation'
              : 'Generate Section Contents',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Choose what kind of content to generate. This will automatically plan the section units and generate them sequentially.',
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
                  widget.onBookUpdated(widget.book);
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
                  widget.onBookUpdated(widget.book);
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

  Future<void> _showResetFormatsDialog(
    Section section,
    int modIdx,
    int secIdx,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.colors.surface,
          content: Row(
            children: [
              CircularProgressIndicator(),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  'AI is analyzing section PDF and generating custom formats...',
                  style: TextStyle(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    try {
      final generatedFormats = await AiService().generateSectionFormats(
        section,
      );

      if (mounted) {
        Navigator.of(context).pop();
      }

      final List<LessonFormat> finalFormats = [];
      for (final gf in generatedFormats) {
        final alreadyExists = finalFormats.any(
          (lf) =>
              lf.id == gf.id || lf.name.toLowerCase() == gf.name.toLowerCase(),
        );
        if (!alreadyExists) {
          finalFormats.add(gf);
        }
      }

      final modules = List<Module>.from(widget.book.modules);
      final sections = List<Section>.from(modules[modIdx].sections);
      sections[secIdx] = sections[secIdx].copyWith(lessonFormats: finalFormats);
      modules[modIdx] = modules[modIdx].copyWith(sections: sections);
      final newBook = widget.book.copyWith(modules: modules);
      await DatabaseService().saveGeneratedBook(newBook);
      widget.onBookUpdated(newBook);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Section lesson formats reset and generated successfully.',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
      }

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: context.colors.surface,
          title: Text(
            'Generation Failed',
            style: TextStyle(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            e.toString(),
            style: TextStyle(color: context.colors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _runDependencySearch(Unit unit) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Row(
          children: [
            CircularProgressIndicator(color: AppTheme.duoBlue),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                'Searching for dependencies across all courses...',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    try {
      final List<Book> books = await DatabaseService().fetchBooks(
        forceRefresh: false,
      );
      final List<String> result = await AiService().analyzePrerequisites(
        targetUnit: unit,
        targetBook: widget.book,
        allBooks: books,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        'prereqs_of_unit_${widget.book.id}_${unit.id}',
        result,
      );

      if (mounted) {
        Navigator.pop(context); // Dismiss loading dialog
        _showPrerequisitesDialog(unit, result);
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // Dismiss loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error finding prerequisites: $e'),
            backgroundColor: AppTheme.duoRed,
          ),
        );
      }
    }
  }

  void _showPrerequisitesDialog(Unit unit, List<String> uniqueIds) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(
        child: CircularProgressIndicator(color: AppTheme.duoBlue),
      ),
    );

    final List<UnitPrerequisite> prereqs = await _getPrerequisitesFromIds(
      uniqueIds,
    );

    if (mounted) {
      Navigator.pop(context); // dismiss spinner
    }

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: context.colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            'Prerequisites for "${unit.title}"',
            style: TextStyle(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: prereqs.isEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.checkCircle,
                      color: AppTheme.duoGreen,
                      size: 40,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'No prerequisites found! You\'re ready to start this unit.',
                      style: TextStyle(
                        color: context.colors.textSecondary,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          'Tap on a prerequisite to navigate to that unit.',
                          style: TextStyle(
                            color: context.colors.textFaint,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: prereqs.length,
                          itemBuilder: (context, idx) {
                            final p = prereqs[idx];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    _navigateToPrerequisite(p);
                                  },
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: context.colors.surfaceAlt,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: context.colors.outline,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                p.unitTitle,
                                                style: TextStyle(
                                                  color: context
                                                      .colors
                                                      .textPrimary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                '${p.bookTitle} / ${p.moduleTitle} / ${p.sectionTitle}',
                                                style: TextStyle(
                                                  color:
                                                      context.colors.textFaint,
                                                  fontSize: 10,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            4,
                                                          ),
                                                      child: LinearProgressIndicator(
                                                        value: p.completionRate,
                                                        backgroundColor: context
                                                            .colors
                                                            .surfaceAlt,
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                              Color
                                                            >(
                                                              p.completionRate >=
                                                                      1.0
                                                                  ? AppTheme
                                                                        .duoGreen
                                                                  : AppTheme
                                                                        .duoBlue,
                                                            ),
                                                        minHeight: 6,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    '${(p.completionRate * 100).toInt()}% (${p.completedLessonsCount}/${p.totalLessonsCount})',
                                                    style: TextStyle(
                                                      color:
                                                          p.completionRate >=
                                                              1.0
                                                          ? AppTheme.duoGreen
                                                          : context
                                                                .colors
                                                                .textSecondary,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Icon(
                                          LucideIcons.chevronRight,
                                          color: context.colors.textFaint,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                _runDependencySearch(unit); // Re-scan
              },
              child: Text(
                'Re-scan',
                style: TextStyle(
                  color: AppTheme.duoOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'Close',
                style: TextStyle(color: context.colors.textFaint),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _navigateToPrerequisite(UnitPrerequisite p) async {
    if (p.bookId == widget.book.id) {
      int? foundModIdx;
      int? foundSecIdx;
      for (int m = 0; m < widget.book.modules.length; m++) {
        final mod = widget.book.modules[m];
        if (mod.id == p.moduleId) {
          for (int s = 0; s < mod.sections.length; s++) {
            if (mod.sections[s].id == p.sectionId) {
              foundModIdx = m;
              foundSecIdx = s;
              break;
            }
          }
        }
        if (foundModIdx != null) break;
      }

      if (foundModIdx != null && foundSecIdx != null) {
        setState(() {
          _activeModuleIdx = foundModIdx!;
          _activeSectionIdx = foundSecIdx!;
        });
        widget.activeModule?.value = _activeModuleIdx;
        widget.activeSection?.value = _activeSectionIdx;

        try {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt(
            'last_mod_idx_${widget.book.id}',
            _activeModuleIdx,
          );
          await prefs.setInt(
            'last_sec_idx_${widget.book.id}',
            _activeSectionIdx,
          );
        } catch (e) {
          print('Error saving last resumed position: $e');
        }
      }
    } else {
      try {
        final List<Book> books = await DatabaseService().fetchBooks(
          forceRefresh: false,
        );
        Book? targetBook;
        for (final b in books) {
          if (b.id == p.bookId) {
            targetBook = b;
            break;
          }
        }

        if (targetBook != null) {
          int targetModIdx = 0;
          int targetSecIdx = 0;
          for (int m = 0; m < targetBook.modules.length; m++) {
            final mod = targetBook.modules[m];
            if (mod.id == p.moduleId) {
              targetModIdx = m;
              for (int s = 0; s < mod.sections.length; s++) {
                if (mod.sections[s].id == p.sectionId) {
                  targetSecIdx = s;
                  break;
                }
              }
              break;
            }
          }

          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('last_mod_idx_${targetBook.id}', targetModIdx);
          await prefs.setInt('last_sec_idx_${targetBook.id}', targetSecIdx);

          if (mounted) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MainLayoutScreen(
                  book: targetBook!,
                  initialModuleIdx: targetModIdx,
                ),
              ),
            );
          }
        }
      } catch (e) {
        print('Error navigating to different course prerequisite: $e');
      }
    }
  }

  Future<List<UnitPrerequisite>> _getPrerequisitesFromIds(
    List<String> ids,
  ) async {
    final List<Book> books = await DatabaseService().fetchBooks(
      forceRefresh: false,
    );
    final List<UnitPrerequisite> results = [];

    for (final id in ids) {
      final parts = id.split('::');
      if (parts.length != 4) continue;
      final bookId = parts[0];
      final moduleId = parts[1];
      final sectionId = parts[2];
      final unitId = parts[3];

      try {
        final book = books.firstWhere((b) => b.id == bookId);
        final module = book.modules.firstWhere((m) => m.id == moduleId);
        final section = module.sections.firstWhere((s) => s.id == sectionId);
        final unit = section.units.firstWhere((u) => u.id == unitId);

        final totalCount = unit.lessons.length;
        final completedCount = unit.lessons
            .where((l) => _completedLessons.contains(l.id))
            .length;
        final double completionRate = totalCount > 0
            ? (completedCount / totalCount)
            : 0.0;

        results.add(
          UnitPrerequisite(
            bookId: bookId,
            bookTitle: book.title,
            moduleId: moduleId,
            moduleTitle: module.title,
            sectionId: sectionId,
            sectionTitle: section.title,
            unitId: unitId,
            unitTitle: unit.title,
            completionRate: completionRate,
            completedLessonsCount: completedCount,
            totalLessonsCount: totalCount,
          ),
        );
      } catch (_) {
        // Book/module/section/unit might have been modified/deleted
      }
    }
    return results;
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
  const _IconHeaderButton({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(padding: const EdgeInsets.all(6), child: child),
      ),
    );
  }
}

class UnitPrerequisite {
  final String bookId;
  final String bookTitle;
  final String moduleId;
  final String moduleTitle;
  final String sectionId;
  final String sectionTitle;
  final String unitId;
  final String unitTitle;
  final double completionRate;
  final int completedLessonsCount;
  final int totalLessonsCount;

  UnitPrerequisite({
    required this.bookId,
    required this.bookTitle,
    required this.moduleId,
    required this.moduleTitle,
    required this.sectionId,
    required this.sectionTitle,
    required this.unitId,
    required this.unitTitle,
    required this.completionRate,
    required this.completedLessonsCount,
    required this.totalLessonsCount,
  });
}

class _CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  final FloatingActionButtonLocation location;
  final double offsetX;
  final double offsetY;

  const _CustomFloatingActionButtonLocation(
    this.location, {
    this.offsetX = 0,
    this.offsetY = 0,
  });

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final Offset offset = location.getOffset(scaffoldGeometry);
    return Offset(offset.dx + offsetX, offset.dy + offsetY);
  }
}