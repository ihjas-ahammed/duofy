import 'package:shared_preferences/shared_preferences.dart';

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
}