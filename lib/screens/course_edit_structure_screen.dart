import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:file_picker/file_picker.dart';
import '../models/app_models.dart';
import '../services/generation_manager.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/responsive_center.dart';

class CourseEditStructureScreen extends StatefulWidget {
  final Book book;
  final void Function(Book) onBookUpdated;

  const CourseEditStructureScreen({
    super.key,
    required this.book,
    required this.onBookUpdated,
  });

  @override
  State<CourseEditStructureScreen> createState() => _CourseEditStructureScreenState();
}

class _CourseEditStructureScreenState extends State<CourseEditStructureScreen> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  
  late List<Module> _modules;
  bool _isSectionLevel = false;
  File? _uploadedPdf;
  bool _showPdfPreview = false;

  final Map<String, TextEditingController> _startPageControllers = {};
  final Map<String, TextEditingController> _endPageControllers = {};
  final Map<String, TextEditingController> _titleControllers = {};
  
  late TextEditingController _bookTitleController;
  late TextEditingController _bookDescController;

  String? _editingTitleId;

  @override
  void initState() {
    super.initState();
    _modules = List.from(widget.book.modules);
    
    // Determine if section-level or unit-level flow is used
    _isSectionLevel = widget.book.modules.any(
      (m) => m.sections.any((s) => s.startPage != null || s.endPage != null),
    );

    _bookTitleController = TextEditingController(text: widget.book.title);
    _bookDescController = TextEditingController(text: widget.book.description);

    _initControllers();
  }

  void _initControllers() {
    for (final module in _modules) {
      _titleControllers[module.id] = TextEditingController(text: module.title);
      for (final section in module.sections) {
        _titleControllers[section.id] = TextEditingController(text: section.title);
        if (_isSectionLevel) {
          _startPageControllers[section.id] = TextEditingController(text: section.startPage?.toString() ?? '');
          _endPageControllers[section.id] = TextEditingController(text: section.endPage?.toString() ?? '');
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

  @override
  void dispose() {
    _pdfViewerController.dispose();
    _bookTitleController.dispose();
    _bookDescController.dispose();
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

  String _generateUniqueId(String prefix) {
    return '$prefix-${DateTime.now().microsecondsSinceEpoch}';
  }

  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _uploadedPdf = File(result.files.single.path!);
        _showPdfPreview = true;
      });
    }
  }

  void _addModule() {
    setState(() {
      final newId = _generateUniqueId('mod');
      final newMod = Module(
        id: newId,
        title: 'New Module',
        description: 'Custom added module',
        sections: [],
        practiceQuestions: [],
      );
      _titleControllers[newId] = TextEditingController(text: newMod.title);
      _modules.add(newMod);
    });
  }

  void _removeModule(int moduleIndex) {
    setState(() {
      final module = _modules[moduleIndex];
      _titleControllers.remove(module.id)?.dispose();
      for (final section in module.sections) {
        _titleControllers.remove(section.id)?.dispose();
        _startPageControllers.remove(section.id)?.dispose();
        _endPageControllers.remove(section.id)?.dispose();
        for (final unit in section.units) {
          _titleControllers.remove(unit.id)?.dispose();
          _startPageControllers.remove(unit.id)?.dispose();
          _endPageControllers.remove(unit.id)?.dispose();
        }
      }
      _modules.removeAt(moduleIndex);
    });
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
      
      _titleControllers[newId] = TextEditingController(text: newSec.title);
      if (_isSectionLevel) {
        _startPageControllers[newId] = TextEditingController();
        _endPageControllers[newId] = TextEditingController();
      }
      
      final updatedSections = List<Section>.from(_modules[moduleIndex].sections)..add(newSec);
      _modules[moduleIndex] = _modules[moduleIndex].copyWith(sections: updatedSections);
    });
  }

  void _removeSection(int moduleIndex, String sectionId) {
    setState(() {
      final updatedSections = List<Section>.from(_modules[moduleIndex].sections)
        ..removeWhere((s) => s.id == sectionId);
      _modules[moduleIndex] = _modules[moduleIndex].copyWith(sections: updatedSections);
      
      _titleControllers.remove(sectionId)?.dispose();
      _startPageControllers.remove(sectionId)?.dispose();
      _endPageControllers.remove(sectionId)?.dispose();
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
      
      _titleControllers[newId] = TextEditingController(text: newUnit.title);
      _startPageControllers[newId] = TextEditingController();
      _endPageControllers[newId] = TextEditingController();
      
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
      
      _titleControllers.remove(unitId)?.dispose();
      _startPageControllers.remove(unitId)?.dispose();
      _endPageControllers.remove(unitId)?.dispose();
    });
  }

  void _saveTitle(String itemId, int moduleIndex, int? sectionIndex, String type) {
    setState(() {
      final newTitle = _titleControllers[itemId]?.text ?? '';
      if (type == 'module') {
        _modules[moduleIndex] = _modules[moduleIndex].copyWith(title: newTitle);
      } else if (type == 'section') {
        final module = _modules[moduleIndex];
        final updatedSections = module.sections.map((s) {
          if (s.id == itemId) return s.copyWith(title: newTitle);
          return s;
        }).toList();
        _modules[moduleIndex] = module.copyWith(sections: updatedSections);
      } else if (type == 'unit' && sectionIndex != null) {
        final module = _modules[moduleIndex];
        final section = module.sections[sectionIndex];
        final updatedUnits = section.units.map((u) {
          if (u.id == itemId) return u.copyWith(title: newTitle);
          return u;
        }).toList();
        final updatedSections = List<Section>.from(module.sections);
        updatedSections[sectionIndex] = section.copyWith(units: updatedUnits);
        _modules[moduleIndex] = module.copyWith(sections: updatedSections);
      }
      _editingTitleId = null;
    });
  }

  Future<void> _saveChanges() async {
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
          finalSections.add(section.copyWith(
            title: _titleControllers[section.id]?.text ?? section.title,
            units: finalUnits,
          ));
        }
      }
      finalModules.add(module.copyWith(
        title: _titleControllers[module.id]?.text ?? module.title,
        sections: finalSections,
      ));
    }

    final updatedBook = widget.book.copyWith(
      title: _bookTitleController.text.trim().isEmpty ? widget.book.title : _bookTitleController.text.trim(),
      description: _bookDescController.text.trim(),
      modules: finalModules,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    if (_uploadedPdf != null) {
      await GenerationManager.instance.restoreBookFiles(updatedBook, [_uploadedPdf!]);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Re-splitting pages and saving course in background...')),
        );
        Navigator.pop(context);
      }
    } else {
      await DatabaseService().saveGeneratedBook(updatedBook);
      GenerationManager.instance.triggerBookUpdate(updatedBook);
      widget.onBookUpdated(updatedBook);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Course details saved.')),
        );
        Navigator.pop(context);
      }
    }
  }

  Widget _buildEditorRow({
    required String itemId,
    required String title,
    required String subtitle,
    required int moduleIndex,
    int? sectionIndex,
    required String type,
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
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 6),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.duoBlue)),
                          ),
                          onSubmitted: (_) => _saveTitle(itemId, moduleIndex, sectionIndex, type),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.check, color: AppTheme.duoGreen, size: 16),
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(),
                        onPressed: () => _saveTitle(itemId, moduleIndex, sectionIndex, type),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
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
          if ((type == 'section' && _isSectionLevel) || (type == 'unit' && !_isSectionLevel)) ...[
            SizedBox(
              width: 50,
              child: TextField(
                controller: _startPageControllers[itemId],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Start',
                  labelStyle: const TextStyle(fontSize: 9, color: Colors.white54),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.white24)),
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
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'End',
                  labelStyle: const TextStyle(fontSize: 9, color: Colors.white54),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.white24)),
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
                if (_uploadedPdf == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please upload the source PDF to preview pages.')),
                  );
                  return;
                }
                int? p = int.tryParse(_startPageControllers[itemId]?.text ?? '');
                if (p != null) {
                  _pdfViewerController.jumpToPage(p);
                }
              },
            ),
          ],
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

    // Course metadata inputs
    listItems.add(
      Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Course General Settings',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Colors.white),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bookTitleController,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              decoration: InputDecoration(
                labelText: 'Course Title',
                labelStyle: const TextStyle(color: Colors.white54, fontSize: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.white24)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bookDescController,
              maxLines: 2,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                labelText: 'Course Description',
                labelStyle: const TextStyle(color: Colors.white54, fontSize: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.white24)),
              ),
            ),
          ],
        ),
      ),
    );

    // PDF Source uploader
    listItems.add(
      Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _uploadedPdf != null ? AppTheme.duoGreen.withOpacity(0.08) : AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _uploadedPdf != null ? AppTheme.duoGreen.withOpacity(0.3) : Colors.white12,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  _uploadedPdf != null ? LucideIcons.fileCheck : LucideIcons.fileWarning,
                  color: _uploadedPdf != null ? AppTheme.duoGreen : AppTheme.duoOrange,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _uploadedPdf != null ? 'Source PDF Loaded' : 'No Source PDF Loaded',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        _uploadedPdf != null
                            ? _uploadedPdf!.path.split(Platform.pathSeparator).last
                            : 'Upload source PDF to preview pages and split component files.',
                        style: const TextStyle(color: Colors.white54, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DuoButton(
                    text: _uploadedPdf != null ? 'Change PDF' : 'Upload Source PDF',
                    color: AppTheme.surface,
                    shadowColor: Colors.black,
                    isOutline: true,
                    onPressed: _pickPdf,
                  ),
                ),
                if (_uploadedPdf != null) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: DuoButton(
                      text: _showPdfPreview ? 'Hide Preview' : 'Show Preview',
                      color: AppTheme.duoBlue,
                      shadowColor: AppTheme.duoBlueDark,
                      onPressed: () {
                        setState(() => _showPdfPreview = !_showPdfPreview);
                      },
                    ),
                  ),
                ],
              ],
            ),
            if (_uploadedPdf != null && _showPdfPreview) ...[
              const SizedBox(height: 12),
              Container(
                height: 280,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white12),
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.hardEdge,
                child: SfPdfViewer.file(
                  _uploadedPdf!,
                  controller: _pdfViewerController,
                  canShowScrollHead: false,
                  canShowScrollStatus: false,
                ),
              ),
            ],
          ],
        ),
      ),
    );

    // Hierarchical structure list
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
                  child: _editingTitleId == module.id
                      ? Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _titleControllers[module.id],
                                autofocus: true,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.duoBlue),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 6),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.duoBlue)),
                                ),
                                onSubmitted: (_) => _saveTitle(module.id, m, null, 'module'),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(LucideIcons.check, color: AppTheme.duoGreen, size: 16),
                              padding: const EdgeInsets.all(4),
                              constraints: const BoxConstraints(),
                              onPressed: () => _saveTitle(module.id, m, null, 'module'),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Module ${m + 1}: ${module.title}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.duoBlue),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(LucideIcons.edit2, color: Colors.white38, size: 14),
                              padding: const EdgeInsets.all(4),
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                setState(() {
                                  _editingTitleId = module.id;
                                });
                              },
                            ),
                          ],
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
            type: 'section',
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
                    child: _editingTitleId == section.id
                        ? Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _titleControllers[section.id],
                                  autofocus: true,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white.withOpacity(0.7)),
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 6),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.duoViolet)),
                                  ),
                                  onSubmitted: (_) => _saveTitle(section.id, m, s, 'section'),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(LucideIcons.check, color: AppTheme.duoGreen, size: 16),
                                padding: const EdgeInsets.all(4),
                                constraints: const BoxConstraints(),
                                onPressed: () => _saveTitle(section.id, m, s, 'section'),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Section ${s + 1}: ${section.title}',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white.withOpacity(0.7)),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(LucideIcons.edit2, color: Colors.white38, size: 14),
                                padding: const EdgeInsets.all(4),
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  setState(() {
                                    _editingTitleId = section.id;
                                  });
                                },
                              ),
                            ],
                          ),
                  ),
                  IconButton(
                    icon: const Icon(LucideIcons.trash2, color: AppTheme.duoRed, size: 14),
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(),
                    tooltip: 'Delete Section',
                    onPressed: () => _removeSection(m, section.id),
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
              type: 'unit',
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

    // Add module button at the very bottom
    listItems.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: DuoButton(
          text: 'Add Module',
          color: AppTheme.surface,
          shadowColor: Colors.black,
          isOutline: true,
          onPressed: _addModule,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Edit Course Structure', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
      ),
      body: ResponsiveCenter(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: listItems,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DuoButton(
                text: 'Save Changes',
                color: AppTheme.duoGreen,
                shadowColor: AppTheme.duoGreenDark,
                onPressed: _saveChanges,
              ),
            )
          ],
        ),
      ),
    );
  }
}
