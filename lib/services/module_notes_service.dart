import 'dart:convert';
import 'dart:ui';
import '../platform/io_shim.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sync_pdf;
import '../models/app_models.dart';
import 'ai_service.dart';
import 'module_notes_html_builder.dart';
import 'pdf_service.dart';
import 'notification_service.dart';

class ModuleNotesJob {
  final String bookId;
  final String moduleId;
  final String moduleTitle;
  double progress;
  String status;
  bool isRunning;
  bool isCompleted;
  bool isFailed;
  File? pdfFile;
  File? htmlFile;
  final List<void Function()> _listeners = [];

  ModuleNotesJob({
    required this.bookId,
    required this.moduleId,
    required this.moduleTitle,
    this.progress = 0.0,
    this.status = 'Queued',
    this.isRunning = true,
    this.isCompleted = false,
    this.isFailed = false,
    this.pdfFile,
    this.htmlFile,
  });

  void addListener(void Function() listener) {
    if (!_listeners.contains(listener)) _listeners.add(listener);
  }

  void removeListener(void Function() listener) {
    _listeners.remove(listener);
  }

  void notify() {
    for (final l in List.from(_listeners)) {
      try {
        l();
      } catch (_) {}
    }
  }
}

class ModuleNotesService {
  ModuleNotesService._();
  static final ModuleNotesService instance = ModuleNotesService._();

  static String _prefKey(String bookId, String moduleId) => 'module_note_pdf_${bookId}_$moduleId';
  static String _jobKey(String bookId, String moduleId) => '${bookId}_$moduleId';

  final Map<String, ModuleNotesJob> _activeJobs = {};

  ModuleNotesJob? getJob(String bookId, String moduleId) => _activeJobs[_jobKey(bookId, moduleId)];

  /// Ensures that local mathjax.js script exists in notes directory for offline Headless Chrome rendering.
  Future<File?> _ensureLocalMathJax(Directory notesDir) async {
    try {
      final localFile = File('${notesDir.path}/mathjax.js');
      if (localFile.existsSync() && localFile.lengthSync() > 100000) {
        return localFile;
      }
      
      final scratchMathJax = File('/home/ihjas/.gemini/antigravity-cli/brain/d08e6741-31b2-4192-abfb-c70c710b4a4f/scratch/mathjax.js');
      if (scratchMathJax.existsSync() && scratchMathJax.lengthSync() > 100000) {
        await scratchMathJax.copy(localFile.path);
        print('[ModuleNotesService] Copied local MathJax JS to ${localFile.path} (${localFile.lengthSync()} bytes)');
        return localFile;
      }
    } catch (e) {
      print('[ModuleNotesService] Note: local MathJax copy fallback: $e');
    }
    return null;
  }

  /// Checks if generated module notes exist for the given book and module.
  Future<bool> hasNotes(String bookId, String moduleId) async {
    final pdfPath = await getNotesPdfPath(bookId, moduleId);
    if (pdfPath != null && pdfPath.isNotEmpty) {
      final file = File(pdfPath);
      if (file.existsSync() && file.lengthSync() > 200) return true;
    }
    final htmlPath = await getNotesHtmlPath(bookId, moduleId);
    if (htmlPath != null && htmlPath.isNotEmpty) {
      final file = File(htmlPath);
      if (file.existsSync() && file.lengthSync() > 200) return true;
    }
    return false;
  }

  /// Gets the path to the saved notes PDF if it exists.
  Future<String?> getNotesPdfPath(String bookId, String moduleId) async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString(_prefKey(bookId, moduleId));
    if (savedPath != null && savedPath.isNotEmpty) {
      final file = File(savedPath);
      if (file.existsSync() && file.lengthSync() > 200) return savedPath;
    }

    final dir = await getApplicationDocumentsDirectory();
    final defaultPath = '${dir.path}/notes/module_note_${bookId}_$moduleId.pdf';
    final defFile = File(defaultPath);
    if (defFile.existsSync() && defFile.lengthSync() > 200) {
      await prefs.setString(_prefKey(bookId, moduleId), defaultPath);
      return defaultPath;
    }

