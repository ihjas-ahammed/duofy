import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/global_state.dart';
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
  
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      BookDashboardScreen(book: widget.book),
      PracticeScreen(book: widget.book),
      NotesScreen(book: widget.book),
      ExamScreen(book: widget.book),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
        title: ValueListenableBuilder<int>(
          valueListenable: GlobalState.xpNotifier,
          builder: (context, xp, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(LucideIcons.zap, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text('$xp XP', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.w900, fontSize: 16)),
              ],
            );
          },
        ),
        actions: [
          IconButton(icon: const Icon(LucideIcons.moreHorizontal), onPressed: () {}),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      
      // Glass Bottom Navigation Bar
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
                  _buildNavItem(0, LucideIcons.map, 'Path'),
                  _buildNavItem(1, LucideIcons.dumbbell, 'Practice'),
                  _buildNavItem(2, LucideIcons.fileText, 'Notes'),
                  _buildNavItem(3, LucideIcons.bookOpenCheck, 'Exam'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isActive = _currentIndex == index;
    final color = isActive ? AppTheme.duoBlue : Colors.white54;
    
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label.toUpperCase(),
              style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1.0),
            ),
          ],
        ),
      ),
    );
  }
}