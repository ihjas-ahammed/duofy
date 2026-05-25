import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../../utils/progress_utils.dart';
import '../mini_progress_bar.dart';

/// Top-anchored modal sheet that mirrors the React ModuleSelector:
/// a glass panel near the top of the screen with a list of modules.
class ModuleSelectorSheet extends StatelessWidget {
  final List<Module> modules;
  final int activeModuleIdx;
  final List<String> completedLessons;
  final ValueChanged<int> onSelect;

  const ModuleSelectorSheet({
    super.key,
    required this.modules,
    required this.activeModuleIdx,
    required this.completedLessons,
    required this.onSelect,
  });

  static Future<void> show({
    required BuildContext context,
    required List<Module> modules,
    required int activeModuleIdx,
    required List<String> completedLessons,
    required ValueChanged<int> onSelect,
  }) {
    return showGeneralDialog(
      context: context,
      barrierLabel: 'Select Module',
      barrierDismissible: true,
      barrierColor: const Color(0xFF0B0F19).withOpacity(0.8),
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (_, __, ___) => ModuleSelectorSheet(
        modules: modules,
        activeModuleIdx: activeModuleIdx,
        completedLessons: completedLessons,
        onSelect: onSelect,
      ),
      transitionBuilder: (ctx, anim, _, child) {
        final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, -0.04), end: Offset.zero).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final topPadding = media.padding.top + 64; // sits below the header bar

    return Stack(
      children: [
        // Tap-outside to close
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).maybePop(),
          ),
        ),
        Positioned(
          top: topPadding,
          left: 16,
          right: 16,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  // Material ancestor supplies a DefaultTextStyle so bare Text
                  // (e.g. the "MODULES" title) doesn\'t render with the yellow
                  // debug double-underline that showGeneralDialog leaves behind.
                  child: Material(
                    type: MaterialType.transparency,
                    child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 30, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                         
                          child: const Padding(
                          padding: EdgeInsets.only(bottom: 0),
                          child: Text(
                            'MODULES',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: media.size.height * 0.6),
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            physics: const BouncingScrollPhysics(),
                            itemCount: modules.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              return _ModuleRow(
                                module: modules[index],
                                isActive: index == activeModuleIdx,
                                progress: calculateModuleProgress(modules[index], completedLessons),
                                onTap: () {
                                  onSelect(index);
                                  Navigator.of(context).maybePop();
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ModuleRow extends StatelessWidget {
  final Module module;
  final bool isActive;
  final int progress;
  final VoidCallback onTap;

  const _ModuleRow({
    required this.module,
    required this.isActive,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isActive
                ? AppTheme.duoBlue.withOpacity(0.18)
                : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isActive ? AppTheme.duoBlue : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isActive ? AppTheme.duoBlue : const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  LucideIcons.bookOpen,
                  size: 22,
                  color: isActive ? Colors.white : const Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            module.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: isActive ? AppTheme.duoBlue : const Color(0xFFE2E8F0),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isActive)
                          const Icon(LucideIcons.check, size: 18, color: AppTheme.duoBlue),
                      ],
                    ),
                    if (module.description.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        module.description,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF64748B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 8),
                    MiniProgressBar(percentage: progress, height: 4, showText: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
