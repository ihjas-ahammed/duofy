import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_service.dart';
import 'global_state.dart';
import 'fb/fb_auth.dart';

import 'metacognition_service.dart';

/// Central place that mirrors the device's **learning state** (completed
/// lessons, XP and bookmarks) to/from the cloud learning doc.
///
/// Local storage stays the source of truth — these helpers are pure backup &
/// cross-device merge, and short-circuit to no-ops when cloud sync is off or
/// the user is a guest. ProgressService and BookmarkService both call [push]
/// after a local change so any one of them keeps the whole doc current.
class LearningSync {
  /// Current user UID (mirrors ProgressService._uid).
  static String get _uid => FbAuth.instance.currentUser?.uid ?? 'guest';

  // Per-user SharedPreferences keys — scoped by UID so switching accounts
  // never pollutes or resets another user's progress.
  static String get completedKey => 'completed_lessons_$_uid';
  static String get xpKey => 'user_xp_$_uid';
  static const String bookmarksKey = 'bookmarks';

  // Legacy unscoped keys — used only for one-time migration.
  static const String _legacyCompletedKey = 'completed_lessons';
  static const String _legacyXpKey = 'user_xp';

  /// Background push of the full learning state. Fire-and-forget — callers
  /// don't await the network.
  static Future<void> push() async {
    final db = DatabaseService();
    if (db.uid == 'guest') return;
    if (!await db.isCloudEnabled()) return;
    final prefs = await SharedPreferences.getInstance();

    final activitiesKey = 'learning_activities_$_uid';
    final activities = prefs.getStringList(activitiesKey) ?? const [];

    Map<String, int> courseXpMap = {};
    final prefix = 'user_xp_${_uid}_';
    for (final key in prefs.getKeys()) {
      if (key.startsWith(prefix)) {
        final courseId = key.substring(prefix.length);
        final val = prefs.getInt(key);
        if (val != null) courseXpMap[courseId] = val;
      }
    }

    await db.saveLearningState(
      completedLessons: prefs.getStringList(completedKey) ?? const [],
      xp: prefs.getInt(xpKey) ?? 0,
      bookmarks: decodeBookmarks(prefs.getString(bookmarksKey)),
      activities: activities,
      courseXp: courseXpMap,
      recentlyCompleted: prefs.getString('recently_completed'),
    );

    await MetacognitionService.push();
  }

