import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';

double calculateUnitProgress(Unit unit, List<String> completedLessons) {
  if (completedLessons.contains(unit.id)) {
    return 1.0;
  }
  if (!unit.isGenerated || unit.lessons.isEmpty) {
    return 0.0;
  }
  final done = unit.lessons.where((l) => completedLessons.contains(l.id)).length;
  return done / unit.lessons.length;
}

double calculateSectionProgressDouble(Section section, List<String> completedLessons) {
  if (completedLessons.contains(section.id)) {
    return 1.0;
  }
  if (section.units.isEmpty) {
    return 0.0;
  }
  double totalProgress = 0.0;
  for (final unit in section.units) {
    totalProgress += calculateUnitProgress(unit, completedLessons);
  }
  return totalProgress / section.units.length;
}

int calculateSectionProgress(Section section, List<String> completedLessons) {
  return (calculateSectionProgressDouble(section, completedLessons) * 100).round();
}

double calculateModuleProgressDouble(Module module, List<String> completedLessons) {
  if (completedLessons.contains(module.id)) {
    return 1.0;
  }
  if (module.sections.isEmpty) {
    return 0.0;
  }
  double totalProgress = 0.0;
  for (final section in module.sections) {
    totalProgress += calculateSectionProgressDouble(section, completedLessons);
  }
  return totalProgress / module.sections.length;
}

int calculateModuleProgress(Module module, List<String> completedLessons) {
  return (calculateModuleProgressDouble(module, completedLessons) * 100).round();
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
