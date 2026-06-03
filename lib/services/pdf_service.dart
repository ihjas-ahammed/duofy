import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sync_pdf;
import 'package:pdf/widgets.dart' as pw;
import '../models/app_models.dart';

class PdfService {
  /// Extracts the given 1-based page numbers from [sourcePdf] into a new
  /// small PDF and returns it. Used by the new index-picker flow so the
  /// skeleton AI call only sees the TOC pages, not the whole book.
  ///
  /// Page numbers outside the source are silently skipped. Duplicates are
  /// preserved in order so the caller controls the page layout.
  Future<File> extractPages(File sourcePdf, List<int> pageNumbers, {String? outputName}) async {
    if (pageNumbers.isEmpty) {
      throw ArgumentError('extractPages: pageNumbers must not be empty');
    }
    final doc = sync_pdf.PdfDocument(inputBytes: await sourcePdf.readAsBytes());
    try {
      final out = sync_pdf.PdfDocument();
      for (final p in pageNumbers) {
        final idx = p - 1;
        if (idx < 0 || idx >= doc.pages.count) continue;
        final loaded = doc.pages[idx];
        out.pageSettings.size = loaded.size;
        out.pageSettings.margins.all = 0;
        final newPage = out.pages.add();
        newPage.graphics.drawPdfTemplate(loaded.createTemplate(), const Offset(0, 0));
      }
      if (out.pages.count == 0) {
        out.dispose();
        throw Exception('extractPages: none of the requested pages exist in the source PDF.');
      }
      final tmpDir = await getTemporaryDirectory();
      final name = outputName ?? 'index_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('${tmpDir.path}/$name');
      final bytes = await out.save();
      out.dispose();
      await file.writeAsBytes(bytes);
      return file;
    } finally {
      doc.dispose();
    }
  }

  Future<String> extractTextFromPdfBytes(Uint8List bytes) async {
    final doc = sync_pdf.PdfDocument(inputBytes: bytes);
    try {
      final extractor = sync_pdf.PdfTextExtractor(doc);
      return extractor.extractText();
    } catch (e) {
      print('PdfService extractText error: $e');
      return '';
    } finally {
      doc.dispose();
    }
  }

  /// Extracts all text from a PDF file locally.
  /// Useful for sending dense documents (like syllabuses) to the AI as plain text
  /// to avoid "unable to process input image" errors with inline PDFs.
  Future<String> extractTextFromPdf(File pdfFile) async {
    return extractTextFromPdfBytes(await pdfFile.readAsBytes());
  }

  /// Merges multiple PDF/Image files into a single temporary PDF file.
  Future<File> mergeFiles(List<File> files) async {
    final out = sync_pdf.PdfDocument();
    try {
      for (final file in files) {
        final ext = file.path.split('.').last.toLowerCase();
        if (ext == 'pdf') {
          sync_pdf.PdfDocument? doc;
          try {
            doc = sync_pdf.PdfDocument(inputBytes: await file.readAsBytes());
            for (int i = 0; i < doc.pages.count; i++) {
              final loaded = doc.pages[i];
              out.pageSettings.size = loaded.size;
              out.pageSettings.margins.all = 0;
              final newPage = out.pages.add();
              newPage.graphics.drawPdfTemplate(loaded.createTemplate(), const Offset(0, 0));
            }
          } catch (e) {
            print('Error merging PDF ${file.path}: $e');
          } finally {
            doc?.dispose();
          }
        } else {
          // Image file
          try {
            final imageBytes = await file.readAsBytes();
            final sync_pdf.PdfImage image = sync_pdf.PdfBitmap(imageBytes);
            out.pageSettings.size = sync_pdf.PdfPageSize.a4;
            out.pageSettings.margins.all = 0;
            final newPage = out.pages.add();
            newPage.graphics.drawImage(image, Rect.fromLTWH(0, 0, newPage.size.width, newPage.size.height));
          } catch (e) {
            print('Error merging image ${file.path}: $e');
          }
        }
      }
      final tmpDir = await getTemporaryDirectory();
      final name = 'merged_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('${tmpDir.path}/$name');
      final bytes = await out.save();
      await file.writeAsBytes(bytes);
      return file;
    } finally {
      out.dispose();
    }
  }

  /// Helper to get the total page count of a PDF document.
  Future<int> getPageCount(File pdfFile) async {
    final bytes = await pdfFile.readAsBytes();
    final doc = sync_pdf.PdfDocument(inputBytes: bytes);
    final count = doc.pages.count;
    doc.dispose();
    return count;
  }

