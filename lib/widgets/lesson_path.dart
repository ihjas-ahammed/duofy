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
    double amplitude = MediaQuery.of(context).size.width * 0.25; // Responsive snaking radius
    List<double> snakingPattern = [0, 0.45, 0.8, 0.45, 0, -0.45, -0.8, -0.45];

    for (int i = 0; i < section.units.length; i++) {
      final unit = section.units[i];
      final int currentUnitIdx = i; 
      final bool isGenerated = unit.isGenerated && unit.lessons.isNotEmpty;
      final UnitGenTask? loadingStatus = loadingUnitStatuses[unit.id];

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

      currentY += isGenerated ? 160 : 210; 

      if (isGenerated) {
        for (int l = 0; l < unit.lessons.length; l++) {
          final lesson = unit.lessons[l];
          final bool isCompleted = completedLessons.contains(lesson.id);
          final bool isLocked = !previousCompleted && !isCompleted;
          final bool isActive = previousCompleted && !isCompleted;
          
          double offsetX = snakingPattern[l % snakingPattern.length] * amplitude;

          double centerX = MediaQuery.of(context).size.width / 2;
          double absoluteX = centerX + offsetX;

          pathPoints.add(Offset(absoluteX, currentY + 50)); 
          nodeCompleted.add(isCompleted || previousCompleted);

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
                  isActive: isActive,
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

          currentY += 170; 
          previousCompleted = isCompleted;
        }
      }
      
      currentY += 40; 
    }

    stackChildren.insert(0, 
      Positioned.fill(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return CustomPaint(
              painter: CurvedPathPainter(
                points: pathPoints,
                nodeCompleted: nodeCompleted,
                pathColor: Colors.grey.shade800,
                activeColor: _getPathColor(), 
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
        height: currentY + 120, 
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
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

    final double trackWidth = 24.0;

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = trackWidth + 8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = pathColor.withOpacity(0.5);

    final fillPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = trackWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = pathColor;

    // Draw full background track
    final fullPath = Path();
    fullPath.moveTo(points[0].dx, points[0].dy);
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      double cy = (p1.dy + p2.dy) / 2;
      fullPath.cubicTo(p1.dx, cy, p2.dx, cy, p2.dx, p2.dy);
    }
    
    canvas.drawPath(fullPath, borderPaint);
    canvas.drawPath(fullPath, fillPaint);

    // Build completed active path
    final activePath = Path();
    activePath.moveTo(points[0].dx, points[0].dy);
    bool hasActiveSegments = false;

    for (int i = 0; i < points.length - 1; i++) {
      if (nodeCompleted[i] && nodeCompleted[i + 1]) {
        hasActiveSegments = true;
        final p1 = points[i];
        final p2 = points[i + 1];
        double cy = (p1.dy + p2.dy) / 2;
        activePath.cubicTo(p1.dx, cy, p2.dx, cy, p2.dx, p2.dy);
      }
    }

    if (hasActiveSegments) {
      PathMetrics metrics = activePath.computeMetrics();
      Path animatedActivePath = Path();
      
      for (PathMetric metric in metrics) {
        animatedActivePath.addPath(metric.extractPath(0, metric.length * animationValue), Offset.zero);
      }

      final activeBorderPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = trackWidth + 8
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = activeColor.withOpacity(0.4);

      final activeFillPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = trackWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = activeColor;

      canvas.drawPath(animatedActivePath, activeBorderPaint);
      canvas.drawPath(animatedActivePath, activeFillPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CurvedPathPainter oldDelegate) => 
    oldDelegate.animationValue != animationValue || 
    oldDelegate.points.length != points.length;
}