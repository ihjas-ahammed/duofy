import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../models/app_models.dart';
import '../services/generation_manager.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/responsive_center.dart';

/// A single editable page-range row. Wraps either a Unit (legacy flow) or a
/// Section (new TOC-only flow); only the indices needed to write the value
/// back into the right slot of the Book change between the two cases.
class _RangeEditor {
  final int modIdx;
  final int secIdx;
  final int? unitIdx; // null for section-level (new-flow) editors
  final String title;
  final String subtitle;
  final TextEditingController startCtrl;
  final TextEditingController endCtrl;

  _RangeEditor.section({
    required this.modIdx,
    required this.secIdx,
    required Section section,
  })  : unitIdx = null,
        title = section.title,
        subtitle = 'M${modIdx + 1} • S${secIdx + 1}',
        startCtrl = TextEditingController(text: section.startPage?.toString() ?? ''),
        endCtrl = TextEditingController(text: section.endPage?.toString() ?? '');

  _RangeEditor.unit({
    required this.modIdx,
    required this.secIdx,
    required int this.unitIdx,
    required Unit unit,
  })  : title = unit.title,
        subtitle = 'M${modIdx + 1} • S${secIdx + 1} • U${unitIdx + 1}',
        startCtrl = TextEditingController(text: unit.startPage?.toString() ?? ''),
        endCtrl = TextEditingController(text: unit.endPage?.toString() ?? '');
}

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
  final List<_RangeEditor> _editors = [];
  bool _isPdf = false;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _isPdf = widget.originalPdf.length == 1 && widget.originalPdf.first.path.toLowerCase().endsWith('.pdf');
    _flattenHierarchy();
  }

  void _flattenHierarchy() {
    for (int m = 0; m < widget.skeletonBook.modules.length; m++) {
      for (int s = 0; s < widget.skeletonBook.modules[m].sections.length; s++) {
        final section = widget.skeletonBook.modules[m].sections[s];
        // New-flow sections own the page range; show one editor per section.
        if (section.startPage != null || section.endPage != null) {
          _editors.add(_RangeEditor.section(modIdx: m, secIdx: s, section: section));
          continue;
        }
        // Old-flow sections delegate to their units.
        for (int u = 0; u < section.units.length; u++) {
          final unit = section.units[u];
          _editors.add(_RangeEditor.unit(modIdx: m, secIdx: s, unitIdx: u, unit: unit));
        }
      }
    }
  }

  void _commitSplits() {
    List<Module> updatedModules = List.from(widget.skeletonBook.modules);

    for (var editor in _editors) {
      int? sPage = int.tryParse(editor.startCtrl.text);
      int? ePage = int.tryParse(editor.endCtrl.text);

      final mIdx = editor.modIdx;
      final sIdx = editor.secIdx;

      final List<Section> modSections = List.from(updatedModules[mIdx].sections);

      if (editor.unitIdx == null) {
        // Section-level (new flow) — page range lives on the section itself.
        modSections[sIdx] = modSections[sIdx].copyWith(startPage: sPage, endPage: ePage);
      } else {
        // Unit-level (old flow).
        final List<Unit> secUnits = List.from(modSections[sIdx].units);
        secUnits[editor.unitIdx!] = secUnits[editor.unitIdx!].copyWith(startPage: sPage, endPage: ePage);
        modSections[sIdx] = modSections[sIdx].copyWith(units: secUnits);
      }
      updatedModules[mIdx] = updatedModules[mIdx].copyWith(sections: modSections);
    }

    final offsetBook = widget.skeletonBook.copyWith(modules: updatedModules);

    GenerationManager.instance.startBackgroundSplitAndSave(widget.taskId, widget.originalPdf, offsetBook);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 24, right: 24, bottom: 8),
                    child: Text('Adjust Unit Ranges', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      itemCount: _editors.length,
                      itemBuilder: (context, i) {
                        final editor = _editors[i];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      editor.title,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(editor.subtitle, style: const TextStyle(color: Colors.white54, fontSize: 9, fontWeight: FontWeight.w900)),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: TextField(
                                  controller: editor.startCtrl,
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
                              Flexible(
                                child: TextField(
                                  controller: editor.endCtrl,
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
                              IconButton(
                                icon: const Icon(LucideIcons.eye, color: AppTheme.duoBlue, size: 18),
                                padding: const EdgeInsets.all(4),
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  int? p = int.tryParse(editor.startCtrl.text);
                                  if (p != null) {
                                    if (_isPdf) {
                                      _pdfViewerController.jumpToPage(p);
                                    } else if (p - 1 >= 0 && p - 1 < widget.originalPdf.length) {
                                      _imagePageController.jumpToPage(p - 1);
                                    }
                                  }
                                },
                              )
                            ],
                          ),
                        );
                      },
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