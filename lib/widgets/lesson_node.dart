import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../utils/progress_utils.dart';

IconData getIconData(String? iconName) {
  switch (iconName) {
    case 'book-open':
    case 'BookOpen':
      return LucideIcons.bookOpen;
    case 'star':
    case 'Star':
      return LucideIcons.star;
    case 'zap':
    case 'Zap':
      return LucideIcons.zap;
    case 'flask-conical':
    case 'FlaskConical':
      return LucideIcons.flaskConical;
    default:
      return LucideIcons.bookOpen;
  }
}

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

  const LessonNodeWidget({
    super.key,
    required this.lesson,
    required this.isCompleted,
    required this.isLocked,
    required this.isActive,
    required this.isNextToStart,
    required this.sectionColorStr,
    required this.onTap,
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
    final sectionDark = SectionColors.dark(widget.sectionColorStr);

    Color bgColor;
    Color borderColor;
    Color iconColor;
    if (widget.isLocked) {
      bgColor = const Color(0xFF334155);
      borderColor = const Color(0xFF1E293B);
      iconColor = const Color(0xFF64748B);
    } else if (widget.isCompleted) {
      bgColor = const Color(0xFFFBBF24);
      borderColor = const Color(0xFFD97706);
      iconColor = Colors.white;
    } else {
      bgColor = sectionColor;
      borderColor = sectionDark;
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
