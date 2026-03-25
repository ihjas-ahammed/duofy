import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/global_state.dart';
import '../services/database_service.dart';
import '../services/generation_manager.dart';
import 'book_dashboard_screen.dart';
import 'practice_screen.dart';
import 'notes_screen.dart';
import 'exam_screen.dart';
import 'course_settings_screen.dart';

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

  @override
  void initState() {
    super.initState();
    _currentBook = widget.book;

    _bookUpdateSub = GenerationManager.instance.bookUpdates.listen((updatedBook) {
      if (updatedBook.id == _currentBook.id && mounted) {
        setState(() {
          _currentBook = updatedBook;
        });
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
    }
  }

  void _openCourseSettings() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => CourseSettingsScreen(book: _currentBook)));
  }

  void _publishBook() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Publish to Community?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text('This will make your course available to everyone in the Global Community Picks.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Publishing...')));
              await DatabaseService().publishToGlobal(_currentBook);
              if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Published Successfully!')));
            },
            child: const Text('Publish', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold)),
          )
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      BookDashboardScreen(book: _currentBook, onBookUpdated: _onBookUpdated),
      PracticeScreen(book: _currentBook),
      NotesScreen(book: _currentBook),
      ExamScreen(book: _currentBook),
    ];

    return Scaffold(
      extendBody: true, 
      appBar: AppBar(
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
            icon: const Icon(LucideIcons.uploadCloud, size: 22, color: AppTheme.duoBlue),
            tooltip: 'Publish to Community',
            onPressed: _publishBook,
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
                  _buildNavItem(2, LucideIcons.fileText),
                  _buildNavItem(3, LucideIcons.fileQuestion),
                ],
              ),
            ),
          ),
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