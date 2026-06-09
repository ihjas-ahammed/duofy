import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/generation_manager.dart';
import '../screens/lesson_screen.dart';
import 'unit_header.dart';

class LessonAccordion extends StatefulWidget {
  final Book book;
  final Map<String, UnitGenTask> loadingUnitStatuses;
  final List<String> completedLessons;
  final VoidCallback onLessonFinished;
  final Function(Unit, int, int, int) onGenerateUnit;
  final Function(Unit, int, int, int) onClearUnit;

  const LessonAccordion({
    super.key,
    required this.book,
    required this.loadingUnitStatuses,
    required this.completedLessons,
    required this.onLessonFinished,
    required this.onGenerateUnit,
    required this.onClearUnit,
  });

  @override
  State<LessonAccordion> createState() => _LessonAccordionState();
}

class _LessonAccordionState extends State<LessonAccordion> {
  String? _activeUnitId;

  @override
  void initState() {
    super.initState();
    _findActiveUnit();
  }

  void _findActiveUnit() {
    bool previousCompleted = true;
    for (var m in widget.book.modules) {
      for (var s in m.sections) {
        for (var u in s.units) {
          if (!u.isGenerated) continue;

          for (var l in u.lessons) {
            bool isCompleted = widget.completedLessons.contains(l.id);
            if (!isCompleted && previousCompleted) {
              _activeUnitId = u.id;
              return;
            }
            previousCompleted = isCompleted;
          }
        }
      }
    }
  }

  Color _getSectionColor(String colorStr) {
    switch (colorStr) {
      case 'duo-green': return AppTheme.duoGreen;
      case 'duo-blue': return AppTheme.duoBlue;
      case 'duo-violet': return AppTheme.duoViolet;
      case 'duo-orange': return AppTheme.duoOrange;
      default: return AppTheme.duoBlue;
    }
  }

  void _openLesson(
    Lesson lesson,
    bool isLocked, {
    required int modIdx,
    required int secIdx,
    required int unitIdx,
    required int lessonIdx,
  }) async {
    if (isLocked) {
      bool? preview = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppTheme.surface,
          title: const Text('Lesson Locked', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: const Text('You haven\'t completed the required previous lessons yet. Do you want to preview this lesson?', style: TextStyle(color: Colors.white70)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
            TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Preview', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold))),
          ]
        )
      );
      if (preview != true) return;
    }
    // Save resume point
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_lesson_id_${widget.book.id}', lesson.id);
    await prefs.setInt('last_mod_idx_${widget.book.id}', modIdx);
    await prefs.setInt('last_sec_idx_${widget.book.id}', secIdx);

