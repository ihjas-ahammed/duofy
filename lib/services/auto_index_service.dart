import 'dart:io';
import 'dart:async';
import 'pdf_service.dart';
import 'ai_service.dart';

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
    const int chunkSize = 10;
    final int chunks = (maxPagesToScan / chunkSize).ceil();

    List<int> foundIndexPages = [];
    int? foundChapter1Page;

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
        
        final jsonMap = await _aiService.scanIndexChunk(chunkPdf, startPage, endPage);

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