  /// Pulls the cloud learning state and merges it into local storage:
  ///   • completed lessons  → union
  ///   • XP                 → max (best-effort; XP only grows in practice)
  ///   • bookmarks          → union by lessonId
  ///   • activities         → union
  ///   • course XP          → max
  ///   • metacognition      → queue & reflections merge
  ///   • settings & folders → sync to local
  ///
  /// Bumps the relevant notifiers and pushes the merged result back so the
  /// cloud reflects the union. Returns true when anything changed locally.
  static Future<bool> pullAndMerge() async {
    final db = DatabaseService();
    if (db.uid == 'guest') return false;
    if (!await db.isCloudEnabled()) return false;

    final prefs = await SharedPreferences.getInstance();

    // One-time migration: move unscoped legacy keys into the per-user keys
    // so existing users don't lose their progress after this update.
    await migrateLegacyKeys(prefs);

    await MetacognitionService.pullAndMerge();
    await db.syncUserSettingsToLocal();
    await db.fetchFolders();

    final remote = await db.fetchLearningState();
    if (remote == null) return false;

    bool changed = false;

    // Completed lessons — union (detect ANY difference, not just remote-ahead).
    final localCompleted = (prefs.getStringList(completedKey) ?? const <String>[]).toSet();
    final remoteCompleted = List<String>.from(remote['completedLessons'] ?? const []).toSet();
    final mergedCompleted = {...localCompleted, ...remoteCompleted};
    if (mergedCompleted.length != localCompleted.length ||
        mergedCompleted.length != remoteCompleted.length) {
      await prefs.setStringList(completedKey, mergedCompleted.toList());
      changed = true;
    }

    // XP — keep the higher value and always push back so the cloud stays
    // current even when local is ahead.
    final localXp = prefs.getInt(xpKey) ?? 0;
    final remoteXp = (remote['xp'] as int?) ?? 0;
    final bestXp = localXp > remoteXp ? localXp : remoteXp;
    GlobalState.xpNotifier.value = bestXp;
    if (bestXp != localXp) {
      await prefs.setInt(xpKey, bestXp);
      changed = true;
    } else if (bestXp != remoteXp) {
      // Local is ahead — still need to push (handled by `changed` flag below).
      changed = true;
    }

    // Bookmarks — union by lessonId.
    final localBm = decodeBookmarks(prefs.getString(bookmarksKey));
    final remoteBm = ((remote['bookmarks'] as List?) ?? const [])
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
    final Map<String, Map<String, dynamic>> byId = {};
    for (final b in localBm) {
      final id = b['lessonId']?.toString() ?? '';
      if (id.isNotEmpty) byId[id] = b;
    }
    for (final r in remoteBm) {
      final id = r['lessonId']?.toString() ?? '';
      if (id.isEmpty) continue;
      final existing = byId[id];
      if (existing == null) {
        byId[id] = r;
      } else {
        byId[id] = {
          ...existing,
          'bookmarkedAt': _minInt(existing['bookmarkedAt'], r['bookmarkedAt']),
          'lastOpenedAt': _maxInt(existing['lastOpenedAt'], r['lastOpenedAt']),
        };
      }
    }
    final mergedBm = byId.values.toList();
    if (mergedBm.length != localBm.length) {
      await prefs.setString(bookmarksKey, jsonEncode(mergedBm));
      changed = true;
    }

    // Activities union
    final remoteActivities = List<String>.from(remote['activities'] ?? []);
    final localActivities = prefs.getStringList('learning_activities_$_uid') ?? [];
    final mergedActivities = {...localActivities, ...remoteActivities}.toList();
    if (mergedActivities.length != localActivities.length) {
      await prefs.setStringList('learning_activities_$_uid', mergedActivities);
      changed = true;
    }

    // Course XP merge
    final remoteCourseXp = Map<String, int>.from(remote['courseXp'] ?? {});
    for (final entry in remoteCourseXp.entries) {
      final key = 'user_xp_${_uid}_${entry.key}';
      final localVal = prefs.getInt(key) ?? 0;
      final bestVal = localVal > entry.value ? localVal : entry.value;
      if (bestVal != localVal) {
        await prefs.setInt(key, bestVal);
        changed = true;
      }
    }

    if (remote['recentlyCompleted'] is String) {
      final rec = remote['recentlyCompleted'] as String;
      if (rec.isNotEmpty && prefs.getString('recently_completed') == null) {
        await prefs.setString('recently_completed', rec);
        changed = true;
      }
    }

    if (changed) {
      GlobalState.bumpProgress();
      GlobalState.bumpBookmarks();
      await push();
    }
    return changed;
  }

  static bool _legacyKeysMigrated = false;

  /// One-time migration: move unscoped legacy keys into the per-user keys
  /// so existing users don't lose their progress after this update.
  static Future<void> migrateLegacyKeys(SharedPreferences prefs) async {
    if (_legacyKeysMigrated) return;
    final uid = _uid;
    if (uid == 'guest') {
      _legacyKeysMigrated = true;
      return;
    }

    // completed_lessons -> completed_lessons_<uid>
    if (prefs.containsKey(_legacyCompletedKey)) {
      final legacyList = prefs.getStringList(_legacyCompletedKey) ?? [];
      if (legacyList.isNotEmpty) {
        final currentList = prefs.getStringList(completedKey) ?? [];
        final merged = {...currentList, ...legacyList}.toList();
        await prefs.setStringList(completedKey, merged);
      }
      await prefs.remove(_legacyCompletedKey);
    }

    // user_xp -> user_xp_<uid>
    if (prefs.containsKey(_legacyXpKey)) {
      final legacyXp = prefs.getInt(_legacyXpKey) ?? 0;
      if (legacyXp > 0) {
        final currentXp = prefs.getInt(xpKey) ?? 0;
        final bestXp = legacyXp > currentXp ? legacyXp : currentXp;
        await prefs.setInt(xpKey, bestXp);
      }
      await prefs.remove(_legacyXpKey);
    }
    _legacyKeysMigrated = true;
  }

  static List<Map<String, dynamic>> decodeBookmarks(String? raw) {
    if (raw == null || raw.trim().isEmpty) return [];
    try {
      return (jsonDecode(raw) as List)
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    } catch (_) {
      return [];
    }
  }

  static int _minInt(dynamic a, dynamic b) {
    final ai = (a is num) ? a.toInt() : null;
    final bi = (b is num) ? b.toInt() : null;
    if (ai == null) return bi ?? 0;
    if (bi == null) return ai;
    return ai < bi ? ai : bi;
  }

  static int _maxInt(dynamic a, dynamic b) {
    final ai = (a is num) ? a.toInt() : 0;
    final bi = (b is num) ? b.toInt() : 0;
    return ai > bi ? ai : bi;
  }
}
