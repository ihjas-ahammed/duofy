import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';

// Helper to get LucideIcon by name
IconData getIconData(String? iconName) {
  switch (iconName) {
    case 'book-open': return LucideIcons.bookOpen;
    case 'star': return LucideIcons.star;
    case 'zap': return LucideIcons.zap;
    case 'flask-conical': return LucideIcons.flaskConical;
    default: return LucideIcons.bookOpen;
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
    if (widget.animate) {
      _ctrl.repeat();
    }
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
        // Pop bounce animation logic mimicking CSS keyframes
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
          child: Transform.scale(
            scale: scale,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

class LessonNodeWidget extends StatefulWidget {
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

  Color _getSectionColor() {
    switch (widget.sectionColorStr) {
      case 'duo-green': return AppTheme.duoGreen;
      case 'duo-blue': return AppTheme.duoBlue;
      case 'duo-violet': return AppTheme.duoViolet;
      case 'duo-orange': return AppTheme.duoOrange;
      default: return AppTheme.duoBlue;
    }
  }

  Color _getSectionShadowColor() {
    switch (widget.sectionColorStr) {
      case 'duo-green': return AppTheme.duoGreenDark;
      case 'duo-blue': return AppTheme.duoBlueDark;
      case 'duo-violet': return AppTheme.duoVioletDark;
      case 'duo-orange': return AppTheme.duoOrangeDark;
      default: return AppTheme.duoBlueDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color borderColor;
    Color iconColor;

    if (widget.isLocked) {
      bgColor = const Color(0xFF334155); // slate-700
      borderColor = const Color(0xFF1E293B); // slate-800
      iconColor = const Color(0xFF64748B); // slate-500
    } else if (widget.isCompleted) {
      bgColor = const Color(0xFFFBBF24); // amber-400
      borderColor = const Color(0xFFD97706); // amber-600
      iconColor = Colors.white;
    } else {
      bgColor = _getSectionColor();
      borderColor = _getSectionShadowColor();
      iconColor = Colors.white;
    }

    final double btnRadius = 80;
    final double borderBottom = 6;
    
    final double translateY = _isPressed && !widget.isLocked ? borderBottom : 0;
    final double currentBorderBottom = _isPressed && !widget.isLocked ? 0 : borderBottom;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
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
                child: Transform.translate(
                  offset: Offset(0, translateY),
                  child: Container(
                    width: btnRadius,
                    height: btnRadius,
                    decoration: BoxDecoration(
                      color: bgColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        if (widget.isActive)
                          BoxShadow(
                            color: bgColor.withOpacity(0.3),
                            spreadRadius: 4,
                          ),
                        if (widget.isActive)
                          const BoxShadow(
                            color: Color(0x26FFFFFF),
                            blurRadius: 20,
                            spreadRadius: 0,
                          ),
                      ],
                      border: Border(
                        top: BorderSide.none,
                        left: BorderSide.none,
                        right: BorderSide.none,
                        bottom: BorderSide(
                          color: borderColor,
                          width: currentBorderBottom,
                        )
                      )
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
                            top: -4,
                            right: -4,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFBBF24), // amber-400
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFFD97706), width: 2), // amber-600
                                boxShadow: const [
                                  BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                                ],
                              ),
                              child: const Icon(LucideIcons.crown, size: 14, color: Color(0xFF92400E)), // amber-800
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.surface.withOpacity(0.6),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))
                ],
              ),
              child: Opacity(
                opacity: widget.isLocked ? 0.5 : 1.0,
                child: Text(
                  widget.lesson.title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}