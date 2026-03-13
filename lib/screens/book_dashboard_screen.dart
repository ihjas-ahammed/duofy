import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/lesson_node.dart';
import 'lesson_screen.dart';

class BookDashboardScreen extends StatefulWidget {
  final Book book;

  const BookDashboardScreen({super.key, required this.book});

  @override
  State<BookDashboardScreen> createState() => _BookDashboardScreenState();
}

class _BookDashboardScreenState extends State<BookDashboardScreen> {
  int currentModuleIdx = 0;
  int currentSectionIdx = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.book.modules.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.book.title)),
        body: const Center(child: Text("This book is empty.")),
      );
    }

    final section = widget.book.modules[currentModuleIdx].sections[currentSectionIdx];
    final allLessons = section.units.expand((u) => u.lessons).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(section.title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.white.withOpacity(0.1), height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Center(
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 60,
              children: allLessons.map((lesson) {
                // Hardcode logic for demo: first lesson unlocked, others locked.
                // In a real app, track via SharedPreferences.
                bool isUnlocked = allLessons.indexOf(lesson) == 0; 
                return LessonNodeWidget(
                  lesson: lesson,
                  isCompleted: false,
                  isLocked: !isUnlocked,
                  sectionColorStr: section.color,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_) => LessonScreen(lesson: lesson)
                    ));
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}