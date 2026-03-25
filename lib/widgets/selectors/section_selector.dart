import 'package:flutter/material.dart';
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
    if (sections.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final section = sections[index];
          final isActive = index == activeSectionIdx;
          final color = _getColor(section.color);
          
          return GestureDetector(
            onTap: () => onSelect(index),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isActive ? color.withOpacity(0.2) : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isActive ? color : Colors.white10, 
                  width: 2
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                section.title, 
                style: TextStyle(
                  fontSize: 13, 
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.white : Colors.white54
                )
              ),
            ),
          );
        },
      ),
    );
  }
}