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
import '../widgets/compact_book_list_item.dart';
import '../widgets/duo_button.dart';
import '../widgets/generating_book_card.dart';
import '../widgets/next_up_card.dart';
import '../widgets/smart_review_card.dart';
import '../widgets/responsive_center.dart';

import 'package:flutter/foundation.dart';
import 'main_layout_screen.dart';
import 'module_selection_screen.dart';
import 'settings_screen.dart';
import 'generate_book_screen.dart';
import 'pdf_split_preview_screen.dart';
import 'course_edit_structure_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/global_state.dart';
import '../main.dart';
import '../widgets/analytics_view.dart';
import 'document_store_screen.dart';
import '../widgets/glassy_nav_bar.dart';
import '../utils/toast_utils.dart';

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
  List<String> _completedLessons = [];
  bool isLoading = true;
  int _selectedTabIndex = 0;

  bool _isListView = true;

  List<CourseFolder> folders = [];
  String? _selectedFolderId;

  final TextEditingController _librarySearchController =
      TextEditingController();
  final TextEditingController _publishedSearchController =
      TextEditingController();
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
    _bookUpdateSubscription = GenerationManager.instance.bookUpdates.listen((
      _,
    ) {
      _loadAllData(force: false);
    });
    GenerationManager.instance.onBookGenerated = () =>
        _loadAllData(force: false);

    GlobalState.progressNotifier.addListener(_handleProgressChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (startupError != null) {
        showGlobalErrorAlert(startupError!, null);
        startupError = null;
      }
      // The writing-style survey is no longer forced on first launch — the
      // onboarding walkthrough handles first-run, and the survey lives on as
      // an optional Settings → Personalization card.
    });
  }

  @override
  void dispose() {
    _librarySearchController.dispose();
    _publishedSearchController.dispose();
    GenerationManager.instance.removeListener(_handleGenerationTasksChange);
    _bookUpdateSubscription?.cancel();
    GlobalState.progressNotifier.removeListener(_handleProgressChange);
    super.dispose();
  }

  void _handleProgressChange() {
    if (mounted) {
      _loadAllData(force: false);
    }
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
    final fetchedFolders = await _db.fetchFolders();
    final completed = await ProgressService.getCompletedLessons();

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
        _completedLessons = completed;
        folders = fetchedFolders;
        isLoading = false;
      });
    }

    // 2. Perform background sync if force is true
    if (force) {
      _syncRemoteData();
    }
  }

  Future<void> _syncRemoteData() async {
    bool anyFailed = false;
    try {
      // Run sync operations in parallel to load faster (especially when offline or on a low network)
      final results = await Future.wait([
        LearningSync.pullAndMerge().catchError((e) {
          print("[HomeScreen] pullAndMerge error: $e");
          anyFailed = true;
          return false;
        }),
        _db.fetchBooks(forceRefresh: true)
            .catchError((e) {
              print("[HomeScreen] fetchBooks error: $e");
              anyFailed = true;
              return <Book>[];
            }),
        _db.fetchGlobalBooks(useCacheOnly: false).catchError((e) {
          print("[HomeScreen] fetchGlobalBooks error: $e");
          anyFailed = true;
          return <Book>[];
        }),
        _db.fetchFolders().catchError((e) {
          print("[HomeScreen] fetchFolders error: $e");
          anyFailed = true;
          return <CourseFolder>[];
        }),
        ProgressService.getCompletedLessons().catchError((e) {
          print("[HomeScreen] getCompletedLessons error: $e");
          anyFailed = true;
          return <String>[];
        }),
      ]);

      final fetched = results[1] as List<Book>;
      final globals = results[2] as List<Book>;
      final fetchedFolders = results[3] as List<CourseFolder>;
      final completed = results[4] as List<String>;

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
          _completedLessons = completed;
          folders = fetchedFolders;
        });
        if (anyFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Some data couldn't sync — showing cached content"),
            ),
          );
        }
      }
    } catch (e) {
      print("[HomeScreen] Background sync error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sync failed — showing cached content")),
        );
      }
    }
  }

  Future<void> _handleGeneratingCardTap(GenerationTask task) async {
    final choice = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        title: Text(
          'Course generation failed',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          task.errorMessage?.isNotEmpty == true
              ? task.errorMessage!
              : 'Something went wrong generating "${task.title}".',
          style: TextStyle(color: context.colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, 'keep'),
            child: Text(
              'Keep',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, 'dismiss'),
            child: const Text(
              'Dismiss',
              style: TextStyle(color: AppTheme.duoRed),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, 'retry'),
            child: const Text(
              'Retry',
              style: TextStyle(
                color: AppTheme.duoBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    if (choice == 'dismiss') {
      GenerationManager.instance.dismissTask(task.id);
    } else if (choice == 'retry') {
      try {
        GenerationManager.instance.dismissTask(task.id);
        await GenerationManager.instance.startBookGeneration(
          task.sourceFiles,
          task.title,
          syllabusFiles: task.syllabusFiles,
          plannerQuestions: task.plannerQuestions,
          selectedQuestions: task.selectedQuestions,
          bloomLevel: task.bloomLevel,
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Couldn't retry — please re-upload")),
          );
        }
      }
    }
  }

  Future<bool> _deleteLocalBook(Book book) async {
    final bool? result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        title: Text(
          'Delete Course?',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this course from your local library?',
          style: TextStyle(color: context.colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx, true);
              setState(() {
                books.removeWhere((b) => b.id == book.id);
              });
              await ProgressService.clearBookProgress(book);
              await _db.deleteBook(book.id);
              _loadAllData(force: true);
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                color: AppTheme.duoRed,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  List<Widget> _buildAppBarActions() {
    return [
      if (kIsWeb && FbAuth.instance.currentUser == null)
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: TextButton.icon(
            icon: Icon(
              LucideIcons.logIn,
              size: 20,
              color: context.colors.textPrimary,
            ),
            label: Text(
              'LOG IN',
              style: TextStyle(
                color: context.colors.textPrimary,
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
        icon: const Icon(LucideIcons.bookmark, size: 26),
        tooltip: 'Bookmarks',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const BookmarksScreen()),
          );
        },
      ),
      IconButton(
        padding: const EdgeInsets.only(right: 16),
        icon: const Icon(LucideIcons.userCircle, size: 28),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          ).then((_) => _loadAllData(force: false));
        },
      ),
    ];
  }

  Widget _buildSearchBar({
    required TextEditingController controller,
    required String value,
    required String hintText,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: context.colors.surfaceAlt,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.colors.outline, width: 1.2),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(
                    LucideIcons.search,
                    color: context.colors.textFaint,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      style: TextStyle(
                        color: context.colors.textPrimary,
                        fontSize: 14,
                      ),
                      textInputAction: TextInputAction.search,
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: TextStyle(color: context.colors.textFaint),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  if (value.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        controller.clear();
                      },
                      child: Icon(
                        LucideIcons.x,
                        color: context.colors.textFaint,
                        size: 18,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (trailing != null) ...[const SizedBox(width: 12), trailing],
        ],
      ),
    );
  }

  Widget _buildLibraryTab(
    List<GenerationTask> activeTasks,
    double screenWidth,
  ) {
    final query = _librarySearchQuery.toLowerCase().trim();
    final isSearching = query.isNotEmpty;

    final List<SearchResultItem> searchResults = [];
    if (isSearching) {
      outerLoop:
      for (final book in books) {
        if (book.title.toLowerCase().contains(query) ||
            book.description.toLowerCase().contains(query)) {
          searchResults.add(
            SearchResultItem(
              book: book,
              type: 'book',
              title: book.title,
              context: 'Course',
            ),
          );
          if (searchResults.length >= 50) break outerLoop;
        }

        for (int modIdx = 0; modIdx < book.modules.length; modIdx++) {
          final module = book.modules[modIdx];
          if (module.title.toLowerCase().contains(query) ||
              module.description.toLowerCase().contains(query)) {
            searchResults.add(
              SearchResultItem(
                book: book,
                type: 'module',
                title: module.title,
                context: '${book.title} • Module ${modIdx + 1}',
                modIdx: modIdx,
              ),
            );
            if (searchResults.length >= 50) break outerLoop;
          }

          for (int secIdx = 0; secIdx < module.sections.length; secIdx++) {
            final section = module.sections[secIdx];
            if (section.title.toLowerCase().contains(query) ||
                section.description.toLowerCase().contains(query)) {
              searchResults.add(
                SearchResultItem(
                  book: book,
                  type: 'section',
                  title: section.title,
                  context: '${book.title} • ${module.title}',
                  modIdx: modIdx,
                  secIdx: secIdx,
                ),
              );
              if (searchResults.length >= 50) break outerLoop;
            }

            for (int unitIdx = 0; unitIdx < section.units.length; unitIdx++) {
              final unit = section.units[unitIdx];
              if (unit.title.toLowerCase().contains(query) ||
                  unit.description.toLowerCase().contains(query)) {
                searchResults.add(
                  SearchResultItem(
                    book: book,
                    type: 'unit',
                    title: unit.title,
                    context: '${book.title} • ${section.title}',
                    modIdx: modIdx,
                    secIdx: secIdx,
                    unitIdx: unitIdx,
                  ),
                );
                if (searchResults.length >= 50) break outerLoop;
              }

              for (
                int lessonIdx = 0;
                lessonIdx < unit.lessons.length;
                lessonIdx++
              ) {
                final lesson = unit.lessons[lessonIdx];
                if (lesson.title.toLowerCase().contains(query) ||
                    lesson.description.toLowerCase().contains(query)) {
                  searchResults.add(
                    SearchResultItem(
                      book: book,
                      type: 'lesson',
                      title: lesson.title,
                      context: '${book.title} • ${unit.title}',
                      modIdx: modIdx,
                      secIdx: secIdx,
                      unitIdx: unitIdx,
                      lessonIdx: lessonIdx,
                      lesson: lesson,
                    ),
                  );
                  if (searchResults.length >= 50) break outerLoop;
                }

                for (
                  int slideIdx = 0;
                  slideIdx < lesson.slides.length;
                  slideIdx++
                ) {
                  final slide = lesson.slides[slideIdx];
                  final inContent = slide.content.toLowerCase().contains(query);
                  final inTitle = slide.title.toLowerCase().contains(query);
                  final inAnswer =
                      slide.blankAnswer?.toLowerCase().contains(query) ?? false;

                  if (inContent || inTitle || inAnswer) {
                    String snippet = '';
                    if (inContent) {
                      snippet = _extractSnippet(slide.content, query);
                    } else if (inAnswer) {
                      snippet = 'Answer: ${slide.blankAnswer}';
                    } else {
                      snippet = slide.content;
                      if (snippet.length > 100)
                        snippet = '${snippet.substring(0, 100)}...';
                    }

                    searchResults.add(
                      SearchResultItem(
                        book: book,
                        type: 'slide',
                        title: slide.title.isNotEmpty
                            ? slide.title
                            : 'Theory Slide',
                        context: '${book.title} • ${lesson.title}',
                        snippet: snippet,
                        modIdx: modIdx,
                        secIdx: secIdx,
                        unitIdx: unitIdx,
                        lessonIdx: lessonIdx,
                        lesson: lesson,
                        slideId: slide.id,
                      ),
                    );
                    if (searchResults.length >= 50) break outerLoop;
                  }
                }
              }
            }
          }
        }
      }
    }

    final List<Book> displayedBooks;
    if (_selectedFolderId != null) {
      final currentFolder = folders.firstWhere(
        (f) => f.id == _selectedFolderId,
        orElse: () => CourseFolder(id: '', name: '', bookIds: []),
      );
      displayedBooks = books
          .where((b) => currentFolder.bookIds.contains(b.id))
          .toList();
    } else {
      displayedBooks = books
          .where((b) => !folders.any((f) => f.bookIds.contains(b.id)))
          .toList();
    }

    return ResponsiveCenter(
      child: RefreshIndicator(
        color: AppTheme.duoBlue,
        onRefresh: () async {
          await _loadAllData(force: false);
          await _syncRemoteData();
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              backgroundColor: context.colors.background,
              elevation: 0,
              centerTitle: false,
              titleSpacing: 24,
              title: DragTarget<Book>(
                onWillAcceptWithDetails: (details) {
                  final book = details.data;
                  return folders.any((f) => f.bookIds.contains(book.id));
                },
                onAcceptWithDetails: (details) async {
                  final book = details.data;
                  for (var i = 0; i < folders.length; i++) {
                    folders[i].bookIds.remove(book.id);
                  }
                  await _db.saveFolders(folders);
                  setState(() {});
                  showToast(context, 'Removed "${book.title}" from folder');
                },
                builder: (context, candidateData, rejectedData) {
                  final isHovered = candidateData.isNotEmpty;
                  final folderName = _selectedFolderId != null
                      ? folders
                            .firstWhere(
                              (f) => f.id == _selectedFolderId,
                              orElse: () => folders.first,
                            )
                            .name
                      : null;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isHovered
                          ? AppTheme.duoRed.withOpacity(0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isHovered ? AppTheme.duoRed : Colors.transparent,
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_selectedFolderId != null) ...[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedFolderId = null;
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  LucideIcons.chevronLeft,
                                  size: 18,
                                  color: AppTheme.duoBlue,
                                ),
                                Text(
                                  'Library',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: AppTheme.duoBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              '/',
                              style: TextStyle(
                                fontSize: 14,
                                color: context.colors.textFaint,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              folderName ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: context.colors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ] else ...[
                          Text(
                            'Your Library',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: context.colors.textPrimary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
              actions: _buildAppBarActions(),
            ),
            SliverToBoxAdapter(
              child: _buildSearchBar(
                controller: _librarySearchController,
                value: _librarySearchQuery,
                hintText: 'Search your courses...',
                trailing: _selectedFolderId == null
                    ? IconButton(
                        icon: Icon(
                          LucideIcons.folderPlus,
                          color: context.colors.textPrimary,
                          size: 24,
                        ),
                        onPressed: _showCreateFolderDialog,
                        style: IconButton.styleFrom(
                          backgroundColor: context.colors.surfaceAlt,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: context.colors.outline,
                              width: 1.2,
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                        ),
                      )
                    : null,
              ),
            ),
            if (!isSearching && _selectedFolderId == null && books.isNotEmpty)
              SliverToBoxAdapter(
                child: NextUpCard(
                  books: books,
                  onReturn: () => _loadAllData(force: false),
                ),
              ),
            if (!isSearching && _selectedFolderId == null)
              const SliverToBoxAdapter(child: SmartReviewCard()),
            if (!isSearching && _selectedFolderId == null && folders.isNotEmpty)
              SliverToBoxAdapter(child: _buildFoldersList()),
            if (!isSearching && activeTasks.isNotEmpty && !kIsWeb)
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final task = activeTasks[index];
                    return GeneratingBookCard(
                      task: task,
                      onTap: () {
                        if (task.state == BookGenState.review &&
                            task.skeletonBook != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PdfSplitPreviewScreen(
                                taskId: task.id,
                                originalPdf: task.sourceFiles,
                                skeletonBook: task.skeletonBook!,
                              ),
                            ),
                          ).then((_) => _loadAllData(force: false));
                        } else if (task.state == BookGenState.error) {
                          _handleGeneratingCardTap(task);
                        }
                      },
                    );
                  }, childCount: activeTasks.length),
                ),
              ),
            if (!isSearching)
              SliverToBoxAdapter(
                child:
                    (displayedBooks.isEmpty &&
                        activeTasks.isEmpty &&
                        (_selectedFolderId != null || folders.isEmpty))
                    ? (_selectedFolderId != null
                          ? Container(
                              height: 180,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: context.colors.surfaceAlt,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'This folder is empty.\nGo back and drag courses here!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: context.colors.textFaint,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : _buildFirstCourseCta())
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
                            Icon(
                              LucideIcons.search,
                              color: context.colors.outline,
                              size: 40,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No matching courses or content found.',
                              style: TextStyle(
                                color: context.colors.textFaint,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            if (isSearching && searchResults.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final result = searchResults[index];
                    return _buildSearchResultCard(context, result, query);
                  }, childCount: searchResults.length),
                ),
              ),
            if (!isSearching && displayedBooks.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final book = displayedBooks[index];
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
                        child: Icon(
                          LucideIcons.trash2,
                          color: context.colors.textPrimary,
                          size: 20,
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        return await _deleteLocalBook(book);
                      },
                      child: CompactBookListItem(
                        book: book,
                        progress: progressMap[book.id] ?? 0.0,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ModuleSelectionScreen(book: book),
                            ),
                          ).then((_) => _loadAllData(force: false));
                        },
                        onLongPress: () => _showBookLongPressMenu(book),
                        dragHandle: _buildDragHandle(book),
                      ),
                    );
                  }, childCount: displayedBooks.length),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  /// Guided empty state for a brand-new library: one obvious action instead
  /// of a bare "tap +" hint.
  Widget _buildFirstCourseCta() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.glassOf(context),
      child: Column(
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.duoGreen.withOpacity(0.12),
              border: Border.all(
                color: AppTheme.duoGreen.withOpacity(0.4),
                width: 2,
              ),
            ),
            child: const Icon(
              LucideIcons.sparkles,
              color: AppTheme.duoGreen,
              size: 40,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Create your first course',
            style: TextStyle(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pick any PDF — a textbook, notes, or a handout — and the AI turns it into an interactive lesson path.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.colors.textFaint,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          if (!kIsWeb)
            SizedBox(
              width: double.infinity,
              child: DuoButton(
                text: 'Upload a PDF',
                color: AppTheme.duoGreen,
                shadowColor: AppTheme.duoGreenDark,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GenerateBookScreen(),
                    ),
                  ).then((_) => _loadAllData(force: false));
                },
              ),
            ),
          TextButton.icon(
            onPressed: () => setState(() => _selectedTabIndex = 2),
            icon: const Icon(
              LucideIcons.globe,
              size: 16,
              color: AppTheme.duoBlue,
            ),
            label: const Text(
              'Or browse community courses',
              style: TextStyle(
                color: AppTheme.duoBlue,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab(double screenWidth) {
    return ResponsiveCenter(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: context.colors.background,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 24,
          title: Text(
            'Analytics',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: context.colors.textPrimary,
            ),
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
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              backgroundColor: context.colors.background,
              elevation: 0,
              centerTitle: false,
              titleSpacing: 24,
              title: Text(
                'Published',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: context.colors.textPrimary,
                ),
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
                      margin: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.surfaceAlt,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'No published courses yet.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.colors.textFaint,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            SliverToBoxAdapter(
              child: globalBooks.isNotEmpty && filteredGlobals.isEmpty
                  ? Container(
                      height: 120,
                      alignment: Alignment.center,
                      child: Text(
                        'No matching published courses.',
                        style: TextStyle(
                          color: context.colors.textFaint,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            if (filteredGlobals.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final book = filteredGlobals[index];
                    final user = FbAuth.instance.currentUser;
                    final bool isOwner =
                        user != null && book.authorId == user.uid;
                    final bool isSuperAdmin =
                        user?.email == 'ihjas.one@gmail.com';
                    final bool canDelete = isOwner || isSuperAdmin;

                    return Dismissible(
                      key: Key(book.id),
                      direction: canDelete
                          ? DismissDirection.endToStart
                          : DismissDirection.none,
                      background: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.red.shade900.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          LucideIcons.trash2,
                          color: context.colors.textPrimary,
                          size: 20,
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            backgroundColor: context.colors.surface,
                            title: Text(
                              'Unpublish Course?',
                              style: TextStyle(
                                color: context.colors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Text(
                              'Are you sure you want to unpublish this course from Published Courses? This won\'t delete your local copy if you have one.',
                              style: TextStyle(
                                color: context.colors.textSecondary,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, false),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: context.colors.textFaint,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, true),
                                child: const Text(
                                  'Unpublish',
                                  style: TextStyle(
                                    color: AppTheme.duoRed,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          setState(() {
                            globalBooks.removeWhere((b) => b.id == book.id);
                          });
                          await _db.deleteGlobalBook(book.id);
                          _loadAllData(force: true);
                          return true;
                        }
                        return false;
                      },
                      child: CompactBookListItem(
                        book: book,
                        progress: progressMap[book.id] ?? 0.0,
                        onTap: () {
                          if (kIsWeb) {
                            Navigator.pushNamed(
                              context,
                              '/${book.id}',
                            ).then((_) => _loadAllData(force: false));
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ModuleSelectionScreen(book: book),
                              ),
                            ).then((_) => _loadAllData(force: false));
                          }
                        },
                        onLongPress: () =>
                            _showPublishedBookLongPressMenu(book),
                      ),
                    );
                  }, childCount: filteredGlobals.length),
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
                color: context.colors.glassStrong,
                border: Border.all(color: context.colors.outline),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
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
                              border: Border.all(
                                color: AppTheme.duoBlue.withOpacity(0.4),
                              ),
                            ),
                            child: const Icon(
                              LucideIcons.globe,
                              color: AppTheme.duoBlue,
                              size: 24,
                            ),
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
                                  style: TextStyle(
                                    color: context.colors.textPrimary,
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
                                backgroundColor: context.colors.surface,
                                title: Text(
                                  'Unpublish Course?',
                                  style: TextStyle(
                                    color: context.colors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Text(
                                  'Are you sure you want to unpublish this course from Published Courses? This won\'t delete your local copy if you have one.',
                                  style: TextStyle(
                                    color: context.colors.textSecondary,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, false),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: context.colors.textFaint,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, true),
                                    child: const Text(
                                      'Unpublish',
                                      style: TextStyle(
                                        color: AppTheme.duoRed,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              setState(() {
                                globalBooks.removeWhere((b) => b.id == book.id);
                              });
                              await _db.deleteGlobalBook(book.id);
                              _loadAllData(force: true);
                            }
                          },
                        ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text(
                          'CANCEL',
                          style: TextStyle(
                            color: context.colors.textSecondary,
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
    final bool isDesktop = screenWidth >= 900;

    return PopScope<Object?>(
      canPop: _selectedFolderId == null,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_selectedFolderId != null) {
          setState(() {
            _selectedFolderId = null;
          });
        }
      },
      child: AnimatedBuilder(
        animation: GenerationManager.instance,
        builder: (context, child) {
          final activeTasks = GenerationManager.instance.activeTasks;

          if (isLoading) {
            return Scaffold(
              backgroundColor: context.colors.background,
              body: const Center(
                child: CircularProgressIndicator(color: AppTheme.duoBlue),
              ),
            );
          }

          if (isDesktop) {
            return Scaffold(
              backgroundColor: context.colors.background,
              body: Row(
                children: [
                  // Desktop Left Sidebar (Navigation)
                  _buildDesktopSidebar(),
                  Container(width: 1, color: context.colors.outline),
                  // Desktop Main Content
                  Expanded(
                    child: IndexedStack(
                      index: _selectedTabIndex,
                      children: [
                        _buildDesktopLibraryTab(activeTasks, screenWidth),
                        _buildAnalyticsTab(screenWidth),
                        _buildPublishedTab(screenWidth),
                        const DocumentStoreScreen(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return Scaffold(
            extendBody: true,
            backgroundColor: context.colors.background,
            body: IndexedStack(
              index: _selectedTabIndex,
              children: [
                _buildLibraryTab(activeTasks, screenWidth),
                _buildAnalyticsTab(screenWidth),
                _buildPublishedTab(screenWidth),
                const DocumentStoreScreen(),
              ],
            ),
            bottomNavigationBar: GlassyNavBar(
              currentIndex: _selectedTabIndex,
              blur: 6.0,
              icons: const [
                LucideIcons.bookOpen,
                LucideIcons.barChart2,
                LucideIcons.globe,
                LucideIcons.hardDrive,
              ],
              tooltips: const ['Library', 'Analytics', 'Published', 'Doc Store'],
              onTap: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              activeColor: AppTheme.duoGreen,
            ),
            floatingActionButton: _selectedTabIndex == 0 && !kIsWeb
                ? FloatingActionButton(
                    heroTag: 'home_fab',
                    backgroundColor: AppTheme.duoGreen,
                    child: Icon(
                      LucideIcons.plus,
                      color: context.colors.textPrimary,
                      size: 32,
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const GenerateBookScreen(),
                      ),
                    ).then((_) => _loadAllData(force: false)),
                  )
                : null,
          );
        },
      ),
    );
  }

  Widget _buildDesktopSidebar() {
    final user = FbAuth.instance.currentUser;
    return Container(
      width: 280,
      color: context.colors.glassStrong,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Branding Header
          Row(
            children: [
              const Icon(
                LucideIcons.bookOpen,
                size: 30,
                color: AppTheme.duoBlue,
              ),
              const SizedBox(width: 12),
              Text(
                'Sirius',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w900,
                  color: context.colors.textPrimary,
                  fontSize: 20,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),

          // Navigation Links
          _buildSidebarNavItem(0, LucideIcons.bookOpen, 'Your Library'),
          const SizedBox(height: 8),
          _buildSidebarNavItem(1, LucideIcons.barChart2, 'Analytics'),
          const SizedBox(height: 8),
          _buildSidebarNavItem(2, LucideIcons.globe, 'Published'),
          const SizedBox(height: 8),
          _buildSidebarNavItem(3, LucideIcons.hardDrive, 'Doc Store'),

          const Spacer(),

          // User profile at bottom if logged in
          if (user != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.colors.surfaceAlt,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.colors.outline),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: AppTheme.duoBlue,
                    child: Text(
                      user?.displayName?.isNotEmpty == true
                          ? user!.displayName![0].toUpperCase()
                          : 'U',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: context.colors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          user?.displayName ?? 'User',
                          style: TextStyle(
                            color: context.colors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          user?.email ?? '',
                          style: TextStyle(
                            color: context.colors.textFaint,
                            fontSize: 10,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
          _buildSidebarActionButton(
            icon: LucideIcons.settings,
            label: 'Settings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              ).then((_) => _loadAllData(force: false));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarNavItem(int index, IconData icon, String label) {
    final isActive = _selectedTabIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedTabIndex = index),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.duoGreen.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? AppTheme.duoGreen : context.colors.textFaint,
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w900,
                fontSize: 14,
                letterSpacing: 0.8,
                color: isActive
                    ? AppTheme.duoGreen
                    : context.colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: context.colors.outline),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: context.colors.textSecondary, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 0.8,
                  color: context.colors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLibraryTab(
    List<GenerationTask> activeTasks,
    double screenWidth,
  ) {
    final query = _librarySearchQuery.toLowerCase().trim();
    final isSearching = query.isNotEmpty;

    final List<SearchResultItem> searchResults = [];
    if (isSearching) {
      outerLoop:
      for (final book in books) {
        if (book.title.toLowerCase().contains(query) ||
            book.description.toLowerCase().contains(query)) {
          searchResults.add(
            SearchResultItem(
              book: book,
              type: 'book',
              title: book.title,
              context: 'Course',
            ),
          );
          if (searchResults.length >= 50) break outerLoop;
        }

        for (int modIdx = 0; modIdx < book.modules.length; modIdx++) {
          final module = book.modules[modIdx];
          if (module.title.toLowerCase().contains(query) ||
              module.description.toLowerCase().contains(query)) {
            searchResults.add(
              SearchResultItem(
                book: book,
                type: 'module',
                title: module.title,
                context: '${book.title} • Module ${modIdx + 1}',
                modIdx: modIdx,
              ),
            );
            if (searchResults.length >= 50) break outerLoop;
          }

          for (int secIdx = 0; secIdx < module.sections.length; secIdx++) {
            final section = module.sections[secIdx];
            if (section.title.toLowerCase().contains(query) ||
                section.description.toLowerCase().contains(query)) {
              searchResults.add(
                SearchResultItem(
                  book: book,
                  type: 'section',
                  title: section.title,
                  context: '${book.title} • ${module.title}',
                  modIdx: modIdx,
                  secIdx: secIdx,
                ),
              );
              if (searchResults.length >= 50) break outerLoop;
            }

            for (int unitIdx = 0; unitIdx < section.units.length; unitIdx++) {
              final unit = section.units[unitIdx];
              if (unit.title.toLowerCase().contains(query) ||
                  unit.description.toLowerCase().contains(query)) {
                searchResults.add(
                  SearchResultItem(
                    book: book,
                    type: 'unit',
                    title: unit.title,
                    context: '${book.title} • ${section.title}',
                    modIdx: modIdx,
                    secIdx: secIdx,
                    unitIdx: unitIdx,
                  ),
                );
                if (searchResults.length >= 50) break outerLoop;
              }

              for (
                int lessonIdx = 0;
                lessonIdx < unit.lessons.length;
                lessonIdx++
              ) {
                final lesson = unit.lessons[lessonIdx];
                if (lesson.title.toLowerCase().contains(query) ||
                    lesson.description.toLowerCase().contains(query)) {
                  searchResults.add(
                    SearchResultItem(
                      book: book,
                      type: 'lesson',
                      title: lesson.title,
                      context: '${book.title} • ${unit.title}',
                      modIdx: modIdx,
                      secIdx: secIdx,
                      unitIdx: unitIdx,
                      lessonIdx: lessonIdx,
                      lesson: lesson,
                    ),
                  );
                  if (searchResults.length >= 50) break outerLoop;
                }

                for (
                  int slideIdx = 0;
                  slideIdx < lesson.slides.length;
                  slideIdx++
                ) {
                  final slide = lesson.slides[slideIdx];
                  final inContent = slide.content.toLowerCase().contains(query);
                  final inTitle = slide.title.toLowerCase().contains(query);
                  final inAnswer =
                      slide.blankAnswer?.toLowerCase().contains(query) ?? false;

                  if (inContent || inTitle || inAnswer) {
                    String snippet = '';
                    if (inContent) {
                      snippet = _extractSnippet(slide.content, query);
                    } else if (inAnswer) {
                      snippet = 'Answer: ${slide.blankAnswer}';
                    } else {
                      snippet = slide.content;
                      if (snippet.length > 100)
                        snippet = '${snippet.substring(0, 100)}...';
                    }

                    searchResults.add(
                      SearchResultItem(
                        book: book,
                        type: 'slide',
                        title: slide.title.isNotEmpty
                            ? slide.title
                            : 'Theory Slide',
                        context: '${book.title} • ${lesson.title}',
                        snippet: snippet,
                        modIdx: modIdx,
                        secIdx: secIdx,
                        unitIdx: unitIdx,
                        lessonIdx: lessonIdx,
                        lesson: lesson,
                        slideId: slide.id,
                      ),
                    );
                    if (searchResults.length >= 50) break outerLoop;
                  }
                }
              }
            }
          }
        }
      }
    }

    final List<Book> displayedBooks;
    if (_selectedFolderId != null) {
      final currentFolder = folders.firstWhere(
        (f) => f.id == _selectedFolderId,
        orElse: () => CourseFolder(id: '', name: '', bookIds: []),
      );
      displayedBooks = books
          .where((b) => currentFolder.bookIds.contains(b.id))
          .toList();
    } else {
      displayedBooks = books
          .where((b) => !folders.any((f) => f.bookIds.contains(b.id)))
          .toList();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column (Smart Review, Next Up, Folders)
        if (!isSearching && _selectedFolderId == null)
          Container(
            width: 350,
            padding: const EdgeInsets.only(top: 24, left: 24, right: 12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SmartReviewCard(),
                  const SizedBox(height: 20),
                  if (books.isNotEmpty) ...[
                    NextUpCard(
                      books: books,
                      onReturn: () => _loadAllData(force: false),
                    ),
                    const SizedBox(height: 20),
                  ],
                  if (folders.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Text(
                        'FOLDERS',
                        style: TextStyle(
                          color: context.colors.textFaint,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildFoldersList(),
                  ],
                ],
              ),
            ),
          ),

        // Right Column (Main content, grid layout of courses)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header actions row
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: DragTarget<Book>(
                        onWillAcceptWithDetails: (details) {
                          final book = details.data;
                          return folders.any(
                            (f) => f.bookIds.contains(book.id),
                          );
                        },
                        onAcceptWithDetails: (details) async {
                          final book = details.data;
                          for (var i = 0; i < folders.length; i++) {
                            folders[i].bookIds.remove(book.id);
                          }
                          await _db.saveFolders(folders);
                          setState(() {});
                          showToast(
                            context,
                            'Removed "${book.title}" from folder',
                          );
                        },
                        builder: (context, candidateData, rejectedData) {
                          final isHovered = candidateData.isNotEmpty;
                          final folderName = _selectedFolderId != null
                              ? folders
                                    .firstWhere(
                                      (f) => f.id == _selectedFolderId,
                                      orElse: () => folders.first,
                                    )
                                    .name
                              : null;

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isHovered
                                  ? AppTheme.duoRed.withOpacity(0.15)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isHovered
                                    ? AppTheme.duoRed
                                    : Colors.transparent,
                                width: 1.2,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (_selectedFolderId != null) ...[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedFolderId = null;
                                      });
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(
                                          LucideIcons.chevronLeft,
                                          size: 18,
                                          color: AppTheme.duoBlue,
                                        ),
                                        Text(
                                          'Library',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: AppTheme.duoBlue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    child: Text(
                                      '/',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: context.colors.textFaint,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      folderName ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: context.colors.textPrimary,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ] else ...[
                                  Text(
                                    'Your Library',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 22,
                                      color: context.colors.textPrimary,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    if (!kIsWeb)
                      SizedBox(
                        width: 180,
                        child: DuoButton(
                          text: 'CREATE COURSE',
                          color: AppTheme.duoGreen,
                          shadowColor: AppTheme.duoGreenDark,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const GenerateBookScreen(),
                              ),
                            ).then((_) => _loadAllData(force: false));
                          },
                        ),
                      ),
                  ],
                ),
              ),

              // Search Bar
              _buildSearchBar(
                controller: _librarySearchController,
                value: _librarySearchQuery,
                hintText: 'Search your courses...',
                trailing: _selectedFolderId == null
                    ? IconButton(
                        icon: Icon(
                          LucideIcons.folderPlus,
                          color: context.colors.textPrimary,
                          size: 24,
                        ),
                        onPressed: _showCreateFolderDialog,
                        style: IconButton.styleFrom(
                          backgroundColor: context.colors.surfaceAlt,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: context.colors.outline,
                              width: 1.2,
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                        ),
                      )
                    : null,
              ),

              // Library contents
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (isSearching) ...[
                        if (searchResults.isEmpty)
                          Container(
                            height: 200,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  LucideIcons.search,
                                  color: context.colors.outline,
                                  size: 40,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No matching courses or content found.',
                                  style: TextStyle(
                                    color: context.colors.textFaint,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: searchResults.length,
                            itemBuilder: (context, index) {
                              final result = searchResults[index];
                              return _buildSearchResultCard(
                                context,
                                result,
                                query,
                              );
                            },
                          ),
                      ] else ...[
                        if (activeTasks.isNotEmpty && !kIsWeb) ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              'GENERATING COURSES',
                              style: TextStyle(
                                color: context.colors.textFaint,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: activeTasks.length,
                            itemBuilder: (context, index) {
                              final task = activeTasks[index];
                              return GeneratingBookCard(
                                task: task,
                                onTap: () {
                                  if (task.state == BookGenState.review &&
                                      task.skeletonBook != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PdfSplitPreviewScreen(
                                          taskId: task.id,
                                          originalPdf: task.sourceFiles,
                                          skeletonBook: task.skeletonBook!,
                                        ),
                                      ),
                                    ).then((_) => _loadAllData(force: false));
                                  } else if (task.state == BookGenState.error) {
                                    _handleGeneratingCardTap(task);
                                  }
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                        if (displayedBooks.isEmpty &&
                            activeTasks.isEmpty &&
                            (_selectedFolderId != null || folders.isEmpty))
                          (_selectedFolderId != null
                              ? Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    color: context.colors.surfaceAlt,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'This folder is empty.\nGo back and drag courses here!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: context.colors.textFaint,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : _buildFirstCourseCta())
                        else ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              'COURSES',
                              style: TextStyle(
                                color: context.colors.textFaint,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final int columns = (constraints.maxWidth / 320)
                                  .floor()
                                  .clamp(1, 3);
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: columns,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      mainAxisExtent: 110,
                                    ),
                                itemCount: displayedBooks.length,
                                itemBuilder: (context, index) {
                                  final book = displayedBooks[index];
                                  return Dismissible(
                                    key: Key(book.id),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade900.withOpacity(
                                          0.8,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Icon(
                                        LucideIcons.trash2,
                                        color: context.colors.textPrimary,
                                        size: 20,
                                      ),
                                    ),
                                    confirmDismiss: (direction) async {
                                      return await _deleteLocalBook(book);
                                    },
                                    child: CompactBookListItem(
                                      book: book,
                                      progress: progressMap[book.id] ?? 0.0,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                ModuleSelectionScreen(
                                                  book: book,
                                                ),
                                          ),
                                        ).then(
                                          (_) => _loadAllData(force: false),
                                        );
                                      },
                                      onLongPress: () =>
                                          _showBookLongPressMenu(book),
                                      dragHandle: _buildDragHandle(book),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
                color: context.colors.glassStrong,
                border: Border.all(color: context.colors.outline),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
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
                              border: Border.all(
                                color: AppTheme.duoBlue.withOpacity(0.4),
                              ),
                            ),
                            child: const Icon(
                              LucideIcons.bookOpen,
                              color: AppTheme.duoBlue,
                              size: 24,
                            ),
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
                                  style: TextStyle(
                                    color: context.colors.textPrimary,
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
                          _promptGenerateOrScheduleBook(
                            book,
                            isScheduled: false,
                          );
                        },
                      ),
                      _buildMenuItem(
                        icon: LucideIcons.calendar,
                        title: 'Schedule Generation',
                        subtitle: 'Queue for auto schedule hours',
                        iconColor: AppTheme.duoViolet,
                        onTap: () {
                          Navigator.pop(ctx);
                          _promptGenerateOrScheduleBook(
                            book,
                            isScheduled: true,
                          );
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
                      if (folders.any((f) => f.bookIds.contains(book.id))) ...[
                        _buildMenuItem(
                          icon: LucideIcons.folderClosed,
                          title: 'Move to another Folder',
                          subtitle: 'Move course to a different folder',
                          iconColor: AppTheme.duoBlue,
                          onTap: () {
                            Navigator.pop(ctx);
                            _showMoveBookToFolderDialog(book);
                          },
                        ),
                        _buildMenuItem(
                          icon: LucideIcons.folderOpen,
                          title: 'Remove from Folder',
                          subtitle: 'Move course back to root library',
                          iconColor: AppTheme.duoOrange,
                          onTap: () async {
                            Navigator.pop(ctx);
                            for (var f in folders) {
                              f.bookIds.remove(book.id);
                            }
                            await _db.saveFolders(folders);
                            _loadAllData(force: false);
                            showToast(
                              context,
                              'Removed "${book.title}" from folder',
                            );
                          },
                        ),
                      ] else
                        _buildMenuItem(
                          icon: LucideIcons.folderClosed,
                          title: 'Move to Folder',
                          subtitle: 'Group this course inside a folder',
                          iconColor: AppTheme.duoBlue,
                          onTap: () {
                            Navigator.pop(ctx);
                            _showMoveBookToFolderDialog(book);
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
                        child: Text(
                          'CANCEL',
                          style: TextStyle(
                            color: context.colors.textSecondary,
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
        backgroundColor: context.colors.surface,
        title: Text(
          'Reset Progress?',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to clear all completion progress for "${book.title}"?',
          style: TextStyle(color: context.colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
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
            child: const Text(
              'Reset',
              style: TextStyle(
                color: AppTheme.duoOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _promptGenerateOrScheduleBook(
    Book book, {
    required bool isScheduled,
  }) async {
    final wantsGraphics = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        title: Text(
          isScheduled
              ? 'Schedule Course Generation'
              : 'Generate Course Contents',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Choose what kind of content to generate for all modules and sections in this course.',
          style: TextStyle(color: context.colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'Text only',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'With diagrams',
              style: TextStyle(
                color: AppTheme.duoBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
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
        backgroundColor: context.colors.surface,
        content: Text(
          isScheduled
              ? 'Course generation scheduled!'
              : 'Course generation queued!',
          style: TextStyle(color: context.colors.textPrimary),
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
              color: context.colors.surfaceAlt,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.colors.outline),
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
                        style: TextStyle(
                          color: context.colors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: context.colors.textFaint,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  LucideIcons.chevronRight,
                  size: 16,
                  color: context.colors.outline,
                ),
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

  Widget _highlightedText(
    String text,
    String query,
    TextStyle baseStyle,
    TextStyle highlightStyle,
  ) {
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
      spans.add(
        TextSpan(
          text: text.substring(index, index + query.length),
          style: highlightStyle,
        ),
      );
      start = index + query.length;
      index = textLower.indexOf(queryLower, start);
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return RichText(
      text: TextSpan(style: baseStyle, children: spans),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSearchResultCard(
    BuildContext context,
    SearchResultItem result,
    String query,
  ) {
    IconData icon;
    Color color;
    String typeLabel;

    final bool isLessonOrSlide =
        result.type == 'lesson' || result.type == 'slide';
    bool isOpen = true;
    bool isCompleted = false;

    if (isLessonOrSlide && result.lesson != null) {
      isCompleted = _completedLessons.contains(result.lesson!.id);
      bool isUnlocked = false;
      if (result.lessonIdx != null &&
          result.book != null &&
          result.modIdx != null &&
          result.secIdx != null &&
          result.unitIdx != null) {
        if (result.modIdx! >= 0 &&
            result.modIdx! < result.book.modules.length) {
          final module = result.book.modules[result.modIdx!];
          if (result.secIdx! >= 0 && result.secIdx! < module.sections.length) {
            final section = module.sections[result.secIdx!];
            if (result.unitIdx! >= 0 &&
                result.unitIdx! < section.units.length) {
              final unit = section.units[result.unitIdx!];
              final idx = result.lessonIdx!;
              if (idx == 0) {
                isUnlocked = true;
              } else if (idx > 0 && idx < unit.lessons.length) {
                final prevLesson = unit.lessons[idx - 1];
                isUnlocked = _completedLessons.contains(prevLesson.id);
              }
            }
          }
        }
      }
      isOpen = isCompleted || isUnlocked;
    }

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
        icon = isCompleted
            ? LucideIcons.checkCircle2
            : (!isOpen ? LucideIcons.lock : LucideIcons.bookOpen);
        color = isCompleted
            ? AppTheme.duoGreen
            : (!isOpen ? context.colors.textFaint : AppTheme.duoGreen);
        typeLabel = isCompleted
            ? 'Lesson (Completed)'
            : (!isOpen ? 'Lesson (Locked)' : 'Lesson');
        break;
      case 'slide':
      default:
        icon = isCompleted
            ? LucideIcons.checkCircle2
            : (!isOpen ? LucideIcons.lock : LucideIcons.fileText);
        color = isCompleted
            ? AppTheme.duoGreen
            : (!isOpen
                  ? context.colors.textFaint
                  : context.colors.textSecondary);
        typeLabel = isCompleted
            ? 'Lesson Text (Completed)'
            : (!isOpen ? 'Lesson Text (Locked)' : 'Lesson Text');
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            if (isLessonOrSlide) {
              if (!isOpen) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: context.colors.surface,
                    title: Text(
                      'Lesson Locked',
                      style: TextStyle(
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      'Finish the previous lessons in this unit to unlock this one.',
                      style: TextStyle(color: context.colors.textSecondary),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text(
                          'OK',
                          style: TextStyle(color: AppTheme.duoBlue),
                        ),
                      ),
                    ],
                  ),
                );
                return;
              }
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
                      initialSlideId: result.type == 'slide'
                          ? result.slideId
                          : null,
                    ),
                  ),
                ).then((_) => _loadAllData(force: false));
              }
            } else {
              if (result.modIdx != null) {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setInt(
                  'last_mod_idx_${result.book.id}',
                  result.modIdx!,
                );
                if (result.secIdx != null) {
                  await prefs.setInt(
                    'last_sec_idx_${result.book.id}',
                    result.secIdx!,
                  );
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
              color: context.colors.surfaceAlt,
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              typeLabel,
                              style: TextStyle(
                                color: color,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              result.context,
                              style: TextStyle(
                                color: context.colors.textFaint,
                                fontSize: 11,
                              ),
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
                        TextStyle(
                          color: context.colors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          backgroundColor: color.withOpacity(0.1),
                        ),
                      ),
                      if (result.snippet != null &&
                          result.snippet!.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        _highlightedText(
                          result.snippet!,
                          query,
                          TextStyle(
                            color: context.colors.textSecondary,
                            fontSize: 12,
                            height: 1.3,
                          ),
                          TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                            backgroundColor: color.withOpacity(0.1),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  LucideIcons.chevronRight,
                  color: context.colors.outline,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _getFolderProgress(CourseFolder folder) {
    if (folder.bookIds.isEmpty) return 0.0;
    double total = 0.0;
    int count = 0;
    for (final bookId in folder.bookIds) {
      if (progressMap.containsKey(bookId)) {
        total += progressMap[bookId]!;
        count++;
      }
    }
    return count > 0 ? total / count : 0.0;
  }

  void _showCreateFolderDialog() {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'New Folder',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: textController,
          autofocus: true,
          style: TextStyle(color: context.colors.textPrimary),
          decoration: InputDecoration(
            hintText: 'Folder Name',
            hintStyle: TextStyle(color: context.colors.textFaint),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: context.colors.outline),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.duoBlue),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
          TextButton(
            onPressed: () async {
              final name = textController.text.trim();
              if (name.isNotEmpty) {
                final newFolder = CourseFolder(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: name,
                  bookIds: [],
                );
                folders.add(newFolder);
                await _db.saveFolders(folders);
                setState(() {});
                Navigator.pop(ctx);
              }
            },
            child: const Text(
              'Create',
              style: TextStyle(
                color: AppTheme.duoGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFolderOptions(CourseFolder folder) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            decoration: BoxDecoration(
              color: context.colors.glassStrong,
              border: Border.all(color: context.colors.outline),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    folder.name,
                    style: TextStyle(
                      color: context.colors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildMenuItem(
                    icon: LucideIcons.edit3,
                    title: 'Rename Folder',
                    subtitle: 'Change the name of this folder',
                    iconColor: AppTheme.duoBlue,
                    onTap: () {
                      Navigator.pop(ctx);
                      _showRenameFolderDialog(folder);
                    },
                  ),
                  _buildMenuItem(
                    icon: LucideIcons.trash2,
                    title: 'Delete Folder',
                    subtitle: 'Delete folder and move all courses to root',
                    iconColor: AppTheme.duoRed,
                    onTap: () async {
                      Navigator.pop(ctx);
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (alertCtx) => AlertDialog(
                          backgroundColor: context.colors.surface,
                          title: Text(
                            'Delete Folder?',
                            style: TextStyle(
                              color: context.colors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(
                            'Are you sure you want to delete this folder? The courses inside will not be deleted.',
                            style: TextStyle(
                              color: context.colors.textSecondary,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(alertCtx, false),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: context.colors.textFaint,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(alertCtx, true),
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                  color: AppTheme.duoRed,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        folders.removeWhere((f) => f.id == folder.id);
                        if (_selectedFolderId == folder.id) {
                          _selectedFolderId = null;
                        }
                        await _db.saveFolders(folders);
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showRenameFolderDialog(CourseFolder folder) {
    final textController = TextEditingController(text: folder.name);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        title: Text(
          'Rename Folder',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: textController,
          autofocus: true,
          style: TextStyle(color: context.colors.textPrimary),
          decoration: InputDecoration(
            hintText: 'Folder Name',
            hintStyle: TextStyle(color: context.colors.textFaint),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: context.colors.outline),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.duoBlue),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
          TextButton(
            onPressed: () async {
              final newName = textController.text.trim();
              if (newName.isNotEmpty) {
                final idx = folders.indexWhere((f) => f.id == folder.id);
                if (idx != -1) {
                  folders[idx] = folder.copyWith(name: newName);
                  await _db.saveFolders(folders);
                  setState(() {});
                }
                Navigator.pop(ctx);
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(
                color: AppTheme.duoGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoldersList() {
    if (folders.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 110,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 100 / 112,
        ),
        itemCount: folders.length,
        itemBuilder: (context, index) {
          final folder = folders[index];
          final progress = _getFolderProgress(folder);
          return _buildFolderCard(folder, progress);
        },
      ),
    );
  }

  Widget _buildFolderCard(CourseFolder folder, double progress) {
    return DragTarget<Book>(
      onWillAcceptWithDetails: (details) {
        return !folder.bookIds.contains(details.data.id);
      },
      onAcceptWithDetails: (details) async {
        final book = details.data;
        for (var i = 0; i < folders.length; i++) {
          folders[i].bookIds.remove(book.id);
        }
        folder.bookIds.add(book.id);
        await _db.saveFolders(folders);
        setState(() {});

        showToast(context, 'Moved "${book.title}" to folder "${folder.name}"');
      },
      builder: (context, candidateData, rejectedData) {
        final isHovered = candidateData.isNotEmpty;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedFolderId = folder.id;
            });
          },
          onLongPress: () => _showFolderOptions(folder),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            decoration: BoxDecoration(
              color: isHovered
                  ? AppTheme.duoBlue.withOpacity(0.15)
                  : context.colors.surfaceAlt,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isHovered ? AppTheme.duoBlue : context.colors.outline,
                width: 1.2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 44,
                      height: 44,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 3.5,
                        backgroundColor: context.colors.surfaceAlt,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          progress == 1.0
                              ? AppTheme.duoGreen
                              : AppTheme.duoBlue,
                        ),
                      ),
                    ),
                    Icon(
                      LucideIcons.folderClosed,
                      color: progress == 1.0
                          ? AppTheme.duoGreen
                          : context.colors.textSecondary,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  folder.name,
                  style: TextStyle(
                    color: context.colors.textPrimary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                Text(
                  folder.bookIds.length == 1
                      ? '1 course'
                      : '${folder.bookIds.length} courses',
                  style: TextStyle(
                    color: context.colors.textFaint,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDragHandle(Book book) {
    return Draggable<Book>(
      data: book,
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(
          opacity: 0.8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.duoBlue, width: 1.2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  LucideIcons.bookOpen,
                  color: AppTheme.duoBlue,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  book.title,
                  style: TextStyle(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      childWhenDragging: const SizedBox.shrink(),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(
          LucideIcons.gripVertical,
          color: context.colors.textFaint,
          size: 20,
        ),
      ),
    );
  }

  void _showMoveBookToFolderDialog(Book book) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Move to Folder',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: folders.isEmpty
            ? Text(
                'No folders created yet. Create a folder first!',
                style: TextStyle(color: context.colors.textSecondary),
              )
            : SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: folders.length,
                  itemBuilder: (context, idx) {
                    final folder = folders[idx];
                    final isAlreadyIn = folder.bookIds.contains(book.id);
                    return ListTile(
                      title: Text(
                        folder.name,
                        style: TextStyle(color: context.colors.textPrimary),
                      ),
                      trailing: isAlreadyIn
                          ? const Icon(
                              LucideIcons.check,
                              color: AppTheme.duoGreen,
                            )
                          : null,
                      onTap: () async {
                        Navigator.pop(ctx);
                        for (var f in folders) {
                          f.bookIds.remove(book.id);
                        }
                        folder.bookIds.add(book.id);
                        await _db.saveFolders(folders);
                        _loadAllData(force: false);

                        showToast(
                          context,
                          'Moved "${book.title}" to folder "${folder.name}"',
                        );
                      },
                    );
                  },
                ),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
          if (folders.isEmpty)
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                _showCreateFolderDialog();
              },
              child: const Text(
                'New Folder',
                style: TextStyle(
                  color: AppTheme.duoGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SearchResultItem {
  final Book book;
  final String
  type; // 'book' | 'module' | 'section' | 'unit' | 'lesson' | 'slide'
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
