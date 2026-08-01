import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/daily_goal.dart';
import 'fb/fb_auth.dart';
import 'guest_service.dart';
import 'global_state.dart';

class DailyGoalsService {
  DailyGoalsService._();
  static final DailyGoalsService instance = DailyGoalsService._();

  static String get _uid =>
      FbAuth.instance.currentUser?.uid ?? GuestService.instance.guestIdSync;

  static String get _goalsKey => 'daily_goals_list_$_uid';
  static String get _dateKey => 'daily_goals_date_$_uid';
  static String get _firstLaunchKey => 'daily_goals_first_launch_seen_$_uid';
  static String get _statsCompletedKey => 'daily_goals_stats_completed_$_uid';
  static String get _statsXpKey => 'daily_goals_stats_xp_$_uid';

  /// Notifier for real-time floating UI toasts when a goal is updated
  final ValueNotifier<DailyGoalUpdateEvent?> goalUpdateNotifier =
      ValueNotifier(null);

  /// Notifier for overall daily goal list updates (rebuilding screens)
  final ValueNotifier<List<DailyGoal>> activeGoalsNotifier =
      ValueNotifier([]);

  // ---------------------------------------------------------------------------
  // 20 Pre-defined Daily Goal Templates
  // ---------------------------------------------------------------------------
  static final List<Map<String, dynamic>> _predefinedTemplates = [
    {
      'id_base': 'complete_1_lesson',
      'title': 'Complete 1 Lesson',
      'description': 'Finish any 1 lesson in any course',
      'category': 'lesson',
      'target': 1,
      'rewardXp': 20,
      'iconName': 'bookOpen',
    },
    {
      'id_base': 'complete_3_lessons',
      'title': 'Complete 3 Lessons',
      'description': 'Keep the momentum going by finishing 3 lessons',
      'category': 'lesson',
      'target': 3,
      'rewardXp': 50,
      'iconName': 'bookOpen',
    },
    {
      'id_base': 'complete_5_lessons',
      'title': 'Complete 5 Lessons',
      'description': 'Master 5 lessons across your courses',
      'category': 'lesson',
      'target': 5,
      'rewardXp': 90,
      'iconName': 'bookOpen',
    },
    {
      'id_base': 'earn_50_xp',
      'title': 'Earn 50 XP',
      'description': 'Accumulate 50 XP today through lessons and practice',
      'category': 'xp',
      'target': 50,
      'rewardXp': 30,
      'iconName': 'zap',
    },
    {
      'id_base': 'earn_100_xp',
      'title': 'Earn 100 XP',
      'description': 'Earn 100 total XP today across all learning activities',
      'category': 'xp',
      'target': 100,
      'rewardXp': 60,
      'iconName': 'zap',
    },
    {
      'id_base': 'earn_200_xp',
      'title': 'Earn 200 XP',
      'description': 'Reach 200 XP earned in a single day',
      'category': 'xp',
      'target': 200,
      'rewardXp': 110,
      'iconName': 'flame',
    },
    {
      'id_base': 'perfect_1_lesson',
      'title': 'Get 1 Perfect Lesson',
      'description': 'Finish a lesson with a 100% score',
      'category': 'perfect',
      'target': 1,
      'rewardXp': 40,
      'iconName': 'star',
    },
    {
      'id_base': 'perfect_2_lessons',
      'title': 'Get 2 Perfect Lessons',
      'description': 'Score 100% accuracy on 2 different lessons',
      'category': 'perfect',
      'target': 2,
      'rewardXp': 80,
      'iconName': 'star',
    },
    {
      'id_base': 'complete_1_unit',
      'title': 'Complete a Unit',
      'description': 'Finish all lessons in a single unit',
      'category': 'unit',
      'target': 1,
      'rewardXp': 100,
      'iconName': 'award',
    },
    {
      'id_base': 'complete_2_units',
      'title': 'Complete 2 Units',
      'description': 'Power through and finish 2 full units',
      'category': 'unit',
      'target': 2,
      'rewardXp': 160,
      'iconName': 'award',
    },
    {
      'id_base': 'practice_10_qs',
      'title': 'Answer 10 Practice Questions',
      'description': 'Solve 10 questions in Practice Arena',
      'category': 'practice',
      'target': 10,
      'rewardXp': 30,
      'iconName': 'helpCircle',
    },
    {
      'id_base': 'practice_25_qs',
      'title': 'Answer 25 Practice Questions',
      'description': 'Sharpen your skills with 25 practice questions',
      'category': 'practice',
      'target': 25,
      'rewardXp': 70,
      'iconName': 'helpCircle',
    },
    {
      'id_base': 'learn_10_mins',
      'title': 'Spend 10 Minutes Learning',
      'description': 'Log at least 10 minutes of active learning today',
      'category': 'time',
      'target': 10,
      'rewardXp': 40,
      'iconName': 'clock',
    },
    {
      'id_base': 'learn_20_mins',
      'title': 'Spend 20 Minutes Learning',
      'description': 'Dedicate 20 minutes of focus to your courses',
      'category': 'time',
      'target': 20,
      'rewardXp': 80,
      'iconName': 'clock',
    },
    {
      'id_base': 'complete_1_section',
      'title': 'Complete 1 Section',
      'description': 'Finish all units within a course section',
      'category': 'section',
      'target': 1,
      'rewardXp': 120,
      'iconName': 'layers',
    },
    {
      'id_base': 'high_accuracy_lesson',
      'title': 'High Accuracy Mastery',
      'description': 'Complete a lesson with over 90% accuracy',
      'category': 'accuracy',
      'target': 1,
      'rewardXp': 35,
      'iconName': 'target',
    },
    {
      'id_base': 'spaced_review_5',
      'title': '5 Spaced Review Items',
      'description': 'Review 5 items in Smart Review',
      'category': 'practice',
      'target': 5,
      'rewardXp': 40,
      'iconName': 'checkCircle2',
    },
    {
      'id_base': 'complete_1_module',
      'title': 'Master 1 Module',
      'description': 'Complete an entire course module',
      'category': 'module',
      'target': 1,
      'rewardXp': 200,
      'iconName': 'trophy',
    },
    {
      'id_base': 'earn_150_xp',
      'title': 'Earn 150 XP Today',
      'description': 'Gain a total of 150 XP across all activities',
      'category': 'xp',
      'target': 150,
      'rewardXp': 90,
      'iconName': 'flame',
    },
    {
      'id_base': 'perfect_practice_combo',
      'title': 'Perfect Practice Combo',
      'description': 'Complete 2 practice sessions with 100% score',
      'category': 'perfect',
      'target': 2,
      'rewardXp': 75,
      'iconName': 'shieldCheck',
    },
  ];

