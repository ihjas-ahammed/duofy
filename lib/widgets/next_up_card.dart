import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_models.dart';
import '../screens/main_layout_screen.dart';
import '../services/global_state.dart';
import '../services/next_up_service.dart';
import '../services/progress_service.dart';
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
    final logs = await ProgressService.getActivityLogs();
    final results = await Future.wait([
      NextUpService.resolve(books, logs),
      NextUpService.xpToday(logs),
    ]);
    final goal = prefs.getInt('daily_goal_xp') ?? 50;
    return (results[0] as NextUp?, results[1] as int? ?? 0, goal);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: GlobalState.progressNotifier,
      builder: (context, _, _) => FutureBuilder<(NextUp?, int, int)>(
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
              onTap: () {
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setString('last_lesson_id_${n.book.id}', n.lesson.id);
                  prefs.setInt('last_mod_idx_${n.book.id}', n.modIdx);
                  prefs.setInt('last_sec_idx_${n.book.id}', n.secIdx);
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LessonLoadingScreen(
                      book: n.book,
                      moduleIdx: n.modIdx,
                      sectionIdx: n.secIdx,
                      onReturn: onReturn,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.duoGreen.withValues(alpha: 0.16),
                      AppTheme.duoBlue.withValues(alpha: 0.10),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.duoGreen.withValues(alpha: 0.35),
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
                    SizedBox(width: 14),
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
                          SizedBox(height: 2),
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
                    SizedBox(width: 8),
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

class LessonLoadingScreen extends StatefulWidget {
  final Book book;
  final int moduleIdx;
  final int sectionIdx;
  final VoidCallback? onReturn;

  const LessonLoadingScreen({
    super.key,
    required this.book,
    required this.moduleIdx,
    required this.sectionIdx,
    this.onReturn,
  });

  @override
  State<LessonLoadingScreen> createState() => _LessonLoadingScreenState();
}

class _LessonLoadingScreenState extends State<LessonLoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainLayoutScreen(
              book: widget.book,
              initialModuleIdx: widget.moduleIdx,
              initialSectionIdx: widget.sectionIdx,
            ),
          ),
        ).then((_) => widget.onReturn?.call());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 44,
              height: 44,
              child: CircularProgressIndicator(
                strokeWidth: 4.5,
                color: AppTheme.duoGreen,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Loading Lesson...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: context.colors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}