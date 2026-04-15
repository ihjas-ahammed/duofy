import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/generation_manager.dart';
import '../services/progress_service.dart';
import '../services/database_service.dart';
import '../widgets/missing_files_banner.dart';
import '../widgets/bottom_sheets/section_bottom_sheet.dart';
import '../widgets/lesson_path.dart';

class BookDashboardScreen extends StatefulWidget {
  final Book book;
  final Function(Book) onBookUpdated;

  const BookDashboardScreen({
    super.key, 
    required this.book,
    required this.onBookUpdated
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
    for (var m in widget.book.modules) {
      for (var s in m.sections) {
        for (var u in s.units) {
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
    if (mounted) {
      setState(() => _completedLessons = comp);
    }
  }

  void _onClearUnit(Unit unit, int modIdx, int secIdx, int unitIdx) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Regenerate Unit?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text('This will permanently delete the AI-generated lessons for this unit, allowing you to generate it fresh.', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx), 
            child: const Text('Cancel', style: TextStyle(color: Colors.white54))
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
            child: const Text('Regenerate', style: TextStyle(color: AppTheme.duoOrange, fontWeight: FontWeight.bold))
          )
        ],
      )
    );
  }

  void _showModuleSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          border: Border.all(color: Colors.white10, width: 1),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 20),
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const Text(
              'SELECT MODULE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 16,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: widget.book.modules.length,
                itemBuilder: (context, index) {
                  final m = widget.book.modules[index];
                  final isActive = _activeModuleIdx == index;
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                         _activeModuleIdx = index;
                         _activeSectionIdx = 0; // reset sections
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isActive ? AppTheme.duoBlue.withOpacity(0.15) : AppTheme.surface.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isActive ? AppTheme.duoBlue : Colors.white10,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(LucideIcons.bookOpen, color: isActive ? AppTheme.duoBlue : Colors.white54, size: 24),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  m.title,
                                  style: TextStyle(
                                    color: isActive ? AppTheme.duoBlue : Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                if (m.description.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    m.description,
                                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ]
                              ],
                            ),
                          ),
                          if (isActive)
                            const Icon(LucideIcons.checkCircle2, color: AppTheme.duoBlue),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.book.modules.isEmpty) {
      return const Center(child: Text("This book is empty.", style: TextStyle(color: Colors.white54)));
    }

    final mIdx = _activeModuleIdx.clamp(0, widget.book.modules.length - 1);
    final activeMod = widget.book.modules[mIdx];
    
    final sIdx = _activeSectionIdx.clamp(0, (activeMod.sections.isNotEmpty ? activeMod.sections.length : 1) - 1);
    final activeSec = activeMod.sections.isNotEmpty ? activeMod.sections[sIdx] : null;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.surface.withOpacity(0.6),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              border: Border.all(color: Colors.white10, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (Navigator.canPop(context))
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Padding(
                            padding: EdgeInsets.only(right: 12.0),
                            child: Icon(LucideIcons.arrowLeft, color: Colors.white70, size: 24),
                          ),
                        ),
                      Expanded(
                        child: GestureDetector(
                          onTap: _showModuleSelector,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    const Icon(LucideIcons.bookOpen, color: AppTheme.duoBlue, size: 24),
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
                                        child: const Icon(LucideIcons.chevronDown, size: 10, color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    activeMod.title.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      letterSpacing: 0.5,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // XP display exactly like dashboard
                FutureBuilder<int>(
                   future: ProgressService.getXp(),
                   builder: (context, snapshot) {
                      final xp = snapshot.data ?? 0;
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(LucideIcons.zap, size: 16, color: Color(0xFFFBBF24)), // amber-400
                            const SizedBox(width: 4),
                            Text(
                              '$xp XP',
                              style: const TextStyle(
                                color: Color(0xFFFBBF24),
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      );
                   }
                )
              ],
            ),
          )
        ),
      ),
      body: Column(
        children: [
          if (_hasMissingFiles)
            MissingFilesBanner(book: widget.book),

          if (activeSec != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => FractionallySizedBox(
                      heightFactor: 0.85,
                      child: SectionBottomSheet(
                        book: widget.book,
                        activeModuleIdx: mIdx,
                        activeSectionIdx: sIdx,
                        onSelect: (modIdx, secIdx) {
                          setState(() {
                            _activeModuleIdx = modIdx;
                            _activeSectionIdx = secIdx;
                          });
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.duoBlue, 
                      width: 2
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          activeSec.title.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(LucideIcons.chevronDown, color: Colors.white54, size: 20),
                    ],
                  ),
                ),
              ),
            ),

          Expanded(
            child: AnimatedBuilder(
              animation: GenerationManager.instance,
              builder: (context, _) {
                if (activeSec == null) {
                  return const Center(child: Text('No sections available.', style: TextStyle(color: Colors.white54)));
                }

                return LessonPath(
                  section: activeSec,
                  loadingUnitStatuses: GenerationManager.instance.activeUnitGenerations,
                  completedLessons: _completedLessons,
                  onLessonFinished: _loadProgress,
                  onGenerateUnit: (unit, unitIdx) {
                    GenerationManager.instance.startUnitGeneration(unit, widget.book, mIdx, sIdx, unitIdx);
                  },
                  onClearUnit: (unit, unitIdx) {
                    _onClearUnit(unit, mIdx, sIdx, unitIdx);
                  },
                );
              }
            )
          ),
        ],
      ),
    );
  }
}