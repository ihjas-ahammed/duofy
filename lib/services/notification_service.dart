import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';
import '../services/generation_manager.dart';
import '../screens/pdf_split_preview_screen.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // Requires an app icon at android/app/src/main/res/mipmap/ic_launcher.png
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();
    const InitializationSettings initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);

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

  static Future<void> showProgress(int id, String title, String body, {bool indeterminate = false}) async {
    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'progress_channel',
      'Task Progress',
      channelDescription: 'Background processing notifications',
      importance: Importance.low,
      priority: Priority.low,
      showProgress: true,
      maxProgress: 100,
      progress: 0,
      indeterminate: indeterminate,
      ongoing: true,
      autoCancel: false,
    );
    final NotificationDetails details = NotificationDetails(android: androidDetails);
    await _plugin.show(id: id,title:  title,body: body,notificationDetails:  details);
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
    const NotificationDetails details = NotificationDetails(android: androidDetails);
    await _plugin.show(id: id,title:  title,body:  body,notificationDetails:  details, payload: payload);
  }

  static Future<void> cancel(int id) async {
    await _plugin.cancel(id: id);
  }
}