    if (context.mounted) {
      await Navigator.push(context, MaterialPageRoute(
        builder: (_) => LessonScreen(
          lesson: lesson,
          book: widget.book,
          modIdx: modIdx,
          secIdx: secIdx,
          unitIdx: unitIdx,
          lessonIdx: lessonIdx,
        ),
      ));
      widget.onLessonFinished();
      _findActiveUnit();
    }
  }

  Widget _buildLessonTile(
    Lesson lesson,
    bool isCompleted,
    bool isLocked,
    bool isActive,
    Color secColor, {
    required int modIdx,
    required int secIdx,
    required int unitIdx,
    required int lessonIdx,
  }) {
    IconData iconData = isCompleted ? LucideIcons.checkCircle2 : (isLocked ? LucideIcons.lock : LucideIcons.playCircle);
    Color iconColor = isCompleted ? AppTheme.duoGreen : (isLocked ? Colors.white38 : secColor);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
      decoration: BoxDecoration(
        color: isCompleted ? AppTheme.duoGreen.withOpacity(0.05) : (isActive ? secColor.withOpacity(0.1) : Colors.transparent),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isActive ? secColor : (isCompleted ? AppTheme.duoGreen.withOpacity(0.3) : Colors.white10)),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          onTap: () => _openLesson(
            lesson,
            isLocked,
            modIdx: modIdx,
            secIdx: secIdx,
            unitIdx: unitIdx,
            lessonIdx: lessonIdx,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          leading: Icon(iconData, color: iconColor, size: 28),
          title: Text(
            lesson.title, 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: isLocked ? Colors.white54 : Colors.white
            ),
            maxLines: 1, overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            lesson.description, 
            style: TextStyle(color: Colors.white38, fontSize: 12, decoration: isCompleted ? TextDecoration.lineThrough : null),
            maxLines: 1, overflow: TextOverflow.ellipsis,
          ),
          trailing: isActive ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: secColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('START', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 1.2)),
          ) : null,
        ),
      ),
    );
  }

  Widget _buildPlaceholderLessonTile(int index, Color secColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        leading: Icon(LucideIcons.loader, color: secColor.withOpacity(0.4), size: 28),
        title: Text(
          'Lesson ${index + 1}: Planning Content...', 
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            color: Colors.white.withOpacity(0.3)
          ),
        ),
        subtitle: Text(
          'This lesson will be available soon.',
          style: TextStyle(color: Colors.white.withOpacity(0.15), fontSize: 12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listItems = [];
    bool previousCompleted = true;

    for (int m = 0; m < widget.book.modules.length; m++) {
      final module = widget.book.modules[m];
      
      listItems.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
          child: Text(
            module.title.toUpperCase(),
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.white54, letterSpacing: 1.5),
          ),
        )
      );

      for (int s = 0; s < module.sections.length; s++) {
        final section = module.sections[s];
        final secColor = _getSectionColor(section.color);

        for (int u = 0; u < section.units.length; u++) {
          final unit = section.units[u];
          final isGenerated = unit.isGenerated && unit.lessons.isNotEmpty;
          final generationTask = widget.loadingUnitStatuses[unit.id];
          final isQueuedOrRunning = generationTask != null;
          final isInterrupted = !unit.isGenerated && unit.lessons.isNotEmpty;
          final showExpandable = isGenerated || isQueuedOrRunning || isInterrupted;
          final isExpanded = _activeUnitId == unit.id;

          listItems.add(
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isExpanded ? secColor : Colors.white12, width: isExpanded ? 2 : 1),
              ),
              clipBehavior: Clip.hardEdge,
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: showExpandable 
                  ? ExpansionTile(
                      initiallyExpanded: isExpanded,
                      iconColor: secColor,
                      collapsedIconColor: Colors.white54,
                      title: Text(unit.title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                      subtitle: Text(unit.description, style: const TextStyle(fontSize: 12, color: Colors.white54)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            children: [
                              if (!isGenerated)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  child: UnitHeader(
                                    unit: unit,
                                    isGenerated: false,
                                    generationTask: generationTask,
                                    onGenerate: () => widget.onGenerateUnit(unit, m, s, u),
                                    onClear: () => widget.onClearUnit(unit, m, s, u),
                                    book: widget.book,
                                  ),
                                ),
                              ...(() {
                                final List<Widget> children = [];
                                final bool showPlaceholders = isQueuedOrRunning || isInterrupted;
                                final int totalPlanned = showPlaceholders
                                    ? (generationTask?.plannedLessonsCount ?? (unit.lessons.isNotEmpty ? unit.lessons.length + 3 : 4))
                                    : unit.lessons.length;
                                for (int lIdx = 0; lIdx < totalPlanned; lIdx++) {
                                  if (lIdx < unit.lessons.length) {
                                    final lesson = unit.lessons[lIdx];
                                    final bool isCompleted = widget.completedLessons.contains(lesson.id);
                                    final bool isLocked = !previousCompleted && !isCompleted;
                                    final bool isActive = previousCompleted && !isCompleted;
                                    children.add(_buildLessonTile(
                                      lesson, isCompleted, isLocked, isActive, secColor,
                                      modIdx: m, secIdx: s, unitIdx: u, lessonIdx: lIdx,
                                    ));
                                    previousCompleted = isCompleted;
                                  } else {
                                    children.add(_buildPlaceholderLessonTile(lIdx, secColor));
                                  }
                                }
                                return children;
                              })(),
                            ],
                          ),
                        )
                      ],
                    )
                  : UnitHeader(
                      unit: unit,
                      isGenerated: false,
                      generationTask: generationTask,
                      onGenerate: () => widget.onGenerateUnit(unit, m, s, u),
                      onClear: () {}, // Not needed for ungenerated unit
                      book: widget.book,
                    ),
              ),
            )
          );
        }
      }
    }

    listItems.add(const SizedBox(height: 120)); // bottom nav padding

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: listItems,
    );
  }
}