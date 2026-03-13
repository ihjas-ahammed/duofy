import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalState {
  // Reactive XP variable that can be listened to anywhere in the app
  static final ValueNotifier<int> xpNotifier = ValueNotifier<int>(0);

  static Future<void> addXp(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    final newXp = xpNotifier.value + amount;
    xpNotifier.value = newXp;
    await prefs.setInt('user_xp', newXp);
  }
}