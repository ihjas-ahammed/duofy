import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_service.dart';
import 'global_state.dart';

/// Central place that mirrors the device's **learning state** (completed
/// lessons, XP and bookmarks) to/from the cloud learning doc.
///
/// Local storage stays the source of truth — these helpers are pure backup &
/// cross-device merge, and short-circuit to no-ops when cloud sync is off or
/// the user is a guest. ProgressService and BookmarkService both call [push]
/// after a local change so any one of them keeps the whole doc current.
class LearningSync {
  // Shared SharedPreferences keys (kept in sync with ProgressService /
  // BookmarkService so this file can read them without importing those and
  // creating an import cycle).
  static const String completedKey = 'completed_lessons';
  static const String xpKey = 'user_xp';
  static const String bookmarksKey = 'bookmarks';

  /// Background push of the full learning state. Fire-and-forget — callers
  /// don't await the network.
  static Future<void> push() async {
    final db = DatabaseService();
    if (db.uid == 'guest') return;
    if (!await db.isCloudEnabled()) return;
    final prefs = await SharedPreferences.getInstance();
    await db.saveLearningState(
      completedLessons: prefs.getStringList(completedKey) ?? const [],
      xp: prefs.getInt(xpKey) ?? 0,
      bookmarks: decodeBookmarks(prefs.getString(bookmarksKey)),
    );
  }

  /// Pulls the cloud learning state and merges it into local storage:
  ///   • completed lessons  → union
  ///   • XP                 → max (best-effort; XP only grows in practice)
  ///   • bookmarks          → union by lessonId (earliest bookmarkedAt,
  ///                          latest lastOpenedAt)
  ///
  /// Bumps the relevant notifiers and pushes the merged result back so the
  /// cloud reflects the union. Returns true when anything changed locally.
  static Future<bool> pullAndMerge() async {
    final db = DatabaseService();
    if (db.uid == 'guest') return false;
    if (!await db.isCloudEnabled()) return false;
    final remote = await db.fetchLearningState();
    if (remote == null) return false;

    final prefs = await SharedPreferences.getInstance();
    bool changed = false;

    // Completed lessons — union.
    final localCompleted = (prefs.getStringList(completedKey) ?? const <String>[]).toSet();
    final remoteCompleted = List<String>.from(remote['completedLessons'] ?? const []).toSet();
    if (!remoteCompleted.every(localCompleted.contains)) {
      final merged = {...localCompleted, ...remoteCompleted}.toList();
      await prefs.setStringList(completedKey, merged);
      changed = true;
    }

    // XP — keep the higher value.
    final localXp = prefs.getInt(xpKey) ?? 0;
    final remoteXp = (remote['xp'] as int?) ?? 0;
    if (remoteXp > localXp) {
      await prefs.setInt(xpKey, remoteXp);
      GlobalState.xpNotifier.value = remoteXp;
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

    if (changed) {
      GlobalState.bumpProgress();
      GlobalState.bumpBookmarks();
      await push();
    }
    return changed;
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
