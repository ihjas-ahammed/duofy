import 'dart:ui';

import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../screens/lesson_screen.dart';
import '../services/generation_manager.dart';
import 'lesson_node.dart';
import 'unit_header.dart';

class LessonPath extends StatelessWidget {
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

  Color _getPathColor() {
    switch (section.color) {
      case 'duo-green': return AppTheme.duoGreen;
      case 'duo-blue': return AppTheme.duoBlue;
      case 'duo-violet': return AppTheme.duoViolet;
      case 'duo-orange': return AppTheme.duoOrange;
      default: return AppTheme.duoBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    List<Offset> pathPoints = [];
    List<bool> nodeCompleted = [];

    double currentY = 40; 
    bool previousCompleted = true; // The very first lesson is always unlocked

    for (int i = 0; i < section.units.length; i++) {
      final unit = section.units[i];
      final int currentUnitIdx = i; 
      final bool isGenerated = unit.isGenerated && unit.lessons.isNotEmpty;
      final UnitGenTask? loadingStatus = loadingUnitStatuses[unit.id];

      // Compact Unit Header ensuring no overflows on small screens
      stackChildren.add(
        Positioned(
          top: currentY,
          left: 16,
          right: 16,
          child: UnitHeader(
            unit: unit,
            isGenerated: isGenerated,
            generationTask: loadingStatus,
            onGenerate: () => onGenerateUnit(unit, currentUnitIdx),
            onClear: () => onClearUnit(unit, currentUnitIdx),
          ),
        ),
      );

      // Expand distance dynamically based on header size, plus added padding
      currentY += isGenerated ? 120 : 190; 

      if (isGenerated) {
        for (int l = 0; l < unit.lessons.length; l++) {
          final lesson = unit.lessons[l];
          final bool isCompleted = completedLessons.contains(lesson.id);
          final bool isLocked = !previousCompleted && !isCompleted;
          
          final int phase = l % 4;
          double offsetX = 0;
          if (phase == 1) offsetX = 50; 
          if (phase == 3) offsetX = -50; 

          double centerX = MediaQuery.of(context).size.width / 2;
          double absoluteX = centerX + offsetX;

          pathPoints.add(Offset(absoluteX, currentY + 40)); 
          nodeCompleted.add(isCompleted || previousCompleted); // Current node acts visually 'reachable' if previous is completed

          stackChildren.add(
            Positioned(
              top: currentY,
              left: 0,
              right: 0,
              child: Transform.translate(
                offset: Offset(offsetX, 0),
                child: LessonNodeWidget(
                  lesson: lesson,
                  isCompleted: isCompleted,
                  isLocked: isLocked,
                  sectionColorStr: section.color,
                  onTap: () async {
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
                    await Navigator.push(context, MaterialPageRoute(
                      builder: (_) => LessonScreen(lesson: lesson)
                    ));
                    onLessonFinished();
                  },
                ),
              ),
            ),
          );

          currentY += 140; 
          previousCompleted = isCompleted;
        }
      }
      
      currentY += 40; // Add spacing bottom padding for each unit
    }

    stackChildren.insert(0, 
      Positioned.fill(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return CustomPaint(
              painter: CurvedPathPainter(
                points: pathPoints,
                nodeCompleted: nodeCompleted,
                pathColor: Colors.grey.shade800,
                activeColor: Colors.amber, 
                animationValue: value,
              ),
            );
          }
        ),
      )
    );

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: currentY + 120, // Extra padding for bottom nav
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: stackChildren,
        ),
      ),
    );
  }
}

class CurvedPathPainter extends CustomPainter {
  final List<Offset> points;
  final List<bool> nodeCompleted;
  final Color pathColor;
  final Color activeColor;
  final double animationValue;

  CurvedPathPainter({
    required this.points,
    required this.nodeCompleted,
    required this.pathColor,
    required this.activeColor,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final basePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14 
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];

      final path = Path();
      path.moveTo(p1.dx, p1.dy);
      
      double cy = (p1.dy + p2.dy) / 2;
      path.cubicTo(p1.dx, cy, p2.dx, cy, p2.dx, p2.dy);

      bool segmentCompleted = nodeCompleted.length > i+1 && nodeCompleted[i] && nodeCompleted[i+1];
      
      basePaint.color = pathColor;
      canvas.drawPath(path, basePaint);

      if (segmentCompleted) {
        PathMetrics metrics = path.computeMetrics();
        for (PathMetric metric in metrics) {
          Path extracted = metric.extractPath(0, metric.length * animationValue);
          basePaint.color = activeColor;
          canvas.drawPath(extracted, basePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CurvedPathPainter oldDelegate) => 
    oldDelegate.animationValue != animationValue || 
    oldDelegate.points.length != points.length;
}