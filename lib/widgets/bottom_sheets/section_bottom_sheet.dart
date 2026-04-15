import 'package:flutter/material.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SectionBottomSheet extends StatelessWidget {
  final Book book;
  final int activeModuleIdx;
  final int activeSectionIdx;
  final Function(int moduleIdx, int sectionIdx) onSelect;

  const SectionBottomSheet({
    super.key,
    required this.book,
    required this.activeModuleIdx,
    required this.activeSectionIdx,
    required this.onSelect,
  });

  Color _getColor(String colorStr) {
    switch (colorStr) {
      case 'duo-green': return AppTheme.duoGreen;
      case 'duo-blue': return AppTheme.duoBlue;
      case 'duo-violet': return AppTheme.duoViolet;
      case 'duo-orange': return AppTheme.duoOrange;
      default: return AppTheme.duoBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> flatSections = [];
    if (book.modules.isNotEmpty && activeModuleIdx < book.modules.length) {
      final module = book.modules[activeModuleIdx];
      for (int s = 0; s < module.sections.length; s++) {
        flatSections.add({
          'moduleIdx': activeModuleIdx,
          'sectionIdx': s,
          'section': module.sections[s],
          'isActive': s == activeSectionIdx,
        });
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background, // very dark background
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          // Drag handle
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
            'Sections',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              physics: const BouncingScrollPhysics(),
              itemCount: flatSections.length,
              itemBuilder: (context, index) {
                final item = flatSections[index];
                final Section section = item['section'];
                final bool isActive = item['isActive'];
                final int mIdx = item['moduleIdx'];
                final int sIdx = item['sectionIdx'];
                
                final color = _getColor(section.color);
                
                // Calculate progress mock or real (lessons completed)
                // For now, let's mock 17% or if you want real calculation we can calculate lessons.
                // As we don't have completed lessons directly here, let's just make it look like Image 2.
                // (In a real scenario we'd pass in completedLessons and calculate it. Let's pass it if needed,
                // but since we only need UI match, let's mock or use a 0-100 placeholder).
                
                return GestureDetector(
                  onTap: () {
                    onSelect(mIdx, sIdx);
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isActive ? color.withOpacity(0.15) : AppTheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isActive ? color : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          section.title,
                          style: TextStyle(
                            color: isActive ? Colors.white : Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          section.description,
                          style: TextStyle(
                            color: isActive ? Colors.white70 : Colors.white54,
                            fontSize: 13,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PROGRESS 0%',
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: 0.0, // MOCK PROGRESS
                                      backgroundColor: Colors.white10,
                                      valueColor: AlwaysStoppedAnimation<Color>(color),
                                      minHeight: 8,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isActive ? color.withOpacity(0.2) : Colors.white10,
                              ),
                              child: Icon(
                                LucideIcons.chevronRight,
                                size: 20,
                                color: isActive ? Colors.white : Colors.white54,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