  /// Splits the source file(s) into per-section or per-unit PDF chunks.
  ///
  /// - **New-flow books** (any section with `startPage`/`endPage` set):
  ///   the chunk is keyed to the section, and units inside that section
  ///   share it. We set `section.pdfPath` and leave units alone.
  /// - **Old-flow books** (units carry their own `startPage`/`endPage`):
  ///   the chunk is keyed to the unit, matching the legacy behaviour.
  ///
  /// A single PDF source uses native vector subsetting via Syncfusion;
  /// image sources are re-bundled into per-chunk PDFs.
  Future<Book> splitBookPdf(
    List<File> inputFiles,
    Book book,
    void Function(String status, double progress) onProgress,
  ) async {
    final dir = await getApplicationDocumentsDirectory();
    final bookDirPath = '${dir.path}/books/${book.id}';
    final bookDir = Directory(bookDirPath);
    if (!await bookDir.exists()) await bookDir.create(recursive: true);

    int totalChunks = 0;
    for (var m in book.modules) {
      for (var s in m.sections) {
        if (s.startPage != null && s.endPage != null) {
          totalChunks++;
        } else {
          for (var u in s.units) {
            if (u.startPage != null && u.endPage != null) totalChunks++;
          }
        }
      }
    }

    int currentChunk = 0;
    final Map<int, sync_pdf.PdfDocument> openedDocs = {};

    Future<String> writeChunk(String id, int startPage, int endPage, int bookIdx) async {
      int start = startPage - 1;
      int end = endPage - 1;
      if (start < 0) start = 0;

      final filePath = '$bookDirPath/$id.pdf';
      final file = File(filePath);

      final currentFile = (bookIdx >= 0 && bookIdx < inputFiles.length) ? inputFiles[bookIdx] : inputFiles.first;
      final isPdf = currentFile.path.toLowerCase().endsWith('.pdf');

      if (isPdf) {
        sync_pdf.PdfDocument doc;
        if (openedDocs.containsKey(bookIdx)) {
          doc = openedDocs[bookIdx]!;
        } else {
          doc = sync_pdf.PdfDocument(inputBytes: await currentFile.readAsBytes());
          openedDocs[bookIdx] = doc;
        }

        if (end >= doc.pages.count) end = doc.pages.count - 1;
        final chunkDoc = sync_pdf.PdfDocument();
        for (int i = start; i <= end; i++) {
          final loaded = doc.pages[i];
          chunkDoc.pageSettings.size = loaded.size;
          chunkDoc.pageSettings.margins.all = 0;
          final newPage = chunkDoc.pages.add();
          newPage.graphics.drawPdfTemplate(loaded.createTemplate(), const Offset(0, 0));
        }
        final bytes = await chunkDoc.save();
        await file.writeAsBytes(bytes);
        chunkDoc.dispose();
      } else {
        // Fallback if the file is an image
        if (end >= inputFiles.length) end = inputFiles.length - 1;
        final pdf = pw.Document();
        for (int i = start; i <= end; i++) {
          final imageBytes = await inputFiles[i].readAsBytes();
          final image = pw.MemoryImage(imageBytes);
          pdf.addPage(pw.Page(
            margin: pw.EdgeInsets.zero,
            build: (pw.Context context) => pw.FullPage(ignoreMargins: true, child: pw.Image(image, fit: pw.BoxFit.contain)),
          ));
        }
        await file.writeAsBytes(await pdf.save());
      }
      return filePath;
    }

    final List<Module> updatedModules = [];
    for (final module in book.modules) {
      final List<Section> updatedSections = [];
      for (final section in module.sections) {
        // New-flow: section owns the chunk.
        if (section.startPage != null && section.endPage != null) {
          currentChunk++;
          onProgress("Chunking section $currentChunk of $totalChunks...", totalChunks == 0 ? 1.0 : currentChunk / totalChunks);
          final path = await writeChunk(section.id, section.startPage!, section.endPage!, section.bookIndex ?? 0);
          updatedSections.add(section.copyWith(pdfPath: path));
          continue;
        }

        // Old-flow: each unit owns its chunk.
        final List<Unit> updatedUnits = [];
        for (final unit in section.units) {
          if (unit.startPage != null && unit.endPage != null) {
            currentChunk++;
            onProgress("Chunking unit $currentChunk of $totalChunks...", totalChunks == 0 ? 1.0 : currentChunk / totalChunks);
            final path = await writeChunk(unit.id, unit.startPage!, unit.endPage!, unit.bookIndex ?? 0);
            updatedUnits.add(unit.copyWith(pdfPath: path, isGenerated: false, lessons: []));
          } else {
            updatedUnits.add(unit.copyWith(isGenerated: false, lessons: []));
          }
        }
        updatedSections.add(section.copyWith(units: updatedUnits));
      }
      updatedModules.add(module.copyWith(sections: updatedSections));
    }

    // Clean up all opened documents
    for (final doc in openedDocs.values) {
      doc.dispose();
    }

    return book.copyWith(modules: updatedModules);
  }
}