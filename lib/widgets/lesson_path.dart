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
  final Book book;
  /// Indices of [section] within [book], used so the lesson screen can
  /// route regenerate-canvas calls back to the right slot in the model.
  final int modIdx;
  final int secIdx;
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
  /// Commits the user\'s per-unit format selections and flips
  /// [Section.unitFormatsConfirmed] true so lessons become reachable.
  final void Function(List<Unit> confirmedUnits)? onConfirmFormats;

  const LessonPath({
    super.key,
    required this.section,
    required this.book,
    required this.modIdx,
    required this.secIdx,
    required this.loadingUnitStatuses,
    required this.onGenerateUnit,
    required this.onClearUnit,
    required this.completedLessons,
    required this.onLessonFinished,
    this.sectionManifestStatus,
    this.onRetryManifest,
    this.onConfirmFormats,
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

    // Units exist but the user hasn\'t signed off on the per-unit format
    // assignments yet. Gate lessons behind a confirmation step so the
    // chosen pedagogical structure is explicit before any lesson is
    // generated.
    if (widget.section.needsFormatConfirmation) {
      return _UnitFormatConfirmPanel(
        section: widget.section,
        formats: widget.book.lessonFormats,
        defaultFormatId: widget.book.defaultFormatId,
        sectionColor: color,
        onConfirm: widget.onConfirmFormats,
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
        for (int lIdx = 0; lIdx < unit.lessons.length; lIdx++) {
          final lesson = unit.lessons[lIdx];
          double offset = 0;
          if (globalIdx % 4 == 1) offset = _zigOffset;
          if (globalIdx % 4 == 3) offset = -_zigOffset;

          final x = _centerX + offset;
          points.add(_PathPoint(x: x, y: y, id: lesson.id));
          elements.add(_Element.lesson(unit: unit, unitIdx: uIdx, lesson: lesson, lessonIdx: lIdx, x: x, y: y));

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
                                  builder: (_) => LessonScreen(
                                    lesson: lesson,
                                    book: widget.book,
                                    modIdx: widget.modIdx,
                                    secIdx: widget.secIdx,
                                    unitIdx: el.unitIdx!,
                                    lessonIdx: el.lessonIdx!,
                                  ),
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
  final int? lessonIdx;
  final double? x;
  final double y;

  _Element._({required this.kind, required this.y, this.unit, this.unitIdx, this.lesson, this.lessonIdx, this.x});

  factory _Element.header({required Unit unit, required int unitIdx, required double y}) =>
      _Element._(kind: _ElementKind.header, unit: unit, unitIdx: unitIdx, y: y);

  factory _Element.lesson({
    required Unit unit,
    required int unitIdx,
    required Lesson lesson,
    required int lessonIdx,
    required double x,
    required double y,
  }) =>
      _Element._(kind: _ElementKind.lesson, unit: unit, unitIdx: unitIdx, lesson: lesson, lessonIdx: lessonIdx, x: x, y: y);
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

/// Shown when a new-flow section has no units yet. Renders one of three
/// states based on [task]: in-flight (spinner + status), errored (retry
/// button), or waiting/preparing (idle hint that the trigger fires
/// automatically the moment the section is opened).
class _SectionManifestPanel extends StatelessWidget {
  final Section section;
  final UnitGenTask? task;
  final Color sectionColor;
  final VoidCallback? onRetry;

  const _SectionManifestPanel({
    required this.section,
    required this.task,
    required this.sectionColor,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final isError = task?.isError ?? false;
    final isRunning = task != null && !isError;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 72,
                height: 72,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: sectionColor.withOpacity(0.18),
                  shape: BoxShape.circle,
                  border: Border.all(color: sectionColor.withOpacity(0.5), width: 2),
                ),
                child: isError
                    ? const Icon(Icons.error_outline, color: Colors.amber, size: 32)
                    : (isRunning
                        ? SizedBox(
                            width: 28,
                            height: 28,
                            child: CircularProgressIndicator(color: sectionColor, strokeWidth: 3),
                          )
                        : Icon(Icons.auto_awesome, color: sectionColor, size: 28)),
              ),
              Text(
                isError
                    ? 'Couldn\'t plan units for this section'
                    : (isRunning ? 'Planning units…' : 'Preparing units for "${section.title}"'),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                isError
                    ? (task?.status ?? 'Unknown error.')
                    : (isRunning
                        ? (task?.status ?? 'AI is breaking this section into units.')
                        : 'This runs once. Lesson generation stays per-unit and on-demand.'),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white60, fontSize: 13, height: 1.4),
              ),
              if (isError && onRetry != null) ...[
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text('Try again', style: TextStyle(fontWeight: FontWeight.w900)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: sectionColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Per-unit lesson-format picker shown right after the AI returns the unit
/// manifest. Each unit row carries a dropdown defaulted to the AI\'s
/// suggested format (or the book default if none). Tapping Confirm hands
/// the updated unit list back to the parent, which persists it and flips
/// [Section.unitFormatsConfirmed] true so lessons become unlocked.
class _UnitFormatConfirmPanel extends StatefulWidget {
  final Section section;
  final List<LessonFormat> formats;
  final String defaultFormatId;
  final Color sectionColor;
  final void Function(List<Unit> confirmedUnits)? onConfirm;

  const _UnitFormatConfirmPanel({
    required this.section,
    required this.formats,
    required this.defaultFormatId,
    required this.sectionColor,
    required this.onConfirm,
  });

  @override
  State<_UnitFormatConfirmPanel> createState() => _UnitFormatConfirmPanelState();
}

class _UnitFormatConfirmPanelState extends State<_UnitFormatConfirmPanel> {
  late Map<String, String> _picked;

  @override
  void initState() {
    super.initState();
    _picked = {
      for (final u in widget.section.units)
        u.id: _resolveValid(u.formatId) ?? widget.defaultFormatId,
    };
  }

  String? _resolveValid(String? id) {
    if (id == null) return null;
    return widget.formats.any((f) => f.id == id) ? id : null;
  }

  void _confirm() {
    final updated = widget.section.units
        .map((u) => u.copyWith(formatId: _picked[u.id] ?? widget.defaultFormatId))
        .toList();
    widget.onConfirm?.call(updated);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: widget.sectionColor.withOpacity(0.18),
                  shape: BoxShape.circle,
                  border: Border.all(color: widget.sectionColor.withOpacity(0.55), width: 2),
                ),
                child: Icon(Icons.tune, color: widget.sectionColor, size: 26),
              ),
              const Text(
                'Confirm lesson formats',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
              ),
              const SizedBox(height: 6),
              const Text(
                'The AI picked one lesson format per unit based on its content. Review and adjust before any lesson is generated.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white60, fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 20),
              for (final unit in widget.section.units)
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(unit.title,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14)),
                      if (unit.description.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(unit.description,
                            style: const TextStyle(color: Colors.white54, fontSize: 12, height: 1.4),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ],
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _picked[unit.id],
                        isDense: true,
                        dropdownColor: const Color(0xFF1E293B),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          filled: true,
                          fillColor: Colors.black26,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                        ),
                        items: [
                          for (final f in widget.formats)
                            DropdownMenuItem(
                              value: f.id,
                              child: Text(f.name, style: const TextStyle(color: Colors.white)),
                            ),
                        ],
                        onChanged: (v) {
                          if (v != null) setState(() => _picked[unit.id] = v);
                        },
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _confirm,
                icon: const Icon(Icons.check, size: 18),
                label: const Text('Confirm and unlock lessons',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.sectionColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
