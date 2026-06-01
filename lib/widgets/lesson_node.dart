import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../utils/progress_utils.dart';

/// Maps a string icon identifier (e.g. coming from AI-generated lesson JSON)
/// to a concrete [IconData]. Falls back to [LucideIcons.bookOpen] when the
/// name is missing or unknown. Accepts kebab-case, snake_case, PascalCase
/// and camelCase variants by normalising first.
IconData getIconData(String? iconName) {
  if (iconName == null || iconName.trim().isEmpty) return LucideIcons.bookOpen;
  // Normalise: lowercase, strip non-letters so 'Book-Open', 'book_open',
  // 'BookOpen' and 'bookOpen' all collapse to 'bookopen'.
  final key = iconName.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
  return _lessonIcons[key] ?? LucideIcons.bookOpen;
}

/// Canonical icon vocabulary the AI is allowed to choose from. The keys are
/// the normalised forms produced by [getIconData]; the [lessonIconChoices]
/// list below is the human-readable version used in prompts.
final Map<String, IconData> _lessonIcons = {
  // Books / general study
  'book': LucideIcons.book,
  'bookopen': LucideIcons.bookOpen,
  'bookmark': LucideIcons.bookmark,
  'filetext': LucideIcons.fileText,
  'scroll': LucideIcons.scroll,
  'clipboard': LucideIcons.clipboard,
  'pencil': LucideIcons.pencil,
  'feather': LucideIcons.feather,
  'graduationcap': LucideIcons.graduationCap,
  'lightbulb': LucideIcons.lightbulb,
  'brain': LucideIcons.brain,
  'sparkles': LucideIcons.sparkles,
  'star': LucideIcons.star,
  'trophy': LucideIcons.trophy,
  'medal': LucideIcons.medal,
  'award': LucideIcons.award,
  'target': LucideIcons.target,
  'crown': LucideIcons.crown,
  'gem': LucideIcons.gem,
  'wand': LucideIcons.wand,
  'puzzle': LucideIcons.puzzle,
  // Maths
  'calculator': LucideIcons.calculator,
  'function': LucideIcons.functionSquare,
  'functionsquare': LucideIcons.functionSquare,
  'variable': LucideIcons.variable,
  'infinity': LucideIcons.infinity,
  'sigma': LucideIcons.sigma,
  'pi': LucideIcons.pi,
  'percent': LucideIcons.percent,
  'plus': LucideIcons.plus,
  'minus': LucideIcons.minus,
  'divide': LucideIcons.divide,
  'equal': LucideIcons.equal,
  'hash': LucideIcons.hash,
  'piechart': LucideIcons.pieChart,
  'barchart': LucideIcons.barChart,
  'linechart': LucideIcons.lineChart,
  'trendingup': LucideIcons.trendingUp,
  // Physical sciences
  'atom': LucideIcons.atom,
  'orbit': LucideIcons.orbit,
  'rocket': LucideIcons.rocket,
  'magnet': LucideIcons.magnet,
  'zap': LucideIcons.zap,
  'flame': LucideIcons.flame,
  'thermometer': LucideIcons.thermometer,
  'flask': LucideIcons.flaskConical,
  'flaskconical': LucideIcons.flaskConical,
  'flaskround': LucideIcons.flaskRound,
  'beaker': LucideIcons.beaker,
  'microscope': LucideIcons.microscope,
  'circuitboard': LucideIcons.circuitBoard,
  'cpu': LucideIcons.cpu,
  // Life sciences
  'dna': LucideIcons.dna,
  'leaf': LucideIcons.leaf,
  'sprout': LucideIcons.sprout,
  'tree': LucideIcons.treeDeciduous,
  'treedeciduous': LucideIcons.treeDeciduous,
  'treepine': LucideIcons.treePine,
  'trees': LucideIcons.trees,
  'heart': LucideIcons.heart,
  'eye': LucideIcons.eye,
  'bone': LucideIcons.bone,
  'pill': LucideIcons.pill,
  'stethoscope': LucideIcons.stethoscope,
  'syringe': LucideIcons.syringe,
  // Earth / geography
  'globe': LucideIcons.globe,
  'map': LucideIcons.map,
  'sun': LucideIcons.sun,
  'moon': LucideIcons.moon,
  'cloud': LucideIcons.cloud,
  'wind': LucideIcons.wind,
  'droplets': LucideIcons.droplets,
  // History / humanities
  'history': LucideIcons.history,
  'landmark': LucideIcons.landmark,
  'swords': LucideIcons.swords,
  'shield': LucideIcons.shield,
  'languages': LucideIcons.languages,
  'messagecircle': LucideIcons.messageCircle,
  // Tech / engineering
  'code': LucideIcons.code,
  'database': LucideIcons.database,
  'key': LucideIcons.key,
  'lock': LucideIcons.lock,
  'wrench': LucideIcons.wrench,
  'hammer': LucideIcons.hammer,
  'cog': LucideIcons.cog,
  // Arts / media
  'palette': LucideIcons.palette,
  'paintbrush': LucideIcons.paintbrush,
  'paintbucket': LucideIcons.paintBucket,
  'image': LucideIcons.image,
  'camera': LucideIcons.camera,
  'video': LucideIcons.video,
  'film': LucideIcons.film,
  'music': LucideIcons.music,
  'mic': LucideIcons.mic,
  'drum': LucideIcons.drumstick,
  'drumstick': LucideIcons.drumstick,
  'radio': LucideIcons.radio,
  // Misc real-world
  'building': LucideIcons.building,
  'home': LucideIcons.home,
  'car': LucideIcons.car,
  'plane': LucideIcons.plane,
  'ship': LucideIcons.ship,
  'cake': LucideIcons.cake,
  'coffee': LucideIcons.coffee,
  'utensils': LucideIcons.utensils,
  'dice': LucideIcons.dices,
  'dices': LucideIcons.dices,
  'gamepad': LucideIcons.gamepad,
  'users': LucideIcons.users,
  'user': LucideIcons.user,
};

