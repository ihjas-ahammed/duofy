import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class DeadlineService {
  DeadlineService._();
  static final DeadlineService instance = DeadlineService._();

  String _getDeadlineKey(String bookId, int moduleIdx, int sectionIdx) {
    return 'deadline_section_${bookId}_${moduleIdx}_$sectionIdx';
  }

  String _getStartDayCompletedKey(String bookId, int moduleIdx, int sectionIdx, String dateStr) {
    return 'start_day_completed_${bookId}_${moduleIdx}_${sectionIdx}_$dateStr';
  }

  String _getTodayStr() {
    return DateTime.now().toLocal().toIso8601String().substring(0, 10);
  }

  Future<void> setSectionDeadline(
    String bookId,
    int moduleIdx,
    int sectionIdx,
    DateTime deadline,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _getDeadlineKey(bookId, moduleIdx, sectionIdx),
      deadline.toIso8601String(),
    );
  }

  Future<DateTime?> getSectionDeadline(
    String bookId,
    int moduleIdx,
    int sectionIdx,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final val = prefs.getString(_getDeadlineKey(bookId, moduleIdx, sectionIdx));
    if (val == null) return null;
    return DateTime.tryParse(val);
  }

  Future<void> clearSectionDeadline(
    String bookId,
    int moduleIdx,
    int sectionIdx,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_getDeadlineKey(bookId, moduleIdx, sectionIdx));
    // Clean up start day metrics as well
    final todayStr = _getTodayStr();
    await prefs.remove(_getStartDayCompletedKey(bookId, moduleIdx, sectionIdx, todayStr));
  }

  Future<Map<String, dynamic>> calculateSectionTarget({
    required String bookId,
    required int moduleIdx,
    required int sectionIdx,
    required int totalLessons,
    required int currentCompleted,
  }) async {
    final deadline = await getSectionDeadline(bookId, moduleIdx, sectionIdx);
    if (deadline == null) {
      return {'hasDeadline': false};
    }

    final todayStr = _getTodayStr();
    final prefs = await SharedPreferences.getInstance();
    final startDayCompletedKey = _getStartDayCompletedKey(bookId, moduleIdx, sectionIdx, todayStr);

    // Initialize start day completed if it doesn't exist
    int startDayCompleted = prefs.getInt(startDayCompletedKey) ?? -1;
    if (startDayCompleted == -1) {
      startDayCompleted = currentCompleted;
      await prefs.setInt(startDayCompletedKey, currentCompleted);
    }

    // Calculate days left (end of deadline day inclusive)
    final now = DateTime.now().toLocal();
    final localDeadline = DateTime(deadline.year, deadline.month, deadline.day, 23, 59, 59);
    final diff = localDeadline.difference(now);
    final daysLeft = diff.isNegative ? 0 : diff.inDays + 1;

    final initialRemaining = max(0, totalLessons - startDayCompleted);
    final todayTarget = daysLeft > 0 ? (initialRemaining / daysLeft).ceil() : initialRemaining;
    final completedToday = max(0, currentCompleted - startDayCompleted);
    final targetLeftToday = max(0, todayTarget - completedToday);
    final lessonsLeft = max(0, totalLessons - currentCompleted);

    return {
      'hasDeadline': true,
      'deadline': deadline,
      'daysLeft': daysLeft,
      'todayTarget': todayTarget,
      'completedToday': completedToday,
      'targetLeftToday': lessonsLeft == 0 ? 0 : targetLeftToday,
      'lessonsLeft': lessonsLeft,
    };
  }

  /// Finds the earliest/most urgent target section with a deadline in a book.
  Future<Map<String, dynamic>?> getMostUrgentActiveTarget(
    String bookId,
    dynamic book, // Book model type
    List<String> completedLessons,
  ) async {
    DateTime? earliestDeadline;
    int? targetModuleIdx;
    int? targetSectionIdx;
    Map<String, dynamic>? targetMetrics;

    for (var mIdx = 0; mIdx < book.modules.length; mIdx++) {
      final module = book.modules[mIdx];
      for (var sIdx = 0; sIdx < module.sections.length; sIdx++) {
        final section = module.sections[sIdx];
        int totalLessons = 0;
        if (section.units.isEmpty) {
          totalLessons = 12;
        } else {
          for (var u in section.units) {
            totalLessons += u.lessons.isEmpty ? 4 : u.lessons.length;
          }
        }
        final completedInSec = section.units.fold<int>(0, (sum, u) {
          return sum + u.lessons.where((l) => completedLessons.contains(l.id)).length;
        });

        if (completedInSec >= totalLessons) continue; // Already fully completed

        final metrics = await calculateSectionTarget(
          bookId: bookId,
          moduleIdx: mIdx,
          sectionIdx: sIdx,
          totalLessons: totalLessons,
          currentCompleted: completedInSec,
        );

        if (metrics['hasDeadline'] == true) {
          final DateTime dl = metrics['deadline'];
          if (earliestDeadline == null || dl.isBefore(earliestDeadline)) {
            earliestDeadline = dl;
            targetModuleIdx = mIdx;
            targetSectionIdx = sIdx;
            targetMetrics = metrics;
          }
        }
      }
    }

    if (targetMetrics != null) {
      return {
        'moduleIdx': targetModuleIdx,
        'sectionIdx': targetSectionIdx,
        'metrics': targetMetrics,
      };
    }
    return null;
  }
}
