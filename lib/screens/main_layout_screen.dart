import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/global_state.dart';
import '../services/generation_manager.dart';
import 'book_dashboard_screen.dart';
import 'practice_screen.dart';
import 'notes_screen.dart';
import 'exam_screen.dart';

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

    // Listen to background generation updates globally
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

  // Fallback direct update for synchronous changes if needed
  void _onBookUpdated(Book newBook) {
    if (mounted) {
      setState(() {
        _currentBook = newBook;
      });
    }
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
        ),
        actions: [
          ValueListenableBuilder<int>(
            valueListenable: GlobalState.xpNotifier,
            builder: (context, xp, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.amber.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(LucideIcons.zap, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '$xp XP', 
                        style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.w900, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      
      // Glass Bottom Navigation Bar (Ultra Compact Icons only)
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
                  _buildNavItem(3, LucideIcons.bookOpenCheck),
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
    
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}