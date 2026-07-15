import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_theme.dart';
import '../services/bookmark_service.dart';
import '../services/database_service.dart';
import '../services/global_state.dart';
import '../widgets/responsive_center.dart';
import 'lesson_screen.dart';

/// The bookmarks window. Lists every bookmarked lesson across all courses,
/// sortable by date, showing when each was last opened. Tapping a bookmark
/// re-opens the lesson (and stamps its last-opened time).
class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

enum _SortMode { lastOpened, dateAdded }

class _BookmarksScreenState extends State<BookmarksScreen> {
  _SortMode _sort = _SortMode.lastOpened;

  String _formatDate(int ts) {
    if (ts == 0) return 'Never';
    final dt = DateTime.fromMillisecondsSinceEpoch(ts);
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    final month = dt.month.toString().padLeft(2, '0');
    final day = dt.day.toString().padLeft(2, '0');
    return '${dt.year}-$month-$day';
  }

  List<Bookmark> _sorted(List<Bookmark> list) {
    final out = List<Bookmark>.from(list);
    out.sort(
      (a, b) => _sort == _SortMode.lastOpened
          ? b.lastOpenedAt.compareTo(a.lastOpenedAt)
          : b.bookmarkedAt.compareTo(a.bookmarkedAt),
    );
    return out;
  }

  Future<void> _openBookmark(Bookmark bm) async {
    final book = await DatabaseService().getBookFromCache(bm.bookId);
    if (!mounted) return;
    if (book == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Course not found on this device.')),
      );
      return;
    }

    // Locate the lesson + its indices so the lesson screen gets full context.
    for (int m = 0; m < book.modules.length; m++) {
      final module = book.modules[m];
      for (int s = 0; s < module.sections.length; s++) {
        final section = module.sections[s];
        for (int u = 0; u < section.units.length; u++) {
          final unit = section.units[u];
          for (int l = 0; l < unit.lessons.length; l++) {
            final lesson = unit.lessons[l];
            if (lesson.id == bm.lessonId) {
              await BookmarkService.markOpened(bm.lessonId);
              if (!mounted) return;
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LessonScreen(
                    lesson: lesson,
                    book: book,
                    modIdx: m,
                    secIdx: s,
                    unitIdx: u,
                    lessonIdx: l,
                  ),
                ),
              );
              return;
            }
          }
        }
      }
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This lesson is no longer available.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        title: const Text(
          'Bookmarks',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          PopupMenuButton<_SortMode>(
            icon: const Icon(LucideIcons.arrowDownUp, size: 20),
            color: context.colors.surface,
            onSelected: (v) => setState(() => _sort = v),
            itemBuilder: (ctx) => [
              CheckedPopupMenuItem(
                value: _SortMode.lastOpened,
                checked: _sort == _SortMode.lastOpened,
                child: Text(
                  'Recently opened',
                  style: TextStyle(color: context.colors.textPrimary),
                ),
              ),
              CheckedPopupMenuItem(
                value: _SortMode.dateAdded,
                checked: _sort == _SortMode.dateAdded,
                child: Text(
                  'Recently added',
                  style: TextStyle(color: context.colors.textPrimary),
                ),
              ),
            ],
          ),
        ],
      ),
      body: ResponsiveCenter(
        maxWidth: ResponsiveMaxWidth.reading,
        child: ValueListenableBuilder<int>(
          valueListenable: GlobalState.bookmarksNotifier,
          builder: (context, _, _) {
            return FutureBuilder<List<Bookmark>>(
              future: BookmarkService.getBookmarks(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppTheme.duoBlue),
                  );
                }
                final bookmarks = _sorted(snap.data ?? const []);
                if (bookmarks.isEmpty) {
                  return _buildEmpty();
                }
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  itemCount: bookmarks.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, i) => _buildTile(bookmarks[i]),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.bookmark,
              color: context.colors.textFaint,
              size: 56,
            ),
            const SizedBox(height: 16),
            Text(
              'No bookmarks yet',
              style: TextStyle(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the bookmark icon while in a lesson to save it here for spaced practice.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.colors.textFaint,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(Bookmark bm) {
    return Dismissible(
      key: ValueKey(bm.lessonId),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppTheme.duoRed.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(LucideIcons.trash2, color: AppTheme.duoRed),
      ),
      onDismissed: (_) => BookmarkService.remove(bm.lessonId),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _openBookmark(bm),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.colors.outline),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.duoBlue.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    LucideIcons.bookmark,
                    color: AppTheme.duoBlue,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bm.lessonTitle.isNotEmpty ? bm.lessonTitle : 'Lesson',
                        style: TextStyle(
                          color: context.colors.textPrimary,
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        bm.bookTitle,
                        style: TextStyle(
                          color: context.colors.textFaint,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            LucideIcons.clock,
                            size: 12,
                            color: context.colors.textFaint,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Last opened ${_formatDate(bm.lastOpenedAt)}',
                            style: TextStyle(
                              color: context.colors.textFaint,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  LucideIcons.chevronRight,
                  size: 18,
                  color: context.colors.textFaint,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
