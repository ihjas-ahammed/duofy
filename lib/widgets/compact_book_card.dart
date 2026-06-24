import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../utils/progress_utils.dart';
import 'lesson_node.dart';

class CompactBookCard extends StatelessWidget {
  final Book book;
  final double progress;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final Widget? dragHandle;

  const CompactBookCard({
    super.key,
    required this.book,
    required this.progress,
    required this.onTap,
    this.onLongPress,
    this.dragHandle,
  });

  String _getMostUsedIcon(Book book) {
    final Map<String, int> counts = {};
    for (final module in book.modules) {
      for (final section in module.sections) {
        for (final unit in section.units) {
          for (final lesson in unit.lessons) {
            final iconName = lesson.icon;
            counts[iconName] = (counts[iconName] ?? 0) + 1;
          }
        }
      }
    }
    if (counts.isEmpty) {
      return book.icon;
    }
    String mostUsed = book.icon;
    int maxVal = -1;
    counts.forEach((iconName, count) {
      if (count > maxVal) {
        maxVal = count;
        mostUsed = iconName;
      }
    });
    return mostUsed;
  }

  Color _getMostUsedSectionColor(Book book) {
    final Map<String, int> counts = {};
    for (final module in book.modules) {
      for (final section in module.sections) {
        final colorName = section.color;
        counts[colorName] = (counts[colorName] ?? 0) + 1;
      }
    }
    if (counts.isEmpty) {
      return AppTheme.duoBlue;
    }
    String mostUsed = 'duo-blue';
    int maxVal = -1;
    counts.forEach((colorName, count) {
      if (count > maxVal) {
        maxVal = count;
        mostUsed = colorName;
      }
    });
    return SectionColors.base(mostUsed);
  }

  @override
  Widget build(BuildContext context) {
    final String mostUsedIconName = _getMostUsedIcon(book);
    final IconData displayIcon = getIconData(mostUsedIconName);
    final Color mostUsedColor = _getMostUsedSectionColor(book);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double cardWidth = constraints.maxWidth;
        // Scale icon size and font size proportionally
        final double iconSize = (cardWidth * 0.35).clamp(18.0, 48.0);
        final double fontSize = (cardWidth * 0.14).clamp(9.5, 12.5);

        return GestureDetector(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: mostUsedColor.withOpacity(0.22), width: 1.2),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top: Seamless Icon (Expanded to consume extra height when resizing)
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Icon(
                          displayIcon,
                          color: mostUsedColor,
                          size: iconSize,
                        ),
                      ),
                    ),
                    
                    // Middle: Text with tight, constant padding (no Expanded)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      child: Text(
                        book.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: fontSize, 
                          color: Colors.white.withOpacity(0.9),
                          height: 1.15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                    // Bottom: Slim Progress Bar
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1.5),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: mostUsedColor.withOpacity(0.12),
                          color: mostUsedColor,
                          minHeight: 3.5,
                        ),
                      ),
                    ),
                  ],
                ),
                if (dragHandle != null)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: dragHandle!,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}