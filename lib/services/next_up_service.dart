import '../models/app_models.dart';
import 'progress_service.dart';

/// What the learner should do next: the first uncompleted lesson of the most
/// recently active book. Powers the "Continue learning" hero card on Home.
class NextUp {
  final Book book;
  final Lesson lesson;
  final int modIdx;
  final int secIdx;
  final int unitIdx;
  final int lessonIdx;

  const NextUp({
    required this.book,
    required this.lesson,
    required this.modIdx,
    required this.secIdx,
    required this.unitIdx,
    required this.lessonIdx,
  });
}

class NextUpService {
  NextUpService._();

  /// Walks [books] in recency order (last learning activity, then the book's
  /// own updatedAt) and returns the first playable uncompleted lesson.
  static Future<NextUp?> resolve(List<Book> books) async {
    if (books.isEmpty) return null;
    final completed = (await ProgressService.getCompletedLessons()).toSet();

    final lastActivity = <String, int>{};
    for (final log in await ProgressService.getActivityLogs()) {
      final id = log['courseId']?.toString();
      final ts = log['timestamp'] is num ? (log['timestamp'] as num).toInt() : 0;
      if (id != null && ts > (lastActivity[id] ?? 0)) lastActivity[id] = ts;
    }
    final ordered = List<Book>.from(books)
      ..sort((a, b) {
        final ta = lastActivity[a.id] ?? a.updatedAt ?? 0;
        final tb = lastActivity[b.id] ?? b.updatedAt ?? 0;
        return tb.compareTo(ta);
      });

    for (final book in ordered) {
      for (var m = 0; m < book.modules.length; m++) {
        final module = book.modules[m];
        for (var s = 0; s < module.sections.length; s++) {
          final section = module.sections[s];
          for (var u = 0; u < section.units.length; u++) {
            final unit = section.units[u];
            for (var l = 0; l < unit.lessons.length; l++) {
              final lesson = unit.lessons[l];
              if (lesson.slides.isEmpty) continue;
              if (completed.contains(lesson.id)) continue;
              return NextUp(
                book: book,
                lesson: lesson,
                modIdx: m,
                secIdx: s,
                unitIdx: u,
                lessonIdx: l,
              );
            }
          }
        }
      }
    }
    return null;
  }

  /// XP earned since local midnight, for the daily-goal ring.
  static Future<int> xpToday() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    var xp = 0;
    for (final log in await ProgressService.getActivityLogs()) {
      final ts = log['timestamp'] is num ? (log['timestamp'] as num).toInt() : 0;
      if (ts >= midnight && log['xp'] is num) xp += (log['xp'] as num).toInt();
    }
    return xp;
  }
}
