import 'dart:io';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../models/app_models.dart';

class PdfService {
  /// True Physical Splitting using Template Drawing
  /// This guarantees that massive, unreferenced meta-data from the old document isn't retained.
  Future<Book> splitBookPdf(File originalPdf, Book book) async {
    final bytes = await originalPdf.readAsBytes();
    final PdfDocument sourceDoc = PdfDocument(inputBytes: bytes);
    final int totalPages = sourceDoc.pages.count;
    
    final dir = await getApplicationDocumentsDirectory();
    final bookDir = Directory('${dir.path}/books/${book.id}');
    if (!await bookDir.exists()) await bookDir.create(recursive: true);

    List<Module> updatedModules = [];

    for (var module in book.modules) {
      List<Section> updatedSections = [];
      
      for (var section in module.sections) {
        List<Unit> updatedUnits = [];
        
        for (var unit in section.units) {
          if (unit.startPage != null && unit.endPage != null) {
            
            int start = unit.startPage! - 1;
            int end = unit.endPage! - 1;
            if (start < 0) start = 0;
            if (end >= totalPages) end = totalPages - 1;

            final PdfDocument newDoc = PdfDocument();
            // Important: drawing templates strips out redundant document-level objects
            for (int i = start; i <= end; i++) {
              final PdfPage sourcePage = sourceDoc.pages[i];
              newDoc.pageSettings.size = sourcePage.size;
              
              final PdfTemplate template = sourcePage.createTemplate();
              final PdfPage newPage = newDoc.pages.add();
              newPage.graphics.drawPdfTemplate(template, const Offset(0, 0));
            }

            final file = File('${bookDir.path}/${unit.id}.pdf');
            await file.writeAsBytes(await newDoc.save());
            newDoc.dispose();

            updatedUnits.add(unit.copyWith(pdfPath: file.path, isGenerated: false, lessons: []));
          } else {
            updatedUnits.add(unit.copyWith(isGenerated: false, lessons: []));
          }
        }
        updatedSections.add(section.copyWith(units: updatedUnits));
      }
      updatedModules.add(module.copyWith(sections: updatedSections));
    }
    sourceDoc.dispose();

    return book.copyWith(modules: updatedModules);
  }
}