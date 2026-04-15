import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../screens/lesson_screen.dart';
import '../services/generation_manager.dart';
import 'lesson_node.dart';
import 'unit_header.dart';

class LessonPath extends StatefulWidget {
  final Section section;
  final Map<String, UnitGenTask> loadingUnitStatuses;
  final Function(Unit, int) onGenerateUnit;
  final Function(Unit, int) onClearUnit;
  final List<String> completedLessons;
  final VoidCallback onLessonFinished;

  const LessonPath({
    super.key,
    required this.section,
    required this.loadingUnitStatuses,
    required this.onGenerateUnit,
    required this.onClearUnit,
    required this.completedLessons,
    required this.onLessonFinished,
  });

  @override
  State<LessonPath> createState() => _LessonPathState();
}

class _LessonPathState extends State<LessonPath> {

  Set<String> _getUnlockedLessons() {
    Set<String> unlocked = {};
    for (var unit in widget.section.units) {
      for (int i = 0; i < unit.lessons.length; i++) {
        final lesson = unit.lessons[i];
        if (i == 0) {
          unlocked.add(lesson.id);
        } else {
          final prevId = unit.lessons[i - 1].id;
          if (widget.completedLessons.contains(prevId)) {
            unlocked.add(lesson.id);
          }
        }
      }
    }
    return unlocked;
  }

  Color _getSectionColor() {
    switch (widget.section.color) {
      case 'duo-green': return AppTheme.duoGreen;
      case 'duo-blue': return AppTheme.duoBlue;
      case 'duo-violet': return AppTheme.duoViolet;
      case 'duo-orange': return AppTheme.duoOrange;
      default: return AppTheme.duoBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final unlockedLessons = _getUnlockedLessons();
    final sectionColor = _getSectionColor();

    // Build a flat list of widgets: headers, nodes, connectors
    List<Widget> children = [];
    int globalLessonIdx = 0;

    for (int uIdx = 0; uIdx < widget.section.units.length; uIdx++) {
      final unit = widget.section.units[uIdx];
      final bool isGenerated = unit.isGenerated && unit.lessons.isNotEmpty;
      final UnitGenTask? loadingStatus = widget.loadingUnitStatuses[unit.id];

      if (uIdx > 0) children.add(const SizedBox(height: 32));

      // Unit Header
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: UnitHeader(
            unit: unit,
            isGenerated: isGenerated,
            generationTask: loadingStatus,
            onGenerate: () => widget.onGenerateUnit(unit, uIdx),
            onClear: () => widget.onClearUnit(unit, uIdx),
          ),
        ),
      );

      children.add(const SizedBox(height: 24));

      if (isGenerated) {
        for (int lIdx = 0; lIdx < unit.lessons.length; lIdx++) {
          final lesson = unit.lessons[lIdx];

          final bool isCompleted = widget.completedLessons.contains(lesson.id);
          final bool isUnlocked = unlockedLessons.contains(lesson.id);
          final bool isLocked = !isCompleted && !isUnlocked;
          final bool isActive = isUnlocked && !isCompleted;

          // Zig-zag horizontal offset for visual interest
          double offset = 0;
          if (globalLessonIdx % 4 == 1) offset = 50;
          if (globalLessonIdx % 4 == 3) offset = -50;

          // Connector line between nodes
          if (lIdx > 0 || (uIdx > 0 && lIdx == 0)) {
            // Determine connector color
            final prevCompleted = lIdx > 0
                ? widget.completedLessons.contains(unit.lessons[lIdx - 1].id)
                : false;
            final connectorColor = (prevCompleted && (isCompleted || isUnlocked))
                ? sectionColor
                : const Color(0xFF334155);

            children.add(
              Center(
                child: Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: connectorColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            );
          }

          children.add(
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(
                left: offset > 0 ? offset : 0,
                right: offset < 0 ? -offset : 0,
              ),
              child: Center(
                child: LessonNodeWidget(
                  lesson: lesson,
                  isCompleted: isCompleted,
                  isLocked: isLocked,
                  isActive: isActive,
                  isNextToStart: false,
                  sectionColorStr: widget.section.color,
                  onTap: () async {
                    await Navigator.push(context, MaterialPageRoute(
                      builder: (_) => LessonScreen(lesson: lesson),
                    ));
                    widget.onLessonFinished();
                  },
                ),
              ),
            ),
          );

          globalLessonIdx++;
        }
      }
    }

    // Bottom padding
    children.add(const SizedBox(height: 100));

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: children,
      ),
    );
  }
}