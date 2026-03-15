import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import '../data/mock_books.dart';

class DatabaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  Future<List<Book>> fetchBooks({bool forceRefresh = false}) async {
    final prefs = await SharedPreferences.getInstance();

    // Load from cache first unless pull-to-refresh
    if (!forceRefresh) {
      final cached = prefs.getString('cached_books');
      if (cached != null) {
        try {
          final List decoded = jsonDecode(cached);
          // Launch a silent fetch in the background to keep cache fresh
          _fetchAndCacheFirebase();
          return decoded.map((e) => Book.fromJson(Map<String, dynamic>.from(e))).toList();
        } catch (e) {
          // Fall through to Firebase fetch if cache parsing fails
        }
      }
    }

    return await _fetchAndCacheFirebase();
  }

  Future<List<Book>> _fetchAndCacheFirebase() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final snapshot = await _dbRef.child('books').get();
      if (snapshot.exists) {
        final Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        List<Book> books = [];
        data.forEach((key, value) {
          books.add(Book.fromJson(Map<String, dynamic>.from(value)));
        });
        await prefs.setString('cached_books', jsonEncode(books.map((b) => b.toJson()).toList()));
        return books;
      } else {
        await saveBooks(mockBooks);
        await prefs.setString('cached_books', jsonEncode(mockBooks.map((b) => b.toJson()).toList()));
        return mockBooks;
      }
    } catch (e) {
      // If offline or errored out, fallback to local cache
      final cached = prefs.getString('cached_books');
      if (cached != null) {
        final List decoded = jsonDecode(cached);
        return decoded.map((e) => Book.fromJson(Map<String, dynamic>.from(e))).toList();
      }
      return mockBooks;
    }
  }

  Future<void> saveBooks(List<Book> books) async {
    for (var book in books) {
      await _dbRef.child('books').child(book.id).set(book.toJson());
    }
  }

  Future<void> saveGeneratedBook(Book book) async {
    await _dbRef.child('books').child(book.id).set(book.toJson());
  }
}