import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/generation_manager.dart';
import '../services/progress_service.dart';
import '../services/database_service.dart';
import '../widgets/missing_files_banner.dart';
import '../widgets/selectors/module_selector.dart';
import '../widgets/selectors/section_selector.dart';
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

  @override
  Widget build(BuildContext context) {
    if (widget.book.modules.isEmpty) {
      return const Center(child: Text("This book is empty.", style: TextStyle(color: Colors.white54)));
    }

    final mIdx = _activeModuleIdx.clamp(0, widget.book.modules.length - 1);
    final activeMod = widget.book.modules[mIdx];
    
    final sIdx = _activeSectionIdx.clamp(0, (activeMod.sections.length > 0 ? activeMod.sections.length : 1) - 1);
    final activeSec = activeMod.sections.isNotEmpty ? activeMod.sections[sIdx] : null;

    return Scaffold(
      body: Column(
        children: [
          if (_hasMissingFiles)
            MissingFilesBanner(book: widget.book),

          ModuleSelector(
            modules: widget.book.modules,
            activeModuleIdx: mIdx,
            onSelect: (i) => setState((){ _activeModuleIdx = i; _activeSectionIdx = 0; }),
          ),
          
          if (activeMod.sections.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SectionSelector(
                sections: activeMod.sections,
                activeSectionIdx: sIdx,
                onSelect: (i) => setState(() => _activeSectionIdx = i),
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