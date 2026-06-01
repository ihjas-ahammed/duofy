import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import '../screens/lesson_screen.dart';
import '../services/generation_manager.dart';
import '../utils/progress_utils.dart';
import 'lesson_node.dart';
import 'unit_header.dart';
import 'missing_files_banner.dart';

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
  /// Fired when the user long-presses a lesson node to regenerate the entire
  /// lesson. Receives the unit index inside the section, the lesson index
  /// inside the unit, and the lesson itself for confirmation copy. Null
  /// disables the affordance.
  final void Function(int unitIdx, int lessonIdx, Lesson lesson)? onRegenerateLesson;
  final void Function(int unitIdx, Unit unit)? onUnitLongPress;
  final List<String> completedLessons;
  final VoidCallback onLessonFinished;
  /// Status of the lazy unit-manifest call for this section (new flow).
  /// Null means no manifest call is in flight or needed.
  final UnitGenTask? sectionManifestStatus;
  /// Starts (or retries) the unit-manifest call with optional planner
  /// instructions captured on the panel. Replaces the old auto-trigger so the
  /// user can review/tweak the guidance before units are planned.
  final void Function(String? instructions, bool saveGlobally)? onPlanManifest;
  /// Commits the user\'s per-unit format selections and flips
  /// [Section.unitFormatsConfirmed] true so lessons become reachable.
  final void Function(List<Unit> confirmedUnits)? onConfirmFormats;
  final bool hasMissingFiles;

  const LessonPath({
    super.key,
    required this.section,
    required this.book,
    required this.modIdx,
    required this.secIdx,
    required this.loadingUnitStatuses,
    required this.onGenerateUnit,
    required this.onClearUnit,
    this.onRegenerateLesson,
    this.onUnitLongPress,
    required this.completedLessons,
    required this.onLessonFinished,
    this.sectionManifestStatus,
    this.onPlanManifest,
    this.onConfirmFormats,
    required this.hasMissingFiles,
  });

  @override
  State<LessonPath> createState() => _LessonPathState();
}

class _LessonPathState extends State<LessonPath> {
  final ScrollController _scrollController = ScrollController();
  String? _lastLessonId;
  bool _didScrollToLast = false;
  List<_Element> _elements = [];

  @override
  void initState() {
    super.initState();
    _loadLastLesson();
  }

  @override
  void didUpdateWidget(LessonPath oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.completedLessons.length < widget.completedLessons.length) {
      final newlyCompleted = widget.completedLessons.firstWhere(
        (id) => !oldWidget.completedLessons.contains(id),
        orElse: () => '',
      );
      if (newlyCompleted.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToNextElement(newlyCompleted);
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadLastLesson() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('last_lesson_id_${widget.book.id}');
      if (id != null && mounted) {
        setState(() {
          _lastLessonId = id;
        });
      }
    } catch (e) {
      print('Error loading last lesson ID: $e');
    }
  }

  void _scrollToNextElement(String completedId) {
    final currentIdx = _elements.indexWhere(
      (el) => el.kind == _ElementKind.lesson && el.lesson?.id == completedId,
    );
    if (currentIdx == -1) return;

    _Element? targetElement;
    for (int i = currentIdx + 1; i < _elements.length; i++) {
      final el = _elements[i];
      if (el.kind == _ElementKind.lesson) {
        targetElement = el;
        break;
      } else if (el.kind == _ElementKind.header) {
        final unit = el.unit!;
        final isGenerated = unit.isGenerated && unit.lessons.isNotEmpty;
        if (!isGenerated) {
          targetElement = el;
          break;
        }
      }
    }

    if (targetElement != null) {
      final targetY = targetElement.y;
      if (_scrollController.hasClients) {
        final viewportHeight = _scrollController.position.viewportDimension;
        double scrollPosition = (targetY - (viewportHeight / 2)).clamp(
          0.0,
          _scrollController.position.maxScrollExtent,
        );
        if (scrollPosition < 150) {
          scrollPosition = 0.0;
        }
        _scrollController.animateTo(
          scrollPosition,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOutCubic,
        );
      }
    }
  }

