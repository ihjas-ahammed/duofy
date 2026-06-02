import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'global_state.dart';
import 'learning_sync.dart';

/// A bookmarked lesson. Stores just enough to re-open the lesson later and to
/// render the bookmarks window (title, course, when it was bookmarked, and
/// when it was last opened).
class Bookmark {
  final String bookId;
  final String bookTitle;
  final String lessonId;
  final String lessonTitle;

  /// Epoch millis when the lesson was first bookmarked.
  final int bookmarkedAt;

  /// Epoch millis the lesson was last opened (defaults to [bookmarkedAt]).
  final int lastOpenedAt;

  Bookmark({
    required this.bookId,
    required this.bookTitle,
    required this.lessonId,
    required this.lessonTitle,
    required this.bookmarkedAt,
    required this.lastOpenedAt,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    final bm = (json['bookmarkedAt'] is num) ? (json['bookmarkedAt'] as num).toInt() : 0;
    return Bookmark(
      bookId: json['bookId']?.toString() ?? '',
      bookTitle: json['bookTitle']?.toString() ?? '',
      lessonId: json['lessonId']?.toString() ?? '',
      lessonTitle: json['lessonTitle']?.toString() ?? '',
      bookmarkedAt: bm,
      lastOpenedAt: (json['lastOpenedAt'] is num) ? (json['lastOpenedAt'] as num).toInt() : bm,
    );
  }

  Map<String, dynamic> toJson() => {
        'bookId': bookId,
        'bookTitle': bookTitle,
        'lessonId': lessonId,
        'lessonTitle': lessonTitle,
        'bookmarkedAt': bookmarkedAt,
        'lastOpenedAt': lastOpenedAt,
      };

  Bookmark copyWith({int? lastOpenedAt}) => Bookmark(
        bookId: bookId,
        bookTitle: bookTitle,
        lessonId: lessonId,
        lessonTitle: lessonTitle,
        bookmarkedAt: bookmarkedAt,
        lastOpenedAt: lastOpenedAt ?? this.lastOpenedAt,
      );
}

/// Local-first bookmark store, backed by SharedPreferences and mirrored to the
/// cloud via [LearningSync] when cloud sync is enabled. Mutations bump
/// [GlobalState.bookmarksNotifier] so the lesson bookmark button and the
/// bookmarks window refresh reactively.
class BookmarkService {
  static const String _key = LearningSync.bookmarksKey;

  static Future<List<Bookmark>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    return _read(prefs);
  }

  static List<Bookmark> _read(SharedPreferences prefs) {
    final raw = prefs.getString(_key);
    if (raw == null || raw.trim().isEmpty) return [];
    try {
      return (jsonDecode(raw) as List)
          .whereType<Map>()
          .map((e) => Bookmark.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> _write(SharedPreferences prefs, List<Bookmark> list) async {
    await prefs.setString(_key, jsonEncode(list.map((b) => b.toJson()).toList()));
    GlobalState.bumpBookmarks();
    LearningSync.push();
  }

  static Future<bool> isBookmarked(String lessonId) async {
    final prefs = await SharedPreferences.getInstance();
    return _read(prefs).any((b) => b.lessonId == lessonId);
  }

  /// Adds a bookmark (no-op if one already exists for [lessonId]).
  static Future<void> add({
    required String bookId,
    required String bookTitle,
    required String lessonId,
    required String lessonTitle,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final list = _read(prefs);
    if (list.any((b) => b.lessonId == lessonId)) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    list.add(Bookmark(
      bookId: bookId,
      bookTitle: bookTitle,
      lessonId: lessonId,
      lessonTitle: lessonTitle,
      bookmarkedAt: now,
      lastOpenedAt: now,
    ));
    await _write(prefs, list);
  }

  static Future<void> remove(String lessonId) async {
    final prefs = await SharedPreferences.getInstance();
    final list = _read(prefs)..removeWhere((b) => b.lessonId == lessonId);
    await _write(prefs, list);
  }

  /// Toggles the bookmark for [lessonId]. Returns the new bookmarked state.
  static Future<bool> toggle({
    required String bookId,
    required String bookTitle,
    required String lessonId,
    required String lessonTitle,
  }) async {
    if (await isBookmarked(lessonId)) {
      await remove(lessonId);
      return false;
    }
    await add(
      bookId: bookId,
      bookTitle: bookTitle,
      lessonId: lessonId,
      lessonTitle: lessonTitle,
    );
    return true;
  }

  /// Stamps the last-opened time for a bookmarked lesson. No-op when the
  /// lesson isn't bookmarked.
  static Future<void> markOpened(String lessonId) async {
    final prefs = await SharedPreferences.getInstance();
    final list = _read(prefs);
    final idx = list.indexWhere((b) => b.lessonId == lessonId);
    if (idx < 0) return;
    list[idx] = list[idx].copyWith(lastOpenedAt: DateTime.now().millisecondsSinceEpoch);
    await _write(prefs, list);
  }
}
