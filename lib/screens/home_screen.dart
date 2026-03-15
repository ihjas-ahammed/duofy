import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../services/database_service.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import '../widgets/book_tile.dart';
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
  List<Book> books =[];
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
        title: const Text('DuoFY', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        actions:[
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
          : RefreshIndicator(
              color: AppTheme.duoBlue,
              onRefresh: () => _loadBooks(force: true),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers:[
                  // Top Search Bar (Visual proxy for Start Menu search)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Row(
                          children: const[
                            Icon(LucideIcons.search, color: Colors.white54, size: 20),
                            SizedBox(width: 12),
                            Text('Type here to search learning content', style: TextStyle(color: Colors.white54, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Pinned Header
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          const Text('Pinned Books', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)),
                            child: const Text('All items >', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                  ),

                  // Start Menu Tiles Grid
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8, // Tailored for compact space (approx 135px height)
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final book = books[index];
                          return BookTile(
                            book: book,
                            progress: progressMap[book.id] ?? 0.0,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => MainLayoutScreen(book: book)))
                                .then((_) => _loadBooks()); // Refresh progress on return
                            },
                          );
                        },
                        childCount: books.length,
                      ),
                    ),
                  ),
                  
                  // Extra space to prevent fab cutoff
                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
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