  static const double _pathWidth = 400;
  static const double _centerX = 200;
  static const double _zigOffset = 65;
  // Header height varies: when the unit is not yet generated the header shows
  // a tall "Generate Unit" button (~155px); once generated it collapses to a
  // shorter glass panel (~120px). Reserve enough space below it so the first
  // lesson node never collides with the title.
  static const double _headerHeightGenerated = 190;
  static const double _headerHeightNeedsGen = 250;
  static const double _nodeSpacing = 155;
  static const double _interUnitGap = 70;
  // Tighter gap used between consecutive units that have no lesson nodes yet
  // (not generated). Without this, ungenerated unit headers float far apart
  // because the full node-spacing slot is reserved even though nothing is
  // drawn below the header.
  static const double _interUnitGapUngenerated = 16;
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
        initialInstructions: widget.section.customInstructions ?? widget.book.customInstructions,
        onPlan: widget.onPlanManifest,
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
        sectionColor: color,
        onConfirm: widget.onConfirmFormats,
      );
    }

    final unlocked = _unlockedLessons();

    // First pass: layout (compute y positions and points)
    double y = _topPad;
    double? targetY;
    int globalIdx = 0;

    final List<_PathPoint> points = [];
    final List<_Element> elements = [];

    bool prevUnitHadNodes = false;
    for (int uIdx = 0; uIdx < widget.section.units.length; uIdx++) {
      final unit = widget.section.units[uIdx];
      final bool hasLessons = unit.lessons.isNotEmpty;
      final bool generating = widget.loadingUnitStatuses.containsKey(unit.id);
      final bool fullyGenerated = unit.isGenerated && hasLessons;
      // Use a tight gap when neither this nor the previous unit drew lesson
      // nodes, so a run of ungenerated unit headers stacks compactly.
      if (uIdx > 0) {
        y += (prevUnitHadNodes || hasLessons) ? _interUnitGap : _interUnitGapUngenerated;
      }

      elements.add(_Element.header(unit: unit, unitIdx: uIdx, y: y));
      // While generating (even with some lessons already streamed in) the
      // header still shows a progress bar, so keep the taller slot reserved.
      y += (fullyGenerated && !generating) ? _headerHeightGenerated : _headerHeightNeedsGen;

      // Render lesson nodes for any lessons we have so far — this is what
      // makes streamed lessons appear one-by-one during generation.
      if (hasLessons) {
        for (int lIdx = 0; lIdx < unit.lessons.length; lIdx++) {
          final lesson = unit.lessons[lIdx];
          double offset = 0;
          if (globalIdx % 4 == 1) offset = _zigOffset;
          if (globalIdx % 4 == 3) offset = -_zigOffset;

          final x = _centerX + offset;
          points.add(_PathPoint(x: x, y: y, id: lesson.id));
          elements.add(_Element.lesson(unit: unit, unitIdx: uIdx, lesson: lesson, lessonIdx: lIdx, x: x, y: y));

          if (lesson.id == _lastLessonId) {
            targetY = y;
          }

          y += _nodeSpacing;
          globalIdx++;
        }
      }
      prevUnitHadNodes = hasLessons;
    }

    _elements = elements;

    final double containerHeight = y + _bottomPad;

    if (targetY != null && !_didScrollToLast) {
      _didScrollToLast = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          final viewportHeight = _scrollController.position.viewportDimension;
          double scrollPosition = (targetY! - (viewportHeight / 2)).clamp(
            0.0,
            _scrollController.position.maxScrollExtent,
          );
          if (scrollPosition < 150) {
            scrollPosition = 0.0;
          }
          _scrollController.animateTo(
            scrollPosition,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          );
        }
      });
    }

    return SingleChildScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 28, bottom: 120),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _pathWidth),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.hasMissingFiles)
                MissingFilesBanner(book: widget.book),
              LayoutBuilder(
                builder: (context, constraints) {
                  final double width = constraints.maxWidth;
                  final double scaleX = width / _pathWidth;

                  // Build lesson widgets and header widgets separately so we can
                  // stack lessons FIRST and headers AFTER them — Stack draws later
                  // children on top, so this guarantees a unit header overlays any
                  // streamed-in lesson node that the generation-state header has
                  // grown over (the bug the layout reservation can't always
                  // prevent when the header runs taller than expected).
                  final lessonWidgets = <Widget>[];
                  final headerWidgets = <Widget>[];
                  for (final el in elements) {
                    if (el.kind == _ElementKind.header) {
                      final unit = el.unit!;
                      final loading = widget.loadingUnitStatuses[unit.id];
                      final isGenerated = unit.isGenerated && unit.lessons.isNotEmpty;
                      final unitPdfPath = unit.pdfPath ?? widget.section.pdfPath;
                      headerWidgets.add(Positioned(
                        left: 16,
                        right: 16,
                        top: el.y - 20,
                        child: GestureDetector(
                          onLongPress: widget.onUnitLongPress == null
                              ? null
                              : () => widget.onUnitLongPress!(el.unitIdx!, unit),
                          child: UnitHeader(
                            unit: unit,
                            isGenerated: isGenerated,
                            generationTask: loading,
                            referencePdfPath: unitPdfPath,
                            onGenerate: () => widget.onGenerateUnit(unit, el.unitIdx!),
                            onClear: () => widget.onClearUnit(unit, el.unitIdx!),
                          ),
                        ),
                      ));
                      continue;
                    }
                    final lesson = el.lesson!;
                    final isCompleted = widget.completedLessons.contains(lesson.id);
                    final isUnlocked = unlocked.contains(lesson.id);
                    final isActive = isUnlocked && !isCompleted;
                    final isLocked = !isCompleted && !isUnlocked;
                    const nodeSize = 80.0;
                    lessonWidgets.add(Positioned(
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
                          onLongPress: widget.onRegenerateLesson == null
                              ? null
                              : () => widget.onRegenerateLesson!(el.unitIdx!, el.lessonIdx!, lesson),
                          onTap: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('last_lesson_id_${widget.book.id}', lesson.id);
                            await prefs.setInt('last_mod_idx_${widget.book.id}', widget.modIdx);
                            await prefs.setInt('last_sec_idx_${widget.book.id}', widget.secIdx);

                            if (context.mounted) {
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
                            }
                          },
                        ),
                      ),
                    ));
                  }

                  return SizedBox(
                    width: width,
                    height: containerHeight,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // SVG-style curved connectors (always behind the nodes)
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
                        ...lessonWidgets,
                        ...headerWidgets,
                      ],
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

