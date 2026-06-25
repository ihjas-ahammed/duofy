import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/app_models.dart';
import '../../utils/progress_utils.dart';
import '../mini_progress_bar.dart';

/// Bottom-sheet section selector that mirrors the React SectionSelector:
/// rounded-t-3xl glass sheet with drag handle, big cards per section,
/// border-b-4 in the section's color when active, and a MiniProgressBar.
class SectionBottomSheet extends StatefulWidget {
  final Book book;
  final int activeModuleIdx;
  final int activeSectionIdx;
  final List<String> completedLessons;
  final Function(int moduleIdx, int sectionIdx) onSelect;
  final Function(int moduleIdx, int sectionIdx)? onSectionLongPress;

  const SectionBottomSheet({
    super.key,
    required this.book,
    required this.activeModuleIdx,
    required this.activeSectionIdx,
    required this.completedLessons,
    required this.onSelect,
    this.onSectionLongPress,
  });

  @override
  State<SectionBottomSheet> createState() => _SectionBottomSheetState();
}

class _SectionBottomSheetState extends State<SectionBottomSheet> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToActiveSection();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToActiveSection() {
    if (!mounted) return;
    final sections = (widget.book.modules.isNotEmpty && widget.activeModuleIdx < widget.book.modules.length)
        ? widget.book.modules[widget.activeModuleIdx].sections
        : <Section>[];
    if (sections.isEmpty) return;

    final index = widget.activeSectionIdx;
    if (index > 0 && _scrollController.hasClients) {
      double targetOffset = 40.0; // Height offset before the first card (title + top padding)
      for (int i = 0; i < index; i++) {
        final sec = sections[i];
        final cardHeight = sec.description.isNotEmpty ? 82.0 : 64.0;
        targetOffset += cardHeight;
      }

      final maxScroll = _scrollController.position.maxScrollExtent;
      final double clampedOffset = targetOffset.clamp(0.0, maxScroll);

      _scrollController.animateTo(
        clampedOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final sections = (widget.book.modules.isNotEmpty && widget.activeModuleIdx < widget.book.modules.length)
        ? widget.book.modules[widget.activeModuleIdx].sections
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
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white.withOpacity(0.05)),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 48,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFF475569),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: Text(
                            'Sections',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        for (int i = 0; i < sections.length; i++) ...[
                          _SectionCard(
                            section: sections[i],
                            isActive: i == widget.activeSectionIdx,
                            progress: calculateSectionProgress(sections[i], widget.completedLessons),
                            onTap: () {
                              widget.onSelect(widget.activeModuleIdx, i);
                              Navigator.of(context).maybePop();
                            },
                            onLongPress: widget.onSectionLongPress == null
                                ? null
                                : () {
                                    Navigator.of(context).maybePop();
                                    widget.onSectionLongPress!(widget.activeModuleIdx, i);
                                  },
                          ),
                          if (i != sections.length - 1) const SizedBox(height: 8),
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
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8 + media.padding.bottom),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.of(context).maybePop(),
                      borderRadius: BorderRadius.circular(12),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: Text(
                            'CLOSE',
                            style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                              letterSpacing: 1.2,
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
  final VoidCallback? onLongPress;

  const _SectionCard({
    required this.section,
    required this.isActive,
    required this.progress,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final color = SectionColors.base(section.color);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isActive ? color.withOpacity(0.2) :  Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1.5),
              left: BorderSide(color: Colors.white.withOpacity(0.1), width: 1.5),
              right: BorderSide(color: Colors.white.withOpacity(0.1), width: 1.5),
              bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 3),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                            fontSize: 14,
                          ),
                        ),
                        if (section.description.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            section.description,
                            style: TextStyle(
                              color: isActive ? Colors.white.withOpacity(0.8) : const Color(0xFF64748B),
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.white.withOpacity(0.1)
                          : Colors.white.withOpacity(0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LucideIcons.chevronRight,
                      size: 16,
                      color: isActive ? Colors.white : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              MiniProgressBar(percentage: progress, height: 4, showText: false),
            ],
          ),
        ),
      ),
    );
  }
}
