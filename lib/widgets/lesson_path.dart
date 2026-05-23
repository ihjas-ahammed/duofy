import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../screens/lesson_screen.dart';
import '../services/generation_manager.dart';
import '../utils/progress_utils.dart';
import 'lesson_node.dart';
import 'unit_header.dart';

/// LessonPath mirrors the React component:
/// - max width 400 px, centered
/// - lessons positioned with absolute x/y inside a Stack
/// - zig-zag horizontal offsets of ±65 px from x=200
/// - smooth S-curve connectors between consecutive nodes
/// - unit headers placed inline along the path
class LessonPath extends StatefulWidget {
  final Section section;
  final Map<String, UnitGenTask> loadingUnitStatuses;
  final Function(Unit, int) onGenerateUnit;
  final Function(Unit, int) onClearUnit;
  final List<String> completedLessons;
  final VoidCallback onLessonFinished;
  /// Status of the lazy unit-manifest call for this section (new flow).
  /// Null means no manifest call is in flight or needed.
  final UnitGenTask? sectionManifestStatus;
  /// Re-runs the unit-manifest call (used to recover from a failed manifest).
  final VoidCallback? onRetryManifest;

  const LessonPath({
    super.key,
    required this.section,
    required this.loadingUnitStatuses,
    required this.onGenerateUnit,
    required this.onClearUnit,
    required this.completedLessons,
    required this.onLessonFinished,
    this.sectionManifestStatus,
    this.onRetryManifest,
  });

  @override
  State<LessonPath> createState() => _LessonPathState();
}

class _LessonPathState extends State<LessonPath> {
  static const double _pathWidth = 400;
  static const double _centerX = 200;
  static const double _zigOffset = 65;
  // Header height varies: when the unit is not yet generated the header shows
  // a tall "Generate Unit" button (~155px); once generated it collapses to a
  // shorter glass panel (~120px). Reserve enough space below it so the first
  // lesson node never collides with the title.
  static const double _headerHeightGenerated = 180;
  static const double _headerHeightNeedsGen = 240;
  static const double _nodeSpacing = 155;
  static const double _interUnitGap = 70;
  static const double _topPad = 0;
  static const double _bottomPad = 40;

  Set<String> _unlockedLessons() {
    final Set<String> unlocked = {};
    for (final unit in widget.section.units) {
      for (int i = 0; i < unit.lessons.length; i++) {
        final lesson = unit.lessons[i];
        if (i == 0) {
          unlocked.add(lesson.id);
        } else if (widget.completedLessons.contains(unit.lessons[i - 1].id)) {
          unlocked.add(lesson.id);
        }
      }
    }
    return unlocked;
  }

