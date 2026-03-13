import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';
import 'main_layout_screen.dart';
import 'settings_screen.dart';
import 'generate_book_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _db = DatabaseService();
  List<Book> books = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    final fetched = await _db.fetchBooks();
    setState(() {
      books = fetched;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DuoFY Books', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.duoBlue))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => MainLayoutScreen(book: book)));
                    },
                    child: Container(
                      decoration: AppTheme.glassDecoration.copyWith(
                        border: Border.all(color: AppTheme.duoBlue.withOpacity(0.3), width: 2),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(LucideIcons.book, size: 48, color: AppTheme.duoBlue),
                          const SizedBox(height: 16),
                          Text(
                            book.title,
                            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            book.description,
                            style: const TextStyle(color: Colors.white54, fontSize: 12),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.duoGreen,
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const GenerateBookScreen()));
          _loadBooks(); // reload after generation
        },
        icon: const Icon(LucideIcons.sparkles, color: Colors.white),
        label: const Text('New Book', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}