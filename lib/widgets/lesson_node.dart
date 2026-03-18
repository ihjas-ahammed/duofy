import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';

class LessonNodeWidget extends StatelessWidget {
  final Lesson lesson;
  final bool isCompleted;
  final bool isLocked;
  final String sectionColorStr;
  final VoidCallback onTap;

  const LessonNodeWidget({
    super.key,
    required this.lesson,
    required this.isCompleted,
    required this.isLocked,
    required this.sectionColorStr,
    required this.onTap,
  });

  Color _getColor() {
    if (isCompleted) return Colors.amber;
    switch (sectionColorStr) {
      case 'duo-green': return AppTheme.duoGreen;
      case 'duo-blue': return AppTheme.duoBlue;
      case 'duo-violet': return AppTheme.duoViolet;
      case 'duo-orange': return AppTheme.duoOrange;
      default: return AppTheme.duoBlue;
    }
  }

  Color _getShadowColor() {
    if (isCompleted) return Colors.amber.shade700;
    switch (sectionColorStr) {
      case 'duo-green': return AppTheme.duoGreenDark;
      case 'duo-blue': return AppTheme.duoBlueDark;
      case 'duo-violet': return AppTheme.duoVioletDark;
      case 'duo-orange': return AppTheme.duoOrangeDark;
      default: return AppTheme.duoBlueDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = isLocked ? Colors.grey.shade800 : _getColor();
    final shadowColor = isLocked ? Colors.grey.shade900 : _getShadowColor();

    return GestureDetector(
      onTap: onTap,
      child: Column(
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
              isLocked ? LucideIcons.lock : LucideIcons.bookOpen,
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
            ),
          )
        ],
      ),
    );
  }
}