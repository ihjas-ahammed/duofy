import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import '../data/mock_books.dart';

/// Local-first storage.
///
/// Books are the source of truth **on the device**: each book is a single
/// JSON file under the app's documents directory, mirrored by an in-memory
/// map so reads are cheap and a per-lesson streaming save only rewrites that
/// one small file (not the whole library, as the old single-key
/// SharedPreferences cache did).
///
/// Cloud (Firestore) is an **optional backup/sync layer**, controlled by the
/// [cloudSyncPrefKey] setting and OFF by default. When disabled, no Firestore
/// reads or writes occur at all — the app works fully offline.
class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String get uid => FirebaseAuth.instance.currentUser?.uid ?? 'guest';

  // ---------------------------------------------------------------------------
  // Cloud sync toggle (local-first: OFF unless the user opts in from Settings)
  // ---------------------------------------------------------------------------
  static const String cloudSyncPrefKey = 'cloud_sync_enabled';

  /// Whether cloud backup/sync is enabled. Defaults to false so the app is
  /// fully local unless the user turns it on.
  Future<bool> isCloudEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(cloudSyncPrefKey) ?? false;
  }

  Future<void> setCloudEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(cloudSyncPrefKey, enabled);
  }

  CollectionReference<Map<String, dynamic>> get _userBooks =>
      _db.collection('users').doc(uid).collection('books');

  CollectionReference<Map<String, dynamic>> get _globalBooks =>
      _db.collection('global_books');

  DocumentReference<Map<String, dynamic>> get _userSettingsDoc =>
      _db.collection('users').doc(uid).collection('meta').doc('settings');

  // ---------------------------------------------------------------------------
  // Local file store (per-book JSON files + an in-memory index)
  // ---------------------------------------------------------------------------
  // Keyed by uid so switching accounts keeps libraries separate. Static so the
  // cache survives the short-lived `DatabaseService()` instances call sites
  // create.
  static final Map<String, Map<String, Book>> _mem = {};
  static final Map<String, Future<Map<String, Book>>> _loading = {};

  Future<Directory> _booksDir(String forUid) async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory('${base.path}/duofy_books/$forUid');
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  File _bookFile(Directory dir, String id) {
    // Keep ids filename-safe (book ids are app-generated, but be defensive).
    final safe = id.replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_');
    return File('${dir.path}/$safe.json');
  }

  /// Loads (once per uid) the on-disk library into memory, migrating any data
  /// left behind in the legacy single-key SharedPreferences cache.
  Future<Map<String, Book>> _ensureLoaded() {
    final u = uid;
    final cached = _mem[u];
    if (cached != null) return Future.value(cached);
    final inFlight = _loading[u];
    if (inFlight != null) return inFlight;
    final fut = _loadFromDisk(u);
    _loading[u] = fut;
    return fut;
  }

  Future<Map<String, Book>> _loadFromDisk(String u) async {
    final Map<String, Book> result = {};
    try {
      final dir = await _booksDir(u);
      final files = dir
          .listSync()
          .whereType<File>()
          .where((f) => f.path.toLowerCase().endsWith('.json'));
      for (final f in files) {
        try {
          final txt = await f.readAsString();
          if (txt.trim().isEmpty) continue;
          final b = Book.fromJson(Map<String, dynamic>.from(jsonDecode(txt)));
          if (b.id.isNotEmpty) result[b.id] = b;
        } catch (e) {
          // One bad file no longer nukes the whole library.
          print("[DatabaseService] Skipping unreadable book file ${f.path}: $e");
        }
      }

      // One-time migration from the old `cached_books_<uid>` blob. Guarded by a
      // flag so deleting every book doesn't resurrect them on next launch.
      final prefs = await SharedPreferences.getInstance();
      final migrated = prefs.getBool('books_migrated_$u') ?? false;
      if (result.isEmpty && !migrated) {
        final legacy = prefs.getString('cached_books_$u');
        if (legacy != null && legacy.trim().isNotEmpty) {
          try {
            final List decoded = jsonDecode(legacy);
            for (final e in decoded) {
              final b = Book.fromJson(Map<String, dynamic>.from(e));
              if (b.id.isNotEmpty) {
                result[b.id] = b;
                await _writeBookFile(u, b);
              }
            }
            print("[DatabaseService] Migrated ${result.length} books from legacy cache for $u.");
          } catch (e) {
            print("[DatabaseService] Legacy cache migration failed: $e");
          }
        }
        await prefs.setBool('books_migrated_$u', true);
      }
    } catch (e) {
      print("[DatabaseService] _loadFromDisk error for $u: $e");
    }
    _mem[u] = result;
    _loading.remove(u);
    return result;
  }

  /// Atomic-ish single-book write: write to a temp file then rename, so an
  /// interrupted write can never leave a half-written (corrupt) book file.
  Future<void> _writeBookFile(String forUid, Book book) async {
    final dir = await _booksDir(forUid);
    final target = _bookFile(dir, book.id);
    final tmp = File('${target.path}.tmp');
    await tmp.writeAsString(jsonEncode(book.toJson()), flush: true);
    if (await target.exists()) await target.delete();
    await tmp.rename(target.path);
  }

  Future<void> _deleteBookFile(String forUid, String id) async {
    try {
      final dir = await _booksDir(forUid);
      final f = _bookFile(dir, id);
      if (await f.exists()) await f.delete();
    } catch (e) {
      print("[DatabaseService] _deleteBookFile error: $e");
    }
  }

  // ---------------------------------------------------------------------------
  // Settings (cloud-only convenience — local settings live in SharedPreferences
  // and are owned by SettingsScreen). Gated behind the cloud toggle.
  // ---------------------------------------------------------------------------
  Future<void> saveUserSettings({
    required List<String> apiKeys,
    required List<String> models,
    List<String>? modelPrimaryTextList,
    List<String>? modelPrimaryGraphicsList,
    List<String>? modelLiteList,
  }) async {
    if (uid == 'guest') return;
    if (!await isCloudEnabled()) return; // local-first: nothing to push
    _userSettingsDoc.set({
      'apiKeys': apiKeys,
      'models': models,
      if (modelPrimaryTextList != null) ...{
        'modelPrimaryTextList': modelPrimaryTextList,
        if (modelPrimaryTextList.isNotEmpty) 'modelPrimaryText': modelPrimaryTextList.first,
      },
      if (modelPrimaryGraphicsList != null) ...{
        'modelPrimaryGraphicsList': modelPrimaryGraphicsList,
        if (modelPrimaryGraphicsList.isNotEmpty) 'modelPrimaryGraphics': modelPrimaryGraphicsList.first,
      },
      if (modelLiteList != null) ...{
        'modelLiteList': modelLiteList,
        if (modelLiteList.isNotEmpty) 'modelLite': modelLiteList.first,
      },
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
    }).then((_) {
      print("[DatabaseService] User settings saved to Firestore.");
    }).catchError((e) {
      print("[DatabaseService] Error saving user settings: $e");
    });
  }

  Future<Map<String, dynamic>?> fetchUserSettings() async {
    if (uid == 'guest') return null;
    if (!await isCloudEnabled()) return null; // local-first: don't hit network
    try {
      final snap = await _userSettingsDoc.get().timeout(const Duration(seconds: 4));
      if (!snap.exists) return null;
      final data = snap.data() ?? {};
      List<String> readList(String listKey, String scalarKey) {
        final list = data[listKey] as List?;
        if (list != null && list.isNotEmpty) return List<String>.from(list);
        final scalar = data[scalarKey] as String?;
        if (scalar != null && scalar.trim().isNotEmpty) return [scalar.trim()];
        return [];
      }
      return {
        'apiKeys': List<String>.from((data['apiKeys'] as List?) ?? []),
        'models': List<String>.from((data['models'] as List?) ?? []),
        'modelPrimaryTextList': readList('modelPrimaryTextList', 'modelPrimaryText'),
        'modelPrimaryGraphicsList': readList('modelPrimaryGraphicsList', 'modelPrimaryGraphics'),
        'modelLiteList': readList('modelLiteList', 'modelLite'),
      };
    } catch (e) {
      print("[DatabaseService] Error fetching user settings: $e");
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // Books
  // ---------------------------------------------------------------------------
  Future<List<Book>> fetchBooks({bool forceRefresh = false}) async {
    final local = await _ensureLoaded();
    final cloud = await isCloudEnabled();

    // Local-first path: when cloud is off we never touch the network.
    if (!cloud) {
      if (local.isEmpty && uid == 'guest') {
        await _seedGuestMocks(local);
      }
      return _sorted(local.values);
    }

    // Cloud enabled: return local immediately unless a refresh was requested.
    if (!forceRefresh && local.isNotEmpty) {
      return _sorted(local.values);
    }

    // Two-way sync: pull remote, merge by updatedAt, push back local-newer
    // books, and persist the merged set to the local file store.
    try {
      final snapshot = await _userBooks.get().timeout(const Duration(seconds: 4));
      final Map<String, Book> remote = {};
      for (final doc in snapshot.docs) {
        final b = Book.fromJson(Map<String, dynamic>.from(doc.data()));
        remote[b.id] = b;
      }

      final Map<String, Book> merged = {...remote};
      final List<Book> toPush = [];

      for (final localBook in local.values) {
        final remoteBook = remote[localBook.id];
        if (remoteBook == null) {
          merged[localBook.id] = localBook;
          toPush.add(localBook);
        } else if ((localBook.updatedAt ?? 0) > (remoteBook.updatedAt ?? 0)) {
          merged[localBook.id] = localBook;
          toPush.add(localBook);
        }
      }

      // Persist merged set locally (remote-only books land on disk too).
      for (final b in merged.values) {
        local[b.id] = b;
        await _writeBookFile(uid, b);
      }

      // Background push of local-newer books (non-blocking).
      for (final b in toPush) {
        _userBooks.doc(b.id).set(b.toJson()).catchError((e) {
          print("[DatabaseService] Error syncing local book ${b.id} to remote: $e");
        });
      }

      if (merged.isEmpty && uid == 'guest') {
        await _seedGuestMocks(local);
        return _sorted(local.values);
      }

      return _sorted(merged.values);
    } catch (e) {
      print("[DatabaseService] SYNC ERROR (returning local): $e");
      return _sorted(local.values);
    }
  }

  List<Book> _sorted(Iterable<Book> books) {
    final list = books.toList();
    list.sort((a, b) => (b.updatedAt ?? 0).compareTo(a.updatedAt ?? 0));
    return list;
  }

  Future<void> _seedGuestMocks(Map<String, Book> into) async {
    for (final book in mockBooks) {
      final seeded = book.copyWith(updatedAt: DateTime.now().millisecondsSinceEpoch);
      into[seeded.id] = seeded;
      await _writeBookFile('guest', seeded);
    }
    print("[DatabaseService] Seeded ${mockBooks.length} mock books for guest (local).");
  }

  /// Returns the freshest in-memory copy of [bookId] (or null). Backed by the
  /// file store, so partial mutations during generation read each other's
  /// latest writes without re-reading the disk every time.
  Future<Book?> getBookFromCache(String bookId) async {
    final books = await _ensureLoaded();
    return books[bookId];
  }

  Future<void> saveGeneratedBook(Book book) async {
    final updatedBook = book.copyWith(updatedAt: DateTime.now().millisecondsSinceEpoch);

    // 1. Local file store first — this is the source of truth and must succeed
    //    for the book to appear in the UI. Only this one book's file is
    //    rewritten, so per-lesson streaming saves stay cheap.
    final books = await _ensureLoaded();
    books[updatedBook.id] = updatedBook;
    try {
      await _writeBookFile(uid, updatedBook);
    } catch (e) {
      print("[DatabaseService] LOCAL WRITE ERROR during saveGeneratedBook: $e");
    }

    // 2. Optional cloud backup (background, non-blocking).
    if (await isCloudEnabled()) {
      _userBooks.doc(updatedBook.id).set(updatedBook.toJson()).catchError((e) {
        print("[DatabaseService] Cloud push failed (book is still saved locally): $e");
      });
    }
  }

  Future<void> deleteBook(String id) async {
    final books = await _ensureLoaded();
    books.remove(id);
    await _deleteBookFile(uid, id);

    if (await isCloudEnabled()) {
      _userBooks.doc(id).delete().catchError((e) {
        print("[DatabaseService] Cloud delete failed: $e");
      });
    }
  }

  // ---------------------------------------------------------------------------
  // Global / community books (inherently a cloud feature)
  // ---------------------------------------------------------------------------
  String get _globalCacheKey => 'cached_global_books';

  Future<List<Book>> fetchGlobalBooks({bool useCacheOnly = false}) async {
    final prefs = await SharedPreferences.getInstance();

    final cachedStr = prefs.getString(_globalCacheKey);
    List<Book> cachedGlobals = [];
    if (cachedStr != null) {
      try {
        final List decoded = jsonDecode(cachedStr);
        cachedGlobals = decoded.map((e) => Book.fromJson(Map<String, dynamic>.from(e))).toList();
      } catch (e) {
        print("[DatabaseService] Error parsing global cache: $e");
      }
    }

    if (useCacheOnly && cachedGlobals.isNotEmpty) return cachedGlobals;
    // Community browsing needs the network; respect the local-first toggle.
    if (!await isCloudEnabled()) return cachedGlobals;

    try {
      final snapshot = await _globalBooks.get().timeout(const Duration(seconds: 4));
      final freshGlobals = snapshot.docs
          .map((d) => Book.fromJson(Map<String, dynamic>.from(d.data())))
          .toList();
      await prefs.setString(_globalCacheKey, jsonEncode(freshGlobals.map((b) => b.toJson()).toList()));
      return freshGlobals;
    } catch (e) {
      print("[DatabaseService] Error fetching global books: $e");
      return cachedGlobals;
    }
  }

  /// Publishes [book] to the community. Returns false (no-op) when cloud sync
  /// is disabled, so the caller can prompt the user to enable it.
  Future<bool> publishToGlobal(Book book) async {
    if (!await isCloudEnabled()) return false;
    final user = FirebaseAuth.instance.currentUser;
    final publishedBook = book.copyWith(
      authorId: user?.uid,
      authorName: user?.displayName ?? 'Anonymous User',
      isGlobal: true,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
    _globalBooks.doc(book.id).set(publishedBook.toJson()).then((_) {
      print("[DatabaseService] Published to global successfully.");
    }).catchError((e) {
      print("[DatabaseService] Error publishing to global: $e");
    });
    return true;
  }

  Future<void> deleteGlobalBook(String id) async {
    if (!await isCloudEnabled()) return;
    _globalBooks.doc(id).delete().then((_) {
      print("[DatabaseService] Admin deleted global book: $id");
    }).catchError((e) {
      print("[DatabaseService] Error deleting global book: $e");
    });
  }
}
