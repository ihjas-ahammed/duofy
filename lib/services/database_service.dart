import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import '../data/mock_books.dart';

class DatabaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  String get uid => FirebaseAuth.instance.currentUser?.uid ?? 'guest';
  String get _cacheKey => 'cached_books_$uid';

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
    print("[DatabaseService] Initiating Two-Way Firebase Sync...");
    try {
      final snapshot = await _dbRef.child('users').child(uid).child('books').get();
      Map<String, Book> remoteBooksMap = {};
      
      if (snapshot.exists) {
        final Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          final b = Book.fromJson(Map<String, dynamic>.from(value));
          remoteBooksMap[b.id] = b;
        });
        print("[DatabaseService] Fetched ${remoteBooksMap.length} books from remote DB.");
      } else {
        print("[DatabaseService] Remote DB is currently empty.");
      }

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
        print("[DatabaseService] Pushing updated local books to Remote DB...");
        for (var book in mergedList) {
          await _dbRef.child('users').child(uid).child('books').child(book.id).set(book.toJson());
        }
      } else if (remoteBooksMap.isEmpty && localBooks.isEmpty && uid == 'guest') {
        print("[DatabaseService] System is completely empty for guest. Populating mock books...");
        for (var book in mockBooks) {
          final mockWithTime = book.copyWith(updatedAt: DateTime.now().millisecondsSinceEpoch);
          await _dbRef.child('users').child(uid).child('books').child(mockWithTime.id).set(mockWithTime.toJson());
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

  Future<void> saveGeneratedBook(Book book) async {
    print("\n[DatabaseService] Saving Generated Book: ${book.id}");
    final updatedTime = DateTime.now().millisecondsSinceEpoch;
    final updatedBook = book.copyWith(updatedAt: updatedTime);
    
    try {
      await _dbRef.child('users').child(uid).child('books').child(updatedBook.id).set(updatedBook.toJson());

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
      print("[DatabaseService] Save Complete.");
    } catch (e) {
      print("[DatabaseService] ERROR during saveGeneratedBook: $e");
    }
  }

  Future<void> deleteBook(String id) async {
    print("\n[DatabaseService] Deleting Book: $id");
    try {
      await _dbRef.child('users').child(uid).child('books').child(id).remove();
      
      final prefs = await SharedPreferences.getInstance();
      final cachedStr = prefs.getString(_cacheKey);
      if (cachedStr != null) {
        List decoded = jsonDecode(cachedStr);
        decoded.removeWhere((e) => e['id'] == id);
        await prefs.setString(_cacheKey, jsonEncode(decoded));
      }
    } catch (e) {
      print("[DatabaseService] ERROR during deletion: $e");
    }
  }

  // GLOBAL COMMUNITY DB METHODS
  Future<List<Book>> fetchGlobalBooks() async {
    try {
      final snapshot = await _dbRef.child('global_books').get();
      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        return data.values.map((v) => Book.fromJson(Map<String, dynamic>.from(v))).toList();
      }
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
    await _dbRef.child('global_books').child(book.id).set(publishedBook.toJson());
  }
}