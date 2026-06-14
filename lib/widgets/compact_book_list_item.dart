import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../utils/progress_utils.dart';
import 'lesson_node.dart';

class CompactBookListItem extends StatelessWidget {
  final Book book;
  final double progress;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const CompactBookListItem({
    super.key,
    required this.book,
    required this.progress,
    required this.onTap,
    this.onLongPress,
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

    final percentText = '${(progress * 100).toInt()}%';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(16),
          splashColor: mostUsedColor.withOpacity(0.08),
          highlightColor: mostUsedColor.withOpacity(0.04),
          child: Ink(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: mostUsedColor.withOpacity(0.2), width: 1.2),
            ),
            child: Row(
              children: [
                // 1. Icon Container
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: mostUsedColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: mostUsedColor.withOpacity(0.25), width: 1.2),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    displayIcon,
                    color: mostUsedColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                
                // 2. Middle Texts & Progress
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        book.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        book.modules.length == 1
                            ? '1 Module • $percentText complete'
                            : '${book.modules.length} Modules • $percentText complete',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Progress Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: mostUsedColor.withOpacity(0.08),
                          color: mostUsedColor,
                          minHeight: 4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                
                // 3. Trailing Arrow
                Icon(
                  LucideIcons.chevronRight,
                  color: Colors.white.withOpacity(0.2),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
