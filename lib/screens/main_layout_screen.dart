import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/database_service.dart';
import '../services/generation_manager.dart';
import 'book_dashboard_screen.dart';
import 'practice_screen.dart';
import 'summary_screen.dart';
import 'pyq_tab_screen.dart';
import 'course_settings_screen.dart';
import 'course_edit_structure_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  final Book book;

  const MainLayoutScreen({super.key, required this.book});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;
  late Book _currentBook;
  late StreamSubscription<Book> _bookUpdateSub;
  bool _isSyncPromptOpen = false;

  @override
  void initState() {
    super.initState();
    _currentBook = widget.book;

    _bookUpdateSub = GenerationManager.instance.bookUpdates.listen((updatedBook) {
      if (updatedBook.id == _currentBook.id && mounted) {
        final wasGlobal = _currentBook.isGlobal;
        setState(() {
          _currentBook = updatedBook;
        });
        if (wasGlobal || updatedBook.isGlobal) {
          _promptSyncPublishedBook(updatedBook);
        }
      }
    });
  }

  @override
  void dispose() {
    _bookUpdateSub.cancel();
    super.dispose();
  }

  void _onBookUpdated(Book newBook) {
    if (mounted) {
      setState(() {
        _currentBook = newBook;
      });
      if (newBook.isGlobal) {
        _promptSyncPublishedBook(newBook);
      }
    }
  }

  void _openCourseSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Course Configuration',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(LucideIcons.edit3, color: AppTheme.duoBlue),
                title: const Text('Edit Course Structure', style: TextStyle(color: Colors.white)),
                subtitle: const Text('Rename components, add modules/sections, or re-map pages', style: TextStyle(color: Colors.white54, fontSize: 11)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CourseEditStructureScreen(
                        book: _currentBook,
                        onBookUpdated: _onBookUpdated,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(LucideIcons.list, color: AppTheme.duoViolet),
                title: const Text('Lesson Formats', style: TextStyle(color: Colors.white)),
                subtitle: const Text('Manage pedagogical structures and AI guidance rules', style: TextStyle(color: Colors.white54, fontSize: 11)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CourseSettingsScreen(book: _currentBook),
                    ),
                  ).then((_) async {
                    final freshest = await DatabaseService().getBookFromCache(_currentBook.id);
                    if (freshest != null && mounted) {
                      _onBookUpdated(freshest);
                    }
                  });
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _publishBook() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Publish to Community?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text('This will make your course available to everyone in the Published Courses.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              _syncBook();
            },
            child: const Text('Publish', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold)),
          )
        ]
      )
    );
  }

  void _syncBook() async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Syncing course to community...')));
    final success = await DatabaseService().publishToGlobal(_currentBook);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(success ? 'Sync Completed!' : 'Enable Cloud Sync in Settings to sync.'),
    ));
    final freshest = await DatabaseService().getBookFromCache(_currentBook.id);
    if (freshest != null && mounted) {
      setState(() {
        _currentBook = freshest;
      });
    }
  }

  void _handlePublishOrSync() {
    if (_currentBook.isGlobal) {
      _syncBook();
    } else {
      _publishBook();
    }
  }

  String _formatLastSyncDate(int? ts) {
    if (ts == null || ts == 0) return 'Never';
    final dt = DateTime.fromMillisecondsSinceEpoch(ts);
    final hour = dt.hour == 0 ? 12 : (dt.hour > 12 ? dt.hour - 12 : dt.hour);
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    final minute = dt.minute.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final day = dt.day.toString().padLeft(2, '0');
    return '$month-$day $hour:$minute $period';
  }

  void _promptSyncPublishedBook(Book book) {
    if (_isSyncPromptOpen) return;
    _isSyncPromptOpen = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Sync Changes?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text('This is a published course. Would you like to sync the new changes/content to the community database?'),
        actions: [
          TextButton(
            onPressed: () {
              _isSyncPromptOpen = false;
              Navigator.pop(ctx);
            },
            child: const Text('Later', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () async {
              _isSyncPromptOpen = false;
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Syncing course to community...')));
              final success = await DatabaseService().publishToGlobal(book);
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(success ? 'Sync Completed!' : 'Enable Cloud Sync in Settings to sync.'),
              ));
              final freshest = await DatabaseService().getBookFromCache(book.id);
              if (freshest != null && mounted) {
                setState(() {
                  _currentBook = freshest;
                });
              }
            },
            child: const Text('Sync Now', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // NOTE: the Exams / Question-Papers tab is intentionally omitted from the
    // nav for now — it's being reworked in a later development stage. The
    // ExamScreen + QP generation code is kept intact for when it returns.
    final List<Widget> pages = [
      BookDashboardScreen(book: _currentBook, onBookUpdated: _onBookUpdated),
      PracticeScreen(book: _currentBook),
      PyqTabScreen(
        book: _currentBook,
        onBookUpdated: () async {
          final freshest = await DatabaseService().getBookFromCache(_currentBook.id);
          if (freshest != null && mounted) {
            setState(() {
              _currentBook = freshest;
            });
          }
        },
      ),
      SummaryScreen(book: _currentBook),
    ];

    final isDesktop = MediaQuery.of(context).size.width >= 900;

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            // Desktop Left Sidebar (SideNav equivalent)
            _buildDesktopSidebar(),
            Container(width: 1, color: Colors.white.withOpacity(0.08)),
            // Desktop Main Content
            Expanded(
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      centerTitle: true,
                      title: Text(
                        _currentIndex == 0
                            ? 'Learning Path'
                            : _currentIndex == 1
                                ? 'Practice Arena'
                                : _currentIndex == 2
                                    ? 'PYQ Analyzer'
                                    : 'Course Summary',
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          letterSpacing: 1.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    body: IndexedStack(
                      index: _currentIndex,
                      children: pages,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      extendBody: true, 
      appBar: _currentIndex == 0 ? null : AppBar(
        backgroundColor: AppTheme.background.withOpacity(0.9),
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
        centerTitle: true,
        title: Text(
          _currentBook.title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 18,
            letterSpacing: 1.0,
            color: Colors.white,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.settings, size: 22, color: Colors.white70),
            tooltip: 'Course Configuration',
            onPressed: _openCourseSettings,
          ),
          IconButton(
            icon: Icon(
              _currentBook.isGlobal ? LucideIcons.refreshCw : LucideIcons.uploadCloud,
              size: 22,
              color: AppTheme.duoBlue,
            ),
            tooltip: _currentBook.isGlobal
                ? 'Sync Course (Last: ${_formatLastSyncDate(_currentBook.updatedAt)})'
                : 'Publish to Community',
            onPressed: _handlePublishOrSync,
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              border: Border(top: BorderSide(color: Colors.white.withOpacity(0.15))),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, LucideIcons.map),
                  _buildNavItem(1, LucideIcons.dumbbell),
                  _buildNavItem(2, LucideIcons.fileQuestion),
                  _buildNavItem(3, LucideIcons.clipboardList),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopSidebar() {
    return Container(
      width: 280,
      color: Colors.black.withOpacity(0.4),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Branding Header
          Row(
            children: [
              const Icon(LucideIcons.map, size: 30, color: AppTheme.duoBlue),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'DuoFY',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      _currentBook.title,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        color: Colors.white54,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          
          // Navigation Links
          _buildSidebarNavItem(0, LucideIcons.map, 'Path'),
          const SizedBox(height: 8),
          _buildSidebarNavItem(1, LucideIcons.dumbbell, 'Practice'),
          const SizedBox(height: 8),
          _buildSidebarNavItem(2, LucideIcons.fileQuestion, 'PYQ'),
          const SizedBox(height: 8),
          _buildSidebarNavItem(3, LucideIcons.clipboardList, 'Summary'),
          
          const Spacer(),
          
          // Settings and Actions
          _buildSidebarActionButton(
            icon: LucideIcons.settings,
            label: 'Course Settings',
            onTap: _openCourseSettings,
          ),
          const SizedBox(height: 8),
          _buildSidebarActionButton(
            icon: _currentBook.isGlobal ? LucideIcons.refreshCw : LucideIcons.uploadCloud,
            label: _currentBook.isGlobal ? 'Sync Course' : 'Publish Course',
            subtitle: _currentBook.isGlobal
                ? 'Last: ${_formatLastSyncDate(_currentBook.updatedAt)}'
                : null,
            iconColor: AppTheme.duoBlue,
            onTap: _handlePublishOrSync,
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarNavItem(int index, IconData icon, String label) {
    final isActive = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.duoBlue.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? AppTheme.duoBlue : Colors.white60,
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
                color: isActive ? AppTheme.duoBlue : Colors.white70,
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
    String? subtitle,
    required VoidCallback onTap,
    Color iconColor = Colors.white70,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.08)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 11,
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    final isActive = _currentIndex == index;
    final color = isActive ? AppTheme.duoBlue : Colors.white54;
    
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Icon(icon, color: color, size: 28),
        ),
      ),
    );
  }
}