  static String getTodayString() {
    final now = DateTime.now();
    return "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  }

  /// Retrieves or initializes today's daily goals.
  Future<List<DailyGoal>> getTodayGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final today = getTodayString();
    final savedDate = prefs.getString(_dateKey);

    if (savedDate != today) {
      // New day: Generate new daily goals!
      final newGoals = _generateDailyGoalsForDate(today);
      await _saveGoals(prefs, today, newGoals);
      activeGoalsNotifier.value = newGoals;
      return newGoals;
    }

    final raw = prefs.getStringList(_goalsKey);
    if (raw == null || raw.isEmpty) {
      final newGoals = _generateDailyGoalsForDate(today);
      await _saveGoals(prefs, today, newGoals);
      activeGoalsNotifier.value = newGoals;
      return newGoals;
    }

    try {
      final goals = raw.map((s) => DailyGoal.fromJson(jsonDecode(s))).toList();
      activeGoalsNotifier.value = goals;
      return goals;
    } catch (_) {
      final newGoals = _generateDailyGoalsForDate(today);
      await _saveGoals(prefs, today, newGoals);
      activeGoalsNotifier.value = newGoals;
      return newGoals;
    }
  }

  /// Procedurally selects 3 daily goals for a given date seed.
  List<DailyGoal> _generateDailyGoalsForDate(String dateStr) {
    final parts = dateStr.split('-');
    final year = int.tryParse(parts[0]) ?? 2026;
    final month = int.tryParse(parts[1]) ?? 1;
    final day = int.tryParse(parts[2]) ?? 1;
    final seed = year * 366 + month * 31 + day;

    final idx1 = seed % _predefinedTemplates.length;
    final idx2 = (seed + 7) % _predefinedTemplates.length;
    final idx3 = (seed + 13) % _predefinedTemplates.length;

    final template1 = _predefinedTemplates[idx1];
    final template2 = _predefinedTemplates[idx2 == idx1 ? (idx2 + 1) % _predefinedTemplates.length : idx2];
    final template3 = _predefinedTemplates[idx3 == idx1 || idx3 == idx2 ? (idx3 + 2) % _predefinedTemplates.length : idx3];

    return [
      _createGoalFromTemplate(template1, dateStr, 'goal_1'),
      _createGoalFromTemplate(template2, dateStr, 'goal_2'),
      _createGoalFromTemplate(template3, dateStr, 'goal_3'),
    ];
  }

  DailyGoal _createGoalFromTemplate(Map<String, dynamic> tmpl, String dateStr, String suffix) {
    return DailyGoal(
      id: "${tmpl['id_base']}_${dateStr}_$suffix",
      title: tmpl['title'] as String,
      description: tmpl['description'] as String,
      category: tmpl['category'] as String,
      target: tmpl['target'] as int,
      current: 0,
      rewardXp: tmpl['rewardXp'] as int,
      iconName: tmpl['iconName'] as String,
    );
  }

