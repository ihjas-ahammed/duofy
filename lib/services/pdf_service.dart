import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../models/app_models.dart';

class PdfService {
  /// True Physical Splitting using Page Removal inside an Isolate.
  /// This fully offloads synchronous PDF parsing rendering it perfectly async,
  /// preventing dropped frames during background chunking operations.
  Future<Book> splitBookPdf(File originalPdf, Book book) async {
    final bytes = await originalPdf.readAsBytes();
    
    final dir = await getApplicationDocumentsDirectory();
    final bookDirPath = '${dir.path}/books/${book.id}';
    final bookDir = Directory(bookDirPath);
    if (!await bookDir.exists()) await bookDir.create(recursive: true);

    // Offload heavy memory calculations and chunking to a background Isolate
    return await compute(_splitPdfTask, {
      'bytes': bytes,
      'book': book.toJson(),
      'bookDirPath': bookDirPath,
    });
  }

  // Pure static task for Isolate execution
  static Future<Book> _splitPdfTask(Map<String, dynamic> params) async {
    final Uint8List bytes = params['bytes'];
    final Book book = Book.fromJson(params['book']);
    final String bookDirPath = params['bookDirPath'];

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

            final PdfDocument newDoc = PdfDocument(inputBytes: bytes);
            
            for (int i = newDoc.pages.count - 1; i > end; i--) {
              newDoc.pages.removeAt(i);
            }
            for (int i = start - 1; i >= 0; i--) {
              newDoc.pages.removeAt(i);
            }

            final filePath = '$bookDirPath/${unit.id}.pdf';
            final file = File(filePath);
            
            // Synchronously save in Isolate to avoid inner event loop bottlenecks
            file.writeAsBytesSync(newDoc.saveSync());
            newDoc.dispose();

            updatedUnits.add(unit.copyWith(pdfPath: filePath, isGenerated: false, lessons: []));
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