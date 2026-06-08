import 'package:syncfusion_flutter_pdf/pdf.dart' as sync_pdf;

void test(sync_pdf.PdfBookmark bookmark, sync_pdf.PdfDocument doc) {
  final String title = bookmark.title;
  final sync_pdf.PdfDestination? destination = bookmark.destination;
  final sync_pdf.PdfAction? action = bookmark.action;
  
  // Test if bookmark inherits from PdfBookmarkCollection or has indexer
  final int count = bookmark.count;
  final sync_pdf.PdfBookmark kid = bookmark[0];
  print("Title: $title, Kids count: $count, Kid title: ${kid.title}");
}

void main() {
  print("Compiles fine!");
}
