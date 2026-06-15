import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'ai_queue_screen.dart';
import 'lesson_screen.dart';
import '../services/fb/fb_auth.dart';
import '../models/app_models.dart';
import '../services/database_service.dart';
import '../services/progress_service.dart';
import '../services/generation_manager.dart';
import '../services/learning_sync.dart';
import 'bookmarks_screen.dart';
import '../theme/app_theme.dart';
import '../widgets/compact_book_card.dart';
import '../widgets/compact_book_list_item.dart';
import '../widgets/generating_book_card.dart';
import '../widgets/responsive_center.dart';
import '../widgets/sync_conflict_dialog.dart';
import 'package:flutter/foundation.dart';
import 'main_layout_screen.dart';
import 'settings_screen.dart';
import 'generate_book_screen.dart';
import 'pdf_split_preview_screen.dart';
import 'course_edit_structure_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/global_state.dart';
import '../main.dart';
import 'metacognition_setup_screen.dart';
import '../widgets/analytics_view.dart';
import 'document_store_screen.dart';

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
  int _selectedTabIndex = 0;

  bool _isListView = true;

  final TextEditingController _librarySearchController = TextEditingController();
  final TextEditingController _publishedSearchController = TextEditingController();
  String _librarySearchQuery = '';
  String _publishedSearchQuery = '';

  StreamSubscription<Book>? _bookUpdateSubscription;
  List<GenerationTask> _prevActiveTasks = [];

  Future<void> _loadListViewPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isListView = prefs.getBool('home_is_list_view') ?? true;
    });
  }

  Future<void> _toggleListView() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isListView = !_isListView;
      prefs.setBool('home_is_list_view', _isListView);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadListViewPreference();
    _librarySearchController.addListener(() {
      setState(() {
        _librarySearchQuery = _librarySearchController.text;
      });
    });
    _publishedSearchController.addListener(() {
      setState(() {
        _publishedSearchQuery = _publishedSearchController.text;
      });
    });
    _prevActiveTasks = List.from(GenerationManager.instance.activeTasks);
    _loadAllData(force: false);
    _syncRemoteData();

    GenerationManager.instance.addListener(_handleGenerationTasksChange);
    _bookUpdateSubscription = GenerationManager.instance.bookUpdates.listen((_) {
      _loadAllData(force: false);
    });
    GenerationManager.instance.onBookGenerated = () => _loadAllData(force: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (startupError != null) {
        showGlobalErrorAlert(startupError!, null);
        startupError = null;
      }
      _checkInterruptedTasks();
      _checkMetacognitionProfile();
    });
  }

  Future<void> _checkMetacognitionProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profile = prefs.getString('user_writing_style_profile');
    if (profile == null) {
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const MetacognitionSetupScreen(),
          ),
        );
      }
    }
  }

  void _checkInterruptedTasks() {
    final manager = GenerationManager.instance;
    if (manager.hasInterruptedTasks) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppTheme.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(LucideIcons.alertTriangle, color: Colors.orangeAccent, size: 28),
              SizedBox(width: 10),
              Text("Resume Generation?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          content: const Text(
            "The app was closed or killed while generating lessons. Would you like to resume your pending lesson generation tasks now?",
            style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                manager.clearInterruptedTasksFlag();
                manager.cancelAllTasks();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pending generation tasks cancelled.")),
                );
              },
              child: const Text("Cancel Tasks", style: TextStyle(color: AppTheme.duoRed, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                manager.clearInterruptedTasksFlag();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Tasks kept paused in queue. You can resume them from settings.")),
                );
              },
              child: const Text("Keep Paused", style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(ctx);
                manager.clearInterruptedTasksFlag();
                await manager.setPaused(false);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Resuming lesson generation...")),
                  );
                }
              },
              child: const Text("Resume", style: TextStyle(color: AppTheme.duoGreen, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    }
  }


  @override
  void dispose() {
    _librarySearchController.dispose();
    _publishedSearchController.dispose();
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
    for (var b in globals) {
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
      // Run sync operations in parallel to load faster (especially when offline or on a low network)
      final results = await Future.wait([
        LearningSync.pullAndMerge().catchError((e) {
          print("[HomeScreen] pullAndMerge error: $e");
          return false;
        }),
        _db.fetchBooks(
          forceRefresh: true,
          onConflict: (local, remote) => showSyncConflictDialog(context, local, remote),
        ).catchError((e) {
          print("[HomeScreen] fetchBooks error: $e");
          return <Book>[];
        }),
        _db.fetchGlobalBooks(useCacheOnly: false).catchError((e) {
          print("[HomeScreen] fetchGlobalBooks error: $e");
          return <Book>[];
        }),
      ]);

      final fetched = results[1] as List<Book>;
      final globals = results[2] as List<Book>;

      Map<String, double> prog = {};
      for (var b in fetched) {
        prog[b.id] = await ProgressService.getBookProgress(b);
      }
      for (var b in globals) {
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

  Future<bool> _deleteLocalBook(Book book) async {
    final bool? result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Delete Course?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to delete this course from your local library?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx, true);
              await ProgressService.clearBookProgress(book);
              await _db.deleteBook(book.id);
              _loadAllData(force: true);
            }, 
            child: const Text('Delete', style: TextStyle(color: AppTheme.duoRed, fontWeight: FontWeight.bold))
          ),
        ]
      )
    );
    return result ?? false;
  }

  List<Widget> _buildAppBarActions() {
    return [
      if (kIsWeb && FbAuth.instance.currentUser == null)
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: TextButton.icon(
            icon: const Icon(LucideIcons.logIn, size: 20, color: Colors.white),
            label: const Text(
              'LOG IN',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 13,
                letterSpacing: 1.0,
              ),
            ),
            onPressed: () {
              GlobalState.isGuestNotifier.value = false;
              GlobalState.forceShowAuthScreen.value = true;
            },
          ),
        ),
      IconButton(
        icon: Icon(_isListView ? LucideIcons.layoutGrid : LucideIcons.list, size: 26),
        tooltip: _isListView ? 'Switch to Grid View' : 'Switch to List View',
        onPressed: _toggleListView,
      ),
      IconButton(
        icon: const Icon(LucideIcons.bookmark, size: 26),
        tooltip: 'Bookmarks',
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const BookmarksScreen()));
        },
      ),
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
    ];
  }

  Widget _buildSearchBar({
    required TextEditingController controller,
    required String value,
    required String hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.08), width: 1.2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const Icon(LucideIcons.search, color: Colors.white54, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                textInputAction: TextInputAction.search,
                onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Colors.white30),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            if (value.isNotEmpty)
              GestureDetector(
                onTap: () {
                  controller.clear();
                },
                child: const Icon(LucideIcons.x, color: Colors.white54, size: 18),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLibraryTab(List<GenerationTask> activeTasks, double screenWidth) {
    final query = _librarySearchQuery.toLowerCase().trim();
    final isSearching = query.isNotEmpty;

    final filtered = books.where((b) {
      if (query.isEmpty) return true;
      return b.title.toLowerCase().contains(query);
    }).toList();

    final List<SearchResultItem> searchResults = [];
    if (isSearching) {
      outerLoop:
      for (final book in books) {
        if (book.title.toLowerCase().contains(query) ||
            book.description.toLowerCase().contains(query)) {
          searchResults.add(SearchResultItem(
            book: book,
            type: 'book',
            title: book.title,
            context: 'Course',
          ));
          if (searchResults.length >= 50) break outerLoop;
        }

        for (int modIdx = 0; modIdx < book.modules.length; modIdx++) {
          final module = book.modules[modIdx];
          if (module.title.toLowerCase().contains(query) ||
              module.description.toLowerCase().contains(query)) {
            searchResults.add(SearchResultItem(
              book: book,
              type: 'module',
              title: module.title,
              context: '${book.title} • Module ${modIdx + 1}',
              modIdx: modIdx,
            ));
            if (searchResults.length >= 50) break outerLoop;
          }

          for (int secIdx = 0; secIdx < module.sections.length; secIdx++) {
            final section = module.sections[secIdx];
            if (section.title.toLowerCase().contains(query) ||
                section.description.toLowerCase().contains(query)) {
              searchResults.add(SearchResultItem(
                book: book,
                type: 'section',
                title: section.title,
                context: '${book.title} • ${module.title}',
                modIdx: modIdx,
                secIdx: secIdx,
              ));
              if (searchResults.length >= 50) break outerLoop;
            }

            for (int unitIdx = 0; unitIdx < section.units.length; unitIdx++) {
              final unit = section.units[unitIdx];
              if (unit.title.toLowerCase().contains(query) ||
                  unit.description.toLowerCase().contains(query)) {
                searchResults.add(SearchResultItem(
                  book: book,
                  type: 'unit',
                  title: unit.title,
                  context: '${book.title} • ${section.title}',
                  modIdx: modIdx,
                  secIdx: secIdx,
                  unitIdx: unitIdx,
                ));
                if (searchResults.length >= 50) break outerLoop;
              }

              for (int lessonIdx = 0; lessonIdx < unit.lessons.length; lessonIdx++) {
                final lesson = unit.lessons[lessonIdx];
                if (lesson.title.toLowerCase().contains(query) ||
                    lesson.description.toLowerCase().contains(query)) {
                  searchResults.add(SearchResultItem(
                    book: book,
                    type: 'lesson',
                    title: lesson.title,
                    context: '${book.title} • ${unit.title}',
                    modIdx: modIdx,
                    secIdx: secIdx,
                    unitIdx: unitIdx,
                    lessonIdx: lessonIdx,
                    lesson: lesson,
                  ));
                  if (searchResults.length >= 50) break outerLoop;
                }

                for (int slideIdx = 0; slideIdx < lesson.slides.length; slideIdx++) {
                  final slide = lesson.slides[slideIdx];
                  final inContent = slide.content.toLowerCase().contains(query);
                  final inTitle = slide.title.toLowerCase().contains(query);
                  final inAnswer = slide.blankAnswer?.toLowerCase().contains(query) ?? false;

                  if (inContent || inTitle || inAnswer) {
                    String snippet = '';
                    if (inContent) {
                      snippet = _extractSnippet(slide.content, query);
                    } else if (inAnswer) {
                      snippet = 'Answer: ${slide.blankAnswer}';
                    } else {
                      snippet = slide.content;
                      if (snippet.length > 100) snippet = '${snippet.substring(0, 100)}...';
                    }

                    searchResults.add(SearchResultItem(
                      book: book,
                      type: 'slide',
                      title: slide.title.isNotEmpty ? slide.title : 'Theory Slide',
                      context: '${book.title} • ${lesson.title}',
                      snippet: snippet,
                      modIdx: modIdx,
                      secIdx: secIdx,
                      unitIdx: unitIdx,
                      lessonIdx: lessonIdx,
                      lesson: lesson,
                      slideId: slide.id,
                    ));
                    if (searchResults.length >= 50) break outerLoop;
                  }
                }
              }
            }
          }
        }
      }
    }

    return ResponsiveCenter(
      child: RefreshIndicator(
        color: AppTheme.duoBlue,
        onRefresh: () async {
          await _loadAllData(force: false);
          await _syncRemoteData();
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              backgroundColor: AppTheme.background,
              elevation: 0,
              centerTitle: false,
              titleSpacing: 24,
              title: const Text(
                'Your Library',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
              ),
              actions: _buildAppBarActions(),
            ),
            SliverToBoxAdapter(
              child: _buildSearchBar(
                controller: _librarySearchController,
                value: _librarySearchQuery,
                hintText: 'Search your courses...',
              ),
            ),
            if (!isSearching && activeTasks.isNotEmpty && !kIsWeb)
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
            if (!isSearching)
              SliverToBoxAdapter(
                child: books.isEmpty && activeTasks.isEmpty
                    ? Container(
                        height: 180,
                        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(24)),
                        alignment: Alignment.center,
                        child: const Text('No courses found.\nTap + to create one!', textAlign: TextAlign.center, style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold)),
                      )
                    : const SizedBox.shrink(),
              ),
            if (isSearching)
              SliverToBoxAdapter(
                child: searchResults.isEmpty
                    ? Container(
                        height: 200,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(LucideIcons.search, color: Colors.white24, size: 40),
                            const SizedBox(height: 16),
                            const Text(
                              'No matching courses or content found.',
                              style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            if (isSearching && searchResults.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final result = searchResults[index];
                      return _buildSearchResultCard(context, result, query);
                    },
                    childCount: searchResults.length,
                  ),
                ),
              ),
            if (!isSearching && books.isNotEmpty)
              _isListView
                  ? SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final book = books[index];
                            return Dismissible(
                              key: Key(book.id),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade900.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(LucideIcons.trash2, color: Colors.white, size: 20),
                              ),
                              confirmDismiss: (direction) async {
                                return await _deleteLocalBook(book);
                              },
                              child: CompactBookListItem(
                                book: book,
                                progress: progressMap[book.id] ?? 0.0,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => MainLayoutScreen(book: book)))
                                    .then((_) => _loadAllData(force: false));
                                },
                                onLongPress: () => _showBookLongPressMenu(book),
                              ),
                            );
                          },
                          childCount: books.length,
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      sliver: SliverGrid(
                        gridDelegate: screenWidth < 600
                            ? const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.78,
                              )
                            : const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 120,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 0.78,
                              ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final book = books[index];
                            return Dismissible(
                              key: Key(book.id),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.red.shade900.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(LucideIcons.trash2, color: Colors.white, size: 20),
                              ),
                              confirmDismiss: (direction) async {
                                return await _deleteLocalBook(book);
                              },
                              child: CompactBookCard(
                                book: book,
                                progress: progressMap[book.id] ?? 0.0,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => MainLayoutScreen(book: book)))
                                    .then((_) => _loadAllData(force: false));
                                },
                                onLongPress: () => _showBookLongPressMenu(book),
                              ),
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
    );
  }

  Widget _buildAnalyticsTab(double screenWidth) {
    return ResponsiveCenter(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppTheme.background,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 24,
          title: const Text(
            'Analytics',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          actions: _buildAppBarActions(),
        ),
        body: const AnalyticsView(),
      ),
    );
  }

  Widget _buildPublishedTab(double screenWidth) {
    final filteredGlobals = globalBooks.where((b) {
      final query = _publishedSearchQuery.toLowerCase().trim();
      if (query.isEmpty) return true;
      return b.title.toLowerCase().contains(query);
    }).toList();

    return ResponsiveCenter(
      child: RefreshIndicator(
        color: AppTheme.duoBlue,
        onRefresh: () async {
          await _loadAllData(force: false);
          await _syncRemoteData();
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              backgroundColor: AppTheme.background,
              elevation: 0,
              centerTitle: false,
              titleSpacing: 24,
              title: const Text(
                'Published',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
              ),
              actions: _buildAppBarActions(),
            ),
            SliverToBoxAdapter(
              child: _buildSearchBar(
                controller: _publishedSearchController,
                value: _publishedSearchQuery,
                hintText: 'Search published courses...',
              ),
            ),
            SliverToBoxAdapter(
              child: globalBooks.isEmpty
                  ? Container(
                      height: 180,
                      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(24)),
                      alignment: Alignment.center,
                      child: const Text('No published courses yet.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold)),
                    )
                  : const SizedBox.shrink(),
            ),
            SliverToBoxAdapter(
              child: globalBooks.isNotEmpty && filteredGlobals.isEmpty
                  ? Container(
                      height: 120,
                      alignment: Alignment.center,
                      child: const Text(
                        'No matching published courses.',
                        style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            if (filteredGlobals.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverGrid(
                  gridDelegate: screenWidth < 600
                      ? const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.78,
                        )
                      : const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 120,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.78,
                        ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final book = filteredGlobals[index];
                      final user = FbAuth.instance.currentUser;
                      final bool isOwner = user != null && book.authorId == user.uid;
                      final bool isSuperAdmin = user?.email == 'ihjas.one@gmail.com';
                      final bool canDelete = isOwner || isSuperAdmin;

                      return Dismissible(
                        key: Key(book.id),
                        direction: canDelete ? DismissDirection.endToStart : DismissDirection.none,
                        background: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.red.shade900.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(LucideIcons.trash2, color: Colors.white, size: 20),
                        ),
                        confirmDismiss: (direction) async {
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
                            await _db.deleteGlobalBook(book.id);
                            _loadAllData(force: true);
                            return true;
                          }
                          return false;
                        },
                        child: CompactBookCard(
                          book: book,
                          progress: progressMap[book.id] ?? 0.0,
                          onTap: () {
                            if (kIsWeb) {
                              Navigator.pushNamed(context, '/${book.id}').then((_) => _loadAllData(force: false));
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => MainLayoutScreen(book: book)))
                                .then((_) => _loadAllData(force: false));
                            }
                          },
                          onLongPress: () => _showPublishedBookLongPressMenu(book),
                        ),
                      );
                    },
                    childCount: filteredGlobals.length,
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  void _showPublishedBookLongPressMenu(Book book) {
    final user = FbAuth.instance.currentUser;
    final bool isOwner = user != null && book.authorId == user.uid;
    final bool isSuperAdmin = user?.email == 'ihjas.one@gmail.com';
    final bool canDelete = isOwner || isSuperAdmin;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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
                            child: const Icon(LucideIcons.globe, color: AppTheme.duoBlue, size: 24),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'PUBLISHED COURSE MENU',
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
                      const SizedBox(height: 16),
                      _buildMenuItem(
                        icon: LucideIcons.refreshCcw,
                        title: 'Reset Progress',
                        subtitle: 'Clear all lesson completion data',
                        iconColor: AppTheme.duoOrange,
                        onTap: () {
                          Navigator.pop(ctx);
                          _resetBookProgress(book);
                        },
                      ),
                      if (canDelete)
                        _buildMenuItem(
                          icon: LucideIcons.trash2,
                          title: 'Unpublish Course',
                          subtitle: 'Remove from published courses',
                          iconColor: AppTheme.duoRed,
                          onTap: () async {
                            Navigator.pop(ctx);
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
                              await _db.deleteGlobalBook(book.id);
                              _loadAllData(force: true);
                            }
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
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: GenerationManager.instance,
      builder: (context, child) {
        final activeTasks = GenerationManager.instance.activeTasks;

        return Scaffold(
          backgroundColor: AppTheme.background,
          body: isLoading
              ? const Center(child: CircularProgressIndicator(color: AppTheme.duoBlue))
              : IndexedStack(
                  index: _selectedTabIndex,
                  children: [
                    _buildLibraryTab(activeTasks, screenWidth),
                    _buildAnalyticsTab(screenWidth),
                    _buildPublishedTab(screenWidth),
                    const DocumentStoreScreen(),
                  ],
                ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedTabIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
            backgroundColor: AppTheme.surface,
            selectedItemColor: AppTheme.duoBlue,
            unselectedItemColor: Colors.white54,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.bookOpen),
                label: 'Your Library',
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.barChart2),
                label: 'Analytics',
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.globe),
                label: 'Published',
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.hardDrive),
                label: 'Doc Store',
              ),
            ],
          ),
          floatingActionButton: _selectedTabIndex == 0 && !kIsWeb
              ? FloatingActionButton(
                  backgroundColor: AppTheme.duoGreen,
                  child: const Icon(LucideIcons.plus, color: Colors.white, size: 32),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GenerateBookScreen())
                  ).then((_) => _loadAllData(force: false)),
                )
              : null,
        );
      },
    );
  }

  void _showBookLongPressMenu(Book book) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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
                      const SizedBox(height: 16),
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
                        icon: LucideIcons.edit3,
                        title: 'Edit Course Structure',
                        subtitle: 'Rename modules/sections or re-map pages',
                        iconColor: AppTheme.duoBlue,
                        onTap: () {
                          Navigator.pop(ctx);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CourseEditStructureScreen(
                                book: book,
                                onBookUpdated: (updatedBook) {
                                  _loadAllData(force: false);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      _buildMenuItem(
                        icon: LucideIcons.refreshCcw,
                        title: 'Reset Progress',
                        subtitle: 'Clear all lesson completion data',
                        iconColor: AppTheme.duoOrange,
                        onTap: () {
                          Navigator.pop(ctx);
                          _resetBookProgress(book);
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
            ),
          ),
        );
      },
    );
  }

  void _resetBookProgress(Book book) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Reset Progress?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Text('Are you sure you want to clear all completion progress for "${book.title}"?', style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await ProgressService.clearBookProgress(book);
              _loadAllData(force: false);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Course progress reset.')),
                );
              }
            }, 
            child: const Text('Reset', style: TextStyle(color: AppTheme.duoOrange, fontWeight: FontWeight.bold))
          ),
        ]
      )
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
    
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.surface,
        content: Text(
          isScheduled ? 'Course generation scheduled!' : 'Course generation queued!',
          style: const TextStyle(color: Colors.white),
        ),
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

  String _extractSnippet(String text, String query) {
    final idx = text.toLowerCase().indexOf(query.toLowerCase());
    if (idx == -1) {
      return text.length > 100 ? '${text.substring(0, 100)}...' : text;
    }
    
    int start = idx - 40;
    if (start < 0) start = 0;
    
    int end = idx + query.length + 60;
    if (end > text.length) end = text.length;
    
    String prefix = start > 0 ? '...' : '';
    String suffix = end < text.length ? '...' : '';
    
    return prefix + text.substring(start, end).replaceAll('\n', ' ') + suffix;
  }

  Widget _highlightedText(String text, String query, TextStyle baseStyle, TextStyle highlightStyle) {
    if (query.isEmpty) return Text(text, style: baseStyle);
    final textLower = text.toLowerCase();
    final queryLower = query.toLowerCase();
    
    final List<TextSpan> spans = [];
    int start = 0;
    int index = textLower.indexOf(queryLower, start);
    
    while (index != -1) {
      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index)));
      }
      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: highlightStyle,
      ));
      start = index + query.length;
      index = textLower.indexOf(queryLower, start);
    }
    
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }
    
    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: spans,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSearchResultCard(BuildContext context, SearchResultItem result, String query) {
    IconData icon;
    Color color;
    String typeLabel;

    switch (result.type) {
      case 'book':
        icon = LucideIcons.book;
        color = AppTheme.duoBlue;
        typeLabel = 'Course';
        break;
      case 'module':
        icon = LucideIcons.folder;
        color = AppTheme.duoViolet;
        typeLabel = 'Module';
        break;
      case 'section':
        icon = LucideIcons.layout;
        color = AppTheme.duoOrange;
        typeLabel = 'Section';
        break;
      case 'unit':
        icon = LucideIcons.bookmark;
        color = Colors.tealAccent;
        typeLabel = 'Unit';
        break;
      case 'lesson':
        icon = LucideIcons.bookOpen;
        color = AppTheme.duoGreen;
        typeLabel = 'Lesson';
        break;
      case 'slide':
      default:
        icon = LucideIcons.fileText;
        color = Colors.white70;
        typeLabel = 'Lesson Text';
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            if (result.type == 'lesson' || result.type == 'slide') {
              if (result.lesson != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LessonScreen(
                      lesson: result.lesson!,
                      book: result.book,
                      modIdx: result.modIdx,
                      secIdx: result.secIdx,
                      unitIdx: result.unitIdx,
                      lessonIdx: result.lessonIdx,
                      initialSlideId: result.type == 'slide' ? result.slideId : null,
                    ),
                  ),
                ).then((_) => _loadAllData(force: false));
              }
            } else {
              if (result.modIdx != null) {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setInt('last_mod_idx_${result.book.id}', result.modIdx!);
                if (result.secIdx != null) {
                  await prefs.setInt('last_sec_idx_${result.book.id}', result.secIdx!);
                }
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MainLayoutScreen(
                    book: result.book,
                    initialModuleIdx: result.modIdx,
                  ),
                ),
              ).then((_) => _loadAllData(force: false));
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.02),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.15), width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: color.withOpacity(0.2), width: 1),
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, color: color, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              typeLabel,
                              style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              result.context,
                              style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      _highlightedText(
                        result.title,
                        query,
                        const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                        TextStyle(color: color, fontWeight: FontWeight.bold, backgroundColor: color.withOpacity(0.1)),
                      ),
                      if (result.snippet != null && result.snippet!.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        _highlightedText(
                          result.snippet!,
                          query,
                          TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12, height: 1.3),
                          TextStyle(color: color, fontWeight: FontWeight.bold, backgroundColor: color.withOpacity(0.1)),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  LucideIcons.chevronRight,
                  color: Colors.white.withOpacity(0.15),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchResultItem {
  final Book book;
  final String type; // 'book' | 'module' | 'section' | 'unit' | 'lesson' | 'slide'
  final String title;
  final String context;
  final String? snippet;
  final int? modIdx;
  final int? secIdx;
  final int? unitIdx;
  final int? lessonIdx;
  final Lesson? lesson;
  final String? slideId;

  SearchResultItem({
    required this.book,
    required this.type,
    required this.title,
    required this.context,
    this.snippet,
    this.modIdx,
    this.secIdx,
    this.unitIdx,
    this.lessonIdx,
    this.lesson,
    this.slideId,
  });
}