import 'package:flutter/material.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';

class ModuleSelector extends StatelessWidget {
  final List<Module> modules;
  final int activeModuleIdx;
  final Function(int) onSelect;

  const ModuleSelector({
    super.key,
    required this.modules,
    required this.activeModuleIdx,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    if (modules.isEmpty) return const SizedBox.shrink();
    
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final mod = modules[index];
          final isActive = index == activeModuleIdx;
          
          return GestureDetector(
            onTap: () => onSelect(index),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isActive ? AppTheme.duoBlue : AppTheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActive ? AppTheme.duoBlueDark : Colors.white12, 
                  width: 2
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                mod.title.toUpperCase(), 
                style: TextStyle(
                  fontSize: 12, 
                  fontWeight: FontWeight.w900,
                  color: isActive ? Colors.white : Colors.white54,
                  letterSpacing: 1.2
                )
              ),
            ),
          );
        },
      ),
    );
  }
}