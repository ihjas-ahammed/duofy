import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/lesson_path.dart';

class BookDashboardScreen extends StatefulWidget {
  final Book book;

  const BookDashboardScreen({super.key, required this.book});

  @override
  State<BookDashboardScreen> createState() => _BookDashboardScreenState();
}

class _BookDashboardScreenState extends State<BookDashboardScreen> {
  int currentModuleIdx = 0;
  int currentSectionIdx = 0;

  void _showSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return AppTheme.applyGlassBlur(
          borderRadius: 24,
          child: Container(
            padding: const EdgeInsets.all(24),
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('SELECT SECTION', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white54, letterSpacing: 1.5)),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.book.modules[currentModuleIdx].sections.length,
                    itemBuilder: (ctx, i) {
                      final s = widget.book.modules[currentModuleIdx].sections[i];
                      final isSelected = i == currentSectionIdx;
                      return ListTile(
                        onTap: () {
                          setState(() => currentSectionIdx = i);
                          Navigator.pop(ctx);
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        tileColor: isSelected ? AppTheme.duoBlue.withOpacity(0.2) : Colors.transparent,
                        title: Text(s.title, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? AppTheme.duoBlue : Colors.white)),
                        subtitle: Text(s.description, style: const TextStyle(fontSize: 12, color: Colors.white54)),
                        trailing: isSelected ? const Icon(LucideIcons.checkCircle2, color: AppTheme.duoBlue) : null,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.book.modules.isEmpty) {
      return const Center(child: Text("This book is empty."));
    }

    final section = widget.book.modules[currentModuleIdx].sections[currentSectionIdx];

    return Scaffold(
      body: Column(
        children: [
          // Glassy Header Selector (Always show to allow user to see what they are on)
          GestureDetector(
            onTap: _showSelector,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: AppTheme.glassDecoration.copyWith(
                border: const Border(bottom: BorderSide(color: AppTheme.duoBlue, width: 4)),
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.book, color: AppTheme.duoBlue, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      section.title.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1.2),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(LucideIcons.chevronDown, color: Colors.white54, size: 20),
                ],
              ),
            ),
          ),
          
          Expanded(child: LessonPath(section: section)),
        ],
      ),
    );
  }
}