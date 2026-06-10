import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sync_pdf;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfx/pdfx.dart' as pdfx;
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
    sync_pdf.PdfDocument? doc;
    try {
      doc = sync_pdf.PdfDocument(inputBytes: await sourcePdf.readAsBytes());
      final out = sync_pdf.PdfDocument();
      for (final p in pageNumbers) {
        final idx = p - 1;
        if (idx < 0 || idx >= doc.pages.count) continue;
        final loaded = doc.pages[idx];
        out.pageSettings.size = loaded.size;
        out.pageSettings.margins.all = 0;
        final newPage = out.pages.add();
        final completer = Completer<void>();
        runZonedGuarded(() {
          try {
            newPage.graphics.drawPdfTemplate(loaded.createTemplate(), const Offset(0, 0));
            completer.complete();
          } catch (e) {
            completer.completeError(e);
          }
        }, (error, stack) {
          if (!completer.isCompleted) {
            completer.completeError(error);
          }
        });

        try {
          await completer.future;
        } catch (e) {
          print('[PdfService] drawPdfTemplate failed (Syncfusion type cast bug: $e). Recovering by rendering page $p as a high-quality raster image fallback...');
          final imgBytes = await _renderPageToImage(sourcePdf, p);
          if (imgBytes != null) {
            final sync_pdf.PdfImage img = sync_pdf.PdfBitmap(imgBytes);
            newPage.graphics.drawImage(img, Rect.fromLTWH(0, 0, newPage.size.width, newPage.size.height));
          } else {
            rethrow;
          }
        }
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
      doc?.dispose();
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
              final completer = Completer<void>();
              runZonedGuarded(() {
                try {
                  newPage.graphics.drawPdfTemplate(loaded.createTemplate(), const Offset(0, 0));
                  completer.complete();
                } catch (e) {
                  completer.completeError(e);
                }
              }, (error, stack) {
                if (!completer.isCompleted) {
                  completer.completeError(error);
                }
              });

              try {
                await completer.future;
              } catch (e) {
                print('[PdfService] mergeFiles template failed (Syncfusion type cast bug: $e). Recovering by rendering page ${i + 1} as a high-quality raster image fallback...');
                final imgBytes = await _renderPageToImage(file, i + 1);
                if (imgBytes != null) {
                  final sync_pdf.PdfImage img = sync_pdf.PdfBitmap(imgBytes);
                  newPage.graphics.drawImage(img, Rect.fromLTWH(0, 0, newPage.size.width, newPage.size.height));
                } else {
                  rethrow;
                }
              }
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
    void Function(String status, double progress) onProgress, {
    bool preserveLessons = false,
  }) async {
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
        try {
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
            final completer = Completer<void>();
            runZonedGuarded(() {
              try {
                newPage.graphics.drawPdfTemplate(loaded.createTemplate(), const Offset(0, 0));
                completer.complete();
              } catch (e) {
                completer.completeError(e);
              }
            }, (error, stack) {
              if (!completer.isCompleted) {
                completer.completeError(error);
              }
            });

            try {
              await completer.future;
            } catch (e) {
              print('[PdfService] splitBookPdf template failed (Syncfusion type cast bug: $e). Recovering by rendering page ${i + 1} as a high-quality raster image fallback...');
              final imgBytes = await _renderPageToImage(currentFile, i + 1);
              if (imgBytes != null) {
                final sync_pdf.PdfImage img = sync_pdf.PdfBitmap(imgBytes);
                newPage.graphics.drawImage(img, Rect.fromLTWH(0, 0, newPage.size.width, newPage.size.height));
              } else {
                rethrow;
              }
            }
          }
          final bytes = await chunkDoc.save();
          await file.writeAsBytes(bytes);
          chunkDoc.dispose();
        } catch (outerErr) {
          print('[PdfService] Chunking failed for $id ($startPage-$endPage) due to Syncfusion cast error and unsupported raster rendering on this platform: $outerErr. Falling back to copying full original PDF...');
          try {
            await currentFile.copy(file.path);
          } catch (copyErr) {
            print('[PdfService] Failed to copy fallback full original PDF: $copyErr');
          }
        }
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
            if (preserveLessons) {
              updatedUnits.add(unit.copyWith(pdfPath: path));
            } else {
              updatedUnits.add(unit.copyWith(pdfPath: path, isGenerated: false, lessons: []));
            }
          } else {
            if (preserveLessons) {
              updatedUnits.add(unit);
            } else {
              updatedUnits.add(unit.copyWith(isGenerated: false, lessons: []));
            }
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

  Future<bool> hasBookmarks(File pdfFile) async {
    try {
      final doc = sync_pdf.PdfDocument(inputBytes: await pdfFile.readAsBytes());
      final count = doc.bookmarks.count;
      doc.dispose();
      return count > 0;
    } catch (_) {
      return false;
    }
  }

  Future<List<PdfBookmarkNode>> extractBookmarks(File pdfFile) async {
    try {
      final doc = sync_pdf.PdfDocument(inputBytes: await pdfFile.readAsBytes());
      final List<PdfBookmarkNode> list = [];
      _traverseBookmarks(doc, doc.bookmarks, list);
      doc.dispose();
      return list;
    } catch (e) {
      print('PdfService extractBookmarks error: $e');
      return [];
    }
  }

  void _traverseBookmarks(
    sync_pdf.PdfDocument doc,
    sync_pdf.PdfBookmarkBase bookmarks,
    List<PdfBookmarkNode> output,
  ) {
    for (int i = 0; i < bookmarks.count; i++) {
      try {
        final b = bookmarks[i];
        final p = _resolveBookmarkPage(doc, b) ?? 1;
        final List<PdfBookmarkNode> children = [];
        if (b.count > 0) {
          _traverseBookmarks(doc, b, children);
        }
        output.add(PdfBookmarkNode(
          title: b.title,
          pageNumber: p,
          children: children,
        ));
      } catch (e) {
        print('[PdfService] Error traversing bookmark at index $i: $e');
      }
    }
  }

  int? _resolveBookmarkPage(sync_pdf.PdfDocument doc, sync_pdf.PdfBookmark bookmark) {
    try {
      if (bookmark.destination != null && bookmark.destination!.page != null) {
        final idx = doc.pages.indexOf(bookmark.destination!.page!);
        if (idx >= 0) return idx + 1;
      }
    } catch (e) {
      print('[PdfService] Error resolving page for bookmark "${bookmark.title}": $e');
    }
    return null;
  }

  Book mapBookmarksToBook(List<PdfBookmarkNode> bookmarks, String filename, File pdfFile) {
    int totalPages = 100;
    try {
      final doc = sync_pdf.PdfDocument(inputBytes: pdfFile.readAsBytesSync());
      totalPages = doc.pages.count;
      doc.dispose();
    } catch (_) {}

    int maxDepth(List<PdfBookmarkNode> nodes) {
      if (nodes.isEmpty) return 0;
      int max = 0;
      for (final n in nodes) {
        final d = maxDepth(n.children);
        if (d > max) max = d;
      }
      return max + 1;
    }

    final depth = maxDepth(bookmarks);
    final List<Module> modules = [];

    int getEndPage(List<PdfBookmarkNode> siblings, int index, int parentEnd) {
      if (index + 1 < siblings.length) {
        return siblings[index + 1].pageNumber - 1;
      }
      return parentEnd;
    }

    if (depth >= 3) {
      for (int i = 0; i < bookmarks.length; i++) {
        final mNode = bookmarks[i];
        final mEnd = getEndPage(bookmarks, i, totalPages);
        final List<Section> sections = [];
        
        for (int j = 0; j < mNode.children.length; j++) {
          final sNode = mNode.children[j];
          final sEnd = getEndPage(mNode.children, j, mEnd);
          final List<Unit> units = [];
          
          for (int k = 0; k < sNode.children.length; k++) {
            final uNode = sNode.children[k];
            final uEnd = getEndPage(sNode.children, k, sEnd);
            units.add(Unit(
              id: 'unit_${DateTime.now().millisecondsSinceEpoch}_${i}_${j}_${k}',
              title: uNode.title,
              description: 'Unit on ${uNode.title}',
              startPage: uNode.pageNumber,
              endPage: uEnd,
              isGenerated: false,
              bookIndex: 0,
              lessons: const [],
            ));
          }
          
          if (units.isEmpty) {
            units.add(Unit(
              id: 'unit_${DateTime.now().millisecondsSinceEpoch}_${i}_${j}_0',
              title: sNode.title,
              description: 'Unit on ${sNode.title}',
              startPage: sNode.pageNumber,
              endPage: sEnd,
              isGenerated: false,
              bookIndex: 0,
              lessons: const [],
            ));
          }
          
          sections.add(Section(
            id: 'section_${DateTime.now().millisecondsSinceEpoch}_${i}_${j}',
            title: sNode.title,
            description: 'Section on ${sNode.title}',
            color: 'duo-blue',
            units: units,
          ));
        }
        
        if (sections.isEmpty) {
          sections.add(Section(
            id: 'section_${DateTime.now().millisecondsSinceEpoch}_${i}_0',
            title: mNode.title,
            description: 'Section on ${mNode.title}',
            color: 'duo-blue',
            units: [
              Unit(
                id: 'unit_${DateTime.now().millisecondsSinceEpoch}_${i}_0_0',
                title: mNode.title,
                description: 'Unit on ${mNode.title}',
                startPage: mNode.pageNumber,
                endPage: mEnd,
                isGenerated: false,
                bookIndex: 0,
                lessons: const [],
              )
            ],
          ));
        }

        modules.add(Module(
          id: 'module_${DateTime.now().millisecondsSinceEpoch}_${i}',
          title: mNode.title,
          description: 'Module on ${mNode.title}',
          practiceQuestions: const [],
          sections: sections,
        ));
      }
    } else if (depth == 2) {
      for (int i = 0; i < bookmarks.length; i++) {
        final mNode = bookmarks[i];
        final mEnd = getEndPage(bookmarks, i, totalPages);
        final List<Unit> units = [];
        
        for (int j = 0; j < mNode.children.length; j++) {
          final uNode = mNode.children[j];
          final uEnd = getEndPage(mNode.children, j, mEnd);
          units.add(Unit(
            id: 'unit_${DateTime.now().millisecondsSinceEpoch}_${i}_${j}',
            title: uNode.title,
            description: 'Unit on ${uNode.title}',
            startPage: uNode.pageNumber,
            endPage: uEnd,
            isGenerated: false,
            bookIndex: 0,
            lessons: const [],
          ));
        }
        
        if (units.isEmpty) {
          units.add(Unit(
            id: 'unit_${DateTime.now().millisecondsSinceEpoch}_${i}_0',
            title: mNode.title,
            description: 'Unit on ${mNode.title}',
            startPage: mNode.pageNumber,
            endPage: mEnd,
            isGenerated: false,
            bookIndex: 0,
            lessons: const [],
          ));
        }

        modules.add(Module(
          id: 'module_${DateTime.now().millisecondsSinceEpoch}_${i}',
          title: mNode.title,
          description: 'Module on ${mNode.title}',
          practiceQuestions: const [],
          sections: [
            Section(
              id: 'section_${DateTime.now().millisecondsSinceEpoch}_${i}',
              title: mNode.title,
              description: 'Section on ${mNode.title}',
              color: 'duo-blue',
              units: units,
            )
          ],
        ));
      }
    } else {
      final List<Unit> units = [];
      for (int i = 0; i < bookmarks.length; i++) {
        final uNode = bookmarks[i];
        final uEnd = getEndPage(bookmarks, i, totalPages);
        units.add(Unit(
          id: 'unit_${DateTime.now().millisecondsSinceEpoch}_${i}',
          title: uNode.title,
          description: 'Unit on ${uNode.title}',
          startPage: uNode.pageNumber,
          endPage: uEnd,
          isGenerated: false,
          bookIndex: 0,
          lessons: const [],
        ));
      }
      
      if (units.isEmpty) {
        units.add(Unit(
          id: 'unit_${DateTime.now().millisecondsSinceEpoch}_0',
          title: filename,
          description: 'Unit on ${filename}',
          startPage: 1,
          endPage: totalPages,
          isGenerated: false,
          bookIndex: 0,
          lessons: const [],
        ));
      }

      modules.add(Module(
        id: 'module_${DateTime.now().millisecondsSinceEpoch}',
        title: filename,
        description: 'Module on ${filename}',
        practiceQuestions: const [],
        sections: [
          Section(
            id: 'section_${DateTime.now().millisecondsSinceEpoch}',
            title: filename,
            description: 'Main sections of $filename',
            color: 'duo-blue',
            units: units,
          )
        ],
      ));
    }

    return Book(
      id: 'book_${DateTime.now().millisecondsSinceEpoch}',
      title: filename,
      description: 'Course generated from PDF bookmarks of $filename',
      icon: 'Book',
      authorName: 'Unknown',
      authorId: 'Unknown',
      lessonFormats: LessonFormat.defaultFormats,
      defaultFormatId: 'default',
      modules: modules,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
  }
  Future<Uint8List?> _renderPageToImage(File pdfFile, int pageNumber) async {
    try {
      final hasSupport = await pdfx.hasPdfSupport();
      if (!hasSupport) {
        print('[PdfService] Platform reports no PDF rendering support.');
        return null;
      }
    } catch (e) {
      print('[PdfService] Error checking PDF support: $e');
      return null;
    }

    final completer = Completer<Uint8List?>();
    
    runZonedGuarded(() async {
      try {
        final doc = await pdfx.PdfDocument.openFile(pdfFile.path);
        final page = await doc.getPage(pageNumber);
        final pageImage = await page.render(
          width: page.width * 2.0,
          height: page.height * 2.0,
          format: pdfx.PdfPageImageFormat.jpeg,
        );
        await page.close();
        await doc.close();
        completer.complete(pageImage?.bytes);
      } catch (e) {
        print('[PdfService] Error rendering page $pageNumber: $e');
        if (!completer.isCompleted) completer.complete(null);
      }
    }, (error, stack) {
      print('[PdfService] Caught unhandled zone error during page $pageNumber rendering: $error');
      if (!completer.isCompleted) {
        completer.complete(null);
      }
    });

    return completer.future;
  }
}

class PdfBookmarkNode {
  final String title;
  final int pageNumber;
  final List<PdfBookmarkNode> children;
  PdfBookmarkNode({required this.title, required this.pageNumber, required this.children});
}