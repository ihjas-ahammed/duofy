import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

class AppCrashRecoveryScreen extends StatelessWidget {
  final String error;
  final String stackTrace;
  final VoidCallback onDismiss;

  const AppCrashRecoveryScreen({
    super.key,
    required this.error,
    required this.stackTrace,
    required this.onDismiss,
  });

  static Future<void> recordCrash(Object error, StackTrace? stack) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('last_fatal_crash_error', error.toString());
      await prefs.setString('last_fatal_crash_stack', stack?.toString() ?? '');
      await prefs.setInt('last_fatal_crash_time', DateTime.now().millisecondsSinceEpoch);
    } catch (_) {}
  }

  static Future<Map<String, String>?> getRecordedCrash() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final err = prefs.getString('last_fatal_crash_error');
      if (err != null && err.isNotEmpty) {
        final stack = prefs.getString('last_fatal_crash_stack') ?? '';
        return {'error': err, 'stack': stack};
      }
    } catch (_) {}
    return null;
  }

  static Future<void> clearRecordedCrash() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('last_fatal_crash_error');
      await prefs.remove('last_fatal_crash_stack');
      await prefs.remove('last_fatal_crash_time');
      // Reset any stored live voice chat flags/prompts to prevent crash loops
      await prefs.remove('custom_live_chat_prompt');
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: Scaffold(
        backgroundColor: context.colors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.duoRed.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.duoRed),
                      ),
                      child: const Icon(LucideIcons.alertTriangle, color: AppTheme.duoRed, size: 28),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'App Crash Recovered',
                            style: TextStyle(
                              color: context.colors.textPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'The app saved crash details before quitting',
                            style: TextStyle(color: context.colors.textSecondary, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'CRASH DETAILS & ERROR LOG:',
                  style: TextStyle(
                    color: AppTheme.duoRed,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: context.colors.surfaceAlt,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: context.colors.outline),
                    ),
                    child: SingleChildScrollView(
                      child: SelectableText(
                        '$error\n\nSTACK TRACE:\n$stackTrace',
                        style: const TextStyle(
                          color: AppTheme.duoRed,
                          fontFamily: 'monospace',
                          fontSize: 11.5,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: context.colors.outline),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        icon: Icon(LucideIcons.copy, color: context.colors.textPrimary, size: 16),
                        label: Text(
                          'Copy Log',
                          style: TextStyle(color: context.colors.textPrimary, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: '$error\n\n$stackTrace'));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Crash log copied to clipboard!')),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.duoGreen,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        icon: const Icon(LucideIcons.check, color: Colors.white, size: 16),
                        label: const Text(
                          'Continue App',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                        onPressed: () async {
                          await clearRecordedCrash();
                          onDismiss();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}