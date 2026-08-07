import 'dart:io';
import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sync_pdf;
import 'package:flow/services/module_notes_html_builder.dart';

void main() {
  test('ModuleNotesHtmlBuilder generates valid HTML string', () {
    final html = ModuleNotesHtmlBuilder.buildHtml(
      chapterNumber: 'Section 1',
      chapterTitle: 'Binary Operations',
      notesJson: {
        'sections': [
          {
            'sectionHeading': '1. Theory & Core Concepts',
            'contentParagraphs': ['Abstract algebra introduces binary operations on sets.'],
            'warningBoxes': [
              {
                'title': 'Two Essential Conditions',
                'content': ['Everywhere defined', 'Closure']
              }
            ],
            'definitions': [
              {
                'number': '1.1',
                'title': 'Definition (Binary Operation)',
                'tag': 'Definition',
                'content': 'A binary operation on a set S maps S x S into S.',
              }
            ],
            'examples': [
              {
                'title': '1.3 Example: Matrix Addition',
                'statusTag': 'Not an Operation',
                'statusType': 'invalid',
                'content': 'Undefined for matrices of different sizes.'
              }
            ]
          }
        ]
      },
    );

    expect(html, contains('Binary Operations'));
    expect(html, contains('Everywhere defined'));
    expect(html, contains('1.1 Definition (Binary Operation)'));
  });

  test('Native Syncfusion PDF layout builds valid, multi-element PDF', () {
    final sync_pdf.PdfDocument document = sync_pdf.PdfDocument();
    document.pageSettings.margins.all = 36;
    
    sync_pdf.PdfPage page = document.pages.add();
    double y = 0;

    final titleFont = sync_pdf.PdfStandardFont(sync_pdf.PdfFontFamily.helvetica, 18, style: sync_pdf.PdfFontStyle.bold);
    final headingFont = sync_pdf.PdfStandardFont(sync_pdf.PdfFontFamily.helvetica, 12, style: sync_pdf.PdfFontStyle.bold);
    final bodyFont = sync_pdf.PdfStandardFont(sync_pdf.PdfFontFamily.helvetica, 10);
    final boldBodyFont = sync_pdf.PdfStandardFont(sync_pdf.PdfFontFamily.helvetica, 10, style: sync_pdf.PdfFontStyle.bold);

    // Title
    final titleResult = sync_pdf.PdfTextElement(text: 'Section 1: Binary Operations', font: titleFont).draw(
      page: page,
      bounds: Rect.fromLTWH(0, y, page.getClientSize().width, 40),
    )!;
    y = titleResult.bounds.bottom + 10;

    // Line
    page.graphics.drawLine(sync_pdf.PdfPen(sync_pdf.PdfColor(0, 0, 0), width: 1.5), Offset(0, y), Offset(page.getClientSize().width, y));
    y += 15;

    // Heading
    final headingResult = sync_pdf.PdfTextElement(text: '1. THEORY & CORE CONCEPTS', font: headingFont).draw(
      page: page,
      bounds: Rect.fromLTWH(0, y, page.getClientSize().width, 30),
    )!;
    y = headingResult.bounds.bottom + 10;

    // Paragraph
    final pResult = sync_pdf.PdfTextElement(
      text: 'A binary operation on a set S is a rule assigning each ordered pair of elements of S a unique element of S.',
      font: bodyFont,
    ).draw(
      page: page,
      bounds: Rect.fromLTWH(0, y, page.getClientSize().width, page.getClientSize().height - y),
    )!;
    y = pResult.bounds.bottom + 15;

    // Box (Warning / Env box)
    page.graphics.drawRectangle(
      pen: sync_pdf.PdfPen(sync_pdf.PdfColor(30, 30, 30), width: 1),
      brush: sync_pdf.PdfSolidBrush(sync_pdf.PdfColor(250, 250, 250)),
      bounds: Rect.fromLTWH(0, y, page.getClientSize().width, 60),
    );
    page.graphics.drawString('DEFINITION 1.1 (Binary Operation)', boldBodyFont, bounds: Rect.fromLTWH(10, y + 8, page.getClientSize().width - 20, 20));
    page.graphics.drawString('A binary operation * on a set S is a function mapping S x S into S.', bodyFont, bounds: Rect.fromLTWH(10, y + 28, page.getClientSize().width - 20, 30));
    y += 75;

    final bytes = document.saveSync();
    document.dispose();

    final file = File('/tmp/test_native_notes.pdf');
    file.writeAsBytesSync(bytes);

    expect(file.existsSync(), isTrue);
    expect(bytes.length, greaterThan(500));

    // Verify loading PDF back
    final testReadDoc = sync_pdf.PdfDocument(inputBytes: bytes);
    expect(testReadDoc.pages.count, equals(1));
    testReadDoc.dispose();
  });
}