  @override
  Widget build(BuildContext context) {
    final color = SectionColors.base(widget.section.color);

    // New-flow section that hasn\'t produced its units yet — show a manifest
    // panel instead of the (empty) lesson path. Status comes from the
    // GenerationManager via the parent.
    if (widget.section.units.isEmpty) {
      return _SectionManifestPanel(
        section: widget.section,
        task: widget.sectionManifestStatus,
        sectionColor: color,
        onRetry: widget.onRetryManifest,
      );
    }

    final unlocked = _unlockedLessons();

    // First pass: layout (compute y positions and points)
    double y = _topPad;
    int globalIdx = 0;

    final List<_PathPoint> points = [];
    final List<_Element> elements = [];

    for (int uIdx = 0; uIdx < widget.section.units.length; uIdx++) {
      if (uIdx > 0) y += _interUnitGap;
      final unit = widget.section.units[uIdx];
      final bool generated = unit.isGenerated && unit.lessons.isNotEmpty;

      elements.add(_Element.header(unit: unit, unitIdx: uIdx, y: y));
      y += generated ? _headerHeightGenerated : _headerHeightNeedsGen;

      if (generated) {
        for (final lesson in unit.lessons) {
          double offset = 0;
          if (globalIdx % 4 == 1) offset = _zigOffset;
          if (globalIdx % 4 == 3) offset = -_zigOffset;

          final x = _centerX + offset;
          points.add(_PathPoint(x: x, y: y, id: lesson.id));
          elements.add(_Element.lesson(unit: unit, lesson: lesson, x: x, y: y));

          y += _nodeSpacing;
          globalIdx++;
        }
      }
    }

    final double containerHeight = y + _bottomPad;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, bottom: 120),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _pathWidth),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double width = constraints.maxWidth;
              final double scaleX = width / _pathWidth;

              return SizedBox(
                width: width,
                height: containerHeight,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // SVG-style curved connectors
                    Positioned.fill(
                      child: IgnorePointer(
                        child: CustomPaint(
                          painter: _PathConnectorPainter(
                            points: points,
                            completed: widget.completedLessons,
                            unlocked: unlocked,
                            sectionColor: color,
                            scaleX: scaleX,
                          ),
                        ),
                      ),
                    ),
                    ...elements.map((el) {
                      if (el.kind == _ElementKind.header) {
                        final unit = el.unit!;
                        final loading = widget.loadingUnitStatuses[unit.id];
                        final isGenerated = unit.isGenerated && unit.lessons.isNotEmpty;
                        // Top-anchored at el.y; the slot below reserves
                        // _headerHeight{Generated,NeedsGen} of vertical space.
                        return Positioned(
                          left: 16,
                          right: 16,
                          top: el.y - 20,
                          child: UnitHeader(
                            unit: unit,
                            isGenerated: isGenerated,
                            generationTask: loading,
                            onGenerate: () => widget.onGenerateUnit(unit, el.unitIdx!),
                            onClear: () => widget.onClearUnit(unit, el.unitIdx!),
                          ),
                        );
                      }
                      // lesson
                      final lesson = el.lesson!;
                      final isCompleted = widget.completedLessons.contains(lesson.id);
                      final isUnlocked = unlocked.contains(lesson.id);
                      final isActive = isUnlocked && !isCompleted;
                      final isLocked = !isCompleted && !isUnlocked;
                      const nodeSize = 80.0;
                      // Center the node around (el.x * scaleX, el.y).
                      return Positioned(
                        left: (el.x! * scaleX) - (nodeSize / 2),
                        top: el.y - (nodeSize / 2),
                        child: SizedBox(
                          width: nodeSize,
                          child: LessonNodeWidget(
                            lesson: lesson,
                            isCompleted: isCompleted,
                            isLocked: isLocked,
                            isActive: isActive,
                            isNextToStart: false,
                            sectionColorStr: widget.section.color,
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LessonScreen(lesson: lesson),
                                ),
                              );
                              widget.onLessonFinished();
                            },
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PathPoint {
  final double x;
  final double y;
  final String id;
  _PathPoint({required this.x, required this.y, required this.id});
}

enum _ElementKind { header, lesson }

class _Element {
  final _ElementKind kind;
  final Unit? unit;
  final int? unitIdx;
  final Lesson? lesson;
  final double? x;
  final double y;

  _Element._({required this.kind, required this.y, this.unit, this.unitIdx, this.lesson, this.x});

  factory _Element.header({required Unit unit, required int unitIdx, required double y}) =>
      _Element._(kind: _ElementKind.header, unit: unit, unitIdx: unitIdx, y: y);

  factory _Element.lesson({required Unit unit, required Lesson lesson, required double x, required double y}) =>
      _Element._(kind: _ElementKind.lesson, unit: unit, lesson: lesson, x: x, y: y);
}

class _PathConnectorPainter extends CustomPainter {
  final List<_PathPoint> points;
  final List<String> completed;
  final Set<String> unlocked;
  final Color sectionColor;
  final double scaleX;

  static const Color _bgStroke = Color(0xFF334155); // slate-700
  static const Color _amber = Color(0xFFFBBF24);

  _PathConnectorPainter({
    required this.points,
    required this.completed,
    required this.unlocked,
    required this.sectionColor,
    required this.scaleX,
  });

  Path _segment(_PathPoint a, _PathPoint b) {
    final ax = a.x * scaleX;
    final bx = b.x * scaleX;
    final cy = (a.y + b.y) / 2;
    final p = Path()..moveTo(ax, a.y);
    p.cubicTo(ax, cy, bx, cy, bx, b.y);
    return p;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;
    final basePaint = Paint()
      ..color = _bgStroke
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    // Draw background tracks
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawPath(_segment(points[i], points[i + 1]), basePaint);
    }

    // Draw active/completed overlays
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final p1Done = completed.contains(p1.id);
      final p2Done = completed.contains(p2.id);
      final p2Unlocked = unlocked.contains(p2.id);
      final isActive = p1Done && (p2Done || p2Unlocked);
      if (!isActive) continue;

      final stroke = (p1Done && p2Done) ? _amber : sectionColor;
      final paint = Paint()
        ..color = stroke
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(_segment(p1, p2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _PathConnectorPainter old) {
    return old.points != points ||
        old.completed != completed ||
        old.unlocked != unlocked ||
        old.sectionColor != sectionColor ||
        old.scaleX != scaleX;
  }
}
