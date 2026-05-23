import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import '../data/mock_books.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String get uid => FirebaseAuth.instance.currentUser?.uid ?? 'guest';
  String get _cacheKey => 'cached_books_$uid';

  CollectionReference<Map<String, dynamic>> get _userBooks =>
      _db.collection('users').doc(uid).collection('books');

  CollectionReference<Map<String, dynamic>> get _globalBooks =>
      _db.collection('global_books');

  DocumentReference<Map<String, dynamic>> get _userSettingsDoc =>
      _db.collection('users').doc(uid).collection('meta').doc('settings');

  Future<void> saveUserSettings({
    required List<String> apiKeys,
    required List<String> models,
    List<String>? modelPrimaryTextList,
    List<String>? modelPrimaryGraphicsList,
    List<String>? modelLiteList,
  }) async {
    if (uid == 'guest') return;
    // Save to Firestore in background without awaiting (non-blocking).
    // Note: we write the new *List fields and also mirror the first entry
    // into the legacy scalar key so older app versions still read a value.
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
      print("[DatabaseService] User settings saved successfully to Firestore.");
    }).catchError((e) {
      print("[DatabaseService] Error saving user settings: $e");
    });
  }

  Future<Map<String, dynamic>?> fetchUserSettings() async {
    if (uid == 'guest') return null;
    try {
      final snap = await _userSettingsDoc.get().timeout(const Duration(seconds: 4));
      if (!snap.exists) return null;
      final data = snap.data() ?? {};
      // Reads new *List fields when present; otherwise wraps the legacy
      // scalar value into a one-element list so callers always get a list.
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

  Future<List<Book>> fetchBooks({bool forceRefresh = false}) async {
    print("\n[DatabaseService] === FETCH BOOKS REQUESTED for $uid ===");
    print("[DatabaseService] Force Refresh: $forceRefresh");

    final prefs = await SharedPreferences.getInstance();

    // 1. Fetch Local Cache
    final cachedStr = prefs.getString(_cacheKey);
    List<Book> localBooks = [];
    if (cachedStr != null) {
      try {
        final List decoded = jsonDecode(cachedStr);
        localBooks = decoded.map((e) => Book.fromJson(Map<String, dynamic>.from(e))).toList();
        print("[DatabaseService] Found ${localBooks.length} books in local cache.");
      } catch (e) {
        print("[DatabaseService] Error parsing local cache: $e");
      }
    }

    if (!forceRefresh && localBooks.isNotEmpty) {
      print("[DatabaseService] Returning local cache without network sync.");
      return localBooks;
    }

    // 2. Perform Intelligent Two-Way Sync with timeout
    print("[DatabaseService] Initiating Two-Way Firestore Sync...");
    try {
      final snapshot = await _userBooks.get().timeout(const Duration(seconds: 4));
      Map<String, Book> remoteBooksMap = {};

      for (final doc in snapshot.docs) {
        final b = Book.fromJson(Map<String, dynamic>.from(doc.data()));
        remoteBooksMap[b.id] = b;
      }
      print("[DatabaseService] Fetched ${remoteBooksMap.length} books from Firestore.");

      Map<String, Book> mergedBooksMap = {...remoteBooksMap};
      bool needsRemoteUpdate = false;

      // Compare local against remote
      print("[DatabaseService] Comparing Local vs Remote Timestamps...");
      for (var localBook in localBooks) {
        if (!remoteBooksMap.containsKey(localBook.id)) {
          mergedBooksMap[localBook.id] = localBook;
          needsRemoteUpdate = true;
        } else {
          final remoteBook = remoteBooksMap[localBook.id]!;
          final localTime = localBook.updatedAt ?? 0;
          final remoteTime = remoteBook.updatedAt ?? 0;

          if (localTime > remoteTime) {
            mergedBooksMap[localBook.id] = localBook;
            needsRemoteUpdate = true;
          }
        }
      }

      final mergedList = mergedBooksMap.values.toList();

      // Push required updates to Remote DB in background without awaiting (non-blocking)
      if (needsRemoteUpdate) {
        print("[DatabaseService] Pushing updated local books to Firestore in background...");
        for (var book in mergedList) {
          _userBooks.doc(book.id).set(book.toJson()).catchError((e) {
            print("[DatabaseService] Error syncing local book to remote: $e");
          });
        }
      } else if (remoteBooksMap.isEmpty && localBooks.isEmpty && uid == 'guest') {
        print("[DatabaseService] System is completely empty for guest. Populating mock books...");
        for (var book in mockBooks) {
          final mockWithTime = book.copyWith(updatedAt: DateTime.now().millisecondsSinceEpoch);
          _userBooks.doc(mockWithTime.id).set(mockWithTime.toJson()).catchError((e) {
            print("[DatabaseService] Guest mock sync failed: $e");
          });
          mergedList.add(mockWithTime);
        }
      }

      // Update Local Cache
      await prefs.setString(_cacheKey, jsonEncode(mergedList.map((b) => b.toJson()).toList()));
      return mergedList;

    } catch (e) {
      print("[DatabaseService] SYNC ERROR: $e");
      return localBooks;
    }
  }

  /// Returns the most recent locally-cached copy of [bookId], or null if not
  /// present. Use this when applying a partial mutation (e.g. one unit's newly
  /// generated lessons) to avoid clobbering concurrent edits that already
  /// landed in cache.
  Future<Book?> getBookFromCache(String bookId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedStr = prefs.getString(_cacheKey);
      if (cachedStr == null) return null;
      final List decoded = jsonDecode(cachedStr);
      for (final e in decoded) {
        final b = Book.fromJson(Map<String, dynamic>.from(e));
        if (b.id == bookId) return b;
      }
    } catch (e) {
      print("[DatabaseService] getBookFromCache error: $e");
    }
    return null;
  }

  Future<void> saveGeneratedBook(Book book) async {
    print("\n[DatabaseService] Saving Generated Book: ${book.id}");
    final updatedTime = DateTime.now().millisecondsSinceEpoch;
    final updatedBook = book.copyWith(updatedAt: updatedTime);

    // 1. Local cache first — must always succeed so the book appears in the UI
    //    even if Firestore writes are blocked (db not enabled / rules deny).
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedStr = prefs.getString(_cacheKey);
      List<Book> localBooks = [];
      if (cachedStr != null) {
        final List decoded = jsonDecode(cachedStr);
        localBooks = decoded.map((e) => Book.fromJson(Map<String, dynamic>.from(e))).toList();
      }

      final index = localBooks.indexWhere((b) => b.id == updatedBook.id);
      if (index >= 0) {
        localBooks[index] = updatedBook;
      } else {
        localBooks.add(updatedBook);
      }

      await prefs.setString(_cacheKey, jsonEncode(localBooks.map((b) => b.toJson()).toList()));
      print("[DatabaseService] Local cache updated.");
    } catch (e) {
      print("[DatabaseService] LOCAL CACHE ERROR during saveGeneratedBook: $e");
    }

    // 2. Then push to Firestore in the background without awaiting (non-blocking)
    _userBooks.doc(updatedBook.id).set(updatedBook.toJson()).then((_) {
      print("[DatabaseService] Firestore push complete.");
    }).catchError((e) {
      print("[DatabaseService] FIRESTORE PUSH FAILED (book is still saved locally): $e");
    });
  }

  Future<void> deleteBook(String id) async {
    print("\n[DatabaseService] Deleting Book: $id");

    // Local cache first so the UI updates regardless of Firestore state.
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedStr = prefs.getString(_cacheKey);
      if (cachedStr != null) {
        List decoded = jsonDecode(cachedStr);
        decoded.removeWhere((e) => e['id'] == id);
        await prefs.setString(_cacheKey, jsonEncode(decoded));
      }
    } catch (e) {
      print("[DatabaseService] LOCAL CACHE ERROR during deletion: $e");
    }

    // Firestore delete in the background without awaiting (non-blocking)
    _userBooks.doc(id).delete().then((_) {
      print("[DatabaseService] Firestore delete complete.");
    }).catchError((e) {
      print("[DatabaseService] FIRESTORE DELETE FAILED: $e");
    });
  }

  String get _globalCacheKey => 'cached_global_books';

  // GLOBAL COMMUNITY DB METHODS
  Future<List<Book>> fetchGlobalBooks({bool useCacheOnly = false}) async {
    final prefs = await SharedPreferences.getInstance();

    // 1. Fetch Local Cache
    final cachedStr = prefs.getString(_globalCacheKey);
    List<Book> cachedGlobals = [];
    if (cachedStr != null) {
      try {
        final List decoded = jsonDecode(cachedStr);
        cachedGlobals = decoded.map((e) => Book.fromJson(Map<String, dynamic>.from(e))).toList();
        print("[DatabaseService] Found ${cachedGlobals.length} global books in local cache.");
      } catch (e) {
        print("[DatabaseService] Error parsing global cache: $e");
      }
    }

    if (useCacheOnly && cachedGlobals.isNotEmpty) {
      return cachedGlobals;
    }

    // 2. Perform Firestore Fetch with timeout
    try {
      final snapshot = await _globalBooks.get().timeout(const Duration(seconds: 4));
      final freshGlobals = snapshot.docs
          .map((d) => Book.fromJson(Map<String, dynamic>.from(d.data())))
          .toList();

      // Update cache
      await prefs.setString(_globalCacheKey, jsonEncode(freshGlobals.map((b) => b.toJson()).toList()));
      return freshGlobals;
    } catch (e) {
      print("[DatabaseService] Error fetching global books: $e");
      return cachedGlobals;
    }
  }

  Future<void> publishToGlobal(Book book) async {
    final user = FirebaseAuth.instance.currentUser;
    final publishedBook = book.copyWith(
       authorId: user?.uid,
       authorName: user?.displayName ?? 'Anonymous User',
       isGlobal: true,
       updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
    // Push to Firestore in background without awaiting (non-blocking)
    _globalBooks.doc(book.id).set(publishedBook.toJson()).then((_) {
      print("[DatabaseService] Published to global successfully.");
    }).catchError((e) {
      print("[DatabaseService] Error publishing to global: $e");
    });
  }

  Future<void> deleteGlobalBook(String id) async {
    // Delete from Firestore in background without awaiting (non-blocking)
    _globalBooks.doc(id).delete().then((_) {
      print("[DatabaseService] Admin deleted global book: $id");
    }).catchError((e) {
      print("[DatabaseService] Error deleting global book: $e");
    });
  }
}
