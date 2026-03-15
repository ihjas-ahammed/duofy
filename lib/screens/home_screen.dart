import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../services/database_service.dart';
import '../services/progress_service.dart';
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
  Map<String, double> progressMap = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks({bool force = false}) async {
    final fetched = await _db.fetchBooks(forceRefresh: force);
    
    // Calculate progress metric locally
    Map<String, double> prog = {};
    for (var b in fetched) {
      prog[b.id] = await ProgressService.getBookProgress(b);
    }

    setState(() {
      books = fetched;
      progressMap = prog;
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
              child: RefreshIndicator(
                color: AppTheme.duoBlue,
                onRefresh: () => _loadBooks(force: true),
                child: GridView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => MainLayoutScreen(book: book)))
                          .then((_) => _loadBooks()); // Refresh progress on return
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
                            Expanded(
                              child: Text(
                                book.description,
                                style: const TextStyle(color: Colors.white54, fontSize: 12),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 12),
                            LinearProgressIndicator(
                              value: progressMap[book.id] ?? 0.0,
                              backgroundColor: Colors.white12,
                              color: AppTheme.duoGreen,
                              borderRadius: BorderRadius.circular(4),
                              minHeight: 6,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.duoGreen,
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const GenerateBookScreen()));
          _loadBooks(force: true); 
        },
        icon: const Icon(LucideIcons.sparkles, color: Colors.white),
        label: const Text('New Book', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}