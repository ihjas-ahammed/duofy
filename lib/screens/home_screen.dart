import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../services/database_service.dart';
import '../services/progress_service.dart';
import '../services/generation_manager.dart';
import '../theme/app_theme.dart';
import '../widgets/book_card.dart';
import '../widgets/generating_book_tile.dart';
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
    GenerationManager.instance.onBookGenerated = () => _loadBooks(force: true);
  }

  Future<void> _loadBooks({bool force = false}) async {
    final fetched = await _db.fetchBooks(forceRefresh: force);
    Map<String, double> prog = {};
    for (var b in fetched) {
      prog[b.id] = await ProgressService.getBookProgress(b);
    }

    if (mounted) {
      setState(() {
        books = fetched;
        progressMap = prog;
        isLoading = false;
      });
    }
  }

  void _deleteBook(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Delete Course?', style: TextStyle(fontWeight: FontWeight.w900)),
        content: const Text('This will permanently delete the course and all its downloaded chunks.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              setState(() => isLoading = true);
              await _db.deleteBook(id);
              _loadBooks(force: true);
            },
            child: const Text('Delete', style: TextStyle(color: AppTheme.duoRed, fontWeight: FontWeight.bold)),
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: GenerationManager.instance,
      builder: (context, child) {
        final activeTasks = GenerationManager.instance.activeTasks;

        return Scaffold(
          backgroundColor: AppTheme.background,
          body: isLoading
            ? const Center(child: CircularProgressIndicator(color: AppTheme.duoBlue))
            : RefreshIndicator(
                color: AppTheme.duoBlue,
                onRefresh: () => _loadBooks(force: true),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  slivers:[
                    SliverAppBar(
                      expandedHeight: 120,
                      floating: true,
                      backgroundColor: AppTheme.background,
                      flexibleSpace: FlexibleSpaceBar(
                        titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
                        title: const Text('Today', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28, color: Colors.white)),
                      ),
                      actions:[
                        IconButton(
                          padding: const EdgeInsets.only(right: 16),
                          icon: const Icon(LucideIcons.settings, size: 28),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
                          },
                        )
                      ],
                    ),

                    if (activeTasks.isNotEmpty)
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                              child: Text('Generating...', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.white54)),
                            ),
                            SizedBox(
                              height: 140,
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                scrollDirection: Axis.horizontal,
                                itemCount: activeTasks.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 140,
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    child: GeneratingBookTile(task: activeTasks[index])
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    
                    if (books.isEmpty && activeTasks.isEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(LucideIcons.bookDown, size: 80, color: Colors.white24),
                                const SizedBox(height: 16),
                                const Text('No courses found.\nTap the + button to create one.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white54, fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                      ),

                    if (books.isNotEmpty)
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final book = books[index];
                              return BookCard(
                                book: book,
                                progress: progressMap[book.id] ?? 0.0,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => MainLayoutScreen(book: book)))
                                    .then((_) => _loadBooks());
                                },
                                onDelete: () => _deleteBook(book.id),
                              );
                            },
                            childCount: books.length,
                          ),
                        ),
                      ),
                    
                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                  ],
                ),
              ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppTheme.duoGreen,
            child: const Icon(LucideIcons.plus, color: Colors.white, size: 32),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GenerateBookScreen())),
          ),
        );
      }
    );
  }
}