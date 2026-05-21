import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';

int calculateSectionProgress(Section section, List<String> completedLessons) {
  final allLessons = section.units.expand((u) => u.lessons).toList();
  if (allLessons.isEmpty) return 0;
  final done = allLessons.where((l) => completedLessons.contains(l.id)).length;
  return ((done / allLessons.length) * 100).round();
}

int calculateModuleProgress(Module module, List<String> completedLessons) {
  final allLessons = module.sections
      .expand((s) => s.units.expand((u) => u.lessons))
      .toList();
  if (allLessons.isEmpty) return 0;
  final done = allLessons.where((l) => completedLessons.contains(l.id)).length;
  return ((done / allLessons.length) * 100).round();
}

class SectionColors {
  static Color base(String name) {
    switch (name) {
      case 'duo-blue': return AppTheme.duoBlue;
      case 'duo-green': return AppTheme.duoGreen;
      case 'duo-red': return AppTheme.duoRed;
      case 'duo-violet': return AppTheme.duoViolet;
      case 'duo-orange': return AppTheme.duoOrange;
      case 'duo-gray': return const Color(0xFF9CA3AF);
      case 'duo-maroon': return const Color(0xFF800000);
      case 'duo-indigo': return const Color(0xFF6366F1);
      case 'duo-pink': return const Color(0xFFEC4899);
      default: return AppTheme.duoBlue;
    }
  }

  static Color dark(String name) {
    switch (name) {
      case 'duo-blue': return AppTheme.duoBlueDark;
      case 'duo-green': return AppTheme.duoGreenDark;
      case 'duo-red': return AppTheme.duoRedDark;
      case 'duo-violet': return AppTheme.duoVioletDark;
      case 'duo-orange': return AppTheme.duoOrangeDark;
      case 'duo-gray': return const Color(0xFF6B7280);
      case 'duo-maroon': return const Color(0xFF500000);
      case 'duo-indigo': return const Color(0xFF4F46E5);
      case 'duo-pink': return const Color(0xFFBE185D);
      default: return AppTheme.duoBlueDark;
    }
  }
}
