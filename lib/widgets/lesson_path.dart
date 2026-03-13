import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../screens/lesson_screen.dart';
import 'lesson_node.dart';

class LessonPath extends StatelessWidget {
  final Section section;

  const LessonPath({
    super.key,
    required this.section,
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

    double currentY = 30; // Added more top spacing
    int globalLessonIdx = 0;

    for (var unit in section.units) {
      // Add Glassy Unit Header with more padding
      stackChildren.add(
        Positioned(
          top: currentY,
          left: 20,
          right: 20,
          child: AppTheme.applyGlassBlur(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  Text(
                    unit.title.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.white, letterSpacing: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    unit.description,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white54),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      currentY += 130; // Increased space after header

      for (var lesson in unit.lessons) {
        final int phase = globalLessonIdx % 4;
        double offsetX = 0;
        if (phase == 1) offsetX = 65; // Wider zig-zag
        if (phase == 3) offsetX = -65; // Wider zig-zag

        double centerX = MediaQuery.of(context).size.width / 2;
        double absoluteX = centerX + offsetX;

        pathPoints.add(Offset(absoluteX, currentY + 40)); // 40 is half of the new 80px node

        stackChildren.add(
          Positioned(
            top: currentY,
            left: 0,
            right: 0,
            child: Transform.translate(
              offset: Offset(offsetX, 0),
              child: LessonNodeWidget(
                lesson: lesson,
                isCompleted: globalLessonIdx < 1,
                isLocked: globalLessonIdx > 1,
                sectionColorStr: section.color,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => LessonScreen(lesson: lesson)
                  ));
                },
              ),
            ),
          ),
        );

        currentY += 140; // Increased vertical spacing between nodes
        globalLessonIdx++;
      }
      
      currentY += 20; // Extra padding at the end of a unit
    }

    stackChildren.insert(0, 
      Positioned.fill(
        child: CustomPaint(
          painter: CurvedPathPainter(
            points: pathPoints,
            pathColor: Colors.grey.shade800,
            activeColor: _getPathColor(),
            activeIndex: 1, 
          ),
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
  final Color pathColor;
  final Color activeColor;
  final int activeIndex;

  CurvedPathPainter({
    required this.points,
    required this.pathColor,
    required this.activeColor,
    required this.activeIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14 // Thicker path
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];

      final path = Path();
      path.moveTo(p1.dx, p1.dy);
      
      double cy = (p1.dy + p2.dy) / 2;
      path.cubicTo(p1.dx, cy, p2.dx, cy, p2.dx, p2.dy);

      paint.color = (i < activeIndex) ? activeColor : pathColor;
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}