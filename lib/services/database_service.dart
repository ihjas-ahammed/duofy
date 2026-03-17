import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import '../data/mock_books.dart';

class DatabaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  Future<List<Book>> fetchBooks({bool forceRefresh = false}) async {
    print("\n[DatabaseService] === FETCH BOOKS REQUESTED ===");
    print("[DatabaseService] Force Refresh: $forceRefresh");
    
    final prefs = await SharedPreferences.getInstance();
    
    // 1. Fetch Local Cache
    final cachedStr = prefs.getString('cached_books');
    List<Book> localBooks = [];
    if (cachedStr != null) {
      try {
        final List decoded = jsonDecode(cachedStr);
        localBooks = decoded.map((e) => Book.fromJson(Map<String, dynamic>.from(e))).toList();
        print("[DatabaseService] Found ${localBooks.length} books in local cache.");
      } catch (e) {
        print("[DatabaseService] Error parsing local cache: $e");
      }
    } else {
      print("[DatabaseService] Local cache is empty.");
    }

    if (!forceRefresh && localBooks.isNotEmpty) {
      print("[DatabaseService] Returning local cache without network sync.");
      return localBooks;
    }

    // 2. Perform Intelligent Two-Way Sync
    print("[DatabaseService] Initiating Two-Way Firebase Sync...");
    try {
      final snapshot = await _dbRef.child('books').get();
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
          print("[DatabaseService] Book ${localBook.id} exists locally but not remotely. Queuing upload.");
          mergedBooksMap[localBook.id] = localBook;
          needsRemoteUpdate = true;
        } else {
          final remoteBook = remoteBooksMap[localBook.id]!;
          final localTime = localBook.updatedAt ?? 0;
          final remoteTime = remoteBook.updatedAt ?? 0;
          
          if (localTime > remoteTime) {
            print("[DatabaseService] Local book ${localBook.id} is newer ($localTime > $remoteTime). Queuing upload.");
            mergedBooksMap[localBook.id] = localBook;
            needsRemoteUpdate = true;
          } else if (remoteTime > localTime) {
            print("[DatabaseService] Remote book ${localBook.id} is newer ($remoteTime > $localTime). Using remote.");
          } else {
            // Equal, no action needed
          }
        }
      }

      final mergedList = mergedBooksMap.values.toList();

      // Push required updates to Remote DB
      if (needsRemoteUpdate) {
        print("[DatabaseService] Pushing updated local books to Remote DB...");
        for (var book in mergedList) {
          await _dbRef.child('books').child(book.id).set(book.toJson());
        }
        print("[DatabaseService] Remote DB updated.");
      } else if (remoteBooksMap.isEmpty && localBooks.isEmpty) {
        print("[DatabaseService] System is completely empty. Populating mock books...");
        for (var book in mockBooks) {
          final mockWithTime = book.copyWith(updatedAt: DateTime.now().millisecondsSinceEpoch);
          await _dbRef.child('books').child(mockWithTime.id).set(mockWithTime.toJson());
          mergedList.add(mockWithTime);
        }
      }

      // Update Local Cache with merged reality
      print("[DatabaseService] Sync Complete. Updating local SharedPrefs cache.");
      await prefs.setString('cached_books', jsonEncode(mergedList.map((b) => b.toJson()).toList()));
      return mergedList;

    } catch (e) {
      print("[DatabaseService] SYNC ERROR: $e");
      print("[DatabaseService] Falling back to local cache.");
      return localBooks;
    }
  }

  Future<void> saveBooks(List<Book> books) async {
    for (var book in books) {
      await saveGeneratedBook(book);
    }
  }

  Future<void> saveGeneratedBook(Book book) async {
    print("\n[DatabaseService] Saving Generated Book: ${book.id}");
    final updatedTime = DateTime.now().millisecondsSinceEpoch;
    final updatedBook = book.copyWith(updatedAt: updatedTime);
    
    try {
      // 1. Save Remote
      print("[DatabaseService] Pushing to Firebase Realtime DB...");
      await _dbRef.child('books').child(updatedBook.id).set(updatedBook.toJson());

      // 2. Save Local Cache
      print("[DatabaseService] Updating Local SharedPrefs...");
      final prefs = await SharedPreferences.getInstance();
      final cachedStr = prefs.getString('cached_books');
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

      await prefs.setString('cached_books', jsonEncode(localBooks.map((b) => b.toJson()).toList()));
      print("[DatabaseService] Save Complete.");
    } catch (e) {
      print("[DatabaseService] ERROR during saveGeneratedBook: $e");
    }
  }

  Future<void> deleteBook(String id) async {
    print("\n[DatabaseService] Deleting Book: $id");
    try {
      await _dbRef.child('books').child(id).remove();
      print("[DatabaseService] Removed from Firebase.");
      
      final prefs = await SharedPreferences.getInstance();
      final cachedStr = prefs.getString('cached_books');
      if (cachedStr != null) {
        List decoded = jsonDecode(cachedStr);
        decoded.removeWhere((e) => e['id'] == id);
        await prefs.setString('cached_books', jsonEncode(decoded));
        print("[DatabaseService] Removed from Local Cache.");
      }
    } catch (e) {
      print("[DatabaseService] ERROR during deletion: $e");
    }
  }
}