/// Human-readable list of icon names the AI is allowed to choose from. Kept
/// in sync with [_lessonIcons]. Surface this in prompts so the model picks
/// from the supported vocabulary.
const List<String> lessonIconChoices = [
  'book', 'book-open', 'bookmark', 'file-text', 'scroll',
  'clipboard', 'pencil', 'feather', 'graduation-cap', 'lightbulb', 'brain',
  'sparkles', 'star', 'trophy', 'medal', 'award', 'target', 'crown', 'gem',
  'wand', 'puzzle',
  'calculator', 'function', 'variable', 'infinity', 'sigma', 'pi', 'percent',
  'plus', 'minus', 'divide', 'equal', 'hash', 'pie-chart', 'bar-chart',
  'line-chart', 'trending-up',
  'atom', 'orbit', 'rocket', 'magnet', 'zap', 'flame',
  'thermometer', 'flask', 'beaker', 'microscope', 'circuit-board', 'cpu',
  'dna', 'leaf', 'sprout', 'tree', 'trees', 'heart', 'eye', 'bone', 'pill',
  'stethoscope', 'syringe',
  'globe', 'map', 'sun', 'moon', 'cloud', 'wind', 'droplets',
  'history', 'landmark', 'swords', 'shield', 'languages', 'message-circle',
  'code', 'database', 'key', 'lock', 'wrench', 'hammer', 'cog',
  'palette', 'paintbrush', 'paint-bucket', 'image', 'camera', 'video',
  'film', 'music', 'mic', 'drum', 'radio',
  'building', 'home', 'car', 'plane', 'ship', 'cake', 'coffee', 'utensils',
  'dice', 'gamepad', 'users', 'user',
];

class NextNodePop extends StatefulWidget {
  final Widget child;
  final bool animate;
  const NextNodePop({super.key, required this.child, required this.animate});

