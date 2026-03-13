import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
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
          const Text('Select Module', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
          const SizedBox(height: 24),
          ...List.generate(modules.length, (index) {
            final mod = modules[index];
            final isActive = index == activeModuleIdx;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => onSelect(index),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isActive ? AppTheme.duoBlue.withOpacity(0.2) : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isActive ? AppTheme.duoBlue : Colors.transparent, 
                      width: 2
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isActive ? AppTheme.duoBlue : Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(LucideIcons.book, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mod.title, 
                              style: TextStyle(
                                fontSize: 16, 
                                fontWeight: FontWeight.bold,
                                color: isActive ? AppTheme.duoBlue : Colors.white
                              )
                            ),
                            const SizedBox(height: 4),
                            Text(
                              mod.description, 
                              style: const TextStyle(fontSize: 12, color: Colors.white54),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (isActive)
                        const Icon(LucideIcons.check, color: AppTheme.duoBlue)
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