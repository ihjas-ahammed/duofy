import '../platform/io_shim.dart';
import 'dart:async';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sync_pdf;
import 'auto_index_pipeline.dart';
import 'pdf_service.dart';
import 'ai_service.dart';

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
    
    int startPage = 1;
    List<int> indexPages = [];
    int? chapter1StartPage;
    
    while (startPage <= pageCount && startPage <= 120) {
      int endPage = startPage + 29;
      if (endPage > pageCount) endPage = pageCount;
      
      final currentProgress = startPage / 120.0;
      onProgress('Scanning pages $startPage–$endPage for index…', currentProgress);
      
      try {
        final chunkFile = await _pdfService.extractPages(
          sourcePdf,
          List.generate(endPage - startPage + 1, (i) => startPage + i),
          outputName: 'temp_chunk_${startPage}_$endPage.pdf',
        );
        
        final res = await _aiService.scanIndexChunk(chunkFile, startPage, endPage);
        
        try {
          await chunkFile.delete();
        } catch (_) {}
        
        if (res != null) {
          final List? idx = res['indexPages'] as List?;
          if (idx != null && idx.isNotEmpty && indexPages.isEmpty) {
            indexPages = idx.map((e) => (e as num).toInt()).toList();
          }
          final ch1 = res['chapter1StartPage'];
          if (ch1 is num && chapter1StartPage == null) {
            chapter1StartPage = ch1.toInt();
          }
        }
      } catch (e) {
        print('[AutoIndexService] Error scanning chunk $startPage–$endPage: $e');
      }
      
      if (indexPages.isNotEmpty && chapter1StartPage != null) {
        break;
      }
      
      startPage += 30;
    }
    
    return AutoIndexResult(indexPages: indexPages, chapter1StartPage: chapter1StartPage);
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

}