/// Shown when a new-flow section has no units yet. Three states based on
/// [task]: in-flight (spinner + status), errored (message + editable
/// instructions + retry), or idle (editable planner instructions + "Plan
/// units"). The instructions field is pre-filled from the book's custom
/// instructions and can be tweaked per-section before planning.
class _SectionManifestPanel extends StatefulWidget {
  final Section section;
  final UnitGenTask? task;
  final Color sectionColor;
  final String? initialInstructions;
  final void Function(String? instructions, bool saveGlobally)? onPlan;

  const _SectionManifestPanel({
    required this.section,
    required this.task,
    required this.sectionColor,
    required this.initialInstructions,
    required this.onPlan,
  });

  @override
  State<_SectionManifestPanel> createState() => _SectionManifestPanelState();
}

class _SectionManifestPanelState extends State<_SectionManifestPanel> {
  late final TextEditingController _ctrl;
  bool _saveGlobally = false;
  final Set<String> _selectedChips = {};
  final List<String> _chipOptions = [
    'Theory Heavy',
    'Practical Examples',
    'Exam Focused',
    'Step-by-Step Proofs',
    'Concise Summaries',
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initialInstructions ?? '');
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _plan() {
    final text = _ctrl.text.trim();
    final chips = _selectedChips.join(', ');
    String combined = text;
    if (chips.isNotEmpty) {
      combined = combined.isEmpty ? 'Style preferences: $chips' : 'Style preferences: $chips\n\n$combined';
    }
    widget.onPlan?.call(combined.isEmpty ? null : combined, _saveGlobally);
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    final sectionColor = widget.sectionColor;
    final isError = task?.isError ?? false;
    final isRunning = task != null && !isError;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 120),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
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
                    : (isRunning ? 'Planning units…' : 'Plan units for "${widget.section.title}"'),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                isError
                    ? (task?.status ?? 'Unknown error.')
                    : (isRunning
                        ? (task.status)
                        : 'Review the planning guidance below, then plan this section into units. This runs once; lessons stay per-unit and on-demand.'),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white60, fontSize: 13, height: 1.4),
              ),
              // Editable instructions + action are hidden while a call is
              // actively in flight, shown for the idle and error states.
              if (!isRunning) ...[
                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Objectives & Focus',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13)),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _chipOptions.map((chip) {
                    final isSelected = _selectedChips.contains(chip);
                    return ChoiceChip(
                      label: Text(chip, style: TextStyle(color: isSelected ? Colors.white : Colors.white54, fontSize: 12)),
                      selected: isSelected,
                      selectedColor: sectionColor.withOpacity(0.5),
                      backgroundColor: Colors.white.withOpacity(0.04),
                      side: BorderSide(color: isSelected ? sectionColor : Colors.white12),
                      onSelected: (val) {
                        setState(() {
                          if (val) _selectedChips.add(chip);
                          else _selectedChips.remove(chip);
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Additional instructions (optional)',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13)),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _ctrl,
                  maxLines: 4,
                  minLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'e.g. Emphasise derivations; one worked example per concept.',
                    hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.04),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  value: _saveGlobally,
                  onChanged: (val) => setState(() => _saveGlobally = val ?? false),
                  title: const Text('Save these preferences for all future units in this course', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: sectionColor,
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: widget.onPlan == null ? null : _plan,
                  icon: Icon(isError ? Icons.refresh : Icons.auto_awesome, size: 16),
                  label: Text(isError ? 'Try again' : 'Plan units',
                      style: const TextStyle(fontWeight: FontWeight.w900)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: sectionColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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

/// Per-unit confirmation panel shown right after the AI returns the unit
/// manifest. Lists the units that will be generated, along with a reference
/// of the available lesson formats. Tapping Confirm unlocks the lessons.
class _UnitFormatConfirmPanel extends StatelessWidget {
  final Section section;
  final List<LessonFormat> formats;
  final Color sectionColor;
  final void Function(List<Unit> confirmedUnits)? onConfirm;

  const _UnitFormatConfirmPanel({
    required this.section,
    required this.formats,
    required this.sectionColor,
    required this.onConfirm,
  });

  void _confirm() {
    onConfirm?.call(section.units);
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
                  color: sectionColor.withOpacity(0.18),
                  shape: BoxShape.circle,
                  border: Border.all(color: sectionColor.withOpacity(0.55), width: 2),
                ),
                child: Icon(Icons.tune, color: sectionColor, size: 26),
              ),
              const Text(
                'Confirm units',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
              ),
              const SizedBox(height: 6),
              const Text(
                'The AI has broken this section into the following units. Review the scope before generating lessons.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white60, fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 20),
              
              for (final unit in section.units)
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
                    ],
                  ),
                ),
                
              const SizedBox(height: 20),
              
              const Text(
                'Available lesson formats:',
                style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w800, fontSize: 13),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.02),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < formats.length; i++) ...[
                      if (i > 0) const Divider(color: Colors.white10, height: 16),
                      Text(
                        formats[i].name,
                        style: TextStyle(color: sectionColor, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        formats[i].description,
                        style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.4),
                      ),
                    ],
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _confirm,
                icon: const Icon(Icons.check, size: 18),
                label: const Text('Confirm and unlock units',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: sectionColor,
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
