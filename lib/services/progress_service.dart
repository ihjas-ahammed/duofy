import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import 'global_state.dart';
import 'learning_sync.dart';
import 'fb/fb_auth.dart';
import 'database_service.dart';

class ProgressService {
  /// Returns the current user's UID (or 'guest' when not signed in).
  static String get _uid => FbAuth.instance.currentUser?.uid ?? 'guest';

  /// Per-user SharedPreferences keys so switching accounts never pollutes
  /// or resets another user's progress.
  static String get _completedKey => 'completed_lessons_${_uid}';
  static String get _xpKey => 'user_xp_${_uid}';
  static String get _activitiesKey => 'learning_activities_${_uid}';

  /// Notifies listeners + backs up to the cloud after a completion change.
  /// Called by every mutation so the UI refreshes and cloud stays in sync.
  static void _onProgressChanged() {
    GlobalState.bumpProgress();
    // Fire-and-forget cloud backup (no-op when cloud sync is disabled).
    LearningSync.push();
  }

  static Future<List<String>> getCompletedLessons() async {
    final prefs = await SharedPreferences.getInstance();
    await LearningSync.migrateLegacyKeys(prefs);
    return prefs.getStringList(_completedKey) ?? [];
  }

  static Future<void> markLessonsCompleted(List<String> lessonIds, String bookId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> completed = prefs.getStringList(_completedKey) ?? [];
    int xpGained = 0;
    String? lastCompletedId;
    for (var id in lessonIds) {
      if (!completed.contains(id)) {
        completed.add(id);
        xpGained += 20;
        lastCompletedId = id;
      }
    }
    if (xpGained > 0) {
      await prefs.setStringList(_completedKey, completed);
      if (lastCompletedId != null) {
        await prefs.setString('recently_completed', lastCompletedId);
      }
      
      // Update course-specific XP
      final courseXpKey = 'user_xp_${_uid}_$bookId';
      int currentCourseXp = prefs.getInt(courseXpKey) ?? 0;
      int newCourseXp = currentCourseXp + xpGained;
      await prefs.setInt(courseXpKey, newCourseXp);

      // Update overall XP
      int currentXp = prefs.getInt(_xpKey) ?? 0;
      int newXp = currentXp + xpGained;
      await prefs.setInt(_xpKey, newXp);
      
      GlobalState.xpNotifier.value = newCourseXp;
      _onProgressChanged();
    }
  }

