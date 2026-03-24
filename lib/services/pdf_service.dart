import 'dart:io';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sync_pdf;
import 'package:pdf/pdf.dart' as pw_pdf;
import 'package:pdf/widgets.dart' as pw;
import '../models/app_models.dart';

class PdfService {
  /// Splitting natively prevents 49mb bloats.
  /// If [inputFiles] contains a single PDF, it uses native vector subsetting via Syncfusion.
  /// If [inputFiles] contains images, it bundles them cleanly into a small PDF chunks.
  Future<Book> splitBookPdf(List<File> inputFiles, Book book, Function(String) onProgress) async {
    final dir = await getApplicationDocumentsDirectory();
    final bookDirPath = '${dir.path}/books/${book.id}';
    final bookDir = Directory(bookDirPath);
    if (!await bookDir.exists()) await bookDir.create(recursive: true);

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
    
    bool isPdfSource = inputFiles.length == 1 && inputFiles.first.path.toLowerCase().endsWith('.pdf');
    sync_pdf.PdfDocument? originalDoc;
    
    if (isPdfSource) {
      originalDoc = sync_pdf.PdfDocument(inputBytes: await inputFiles.first.readAsBytes());
    }

    for (var module in book.modules) {
      List<Section> updatedSections = [];
      
      for (var section in module.sections) {
        List<Unit> updatedUnits = [];
        
        for (var unit in section.units) {
          if (unit.startPage != null && unit.endPage != null) {
            currentUnit++;
            onProgress("Native chunking unit $currentUnit of $totalUnits...");

            int start = unit.startPage! - 1;
            int end = unit.endPage! - 1;
            if (start < 0) start = 0;

            final filePath = '$bookDirPath/${unit.id}.pdf';
            final file = File(filePath);

            if (isPdfSource && originalDoc != null) {
              if (end >= originalDoc.pages.count) end = originalDoc.pages.count - 1;

              final sync_pdf.PdfDocument chunkDoc = sync_pdf.PdfDocument();
              
              for (int i = start; i <= end; i++) {
                final sync_pdf.PdfPage loadedPage = originalDoc.pages[i];
                chunkDoc.pageSettings.size = loadedPage.size;
                chunkDoc.pageSettings.margins.all = 0;
                
                final sync_pdf.PdfPage newPage = chunkDoc.pages.add();
                newPage.graphics.drawPdfTemplate(loadedPage.createTemplate(), const Offset(0, 0));
              }

              final bytes = await chunkDoc.save();
              await file.writeAsBytes(bytes);
              chunkDoc.dispose();
              
            } else {
              // Image source bundling
              if (end >= inputFiles.length) end = inputFiles.length - 1;
              
              final pw.Document pdf = pw.Document();
              for(int i = start; i <= end; i++) {
                 final imageBytes = await inputFiles[i].readAsBytes();
                 final image = pw.MemoryImage(imageBytes);
                 pdf.addPage(
                   pw.Page(
                     margin: pw.EdgeInsets.zero,
                     build: (pw.Context context) => pw.FullPage(ignoreMargins: true, child: pw.Image(image, fit: pw.BoxFit.contain))
                   )
                 );
              }
              await file.writeAsBytes(await pdf.save());
            }

            updatedUnits.add(unit.copyWith(pdfPath: filePath, isGenerated: false, lessons: []));
          } else {
            updatedUnits.add(unit.copyWith(isGenerated: false, lessons: []));
          }
        }
        updatedSections.add(section.copyWith(units: updatedUnits));
      }
      updatedModules.add(module.copyWith(sections: updatedSections));
    }

    originalDoc?.dispose();
    return book.copyWith(modules: updatedModules);
  }
}