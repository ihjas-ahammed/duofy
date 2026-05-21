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

/// Single lesson node: 80x80 circular button + glass title pill below.
/// The title pill is overlaid via a non-clipping Stack so it can overflow
/// the 80px width and stay readable.
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

class _LessonNodeWidgetState extends State<LessonNodeWidget> {
  bool _isPressed = false;

  @override
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

    const double borderBottom = 6;
    final double translateY = (_isPressed && !widget.isLocked) ? borderBottom : 0;
    final double currentBorderBottom = (_isPressed && !widget.isLocked) ? 0 : borderBottom;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // Circular button
        NextNodePop(
          animate: widget.isNextToStart && !widget.isLocked,
          child: GestureDetector(
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) {
              setState(() => _isPressed = false);
              if (!widget.isLocked) widget.onTap();
            },
            onTapCancel: () => setState(() => _isPressed = false),
            child: Transform.translate(
              offset: Offset(0, translateY),
              child: Container(
                width: LessonNodeWidget.nodeSize,
                height: LessonNodeWidget.nodeSize,
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    if (widget.isActive)
                      BoxShadow(color: bgColor.withOpacity(0.3), spreadRadius: 4),
                    if (widget.isActive)
                      const BoxShadow(color: Color(0x26FFFFFF), blurRadius: 20),
                  ],
                  border: Border(
                    bottom: BorderSide(color: borderColor, width: currentBorderBottom),
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      getIconData(widget.lesson.icon),
                      color: iconColor,
                      size: 32,
                    ),
                    if (widget.isCompleted)
                      Positioned(
                        top: -8,
                        right: -8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFBBF24),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFD97706), width: 2),
                          ),
                          child: const Icon(LucideIcons.crown, size: 14, color: Color(0xFF92400E)),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Title pill below — allowed to overflow horizontally
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
