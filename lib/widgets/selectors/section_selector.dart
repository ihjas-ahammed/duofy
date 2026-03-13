import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';

class SectionSelector extends StatelessWidget {
  final List<Section> sections;
  final int activeSectionIdx;
  final Function(int) onSelect;

  const SectionSelector({
    super.key,
    required this.sections,
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
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface.withOpacity(0.95),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border.all(color: Colors.white10),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Sections', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 24),
          ...List.generate(sections.length, (index) {
            final section = sections[index];
            final isActive = index == activeSectionIdx;
            final color = _getColor(section.color);
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => onSelect(index),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isActive ? color.withOpacity(0.2) : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isActive ? color : Colors.transparent, 
                      width: 2
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              section.title, 
                              style: TextStyle(
                                fontSize: 18, 
                                fontWeight: FontWeight.bold,
                                color: isActive ? Colors.white : Colors.white70
                              )
                            ),
                            const SizedBox(height: 4),
                            Text(
                              section.description, 
                              style: TextStyle(
                                fontSize: 13, 
                                color: isActive ? Colors.white.withOpacity(0.8) : Colors.white54
                              )
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isActive ? Colors.white24 : Colors.white10,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          LucideIcons.chevronRight, 
                          color: isActive ? Colors.white : Colors.white54
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 20), // Bottom safe area padding
        ],
      ),
    );
  }
}