import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/notification_service.dart';
import '../theme/app_theme.dart';

/// Settings card for the daily XP goal and the optional study reminder.
/// Self-contained: loads and saves its own prefs (`daily_goal_xp`,
/// `daily_reminder_enabled`, `daily_reminder_time`) and (re)schedules the
/// notification immediately, so it works without the screen-level Save.
class DailyGoalCard extends StatefulWidget {
  const DailyGoalCard({super.key});

  @override
  State<DailyGoalCard> createState() => _DailyGoalCardState();
}

class _DailyGoalCardState extends State<DailyGoalCard> {
  static const _goals = [30, 50, 100, 200];

  int _goal = 50;
  bool _reminderEnabled = false;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 19, minute: 0);
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _goal = prefs.getInt('daily_goal_xp') ?? 50;
      _reminderEnabled = prefs.getBool('daily_reminder_enabled') ?? false;
      final t = prefs.getString('daily_reminder_time');
      if (t != null && t.contains(':')) {
        final parts = t.split(':');
        _reminderTime = TimeOfDay(
          hour: int.tryParse(parts[0]) ?? 19,
          minute: int.tryParse(parts[1]) ?? 0,
        );
      }
      _loaded = true;
    });
  }

  Future<void> _saveGoal(int goal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('daily_goal_xp', goal);
    setState(() => _goal = goal);
  }

  Future<void> _applyReminder() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('daily_reminder_enabled', _reminderEnabled);
    await prefs.setString(
      'daily_reminder_time',
      '${_reminderTime.hour}:${_reminderTime.minute.toString().padLeft(2, '0')}',
    );
    if (_reminderEnabled) {
      await NotificationService.scheduleDailyReminder(_reminderTime);
    } else {
      await NotificationService.cancelDailyReminder();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.glassOf(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                LucideIcons.flame,
                color: AppTheme.duoOrange,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Daily XP goal',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (final g in _goals) ...[
                Expanded(
                  child: GestureDetector(
                    onTap: () => _saveGoal(g),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _goal == g
                            ? AppTheme.duoOrange.withOpacity(0.2)
                            : context.colors.surfaceAlt,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _goal == g
                              ? AppTheme.duoOrange
                              : context.colors.outline,
                        ),
                      ),
                      child: Text(
                        '$g',
                        style: TextStyle(
                          color: _goal == g
                              ? AppTheme.duoOrange
                              : context.colors.textSecondary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
                if (g != _goals.last) const SizedBox(width: 8),
              ],
            ],
          ),
          if (!kIsWeb) ...[
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _reminderEnabled,
              activeColor: AppTheme.duoOrange,
              title: Text(
                'Daily reminder',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                _reminderEnabled
                    ? 'Every day at ${_reminderTime.format(context)}'
                    : 'Get a nudge to keep your streak alive',
                style: TextStyle(color: context.colors.textFaint, fontSize: 11),
              ),
              onChanged: (v) async {
                setState(() => _reminderEnabled = v);
                await _applyReminder();
              },
            ),
            if (_reminderEnabled)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: _reminderTime,
                    );
                    if (picked != null) {
                      setState(() => _reminderTime = picked);
                      await _applyReminder();
                    }
                  },
                  icon: const Icon(
                    LucideIcons.clock,
                    size: 14,
                    color: AppTheme.duoBlue,
                  ),
                  label: Text(
                    'Change time (${_reminderTime.format(context)})',
                    style: const TextStyle(
                      color: AppTheme.duoBlue,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
