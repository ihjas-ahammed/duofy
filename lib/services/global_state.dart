import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'learning_sync.dart';
import 'fb/fb_auth.dart';

class GlobalState {
  // Reactive XP variable that can be listened to anywhere in the app
  static final ValueNotifier<int> xpNotifier = ValueNotifier<int>(0);

  /// Bumped every time lesson-completion progress changes (a lesson/unit/
  /// section/module is marked finished or cleared). Screens that render
  /// completion state listen to this so they refresh immediately, no matter
  /// which surface triggered the change. The value itself is just a version
  /// counter — listeners re-read [ProgressService] when it ticks.
  static final ValueNotifier<int> progressNotifier = ValueNotifier<int>(0);

  /// Bumped whenever the bookmark set changes (added/removed/opened).
  static final ValueNotifier<int> bookmarksNotifier = ValueNotifier<int>(0);

  static void bumpProgress() => progressNotifier.value++;
  static void bumpBookmarks() => bookmarksNotifier.value++;

  // Guest mode state indicator
  static final ValueNotifier<bool> isGuestNotifier = ValueNotifier<bool>(false);

  // Indicator to force displaying the login screen even on Web
  static final ValueNotifier<bool> forceShowAuthScreen = ValueNotifier<bool>(false);

  static Future<void> addXp(int amount, String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    final uid = FbAuth.instance.currentUser?.uid ?? 'guest';
    final courseXpKey = 'user_xp_${uid}_$courseId';
    
    // Update course-specific XP
    final currentCourseXp = prefs.getInt(courseXpKey) ?? 0;
    final newCourseXp = currentCourseXp + amount;
    await prefs.setInt(courseXpKey, newCourseXp);
    xpNotifier.value = newCourseXp;

    // Update overall global XP
    final globalKey = LearningSync.xpKey;
    final currentGlobalXp = prefs.getInt(globalKey) ?? 0;
    final newGlobalXp = currentGlobalXp + amount;
    await prefs.setInt(globalKey, newGlobalXp);

    // Back up XP to the cloud (no-op when cloud sync is disabled).
    LearningSync.push();
  }
}