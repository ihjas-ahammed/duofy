import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/app_models.dart';
import '../../utils/progress_utils.dart';
import '../mini_progress_bar.dart';

/// Bottom-sheet section selector that mirrors the React SectionSelector:
/// rounded-t-3xl glass sheet with drag handle, big cards per section,
/// border-b-4 in the section's color when active, and a MiniProgressBar.
class SectionBottomSheet extends StatelessWidget {
  final Book book;
  final int activeModuleIdx;
  final int activeSectionIdx;
  final List<String> completedLessons;
  final Function(int moduleIdx, int sectionIdx) onSelect;

  const SectionBottomSheet({
    super.key,
    required this.book,
    required this.activeModuleIdx,
    required this.activeSectionIdx,
    required this.completedLessons,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final sections = (book.modules.isNotEmpty && activeModuleIdx < book.modules.length)
        ? book.modules[activeModuleIdx].sections
        : <Section>[];

    return Padding(
      padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white.withOpacity(0.05)),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 48,
                      height: 6,
                      decoration: BoxDecoration(
                        color: const Color(0xFF475569),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 24),
                          child: Text(
                            'Sections',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        for (int i = 0; i < sections.length; i++) ...[
                          _SectionCard(
                            section: sections[i],
                            isActive: i == activeSectionIdx,
                            progress: calculateSectionProgress(sections[i], completedLessons),
                            onTap: () {
                              onSelect(activeModuleIdx, i);
                              Navigator.of(context).maybePop();
                            },
                          ),
                          if (i != sections.length - 1) const SizedBox(height: 16),
                        ],
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    border: Border(
                      top: BorderSide(color: Colors.white.withOpacity(0.05)),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(16, 12, 16, 12 + media.padding.bottom),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.of(context).maybePop(),
                      borderRadius: BorderRadius.circular(12),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: Text(
                            'CLOSE',
                            style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontWeight: FontWeight.w900,
                              fontSize: 13,
                              letterSpacing: 1.4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final Section section;
  final bool isActive;
  final int progress;
  final VoidCallback onTap;

  const _SectionCard({
    required this.section,
    required this.isActive,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = SectionColors.base(section.color);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isActive ? color.withOpacity(0.2) : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(isActive ? 0 : 0.1), width: 2),
              left: BorderSide(color: Colors.white.withOpacity(isActive ? 0 : 0.1), width: 2),
              right: BorderSide(color: Colors.white.withOpacity(isActive ? 0 : 0.1), width: 2),
              bottom: BorderSide(color: isActive ? color : Colors.white.withOpacity(0.1), width: 4),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          section.title,
                          style: TextStyle(
                            color: isActive ? Colors.white : const Color(0xFFCBD5E1),
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                          ),
                        ),
                        if (section.description.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            section.description,
                            style: TextStyle(
                              color: isActive ? Colors.white.withOpacity(0.8) : const Color(0xFF64748B),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.white.withOpacity(0.1)
                          : Colors.white.withOpacity(0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LucideIcons.chevronRight,
                      size: 22,
                      color: isActive ? Colors.white : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              MiniProgressBar(percentage: progress, height: 6, showText: false),
            ],
          ),
        ),
      ),
    );
  }
}
