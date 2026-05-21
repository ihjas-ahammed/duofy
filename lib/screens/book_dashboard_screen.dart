import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/generation_manager.dart';
import '../services/progress_service.dart';
import '../services/database_service.dart';
import '../utils/progress_utils.dart';
import '../widgets/missing_files_banner.dart';
import '../widgets/bottom_sheets/section_bottom_sheet.dart';
import '../widgets/selectors/module_selector.dart';
import '../widgets/lesson_path.dart';

class BookDashboardScreen extends StatefulWidget {
  final Book book;
  final Function(Book) onBookUpdated;

  const BookDashboardScreen({
    super.key,
    required this.book,
    required this.onBookUpdated,
  });

  @override
  State<BookDashboardScreen> createState() => _BookDashboardScreenState();
}

class _BookDashboardScreenState extends State<BookDashboardScreen> {
  List<String> _completedLessons = [];
  bool _hasMissingFiles = false;

  int _activeModuleIdx = 0;
  int _activeSectionIdx = 0;

  @override
  void initState() {
    super.initState();
    _loadProgress();
    _checkMissingFiles();
  }

  @override
  void didUpdateWidget(BookDashboardScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.book.id != widget.book.id || oldWidget.book.updatedAt != widget.book.updatedAt) {
      _checkMissingFiles();
    }
  }

  Future<void> _checkMissingFiles() async {
    bool missing = false;
    for (final m in widget.book.modules) {
      for (final s in m.sections) {
        for (final u in s.units) {
          if (u.startPage != null && u.endPage != null) {
            if (u.pdfPath == null || !File(u.pdfPath!).existsSync()) {
              missing = true;
              break;
            }
          }
        }
        if (missing) break;
      }
      if (missing) break;
    }
    if (mounted) setState(() => _hasMissingFiles = missing);
  }

  Future<void> _loadProgress() async {
    final comp = await ProgressService.getCompletedLessons();
    if (mounted) setState(() => _completedLessons = comp);
  }

  void _onClearUnit(Unit unit, int modIdx, int secIdx, int unitIdx) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Regenerate Unit?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text(
          'This will permanently delete the AI-generated lessons for this unit, allowing you to generate it fresh.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final List<Unit> updatedUnits = List.from(widget.book.modules[modIdx].sections[secIdx].units);
              updatedUnits[unitIdx] = unit.copyWith(isGenerated: false, lessons: []);

              final List<Section> updatedSecs = List.from(widget.book.modules[modIdx].sections);
              updatedSecs[secIdx] = updatedSecs[secIdx].copyWith(units: updatedUnits);

              final List<Module> updatedMods = List.from(widget.book.modules);
              updatedMods[modIdx] = updatedMods[modIdx].copyWith(sections: updatedSecs);

              final newBook = widget.book.copyWith(modules: updatedMods);
              await DatabaseService().saveGeneratedBook(newBook);
              widget.onBookUpdated(newBook);
            },
            child: const Text('Regenerate', style: TextStyle(color: AppTheme.duoOrange, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _openModuleSelector() {
    ModuleSelectorSheet.show(
      context: context,
      modules: widget.book.modules,
      activeModuleIdx: _activeModuleIdx,
      completedLessons: _completedLessons,
      onSelect: (idx) {
        setState(() {
          _activeModuleIdx = idx;
          _activeSectionIdx = 0;
        });
      },
    );
  }

  void _openSectionSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.85,
        child: SectionBottomSheet(
          book: widget.book,
          activeModuleIdx: _activeModuleIdx,
          activeSectionIdx: _activeSectionIdx,
          completedLessons: _completedLessons,
          onSelect: (modIdx, secIdx) {
            setState(() {
              _activeModuleIdx = modIdx;
              _activeSectionIdx = secIdx;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.book.modules.isEmpty) {
      return const Scaffold(
        backgroundColor: AppTheme.background,
        body: Center(child: Text('This book is empty.', style: TextStyle(color: Colors.white54))),
      );
    }

    final mIdx = _activeModuleIdx.clamp(0, widget.book.modules.length - 1);
    final activeMod = widget.book.modules[mIdx];

    final sectionsCount = activeMod.sections.length;
    final sIdx = sectionsCount == 0 ? 0 : _activeSectionIdx.clamp(0, sectionsCount - 1);
    final activeSec = sectionsCount > 0 ? activeMod.sections[sIdx] : null;

    final Color sectionColor =
        activeSec != null ? SectionColors.base(activeSec.color) : AppTheme.duoBlue;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Lesson path content
          Positioned.fill(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 72),
                if (_hasMissingFiles) MissingFilesBanner(book: widget.book),
                Expanded(
                  child: AnimatedBuilder(
                    animation: GenerationManager.instance,
                    builder: (context, _) {
                      if (activeSec == null) {
                        return const Center(
                          child: Text('No sections available.', style: TextStyle(color: Colors.white54)),
                        );
                      }
                      return LessonPath(
                        section: activeSec,
                        loadingUnitStatuses: GenerationManager.instance.activeUnitGenerations,
                        completedLessons: _completedLessons,
                        onLessonFinished: _loadProgress,
                        onGenerateUnit: (unit, unitIdx) {
                          GenerationManager.instance.startUnitGeneration(
                            unit, widget.book, mIdx, sIdx, unitIdx,
                          );
                        },
                        onClearUnit: (unit, unitIdx) {
                          _onClearUnit(unit, mIdx, sIdx, unitIdx);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Floating glass header bar (matches React: glass-panel rounded-b-2xl)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.03),
                            border: Border(
                              left: BorderSide(color: Colors.white.withOpacity(0.08)),
                              right: BorderSide(color: Colors.white.withOpacity(0.08)),
                              bottom: BorderSide(color: Colors.white.withOpacity(0.08)),
                            ),
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 30, offset: const Offset(0, 4)),
                            ],
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              // Module book icon with chevron badge
                              _IconHeaderButton(
                                onTap: _openModuleSelector,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    const Icon(LucideIcons.bookOpen, color: AppTheme.duoBlue, size: 26),
                                    Positioned(
                                      bottom: -4,
                                      right: -4,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF1E293B),
                                          shape: BoxShape.circle,
                                          border: Border.all(color: const Color(0xFF475569), width: 1),
                                        ),
                                        child: const Icon(LucideIcons.chevronDown, size: 10, color: Color(0xFFCBD5E1)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),

                              // Section pill — flex-grow, border-b-2 in section color
                              if (activeSec != null)
                                Expanded(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: _openSectionSelector,
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.05),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border(
                                            bottom: BorderSide(color: sectionColor, width: 2),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                activeSec.title.toUpperCase(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w900,
                                                  letterSpacing: 1.6,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            const Icon(LucideIcons.chevronDown, size: 16, color: Color(0xFFCBD5E1)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              else
                                const Expanded(child: SizedBox.shrink()),
                              const SizedBox(width: 8),

                              // XP chip
                              FutureBuilder<int>(
                                future: ProgressService.getXp(),
                                builder: (context, snapshot) {
                                  final xp = snapshot.data ?? 0;
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(LucideIcons.zap, size: 14, color: Color(0xFFFBBF24)),
                                        const SizedBox(width: 4),
                                        Text(
                                          '$xp',
                                          style: const TextStyle(
                                            color: Color(0xFFFBBF24),
                                            fontWeight: FontWeight.w900,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
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
          ),
        ],
      ),
    );
  }
}

class _IconHeaderButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const _IconHeaderButton({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: child,
        ),
      ),
    );
  }
}
