import 'package:firebase_database/firebase_database.dart';
import '../models/app_models.dart';
import '../data/mock_books.dart';

class DatabaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  Future<List<Book>> fetchBooks() async {
    try {
      final snapshot = await _dbRef.child('books').get();
      if (snapshot.exists) {
        final Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        List<Book> books = [];
        data.forEach((key, value) {
          books.add(Book.fromJson(Map<String, dynamic>.from(value)));
        });
        return books;
      } else {
        // If DB is empty, populate with mock data for demonstration
        await saveBooks(mockBooks);
        return mockBooks;
      }
    } catch (e) {
      print('Firebase Error: \$e. Falling back to mock data.');
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