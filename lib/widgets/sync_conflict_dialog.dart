import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';

Future<bool> showSyncConflictDialog(BuildContext context, Book local, Book remote) async {
  String formatTime(int? ts) {
    if (ts == null || ts == 0) return 'Unknown';
    final dt = DateTime.fromMillisecondsSinceEpoch(ts);
    final hour = dt.hour == 0 ? 12 : (dt.hour > 12 ? dt.hour - 12 : dt.hour);
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    final minute = dt.minute.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final day = dt.day.toString().padLeft(2, '0');
    return '${dt.year}-$month-$day $hour:$minute $period';
  }

  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      backgroundColor: AppTheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: AppTheme.duoOrange, size: 28),
          const SizedBox(width: 12),
          const Text(
            'Sync Conflict',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'The course "${local.title}" has different modifications on another device.',
            style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 16),
          const Text(
            'Which version do you want to keep?',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Local Version (This Device)',
                  style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 0.5),
                ),
                const SizedBox(height: 6),
                Text(
                  'Last modified: ${formatTime(local.updatedAt)}',
                  style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Remote Version (Cloud/Other Device)',
                  style: TextStyle(color: AppTheme.duoOrange, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 0.5),
                ),
                const SizedBox(height: 6),
                Text(
                  'Last modified: ${formatTime(remote.updatedAt)}',
                  style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Use Cloud Version', style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Keep Local Version', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.w900)),
        ),
      ],
    ),
  );
  return result ?? false;
}
