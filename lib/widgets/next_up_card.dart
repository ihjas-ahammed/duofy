import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_models.dart';
import '../screens/main_layout_screen.dart';
import '../services/global_state.dart';
import '../services/next_up_service.dart';
import '../theme/app_theme.dart';

/// "Continue learning" hero: one tap from the library straight into the next
/// uncompleted lesson, with the daily-goal ring. Renders nothing when there
/// is no lesson to continue.
class NextUpCard extends StatelessWidget {
  final List<Book> books;
  final VoidCallback? onReturn;

  const NextUpCard({super.key, required this.books, this.onReturn});

  Future<(NextUp?, int, int)> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final results = await Future.wait([
      NextUpService.resolve(books),
      NextUpService.xpToday(),
    ]);
    final goal = prefs.getInt('daily_goal_xp') ?? 50;
    return (results[0] as NextUp?, results[1] as int? ?? 0, goal);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: GlobalState.progressNotifier,
      builder: (context, _, __) => FutureBuilder<(NextUp?, int, int)>(
        future: _load(),
        builder: (context, snap) {
          final data = snap.data;
          if (data == null || data.$1 == null) return const SizedBox.shrink();
          final (next, xpToday, goal) = data;
          final n = next!;
          final ringValue = goal <= 0 ? 1.0 : (xpToday / goal).clamp(0.0, 1.0);
          final goalMet = xpToday >= goal;

          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 4, 24, 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString(
                  'last_lesson_id_${n.book.id}',
                  n.lesson.id,
                );
                await prefs.setInt('last_mod_idx_${n.book.id}', n.modIdx);
                await prefs.setInt('last_sec_idx_${n.book.id}', n.secIdx);

                if (!context.mounted) return;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MainLayoutScreen(
                      book: n.book,
                      initialModuleIdx: n.modIdx,
                      initialSectionIdx: n.secIdx,
                    ),
                  ),
                ).then((_) => onReturn?.call());
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.duoGreen.withOpacity(0.16),
                      AppTheme.duoBlue.withOpacity(0.10),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.duoGreen.withOpacity(0.35),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 54,
                      height: 54,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: ringValue,
                            strokeWidth: 5,
                            backgroundColor: context.colors.surfaceAlt,
                            valueColor: AlwaysStoppedAnimation(
                              goalMet ? AppTheme.duoGreen : AppTheme.duoOrange,
                            ),
                          ),
                          Center(
                            child: Icon(
                              goalMet ? LucideIcons.check : LucideIcons.flame,
                              color: goalMet
                                  ? AppTheme.duoGreen
                                  : AppTheme.duoOrange,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'CONTINUE LEARNING',
                            style: TextStyle(
                              color: AppTheme.duoGreen,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            n.lesson.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: context.colors.textPrimary,
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${n.book.title}  •  $xpToday/$goal XP today',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: context.colors.textFaint,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.duoGreen,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.duoGreenDark,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        LucideIcons.play,
                        color: context.colors.textPrimary,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
