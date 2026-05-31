import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../models/app_models.dart';
import '../services/generation_manager.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/responsive_center.dart';

/// A screen to review and adjust page ranges for sections/units before generating the course.
class PdfSplitPreviewScreen extends StatefulWidget {
  final String taskId;
  final List<File> originalPdf;
  final Book skeletonBook;

  const PdfSplitPreviewScreen({
    super.key,
    required this.taskId,
    required this.originalPdf,
    required this.skeletonBook,
  });

  @override
  State<PdfSplitPreviewScreen> createState() => _PdfSplitPreviewScreenState();
}

class _PdfSplitPreviewScreenState extends State<PdfSplitPreviewScreen> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final PageController _imagePageController = PageController();
  
  late List<Module> _modules;
  bool _isPdf = false;
  int _currentImageIndex = 0;
  bool _isSectionLevel = false;

  final Map<String, TextEditingController> _startPageControllers = {};
  final Map<String, TextEditingController> _endPageControllers = {};
  final Map<String, TextEditingController> _titleControllers = {};

  String? _editingTitleId;

  @override
  void initState() {
    super.initState();
    _isPdf = widget.originalPdf.length == 1 && widget.originalPdf.first.path.toLowerCase().endsWith('.pdf');
    _modules = List.from(widget.skeletonBook.modules);
    
    // Determine if section-level or unit-level flow is used
    _isSectionLevel = widget.skeletonBook.modules.any(
      (m) => m.sections.any((s) => s.startPage != null || s.endPage != null),
    );

    _initControllers();
  }

  void _initControllers() {
    for (final module in _modules) {
      for (final section in module.sections) {
        if (_isSectionLevel) {
          _startPageControllers[section.id] = TextEditingController(text: section.startPage?.toString() ?? '');
          _endPageControllers[section.id] = TextEditingController(text: section.endPage?.toString() ?? '');
          _titleControllers[section.id] = TextEditingController(text: section.title);
        } else {
          for (final unit in section.units) {
            _startPageControllers[unit.id] = TextEditingController(text: unit.startPage?.toString() ?? '');
            _endPageControllers[unit.id] = TextEditingController(text: unit.endPage?.toString() ?? '');
            _titleControllers[unit.id] = TextEditingController(text: unit.title);
          }
        }
      }
    }
  }

  String _generateUniqueId(String prefix) {
    return '$prefix-${DateTime.now().microsecondsSinceEpoch}';
  }

  void _addSection(int moduleIndex) {
    setState(() {
      final newId = _generateUniqueId('sec');
      final newSec = Section(
        id: newId,
        title: 'New Section',
        description: 'Custom added section',
        color: 'duo-blue',
        units: [],
        startPage: null,
        endPage: null,
      );
      
      _startPageControllers[newId] = TextEditingController();
      _endPageControllers[newId] = TextEditingController();
      _titleControllers[newId] = TextEditingController(text: newSec.title);
      
      final updatedSections = List<Section>.from(_modules[moduleIndex].sections)..add(newSec);
      _modules[moduleIndex] = _modules[moduleIndex].copyWith(sections: updatedSections);
    });
  }

  void _removeSection(int moduleIndex, String sectionId) {
    setState(() {
      final updatedSections = List<Section>.from(_modules[moduleIndex].sections)
        ..removeWhere((s) => s.id == sectionId);
      _modules[moduleIndex] = _modules[moduleIndex].copyWith(sections: updatedSections);
      
      _startPageControllers.remove(sectionId)?.dispose();
      _endPageControllers.remove(sectionId)?.dispose();
      _titleControllers.remove(sectionId)?.dispose();
    });
  }

  void _addUnit(int moduleIndex, int sectionIndex) {
    setState(() {
      final newId = _generateUniqueId('unit');
      final newUnit = Unit(
        id: newId,
        title: 'New Unit',
        description: 'Custom added unit',
        isGenerated: false,
        lessons: [],
        startPage: null,
        endPage: null,
      );
      
      _startPageControllers[newId] = TextEditingController();
      _endPageControllers[newId] = TextEditingController();
      _titleControllers[newId] = TextEditingController(text: newUnit.title);
      
      final currentSection = _modules[moduleIndex].sections[sectionIndex];
      final updatedUnits = List<Unit>.from(currentSection.units)..add(newUnit);
      
      final updatedSections = List<Section>.from(_modules[moduleIndex].sections);
      updatedSections[sectionIndex] = currentSection.copyWith(units: updatedUnits);
      
      _modules[moduleIndex] = _modules[moduleIndex].copyWith(sections: updatedSections);
    });
  }

  void _removeUnit(int moduleIndex, int sectionIndex, String unitId) {
    setState(() {
      final currentSection = _modules[moduleIndex].sections[sectionIndex];
      final updatedUnits = List<Unit>.from(currentSection.units)
        ..removeWhere((u) => u.id == unitId);
      
      final updatedSections = List<Section>.from(_modules[moduleIndex].sections);
      updatedSections[sectionIndex] = currentSection.copyWith(units: updatedUnits);
      
      _modules[moduleIndex] = _modules[moduleIndex].copyWith(sections: updatedSections);
      
      _startPageControllers.remove(unitId)?.dispose();
      _endPageControllers.remove(unitId)?.dispose();
      _titleControllers.remove(unitId)?.dispose();
    });
  }

  void _removeModule(int moduleIndex) {
    setState(() {
      final module = _modules[moduleIndex];
      for (final section in module.sections) {
        if (_isSectionLevel) {
          _startPageControllers.remove(section.id)?.dispose();
          _endPageControllers.remove(section.id)?.dispose();
          _titleControllers.remove(section.id)?.dispose();
        } else {
          for (final unit in section.units) {
            _startPageControllers.remove(unit.id)?.dispose();
            _endPageControllers.remove(unit.id)?.dispose();
            _titleControllers.remove(unit.id)?.dispose();
          }
        }
      }
      _modules.removeAt(moduleIndex);
    });
  }

  void _saveTitle(String itemId, int moduleIndex, int? sectionIndex) {
    setState(() {
      final newTitle = _titleControllers[itemId]?.text ?? '';
      if (_isSectionLevel) {
        final module = _modules[moduleIndex];
        final updatedSections = module.sections.map((s) {
          if (s.id == itemId) {
            return s.copyWith(title: newTitle);
          }
          return s;
        }).toList();
        _modules[moduleIndex] = module.copyWith(sections: updatedSections);
      } else {
        if (sectionIndex != null) {
          final module = _modules[moduleIndex];
          final section = module.sections[sectionIndex];
          final updatedUnits = section.units.map((u) {
            if (u.id == itemId) {
              return u.copyWith(title: newTitle);
            }
            return u;
          }).toList();
          final updatedSections = List<Section>.from(module.sections);
          updatedSections[sectionIndex] = section.copyWith(units: updatedUnits);
          _modules[moduleIndex] = module.copyWith(sections: updatedSections);
        }
      }
      _editingTitleId = null;
    });
  }

  void _commitSplits() {
    List<Module> finalModules = [];

    for (var m = 0; m < _modules.length; m++) {
      final module = _modules[m];
      List<Section> finalSections = [];

      for (var s = 0; s < module.sections.length; s++) {
        final section = module.sections[s];

        if (_isSectionLevel) {
          final sPage = int.tryParse(_startPageControllers[section.id]?.text ?? '');
          final ePage = int.tryParse(_endPageControllers[section.id]?.text ?? '');
          final title = _titleControllers[section.id]?.text ?? section.title;

          finalSections.add(section.copyWith(
            title: title,
            startPage: sPage,
            endPage: ePage,
          ));
        } else {
          List<Unit> finalUnits = [];
          for (var u = 0; u < section.units.length; u++) {
            final unit = section.units[u];
            final sPage = int.tryParse(_startPageControllers[unit.id]?.text ?? '');
            final ePage = int.tryParse(_endPageControllers[unit.id]?.text ?? '');
            final title = _titleControllers[unit.id]?.text ?? unit.title;

            finalUnits.add(unit.copyWith(
              title: title,
              startPage: sPage,
              endPage: ePage,
            ));
          }
          finalSections.add(section.copyWith(units: finalUnits));
        }
      }
      finalModules.add(module.copyWith(sections: finalSections));
    }

    final offsetBook = widget.skeletonBook.copyWith(modules: finalModules);

    GenerationManager.instance.startBackgroundSplitAndSave(widget.taskId, widget.originalPdf, offsetBook);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    _imagePageController.dispose();
    for (var ctrl in _startPageControllers.values) {
      ctrl.dispose();
    }
    for (var ctrl in _endPageControllers.values) {
      ctrl.dispose();
    }
    for (var ctrl in _titleControllers.values) {
      ctrl.dispose();
    }
    super.dispose();
  }

  Widget _buildEditorRow({
    required String itemId,
    required String title,
    required String subtitle,
    required int moduleIndex,
    int? sectionIndex,
    required VoidCallback onDelete,
  }) {
    final isEditing = _editingTitleId == itemId;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isEditing)
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleControllers[itemId],
                          autofocus: true,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 6),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.duoBlue)),
                          ),
                          onSubmitted: (_) => _saveTitle(itemId, moduleIndex, sectionIndex),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.check, color: AppTheme.duoGreen, size: 16),
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(),
                        onPressed: () => _saveTitle(itemId, moduleIndex, sectionIndex),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.edit2, color: Colors.white38, size: 14),
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          setState(() {
                            _editingTitleId = itemId;
                          });
                        },
                      ),
                    ],
                  ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 9, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 50,
            child: TextField(
              controller: _startPageControllers[itemId],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              decoration: InputDecoration(
                labelText: 'Start',
                labelStyle: const TextStyle(fontSize: 9),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text('-', style: TextStyle(color: Colors.white54, fontSize: 12)),
          ),
          SizedBox(
            width: 50,
            child: TextField(
              controller: _endPageControllers[itemId],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              decoration: InputDecoration(
                labelText: 'End',
                labelStyle: const TextStyle(fontSize: 9),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(width: 4),
          IconButton(
            icon: const Icon(LucideIcons.eye, color: AppTheme.duoBlue, size: 16),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
            tooltip: 'View page',
            onPressed: () {
              int? p = int.tryParse(_startPageControllers[itemId]?.text ?? '');
              if (p != null) {
                if (_isPdf) {
                  _pdfViewerController.jumpToPage(p);
                } else if (p - 1 >= 0 && p - 1 < widget.originalPdf.length) {
                  _imagePageController.jumpToPage(p - 1);
                }
              }
            },
          ),
          IconButton(
            icon: const Icon(LucideIcons.trash2, color: AppTheme.duoRed, size: 16),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
            tooltip: 'Delete',
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> listItems = [];

    for (int m = 0; m < _modules.length; m++) {
      final module = _modules[m];
      
      // Module Header Card
      listItems.add(
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.duoBlue.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.duoBlue.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                const Icon(LucideIcons.bookOpen, color: AppTheme.duoBlue, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Module ${m + 1}: ${module.title}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.duoBlue),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(LucideIcons.trash2, color: AppTheme.duoRed, size: 16),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  tooltip: 'Delete Module',
                  onPressed: () => _removeModule(m),
                ),
              ],
            ),
          ),
        ),
      );

      for (int s = 0; s < module.sections.length; s++) {
        final section = module.sections[s];

        if (_isSectionLevel) {
          listItems.add(_buildEditorRow(
            itemId: section.id,
            title: section.title,
            subtitle: 'M${m + 1} • Section ${s + 1}',
            moduleIndex: m,
            sectionIndex: s,
            onDelete: () => _removeSection(m, section.id),
          ));
        } else {
          listItems.add(
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 6, left: 8),
              child: Row(
                children: [
                  const Icon(LucideIcons.layers, color: AppTheme.duoViolet, size: 14),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Section ${s + 1}: ${section.title}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white.withOpacity(0.7)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );

          for (int u = 0; u < section.units.length; u++) {
            final unit = section.units[u];
            listItems.add(_buildEditorRow(
              itemId: unit.id,
              title: unit.title,
              subtitle: 'M${m + 1} • S${s + 1} • Unit ${u + 1}',
              moduleIndex: m,
              sectionIndex: s,
              onDelete: () => _removeUnit(m, s, unit.id),
            ));
          }

          listItems.add(
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4, bottom: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => _addUnit(m, s),
                  icon: const Icon(LucideIcons.plus, size: 14, color: AppTheme.duoViolet),
                  label: const Text('Add Unit', style: TextStyle(color: AppTheme.duoViolet, fontSize: 11, fontWeight: FontWeight.bold)),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    backgroundColor: AppTheme.duoViolet.withOpacity(0.08),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ),
          );
        }
      }

      if (_isSectionLevel) {
        listItems.add(
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => _addSection(m),
                icon: const Icon(LucideIcons.plus, size: 14, color: AppTheme.duoBlue),
                label: const Text('Add Section', style: TextStyle(color: AppTheme.duoBlue, fontSize: 11, fontWeight: FontWeight.bold)),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  backgroundColor: AppTheme.duoBlue.withOpacity(0.08),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Review Page Splits', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18))),
      body: ResponsiveCenter(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white12, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  children: [
                    if (_isPdf)
                      SfPdfViewer.file(
                        widget.originalPdf.first,
                        controller: _pdfViewerController,
                        canShowScrollHead: false,
                        canShowScrollStatus: false,
                      )
                    else
                      PageView.builder(
                        controller: _imagePageController,
                        onPageChanged: (i) => setState(() => _currentImageIndex = i),
                        itemCount: widget.originalPdf.length,
                        itemBuilder: (context, index) => Image.file(widget.originalPdf[index], fit: BoxFit.contain),
                      ),
                    
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.surface.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Row(
                          children: [
                            Icon(_isPdf ? LucideIcons.fileText : LucideIcons.image, size: 14, color: Colors.white54),
                            const SizedBox(width: 8),
                            Text(
                              _isPdf ? 'Use Viewer to find exact page #' : 'Image ${_currentImageIndex + 1} of ${widget.originalPdf.length}', 
                              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, -4))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 24, right: 24, bottom: 8),
                      child: Text(
                        _isSectionLevel ? 'Adjust Section Ranges' : 'Adjust Unit Ranges',
                        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        children: listItems,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DuoButton(
                        text: 'Confirm & Split Course',
                        color: AppTheme.duoGreen,
                        shadowColor: AppTheme.duoGreenDark,
                        onPressed: _commitSplits,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}