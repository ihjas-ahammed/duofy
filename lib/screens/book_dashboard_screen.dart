import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/lesson_path.dart';
import '../services/generation_manager.dart';
import '../services/progress_service.dart';
import '../services/database_service.dart';

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
  int currentModuleIdx = 0;
  int currentSectionIdx = 0;
  List<String> _completedLessons = [];

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final comp = await ProgressService.getCompletedLessons();
    if (mounted) {
      setState(() => _completedLessons = comp);
    }
  }

  void _onClearUnit(Unit unit, int unitIdx) {
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
              final List<Unit> updatedUnits = List.from(widget.book.modules[currentModuleIdx].sections[currentSectionIdx].units);
              updatedUnits[unitIdx] = unit.copyWith(isGenerated: false, lessons: []);
              
              final List<Section> updatedSecs = List.from(widget.book.modules[currentModuleIdx].sections);
              updatedSecs[currentSectionIdx] = updatedSecs[currentSectionIdx].copyWith(units: updatedUnits);

              final List<Module> updatedMods = List.from(widget.book.modules);
              updatedMods[currentModuleIdx] = updatedMods[currentModuleIdx].copyWith(sections: updatedSecs);

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

  void _showHierarchySelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return AppTheme.applyGlassBlur(
          borderRadius: 24,
          child: Container(
            padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('COURSE STRUCTURE', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white54, letterSpacing: 1.5)),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.book.modules.length,
                    itemBuilder: (ctx, mIdx) {
                      final m = widget.book.modules[mIdx];
                      final bool isModuleActive = mIdx == currentModuleIdx;
                      
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: isModuleActive ? Colors.white.withOpacity(0.05) : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: isModuleActive ? Colors.white24 : Colors.transparent),
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            initiallyExpanded: isModuleActive,
                            iconColor: AppTheme.duoBlue,
                            collapsedIconColor: Colors.white54,
                            leading: Icon(LucideIcons.folder, color: isModuleActive ? AppTheme.duoBlue : Colors.white54),
                            title: Text(
                              m.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold, 
                                color: isModuleActive ? Colors.white : Colors.white70
                              ),
                            ),
                            children: m.sections.asMap().entries.map((entry) {
                              final sIdx = entry.key;
                              final s = entry.value;
                              final isSectionActive = isModuleActive && sIdx == currentSectionIdx;
                              
                              return Padding(
                                padding: const EdgeInsets.only(left: 32, right: 8, bottom: 8),
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      currentModuleIdx = mIdx;
                                      currentSectionIdx = sIdx;
                                    });
                                    Navigator.pop(ctx);
                                  },
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  tileColor: isSectionActive ? AppTheme.duoBlue.withOpacity(0.2) : Colors.transparent,
                                  title: Text(
                                    s.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold, 
                                      color: isSectionActive ? AppTheme.duoBlue : Colors.white
                                    ),
                                  ),
                                  trailing: isSectionActive 
                                    ? const Icon(LucideIcons.checkCircle2, color: AppTheme.duoBlue, size: 20)
                                    : null,
                                ),
                              );
                            }).toList(),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.book.modules.isEmpty) {
      return const Center(child: Text("This book is empty."));
    }

    final module = widget.book.modules[currentModuleIdx];
    final section = module.sections[currentSectionIdx];

    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: _showHierarchySelector,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: AppTheme.glassDecoration.copyWith(
                border: const Border(bottom: BorderSide(color: AppTheme.duoBlue, width: 4)),
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.book, color: AppTheme.duoBlue, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          module.title.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 10, color: Colors.white54, letterSpacing: 1.2),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          section.title,
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Icon(LucideIcons.chevronDown, color: Colors.white54, size: 20),
                ],
              ),
            ),
          ),
          
          Expanded(
            child: AnimatedBuilder(
              animation: GenerationManager.instance,
              builder: (context, _) {
                return LessonPath(
                  section: section,
                  loadingUnitStatuses: GenerationManager.instance.activeUnitGenerations,
                  completedLessons: _completedLessons,
                  onLessonFinished: _loadProgress,
                  onClearUnit: _onClearUnit,
                  onGenerateUnit: (unit, unitIdx) {
                    GenerationManager.instance.startUnitGeneration(
                      unit, widget.book, currentModuleIdx, currentSectionIdx, unitIdx
                    );
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