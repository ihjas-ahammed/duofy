import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';

class FloatingStartBubble extends StatefulWidget {
  final Color color;
  const FloatingStartBubble({super.key, required this.color});

  @override
  State<FloatingStartBubble> createState() => _FloatingStartBubbleState();
}

class _FloatingStartBubbleState extends State<FloatingStartBubble> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat(reverse: true);
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
      builder: (ctx, child) => Transform.translate(
        offset: Offset(0, -6 * _ctrl.value),
        child: child,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: widget.color.withOpacity(0.5), blurRadius: 8, offset: const Offset(0, 4))
          ],
        ),
        child: Text(
          'START',
          style: TextStyle(color: widget.color, fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1.2),
        ),
      ),
    );
  }
}

class LessonNodeWidget extends StatelessWidget {
  final Lesson lesson;
  final bool isCompleted;
  final bool isLocked;
  final bool isActive;
  final String sectionColorStr;
  final VoidCallback onTap;

  const LessonNodeWidget({
    super.key,
    required this.lesson,
    required this.isCompleted,
    required this.isLocked,
    required this.isActive,
    required this.sectionColorStr,
    required this.onTap,
  });

  Color _getSectionColor() {
    switch (sectionColorStr) {
      case 'duo-green': return AppTheme.duoGreen;
      case 'duo-blue': return AppTheme.duoBlue;
      case 'duo-violet': return AppTheme.duoViolet;
      case 'duo-orange': return AppTheme.duoOrange;
      default: return AppTheme.duoBlue;
    }
  }

  Color _getSectionShadowColor() {
    switch (sectionColorStr) {
      case 'duo-green': return AppTheme.duoGreenDark;
      case 'duo-blue': return AppTheme.duoBlueDark;
      case 'duo-violet': return AppTheme.duoVioletDark;
      case 'duo-orange': return AppTheme.duoOrangeDark;
      default: return AppTheme.duoBlueDark;
    }
  }

  Color _getColor() {
    if (isLocked) return Colors.grey.shade800;
    if (isCompleted) return Colors.amber;
    return _getSectionColor();
  }

  Color _getShadowColor() {
    if (isLocked) return Colors.grey.shade900;
    if (isCompleted) return Colors.amber.shade700;
    return _getSectionShadowColor();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _getColor();
    final shadowColor = _getShadowColor();

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80, 
                height: 80, 
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: shadowColor, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: Icon(
                  isCompleted ? LucideIcons.check : (isLocked ? LucideIcons.lock : LucideIcons.star),
                  color: isLocked ? Colors.grey.shade500 : Colors.white,
                  size: 36, 
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), 
                decoration: AppTheme.glassDecoration,
                child: Text(
                  lesson.title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 11, 
                    fontWeight: FontWeight.w900,
                    color: Colors.white70,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          if (isActive)
            Positioned(
              top: -30,
              child: FloatingStartBubble(color: _getSectionColor()),
            )
        ],
      ),
    );
  }
}