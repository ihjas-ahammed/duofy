import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/lesson_path.dart';
import '../services/ai_service.dart';
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

  final Set<String> _generatingUnits = {};
  final AiService _aiService = AiService();
  final DatabaseService _dbService = DatabaseService();

  Future<void> _handleGenerateUnit(Unit unit, int modIdx, int secIdx, int unitIdx) async {
    setState(() => _generatingUnits.add(unit.id));
    
    try {
      final updatedUnit = await _aiService.generateUnitContent(unit, widget.book);
      
      final List<Unit> updatedUnits = List.from(widget.book.modules[modIdx].sections[secIdx].units);
      updatedUnits[unitIdx] = updatedUnit;
      
      final List<Section> updatedSections = List.from(widget.book.modules[modIdx].sections);
      updatedSections[secIdx] = updatedSections[secIdx].copyWith(units: updatedUnits);

      final List<Module> updatedModules = List.from(widget.book.modules);
      updatedModules[modIdx] = updatedModules[modIdx].copyWith(sections: updatedSections);

      final newBook = widget.book.copyWith(modules: updatedModules);

      await _dbService.saveGeneratedBook(newBook);
      widget.onBookUpdated(newBook);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Unit Generated Successfully!')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error generating: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _generatingUnits.remove(unit.id));
      }
    }
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
            child: LessonPath(
              section: section,
              loadingUnitIds: _generatingUnits,
              onGenerateUnit: (unit, unitIdx) {
                _handleGenerateUnit(unit, currentModuleIdx, currentSectionIdx, unitIdx);
              },
            )
          ),
        ],
      ),
    );
  }
}