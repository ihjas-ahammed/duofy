import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import 'main_layout_screen.dart';

class BookRouteLoaderScreen extends StatefulWidget {
  final String bookId;
  const BookRouteLoaderScreen({super.key, required this.bookId});

  @override
  State<BookRouteLoaderScreen> createState() => _BookRouteLoaderScreenState();
}

class _BookRouteLoaderScreenState extends State<BookRouteLoaderScreen> {
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadBook();
  }

  Future<void> _loadBook() async {
    try {
      final db = DatabaseService();
      // 1. Check local cache first
      Book? b = await db.getBookFromCache(widget.bookId);
      if (b == null) {
        // 2. Fetch from global firestore
        b = await db.fetchGlobalBookById(widget.bookId);
        if (b != null) {
          // Save it locally so that modifications can be saved
          await db.saveGeneratedBook(b);
        }
      }
      
      if (b != null) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          // Redirect to main layout
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => MainLayoutScreen(book: b!),
              settings: RouteSettings(name: '/${b.id}'),
            ),
          );
        }
      } else {
        setState(() {
          _error = "Course not found. Ensure the course link is correct and cloud sync is enabled.";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = "Error loading course: $e";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: _isLoading
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: AppTheme.duoBlue),
                    SizedBox(height: 20),
                    Text(
                      "Loading course...",
                      style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Fetching from community library",
                      style: TextStyle(color: Colors.white38, fontSize: 12),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.error_outline_rounded, size: 64, color: AppTheme.duoRed),
                    const SizedBox(height: 24),
                    const Text(
                      "Failed to Open Course",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _error ?? "Unknown error occurred",
                      style: const TextStyle(color: Colors.white60, fontSize: 14, height: 1.4),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.duoBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text(
                        "Go to Dashboard",
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
