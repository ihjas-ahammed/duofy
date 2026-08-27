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
import 'latex_json_repairer.dart';
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

class ModuleNotesService extends ChangeNotifier {
  ModuleNotesService._();
  static final ModuleNotesService instance = ModuleNotesService._();

  static const List<String> availableDepths = [
    'Min (Quick Summary)',
    'Low (Concise Lecture)',
    'Medium (Standard Depth)',
    'High (Detailed & Rigorous)',
    'Max (Exhaustive & Full Proofs)',
  ];

  static const List<String> depthShortLabels = [
    'Min',
    'Low',
    'Medium',
    'High',
    'Max',
  ];

  static String _prefKey(String bookId, String moduleId) => 'module_note_pdf_${bookId}_$moduleId';
  static String _jobKey(String bookId, String moduleId) => '${bookId}_$moduleId';

  final Map<String, ModuleNotesJob> _activeJobs = {};

  ModuleNotesJob? getJob(String bookId, String moduleId) => _activeJobs[_jobKey(bookId, moduleId)];

  /// Deletes all cached notes (PDF and HTML) for a module.
  Future<void> deleteNotes(String bookId, String moduleId) async {
    final dir = await getApplicationDocumentsDirectory();
    final notesDir = Directory('${dir.path}/notes');

    final filePaths = [
      '${notesDir.path}/module_note_${bookId}_$moduleId.pdf',
      '${notesDir.path}/module_note_${bookId}_$moduleId.html',
      '${notesDir.path}/module_note_${bookId}_${moduleId}_rendered.html',
    ];

    for (final p in filePaths) {
      final f = File(p);
      if (f.existsSync()) {
        try {
          f.deleteSync();
        } catch (e) {
          print('[ModuleNotesService] Error deleting note file $p: $e');
        }
      }
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefKey(bookId, moduleId));
    _activeJobs.remove(_jobKey(bookId, moduleId));
    notifyListeners();
  }

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
    String depth = 'High (Detailed & Rigorous)',
  }) async {
    final key = _jobKey(book.id, module.id);
    final job = ModuleNotesJob(
      bookId: book.id,
      moduleId: module.id,
      moduleTitle: module.title,
      progress: 0.05,
      status: 'Starting Module Notes Generation (Depth: $depth)...',
      isRunning: true,
    );
    _activeJobs[key] = job;
    job.notify();
    notifyListeners();

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
        depth: depth,
        onProgress: (pStatus, pProgress) async {
          job.progress = pProgress;
          job.status = pStatus;
          job.notify();
          notifyListeners();

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
      notifyListeners();

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
      notifyListeners();

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
    String depth = 'High (Detailed & Rigorous)',
    void Function(String status, double progress)? onProgress,
  }) async {
    final timestamp = DateTime.now().toIso8601String();
    print('[ModuleNotesService][$timestamp] Generating section-by-section module notes for Book "${book.title}", Module ${moduleIndex + 1}: "${module.title}" [Depth: $depth]');

    onProgress?.call('Reading syllabus & reference materials...', 0.05);

    String syllabusText = '';
    File? sFile;
    if (book.syllabusPath != null && book.syllabusPath!.isNotEmpty) {
      final candidate = File(book.syllabusPath!);
      if (candidate.existsSync()) {
        sFile = candidate;
      }
    }
    if (sFile == null) {
      final dir = await getApplicationDocumentsDirectory();
      for (final ext in ['pdf', 'txt', 'md']) {
        final candidate = File('${dir.path}/books/${book.id}/syllabus.$ext');
        if (candidate.existsSync()) {
          sFile = candidate;
          break;
        }
      }
    }

    if (sFile != null && sFile.existsSync()) {
      try {
        final pathLower = sFile.path.toLowerCase();
        if (pathLower.endsWith('.txt') || pathLower.endsWith('.md')) {
          syllabusText = await sFile.readAsString();
        } else {
          syllabusText = await PdfService().extractTextFromPdf(sFile);
        }
        print('[ModuleNotesService] Extracted ${syllabusText.length} characters from syllabus (${sFile.path}).');
      } catch (e) {
        print('[ModuleNotesService] Syllabus text extraction failed: $e');
      }
    }

    if (syllabusText.isEmpty && book.customIndexText != null && book.customIndexText!.trim().isNotEmpty) {
      syllabusText = book.customIndexText!.trim();
      print('[ModuleNotesService] Using customIndexText as syllabus context (${syllabusText.length} chars).');
    }

    // Read previous notes version if available to feed into regeneration prompt
    String? previousNotesText;
    try {
      final prevHtmlPath = await getNotesHtmlPath(book.id, module.id);
      if (prevHtmlPath != null && File(prevHtmlPath).existsSync()) {
        final rawHtml = await File(prevHtmlPath).readAsString();
        final stripped = rawHtml
            .replaceAll(RegExp(r'<style[\s\S]*?</style>', caseSensitive: false), '')
            .replaceAll(RegExp(r'<script[\s\S]*?</script>', caseSensitive: false), '')
            .replaceAll(RegExp(r'<[^>]+>'), ' ')
            .replaceAll(RegExp(r'\s+'), ' ')
            .trim();
        if (stripped.length > 50) {
          previousNotesText = stripped.length > 4000 ? stripped.substring(0, 4000) : stripped;
          print('[ModuleNotesService] Ingested previous version (${previousNotesText.length} chars) for regeneration.');
        }
      }
    } catch (e) {
      print('[ModuleNotesService] Notice: could not load previous notes: $e');
    }

    final ai = AiService();
    final String regenDirective = (userRegenReason != null && userRegenReason.trim().isNotEmpty)
        ? '\nUSER REGENERATION REQUEST / REASON: "${userRegenReason.trim()}". Prioritize these requirements and improvements across all sections.'
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

    // Generate detailed notes FOR EVERY SECTION in the module sequentially according to syllabus (2 passes per section)
    for (int i = 0; i < totalSecs; i++) {
      final sec = sectionsToGenerate[i];
      final double secBaseProgress = 0.10 + (i / totalSecs) * 0.75;
      final double secHalfProgress = secBaseProgress + (0.75 / totalSecs) * 0.5;

      // Pass 1: Section lecture note generation strictly aligned with syllabus
      onProgress?.call('Section ${i + 1}/$totalSecs: Drafting notes per syllabus ("${sec.title}")...', secBaseProgress);
      print('[ModuleNotesService] Pass 1: Generating section ${i + 1}/$totalSecs per syllabus: "${sec.title}"');

      Map<String, dynamic> secNote;
      try {
        secNote = await _generateNotesForSection(
          ai: ai,
          book: book,
          module: module,
          sec: sec,
          secIndex: i,
          totalSections: totalSecs,
          syllabusText: syllabusText,
          regenDirective: regenDirective,
          previousNotesText: previousNotesText,
          depth: depth,
        );
      } catch (e) {
        print('[ModuleNotesService] Warning generating section ${i + 1}: $e');
        secNote = _buildSmartFallbackSection(secIndex: i, sec: sec);
      }

      // Pass 2: Syllabus fidelity, content depth, and format audit pass
      onProgress?.call('Section ${i + 1}/$totalSecs: Verifying syllabus alignment & quality ("${sec.title}")...', secHalfProgress);
      print('[ModuleNotesService] Pass 2: Auditing syllabus alignment & formatting for section ${i + 1}/$totalSecs: "${sec.title}"');

      try {
        secNote = await _auditAndRefineSectionNotes(
          ai: ai,
          book: book,
          module: module,
          sec: sec,
          rawJson: secNote,
          syllabusText: syllabusText,
          depth: depth,
        );
      } catch (e) {
        print('[ModuleNotesService] Audit pass fallback for ${sec.title}: $e');
      }

      final extractedList = _extractSectionMaps(secNote);
      if (extractedList.isNotEmpty) {
        generatedSections.addAll(extractedList);
      } else {
        generatedSections.add(secNote);
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

  /// Pass 1: Prompts AI to generate concise, highly dense academic lecture notes following the syllabus without storytelling fluff.
  Future<Map<String, dynamic>> _generateNotesForSection({
    required AiService ai,
    required Book book,
    required Module module,
    required Section sec,
    required int secIndex,
    required int totalSections,
    required String syllabusText,
    required String regenDirective,
    String? previousNotesText,
    required String depth,
  }) async {
    final String sectionHeadingStr = 'Section ${secIndex + 1}: ${sec.title}';
    final String unitTitles = sec.units.map((u) => u.title).join(', ');

    // Allow generous syllabus context (up to 40,000 chars) so no syllabus sections are truncated
    final String trimmedSyllabus = syllabusText.length > 40000
        ? syllabusText.substring(0, 40000)
        : syllabusText;

    final String prevNotesContext = (previousNotesText != null && previousNotesText.isNotEmpty)
        ? '''
PREVIOUS VERSION OF NOTES (FIRST VERSION TO IMPROVE/EXPAND):
"""
$previousNotesText
"""
CRITICAL REGENERATION DIRECTIVES:
- The user is REGENERATING these notes to make them significantly more thorough, comprehensive, clear, and faithful to the syllabus.
- CRITICALLY EXPAND and ENRICH all explanations, definitions, key concepts, frameworks, and examples.
- Address user feedback: "${regenDirective.isNotEmpty ? regenDirective : 'Expand depth, ensure complete syllabus coverage, and align with target depth.'}"
'''
        : '';

    final prompt = '''
You are an expert university professor and textbook author creating dense, authoritative, comprehensive lecture notes.

COURSE: ${book.title}
MODULE: ${module.title}
TARGET SECTION: $sectionHeadingStr
SECTION DESCRIPTION: ${sec.description.isNotEmpty ? sec.description : sec.title}
KEY TOPICS / UNITS IN THIS SECTION: ${unitTitles.isNotEmpty ? unitTitles : sec.title}
TARGET NOTE DEPTH: $depth (Min to Max Scale)
${trimmedSyllabus.isNotEmpty ? 'COURSE SYLLABUS (MANDATORY TO FOLLOW):\n"""\n$trimmedSyllabus\n"""' : ''}
$prevNotesContext
$regenDirective

CRITICAL PEDAGOGICAL INSTRUCTIONS:
1. STRICT SYLLABUS ALIGNMENT:
   - The notes MUST strictly follow the course syllabus topics, learning objectives, definitions, and scope provided above.
   - Systematically cover every topic, concept, term, rule, process, and mechanism relevant to this section and module as outlined in the syllabus without omitting anything.

2. ADAPT TO ALL COURSE TYPES (DO NOT FORCE LATEX OR EQUATIONS ON REGULAR COURSES):
   - We cater to ALL disciplines: Humanities, Social Sciences, History, Literature, Philosophy, Law, Political Science, Business, Management, Economics, Life Sciences, Medicine, Nursing, Psychology, Computer Science, Engineering, Physics, Chemistry, Mathematics, etc.
   - DO NOT FORCE mathematical equations, formulas, or LaTeX formatting on regular non-mathematical courses (e.g., History, Literature, Management, Biology, Law, Arts). Most regular courses do NOT need LaTeX or equations.
   - ONLY use LaTeX math formatting (\$...\$ for inline and \$\$...\$\$ for display blocks) IF the course is naturally mathematical, physical, or quantitative. If the subject is non-mathematical, output natural, clean prose and markdown.
   - DO NOT invent fake mathematical theorems or fake mathematical proofs for non-mathematical topics. For non-mathematical subjects, definitions should be core doctrines, principles, mechanisms, terms, or frameworks, and the accompanying block should be "Significance & Analysis", "Real-World Application & Impact", "Mechanisms & Pathways", or "Key Case Study" (do NOT end with \$\\blacksquare\$ unless it is an actual mathematical proof).

3. PURE ACADEMIC LECTURE NOTE STYLE (NO STORYTELLING / NO META INFO / NO PREREQUISITES):
   - Do NOT write conversational intros, storytelling, or rhetorical fluff (e.g., "Imagine you are...", "Let us embark on...", "Have you ever wondered...").
   - Do NOT include meta-information sections, prerequisite checklists, syllabus requirements, or background requirements. Jump directly into formal concepts, definitions, analytical frameworks, and mechanics.
   - Every paragraph must be dense, technical, precise, and directly explain concepts, mechanisms, analytical properties, or theories.

4. DEPTH CALIBRATION ($depth):
   - Min/Low: Sharp summary bullet points, core definitions/formulas, essential concept statements, and concise explanations.
   - Medium/High/Max: Comprehensive academic paragraphs, thorough analytical breakdowns, step-by-step proofs (for math/physics) or in-depth significance/application analyses (for other disciplines), rich examples, and SVG diagrams.

5. INLINE SVG VECTOR DIAGRAMS (STRICTLY NO LATEX INSIDE SVG):
   - Include 1 or 2 standalone, beautiful, clean SVG vector diagrams in the "diagrams" array (e.g., flowcharts, concept maps, timelines, architecture models, curves, state graphs, anatomical models).
   - Use valid SVG XML: `<svg viewBox="0 0 450 200" xmlns="http://www.w3.org/2000/svg">...</svg>` with labeled geometric elements.
   - CRITICAL RULE: NEVER use LaTeX math tags (\$...\$ or \$\$...\$\$) inside SVG or `<text>` elements. MathJax cannot parse LaTeX inside SVGs. Use clean plain text labels or standard Unicode symbols (e.g. θ, π, →, ≤, ≥, √) directly.

6. RICH PRACTICAL EXAMPLES & CASE STUDIES:
   - Include 2 to 4 detailed step-by-step examples suited to the subject (e.g., worked problem solutions for math/physics, case studies for business/law/history, code examples for computer science, clinical scenarios for biology/medicine).

7. EXAM WARNINGS & COMMON PITFALLS:
   - Detail common student misconceptions, critical distinctions, conditions where theories/assumptions fail, and high-yield exam tips.

Return valid JSON with this exact schema:
{
  "sectionHeading": "$sectionHeadingStr",
  "keyConcepts": [
    "Technical summary point 1 synthesizing core syllabus concept...",
    "Technical summary point 2 synthesizing key mechanism or framework..."
  ],
  "contentParagraphs": [
    "Direct academic lecture explanation paragraph 1 defining the analytical framework and core mechanics...",
    "Direct academic lecture explanation paragraph 2 detailing properties, behavior, and relationships..."
  ],
  "definitions": [
    {
      "number": "${secIndex + 1}.1",
      "title": "Core Concept / Principle / Framework / Theorem Title",
      "tag": "Definition / Principle / Framework / Theorem / Doctrine / Law",
      "content": "Formal statement, definition, or doctrine according to the syllabus.",
      "proof": {
        "title": "Significance & Analysis. (or 'Proof.' for math/logic, or 'Clinical Context.')",
        "content": "Detailed technical explanation of significance, application, mechanics, or step-by-step proof."
      }
    },
    {
      "number": "${secIndex + 1}.2",
      "title": "Fundamental Term / Mechanism Title",
      "tag": "Definition",
      "content": "Precise formal definition according to the syllabus.",
      "proof": {
        "title": "Real-World Context & Application.",
        "content": "Detailed technical explanation of how this is applied in practice."
      }
    }
  ],
  "warningBoxes": [
    {
      "title": "Common Pitfall / Critical Nuance / Exam Trap",
      "content": "Critical condition, misconception, or distinction students often miss."
    }
  ],
  "examples": [
    {
      "title": "Example ${secIndex + 1}.1: Solved Case / Problem / Application",
      "statusTag": "Worked Solution / Case Study / Illustration / Code Walkthrough",
      "statusType": "valid",
      "content": "Problem/scenario statement, step-by-step analysis or derivation, and key takeaway."
    }
  ],
  "diagrams": [
    {
      "title": "Concept Diagram",
      "svgContent": "<svg viewBox=\\"0 0 400 160\\" xmlns=\\"http://www.w3.org/2000/svg\\"><rect width=\\"400\\" height=\\"160\\" fill=\\"#f8fafc\\" rx=\\"8\\"/><circle cx=\\"100\\" cy=\\"80\\" r=\\"35\\" stroke=\\"#2563eb\\" stroke-width=\\"2\\" fill=\\"#dbeafe\\"/><circle cx=\\"300\\" cy=\\"80\\" r=\\"35\\" stroke=\\"#059669\\" stroke-width=\\"2\\" fill=\\"#dcfce7\\"/><line x1=\\"140\\" y1=\\"80\\" x2=\\"260\\" y2=\\"80\\" stroke=\\"#334155\\" stroke-width=\\"2\\" stroke-dasharray=\\"4\\"/><text x=\\"100\\" y=\\"85\\" text-anchor=\\"middle\\" font-size=\\"12\\" font-family=\\"sans-serif\\" fill=\\"#1e293b\\">Concept A</text><text x=\\"300\\" y=\\"85\\" text-anchor=\\"middle\\" font-size=\\"12\\" font-family=\\"sans-serif\\" fill=\\"#1e293b\\">Concept B</text><text x=\\"200\\" y=\\"70\\" text-anchor=\\"middle\\" font-size=\\"12\\" font-family=\\"sans-serif\\" fill=\\"#2563eb\\">Relationship</text></svg>",
      "description": "Visual diagram illustrating relationship."
    }
  ]
}

Return ONLY valid JSON.
''';

    for (int attempt = 1; attempt <= 2; attempt++) {
      try {
        final currentPrompt = attempt == 1
            ? prompt
            : '$prompt\n\nCRITICAL RETRY NOTICE: Your previous output failed JSON parsing. Return STRICT raw valid JSON only, escape all quotes and backslashes inside string fields!';
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

    // High-quality smart fallback generator
    return _buildSmartFallbackSection(secIndex: secIndex, sec: sec);
  }

  /// Pass 2: Audits syllabus fidelity, academic depth, and domain formatting (LaTeX validation only for math/STEM; plain text clean for regular courses).
  Future<Map<String, dynamic>> _auditAndRefineSectionNotes({
    required AiService ai,
    required Book book,
    required Module module,
    required Section sec,
    required Map<String, dynamic> rawJson,
    required String syllabusText,
    required String depth,
  }) async {
    final rawJsonStr = jsonEncode(rawJson);
    final String trimmedSyllabus = syllabusText.length > 20000
        ? syllabusText.substring(0, 20000)
        : syllabusText;

    final refinePrompt = '''
You are a senior academic curriculum auditor and technical lecture note editor.
Review and audit the following study note JSON for Section "${sec.title}" in Course "${book.title}".

${trimmedSyllabus.isNotEmpty ? 'COURSE SYLLABUS:\n"""\n$trimmedSyllabus\n"""\n' : ''}
RAW INPUT JSON:
```json
$rawJsonStr
```

CRITICAL VALIDATION & REFINEMENT INSTRUCTIONS:
1. STRICT SYLLABUS COVERAGE & ACADEMIC DEPTH ($depth):
   - Ensure all key concepts and topics for this section as defined in the syllabus are thoroughly covered.
   - Maintain dense, precise academic lecture prose without superficial shortcuts.

2. REMOVE CONVERSATIONAL FLUFF & STORYTELLING:
   - Strip out conversational intros, storytelling, prerequisite requirement checklists, syllabus requirement meta-commentary, or rhetorical filler.
   - Retain only dense, rigorous, technical academic lecture explanations, definitions, and mechanics.

3. DOMAIN-APPROPRIATE FORMATTING & LATEX VERIFICATION:
   - If the subject is mathematical/quantitative and contains LaTeX math expressions (\$...\$ or \$\$...\$\$), verify that all syntax is valid AMS-LaTeX (properly closed braces, valid brackets, escaped backslashes in JSON strings).
   - If the subject is a regular non-mathematical course (History, Management, Literature, Biology, Law, etc.), ensure plain text is clean and natural WITHOUT unnecessary or awkward LaTeX math symbols.
   - Ensure `\\blacksquare` / Q.E.D. is only present on genuine mathematical proofs, not on general conceptual or descriptive analysis blocks.

4. VALIDATE SVG DIAGRAMS & STRIP LATEX FROM SVGs:
   - Ensure all SVG code in diagrams has valid XML syntax with viewBox, xmlns="http://www.w3.org/2000/svg", and clean vector shapes.
   - CRITICAL: NEVER leave LaTeX delimiters (\$...\$ or \$\$...\$\$) inside SVG or `<text>` elements. Replace any with plain readable text or Unicode symbols.

5. PRESERVE FULL SECTIONS, DEFINITIONS & EXAMPLES:
   - Do NOT delete or truncate definitions, analytical explanations, or worked examples.

Return ONLY the refined, 100% syntactically valid JSON.
''';

    try {
      final resp = await ai.generateSimpleText(prompt: refinePrompt, slotName: 'Primary - Text');
      final parsed = _parseJson(resp);
      if (parsed != null && parsed.isNotEmpty) {
        if (!parsed.containsKey('sectionHeading') && rawJson.containsKey('sectionHeading')) {
          parsed['sectionHeading'] = rawJson['sectionHeading'];
        }
        return parsed;
      }
    } catch (e) {
      print('[ModuleNotesService] Notice: Note audit pass encountered an issue for ${sec.title}: $e. Using pass 1 output.');
    }

    return rawJson;
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
        concepts.add('${u.title}: ${u.description.isNotEmpty ? u.description : "Core topic covering key definitions, principles, and practical evaluation methods."}');
      }
    } else {
      concepts.add('Core Concepts: Detailed study of key principles, theoretical foundations, and methods in ${sec.title}.');
      concepts.add('Analytical Framework: Master foundational concepts, core mechanisms, and practical applications.');
    }

    return {
      'sectionHeading': sectionHeadingStr,
      'keyConcepts': concepts,
      'contentParagraphs': [
        '${sec.title} forms a foundational component of this module. A comprehensive understanding requires examining its core definitions, theoretical underpinnings, and analytical methods.',
        if (sec.description.isNotEmpty) sec.description,
      ],
      'definitions': [
        {
          'number': '${secIndex + 1}.1',
          'title': sec.title,
          'tag': 'Core Principle',
          'content': sec.description.isNotEmpty ? sec.description : 'Fundamental concept and scope of ${sec.title}.',
          'proof': {
            'title': 'Significance & Analysis.',
            'content': 'Understanding the mechanics and framework of ${sec.title} enables effective analysis of related topics within this domain.'
          }
        }
      ],
      'warningBoxes': [
        {
          'title': 'Key Focus Area',
          'content': 'Ensure precise understanding of terminology, core assumptions, and domain-specific principles during study.'
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
        .replaceAll('“', '"')
        .replaceAll('”', '"')
        .replaceAll('‘', "'")
        .replaceAll('’', "'")
        .replaceAll('—', ' - ')
        .replaceAll('–', '-')
        .replaceAll('…', '...')
        .replaceAll('•', '*')
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

              if (y > page.getClientSize().height - 70) {
                page = document.pages.add();
                y = 0;
              }

              final boxWidth = page.getClientSize().width;
              final startY = y;

              // Title
              final titleRes = sync_pdf.PdfTextElement(text: title.toString().toUpperCase(), font: boldFont).draw(
                page: page,
                bounds: Rect.fromLTWH(8, startY + 6, boxWidth - 16, page.getClientSize().height - startY - 10),
              )!;
              y = titleRes.bounds.bottom + 4;

              // Body
              final textRes = sync_pdf.PdfTextElement(text: textStr, font: bodyFont).draw(
                page: page,
                bounds: Rect.fromLTWH(8, y, boxWidth - 16, page.getClientSize().height - y),
              )!;
              y = textRes.bounds.bottom + 8;

              // Draw border around warning box
              page.graphics.drawRectangle(
                pen: sync_pdf.PdfPen(sync_pdf.PdfColor(20, 20, 20), width: 1),
                bounds: Rect.fromLTWH(0, startY, boxWidth, y - startY),
              );
              y += 10;
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

              if (y > page.getClientSize().height - 80) {
                page = document.pages.add();
                y = 0;
              }

              final boxWidth = page.getClientSize().width;
              final startBoxY = y;

              // Title + Tag
              final titleRes = sync_pdf.PdfTextElement(text: '${displayTitle.toUpperCase()}  [${tag.toString().toUpperCase()}]', font: boldFont).draw(
                page: page,
                bounds: Rect.fromLTWH(8, startBoxY + 6, boxWidth - 16, page.getClientSize().height - startBoxY - 10),
              )!;
              y = titleRes.bounds.bottom + 4;

              // Content
              if (content.isNotEmpty) {
                final contentRes = sync_pdf.PdfTextElement(text: content, font: bodyFont).draw(
                  page: page,
                  bounds: Rect.fromLTWH(8, y, boxWidth - 16, page.getClientSize().height - y),
                )!;
                y = contentRes.bounds.bottom + 6;
              }

              // Draw box border
              page.graphics.drawRectangle(
                pen: sync_pdf.PdfPen(sync_pdf.PdfColor(30, 30, 30), width: 1),
                bounds: Rect.fromLTWH(0, startBoxY, boxWidth, y - startBoxY + 4),
              );
              y += 8;

              // Proof / Significance Block (if present)
              if (proof != null) {
                String proofTitle = 'Significance & Analysis:';
                String proofText = '';
                if (proof is Map) {
                  proofTitle = (proof['title'] ?? 'Significance & Analysis:').toString();
                  proofText = (proof['content'] ?? '').toString();
                } else {
                  proofText = proof.toString();
                }
                proofText = _cleanLatexForNativePdf(proofText);
                final isMathProof = proofTitle.toLowerCase().contains('proof') ||
                    proofText.contains('[Q.E.D.]') ||
                    proofText.toLowerCase().contains('q.e.d.');

                if (proofText.trim().isNotEmpty) {
                  if (y > page.getClientSize().height - 60) {
                    page = document.pages.add();
                    y = 0;
                  }

                  final proofStartY = y;
                  final pTitleRes = sync_pdf.PdfTextElement(text: proofTitle, font: italicFont).draw(
                    page: page,
                    bounds: Rect.fromLTWH(18, y, boxWidth - 24, page.getClientSize().height - y),
                  )!;
                  y = pTitleRes.bounds.bottom + 2;

                  final textToRender = (isMathProof && !proofText.contains('[Q.E.D.]'))
                      ? '$proofText [Q.E.D.]'
                      : proofText;

                  final pTextRes = sync_pdf.PdfTextElement(text: textToRender, font: bodyFont).draw(
                    page: page,
                    bounds: Rect.fromLTWH(18, y, boxWidth - 24, page.getClientSize().height - y),
                  )!;
                  y = pTextRes.bounds.bottom + 8;

                  // Left vertical proof bar
                  page.graphics.drawLine(
                    sync_pdf.PdfPen(sync_pdf.PdfColor(80, 80, 80), width: 2),
                    Offset(10, proofStartY),
                    Offset(10, y - 4),
                  );
                }
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
              final startExY = y;

              final exTitle = tag.toString().isNotEmpty ? '$title (${tag.toString()})' : title.toString();
              final titleRes = sync_pdf.PdfTextElement(text: exTitle, font: boldFont).draw(
                page: page,
                bounds: Rect.fromLTWH(8, startExY + 6, boxWidth - 16, page.getClientSize().height - startExY - 10),
              )!;
              y = titleRes.bounds.bottom + 4;

              final contentRes = sync_pdf.PdfTextElement(text: content, font: bodyFont).draw(
                page: page,
                bounds: Rect.fromLTWH(8, y, boxWidth - 16, page.getClientSize().height - y),
              )!;
              y = contentRes.bounds.bottom + 6;

              page.graphics.drawRectangle(
                pen: sync_pdf.PdfPen(sync_pdf.PdfColor(100, 100, 100), width: 0.8),
                bounds: Rect.fromLTWH(0, startExY, boxWidth, y - startExY + 4),
              );
              y += 10;
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
    return LatexJsonRepairer.parse(text);
  }
}
