import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sync_pdf;

/// Standalone test verifying Syncfusion PDF math rendering & text extraction
void main() {
  test('Empirically test Syncfusion PDF TeX math translation and page drawing', () async {
    final document = sync_pdf.PdfDocument();
    document.pageSettings.margins.all = 36;
    document.pageSettings.size = sync_pdf.PdfPageSize.a4;

    final titleFont = sync_pdf.PdfStandardFont(sync_pdf.PdfFontFamily.helvetica, 18, style: sync_pdf.PdfFontStyle.bold);
    final headingFont = sync_pdf.PdfStandardFont(sync_pdf.PdfFontFamily.helvetica, 12, style: sync_pdf.PdfFontStyle.bold);
    final bodyFont = sync_pdf.PdfStandardFont(sync_pdf.PdfFontFamily.helvetica, 10);
    final boldFont = sync_pdf.PdfStandardFont(sync_pdf.PdfFontFamily.helvetica, 10, style: sync_pdf.PdfFontStyle.bold);
    final italicFont = sync_pdf.PdfStandardFont(sync_pdf.PdfFontFamily.helvetica, 10, style: sync_pdf.PdfFontStyle.italic);

    final sync_pdf.PdfPage page = document.pages.add();
    double y = 10;

    // Header
    final titleRes = sync_pdf.PdfTextElement(text: 'MODULE 1: ABSTRACT ALGEBRA', font: titleFont).draw(
      page: page,
      bounds: Rect.fromLTWH(0, y, page.getClientSize().width, 30),
    )!;
    y = titleRes.bounds.bottom + 10;

    page.graphics.drawLine(sync_pdf.PdfPen(sync_pdf.PdfColor(0, 0, 0), width: 1.5), Offset(0, y), Offset(page.getClientSize().width, y));
    y += 15;

    // Section 1: Theory & Math Formats
    final rawTheory = r'A group (G, *) is a set G together with a binary operation * satisfying closure, associativity, identity, and inverses: \forall a, b \in G, a \cdot b \in G.';
    final cleanedTheory = cleanLatexForSyncfusion(rawTheory);

    final h1Res = sync_pdf.PdfTextElement(text: '1. THEORY & CORE CONCEPTS', font: headingFont).draw(
      page: page,
      bounds: Rect.fromLTWH(0, y, page.getClientSize().width, 24),
    )!;
    y = h1Res.bounds.bottom + 6;

    final p1Res = sync_pdf.PdfTextElement(text: cleanedTheory, font: bodyFont).draw(
      page: page,
      bounds: Rect.fromLTWH(0, y, page.getClientSize().width, 100),
    )!;
    y = p1Res.bounds.bottom + 12;

    // Section 2: Definitions & Theorems
    final rawDef = r'Theorem 1.1: For any element a \in G, the set \langle a \rangle = \{a^n : n \in \mathbb{Z}\} forms a cyclic subgroup of G.';
    final cleanedDef = cleanLatexForSyncfusion(rawDef);
    final rawProof = r'Proof: Since a \cdot a^{-1} = e, the identity e \in \langle a \rangle. \blacksquare';
    final cleanedProof = cleanLatexForSyncfusion(rawProof);

    page.graphics.drawRectangle(
      pen: sync_pdf.PdfPen(sync_pdf.PdfColor(30, 30, 30), width: 1),
      brush: sync_pdf.PdfSolidBrush(sync_pdf.PdfColor(250, 250, 250)),
      bounds: Rect.fromLTWH(0, y, page.getClientSize().width, 70),
    );
    page.graphics.drawString('THEOREM 1.1 [THEOREM]', boldFont, bounds: Rect.fromLTWH(8, y + 6, page.getClientSize().width - 16, 16));
    page.graphics.drawString(cleanedDef, bodyFont, bounds: Rect.fromLTWH(8, y + 24, page.getClientSize().width - 16, 40));
    y += 80;

    page.graphics.drawLine(sync_pdf.PdfPen(sync_pdf.PdfColor(80, 80, 80), width: 2), Offset(10, y), Offset(10, y + 30));
    page.graphics.drawString(cleanedProof, italicFont, bounds: Rect.fromLTWH(18, y + 6, page.getClientSize().width - 20, 25));
    y += 40;

    // Display Equations & Fractions / Integrals
    final rawDisplay = r'Integral identity: \int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi} and \frac{a}{b} + \frac{c}{d} = \frac{ad + bc}{bd}';
    final cleanedDisplay = cleanLatexForSyncfusion(rawDisplay);

    final p2Res = sync_pdf.PdfTextElement(text: cleanedDisplay, font: boldFont).draw(
      page: page,
      bounds: Rect.fromLTWH(0, y, page.getClientSize().width, 60),
    )!;
    y = p2Res.bounds.bottom + 10;

    final bytes = document.saveSync();
    document.dispose();

    final testPdfFile = File('test_syncfusion_output.pdf');
    await testPdfFile.writeAsBytes(bytes);
    print('[SyncfusionTest] Saved PDF: ${bytes.length} bytes to ${testPdfFile.path}');

    // Extract text from the generated Syncfusion PDF using PdfTextExtractor
    final readDoc = sync_pdf.PdfDocument(inputBytes: bytes);
    final extractor = sync_pdf.PdfTextExtractor(readDoc);
    final extractedText = extractor.extractText();
    readDoc.dispose();

    print('\n================ EXTRACTED TEXT FROM SYNCFUSION PDF ================');
    print(extractedText);
    print('====================================================================\n');

    expect(bytes.length, greaterThan(1000));
    expect(extractedText.contains('ABSTRACT ALGEBRA'), isTrue);
    expect(extractedText.contains('subgroup'), isTrue);
    expect(extractedText.contains('integral'), isTrue);
    expect(extractedText.contains('infinity'), isTrue);

    if (testPdfFile.existsSync()) {
      testPdfFile.deleteSync();
    }
  });
}

