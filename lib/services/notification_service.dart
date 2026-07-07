import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import '../main.dart';
import '../services/generation_manager.dart';
import '../screens/pdf_split_preview_screen.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  /// Fixed id for the daily study reminder so re-scheduling replaces it.
  static const int dailyReminderId = 777001;

  static Future<void> init() async {
    // No notification backend on web; every show/schedule call is also
    // individually guarded or try/caught.
    if (kIsWeb) return;
    // Timezone database for exact-time scheduling (daily reminder).
    try {
      tz_data.initializeTimeZones();
      final localTz = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(localTz.identifier));
    } catch (e) {
      debugPrint('[NotificationService] Timezone init failed (reminders fall back to UTC): $e');
    }
    // Requires an app icon at android/app/src/main/res/mipmap/ic_launcher.png
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();
    // flutter_local_notifications requires explicit Linux settings even when
    // we don't ship notifications there. defaultActionName is what the action
    // button shows in the notification center; defaultIcon is optional.
    const LinuxInitializationSettings linuxSettings =
        LinuxInitializationSettings(defaultActionName: 'Open');
    // flutter_local_notifications also requires explicit Windows settings.
    // The guid must be stable across launches (it identifies the app to the
    // Windows notification system); appUserModelId should match the app's AUMID.
    const WindowsInitializationSettings windowsSettings =
        WindowsInitializationSettings(
      appName: 'duofy',
      appUserModelId: 'com.duofy.app',
      guid: 'cd9ef36f-e3fa-4f0c-a409-d39c262ed9d9',
    );
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
      linux: linuxSettings,
      windows: windowsSettings,
    );

    await _plugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );

    // Request permissions for Android 13+
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await androidImplementation?.requestNotificationsPermission();
  }

  static Future<void> _onSelectNotification(NotificationResponse response) async {
    final payload = response.payload;
    if (payload != null) {
      final parts = payload.split('|');
      final action = parts[0];

      if (action == 'review_split' && parts.length > 1) {
        final taskId = parts[1];
        
        GenerationTask? targetTask;
        try {
          targetTask = GenerationManager.instance.activeTasks.firstWhere((t) => t.id == taskId);
        } catch (_) {}

        if (targetTask != null && targetTask.skeletonBook != null) {
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (_) => PdfSplitPreviewScreen(
              taskId: targetTask!.id,
              originalPdf: targetTask.sourceFiles,
              skeletonBook: targetTask.skeletonBook!,
            )
          ));
        }
      }
      // "open_home" action naturally brings app to foreground.
    }
  }

  static Future<void> showProgress(
    int id,
    String title,
    String body, {
    int progress = 0,
    int maxProgress = 100,
    bool indeterminate = false,
  }) async {
    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'progress_channel',
      'Task Progress',
      channelDescription: 'Background processing notifications',
      importance: Importance.low,
      priority: Priority.low,
      showProgress: true,
      maxProgress: maxProgress,
      progress: progress,
      indeterminate: indeterminate,
      ongoing: true,
      autoCancel: false,
    );
    final NotificationDetails details = NotificationDetails(
      android: androidDetails,
      linux: const LinuxNotificationDetails(),
      iOS: const DarwinNotificationDetails(),
      macOS: const DarwinNotificationDetails(),
    );
    try {
      await _plugin.show(id: id, title: title, body: body, notificationDetails: details);
    } catch (e) {
      debugPrint('[NotificationService] Error showing progress notification: $e');
    }
  }

  static Future<void> showActionable(int id, String title, String body, String payload) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'action_channel',
      'Task Completion',
      channelDescription: 'Notifications requiring user action',
      importance: Importance.high,
      priority: Priority.high,
      autoCancel: true,
    );
    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      linux: const LinuxNotificationDetails(),
      iOS: const DarwinNotificationDetails(),
      macOS: const DarwinNotificationDetails(),
    );
    try {
      await _plugin.show(id: id, title: title, body: body, notificationDetails: details, payload: payload);
    } catch (e) {
      debugPrint('[NotificationService] Error showing actionable notification: $e');
    }
  }

  static Future<void> cancel(int id) async {
    try {
      await _plugin.cancel(id: id);
    } catch (e) {
      debugPrint('[NotificationService] Error cancelling notification: $e');
    }
  }

  /// Schedules (or replaces) the repeating daily study reminder at [time].
  /// No-op on web. Uses inexact scheduling so no special Android alarm
  /// permission is needed.
  static Future<void> scheduleDailyReminder(TimeOfDay time) async {
    if (kIsWeb) return;
    try {
      final now = tz.TZDateTime.now(tz.local);
      var next = tz.TZDateTime(
          tz.local, now.year, now.month, now.day, time.hour, time.minute);
      if (!next.isAfter(now)) next = next.add(const Duration(days: 1));

      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'reminder_channel',
        'Daily Reminder',
        channelDescription: 'Daily study reminder to keep your streak alive',
        importance: Importance.high,
        priority: Priority.high,
      );
      const NotificationDetails details = NotificationDetails(
        android: androidDetails,
        linux: LinuxNotificationDetails(),
        iOS: DarwinNotificationDetails(),
        macOS: DarwinNotificationDetails(),
      );
      await _plugin.zonedSchedule(
        id: dailyReminderId,
        title: 'Time to learn 🔥',
        body: 'A quick lesson keeps your streak alive. Jump back in!',
        scheduledDate: next,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: 'open_home|',
      );
    } catch (e) {
      debugPrint('[NotificationService] Failed to schedule daily reminder: $e');
    }
  }

  static Future<void> cancelDailyReminder() => cancel(dailyReminderId);
}