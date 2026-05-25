import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../services/generation_manager.dart';
import '../services/pdf_service.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';

/// Step 1 of the new book-generation flow.
///
/// User scrolls through the source PDF, marks which pages contain the
/// table of contents / index, and tells us the absolute PDF page on which
/// Chapter 1 actually starts (so we can correct printed-page-number ↔
/// absolute-page-number offsets in the prompt).
///
/// On confirm:
///   1. The marked pages are sliced into a small mini-PDF via
///      [PdfService.extractPages].
///   2. The mini-PDF + the chapter-1 absolute page are handed to
///      [GenerationManager.startBookGeneration] which then drives the AI
///      skeleton call. The full original PDF is kept for the later
///      per-section chunking step.
class IndexPickerScreen extends StatefulWidget {
  final File sourcePdf;
  final String filename;

  const IndexPickerScreen({
    super.key,
    required this.sourcePdf,
    required this.filename,
  });

  @override
  State<IndexPickerScreen> createState() => _IndexPickerScreenState();
}

class _IndexPickerScreenState extends State<IndexPickerScreen> {
  final PdfViewerController _pdfCtrl = PdfViewerController();
  final TextEditingController _chapter1Ctrl = TextEditingController();
  final TextEditingController _instructionsCtrl = TextEditingController();
  final Set<int> _selectedPages = <int>{};
  int _currentPage = 1;
  int _pageCount = 0;
  bool _isStarting = false;

  @override
  void dispose() {
    _chapter1Ctrl.dispose();
    _instructionsCtrl.dispose();
    super.dispose();
  }

  void _toggleCurrentPage() {
    setState(() {
      if (_selectedPages.contains(_currentPage)) {
        _selectedPages.remove(_currentPage);
      } else {
        _selectedPages.add(_currentPage);
      }
    });
  }

  void _markAsChapter1Start() {
    _chapter1Ctrl.text = _currentPage.toString();
    setState(() {});
  }

  Future<void> _continue() async {
    if (_selectedPages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick at least one index/TOC page.')),
      );
      return;
    }
    final ch1 = int.tryParse(_chapter1Ctrl.text.trim());
    if (ch1 == null || ch1 < 1 || (_pageCount > 0 && ch1 > _pageCount)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter the absolute PDF page where Chapter 1 starts.')),
      );
      return;
    }

    setState(() => _isStarting = true);
    File? indexPdf;
    try {
      // Slicing the mini-PDF is the only foreground work — it\'s fast (just a
      // few pages of native vector copying) and we need its file path before
      // we can hand control off to the background task.
      final pages = _selectedPages.toList()..sort();
      indexPdf = await PdfService().extractPages(
        widget.sourcePdf,
        pages,
        outputName: 'index_${widget.filename}',
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isStarting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not extract index pages: $e')),
      );
      return;
    }

    // Fire-and-forget the AI skeleton call. GenerationManager owns the task
    // lifecycle, surfaces progress via its ChangeNotifier, and posts the
    // "review splits" notification when the skeleton is ready, so we don\'t
    // need to keep this screen open while it runs.
    // ignore: unawaited_futures
    final instructions = _instructionsCtrl.text.trim();
    GenerationManager.instance.startBookGeneration(
      [widget.sourcePdf],
      widget.filename,
      indexFiles: [indexPdf],
      chapter1AbsolutePage: ch1,
      customInstructions: instructions.isEmpty ? null : instructions,
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Analyzing index in background. You can add another course.')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = _selectedPages.contains(_currentPage);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Index Pages', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white12, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  children: [
                    SfPdfViewer.file(
                      widget.sourcePdf,
                      controller: _pdfCtrl,
                      canShowScrollHead: false,
                      canShowScrollStatus: false,
                      onDocumentLoaded: (details) {
                        setState(() {
                          _pageCount = _pdfCtrl.pageCount;
                          _currentPage = _pdfCtrl.pageNumber;
                        });
                      },
                      onPageChanged: (details) {
                        setState(() => _currentPage = details.newPageNumber);
                      },
                    ),
                    Positioned(
                      bottom: 12,
                      left: 12,
                      right: 12,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppTheme.surface.withOpacity(0.92),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: Text(
                              _pageCount > 0 ? 'Page $_currentPage / $_pageCount' : 'Loading…',
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
                            ),
                          ),
                          const Spacer(),
                          Material(
                            color: isSelected ? AppTheme.duoGreen : AppTheme.duoBlue,
                            borderRadius: BorderRadius.circular(20),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: _pageCount == 0 ? null : _toggleCurrentPage,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(isSelected ? LucideIcons.checkSquare : LucideIcons.plus, size: 14, color: Colors.white),
                                    const SizedBox(width: 6),
                                    Text(
                                      isSelected ? 'INDEX PAGE' : 'MARK AS INDEX',
                                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, -4))],
                ),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Selected index pages',
                                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 38,
                                child: _selectedPages.isEmpty
                                    ? const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'No pages picked yet. Use the viewer above and tap "Mark as Index".',
                                          style: TextStyle(color: Colors.white54, fontSize: 12),
                                        ),
                                      )
                                    : ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          for (final p in (_selectedPages.toList()..sort()))
                                            Padding(
                                              padding: const EdgeInsets.only(right: 6),
                                              child: InputChip(
                                                label: Text('$p', style: const TextStyle(fontWeight: FontWeight.w800)),
                                                onPressed: () {
                                                  _pdfCtrl.jumpToPage(p);
                                                },
                                                onDeleted: () => setState(() => _selectedPages.remove(p)),
                                                deleteIcon: const Icon(LucideIcons.x, size: 14),
                                                backgroundColor: AppTheme.duoBlue.withOpacity(0.18),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  side: const BorderSide(color: AppTheme.duoBlue),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Chapter 1 starts on PDF page',
                                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Colors.white),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Open the page where Chapter 1 actually begins and tap "Use current". This corrects the offset between the TOC\'s printed page numbers and absolute PDF pages.',
                                style: TextStyle(color: Colors.white54, fontSize: 11, height: 1.4),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _chapter1Ctrl,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: _pageCount > 0 ? 'e.g. 13 (out of $_pageCount)' : 'e.g. 13',
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  OutlinedButton.icon(
                                    onPressed: _pageCount == 0 ? null : _markAsChapter1Start,
                                    icon: const Icon(LucideIcons.crosshair, size: 14),
                                    label: const Text('Use current', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Custom instructions (optional)',
                                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Colors.white),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Guidance applied across the whole course — structure, lesson planning, and every lesson. e.g. "Focus on exam-style worked examples and keep theory concise."',
                                style: TextStyle(color: Colors.white54, fontSize: 11, height: 1.4),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _instructionsCtrl,
                                maxLines: 3,
                                minLines: 2,
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Optional — leave blank for defaults',
                                  hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              const SizedBox(height: 12),
                              DuoButton(
                                text: _isStarting ? 'Starting…' : 'Continue',
                                color: _isStarting ? Colors.grey.shade700 : AppTheme.duoGreen,
                                shadowColor: _isStarting ? Colors.grey.shade800 : AppTheme.duoGreenDark,
                                onPressed: () { if (!_isStarting) _continue(); },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
