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
      backgroundColor: context.colors.background,
      appBar: AppBar(
        title: const Text(
          'Select Section',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
                    // Module Header Info
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

                    // Section Cards List
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

                              final progress = totalLessons > 0
                                  ? (completedCount / totalLessons)
                                  : 0.0;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: context.colors.surfaceAlt,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: context.colors.outline,
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
                                    );
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
                                            color: context.colors.textFaint,
                                            fontSize: 12,
                                            height: 1.4,
                                          ),
                                        ),

                                        // Display units inside the section (so the user knows there are multiple units!)
                                        if (section.units.isNotEmpty) ...[
                                          const SizedBox(height: 16),
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: context.colors.surfaceAlt,
                                              borderRadius:
                                                  BorderRadius.circular(12),
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
                                                                  (
                                                                    l,
                                                                  ) => _completedLessons
                                                                      .contains(
                                                                        l.id,
                                                                      ),
                                                                )
                                                                .length /
                                                            unit
                                                                .lessons
                                                                .length);
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          bottom: 6,
                                                        ),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          unitProgress >= 1.0
                                                              ? LucideIcons
                                                                    .checkCircle2
                                                              : LucideIcons
                                                                    .circle,
                                                          color:
                                                              unitProgress >=
                                                                  1.0
                                                              ? AppTheme
                                                                    .duoGreen
                                                              : context
                                                                    .colors
                                                                    .textFaint,
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
                                                    : context
                                                          .colors
                                                          .textSecondary,
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