  @override
  State<NextNodePop> createState() => _NextNodePopState();
}

class _NextNodePopState extends State<NextNodePop> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    if (widget.animate) _ctrl.repeat();
  }

  @override
  void didUpdateWidget(NextNodePop oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !oldWidget.animate) {
      _ctrl.repeat();
    } else if (!widget.animate && oldWidget.animate) {
      _ctrl.stop();
      _ctrl.value = 0;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (ctx, child) {
        double scale = 1.0;
        double dy = 0.0;
        if (_ctrl.value < 0.1) {
          double t = _ctrl.value / 0.1;
          dy = -8 * t;
          scale = 1.0 + (0.05 * t);
        } else if (_ctrl.value < 0.2) {
          double t = (_ctrl.value - 0.1) / 0.1;
          dy = -8 * (1 - t);
          scale = 1.0 + (0.05 * (1 - t));
        }
        return Transform.translate(
          offset: Offset(0, dy),
          child: Transform.scale(scale: scale, child: child),
        );
      },
      child: widget.child,
    );
  }
}

/// Three-circle lesson node:
///   1. **Glow** — soft radial halo behind everything; subtle/dark when idle,
///      colored and pulsing when this is the next lesson to start.
///   2. **Shadow** — same-size disc as the body, offset downward by
///      [_depthOffset]. The exposed crescent at the bottom is the moon-style
///      shadow lip.
///   3. **Body** — bright disc with the icon. Sinks down onto the shadow when
///      pressed so the lip visually disappears.
class LessonNodeWidget extends StatefulWidget {
  static const double nodeSize = 80;
  static const double labelTopGap = 14;
  static const double labelWidth = 160;

  final Lesson lesson;
  final bool isCompleted;
  final bool isLocked;
  final bool isActive;
  final bool isNextToStart;
  final String sectionColorStr;
  final VoidCallback onTap;
  /// Long-press the node to surface destructive/maintenance actions
  /// (currently: regenerate this entire lesson). Null hides the affordance.
  final VoidCallback? onLongPress;

  const LessonNodeWidget({
    super.key,
    required this.lesson,
    required this.isCompleted,
    required this.isLocked,
    required this.isActive,
    required this.isNextToStart,
    required this.sectionColorStr,
    required this.onTap,
    this.onLongPress,
  });

  @override
  State<LessonNodeWidget> createState() => _LessonNodeWidgetState();
}

