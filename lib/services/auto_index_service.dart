import 'dart:io';
import 'dart:async';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sync_pdf;
import 'pdf_service.dart';
import 'ai_service.dart';
import 'generation_manager.dart';

class AutoIndexResult {
  final List<int> indexPages;
  final int? chapter1StartPage;

  AutoIndexResult({required this.indexPages, this.chapter1StartPage});
}

class AutoIndexService {
  final AiService _aiService = AiService();
  final PdfService _pdfService = PdfService();

  Future<AutoIndexResult> findIndexAndChapter1(
    File sourcePdf,
    void Function(String status, double progress) onProgress,
  ) async {
    final pageCount = await _pdfService.getPageCount(sourcePdf);
    final int maxPagesToScan = pageCount.clamp(0, 100);

    List<int> foundIndexPages = [];
    int? foundChapter1Page;

    // 1. Try text-based PDF text analysis first
    bool textExtractionSuccess = false;
    sync_pdf.PdfDocument? doc;
    try {
      final bytes = await sourcePdf.readAsBytes();
      doc = sync_pdf.PdfDocument(inputBytes: bytes);
      final extractor = sync_pdf.PdfTextExtractor(doc);

      onProgress('Extracting textbook text...', 0.1);
      
      for (int i = 0; i < maxPagesToScan; i++) {
        final pageNum = i + 1;
        onProgress('Analyzing page text $pageNum of $maxPagesToScan...', 0.1 + (0.8 * (i / maxPagesToScan)));
        
        final pageText = extractor.extractText(startPageIndex: i, endPageIndex: i);
        if (pageText.trim().isEmpty) continue;
        
        textExtractionSuccess = true;
        
        final lowerText = pageText.toLowerCase();
        
        // Check for index/contents keywords
        final bool isTocCandidate = lowerText.contains('contents') || 
                                     lowerText.contains('table of contents') || 
                                     lowerText.contains('table of content') || 
                                     lowerText.contains('index');
                                     
        // Check for chapter 1 keywords
        final bool isCh1Candidate = lowerText.contains('chapter 1') || 
                                     lowerText.contains('chapter i') || 
                                     (lowerText.contains('introduction') && !lowerText.contains('contents'));
                                     
        if (isTocCandidate || isCh1Candidate) {
          final verification = await _aiService.verifyPageRole(pageText, pageNum);
          if (verification != null) {
            if (verification['isContentsPage'] == true) {
              foundIndexPages.add(pageNum);
            }
            if (verification['isChapter1Start'] == true && foundChapter1Page == null) {
              foundChapter1Page = pageNum;
            }
          }
        }
      }
    } catch (e) {
      print('[AutoIndexService] Text-based index extraction error: $e');
    } finally {
      doc?.dispose();
    }

    // 2. If text extraction worked and we found candidate pages, return them!
    if (foundIndexPages.isNotEmpty && foundChapter1Page != null) {
      return AutoIndexResult(
        indexPages: foundIndexPages.toSet().toList()..sort(),
        chapter1StartPage: foundChapter1Page,
      );
    }

    // 3. Fallback to existing chunk-based scan
    print('[AutoIndexService] Text analysis failed/incomplete. Falling back to PDF chunk scanning...');
    onProgress('Falling back to PDF chunk scanning...', 0.0);
    
    foundIndexPages.clear();
    foundChapter1Page = null;

    final int chunkSize = 10;
    final int chunks = (maxPagesToScan / chunkSize).ceil();

    for (int i = 0; i < chunks; i++) {
      if (foundIndexPages.isNotEmpty && foundChapter1Page != null) {
        break; // Found everything!
      }

      int startPage = i * chunkSize + 1;
      int endPage = (i + 1) * chunkSize;
      if (endPage > pageCount) endPage = pageCount;
      if (startPage > pageCount) break;
      
      onProgress('Scanning pages $startPage to $endPage...', (i + 1) / chunks);

      try {
        final chunkPages = List.generate(endPage - startPage + 1, (index) => startPage + index);
        final chunkPdf = await _pdfService.extractPages(sourcePdf, chunkPages);
        
        final jsonMap = await GenerationManager.instance.startIndexScanTask(chunkPdf, startPage, endPage);

        if (jsonMap != null) {
          if (jsonMap['indexPages'] != null && jsonMap['indexPages'] is List) {
            for (var p in jsonMap['indexPages']) {
              if (p is int && p >= 1 && p <= pageCount) foundIndexPages.add(p);
            }
          }
          if (jsonMap['chapter1StartPage'] != null && jsonMap['chapter1StartPage'] is int) {
            final val = jsonMap['chapter1StartPage'];
            if (val >= 1 && val <= pageCount) {
              foundChapter1Page = val;
            }
          }
        }
        
        // Clean up temp file
        if (chunkPdf.existsSync()) {
          chunkPdf.deleteSync();
        }
      } catch (e) {
        print('Error scanning chunk $i: $e');
      }
    }

    return AutoIndexResult(
      indexPages: foundIndexPages.toSet().toList()..sort(),
      chapter1StartPage: foundChapter1Page,
    );
  }
}
