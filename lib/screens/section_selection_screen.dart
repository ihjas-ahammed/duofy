import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/progress_service.dart';
import '../utils/progress_utils.dart';
import 'dart:ui';
import '../services/global_state.dart';
import '../services/generation_manager.dart';
import 'main_layout_screen.dart';
import '../services/deadline_service.dart';

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
  List<String> _completedLessons = [];
  bool _isLoading = true;
  Map<int, Map<String, dynamic>> _sectionTargets = {};
  int? _highlightedSectionIdx;
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _sectionKeys = {};

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
        });
      }
      await _loadDeadlines();
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      if (widget.initialHighlightSectionIdx != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(milliseconds: 400), () {
            _scrollToAndHighlight(widget.initialHighlightSectionIdx!);
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
    for (var sIdx = 0; sIdx < widget.module.sections.length; sIdx++) {
      final section = widget.module.sections[sIdx];
      int totalLessons = 0;
      if (section.units.isEmpty) {
        totalLessons = 12;
      } else {
        for (var u in section.units) {
          totalLessons += u.lessons.isEmpty ? 4 : u.lessons.length;
        }
      }
      final completedInSec = section.units.fold<int>(0, (sum, u) {
        return sum + u.lessons.where((l) => _completedLessons.contains(l.id)).length;
      });

      final metrics = await DeadlineService.instance.calculateSectionTarget(
        bookId: widget.book.id,
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
        title: const Text(
          'Select Section',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                      padding: const EdgeInsets.all(20),
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
                            style: TextStyle(
                              color: context.colors.textPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.module.description,
                            style: TextStyle(
                              color: context.colors.textFaint,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'SECTIONS IN THIS MODULE',
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    widget.module.sections.isEmpty
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
                            itemCount: widget.module.sections.length,
                            itemBuilder: (context, index) {
                              final section = widget.module.sections[index];
                              final Color sectionColor = SectionColors.base(
                                section.color,
                              );

                              final progress = calculateSectionProgressDouble(section, _completedLessons);
                              int totalLessons = 0;
                              if (section.units.isEmpty) {
                                totalLessons = 12;
                              } else {
                                for (var u in section.units) {
                                  totalLessons += u.lessons.isEmpty ? 4 : u.lessons.length;
                                }
                              }

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
                                  margin: const EdgeInsets.only(bottom: 16),
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
                                            book: widget.book,
                                            initialModuleIdx: widget.moduleIdx,
                                            initialSectionIdx: index,
                                          ),
                                        ),
                                      ).then((_) => _loadProgress());
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
                                              const SizedBox(width: 8),
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
                                            const SizedBox(height: 16),
                                            Container(
                                              padding: const EdgeInsets.all(12),
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
                                            const SizedBox(height: 12),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                              decoration: BoxDecoration(
                                                color: AppTheme.duoViolet.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: AppTheme.duoViolet.withOpacity(0.2)),
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
                                                              ? "Today's Target: $targetLeft lessons left"
                                                              : "Today's Target Completed! 🎉",
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
                                                    icon: const Icon(LucideIcons.edit2, size: 14),
                                                    onPressed: () => _showDeadlineMenu(index),
                                                    padding: EdgeInsets.zero,
                                                    constraints: const BoxConstraints(),
                                                    color: context.colors.textFaint,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ] else if (progress < 1.0) ...[
                                            const SizedBox(height: 12),
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
                                          const SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${section.units.length} Units • $totalLessons Lessons',
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

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDeadline ?? DateTime.now().add(const Duration(days: 7)),
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
            ),
            dialogBackgroundColor: context.colors.surface,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      await DeadlineService.instance.setSectionDeadline(
        widget.book.id,
        widget.moduleIdx,
        sectionIdx,
        picked,
      );
      await _loadDeadlines();
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

    final text = targetLeft > 0 
        ? "Today's Target: $targetLeft lessons left"
        : "Today's Target Completed! 🎉";

    return FloatingActionButton.extended(
      onPressed: () {
        _scrollToAndHighlight(currentSecIdx!);
      },
      backgroundColor: color,
      icon: const Icon(LucideIcons.target, color: Colors.white),
      label: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
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
              physics: const BouncingScrollPhysics(),
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
                                const SizedBox(width: 14),
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
                                      const SizedBox(height: 2),
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
