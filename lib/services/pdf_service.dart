import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../models/app_models.dart';

class PdfService {
  /// True Physical Splitting using Page Removal
  /// This guarantees exact original margins, dimensions, and significantly smaller file sizes
  /// by not wrapping pages inside graphical templates.
  Future<Book> splitBookPdf(File originalPdf, Book book) async {
    final bytes = await originalPdf.readAsBytes();
    
    final dir = await getApplicationDocumentsDirectory();
    final bookDir = Directory('${dir.path}/books/${book.id}');
    if (!await bookDir.exists()) await bookDir.create(recursive: true);

    // Pre-calculate total pages to prevent index out of bounds
    final dummyDoc = PdfDocument(inputBytes: bytes);
    final int totalPages = dummyDoc.pages.count;
    dummyDoc.dispose();

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

            // Load fresh document for physical split
            final PdfDocument newDoc = PdfDocument(inputBytes: bytes);
            
            // Critical: Remove trailing pages first so indices of lower pages aren't shifted
            for (int i = newDoc.pages.count - 1; i > end; i--) {
              newDoc.pages.removeAt(i);
            }
            // Remove leading pages
            for (int i = start - 1; i >= 0; i--) {
              newDoc.pages.removeAt(i);
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

    return book.copyWith(modules: updatedModules);
  }
}