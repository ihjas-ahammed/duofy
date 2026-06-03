import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'ai_queue_screen.dart';
import '../services/fb/fb_auth.dart';
import '../models/app_models.dart';
import '../services/database_service.dart';
import '../services/progress_service.dart';
import '../services/generation_manager.dart';
import '../theme/app_theme.dart';
import '../widgets/compact_book_card.dart';
import '../widgets/community_book_card.dart';
import '../widgets/generating_book_card.dart';
import '../widgets/responsive_center.dart';
import '../widgets/sync_conflict_dialog.dart';
import 'package:flutter/foundation.dart';
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
      final fetched = await _db.fetchBooks(
        forceRefresh: true,
        onConflict: (local, remote) => showSyncConflictDialog(context, local, remote),
      );
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
              await ProgressService.clearBookProgress(book);
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
          body: ResponsiveCenter(
            child: isLoading
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
                        if (!kIsWeb)
                          IconButton(
                            icon: const Icon(LucideIcons.cpu, size: 28),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const AiQueueScreen()));
                            },
                          ),
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
                    
                    if (activeTasks.isNotEmpty && !kIsWeb)
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
                    
                    if (!kIsWeb)
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
                                         onLongPress: () => _showBookLongPressMenu(book),
                                         onDelete: () => _deleteLocalBook(book),
                                       );
                                   },
                                 ),
                               ),
                          ],
                        ),
                      ),

                    if (kIsWeb) ...[
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Published Courses',
                                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Explore and study courses published by the community.',
                                style: TextStyle(color: Colors.white54, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(24),
                        sliver: globalBooks.isEmpty
                            ? const SliverToBoxAdapter(
                                child: Center(
                                  child: Text('No published courses yet.', style: TextStyle(color: Colors.white54)),
                                ),
                              )
                            : SliverGrid(
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 360,
                                  mainAxisExtent: 120,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final gBook = globalBooks[index];
                                    final user = FbAuth.instance.currentUser;
                                    final bool isOwner = user != null && gBook.authorId == user.uid;
                                    final bool isSuperAdmin = user?.email == 'ihjas.one@gmail.com';
                                    final bool canDelete = isOwner || isSuperAdmin;

                                    return CommunityBookCard(
                                      book: gBook,
                                      buttonText: 'OPEN',
                                      onGetPressed: () {
                                        Navigator.pushNamed(context, '/${gBook.id}');
                                      },
                                      onDeletePressed: canDelete ? () async {
                                        final confirm = await showDialog<bool>(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            backgroundColor: AppTheme.surface,
                                            title: const Text('Unpublish Course?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                            content: const Text('Are you sure you want to unpublish this course from Published Courses? This won\'t delete your local copy if you have one.', style: TextStyle(color: Colors.white70)),
                                            actions: [
                                              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
                                              TextButton(
                                                onPressed: () => Navigator.pop(ctx, true),
                                                child: const Text('Unpublish', style: TextStyle(color: AppTheme.duoRed, fontWeight: FontWeight.bold)),
                                              ),
                                            ],
                                          ),
                                        );
                                        if (confirm == true) {
                                          await _db.deleteGlobalBook(gBook.id);
                                          _loadAllData(force: true);
                                        }
                                      } : null,
                                    );
                                  },
                                  childCount: globalBooks.length,
                                ),
                              ),
                      ),
                    ] else ...[
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(24, 32, 24, 16),
                              child: Text('Published Courses', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                            ),
                            if (globalBooks.isEmpty)
                               const Padding(
                                 padding: EdgeInsets.symmetric(horizontal: 24.0),
                                 child: Text('No published courses yet.', style: TextStyle(color: Colors.white54)),
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
                                     final bool isOwner = user != null && gBook.authorId == user.uid;
                                     final bool isSuperAdmin = user?.email == 'ihjas.one@gmail.com';
                                     final bool canDelete = isOwner || isSuperAdmin;

                                     return CommunityBookCard(
                                       book: gBook,
                                       buttonText: 'GET',
                                       onGetPressed: () => _downloadGlobalBook(gBook),
                                       onDeletePressed: canDelete ? () async {
                                         final confirm = await showDialog<bool>(
                                           context: context,
                                           builder: (ctx) => AlertDialog(
                                             backgroundColor: AppTheme.surface,
                                             title: const Text('Unpublish Course?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                             content: const Text('Are you sure you want to unpublish this course from Published Courses? This won\'t delete your local copy if you have one.', style: TextStyle(color: Colors.white70)),
                                             actions: [
                                               TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
                                               TextButton(
                                                 onPressed: () => Navigator.pop(ctx, true),
                                                 child: const Text('Unpublish', style: TextStyle(color: AppTheme.duoRed, fontWeight: FontWeight.bold)),
                                               ),
                                             ],
                                           ),
                                         );
                                         if (confirm == true) {
                                           await _db.deleteGlobalBook(gBook.id);
                                           _loadAllData(force: true);
                                         }
                                       } : null,
                                     );
                                   },
                                 ),
                               ),
                          ],
                        ),
                      ),
                    ],

                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                  ],
                ),
              ),
          ),
          floatingActionButton: kIsWeb ? null : FloatingActionButton(
            backgroundColor: AppTheme.duoGreen,
            child: const Icon(LucideIcons.plus, color: Colors.white, size: 32),
            onPressed: () => Navigator.push(
              context, 
              MaterialPageRoute(builder: (_) => const GenerateBookScreen())
            ).then((_) => _loadAllData(force: false)),
          ),
        );
      },
    );
  }

  void _showBookLongPressMenu(Book book) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              ),
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.duoBlue.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppTheme.duoBlue.withOpacity(0.4)),
                        ),
                        child: const Icon(LucideIcons.bookOpen, color: AppTheme.duoBlue, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'COURSE MENU',
                              style: TextStyle(
                                color: AppTheme.duoBlue,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              book.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildMenuItem(
                    icon: LucideIcons.play,
                    title: 'Generate Contents',
                    subtitle: 'Generate all lessons and graphics now',
                    iconColor: AppTheme.duoGreen,
                    onTap: () {
                      Navigator.pop(ctx);
                      _promptGenerateOrScheduleBook(book, isScheduled: false);
                    },
                  ),
                  _buildMenuItem(
                    icon: LucideIcons.calendar,
                    title: 'Schedule Generation',
                    subtitle: 'Queue for auto schedule hours',
                    iconColor: AppTheme.duoViolet,
                    onTap: () {
                      Navigator.pop(ctx);
                      _promptGenerateOrScheduleBook(book, isScheduled: true);
                    },
                  ),
                  _buildMenuItem(
                    icon: LucideIcons.trash2,
                    title: 'Delete Course',
                    subtitle: 'Remove from your library',
                    iconColor: AppTheme.duoRed,
                    onTap: () {
                      Navigator.pop(ctx);
                      _deleteLocalBook(book);
                    },
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _promptGenerateOrScheduleBook(Book book, {required bool isScheduled}) async {
    final wantsGraphics = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: Text(isScheduled ? 'Schedule Course Generation' : 'Generate Course Contents', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text(
          'Choose what kind of content to generate for all modules and sections in this course.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Text only', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('With diagrams', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
    if (wantsGraphics == null) return;
    
    GenerationManager.instance.startBookContentGeneration(
      book,
      generateGraphics: wantsGraphics,
      isScheduled: isScheduled,
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.surface,
        content: Text(isScheduled ? 'Course generation scheduled!' : 'Course generation queued!'),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white12),
            ),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 22),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(LucideIcons.chevronRight, size: 16, color: Colors.white24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}