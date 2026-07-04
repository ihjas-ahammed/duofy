import 'dart:io';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/auto_index_service.dart';
import '../widgets/responsive_center.dart';
import 'index_picker_screen.dart';
import 'course_questionnaire_screen.dart';
import 'generate_book_screen.dart' show IndexMode;

class AutoIndexScreen extends StatefulWidget {
  final File sourcePdf;
  final String filename;
  final List<File> syllabusFiles;
  final bool isCourse;

  // Chained parameters
  final List<File>? allSourcePdfs;
  final int currentPdfIndex;
  final List<List<int>>? collectedIndexPages;
  final List<int>? collectedChapter1StartPages;
  final bool isAutoMode;
  final bool isHandout;
  final String? customIndexingPrompt;

  const AutoIndexScreen({
    super.key,
    required this.sourcePdf,
    required this.filename,
    this.syllabusFiles = const [],
    this.isCourse = false,
    this.allSourcePdfs,
    this.currentPdfIndex = 0,
    this.collectedIndexPages,
    this.collectedChapter1StartPages,
    this.isAutoMode = true,
    this.isHandout = false,
    this.customIndexingPrompt,
  });

  @override
  State<AutoIndexScreen> createState() => _AutoIndexScreenState();
}

class _AutoIndexScreenState extends State<AutoIndexScreen> {
  String _status = 'Starting...';
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startAutoIndex();
  }

  Future<void> _startAutoIndex() async {
    try {
      final service = AutoIndexService();
      final result = await service.findIndexAndChapter1(
        widget.sourcePdf,
        (status, progress) {
          if (mounted) {
            setState(() {
              _status = status;
              _progress = progress;
            });
          }
        },
      );

      if (mounted) {
        if (result.indexPages.isEmpty || result.chapter1StartPage == null) {
          _fallbackToManual(
            initialIndexPages:
                result.indexPages.isNotEmpty ? result.indexPages : null,
            initialChapter1Page: result.chapter1StartPage,
          );
        } else {
          final currentPagesList = List<List<int>>.from(widget.collectedIndexPages ?? []);
          final currentCh1List = List<int>.from(widget.collectedChapter1StartPages ?? []);
          currentPagesList.add(result.indexPages);
          currentCh1List.add(result.chapter1StartPage!);

          final sourcePdfs = widget.allSourcePdfs ?? [widget.sourcePdf];
          final nextIdx = widget.currentPdfIndex + 1;

          if (nextIdx < sourcePdfs.length) {
            final nextPdf = sourcePdfs[nextIdx];
            final nextFilename = nextPdf.path.split(RegExp(r'[\\/]')).last;

            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => AutoIndexScreen(
                sourcePdf: nextPdf,
                filename: nextFilename,
                syllabusFiles: widget.syllabusFiles,
                isCourse: widget.isCourse,
                allSourcePdfs: sourcePdfs,
                currentPdfIndex: nextIdx,
                collectedIndexPages: currentPagesList,
                collectedChapter1StartPages: currentCh1List,
                isAutoMode: true,
                isHandout: widget.isHandout,
                customIndexingPrompt: widget.customIndexingPrompt,
              ),
            ));
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => CourseQuestionnaireScreen(
                sourcePdfs: sourcePdfs,
                filename: widget.filename,
                syllabusFiles: widget.syllabusFiles,
                isCourse: widget.isCourse,
                allIndexPages: currentPagesList,
                allChapter1StartPages: currentCh1List,
                isHandout: widget.isHandout,
                customIndexingPrompt: widget.customIndexingPrompt,
              ),
            ));
          }
        }
      }
    } catch (e) {
      print('[AutoIndexScreen] Auto-index failed: $e');
      if (mounted) {
        _fallbackToManual();
      }
    }
  }

  /// Auto-detection failed for this PDF: hand over to the manual picker,
  /// pre-filled with any partial results. Subsequent PDFs in the chain
  /// still go through auto-detection first (isAutoMode stays true).
  void _fallbackToManual({List<int>? initialIndexPages, int? initialChapter1Page}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          'Auto-detect couldn\'t index "${widget.filename}". Please mark the index pages manually.'),
      duration: const Duration(seconds: 5),
    ));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => IndexPickerScreen(
        sourcePdf: widget.sourcePdf,
        filename: widget.filename,
        syllabusFiles: widget.syllabusFiles,
        isCourse: widget.isCourse,
        initialIndexPages: initialIndexPages,
        initialChapter1Page: initialChapter1Page,
        allSourcePdfs: widget.allSourcePdfs,
        currentPdfIndex: widget.currentPdfIndex,
        collectedIndexPages: widget.collectedIndexPages,
        collectedChapter1StartPages: widget.collectedChapter1StartPages,
        isAutoMode: true,
        isHandout: widget.isHandout,
        indexMode: IndexMode.manual,
        customIndexingPrompt: widget.customIndexingPrompt,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text('Analyzing Structure...')),
      body: ResponsiveCenter(
        maxWidth: ResponsiveMaxWidth.form,
        child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: AppTheme.duoGreen),
              const SizedBox(height: 24),
              Text(_status, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              const SizedBox(height: 12),
              LinearProgressIndicator(value: _progress, backgroundColor: Colors.white12, color: AppTheme.duoGreen),
              const SizedBox(height: 24),
              const Text('AI is scanning the textbook to locate the table of contents and chapter starts. This saves you from scrolling!', style: TextStyle(color: Colors.white54, fontSize: 13), textAlign: TextAlign.center),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