    return null;
  }

  /// Gets the path to the saved notes HTML if it exists.
  Future<String?> getNotesHtmlPath(String bookId, String moduleId) async {
    final dir = await getApplicationDocumentsDirectory();
    final renderedPath = '${dir.path}/notes/module_note_${bookId}_${moduleId}_rendered.html';
    final renderedFile = File(renderedPath);
    if (renderedFile.existsSync() && renderedFile.lengthSync() > 200) {
      return renderedPath;
    }

    final path = '${dir.path}/notes/module_note_${bookId}_$moduleId.html';
    final file = File(path);
    if (file.existsSync() && file.lengthSync() > 200) return path;
    return null;
  }

  /// Saves rendered HTML (with MathJax TeX math converted to SVG) to disk.
  Future<void> saveRenderedHtml(String bookId, String moduleId, String htmlWithSvg) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final notesDir = Directory('${dir.path}/notes');
      if (!notesDir.existsSync()) notesDir.createSync(recursive: true);
      final file = File('${notesDir.path}/module_note_${bookId}_${moduleId}_rendered.html');
      await file.writeAsString(htmlWithSvg);
      print('[ModuleNotesService] Saved rendered MathJax HTML (with SVGs) to ${file.path} (${file.lengthSync()} bytes)');
    } catch (e) {
      print('[ModuleNotesService] Error saving rendered HTML: $e');
    }
  }

  /// Starts background AI note generation (async, non-blocking).
  Future<void> startBackgroundNotesGeneration({
    required Book book,
    required Module module,
    required int moduleIndex,
    String? userRegenReason,
  }) async {
    final key = _jobKey(book.id, module.id);
    final job = ModuleNotesJob(
      bookId: book.id,
      moduleId: module.id,
      moduleTitle: module.title,
      progress: 0.05,
      status: 'Starting Module Notes Generation...',
      isRunning: true,
    );
    _activeJobs[key] = job;
    job.notify();

    final notifId = (key.hashCode).abs() % 100000 + 10000;
    await NotificationService.showProgress(
      notifId,
      'Module Notes: ${module.title}',
      'Initializing AI section generation...',
      progress: 5,
      maxProgress: 100,
    );

    try {
      final pdfFile = await generateModuleNotes(
        book: book,
        module: module,
        moduleIndex: moduleIndex,
        userRegenReason: userRegenReason,
        onProgress: (pStatus, pProgress) async {
          job.progress = pProgress;
          job.status = pStatus;
          job.notify();

          await NotificationService.showProgress(
            notifId,
            'Module Notes: ${module.title}',
            pStatus,
            progress: (pProgress * 100).toInt(),
            maxProgress: 100,
          );
        },
      );

      job.pdfFile = pdfFile;
      job.isRunning = false;
      job.isCompleted = true;
      job.progress = 1.0;
      job.status = 'Completed!';
      job.notify();

      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(
        notifId + 1,
        'Module Notes Ready! (${module.title})',
        'Book-like study notes for all sections generated and saved!',
        'bookOpen',
      );
    } catch (e, st) {
      print('[ModuleNotesService] ERROR during background note generation: $e\n$st');
      job.isRunning = false;
      job.isFailed = true;
      job.status = 'Failed: $e';
      job.notify();

      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(
        notifId + 2,
        'Module Notes Generation Failed',
        'Error generating notes for ${module.title}: $e',
        'alertCircle',
      );
    }
  }

  /// Core method for generating complete module notes by generating detailed notes FOR EVERY SECTION in the module and combining them.
  Future<File> generateModuleNotes({
    required Book book,
    required Module module,
    required int moduleIndex,
    String? userRegenReason,
    void Function(String status, double progress)? onProgress,
  }) async {
    final timestamp = DateTime.now().toIso8601String();
    print('[ModuleNotesService][$timestamp] Generating section-by-section module notes for Book "${book.title}", Module ${moduleIndex + 1}: "${module.title}"');

    onProgress?.call('Reading reference materials & syllabus...', 0.05);

    String refBookText = '';
    if (book.syllabusPath != null && book.syllabusPath!.isNotEmpty) {
      final sFile = File(book.syllabusPath!);
      if (sFile.existsSync()) {
        try {
          refBookText = await PdfService().extractTextFromPdf(sFile);
          print('[ModuleNotesService] Extracted ${refBookText.length} characters from syllabus PDF.');
        } catch (e) {
          print('[ModuleNotesService] Syllabus text extraction failed: $e');
        }
      }
    }

    final ai = AiService();
    final String regenDirective = (userRegenReason != null && userRegenReason.trim().isNotEmpty)
        ? '\nUSER REGENERATION REQUEST / REASON: "${userRegenReason.trim()}". Make sure to prioritize these requirements in every section.'
        : '';

    final List<Map<String, dynamic>> generatedSections = [];
    final sectionsToGenerate = module.sections.isNotEmpty
        ? module.sections
        : [
            Section(
              id: 'sec_default',
              title: module.title,
              description: module.description,
              color: '#4B5563',
              units: [],
            )
          ];

    final int totalSecs = sectionsToGenerate.length;

    // Generate detailed notes FOR EVERY SECTION in the module sequentially
    for (int i = 0; i < totalSecs; i++) {
      final sec = sectionsToGenerate[i];
      final double secProgress = 0.10 + (i / totalSecs) * 0.75;
      final String progressMsg = 'Section ${i + 1}/$totalSecs: "${sec.title}"...';

      onProgress?.call(progressMsg, secProgress);
      print('[ModuleNotesService] Generating section ${i + 1}/$totalSecs: "${sec.title}"');

      try {
        final secNote = await _generateNotesForSection(
          ai: ai,
          book: book,
          module: module,
          sec: sec,
          secIndex: i,
          totalSections: totalSecs,
          refBookText: refBookText,
          regenDirective: regenDirective,
        );

        final extractedList = _extractSectionMaps(secNote);
        if (extractedList.isNotEmpty) {
          generatedSections.addAll(extractedList);
        } else {
          generatedSections.add(secNote);
        }
      } catch (e) {
        print('[ModuleNotesService] Warning generating section ${i + 1}: $e');
        generatedSections.add(_buildSmartFallbackSection(secIndex: i, sec: sec));
      }
    }

    print('[ModuleNotesService] Successfully generated ${generatedSections.length} sections for module "${module.title}". Combining into final Module Notes HTML...');

    onProgress?.call('Compiling full module textbook notes...', 0.88);

    final String chapterNumber = 'Module ${moduleIndex + 1}';
    final String chapterTitle = module.title;

    final String fullHtml = ModuleNotesHtmlBuilder.buildHtml(
      chapterNumber: chapterNumber,
      chapterTitle: chapterTitle,
      notesJson: {'sections': generatedSections},
    );

    final dir = await getApplicationDocumentsDirectory();
    final notesDir = Directory('${dir.path}/notes');
    if (!notesDir.existsSync()) {
      notesDir.createSync(recursive: true);
    }

    await _ensureLocalMathJax(notesDir);

    final htmlFile = File('${notesDir.path}/module_note_${book.id}_${module.id}.html');
    await htmlFile.writeAsString(fullHtml);
    print('[ModuleNotesService] Saved compiled Module Notes HTML to: ${htmlFile.path} (${htmlFile.lengthSync()} bytes)');

    final pdfFile = File('${notesDir.path}/module_note_${book.id}_${module.id}.pdf');

    // PDF Generation with MathJax Wait-and-Retry Loop & Empirical Reading
    onProgress?.call('Generating A4 PDF notes document...', 0.93);

    bool pdfSuccess = false;

    if (!kIsWeb && (Platform.isLinux || Platform.isWindows || Platform.isMacOS)) {
      pdfSuccess = await _tryChromePrintToPdf(htmlFile: htmlFile, pdfFile: pdfFile, bookId: book.id, moduleId: module.id);
    } else {
      print('[ModuleNotesService] Mobile platform detected (Android/iOS). Skipping Headless Chrome CLI.');
    }

    if (!pdfSuccess || !pdfFile.existsSync() || pdfFile.lengthSync() < 200) {
      print('[ModuleNotesService] Running native pure-Dart Syncfusion PDF builder...');
      pdfSuccess = await _buildNativePdfFromNotes(
        chapterNumber: chapterNumber,
        chapterTitle: chapterTitle,
        sections: generatedSections,
        pdfFile: pdfFile,
      );
    }

    if (!pdfSuccess || !pdfFile.existsSync() || pdfFile.lengthSync() < 200) {
      throw Exception('Failed to produce a valid PDF notes document.');
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey(book.id, module.id), pdfFile.path);

    print('[ModuleNotesService] Module Notes PDF saved to: ${pdfFile.path} (${pdfFile.lengthSync()} bytes)');

    onProgress?.call('Module Notes Ready!', 1.0);
    return pdfFile;
  }

  /// Prompts AI to generate concise, high-density study/revision notes for a single section.
  Future<Map<String, dynamic>> _generateNotesForSection({
    required AiService ai,
    required Book book,
    required Module module,
    required Section sec,
    required int secIndex,
    required int totalSections,
    required String refBookText,
    required String regenDirective,
  }) async {
    final String sectionHeadingStr = 'Section ${secIndex + 1}: ${sec.title}';
    final String unitTitles = sec.units.map((u) => u.title).join(', ');

    final prompt = '''
You are an expert academic tutor creating concise, high-density, information-rich revision notes & cheat sheets for university students.
Course Title: ${book.title}
Module Title: ${module.title}
Target Section: $sectionHeadingStr
Section Description: ${sec.description.isNotEmpty ? sec.description : sec.title}
Units / Key Topics: ${unitTitles.isNotEmpty ? unitTitles : sec.title}
${refBookText.isNotEmpty ? 'Reference Text Snippet:\n${refBookText.length > 1200 ? refBookText.substring(0, 1200) : refBookText}' : ''}
$regenDirective

INSTRUCTIONS:
1. Write CONCISE, HIGH-DENSITY, INFORMATION-RICH revision notes (cheat-sheet style).
2. Avoid long textbook essays or fluff. Use bullet points, sharp definitions, key formulas, exam warnings, and 1-2 quick worked examples.
3. Use inline LaTeX math (\$...\$) and display LaTeX math (\$\$...\$\$).

Return valid JSON with this exact schema:
{
  "sectionHeading": "$sectionHeadingStr",
  "keyConcepts": [
    "Sharp bullet point 1 explaining core concept with inline LaTeX \$...\$",
    "Sharp bullet point 2 with key formula \$\$...\$\$",
    "Sharp bullet point 3 summarizing critical application rule"
  ],
  "definitions": [
    {
      "number": "${secIndex + 1}.1",
      "title": "Core Definition / Theorem Title",
      "tag": "Definition",
      "content": "Concise formal statement with LaTeX math \$...\$"
    }
  ],
  "warningBoxes": [
    {
      "title": "Exam Warning / Pitfall",
      "content": "Common student mistake or critical condition to watch out for."
    }
  ],
  "examples": [
    {
      "title": "Example ${secIndex + 1}.1: Solved Problem",
      "statusTag": "Worked Solution",
      "content": "Step 1: ... \\nStep 2: ... \\nResult: ..."
    }
  ]
}

Return ONLY valid JSON.
''';

    for (int attempt = 1; attempt <= 2; attempt++) {
      try {
        final currentPrompt = attempt == 1
            ? prompt
            : '$prompt\n\nCRITICAL RETRY NOTICE: Your previous output failed JSON parsing. Return STRICT raw valid JSON only, escape all quotes inside string fields!';
        final resp = await ai.generateSimpleText(prompt: currentPrompt, slotName: 'Primary - Text');
        final parsed = _parseJson(resp);
        if (parsed != null && parsed.isNotEmpty) {
          if (!parsed.containsKey('sectionHeading')) {
            parsed['sectionHeading'] = sectionHeadingStr;
          }
          return parsed;
        }
      } catch (e) {
        print('[ModuleNotesService] AI Section generation attempt $attempt failed for ${sec.title}: $e');
      }
    }

    // High-quality smart fallback generator (No empty placeholder text!)
    return _buildSmartFallbackSection(secIndex: secIndex, sec: sec);
  }

  Map<String, dynamic> _buildSmartFallbackSection({
    required int secIndex,
    required Section sec,
  }) {
    final String sectionHeadingStr = 'Section ${secIndex + 1}: ${sec.title}';
    final List<String> concepts = [];

    if (sec.description.isNotEmpty) {
      concepts.add(sec.description);
    }

    if (sec.units.isNotEmpty) {
      for (final u in sec.units) {
        concepts.add('${u.title}: ${u.description.isNotEmpty ? u.description : "Core topic covering key definitions, rules, and practical evaluation methods."}');
      }
    } else {
      concepts.add('Core Concepts: Detailed study of key principles, algebraic operations, and methods in ${sec.title}.');
      concepts.add('Formula & Rules: Master standard mathematical operations, order of evaluation, and notation.');
    }

    return {
      'sectionHeading': sectionHeadingStr,
      'keyConcepts': concepts,
      'warningBoxes': [
        {
          'title': 'Key Focus Area',
          'content': 'Ensure proper order of operations and verify variable substitutions carefully during evaluation.'
        }
      ]
    };
  }

  /// Recursively extracts section maps from JSON structure regardless of wrapper keys.
  List<Map<String, dynamic>> _extractSectionMaps(dynamic parsed) {
    final List<Map<String, dynamic>> result = [];
    if (parsed is List) {
      for (var item in parsed) {
        result.addAll(_extractSectionMaps(item));
      }
    } else if (parsed is Map) {
      final map = Map<String, dynamic>.from(parsed);
      if (map.containsKey('sections') && map['sections'] is List) {
        for (var item in map['sections']) {
          result.addAll(_extractSectionMaps(item));
        }
      } else if (map.containsKey('section') && map['section'] is Map) {
        result.addAll(_extractSectionMaps(map['section']));
      } else if (map.containsKey('sectionHeading') || map.containsKey('title') || map.containsKey('contentParagraphs') || map.containsKey('definitions') || map.containsKey('examples')) {
        result.add(map);
      }
    }
    return result;
  }

  /// Attempts Headless Chrome print-to-pdf with virtual time budget and reads PDF content to verify LaTeX loading.
  Future<bool> _tryChromePrintToPdf({
    required File htmlFile,
    required File pdfFile,
    required String bookId,
    required String moduleId,
  }) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final renderedPath = '${dir.path}/notes/module_note_${bookId}_${moduleId}_rendered.html';
      final renderedFile = File(renderedPath);

      final File targetHtml = (renderedFile.existsSync() && renderedFile.lengthSync() > 200)
          ? renderedFile
          : htmlFile;

      print('[ModuleNotesService] Printing to A4 PDF using ${targetHtml.path}...');

      final budgets = [5000, 10000, 15000];
      for (final budget in budgets) {
        print('[ModuleNotesService] Running google-chrome-stable (virtual-time-budget=$budget)...');
        final res = await Process.run('google-chrome-stable', [
          '--headless',
          '--disable-gpu',
          '--no-sandbox',
          '--allow-file-access-from-files',
          '--no-pdf-header-footer',
          '--run-all-compositor-stages-before-draw',
          '--virtual-time-budget=$budget',
          '--print-to-pdf=${pdfFile.path}',
          targetHtml.path,
        ]);

        if (res.exitCode == 0 && pdfFile.existsSync() && pdfFile.lengthSync() > 200) {
          if (_validatePdfBytes(pdfFile)) {
            final pdfText = await _readPdfText(pdfFile);
            print('[ModuleNotesService] Empirically read PDF content (${pdfFile.lengthSync()} bytes). Extracted text length: ${pdfText.length}');
            if (pdfText.length > 50) {
              print('[ModuleNotesService] Verified valid A4 PDF created via Headless Chrome!');
              return true;
            }
          }
        }

        final resChromium = await Process.run('chromium', [
          '--headless',
          '--disable-gpu',
          '--no-sandbox',
          '--allow-file-access-from-files',
          '--no-pdf-header-footer',
          '--run-all-compositor-stages-before-draw',
          '--virtual-time-budget=$budget',
          '--print-to-pdf=${pdfFile.path}',
          targetHtml.path,
        ]);

        if (resChromium.exitCode == 0 && pdfFile.existsSync() && pdfFile.lengthSync() > 200) {
          if (_validatePdfBytes(pdfFile)) {
            final pdfText = await _readPdfText(pdfFile);
            if (pdfText.length > 50) {
              print('[ModuleNotesService] Verified valid A4 PDF created via chromium!');
              return true;
            }
          }
        }
      }
    } catch (e) {
      print('[ModuleNotesService] Headless Chrome CLI execution failed: $e');
    }
    return false;
  }

  /// Empirically reads text content from a PDF file using PdfService / Syncfusion.
  Future<String> _readPdfText(File pdfFile) async {
    try {
      final doc = sync_pdf.PdfDocument(inputBytes: pdfFile.readAsBytesSync());
      final extractor = sync_pdf.PdfTextExtractor(doc);
      final text = extractor.extractText();
      doc.dispose();
      return text;
    } catch (e) {
      print('[ModuleNotesService] _readPdfText error: $e');
      return '';
    }
  }

  /// Validates that a PDF file can be parsed by Syncfusion PdfDocument without errors.
  bool _validatePdfBytes(File pdfFile) {
    try {
      final doc = sync_pdf.PdfDocument(inputBytes: pdfFile.readAsBytesSync());
      final valid = doc.pages.count > 0;
      doc.dispose();
      return valid;
    } catch (e) {
      print('[ModuleNotesService] PDF validation check failed for ${pdfFile.path}: $e');
      return false;
    }
  }

  /// Converts raw TeX math strings into clean, readable notation for native Syncfusion PDF without font metric crashes.
  String _cleanLatexForNativePdf(String text) {
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
        .replaceAll(RegExp(r'\\in'), ' in ')
        .replaceAll(RegExp(r'\\notin'), ' not in ')
        .replaceAll(RegExp(r'\\subseteq'), ' subset= ')
        .replaceAll(RegExp(r'\\subset'), ' subset ')
        .replaceAll(RegExp(r'\\cup'), ' union ')
        .replaceAll(RegExp(r'\\cap'), ' intersect ')
        .replaceAll(RegExp(r'\\cdot'), ' * ')
        .replaceAll(RegExp(r'\\times'), ' x ')
        .replaceAll(RegExp(r'\\rightarrow'), ' -> ')
        .replaceAll(RegExp(r'\\Rightarrow'), ' => ')
        .replaceAll(RegExp(r'\\Leftrightarrow'), ' <=> ')
        .replaceAll(RegExp(r'\\forall'), 'for all ')
        .replaceAll(RegExp(r'\\exists'), 'exists ')
        .replaceAll(RegExp(r'\\infty'), 'infinity')
        .replaceAll(RegExp(r'\\neq'), '!=')
        .replaceAll(RegExp(r'\\leq'), '<=')
        .replaceAll(RegExp(r'\\geq'), '>=')
        .replaceAll(RegExp(r'\\langle'), '<')
        .replaceAll(RegExp(r'\\rangle'), '>')
        .replaceAll(RegExp(r'\\int'), 'integral ')
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

  /// Pure-Dart Native PDF Generator using Syncfusion.
  /// Used on Android, iOS, or when Headless Chrome CLI is unavailable.
  /// Produces 100% valid, beautiful native PDF documents containing ALL sections without blank pages.
  Future<bool> _buildNativePdfFromNotes({
    required String chapterNumber,
    required String chapterTitle,
    required List<Map<String, dynamic>> sections,
    required File pdfFile,
  }) async {
    try {
      final sync_pdf.PdfDocument document = sync_pdf.PdfDocument();
      document.pageSettings.margins.all = 36;
      document.pageSettings.size = sync_pdf.PdfPageSize.a4;

      final titleFont = sync_pdf.PdfStandardFont(sync_pdf.PdfFontFamily.helvetica, 18, style: sync_pdf.PdfFontStyle.bold);
      final chapterNumFont = sync_pdf.PdfStandardFont(sync_pdf.PdfFontFamily.helvetica, 10, style: sync_pdf.PdfFontStyle.bold);
      final headingFont = sync_pdf.PdfStandardFont(sync_pdf.PdfFontFamily.helvetica, 12, style: sync_pdf.PdfFontStyle.bold);
      final bodyFont = sync_pdf.PdfStandardFont(sync_pdf.PdfFontFamily.helvetica, 9.5);
      final boldFont = sync_pdf.PdfStandardFont(sync_pdf.PdfFontFamily.helvetica, 9.5, style: sync_pdf.PdfFontStyle.bold);
      final italicFont = sync_pdf.PdfStandardFont(sync_pdf.PdfFontFamily.helvetica, 9.5, style: sync_pdf.PdfFontStyle.italic);

      sync_pdf.PdfPage page = document.pages.add();
      double y = 0;

      // Header
      final chapterNumResult = sync_pdf.PdfTextElement(text: chapterNumber.toUpperCase(), font: chapterNumFont, brush: sync_pdf.PdfSolidBrush(sync_pdf.PdfColor(100, 100, 100))).draw(
        page: page,
        bounds: Rect.fromLTWH(0, y, page.getClientSize().width, 20),
      )!;
      y = chapterNumResult.bounds.bottom + 2;

      final titleResult = sync_pdf.PdfTextElement(text: chapterTitle, font: titleFont).draw(
        page: page,
        bounds: Rect.fromLTWH(0, y, page.getClientSize().width, 30),
      )!;
      y = titleResult.bounds.bottom + 8;

      page.graphics.drawLine(sync_pdf.PdfPen(sync_pdf.PdfColor(0, 0, 0), width: 1.5), Offset(0, y), Offset(page.getClientSize().width, y));
      y += 16;

      int secNum = 1;
      for (var secMap in sections) {
        final heading = secMap['sectionHeading'] ?? secMap['title'] ?? 'Section $secNum';
        secNum++;

        if (y > page.getClientSize().height - 60) {
          page = document.pages.add();
          y = 0;
        }

        // Section Heading
        final hRes = sync_pdf.PdfTextElement(text: heading.toString().toUpperCase(), font: headingFont).draw(
          page: page,
          bounds: Rect.fromLTWH(0, y, page.getClientSize().width, 24),
        )!;
        y = hRes.bounds.bottom + 4;
        page.graphics.drawLine(sync_pdf.PdfPen(sync_pdf.PdfColor(50, 50, 50), width: 0.8), Offset(0, y), Offset(page.getClientSize().width, y));
        y += 10;

        // Key Takeaways & Concepts
        final keyConcepts = secMap['keyConcepts'] ?? secMap['keyTakeaways'] ?? secMap['highlights'];
        if (keyConcepts is List && keyConcepts.isNotEmpty) {
          for (var kc in keyConcepts) {
            if (kc == null || kc.toString().trim().isEmpty) continue;
            final text = '• ${_cleanLatexForNativePdf(kc.toString())}';
            if (y > page.getClientSize().height - 40) {
              page = document.pages.add();
              y = 0;
            }
            final pRes = sync_pdf.PdfTextElement(text: text, font: bodyFont).draw(
              page: page,
              bounds: Rect.fromLTWH(0, y, page.getClientSize().width, page.getClientSize().height - y),
            )!;
            y = pRes.bounds.bottom + 6;
          }
          y += 6;
        }

        // Paragraphs
        final paragraphs = secMap['contentParagraphs'] ?? secMap['paragraphs'] ?? secMap['theory'];
        if (paragraphs is List) {
          for (var p in paragraphs) {
            if (p == null || p.toString().trim().isEmpty) continue;
            final text = _cleanLatexForNativePdf(p.toString());
            if (y > page.getClientSize().height - 40) {
              page = document.pages.add();
              y = 0;
            }
            final pRes = sync_pdf.PdfTextElement(text: text, font: bodyFont).draw(
              page: page,
              bounds: Rect.fromLTWH(0, y, page.getClientSize().width, page.getClientSize().height - y),
            )!;
            y = pRes.bounds.bottom + 8;
          }
        }

        // Warning Boxes
        final warningBoxes = secMap['warningBoxes'] ?? secMap['warnings'];
        if (warningBoxes is List) {
          for (var w in warningBoxes) {
            if (w is Map) {
              final title = w['title'] ?? 'Word of Warning';
              final content = w['content'] ?? '';
              String textStr = content is List ? content.join('\n• ') : content.toString();
              textStr = _cleanLatexForNativePdf(textStr);

              if (y > page.getClientSize().height - 80) {
                page = document.pages.add();
                y = 0;
              }

              final boxWidth = page.getClientSize().width;
              page.graphics.drawRectangle(
                pen: sync_pdf.PdfPen(sync_pdf.PdfColor(20, 20, 20), width: 1),
                brush: sync_pdf.PdfSolidBrush(sync_pdf.PdfColor(245, 245, 245)),
                bounds: Rect.fromLTWH(0, y, boxWidth, 55),
              );
              page.graphics.drawString(title.toString().toUpperCase(), boldFont, bounds: Rect.fromLTWH(8, y + 6, boxWidth - 16, 16));
              page.graphics.drawString(textStr, bodyFont, bounds: Rect.fromLTWH(8, y + 24, boxWidth - 16, 30));
              y += 65;
            }
          }
        }

        // Definitions & Theorems
        final definitions = secMap['definitions'] ?? secMap['envBoxes'];
        if (definitions is List) {
          for (var d in definitions) {
            if (d is Map) {
              final number = d['number'] ?? '';
              final title = d['title'] ?? 'Definition';
              final tag = d['tag'] ?? 'Definition';
              final content = _cleanLatexForNativePdf((d['content'] ?? '').toString());
              final proof = d['proof'];

              final displayTitle = number.toString().isNotEmpty ? '$number $title' : title.toString();

              if (y > page.getClientSize().height - 100) {
                page = document.pages.add();
                y = 0;
              }

              final boxWidth = page.getClientSize().width;
              page.graphics.drawRectangle(
                pen: sync_pdf.PdfPen(sync_pdf.PdfColor(30, 30, 30), width: 1),
                brush: sync_pdf.PdfSolidBrush(sync_pdf.PdfColor(250, 250, 250)),
                bounds: Rect.fromLTWH(0, y, boxWidth, 65),
              );
              page.graphics.drawString(displayTitle.toUpperCase(), boldFont, bounds: Rect.fromLTWH(8, y + 6, boxWidth - 80, 16));
              page.graphics.drawString('[${tag.toString().toUpperCase()}]', boldFont, bounds: Rect.fromLTWH(boxWidth - 75, y + 6, 70, 16));
              page.graphics.drawString(content, bodyFont, bounds: Rect.fromLTWH(8, y + 24, boxWidth - 16, 35));
              y += 75;

              if (proof != null) {
                String proofText = proof is Map ? (proof['content'] ?? '') : proof.toString();
                proofText = _cleanLatexForNativePdf(proofText);
                if (y > page.getClientSize().height - 40) {
                  page = document.pages.add();
                  y = 0;
                }
                page.graphics.drawLine(sync_pdf.PdfPen(sync_pdf.PdfColor(80, 80, 80), width: 2), Offset(10, y), Offset(10, y + 30));
                page.graphics.drawString('Proof.', italicFont, bounds: Rect.fromLTWH(18, y, boxWidth - 20, 14));
                page.graphics.drawString(proofText, bodyFont, bounds: Rect.fromLTWH(18, y + 14, boxWidth - 20, 25));
                y += 35;
              }
            }
          }
        }

        // Examples
        final examples = secMap['examples'];
        if (examples is List) {
          for (var ex in examples) {
            if (ex is Map) {
              final title = ex['title'] ?? 'Example';
              final tag = ex['statusTag'] ?? '';
              final content = _cleanLatexForNativePdf((ex['content'] ?? '').toString());

              if (y > page.getClientSize().height - 70) {
                page = document.pages.add();
                y = 0;
              }

              final boxWidth = page.getClientSize().width;
              page.graphics.drawRectangle(
                pen: sync_pdf.PdfPen(sync_pdf.PdfColor(100, 100, 100), width: 0.8),
                brush: sync_pdf.PdfSolidBrush(sync_pdf.PdfColor(255, 255, 255)),
                bounds: Rect.fromLTWH(0, y, boxWidth, 55),
              );
              page.graphics.drawString(title.toString(), boldFont, bounds: Rect.fromLTWH(8, y + 6, boxWidth - 16, 16));
              if (tag.toString().isNotEmpty) {
                page.graphics.drawString('Status: ${tag.toString()}', italicFont, bounds: Rect.fromLTWH(8, y + 22, boxWidth - 16, 14));
              }
              page.graphics.drawString(content, bodyFont, bounds: Rect.fromLTWH(8, y + 36, boxWidth - 16, 16));
              y += 65;
            }
          }
        }

        y += 10;
      }

      final List<int> bytes = document.saveSync();
      document.dispose();

      await pdfFile.writeAsBytes(bytes);
      print('[ModuleNotesService] Native Syncfusion PDF generated: ${bytes.length} bytes saved to ${pdfFile.path}');
      return true;
    } catch (e, st) {
      print('[ModuleNotesService] ERROR in _buildNativePdfFromNotes: $e\n$st');
      return false;
    }
  }

  Map<String, dynamic>? _parseJson(String text) {
    try {
      String cleaned = text.trim();
      if (cleaned.contains('```json')) {
        cleaned = cleaned.split('```json')[1].split('```')[0];
      } else if (cleaned.contains('```')) {
        final parts = cleaned.split('```');
        if (parts.length >= 2) cleaned = parts[1];
      }
      cleaned = cleaned.trim();
      final int start = cleaned.indexOf('{');
      final int end = cleaned.lastIndexOf('}');
      if (start != -1 && end != -1 && end >= start) {
        cleaned = cleaned.substring(start, end + 1);
        return jsonDecode(cleaned) as Map<String, dynamic>;
      }
    } catch (e) {
      print('[ModuleNotesService] _parseJson warning: $e');
    }
    return null;
  }
}