  /// Algorithm for Infinite Bonus Goal generation:
  /// When a user completes all existing goals, procedurally generate bonus goal #4, #5, #6...
  DailyGoal generateInfiniteBonusGoal(List<DailyGoal> existingGoals) {
    final today = getTodayString();
    final bonusCount = existingGoals.where((g) => g.isBonus).length + 1;
    final parts = today.split('-');
    final day = int.tryParse(parts[2]) ?? 1;

    final tmplIdx = (day + bonusCount * 3) % _predefinedTemplates.length;
    final tmpl = _predefinedTemplates[tmplIdx];

    final multiplier = 1.0 + (bonusCount * 0.5);
    final baseTarget = tmpl['target'] as int;
    final baseReward = tmpl['rewardXp'] as int;

    final target = (baseTarget * multiplier).round().clamp(1, 1000);
    final rewardXp = (baseReward * multiplier).round();

    return DailyGoal(
      id: "infinite_bonus_${today}_$bonusCount",
      title: "Bonus: ${tmpl['title']}",
      description: "Infinite Challenge #$bonusCount! Reach $target ${tmpl['category']}s",
      category: tmpl['category'] as String,
      target: target,
      current: 0,
      rewardXp: rewardXp,
      iconName: tmpl['iconName'] as String,
      isBonus: true,
    );
  }

  Future<void> _saveGoals(SharedPreferences prefs, String dateStr, List<DailyGoal> goals) async {
    await prefs.setString(_dateKey, dateStr);
    final raw = goals.map((g) => jsonEncode(g.toJson())).toList();
    await prefs.setStringList(_goalsKey, raw);
    activeGoalsNotifier.value = goals;
  }

  /// Check if it's the user's first time opening the app today.
  Future<bool> isFirstLaunchToday() async {
    final prefs = await SharedPreferences.getInstance();
    final today = getTodayString();
    final lastSeen = prefs.getString(_firstLaunchKey);
    return lastSeen != today;
  }

  /// Mark the first time of day popup as seen.
  Future<void> markFirstLaunchSeen() async {
    final prefs = await SharedPreferences.getInstance();
    final today = getTodayString();
    await prefs.setString(_firstLaunchKey, today);
  }

  /// Called after any activity / lesson / practice is completed to update goal progress.
  Future<void> updateProgressOnActivity({
    int xpGained = 0,
    int lessonsCompleted = 0,
    int perfectLessons = 0,
    int unitsCompleted = 0,
    int sectionsCompleted = 0,
    int modulesCompleted = 0,
    int practiceQuestions = 0,
    int timeSpentMinutes = 0,
    double accuracy = 100.0,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final goals = await getTodayGoals();
    final today = getTodayString();

    bool changed = false;

    for (final goal in goals) {
      final prevCurrent = goal.current;
      int addAmount = 0;

      switch (goal.category) {
        case 'lesson':
          addAmount = lessonsCompleted;
          break;
        case 'xp':
          addAmount = xpGained;
          break;
        case 'perfect':
          addAmount = perfectLessons;
          break;
        case 'unit':
          addAmount = unitsCompleted;
          break;
        case 'section':
          addAmount = sectionsCompleted;
          break;
        case 'module':
          addAmount = modulesCompleted;
          break;
        case 'practice':
          addAmount = practiceQuestions;
          break;
        case 'time':
          addAmount = timeSpentMinutes;
          break;
        case 'accuracy':
          if (accuracy >= 90.0 && lessonsCompleted > 0) {
            addAmount = 1;
          }
          break;
      }

      if (addAmount > 0) {
        final wasCompleted = goal.isCompleted;
        goal.current = (goal.current + addAmount).clamp(0, goal.target * 2);
        final justCompleted = !wasCompleted && goal.isCompleted;

        if (goal.current != prevCurrent) {
          changed = true;
          // Trigger floating animated progress toast!
          goalUpdateNotifier.value = DailyGoalUpdateEvent(
            goal: goal,
            previousCurrent: prevCurrent,
            newCurrent: goal.current,
            justCompleted: justCompleted,
          );
        }
      }
    }

    // Check if ALL goals are completed — if so, automatically append an Infinite Bonus Goal!
    if (goals.every((g) => g.isCompleted)) {
      final bonusGoal = generateInfiniteBonusGoal(goals);
      goals.add(bonusGoal);
      changed = true;
    }

    if (changed) {
      await _saveGoals(prefs, today, goals);
    }
  }

  /// Claim XP reward for a completed goal.
  Future<void> claimReward(DailyGoal goal) async {
    if (!goal.isCompleted || goal.isClaimed) return;

    final prefs = await SharedPreferences.getInstance();
    final goals = await getTodayGoals();
    final today = getTodayString();

    final target = goals.firstWhere((g) => g.id == goal.id, orElse: () => goal);
    target.isClaimed = true;

    // Grant reward XP
    await GlobalState.addXp(goal.rewardXp, 'daily_goals');

    // Update all-time goals stats
    int completedCount = prefs.getInt(_statsCompletedKey) ?? 0;
    int totalXpEarned = prefs.getInt(_statsXpKey) ?? 0;
    await prefs.setInt(_statsCompletedKey, completedCount + 1);
    await prefs.setInt(_statsXpKey, totalXpEarned + goal.rewardXp);

    await _saveGoals(prefs, today, goals);
  }

  /// Get overall stats: Total goals completed & Total XP earned from daily goals
  Future<Map<String, int>> getStats() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'completed': prefs.getInt(_statsCompletedKey) ?? 0,
      'xpEarned': prefs.getInt(_statsXpKey) ?? 0,
    };
  }
}