  static Future<void> markLessonsCompletedSilent(List<String> lessonIds) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> completed = prefs.getStringList(_completedKey) ?? [];
    bool changed = false;
    for (var id in lessonIds) {
      if (!completed.contains(id)) {
        completed.add(id);
        changed = true;
      }
    }
    if (changed) {
      await prefs.setStringList(_completedKey, completed);
      _onProgressChanged();
    }
  }

  static Future<void> clearLessonsProgress(List<String> lessonIds, String bookId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> completed = prefs.getStringList(_completedKey) ?? [];
    int xpLost = 0;
    for (var id in lessonIds) {
      if (completed.contains(id)) {
        completed.remove(id);
        xpLost += 20;
      }
    }
    if (xpLost > 0) {
      await prefs.setStringList(_completedKey, completed);
      
      // Update course-specific XP
      final courseXpKey = 'user_xp_${_uid}_$bookId';
      int currentCourseXp = prefs.getInt(courseXpKey) ?? 0;
      int newCourseXp = currentCourseXp - xpLost;
      if (newCourseXp < 0) newCourseXp = 0;
      await prefs.setInt(courseXpKey, newCourseXp);

      // Update overall XP
      int currentXp = prefs.getInt(_xpKey) ?? 0;
      int newXp = currentXp - xpLost;
      if (newXp < 0) newXp = 0;
      await prefs.setInt(_xpKey, newXp);
      
      GlobalState.xpNotifier.value = newCourseXp;
      _onProgressChanged();
    }
  }

  static Future<void> markLessonCompleted(String lessonId, String bookId) async {
    await markLessonsCompleted([lessonId], bookId);
  }

  static Future<int> getXp() async {
    final prefs = await SharedPreferences.getInstance();
    await LearningSync.migrateLegacyKeys(prefs);
    final currentXp = prefs.getInt(_xpKey) ?? 0;
    GlobalState.xpNotifier.value = currentXp;
    return currentXp;
  }

  static Future<int> getXpForCourse(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_xp_${_uid}_$courseId';
    if (!prefs.containsKey(key)) {
      // Proactively backfill estimated XP based on completed lessons of this course
      final completed = prefs.getStringList(_completedKey) ?? [];
      int estimatedXp = 0;
      try {
        final book = await DatabaseService().getBookFromCache(courseId);
        if (book != null) {
          for (var m in book.modules) {
            for (var s in m.sections) {
              for (var u in s.units) {
                for (var l in u.lessons) {
                  if (completed.contains(l.id)) {
                     estimatedXp += 20;
                  }
                }
              }
            }
          }
        }
      } catch (e) {
        print("Error backfilling course XP: $e");
      }
      await prefs.setInt(key, estimatedXp);
      return estimatedXp;
    }
    return prefs.getInt(key) ?? 0;
  }

  static Future<double> getBookProgress(Book book) async {
    final completed = await getCompletedLessons();

    // First pass: count actual lessons in generated units and figure out
    // the average lessons-per-unit so we can estimate ungenerated ones.
    int generatedUnitCount = 0;
    int generatedLessonCount = 0;
    int ungeneratedUnitCount = 0;
    int done = 0;

    for (var m in book.modules) {
      for (var s in m.sections) {
        for (var u in s.units) {
          if (u.isGenerated && u.lessons.isNotEmpty) {
            generatedUnitCount++;
            generatedLessonCount += u.lessons.length;
            for (var l in u.lessons) {
              if (completed.contains(l.id)) done++;
            }
          } else if (u.lessons.isNotEmpty) {
            // Partially generated / interrupted — count actual lessons.
            generatedLessonCount += u.lessons.length;
            generatedUnitCount++;
            for (var l in u.lessons) {
              if (completed.contains(l.id)) done++;
            }
          } else {
            ungeneratedUnitCount++;
          }
        }
      }
    }

    // Estimate: average lessons per generated unit, or 4 as a sensible default.
    final avgLessons = generatedUnitCount > 0
        ? (generatedLessonCount / generatedUnitCount).round()
        : 4;

    final total = generatedLessonCount + (ungeneratedUnitCount * avgLessons);
    return total == 0 ? 0.0 : (done / total);
  }

  static Future<void> clearLessonProgress(String lessonId, String bookId) async {
    await clearLessonsProgress([lessonId], bookId);
  }

  static Future<void> clearBookProgress(Book book) async {
    final ids = <String>[];
    for (var m in book.modules) {
      for (var s in m.sections) {
        for (var u in s.units) {
          for (var l in u.lessons) {
            ids.add(l.id);
          }
        }
      }
    }
    await clearLessonsProgress(ids, book.id);
    
    // Reset course-specific XP to 0
    final prefs = await SharedPreferences.getInstance();
    final courseXpKey = 'user_xp_${_uid}_${book.id}';
    await prefs.setInt(courseXpKey, 0);
    GlobalState.xpNotifier.value = 0;
  }

  static Future<void> markUnitCompleted(Unit unit, String bookId) async {
    final ids = unit.lessons.map((l) => l.id).toList();
    await markLessonsCompleted(ids, bookId);
  }

  static Future<void> clearUnitProgress(Unit unit, String bookId) async {
    final ids = unit.lessons.map((l) => l.id).toList();
    await clearLessonsProgress(ids, bookId);
  }

  static Future<void> markSectionCompleted(Section section, String bookId) async {
    final ids = <String>[];
    for (var u in section.units) {
      ids.addAll(u.lessons.map((l) => l.id));
    }
    await markLessonsCompleted(ids, bookId);
  }

  static Future<void> clearSectionProgress(Section section, String bookId) async {
    final ids = <String>[];
    for (var u in section.units) {
      ids.addAll(u.lessons.map((l) => l.id));
    }
    await clearLessonsProgress(ids, bookId);
  }

  static Future<void> markModuleCompleted(Module module, String bookId) async {
    final ids = <String>[];
    for (var s in module.sections) {
      for (var u in s.units) {
        ids.addAll(u.lessons.map((l) => l.id));
      }
    }
    await markLessonsCompleted(ids, bookId);
  }

  static Future<void> clearModuleProgress(Module module, String bookId) async {
    final ids = <String>[];
    for (var s in module.sections) {
      for (var u in s.units) {
        ids.addAll(u.lessons.map((l) => l.id));
      }
    }
    await clearLessonsProgress(ids, bookId);
  }

  // ---------------------------------------------------------------------------
  // Activity Logging & Analytics Helpers
  // ---------------------------------------------------------------------------

  static Future<void> logActivity({
    required String courseId,
    required String lessonId,
    required String activityType,
    required int xp,
    required int timeSpent,
    required int accuracy,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_activitiesKey) ?? [];
    
    final log = {
      'courseId': courseId,
      'lessonId': lessonId,
      'activityType': activityType,
      'xp': xp,
      'timeSpent': timeSpent,
      'accuracy': accuracy,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
    
    list.add(jsonEncode(log));
    await prefs.setStringList(_activitiesKey, list);
    _onProgressChanged();
  }

  static Future<List<Map<String, dynamic>>> getActivityLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_activitiesKey) ?? [];
    return list.map((s) {
      try {
        return Map<String, dynamic>.from(jsonDecode(s));
      } catch (_) {
        return <String, dynamic>{};
      }
    }).where((m) => m.isNotEmpty).toList();
  }
}