import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';

class ProgressService {
  static const String _completedKey = 'completed_lessons';
  static const String _xpKey = 'user_xp';

  static Future<List<String>> getCompletedLessons() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_completedKey) ?? [];
  }

  static Future<void> markLessonCompleted(String lessonId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> completed = prefs.getStringList(_completedKey) ?? [];
    if (!completed.contains(lessonId)) {
      completed.add(lessonId);
      await prefs.setStringList(_completedKey, completed);
      
      // Add XP
      int currentXp = prefs.getInt(_xpKey) ?? 0;
      await prefs.setInt(_xpKey, currentXp + 20);
    }
  }

  static Future<int> getXp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_xpKey) ?? 0;
  }

  static Future<double> getBookProgress(Book book) async {
    final completed = await getCompletedLessons();
    int total = 0;
    int done = 0;
    for (var m in book.modules) {
      for (var s in m.sections) {
        for (var u in s.units) {
          for (var l in u.lessons) {
            total++;
            if (completed.contains(l.id)) done++;
          }
        }
      }
    }
    return total == 0 ? 0.0 : (done / total);
  }
}