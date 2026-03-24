import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart' as pdfx;
import 'package:pdf/pdf.dart' as pw_pdf;
import 'package:pdf/widgets.dart' as pw;
import '../models/app_models.dart';

class PdfService {
  /// Rasterizes and repackages PDF pages into clean, compressed PDFs.
  /// Fixes the "hidden bloat" issue of standard PDF splitters where deleted pages
  /// still consume background memory and maintain massive original file sizes.
  Future<Book> splitBookPdf(File originalPdf, Book book, Function(String) onProgress) async {
    final dir = await getApplicationDocumentsDirectory();
    final bookDirPath = '${dir.path}/books/${book.id}';
    final bookDir = Directory(bookDirPath);
    if (!await bookDir.exists()) await bookDir.create(recursive: true);

    final doc = await pdfx.PdfDocument.openFile(originalPdf.path);
    
    int totalUnits = 0;
    for (var m in book.modules) {
      for (var s in m.sections) {
        for (var u in s.units) {
          if (u.startPage != null && u.endPage != null) totalUnits++;
        }
      }
    }

    int currentUnit = 0;
    List<Module> updatedModules = [];

    for (var module in book.modules) {
      List<Section> updatedSections = [];
      
      for (var section in module.sections) {
        List<Unit> updatedUnits = [];
        
        for (var unit in section.units) {
          if (unit.startPage != null && unit.endPage != null) {
            currentUnit++;
            onProgress("Rasterizing unit $currentUnit of $totalUnits...");

            int start = unit.startPage! - 1;
            int end = unit.endPage! - 1;
            if (start < 0) start = 0;
            if (end >= doc.pagesCount) end = doc.pagesCount - 1;

            final pw.Document pdf = pw.Document();

            for (int i = start; i <= end; i++) {
              onProgress("Unit $currentUnit: Rendering page ${i - start + 1} of ${end - start + 1}");
              final page = await doc.getPage(i + 1); // 1-based index

              // Use 2x scale for decent readability while guaranteeing file compression
              final pageImage = await page.render(
                width: page.width * 2,
                height: page.height * 2,
                format: pdfx.PdfPageImageFormat.jpeg,
                quality: 75,
              );

              if (pageImage != null) {
                pdf.addPage(
                  pw.Page(
                    pageFormat: pw_pdf.PdfPageFormat(page.width, page.height),
                    margin: pw.EdgeInsets.zero,
                    build: (context) {
                      return pw.Image(
                        pw.MemoryImage(pageImage.bytes),
                        fit: pw.BoxFit.cover,
                      );
                    },
                  ),
                );
              }
              await page.close();
            }

            final filePath = '$bookDirPath/${unit.id}.pdf';
            final file = File(filePath);
            await file.writeAsBytes(await pdf.save());

            updatedUnits.add(unit.copyWith(pdfPath: filePath, isGenerated: false, lessons: []));
          } else {
            updatedUnits.add(unit.copyWith(isGenerated: false, lessons: []));
          }
        }
        updatedSections.add(section.copyWith(units: updatedUnits));
      }
      updatedModules.add(module.copyWith(sections: updatedSections));
    }

    await doc.close();
    return book.copyWith(modules: updatedModules);
  }
}