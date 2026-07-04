import 'dart:io';
import 'dart:async';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sync_pdf;
import 'auto_index_pipeline.dart';
import 'pdf_service.dart';
import 'ai_service.dart';
import 'generation_manager.dart';

export 'auto_index_pipeline.dart' show AutoIndexResult;

/// Finds a book's table-of-contents pages and the absolute page where
/// Chapter 1 starts. Wires real I/O (Syncfusion text/link/bookmark
/// extraction, AiService, GenerationManager) into [AutoIndexPipeline].
class AutoIndexService {
  final AiService _aiService = AiService();
  final PdfService _pdfService = PdfService();

  static const int maxPagesToScan = 120;

  Future<AutoIndexResult> findIndexAndChapter1(
    File sourcePdf,
    void Function(String status, double progress) onProgress,
  ) async {
    final pageCount = await _pdfService.getPageCount(sourcePdf);
    final int scanLimit = pageCount.clamp(0, maxPagesToScan);

    onProgress('Extracting textbook text…', 0.05);
    final pageTexts = await _extractPageTexts(sourcePdf, scanLimit, onProgress);

    final pipeline = AutoIndexPipeline(
      verifyPage: (text, page) => _aiService.verifyPageRole(text, page),
      extractLinkDestinations: (tocPages) =>
          _extractLinkDestinations(sourcePdf, tocPages),
      chunkScanFallback: (progress) =>
          _chunkScan(sourcePdf, pageCount, scanLimit, progress),
      optimize: (tocText, pages, ch1) =>
          _aiService.optimizeIndexResult(tocText, pages, ch1, pageCount),
    );

    return pipeline.run(pageTexts, pageCount, onProgress);
  }

  /// Embedded-text extraction of the first [scanLimit] pages. Pages that
  /// fail to extract yield '' (a mostly-empty result means a scanned PDF,
  /// which the pipeline short-circuits to the AI chunk scan).
  Future<List<String>> _extractPageTexts(
      File sourcePdf, int scanLimit, ProgressCallback onProgress) async {
    final texts = List<String>.filled(scanLimit, '');
    sync_pdf.PdfDocument? doc;
    try {
      final bytes = await sourcePdf.readAsBytes();
      doc = sync_pdf.PdfDocument(inputBytes: bytes);
      final extractor = sync_pdf.PdfTextExtractor(doc);
      for (int i = 0; i < scanLimit; i++) {
        onProgress('Reading page ${i + 1} of $scanLimit…',
            0.05 + 0.2 * (i / scanLimit));
        try {
          texts[i] = extractor.extractText(startPageIndex: i, endPageIndex: i);
        } catch (_) {}
      }
    } catch (e) {
      print('[AutoIndexService] Text extraction failed: $e');
    } finally {
      doc?.dispose();
    }
    return texts;
  }

  /// Destination pages of internal link annotations on [tocPages] plus all
  /// document outline/bookmark entries. Empty result is fine — the pipeline
  /// falls back to text scanning.
  Future<List<int>> _extractLinkDestinations(
      File sourcePdf, List<int> tocPages) async {
    final dests = <int>{};
    sync_pdf.PdfDocument? doc;
    try {
      doc = sync_pdf.PdfDocument(inputBytes: await sourcePdf.readAsBytes());
      for (final pageNum in tocPages) {
        if (pageNum < 1 || pageNum > doc.pages.count) continue;
        final annotations = doc.pages[pageNum - 1].annotations;
        for (int i = 0; i < annotations.count; i++) {
          final a = annotations[i];
          if (a is sync_pdf.PdfDocumentLinkAnnotation) {
            final destPage = a.destination?.page;
            if (destPage != null) {
              final idx = doc.pages.indexOf(destPage);
              if (idx >= 0) dests.add(idx + 1);
            }
          }
        }
      }
      _collectBookmarks(doc, doc.bookmarks, dests);
    } catch (e) {
      print('[AutoIndexService] Link/bookmark extraction failed: $e');
    } finally {
      doc?.dispose();
    }
    return dests.toList()..sort();
  }

  void _collectBookmarks(
      sync_pdf.PdfDocument doc, sync_pdf.PdfBookmarkBase base, Set<int> dests) {
    for (int i = 0; i < base.count; i++) {
      final bm = base[i];
      final destPage = bm.destination?.page;
      if (destPage != null) {
        final idx = doc.pages.indexOf(destPage);
        if (idx >= 0) dests.add(idx + 1);
      }
      _collectBookmarks(doc, bm, dests);
    }
  }

  /// Pre-existing AI chunk scan: slice the PDF into 10-page mini-PDFs and
  /// ask the AI to locate the TOC and Chapter 1 in each.
  Future<AutoIndexResult> _chunkScan(File sourcePdf, int pageCount,
      int scanLimit, ProgressCallback onProgress) async {
    final found = <int>[];
    int? ch1;
    const chunkSize = 10;
    final chunks = (scanLimit / chunkSize).ceil();

    for (int i = 0; i < chunks; i++) {
      if (found.isNotEmpty && ch1 != null) break;

      final startPage = i * chunkSize + 1;
      int endPage = (i + 1) * chunkSize;
      if (endPage > pageCount) endPage = pageCount;
      if (startPage > pageCount) break;

      onProgress('Scanning pages $startPage to $endPage with AI…',
          (i + 1) / chunks);

      try {
        final chunkPages =
            List.generate(endPage - startPage + 1, (idx) => startPage + idx);
        final chunkPdf = await _pdfService.extractPages(sourcePdf, chunkPages);
        final jsonMap = await GenerationManager.instance
            .startIndexScanTask(chunkPdf, startPage, endPage);

        if (jsonMap != null) {
          if (jsonMap['indexPages'] is List) {
            for (var p in jsonMap['indexPages']) {
              if (p is int && p >= 1 && p <= pageCount) found.add(p);
            }
          }
          final v = jsonMap['chapter1StartPage'];
          if (v is int && v >= 1 && v <= pageCount) ch1 ??= v;
        }

        if (chunkPdf.existsSync()) {
          chunkPdf.deleteSync();
        }
      } catch (e) {
        print('[AutoIndexService] Error scanning chunk $i: $e');
      }
    }

    return AutoIndexResult(
      indexPages: found.toSet().toList()..sort(),
      chapter1StartPage: ch1,
    );
  }
}