class _LessonNodeWidgetState extends State<LessonNodeWidget> with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _glowCtrl;

  static const double _depthOffset = 9;

  @override
  void initState() {
    super.initState();
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    if (widget.isActive) _glowCtrl.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(LessonNodeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final shouldGlow = widget.isActive;
    if (shouldGlow && !_glowCtrl.isAnimating) {
      _glowCtrl.repeat(reverse: true);
    } else if (!shouldGlow && _glowCtrl.isAnimating) {
      _glowCtrl.stop();
      _glowCtrl.value = 0;
    }
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final sectionColor = SectionColors.base(widget.sectionColorStr);

    Color bgColor;
    Color iconColor;
    if (widget.isLocked) {
      bgColor = const Color(0xFF334155);
      iconColor = const Color(0xFF64748B);
    } else if (widget.isCompleted) {
      bgColor = const Color(0xFFFBBF24);
      iconColor = Colors.white;
    } else {
      bgColor = sectionColor;
      iconColor = Colors.white;
    }

    final Color highlightColor = widget.isLocked
        ? Colors.white.withOpacity(0.06)
        : Colors.white.withOpacity(0.22);
    final Color rimShade = Colors.black.withOpacity(0.18);

    // When NOT pressed, the top face is shifted UP by _depthOffset.
    // When pressed, it shifts to 0, covering the shadow.
    final double topFaceOffset = (_isPressed && !widget.isLocked) ? 0 : -_depthOffset;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        NextNodePop(
          animate: widget.isNextToStart && !widget.isLocked,
          child: GestureDetector(
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) {
              setState(() => _isPressed = false);
              if (!widget.isLocked) widget.onTap();
            },
            onTapCancel: () => setState(() => _isPressed = false),
            onLongPress: (widget.onLongPress != null && !widget.isLocked)
                ? () {
                    setState(() => _isPressed = false);
                    widget.onLongPress!();
                  }
                : null,
            child: SizedBox(
              width: LessonNodeWidget.nodeSize,
              height: LessonNodeWidget.nodeSize,
              child: AnimatedBuilder(
                animation: _glowCtrl,
                builder: (context, _) {
                  final t = Curves.easeInOut.transform(_glowCtrl.value);

                  // GLOW dimensions / intensity depend on active state.
                  final bool active = widget.isActive && !widget.isLocked;
                  final double extra = active ? 14 + 8 * t : 10;
                  final double glowSize = LessonNodeWidget.nodeSize + extra * 2;
                  final Color glowColor = active ? bgColor : Colors.black;
                  final double glowOpacity = active
                      ? 0.35 + 0.30 * t
                      : (widget.isLocked ? 0.20 : 0.35);

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // 1. GLOW — circle behind everything.
                      Positioned(
                        left: -extra,
                        top: -extra,
                        width: glowSize,
                        height: glowSize,
                        child: IgnorePointer(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  glowColor.withOpacity(glowOpacity),
                                  glowColor.withOpacity(0),
                                ],
                                stops: const [0.42, 1.0],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // 2. The 3D Button Container
                      Positioned(
                        left: 0,
                        top: 0,
                        width: LessonNodeWidget.nodeSize,
                        height: LessonNodeWidget.nodeSize,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            children: [
                              // Circle 1: Background
                              Positioned.fill(
                                child: Container(
                                  color: bgColor,
                                ),
                              ),
                              
                              // Circle 2: Transparent black for shadow effect
                              Positioned.fill(
                                child: Container(
                                  color: Colors.black.withOpacity(0.2),
                                ),
                              ),

                              // Circle 3: Top face
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 80),
                                curve: Curves.easeOut,
                                left: 0,
                                top: topFaceOffset,
                                width: LessonNodeWidget.nodeSize,
                                height: LessonNodeWidget.nodeSize,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      center: const Alignment(-0.2, -0.55),
                                      radius: 0.95,
                                      colors: [
                                        Color.alphaBlend(highlightColor, bgColor),
                                        bgColor,
                                        Color.alphaBlend(rimShade, bgColor),
                                      ],
                                      stops: const [0.0, 0.55, 1.0],
                                    ),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      // glossy top sliver — sells the spherical feel
                                      Positioned(
                                        top: 6,
                                        left: 14,
                                        right: 14,
                                        height: 14,
                                        child: IgnorePointer(
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(40),
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.white.withOpacity(widget.isLocked ? 0.10 : 0.28),
                                                  Colors.white.withOpacity(0.0),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Icon perfectly centered in the overall node (both focus)
                              Positioned.fill(
                                child: Center(
                                  child: Icon(
                                    getIconData(widget.lesson.icon),
                                    color: iconColor,
                                    size: 34,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Crown badge — positioned at the top right of the perfect circle
                      if (widget.isCompleted)
                        Positioned(
                          top: -4,
                          right: -4,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFBBF24),
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFFD97706), width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.35),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(LucideIcons.crown, size: 14, color: Color(0xFF92400E)),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        // Title pill below
        Positioned(
          top: LessonNodeWidget.nodeSize + LessonNodeWidget.labelTopGap,
          left: (LessonNodeWidget.nodeSize - LessonNodeWidget.labelWidth) / 2,
          width: LessonNodeWidget.labelWidth,
          child: IgnorePointer(
            child: Opacity(
              opacity: widget.isLocked ? 0.5 : 1.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.03),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 30, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Text(
                      widget.lesson.title.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFE2E8F0),
                        height: 1.15,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
