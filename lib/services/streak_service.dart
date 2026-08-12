import 'package:shared_preferences/shared_preferences.dart';
import 'progress_service.dart';

class DayStreakData {
  final String dayName;
  final String dateStr;
  final bool isActive;
  final bool isToday;
  final bool isPast;

  const DayStreakData({
    required this.dayName,
    required this.dateStr,
    required this.isActive,
    required this.isToday,
    required this.isPast,
  });
}

class StreakInfo {
  final int streakCount;
  final int todayXp;
  final int dailyGoalXp;
  final bool todayGoalMet;
  final List<DayStreakData> weekDays;

  const StreakInfo({
    required this.streakCount,
    required this.todayXp,
    required this.dailyGoalXp,
    required this.todayGoalMet,
    required this.weekDays,
  });
}

class StreakService {
  static String _formatDate(DateTime d) {
    return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
  }

  static Future<StreakInfo> getStreakInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final dailyGoalXp = prefs.getInt('daily_goal_xp') ?? 50;

    final logs = await ProgressService.getActivityLogs();
    final now = DateTime.now();
    final todayStr = _formatDate(now);
    final yesterdayStr = _formatDate(now.subtract(const Duration(days: 1)));

    // Extract active dates and today's total XP
    final Set<String> activeDates = {};
    int todayXp = 0;

    for (final log in logs) {
      final ts = log['timestamp'] is int ? log['timestamp'] as int : 0;
      if (ts == 0) continue;
      final d = DateTime.fromMillisecondsSinceEpoch(ts);
      final dStr = _formatDate(d);
      activeDates.add(dStr);

      if (dStr == todayStr) {
        final xp = log['xp'] is int ? log['xp'] as int : 0;
        todayXp += xp;
      }
    }

    // 1. Calculate streak count
    int streakCount = 0;
    if (activeDates.contains(todayStr) || activeDates.contains(yesterdayStr)) {
      DateTime checkDate = activeDates.contains(todayStr)
          ? now
          : now.subtract(const Duration(days: 1));

      while (true) {
        final checkStr = _formatDate(checkDate);
        if (activeDates.contains(checkStr)) {
          streakCount++;
          checkDate = checkDate.subtract(const Duration(days: 1));
        } else {
          break;
        }
      }
    }

    // 2. Compute 7-day Monday through Sunday status
    final todayZero = DateTime(now.year, now.month, now.day);
    final monday = todayZero.subtract(Duration(days: todayZero.weekday - 1));

    const dayLabels = ["M", "T", "W", "T", "F", "S", "S"];
    final List<DayStreakData> weekDays = [];

    for (int i = 0; i < 7; i++) {
      final dayDate = monday.add(Duration(days: i));
      final dateStr = _formatDate(dayDate);
      final isActive = activeDates.contains(dateStr);
      final isToday = dateStr == todayStr;
      final isPast = dayDate.isBefore(todayZero);

      weekDays.add(DayStreakData(
        dayName: dayLabels[i],
        dateStr: dateStr,
        isActive: isActive,
        isToday: isToday,
        isPast: isPast,
      ));
    }

    return StreakInfo(
      streakCount: streakCount,
      todayXp: todayXp,
      dailyGoalXp: dailyGoalXp,
      todayGoalMet: todayXp >= dailyGoalXp,
      weekDays: weekDays,
    );
  }
}
