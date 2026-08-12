import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';
import 'streak_service.dart';

/// Service to sync and update Android Homescreen Widgets using home_widget package.
class HomeWidgetService {
  HomeWidgetService._();
  static final HomeWidgetService instance = HomeWidgetService._();

  static const String _providerStreak = 'com.example.duofy.widgets.StreakWidget';

  bool get _supported => !kIsWeb && Platform.isAndroid;

  void Function(String action)? onAction;
  StreamSubscription<Uri?>? _clickSub;

  Future<void> init() async {
    if (!_supported) return;
    try {
      await HomeWidget.setAppGroupId('group.com.example.duofy');
    } catch (_) {}

    try {
      final initial = await HomeWidget.initiallyLaunchedFromHomeWidget();
      _dispatch(initial);
    } catch (e) {
      debugPrint('[HomeWidget] initiallyLaunched error: $e');
    }

    _clickSub?.cancel();
    _clickSub = HomeWidget.widgetClicked.listen(_dispatch);

    await publishStreak();
  }

  void dispose() {
    _clickSub?.cancel();
    _clickSub = null;
  }

  void _dispatch(Uri? uri) {
    if (uri == null) return;
    final action = uri.queryParameters['action'];
    if (action == null || action.isEmpty) return;
    final cb = onAction;
    if (cb == null) return;
    Future.microtask(() => cb(action));
  }

  /// Publishes week streak data to SharedPreferences and triggers widget update.
  Future<void> publishStreak() async {
    if (!_supported) return;

    try {
      final info = await StreakService.getStreakInfo();

      final Map<String, Object> data = {
        'duofy.streak.count': info.streakCount,
        'duofy.streak.todayXp': info.todayXp,
        'duofy.streak.goalXp': info.dailyGoalXp,
        'duofy.streak.subtitle': '${info.todayXp} / ${info.dailyGoalXp} XP TODAY',
        'duofy.streak.updatedAtMs': DateTime.now().millisecondsSinceEpoch,
      };

      for (int i = 0; i < info.weekDays.length; i++) {
        final d = info.weekDays[i];
        data['duofy.streak.day$i.active'] = d.isActive;
        data['duofy.streak.day$i.today'] = d.isToday;
        data['duofy.streak.day$i.name'] = d.dayName;
      }

      for (final e in data.entries) {
        await HomeWidget.saveWidgetData(e.key, e.value);
      }

      await HomeWidget.updateWidget(
        name: _providerStreak,
        androidName: _providerStreak.split('.').last,
        qualifiedAndroidName: _providerStreak,
      );
    } catch (e) {
      debugPrint('[HomeWidget] publish streak error: $e');
    }
  }
}
