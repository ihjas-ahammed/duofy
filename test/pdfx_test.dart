import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow/services/pdf_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    // Mock the path_provider method channel
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'getTemporaryDirectory') {
          return Directory.systemTemp.path;
        }
        if (methodCall.method == 'getApplicationDocumentsDirectory') {
          return Directory.systemTemp.path;
        }
        return null;
      },
    );
  });

  group('PdfService Tests', () {
    final file = File('METACOGNITION.pdf');

    test('Verify METACOGNITION.pdf file exists', () {
      expect(file.existsSync(), true);
    });

    test('Extract text from PDF (Syncfusion - pure Dart)', () async {
      final text = await PdfService().extractTextFromPdf(file);
      print('Extracted text preview: ${text.length > 200 ? text.substring(0, 200) : text}');
      expect(text, isNotEmpty);
      expect(text.toLowerCase(), contains('metacognition'));
    });

    test('Extract single page to a new PDF file (Syncfusion - pure Dart)', () async {
      final singlePagePdf = await PdfService().extractPages(file, [1]);
      expect(singlePagePdf.existsSync(), true);
      expect(await singlePagePdf.length(), greaterThan(0));

      final text = await PdfService().extractTextFromPdf(singlePagePdf);
      expect(text, isNotEmpty);

      // Clean up temp file
      if (singlePagePdf.existsSync()) {
        await singlePagePdf.delete();
      }
    });

    test('Render page to image (pdfx with pdftoppm Linux fallback)', () async {
      final imgBytes = await PdfService().renderPageToImage(file, 1);
      
      // If we are in a unit test environment on a non-Linux platform, or if pdftoppm is not installed on Linux,
      // we might not get rendered bytes. Let's check for fallback availability to avoid spurious failures.
      bool hasPdftoppm = false;
      if (Platform.isLinux) {
        try {
          final result = await Process.run('which', ['pdftoppm']);
          hasPdftoppm = result.exitCode == 0;
        } catch (_) {}
      }

      if (!Platform.isLinux || !hasPdftoppm) {
        print('Skipping image verification assertions because rendering is not supported on this platform/environment configuration.');
        return;
      }

      expect(imgBytes, isNotNull);
      expect(imgBytes!.length, greaterThan(0));
      print('Rendered page 1 to image. Bytes count: ${imgBytes.length}');
    });
  });
}