String cleanLatexForSyncfusion(String text) {
  final cleaned = text
      .replaceAll(RegExp(r'\$\\blacksquare\$'), '[Q.E.D.]')
      .replaceAll(RegExp(r'\\blacksquare'), '[Q.E.D.]')
      .replaceAll(RegExp(r'\\alpha'), 'alpha')
      .replaceAll(RegExp(r'\\beta'), 'beta')
      .replaceAll(RegExp(r'\\gamma'), 'gamma')
      .replaceAll(RegExp(r'\\delta'), 'delta')
      .replaceAll(RegExp(r'\\theta'), 'theta')
      .replaceAll(RegExp(r'\\lambda'), 'lambda')
      .replaceAll(RegExp(r'\\pi'), 'pi')
      .replaceAll(RegExp(r'\\sigma'), 'sigma')
      .replaceAll(RegExp(r'\\phi'), 'phi')
      .replaceAll(RegExp(r'\\omega'), 'omega')
      .replaceAll(RegExp(r'\\mathbb\{R\}'), 'R')
      .replaceAll(RegExp(r'\\mathbb\{Z\}'), 'Z')
      .replaceAll(RegExp(r'\\mathbb\{N\}'), 'N')
      .replaceAll(RegExp(r'\\mathbb\{Q\}'), 'Q')
      .replaceAll(RegExp(r'\\mathbb\{C\}'), 'C')
      .replaceAll(RegExp(r'\\infty'), 'infinity')
      .replaceAll(RegExp(r'\\int'), 'integral ')
      .replaceAll(RegExp(r'\\notin'), ' not in ')
      .replaceAll(RegExp(r'\\in\b'), ' in ')
      .replaceAll(RegExp(r'\\subseteq'), ' subset= ')
      .replaceAll(RegExp(r'\\subset'), ' subset ')
      .replaceAll(RegExp(r'\\cup'), ' union ')
      .replaceAll(RegExp(r'\\cap'), ' intersect ')
      .replaceAll(RegExp(r'\\cdot'), ' * ')
      .replaceAll(RegExp(r'\\times'), ' x ')
      .replaceAll(RegExp(r'\\rightarrow'), ' -> ')
      .replaceAll(RegExp(r'\\Rightarrow'), ' => ')
      .replaceAll(RegExp(r'\\Leftrightarrow'), '<=>')
      .replaceAll(RegExp(r'\\forall'), 'for all ')
      .replaceAll(RegExp(r'\\exists'), 'exists ')
      .replaceAll(RegExp(r'\\neq'), '!=')
      .replaceAll(RegExp(r'\\leq'), '<=')
      .replaceAll(RegExp(r'\\geq'), '>=')
      .replaceAll(RegExp(r'\\langle'), '<')
      .replaceAll(RegExp(r'\\rangle'), '>')
      .replaceAll(RegExp(r'\\sqrt'), 'sqrt')
      .replaceAll(RegExp(r'\\frac\{([^}]+)\}\{([^}]+)\}'), r'(\1 / \2)')
      .replaceAll(RegExp(r'[\$\\]'), '');

  final buffer = StringBuffer();
  for (final rune in cleaned.runes) {
    if (rune <= 255) {
      buffer.writeCharCode(rune);
    } else {
      buffer.write(' ');
    }
  }
  return buffer.toString();
}
