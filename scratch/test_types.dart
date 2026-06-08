import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sync_pdf;

void main() {
  final doc = sync_pdf.PdfDocument();
  final bookmarks = doc.bookmarks;
  print("Bookmarks type: ${bookmarks.runtimeType}");
  doc.dispose();
}
