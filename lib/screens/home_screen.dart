import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../services/fb/fb_auth.dart';
import '../models/app_models.dart';
import '../services/database_service.dart';
import '../services/progress_service.dart';
import '../services/generation_manager.dart';
import '../theme/app_theme.dart';
import '../widgets/compact_book_card.dart';
import '../widgets/community_book_card.dart';
import '../widgets/generating_book_card.dart';
import 'main_layout_screen.dart';
import 'settings_screen.dart';
import 'generate_book_screen.dart';
import 'pdf_split_preview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _db = DatabaseService();
  List<Book> books = [];
  List<Book> globalBooks = [];
  Map<String, double> progressMap = {};
  bool isLoading = true;

  StreamSubscription<Book>? _bookUpdateSubscription;
  List<GenerationTask> _prevActiveTasks = [];

  @override
  void initState() {
    super.initState();
    _prevActiveTasks = List.from(GenerationManager.instance.activeTasks);
    _loadAllData(force: false);
    _syncRemoteData();

    GenerationManager.instance.addListener(_handleGenerationTasksChange);
    _bookUpdateSubscription = GenerationManager.instance.bookUpdates.listen((_) {
      _loadAllData(force: false);
    });
    GenerationManager.instance.onBookGenerated = () => _loadAllData(force: false);
  }

  @override
  void dispose() {
    GenerationManager.instance.removeListener(_handleGenerationTasksChange);
    _bookUpdateSubscription?.cancel();
    super.dispose();
  }

  void _handleGenerationTasksChange() {
    final currentTasks = GenerationManager.instance.activeTasks;
    bool taskRemoved = false;
    for (var prev in _prevActiveTasks) {
      if (!currentTasks.any((t) => t.id == prev.id)) {
        taskRemoved = true;
        break;
      }
    }
    _prevActiveTasks = List.from(currentTasks);

    if (taskRemoved) {
      _loadAllData(force: false);
    }
  }

  Future<void> _loadAllData({bool force = false}) async {
    // 1. Fetch Local Cache immediately
    final fetched = await _db.fetchBooks(forceRefresh: false);
    final globals = await _db.fetchGlobalBooks(useCacheOnly: true);
    
    Map<String, double> prog = {};
    for (var b in fetched) {
      prog[b.id] = await ProgressService.getBookProgress(b);
    }

    if (mounted) {
      setState(() {
        books = fetched;
        if (globals.isNotEmpty) {
          globalBooks = globals;
        }
        progressMap = prog;
        isLoading = false;
      });
    }

    // 2. Perform background sync if force is true
    if (force) {
      _syncRemoteData();
    }
  }

  Future<void> _syncRemoteData() async {
    try {
      final fetched = await _db.fetchBooks(forceRefresh: true);
      final globals = await _db.fetchGlobalBooks(useCacheOnly: false);
      
      Map<String, double> prog = {};
      for (var b in fetched) {
        prog[b.id] = await ProgressService.getBookProgress(b);
      }

      if (mounted) {
        setState(() {
          books = fetched;
          globalBooks = globals;
          progressMap = prog;
        });
      }
    } catch (e) {
      print("[HomeScreen] Background sync error: $e");
    }
  }

  void _downloadGlobalBook(Book globalBook) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Downloading ${globalBook.title}...')));
    
    final newBook = globalBook.copyWith(
      id: 'dl_${DateTime.now().millisecondsSinceEpoch}',
      isGlobal: false,
    );
    
    await _db.saveGeneratedBook(newBook);
    await _loadAllData(force: false);
    
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved to your library!')));
  }

  void _deleteLocalBook(Book book) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Delete Course?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to delete this course from your local library?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await _db.deleteBook(book.id);
              _loadAllData(force: true);
            }, 
            child: const Text('Delete', style: TextStyle(color: AppTheme.duoRed, fontWeight: FontWeight.bold))
          ),
        ]
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
                onRefresh: () async {
                  await _loadAllData(force: false);
                  await _syncRemoteData();
                },
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  slivers:[
                    SliverAppBar(
                      expandedHeight: 120,
                      floating: true,
                      backgroundColor: AppTheme.background,
                      flexibleSpace: const FlexibleSpaceBar(
                        titlePadding: EdgeInsets.only(left: 24, bottom: 16),
                        title: Text('Discover', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28, color: Colors.white)),
                      ),
                      actions:[
                        IconButton(
                          padding: const EdgeInsets.only(right: 16),
                          icon: const Icon(LucideIcons.userCircle, size: 28),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))
                              .then((_) => _loadAllData(force: false));
                          },
                        )
                      ],
                    ),
                    
                    if (activeTasks.isNotEmpty)
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final task = activeTasks[index];
                              return GeneratingBookCard(
                                task: task,
                                onTap: () {
                                  if (task.state == BookGenState.review && task.skeletonBook != null) {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (_) => PdfSplitPreviewScreen(
                                        taskId: task.id,
                                        originalPdf: task.sourceFiles,
                                        skeletonBook: task.skeletonBook!,
                                      )
                                    )).then((_) => _loadAllData(force: false));
                                  } else if (task.state == BookGenState.error) {
                                    GenerationManager.instance.dismissTask(task.id);
                                  }
                                }
                              );
                            },
                            childCount: activeTasks.length,
                          ),
                        ),
                      ),
                    
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                            child: Text('Your Library', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                          ),
                          if (books.isEmpty && activeTasks.isEmpty)
                             Container(
                               height: 180,
                               margin: const EdgeInsets.symmetric(horizontal: 24),
                               decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(24)),
                               alignment: Alignment.center,
                               child: const Text('No courses found.\nTap + to create one!', textAlign: TextAlign.center, style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold)),
                             )
                          else if (books.isNotEmpty)
                             SizedBox(
                               height: 220,
                               child: ListView.builder(
                                 scrollDirection: Axis.horizontal,
                                 physics: const BouncingScrollPhysics(),
                                 padding: const EdgeInsets.only(left: 8, right: 24),
                                 itemCount: books.length,
                                 itemBuilder: (context, index) {
                                   final book = books[index];
                                   return CompactBookCard(
                                     book: book,
                                     progress: progressMap[book.id] ?? 0.0,
                                     onTap: () {
                                       Navigator.push(context, MaterialPageRoute(builder: (_) => MainLayoutScreen(book: book)))
                                         .then((_) => _loadAllData(force: false));
                                     },
                                     onDelete: () => _deleteLocalBook(book),
                                   );
                                 },
                               ),
                             ),
                        ],
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(24, 32, 24, 16),
                            child: Text('Community Picks', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                          ),
                          if (globalBooks.isEmpty)
                             const Padding(
                               padding: EdgeInsets.symmetric(horizontal: 24.0),
                               child: Text('No community books published yet.', style: TextStyle(color: Colors.white54)),
                             )
                          else
                             SizedBox(
                               height: 120,
                               child: ListView.builder(
                                 scrollDirection: Axis.horizontal,
                                 physics: const BouncingScrollPhysics(),
                                 padding: const EdgeInsets.only(left: 8, right: 24),
                                 itemCount: globalBooks.length,
                                 itemBuilder: (context, index) {
                                   final gBook = globalBooks[index];
                                   final user = FbAuth.instance.currentUser;
                                   final bool isSuperAdmin = user?.email == 'ihjas.one@gmail.com';

                                   return CommunityBookCard(
                                     book: gBook,
                                     onGetPressed: () => _downloadGlobalBook(gBook),
                                     onDeletePressed: isSuperAdmin ? () async {
                                        await _db.deleteGlobalBook(gBook.id);
                                        _loadAllData(force: true);
                                     } : null,
                                   );
                                 },
                               ),
                             ),
                        ],
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                  ],
                ),
              ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppTheme.duoGreen,
            child: const Icon(LucideIcons.plus, color: Colors.white, size: 32),
            onPressed: () => Navigator.push(
              context, 
              MaterialPageRoute(builder: (_) => const GenerateBookScreen())
            ).then((_) => _loadAllData(force: false)),
          ),
        );
      }
    );
  }
}