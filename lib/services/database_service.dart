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

  Future<void> saveUserSettings({required List<String> apiKeys, required List<String> models}) async {
    if (uid == 'guest') return;
    try {
      await _userSettingsDoc.set({
        'apiKeys': apiKeys,
        'models': models,
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      print("[DatabaseService] Error saving user settings: $e");
    }
  }

  Future<Map<String, List<String>>?> fetchUserSettings() async {
    if (uid == 'guest') return null;
    try {
      final snap = await _userSettingsDoc.get();
      if (!snap.exists) return null;
      final data = snap.data() ?? {};
      return {
        'apiKeys': List<String>.from((data['apiKeys'] as List?) ?? []),
        'models': List<String>.from((data['models'] as List?) ?? []),
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

    // 2. Perform Intelligent Two-Way Sync
    print("[DatabaseService] Initiating Two-Way Firestore Sync...");
    try {
      final snapshot = await _userBooks.get();
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

      // Push required updates to Remote DB
      if (needsRemoteUpdate) {
        print("[DatabaseService] Pushing updated local books to Firestore...");
        for (var book in mergedList) {
          await _userBooks.doc(book.id).set(book.toJson());
        }
      } else if (remoteBooksMap.isEmpty && localBooks.isEmpty && uid == 'guest') {
        print("[DatabaseService] System is completely empty for guest. Populating mock books...");
        for (var book in mockBooks) {
          final mockWithTime = book.copyWith(updatedAt: DateTime.now().millisecondsSinceEpoch);
          await _userBooks.doc(mockWithTime.id).set(mockWithTime.toJson());
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

    // 2. Then push to Firestore. Failures here are non-fatal — local copy stands.
    try {
      await _userBooks.doc(updatedBook.id).set(updatedBook.toJson());
      print("[DatabaseService] Firestore push complete.");
    } catch (e) {
      print("[DatabaseService] FIRESTORE PUSH FAILED (book is still saved locally): $e");
    }
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

    try {
      await _userBooks.doc(id).delete();
    } catch (e) {
      print("[DatabaseService] FIRESTORE DELETE FAILED: $e");
    }
  }

  // GLOBAL COMMUNITY DB METHODS
  Future<List<Book>> fetchGlobalBooks() async {
    try {
      final snapshot = await _globalBooks.get();
      return snapshot.docs
          .map((d) => Book.fromJson(Map<String, dynamic>.from(d.data())))
          .toList();
    } catch (e) {
      print("[DatabaseService] Error fetching global books: $e");
    }
    return [];
  }

  Future<void> publishToGlobal(Book book) async {
    final user = FirebaseAuth.instance.currentUser;
    final publishedBook = book.copyWith(
       authorId: user?.uid,
       authorName: user?.displayName ?? 'Anonymous User',
       isGlobal: true,
       updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _globalBooks.doc(book.id).set(publishedBook.toJson());
  }

  Future<void> deleteGlobalBook(String id) async {
    try {
      await _globalBooks.doc(id).delete();
      print("[DatabaseService] Admin deleted global book: $id");
    } catch (e) {
      print("[DatabaseService] Error deleting global book: $e");
    }
  }
}
