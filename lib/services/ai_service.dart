import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdfx/pdfx.dart' as pdfx;
import '../models/app_models.dart';
import 'prompt_service.dart';
import 'pdf_service.dart';

class AiService {
  Future<List<String>> _getKeys({String? forcedApiKey}) async {
    if (forcedApiKey != null && forcedApiKey.trim().isNotEmpty) {
      return [forcedApiKey.trim()];
    }
    final prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs.getStringList('gemini_api_keys_list') ?? [];
    if (keys.isEmpty) {
      final keysString = prefs.getString('gemini_api_keys') ?? '';
      keys = keysString.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    if (keys.isEmpty) {
      throw Exception('No API Keys configured.');
    }
    return keys;
  }

  /// Reads an ordered list of preferred models for one slot. Falls back to
  /// the legacy single-string key when the new list key is empty so older
  /// installs keep working without migration. The returned list is never
  /// empty — the caller can safely iterate it as a model-fallback ladder.
  Future<List<String>> _getModelsForSlot(String slotKey, String legacyKey, String fallback) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(slotKey) ?? [];
    if (list.isNotEmpty) return list;
    final legacy = prefs.getString(legacyKey);
    if (legacy != null && legacy.trim().isNotEmpty) return [legacy.trim()];
    return [fallback];
  }

  Future<List<String>> _getPrimaryTextModels() =>
      _getModelsForSlot('model_primary_text_list', 'model_primary_text', 'gemini-flash-lite-latest');

  Future<List<String>> _getPrimaryGraphicsModels() =>
      _getModelsForSlot('model_primary_graphics_list', 'model_primary_graphics', 'gemini-3.5-flash');

  Future<List<String>> _getLiteModels() =>
      _getModelsForSlot('model_lite_list', 'model_lite', 'gemini-flash-lite-latest');

  Future<List<String>> _getLiveModels() =>
      _getModelsForSlot('model_live_list', 'model_live', 'gemini-3.1-flash-live-preview');

  Future<String> getLiveModelName() async {
    final list = await _getLiveModels();
    return list.isNotEmpty ? list.first : 'gemini-3.1-flash-live-preview';
  }

  Future<String> getPrimaryTextModelName() async {
    final list = await _getPrimaryTextModels();
    return list.isNotEmpty ? list.first : 'gemini-flash-lite-latest';
  }

  Future<String> getApiKey() async {
    final keys = await _getKeys();
    return keys.isNotEmpty ? keys.first : '';
  }

  Map<String, dynamic> _cleanAndDecodeJson(String text) {
    String cleaned = text.trim();

    if (cleaned.isEmpty) {
      throw Exception('AI returned an empty response.');
    }

    // Strip optional Markdown code fences (```json … ``` or ``` … ```).
    if (cleaned.contains('```json')) {
      cleaned = cleaned.split('```json')[1].split('```')[0];
    } else if (cleaned.contains('```')) {
      final parts = cleaned.split('```');
      if (parts.length >= 2) cleaned = parts[1];
    }

    cleaned = cleaned.trim();
    final int start = cleaned.indexOf('{');
    final int end = cleaned.lastIndexOf('}');

    if (start == -1 || end == -1 || end < start) {
      final preview = cleaned.length > 200 ? '${cleaned.substring(0, 200)}…' : cleaned;
      throw Exception('AI response did not contain a JSON object. Got: $preview');
    }

    cleaned = cleaned.substring(start, end + 1);

    try {
      final decoded = jsonDecode(cleaned);
      if (decoded is! Map<String, dynamic>) {
        throw Exception('Expected a JSON Object (Map), but got ${decoded.runtimeType}.');
      }
      return decoded;
    } catch (e1) {
      try {
        // Some models emit raw newlines inside string literals — escape them.
        final agg = cleaned.replaceAll('\n', '\\n').replaceAll('\r', '');
        final decoded = jsonDecode(agg);
        if (decoded is! Map<String, dynamic>) {
          throw Exception('Expected a JSON Object after sanitization, got ${decoded.runtimeType}.');
        }
        return decoded;
      } catch (e2) {
        final preview = cleaned.length > 200 ? '${cleaned.substring(0, 200)}…' : cleaned;
        throw Exception('Failed to parse AI JSON. First parse: $e1. After sanitization: $e2. Snippet: $preview');
      }
    }
  }

  /// Reads "TOTAL_LESSONS: N" from the first non-empty lines of the plan, or
  /// falls back to the highest "Lesson N" index found in the text.
  int _parseLessonCount(String plan) {
    final headerRe = RegExp(r'TOTAL[_ ]?LESSONS\s*[:=]\s*(\d+)', caseSensitive: false);
    for (final line in plan.split('\n').take(5)) {
      final m = headerRe.firstMatch(line);
      if (m != null) {
        final n = int.tryParse(m.group(1)!) ?? 0;
        if (n > 0) return n;
      }
    }
    final lessonRe = RegExp(r'lesson\s+(\d+)', caseSensitive: false);
    int max = 0;
    for (final m in lessonRe.allMatches(plan)) {
      final n = int.tryParse(m.group(1) ?? '');
      if (n != null && n > max) max = n;
    }
    return max;
  }

  /// True for failures that are typically transient — HTML error pages
  /// (502/503/504), 500 "internal error", overload/rate-limit (429, RESOURCE
  /// EXHAUSTED, overloaded), socket drops, and generic timeouts. We retry
  /// these (bounded backoff) before falling back to the next model/key. The
  /// caller's model×key ladder then handles anything that survives the retry,
  /// so e.g. a persistent "internal error" on one model moves on to the next.
  bool _isTransient(Object e) {
    final s = e.toString().toLowerCase();
    return s.contains('500') ||
        s.contains('502') ||
        s.contains('503') ||
        s.contains('504') ||
        s.contains('internal error') ||
        s.contains('internal server') ||
        s.contains('bad gateway') ||
        s.contains('service unavailable') ||
        s.contains('gateway timeout') ||
        s.contains('overloaded') ||
        s.contains('try again') ||
        s.contains('deadline exceeded') ||
        s.contains('429') ||
        s.contains('rate limit') ||
        s.contains('resource exhausted') ||
        s.contains('quota') ||
        s.contains('unavailable') ||
        s.contains('doctype html') ||
        s.contains('<html') ||
        s.contains('socketexception') ||
        s.contains('timeoutexception') ||
        s.contains('connection closed') ||
        s.contains('connection reset');
  }

  /// Maps a raw error into a short category label used for logging/UI so each
  /// kind of generation failure is acknowledged explicitly rather than lumped
  /// into one opaque "failed" message.
  String _classifyError(Object e) {
    final s = e.toString().toLowerCase();
    if (s.contains('internal error') || s.contains('500') || s.contains('internal server')) {
      return 'Model internal error';
    }
    if (s.contains('429') || s.contains('rate limit') || s.contains('resource exhausted') || s.contains('quota')) {
      return 'Rate limited / quota exceeded';
    }
    if (s.contains('overloaded') || s.contains('503') || s.contains('unavailable')) {
      return 'Model overloaded';
    }
    if (s.contains('timeout') || s.contains('deadline exceeded')) {
      return 'Request timed out';
    }
    if (s.contains('api key') || s.contains('permission') || s.contains('401') || s.contains('403')) {
      return 'API key / permission error';
    }
    if (s.contains('json') || s.contains('parse')) {
      return 'Malformed AI response';
    }
    if (s.contains('safety') || s.contains('blocked')) {
      return 'Blocked by safety filter';
    }
    return 'Generation error';
  }

  /// Strips HTML error pages out of error strings and prefixes a short
  /// category so the surfaced message names what kind of failure occurred.
  String _cleanErrMsg(Object e) {
    final category = _classifyError(e);
    final s = e.toString();
    final lower = s.toLowerCase();
    if (lower.contains('<html') || lower.contains('doctype html')) {
      if (lower.contains('502')) return '$category — server 502 (Bad Gateway), model temporarily unavailable.';
      if (lower.contains('503')) return '$category — server 503, model overloaded.';
      if (lower.contains('504')) return '$category — server 504, upstream timeout.';
      return '$category — upstream returned an HTML error page (model unavailable).';
    }
    return '$category: $s';
  }

  /// Wraps an async call with bounded exponential backoff for transient errors.
  /// Non-transient errors propagate immediately. Used to swallow flaky Gemma 4
  /// 502s without burning through the user's full key/model fallback ladder.
  Future<T> _retryTransient<T>(
    Future<T> Function() op, {
    int maxAttempts = 3,
    Duration baseDelay = const Duration(seconds: 2),
    bool retryTimeouts = true,
    void Function(int attempt, Object err)? onRetry,
  }) async {
    Object? last;
    for (int attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        return await op();
      } catch (e) {
        last = e;
        // When [retryTimeouts] is false, a timeout is rethrown immediately so
        // the caller can fall back to the NEXT model/key instead of burning
        // more attempts (and more wall-clock) on a model that's already slow.
        if (e is TimeoutException && !retryTimeouts) rethrow;
        if (!_isTransient(e) || attempt == maxAttempts) rethrow;
        onRetry?.call(attempt, e);
        await Future.delayed(baseDelay * (1 << (attempt - 1)));
      }
    }
    throw last ?? Exception('Retry exhausted');
  }

  Future<List<Part>> _buildFileParts(List<dynamic> files, {bool extractText = false, List<String>? fileLabels}) async {
    List<Part> parts = [];
    for (int idx = 0; idx < files.length; idx++) {
      final f = files[idx];
      if (fileLabels != null && idx < fileLabels.length) {
        parts.add(TextPart(fileLabels[idx]));
      }

      String name = '';
      Uint8List bytes;

      if (f is File) {
        name = f.path;
        bytes = await f.readAsBytes();
      } else if (f is PlatformFile) {
        name = f.name;
        if (f.bytes != null) {
          bytes = f.bytes!;
        } else if (f.path != null) {
          bytes = await File(f.path!).readAsBytes();
        } else {
          continue;
        }
      } else {
        continue;
      }

      final ext = name.split('.').last.toLowerCase();
      if (ext == 'pdf') {
        if (extractText) {
          final text = await PdfService().extractTextFromPdfBytes(bytes);
          if (text.trim().isNotEmpty) {
            parts.add(TextPart('--- SYLLABUS CONTENT START ---\n$text\n--- SYLLABUS CONTENT END ---'));
          }
        } else {
          try {
            final doc = await pdfx.PdfDocument.openData(bytes);
            for (int i = 1; i <= doc.pagesCount; i++) {
              final page = await doc.getPage(i);
              final pageImage = await page.render(
                width: page.width * 1.5,
                height: page.height * 1.5,
                format: pdfx.PdfPageImageFormat.jpeg,
              );
              if (pageImage != null) {
                parts.add(DataPart('image/jpeg', pageImage.bytes));
              }
              await page.close();
            }
          } catch (e) {
            print('PDF to Image fallback error: $e');
            // Last resort: extract text if image conversion fails
            final text = await PdfService().extractTextFromPdfBytes(bytes);
            if (text.trim().isNotEmpty) {
              parts.add(TextPart('--- CONTENT START ---\n$text\n--- CONTENT END ---'));
            }
          }
        }
      } else {
        final mime = ext == 'png' ? 'image/png' : 'image/jpeg';
        parts.add(DataPart(mime, bytes));
      }
    }
    return parts;
  }

  int? _asInt(dynamic v) {
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v.trim());
    return null;
  }

  Future<List<String>?> generateCourseQuestions({
    required File sourcePdf,
    required int chapter1StartPage,
    String? forcedApiKey,
  }) async {
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getLiteModels();
    
    // Read preface: pages 1 to chapter1StartPage - 1
    if (chapter1StartPage <= 1) return null;
    int endPage = chapter1StartPage - 1;
    if (endPage > 30) endPage = 30; // cap to 30 pages of preface to save tokens
    
    final chunkPages = List.generate(endPage, (i) => i + 1);
    final pdfChunk = await PdfService().extractPages(sourcePdf, chunkPages);
    final pdfBytes = await pdfChunk.readAsBytes();

    final prompt = '''
Analyze the attached preface/guide pages of this textbook.
Generate 2-3 questions to ask the student about how they want this book structured or taught, based specifically on the book's stated goals in the preface.
For example, if the preface mentions "focus on proofs", ask "This book contains many proofs. Should we emphasize them or focus on application?"

Keep the questions very short and concise (under 10 words each).

Return JSON format:
{
  "questions": ["Question 1", "Question 2"]
}
''';

    for (var key in keys) {
      for (var modelName in modelsToTry) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: key,
            generationConfig: GenerationConfig(responseMimeType: 'application/json'),
          );
          final response = await _retryTransient(
            () => model.generateContent([
              Content.multi([TextPart(prompt), DataPart('application/pdf', pdfBytes)])
            ]).timeout(const Duration(minutes: 2)),
            onRetry: (a, e) => print('[AiService] Questions transient ($modelName) attempt $a: ${_cleanErrMsg(e)}'),
          );

          if (response.text != null) {
            final jsonMap = _cleanAndDecodeJson(response.text!);
            if (jsonMap['questions'] is List) {
              return (jsonMap['questions'] as List).map((e) => e.toString()).toList();
            }
          }
        } catch (e) {
          print('[AiService] generateCourseQuestions ($modelName) failed: ${_cleanErrMsg(e)}');
        }
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> scanIndexChunk(File chunkPdf, int startPage, int endPage, {String? forcedApiKey}) async {
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getLiteModels();
    final pdfBytes = await chunkPdf.readAsBytes();

    final prompt = '''
Analyze the attached PDF chunk (which represents physical pages $startPage to $endPage of a textbook).
Identify if this chunk contains the Table of Contents / Index. If so, return the absolute page numbers.
Also identify if this chunk contains the exact start of "Chapter 1" (or the first main content chapter). If so, return its absolute page number.

Respond strictly in JSON format:
{
  "indexPages": [list of integers, or empty array],
  "chapter1StartPage": integer or null
}

Important Rules:
1. The page numbers you return MUST be the absolute PDF page numbers ($startPage to $endPage), NOT the printed page numbers on the page itself.
2. For "chapter1StartPage", DO NOT return a page from the Table of Contents just because it lists "Chapter 1". You must only return the page where the actual content/text of Chapter 1 begins!
''';

    for (var key in keys) {
      for (var modelName in modelsToTry) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: key,
            generationConfig: GenerationConfig(responseMimeType: 'application/json'),
          );
          final response = await _retryTransient(
            () => model.generateContent([
              Content.multi([TextPart(prompt), DataPart('application/pdf', pdfBytes)])
            ]).timeout(const Duration(minutes: 2)),
            onRetry: (a, e) => print('[AiService] Index scan transient ($modelName) attempt $a: ${_cleanErrMsg(e)}'),
          );

          if (response.text != null) {
            return _cleanAndDecodeJson(response.text!);
          }
        } catch (e) {
          print('[AiService] scanIndexChunk ($modelName) failed: ${_cleanErrMsg(e)}');
        }
      }
    }
    return null;
  }

  /// Generates the course skeleton from a TOC-only PDF, in TWO batched stages
  /// so the lite model stops skipping chapters and merging sections:
  ///   1. [PromptService.chapterList] — enumerate every top-level chapter
  ///      (one focused job → far fewer omissions), plus the course metadata.
  ///   2. [PromptService.sectionList] — for EACH chapter, in parallel, detail
  ///      its sub-topics bounded to that chapter's page range (so sections
  ///      never bleed across, or merge with, neighbouring chapters).
  ///
  /// [indexFiles] is the cropped index/TOC PDF (a few pages cut out of the
  /// full source PDF by [PdfService.extractPages]). [chapter1AbsolutePage] is
  /// the ABSOLUTE PDF page (1-based) where Chapter 1 actually starts, used for
  /// offset correction. [onProgress] reports REAL progress — null fraction
  /// during the single chapter call (indeterminate), then chapters-completed /
  /// total as sections fill in.
  Future<Book?> generateBookSkeleton(
    List<File> indexFiles,
    String filename, {
    required List<int> chapter1AbsolutePages,
    String? customInstructions,
    List<File> syllabusFiles = const [],
    bool isHandout = false,
    void Function(String status, double? progress)? onProgress,
    String? forcedApiKey,
    List<List<int>>? chapterStarts,
    List<File>? sourceFiles,
  }) async {
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getLiteModels();
    final instructionsBlock = PromptService.instructionsBlock(customInstructions);
    
    // Create the labels for files
    final List<String> fileLabels = [];
    for (int i = 0; i < indexFiles.length; i++) {
      final name = indexFiles[i].path.split(RegExp(r'[\\/]')).last;
      final ch1 = i < chapter1AbsolutePages.length ? chapter1AbsolutePages[i] : 1;
      fileLabels.add('\n--- INDEX FOR BOOK $i: "$name" (Chapter 1 absolute page starts at page $ch1) ---\n');
    }
    
    final fileParts = await _buildFileParts(indexFiles, fileLabels: fileLabels);
    final syllabusParts = await _buildFileParts(syllabusFiles, extractText: true);

    // Chapter Starts Mode (Method Two)
    if (chapterStarts != null && chapterStarts.isNotEmpty) {
      onProgress?.call('Mapping chapter starts…', null);
      
      String multiBookInstruction = '';
      if (indexFiles.length > 1) {
        final bookDescriptions = List.generate(
          indexFiles.length,
          (i) => 'Book $i: "${indexFiles[i].path.split(RegExp(r'[\\/]')).last}"'
        ).join('\n');

        multiBookInstruction = '''
IMPORTANT: We are using MULTIPLE reference textbooks. Here is the list of books and their indices:
$bookDescriptions

You must map each chapter/module to its corresponding book.
In the returned JSON, for every chapter object in the "chapters" array, you MUST include a "bookIndex" field (0-based integer, e.g. 0 for Book 0, 1 for Book 1, etc.) indicating which textbook contains this chapter.
''';
      }

      final chapterPrompt = PromptService.chapterStartsList
          .replaceAll('%filename%', filename)
          .replaceAll('%custom_instructions%', '$instructionsBlock\n$multiBookInstruction');

      Map<String, dynamic>? meta;
      Exception? lastException;
      for (final modelName in modelsToTry) {
        for (final apiKey in keys) {
          try {
            final model = GenerativeModel(
              model: modelName,
              apiKey: apiKey,
              generationConfig: GenerationConfig(responseMimeType: 'application/json'),
            );
            final response = await _retryTransient(
              () => model.generateContent([Content.multi([TextPart(chapterPrompt), ...syllabusParts, ...fileParts])])
                  .timeout(const Duration(minutes: 4)),
              onRetry: (a, e) => print('[AiService] Chapter starts transient ($modelName) attempt $a: ${_cleanErrMsg(e)}'),
            );
            if (response.text != null) {
              meta = _cleanAndDecodeJson(response.text!);
              break;
            }
          } on TimeoutException {
            lastException = Exception('Chapter starts mapping timed out ($modelName).');
          } catch (e) {
            lastException = Exception('Chapter starts mapping failed ($modelName): ${_cleanErrMsg(e)}');
          }
        }
        if (meta != null) break;
      }
      if (meta == null) throw lastException ?? Exception('Failed to map chapters. All models/keys exhausted.');

      final rawChapters = (meta['chapters'] ?? meta['modules']) as List?;
      if (rawChapters == null || rawChapters.isEmpty) {
        throw Exception('The model returned no chapters for this PDF.');
      }

      // Initialize pointers/data for each book
      final Map<int, List<int>> bookStarts = {};
      final Map<int, List<Map<String, dynamic>>> matchedChaptersByBook = {};
      for (int i = 0; i < indexFiles.length; i++) {
        final starts = List<int>.from(chapterStarts[i])..sort();
        bookStarts[i] = starts;
        matchedChaptersByBook[i] = [];
      }

      // Iterate through AI-returned chapters and match
      for (var i = 0; i < rawChapters.length; i++) {
        final c = rawChapters[i] is Map ? Map<String, dynamic>.from(rawChapters[i]) : <String, dynamic>{};
        int bookIdx = _asInt(c['bookIndex']) ?? 0;
        if (bookIdx < 0 || bookIdx >= indexFiles.length) {
          bookIdx = 0;
        }
        
        final starts = bookStarts[bookIdx]!;
        final currentMatchedList = matchedChaptersByBook[bookIdx]!;
        final int matchedCount = currentMatchedList.length;
        
        int? startPage;
        int? endPage;
        if (matchedCount < starts.length) {
          startPage = starts[matchedCount];
          if (matchedCount < starts.length - 1) {
            endPage = starts[matchedCount + 1] - 1;
          } else {
            // Last chapter of this book
            if (sourceFiles != null && bookIdx < sourceFiles.length) {
              try {
                endPage = await PdfService().getPageCount(sourceFiles[bookIdx]);
              } catch (e) {
                endPage = startPage + 20;
              }
            } else {
              endPage = startPage + 20;
            }
          }
        } else {
          // Fallback
          startPage = starts.isNotEmpty ? starts.last : 1;
          endPage = startPage + 20;
        }
        
        final cid = (c['id']?.toString().trim().isNotEmpty ?? false) ? c['id'].toString() : 'm${i + 1}';
        
        currentMatchedList.add({
          'id': cid,
          'title': c['title']?.toString() ?? 'Chapter ${i + 1}',
          'description': c['description']?.toString() ?? '',
          'startPage': startPage,
          'endPage': endPage,
          'bookIndex': bookIdx,
        });
      }
      
      // Assemble the flattened chapters
      final chapters = <Map<String, dynamic>>[];
      for (int i = 0; i < indexFiles.length; i++) {
        chapters.addAll(matchedChaptersByBook[i]!);
      }

      final assembled = <String, dynamic>{
        'id': 'book-${DateTime.now().millisecondsSinceEpoch}',
        'title': meta['title']?.toString() ?? filename,
        'description': meta['description']?.toString() ?? 'Auto-generated course',
        'icon': meta['icon']?.toString() ?? 'Book',
        if (meta['systemPrompt'] != null) 'systemPrompt': meta['systemPrompt'],
        'modules': [
          for (var i = 0; i < chapters.length; i++)
            {
              'id': chapters[i]['id'],
              'title': chapters[i]['title'],
              'description': chapters[i]['description'],
              'sections': [
                {
                  'id': '${chapters[i]['id']}-s1',
                  'title': chapters[i]['title'],
                  'description': chapters[i]['description'],
                  'color': 'duo-blue',
                  'startPage': chapters[i]['startPage'],
                  'endPage': chapters[i]['endPage'],
                  'bookIndex': chapters[i]['bookIndex'] ?? 0,
                }
              ],
            }
        ],
      };
      onProgress?.call('Finalizing structure…', 1.0);
      return Book.fromJson(assembled).copyWith(customInstructions: customInstructions);
    }

    if (isHandout) {
      onProgress?.call('Analyzing handout content…', null);
      int totalPages = 1;
      try {
        if (indexFiles.isNotEmpty) {
          totalPages = await PdfService().getPageCount(indexFiles.first);
        }
      } catch (e) {
        print('Error getting page count: $e');
      }

      final handoutPrompt = PromptService.handoutSkeleton
          .replaceAll('%filename%', filename)
          .replaceAll('%total_pages%', '$totalPages')
          .replaceAll('%custom_instructions%', instructionsBlock);

      Map<String, dynamic>? handoutMeta;
      Exception? lastException;
      for (final modelName in modelsToTry) {
        for (final apiKey in keys) {
          try {
            final model = GenerativeModel(
              model: modelName,
              apiKey: apiKey,
              generationConfig: GenerationConfig(responseMimeType: 'application/json'),
            );
            final response = await _retryTransient(
              () => model.generateContent([Content.multi([TextPart(handoutPrompt), ...fileParts])])
                  .timeout(const Duration(minutes: 4)),
              onRetry: (a, e) => print('[AiService] Handout skeleton transient ($modelName) attempt $a: ${_cleanErrMsg(e)}'),
            );
            if (response.text != null) {
              handoutMeta = _cleanAndDecodeJson(response.text!);
              break;
            }
          } on TimeoutException {
            lastException = Exception('Handout analysis timed out ($modelName).');
          } catch (e) {
            lastException = Exception('Handout analysis failed ($modelName): ${_cleanErrMsg(e)}');
          }
        }
        if (handoutMeta != null) break;
      }
      if (handoutMeta == null) throw lastException ?? Exception('Failed to analyze handout. All models/keys exhausted.');

      onProgress?.call('Finalizing handout structure…', 1.0);
      return Book.fromJson(handoutMeta).copyWith(customInstructions: customInstructions);
    }

    // ---- Stage 1: chapter list (one focused call → indeterminate) ----------
    onProgress?.call('Mapping chapters…', null);
    final bool isCourse = syllabusFiles.isNotEmpty;
    final promptTemplate = isCourse ? PromptService.syllabusChapterList : PromptService.chapterList;
    
    // Customize the offset block dynamically if we have multiple books!
    String offsetBlock = '';
    if (indexFiles.length == 1) {
      final ch1 = chapter1AbsolutePages.isNotEmpty ? chapter1AbsolutePages.first : 1;
      offsetBlock = '''OFFSET CORRECTION:
- Page numbers in the table of contents refer to printed page numbers.
- The PDF viewer uses absolute page numbers (1-based, starting from page 1 of the file).
- Chapter 1 starts on absolute PDF page $ch1.
- Use this start page to compute the correct absolute PDF page for all chapters in the TOC. For example, if Chapter 1 is listed as printed page "1" but actually starts on absolute page $ch1, then printed page "10" is absolute page (10 - 1) + $ch1 = 9 + $ch1.''';
    } else {
      final buffer = StringBuffer();
      buffer.writeln('OFFSET CORRECTION FOR EACH BOOK:');
      for (int i = 0; i < indexFiles.length; i++) {
        final ch1 = i < chapter1AbsolutePages.length ? chapter1AbsolutePages[i] : 1;
        buffer.writeln('- Book $i: Chapter 1 starts on absolute PDF page $ch1.');
        buffer.writeln('  For Book $i, if Chapter 1 is listed as printed page "1" but starts on absolute page $ch1, then printed page "10" is absolute page (10 - 1) + $ch1 = 9 + $ch1.');
      }
      offsetBlock = buffer.toString();
    }

    String multiBookInstruction = '';
    if (indexFiles.length > 1) {
      final bookDescriptions = List.generate(
        indexFiles.length,
        (i) => 'Book $i: "${indexFiles[i].path.split(RegExp(r'[\\/]')).last}"'
      ).join('\n');

      multiBookInstruction = '''
IMPORTANT: We are using MULTIPLE reference textbooks. Here is the list of books and their indices:
$bookDescriptions

You must map each chapter/module to its corresponding book.
In the returned JSON, for every chapter object in the "chapters" array, you MUST include a "bookIndex" field (0-based integer, e.g. 0 for Book 0, 1 for Book 1, etc.) indicating which textbook contains this chapter, and "startPage" / "endPage" must refer to pages within that specific textbook.
''';
    }

    var chapterPrompt = promptTemplate
        .replaceAll('%filename%', filename)
        .replaceAll('%custom_instructions%', '$instructionsBlock\n$multiBookInstruction');
    
    // Replace the default offset block with our custom one
    chapterPrompt = chapterPrompt.replaceAll(PromptService.offsetBlock, offsetBlock);
    
    // Safe fallback for '%chapter1_abs_page%' placeholder just in case
    final firstCh1 = chapter1AbsolutePages.isNotEmpty ? chapter1AbsolutePages.first : 1;
    chapterPrompt = chapterPrompt.replaceAll('%chapter1_abs_page%', '$firstCh1');

    Map<String, dynamic>? meta;
    Exception? lastException;
    for (final modelName in modelsToTry) {
      for (final apiKey in keys) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(responseMimeType: 'application/json'),
          );
          final response = await _retryTransient(
            () => model.generateContent([Content.multi([TextPart(chapterPrompt), ...syllabusParts, ...fileParts])])
                .timeout(const Duration(minutes: 4)),
            onRetry: (a, e) => print('[AiService] Chapter list transient ($modelName) attempt $a: ${_cleanErrMsg(e)}'),
          );
          if (response.text != null) {
            meta = _cleanAndDecodeJson(response.text!);
            break;
          }
        } on TimeoutException {
          lastException = Exception('Chapter mapping timed out ($modelName).');
        } catch (e) {
          lastException = Exception('Chapter mapping failed ($modelName): ${_cleanErrMsg(e)}');
        }
      }
      if (meta != null) break;
    }
    if (meta == null) throw lastException ?? Exception('Failed to map chapters. All models/keys exhausted.');

    final rawChapters = (meta['chapters'] ?? meta['modules']) as List?;
    if (rawChapters == null || rawChapters.isEmpty) {
      throw Exception('The model returned no chapters for this table of contents.');
    }

    // Normalize: stable ids + parsed page bounds.
    final chapters = <Map<String, dynamic>>[];
    for (var i = 0; i < rawChapters.length; i++) {
      final c = rawChapters[i] is Map ? Map<String, dynamic>.from(rawChapters[i]) : <String, dynamic>{};
      final cid = (c['id']?.toString().trim().isNotEmpty ?? false) ? c['id'].toString() : 'm${i + 1}';
      chapters.add({
        'id': cid,
        'title': c['title']?.toString() ?? 'Chapter ${i + 1}',
        'description': c['description']?.toString() ?? '',
        'startPage': _asInt(c['startPage']),
        'endPage': _asInt(c['endPage']),
        'bookIndex': _asInt(c['bookIndex']) ?? 0,
      });
    }
    // Resolve bounds left-to-right: a missing/invalid endPage falls back to the
    // page before the next chapter starts, so every section call has a range.
    for (var i = 0; i < chapters.length; i++) {
      int? start = chapters[i]['startPage'] as int?;
      final int currentBookIdx = chapters[i]['bookIndex'] as int? ?? 0;
      final int currentBookCh1 = currentBookIdx < chapter1AbsolutePages.length ? chapter1AbsolutePages[currentBookIdx] : 1;
      start ??= (i == 0 ? currentBookCh1 : null);
      int? end = chapters[i]['endPage'] as int?;
      final nextStart = i + 1 < chapters.length ? chapters[i + 1]['startPage'] as int? : null;
      if (end == null || (start != null && end < start)) {
        end = nextStart != null ? nextStart - 1 : (start != null ? start + 9 : null);
      }
      chapters[i]['startPage'] = start;
      chapters[i]['endPage'] = end;
    }

    // ---- Stage 2: sections per chapter (real progress, bounded concurrency) -
    final int chapterCount = chapters.length;
    onProgress?.call('Mapping sections (0/$chapterCount)…', 0);
    final List<List<Map<String, dynamic>>?> sectionSlots =
        List<List<Map<String, dynamic>>?>.filled(chapterCount, null);
    int done = 0;
    int nextIdx = 0;
    final int concurrency = (await _resolveConcurrency()).clamp(1, chapterCount);

    Future<void> worker() async {
      while (true) {
        final i = nextIdx;
        if (i >= chapterCount) break;
        nextIdx++;
        final ch = chapters[i];
        
        final int bookIdx = ch['bookIndex'] as int? ?? 0;
        final File specificIndexFile = (bookIdx >= 0 && bookIdx < indexFiles.length) ? indexFiles[bookIdx] : indexFiles.first;
        final int specificChapter1Page = bookIdx < chapter1AbsolutePages.length ? chapter1AbsolutePages[bookIdx] : 1;
        final name = specificIndexFile.path.split(RegExp(r'[\\/]')).last;
        final specificFileParts = await _buildFileParts([specificIndexFile], fileLabels: ['\n--- INDEX FOR BOOK $bookIdx: "$name" ---\n']);

        List<Map<String, dynamic>>? secs;
        try {
          secs = await _generateSectionsForChapter(
            chapter: ch,
            filename: name,
            chapter1AbsolutePage: specificChapter1Page,
            instructionsBlock: instructionsBlock,
            fileParts: specificFileParts,
            models: modelsToTry,
            keys: keys,
            isCourse: isCourse,
            syllabusParts: syllabusParts,
          );
        } catch (e) {
          print('[AiService] Sections for chapter ${ch['id']} failed: ${_cleanErrMsg(e)}');
        }
        // Never drop a chapter: fall back to one whole-chapter section.
        if (secs == null || secs.isEmpty) {
          secs = [
            {
              'id': '${ch['id']}-s1',
              'title': ch['title'],
              'description': ch['description'],
              'color': 'duo-blue',
              if (ch['startPage'] != null) 'startPage': ch['startPage'],
              if (ch['endPage'] != null) 'endPage': ch['endPage'],
            }
          ];
        }
        sectionSlots[i] = secs;
        done++;
        onProgress?.call('Mapping sections ($done/$chapterCount)…', done / chapterCount);
      }
    }

    await Future.wait(List.generate(concurrency, (_) => worker()));

    // ---- Assemble via Book.fromJson (reuses defensive parsing + format
    //      defaults). Persist the user's verbatim instructions on the book. ---
    final assembled = <String, dynamic>{
      'id': 'book-${DateTime.now().millisecondsSinceEpoch}',
      'title': meta['title']?.toString() ?? filename,
      'description': meta['description']?.toString() ?? 'Auto-generated course',
      'icon': meta['icon']?.toString() ?? 'Book',
      if (meta['systemPrompt'] != null) 'systemPrompt': meta['systemPrompt'],
      'modules': [
        for (var i = 0; i < chapterCount; i++)
          {
            'id': chapters[i]['id'],
            'title': chapters[i]['title'],
            'description': chapters[i]['description'],
            'sections': [
              for (var s in (sectionSlots[i] ?? const <Map<String, dynamic>>[]))
                {
                  ...s,
                  'bookIndex': chapters[i]['bookIndex'] ?? 0,
                }
            ],
          }
      ],
    };
    onProgress?.call('Finalizing structure…', 1.0);
    return Book.fromJson(assembled).copyWith(customInstructions: customInstructions);
  }

  /// Stage-2 helper: details the sections of ONE [chapter] via
  /// [PromptService.sectionList], bounded to that chapter's page range.
  /// Returns normalized section JSON maps (chapter-scoped ids), or null when
  /// every model/key combination fails so the caller can fall back to a
  /// single whole-chapter section rather than lose the chapter.
  Future<List<Map<String, dynamic>>?> _generateSectionsForChapter({
    required Map<String, dynamic> chapter,
    required String filename,
    required int chapter1AbsolutePage,
    required String instructionsBlock,
    required List<Part> fileParts,
    required List<String> models,
    required List<String> keys,
    bool isCourse = false,
    List<Part> syllabusParts = const [],
  }) async {
    final promptTemplate = isCourse ? PromptService.syllabusSectionList : PromptService.sectionList;
    final prompt = promptTemplate
        .replaceAll('%filename%', filename)
        .replaceAll('%chapter1_abs_page%', '$chapter1AbsolutePage')
        .replaceAll('%custom_instructions%', instructionsBlock)
        .replaceAll('%chapter_title%', chapter['title']?.toString() ?? '')
        .replaceAll('%chapter_start%', (chapter['startPage'])?.toString() ?? '?')
        .replaceAll('%chapter_end%', (chapter['endPage'])?.toString() ?? '?');

    final parts = <Part>[TextPart(prompt), ...syllabusParts, ...fileParts];
    Object? lastErr;
    for (final modelName in models) {
      for (final apiKey in keys) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(responseMimeType: 'application/json'),
          );
          final response = await _retryTransient(
            () => model.generateContent([Content.multi(parts)]).timeout(const Duration(minutes: 3)),
            onRetry: (a, e) => print('[AiService] Sections (${chapter['id']}) transient ($modelName) attempt $a: ${_cleanErrMsg(e)}'),
          );
          final text = response.text;
          if (text == null || text.trim().isEmpty) continue;
          final jsonMap = _cleanAndDecodeJson(text);
          final rawSecs = jsonMap['sections'] as List?;
          if (rawSecs == null || rawSecs.isEmpty) continue;
          final out = <Map<String, dynamic>>[];
          for (var j = 0; j < rawSecs.length; j++) {
            final s = rawSecs[j] is Map ? Map<String, dynamic>.from(rawSecs[j]) : <String, dynamic>{};
            final sid = (s['id']?.toString().trim().isNotEmpty ?? false) ? s['id'].toString() : 's${j + 1}';
            out.add({
              'id': '${chapter['id']}-$sid',
              'title': s['title']?.toString() ?? 'Section ${j + 1}',
              'description': s['description']?.toString() ?? '',
              'color': s['color']?.toString() ?? 'duo-blue',
              if (_asInt(s['startPage']) != null) 'startPage': _asInt(s['startPage']),
              if (_asInt(s['endPage']) != null) 'endPage': _asInt(s['endPage']),
            });
          }
          if (out.isNotEmpty) return out;
        } catch (e) {
          lastErr = e;
        }
      }
    }
    if (lastErr != null) {
      print('[AiService] Sections (${chapter['id']}) exhausted: ${_cleanErrMsg(lastErr)}');
    }
    return null;
  }

  /// Generates all lessons for [unit] off the section's shared PDF chunk.
  ///
  /// Pipeline: (1) a lite-model lesson *plan*, then (2) per-lesson JSON calls
  /// generated ONE AT A TIME, IN ORDER. Each lesson's text is streamed back via
  /// [onLessonGenerated] the moment it's ready (so it shows immediately); when
  /// [generateGraphics] is true its diagram is then rendered and the lesson is
  /// streamed again — so the learner watches lesson → its diagram → next lesson
  /// appear in sequence, rather than a chunk of texts followed by a chunk of
  /// diagrams.
  ///
  /// RESUME: any lessons already present on [unit] (from an interrupted run)
  /// are kept and shown straight away; only the missing lessons are generated
  /// and only missing diagrams are filled — so generation continues from where
  /// it left off instead of restarting.
  ///
  /// [previousUnit]/[nextUnit] give the AI this unit's boundaries inside the
  /// shared chunk; [previousGeneratedUnits] is a short summary of units already
  /// generated in this section so the model doesn't re-teach covered material.
  Future<Unit> generateUnitContent(
    Unit unit,
    Book bookContext,
    void Function(String status, [double? progress]) onProgress, {
    String? sectionPdfPath,
    Unit? previousUnit,
    Unit? nextUnit,
    List<Unit> previousGeneratedUnits = const [],
    bool generateGraphics = true,
    void Function(List<Lesson> lessonsSoFar)? onLessonGenerated,
    String? forcedApiKey,
  }) async {
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final textModelsToTry = await _getPrimaryTextModels();
    final liteModelsToTry = await _getLiteModels();

    // New-flow units share the section\'s PDF chunk; old-flow units have
    // their own pdfPath. Either way, we need a real, on-disk file.
    final String? chunkPath = unit.pdfPath ?? sectionPdfPath;
    if (chunkPath == null) throw Exception("No PDF/Image chunk available for this unit.");
    final chunkFile = File(chunkPath);
    if (!chunkFile.existsSync()) {
      throw Exception("Local file missing. Tap 'Restore' on the warning banner to re-link source files.");
    }

    // Build a layout descriptor of all available lesson formats in the book.
    // Different lessons in the same unit can follow different formats.
    final String formatsLayoutString = bookContext.lessonFormats.map((f) {
      final slidesStr = f.slides
          .map((t) => "  * Type: ${t.type} | Condition: ${t.condition} | Instructions: ${t.description}")
          .join('\n');
      return "- Format: ${f.id} (${f.name}) — ${f.description}\n$slidesStr";
    }).join('\n\n');

    // Context shared by the plan + per-lesson prompts: the unit's neighbours
    // (so generation stays inside this unit's slice of the shared section PDF)
    // and a summary of already-generated units (so material isn't repeated).
    final String neighborContext = _buildNeighborContext(previousUnit, unit, nextUnit);
    final String previousUnitsContent = _buildPreviousUnitsContent(previousGeneratedUnits);
    final String instructionsBlock = PromptService.instructionsBlock(bookContext.customInstructions);

    // --- Stage 1: lesson plan (lite-model fallback ladder) ----------------
    // The plan is a small text outline; a lite model that hasn't answered in
    // ~120s is misbehaving (overloaded / stuck), so we cap the wait and jump to
    // the NEXT model/key rather than blocking the whole unit on one slow model.
    // A genuine transient server blip (502/overload) still gets one quick retry
    // on the same model before we move on; timeouts do NOT (retryTimeouts:false).
    const planTimeout = Duration(seconds: 120);
    onProgress("Analyzing PDF & Planning Layout...");
    final hydratedPlanPrompt = PromptService.plan
        .replaceAll('%unit_title%', unit.title)
        .replaceAll('%formats_layout%', formatsLayoutString)
        .replaceAll('%custom_instructions%', instructionsBlock)
        .replaceAll('%neighbor_context%', neighborContext);

    final planFileParts = await _buildFileParts([chunkFile]);
    String? lessonPlan;
    Exception? planError;
    for (final liteModel in liteModelsToTry) {
      for (final apiKey in keys) {
        try {
          final modelText = GenerativeModel(model: liteModel, apiKey: apiKey);
          final planResponse = await _retryTransient(
            () => modelText
                .generateContent([Content.multi([TextPart(hydratedPlanPrompt), ...planFileParts])])
                .timeout(planTimeout),
            maxAttempts: 2,
            baseDelay: const Duration(seconds: 1),
            retryTimeouts: false,
            onRetry: (a, e) {
              print('[AiService] Unit plan transient ($liteModel) attempt $a: ${_cleanErrMsg(e)}');
              onProgress('Server hiccup — retrying...');
            },
          );
          final text = planResponse.text ?? '';
          if (text.trim().isNotEmpty) {
            lessonPlan = text;
            break;
          }
        } on TimeoutException {
          planError = Exception('Plan timed out on "$liteModel" after ${planTimeout.inSeconds}s.');
          print('[AiService] Unit plan TIMEOUT ($liteModel) — switching to next model/key.');
          onProgress('"$liteModel" is slow — trying another model...');
        } catch (e) {
          planError = Exception('Plan failed ($liteModel): ${_cleanErrMsg(e)}');
          if (_isTransient(e)) onProgress('Model busy — trying another model...');
        }
      }
      if (lessonPlan != null) break;
    }
    if (lessonPlan == null) {
      throw planError ?? Exception('AI failed to generate a lesson plan.');
    }
    // Capture into a final non-nullable so the worker closure below can read
    // it without null-promotion concerns.
    final String planText = lessonPlan;

    int lessonCount = _parseLessonCount(planText);
    if (lessonCount <= 0) {
      throw Exception('Could not determine lesson count from plan. Expected a "TOTAL_LESSONS: N" line.');
    }
    // Soft cap so a hallucinated count of, say, 99 doesn't blow up the unit.
    if (lessonCount > 30) lessonCount = 30;

    // --- Stage 2: per-lesson, IN ORDER --------------------------------------
    // Lessons are produced one at a time. Each lesson's text is streamed the
    // moment it lands; its diagram is then rendered and streamed too, before we
    // move to the next lesson — so the learner sees lesson → diagram → next.
    // Lessons already on [unit] (an interrupted/resumed run) are pre-seeded and
    // shown immediately, and only the gaps (missing lessons / missing art) are
    // filled, so we continue from where we left off.
    final lessonFileParts = await _buildFileParts([chunkFile]);
    final List<Lesson> existing = List.of(unit.lessons);
    final int total = lessonCount > existing.length ? lessonCount : existing.length;
    final List<Lesson?> slots = List<Lesson?>.filled(total, null);
    for (int i = 0; i < existing.length && i < total; i++) {
      slots[i] = existing[i];
    }

    // Combined step accounting: one text step per lesson, plus one art step
    // per lesson when diagrams are enabled, so progress covers the whole run.
    final int totalSteps = generateGraphics ? total * 2 : total;
    int doneSteps = 0;
    Object? lastLessonError;

    List<Lesson> collected() => slots.whereType<Lesson>().toList();

    // A lesson still needs art if its own diagram, or any proof/step diagram,
    // has a prompt but no rendered canvas yet.
    bool needsArt(Lesson l) {
      bool empty(String? s) => s == null || s.trim().isEmpty;
      if ((l.canvasPrompt?.trim().isNotEmpty ?? false) && empty(l.canvasSvg)) return true;
      return l.slides.any((s) =>
          (s.type == 'proof' || s.type == 'step_by_step') &&
          (s.canvasPrompt?.trim().isNotEmpty ?? false) &&
          empty(s.canvasSvg));
    }

    for (int i = 0; i < total; i++) {
      Lesson? lesson = slots[i];

      // 1. Text — generate only when this slot isn't already filled (resume).
      if (lesson == null) {
        try {
          lesson = await _generateOneLesson(
            index: i + 1,
            unit: unit,
            bookContext: bookContext,
            lessonPlan: planText,
            neighborContext: neighborContext,
            previousUnitsContent: previousUnitsContent,
            instructionsBlock: instructionsBlock,
            fileParts: lessonFileParts,
            textModels: textModelsToTry,
            keys: keys,
          );
        } catch (e) {
          lastLessonError = e;
          print('[AiService] Lesson ${i + 1} failed permanently: ${_cleanErrMsg(e)}');
        }
        if (lesson != null) slots[i] = lesson;
      }
      doneSteps++;
      onProgress('Generating lessons (${collected().length}/$total)...', doneSteps / totalSteps);
      onLessonGenerated?.call(collected()); // show this lesson right away

      // 2. This lesson's diagram(s), then stream the lesson again with its art.
      if (generateGraphics) {
        if (lesson != null && needsArt(lesson)) {
          try {
            slots[i] = await _attachArtToLesson(lesson, forcedApiKey: forcedApiKey);
            onLessonGenerated?.call(collected());
          } catch (e) {
            print('[AiService] Art for lesson ${i + 1} failed: ${_cleanErrMsg(e)}');
          }
        }
        doneSteps++; // counted even when skipped/failed so totals reconcile
        onProgress('Rendering diagrams (${i + 1}/$total)...', doneSteps / totalSteps);
      }
    }

    final newLessons = collected();
    if (newLessons.isEmpty) {
      throw Exception(
        'AI returned no usable lessons.${lastLessonError != null ? ' Last error: ${_cleanErrMsg(lastLessonError)}' : ''}',
      );
    }
    return unit.copyWith(isGenerated: true, lessons: newLessons);
  }

  /// One natural-language boundary descriptor for the unit currently being
  /// generated, so the model knows which slice of the shared section chunk
  /// belongs to it (and which neighbouring units to leave alone).
  String _buildNeighborContext(Unit? prev, Unit current, Unit? next) {
    final b = StringBuffer();
    b.writeln('- CURRENT unit (generate ONLY this): "${current.title}" — ${current.description}');
    b.writeln(prev != null
        ? '- PREVIOUS unit (already handled — do NOT cover): "${prev.title}" — ${prev.description}'
        : '- PREVIOUS unit: (none — this is the first unit in the section)');
    b.writeln(next != null
        ? '- NEXT unit (handled separately later — do NOT cover): "${next.title}" — ${next.description}'
        : '- NEXT unit: (none — this is the last unit in the section)');
    return b.toString().trim();
  }

  /// Compact summary of up to a couple of already-generated units, used to
  /// stop the model from re-teaching content the learner has already seen.
  /// Length-capped so it never dominates the prompt.
  String _buildPreviousUnitsContent(List<Unit> prevUnits) {
    if (prevUnits.isEmpty) {
      return '(none — this is the first generated unit in the section)';
    }
    final b = StringBuffer();
    for (final u in prevUnits) {
      b.writeln('UNIT "${u.title}":');
      for (final l in u.lessons) {
        final desc = l.description.trim();
        b.writeln('  • ${l.title}${desc.isNotEmpty ? ' — $desc' : ''}');
      }
    }
    var s = b.toString().trim();
    if (s.length > 2000) s = '${s.substring(0, 2000)}…';
    return s;
  }

  /// Resolves how many lesson requests to run concurrently. Reads the
  /// `gen_concurrency` pref ('auto' or a number); 'auto' picks a value from
  /// the device's core count as a rough device/network capacity proxy.
  Future<int> _resolveConcurrency() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final setting = prefs.getString('gen_concurrency') ?? 'auto';
      if (setting != 'auto') {
        final n = int.tryParse(setting);
        if (n != null && n >= 1) return n.clamp(1, 6);
      }
      final cores = kIsWeb ? 1 : Platform.numberOfProcessors;
      if (cores >= 8) return 4;
      if (cores >= 4) return 3;
      return 2;
    } catch (_) {
      return 2;
    }
  }

  /// Generates a single lesson (number [index] in the plan) as JSON, walking
  /// the text-model × key fallback ladder. Returns the parsed [Lesson] with
  /// unit-scoped ids, or null if every combination produced no usable output.
  /// Throws only when every combination errored.
  Future<Lesson?> _generateOneLesson({
    required int index,
    required Unit unit,
    required Book bookContext,
    required String lessonPlan,
    required String neighborContext,
    required String previousUnitsContent,
    required String instructionsBlock,
    required List<Part> fileParts,
    required List<String> textModels,
    required List<String> keys,
  }) async {
    final prompt = PromptService.singleLessonJson
        .replaceAll('%system_prompt%', bookContext.systemPrompt ?? 'You are an expert tutor.')
        .replaceAll('%custom_instructions%', instructionsBlock)
        .replaceAll('%unit_title%', unit.title)
        .replaceAll('%lesson_plan%', lessonPlan)
        .replaceAll('%lesson_index%', '$index')
        .replaceAll('%neighbor_context%', neighborContext)
        .replaceAll('%previous_units_content%', previousUnitsContent);

    final parts = <Part>[TextPart(prompt), ...fileParts];
    final validFormatIds = bookContext.lessonFormats.map((f) => f.id).toSet();

    Object? lastErr;
    for (final modelName in textModels) {
      for (final apiKey in keys) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(responseMimeType: 'application/json'),
          );
          final response = await _retryTransient(
            () => model.generateContent([Content.multi(parts)]).timeout(const Duration(minutes: 3)),
            onRetry: (a, e) => print('[AiService] Lesson $index transient ($modelName) attempt $a: ${_cleanErrMsg(e)}'),
          );
          final text = response.text;
          if (text == null || text.trim().isEmpty) {
            throw Exception('Empty response for lesson $index.');
          }
          final jsonMap = _cleanAndDecodeJson(text);
          final lesson = Lesson.fromJson(jsonMap);
          final uniqueLessonId = '${unit.id}-${lesson.id.isNotEmpty ? lesson.id : 'l$index'}';
          final claimedFormat = lesson.formatId;
          final acceptedFormat = (claimedFormat != null && validFormatIds.contains(claimedFormat))
              ? claimedFormat
              : bookContext.defaultFormatId;
          return lesson.copyWith(
            id: uniqueLessonId,
            formatId: acceptedFormat,
            slides: lesson.slides.map((s) => s.copyWith(id: '$uniqueLessonId-${s.id}')).toList(),
          );
        } catch (e) {
          lastErr = e;
        }
      }
    }
    if (lastErr != null) throw Exception(_cleanErrMsg(lastErr));
    return null;
  }

  /// Regenerates a whole [lesson] in [unit]. Synthesises a single-lesson plan
  /// from the lesson's title + description so the model knows exactly what to
  /// recreate, then runs the same per-lesson JSON call used during full unit
  /// generation. Diagrams are re-rendered when [generateGraphics] is true.
  /// Returns the fresh lesson (with the same id as the original so it slots
  /// back into the unit at the same position), or null when every model/key
  /// combination fails.
  Future<Lesson?> regenerateLesson({
    required Lesson lesson,
    required Unit unit,
    required Book bookContext,
    String? sectionPdfPath,
    Unit? previousUnit,
    Unit? nextUnit,
    bool generateGraphics = true,
    String? forcedApiKey,
  }) async {
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final textModels = await _getPrimaryTextModels();

    final String? chunkPath = unit.pdfPath ?? sectionPdfPath;
    if (chunkPath == null) {
      throw Exception('No PDF chunk available for this unit — cannot regenerate.');
    }
    final chunkFile = File(chunkPath);
    if (!chunkFile.existsSync()) {
      throw Exception("Local file missing. Tap 'Restore' on the warning banner to re-link source files.");
    }

    final neighborContext = _buildNeighborContext(previousUnit, unit, nextUnit);
    final instructionsBlock = PromptService.instructionsBlock(bookContext.customInstructions);

    // Synthesise a one-lesson plan so the model regenerates THIS lesson
    // specifically rather than picking a new topic.
    final synthPlan = StringBuffer()
      ..writeln('TOTAL_LESSONS: 1')
      ..writeln('Lesson 1: ${lesson.title}')
      ..writeln(lesson.description);
    if (lesson.canvasPrompt != null && lesson.canvasPrompt!.trim().isNotEmpty) {
      synthPlan.writeln('Diagram: ${lesson.canvasPrompt!.trim()}');
    }
    synthPlan.writeln('Cover the same pedagogical point. Use the same lesson format ("${lesson.formatId ?? bookContext.defaultFormatId}") and a similar slide structure.');

    final fileParts = await _buildFileParts([chunkFile]);
    Lesson? fresh;
    try {
      fresh = await _generateOneLesson(
        index: 1,
        unit: unit,
        bookContext: bookContext,
        lessonPlan: synthPlan.toString(),
        neighborContext: neighborContext,
        previousUnitsContent: '(regeneration of an existing lesson — no prior-unit context needed)',
        instructionsBlock: instructionsBlock,
        fileParts: fileParts,
        textModels: textModels,
        keys: keys,
      );
    } catch (e) {
      print('[AiService] Lesson regen failed: ${_cleanErrMsg(e)}');
      return null;
    }
    if (fresh == null) return null;

    // Preserve the original lesson id so the unit's lesson order stays stable.
    fresh = fresh.copyWith(
      id: lesson.id,
      slides: fresh.slides.map((s) {
        // Rewrite slide ids so they're rooted on the kept lesson id.
        final tail = s.id.split('-').last;
        return s.copyWith(id: '${lesson.id}-$tail');
      }).toList(),
    );

    if (generateGraphics) {
      try {
        fresh = await _attachArtToLesson(fresh, forcedApiKey: forcedApiKey);
      } catch (e) {
        print('[AiService] Lesson regen art failed: ${_cleanErrMsg(e)}');
      }
    }
    return fresh;
  }

  /// Regenerates a single [slide] inside [lesson], optionally steered by a
  /// free-text [note]. Re-uses the source [chunkPath] (the section/unit PDF)
  /// for grounding. Returns a fresh [Slide] of the same type and id, or null
  /// when every model/key combination fails (caller keeps the old slide).
  Future<Slide?> regenerateSlide({
    required Slide slide,
    required Lesson lesson,
    required Book bookContext,
    String? chunkPath,
    String? note,
    String? forcedApiKey,
  }) async {
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final textModels = await _getPrimaryTextModels();

    final noteLine = (note?.trim().isNotEmpty ?? false)
        ? 'USER STEERING NOTE FOR THIS REGENERATION: ${note!.trim()}\n'
        : '';
    final prompt = PromptService.singleSlideJson
        .replaceAll('%system_prompt%', bookContext.systemPrompt ?? 'You are an expert tutor.')
        .replaceAll('%custom_instructions%', PromptService.instructionsBlock(bookContext.customInstructions))
        .replaceAll('%lesson_title%', lesson.title)
        .replaceAll('%unit_title%', lesson.title)
        .replaceAll('%slide_type%', slide.type)
        .replaceAll('%slide_content%', jsonEncode(slide.toJson()))
        .replaceAll('%slide_id%', slide.id)
        .replaceAll('%regen_note%', noteLine);

    // Attach the source chunk when we still have it on disk — improves
    // accuracy — but regeneration must still work without it.
    final List<Part> fileParts = [];
    if (chunkPath != null) {
      final f = File(chunkPath);
      if (f.existsSync()) fileParts.addAll(await _buildFileParts([f]));
    }
    final parts = <Part>[TextPart(prompt), ...fileParts];

    Object? lastErr;
    for (final modelName in textModels) {
      for (final apiKey in keys) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(responseMimeType: 'application/json'),
          );
          final response = await _retryTransient(
            () => model.generateContent([Content.multi(parts)]).timeout(const Duration(minutes: 3)),
            onRetry: (a, e) => print('[AiService] Slide regen transient ($modelName) attempt $a: ${_cleanErrMsg(e)}'),
          );
          final text = response.text;
          if (text == null || text.trim().isEmpty) continue;
          final jsonMap = _cleanAndDecodeJson(text);
          final fresh = Slide.fromJson(jsonMap);
          // Preserve the slide's identity and type; the model only supplies
          // the new content/options. Keep any existing diagram SVG.
          return fresh.copyWith(id: slide.id, type: slide.type, canvasSvg: slide.canvasSvg);
        } catch (e) {
          lastErr = e;
        }
      }
    }
    if (lastErr != null) {
      print('[AiService] Slide regen exhausted all models. Last: ${_cleanErrMsg(lastErr)}');
    }
    return null;
  }

  /// Asks the AI to break a section\'s PDF chunk into a list of units
  /// (manifest only — no slides). Used by the new TOC-only flow the first
  /// time a section is opened. Returns units with empty `lessons` and
  /// `isGenerated == false`, so the existing per-unit lesson generation
  /// Stage-2 graphics call: turn a single natural-language `canvasPrompt`
  /// into a JavaScript `draw(ctx, W, H)` function using the user\'s configured
  /// graphics models (with fallback). The function is later run inside a
  /// reusable HTML5 `<canvas>` host. Returns null when every model/key
  /// combination fails so the caller can persist the lesson without art
  /// rather than blow up the whole generation.
  ///
  /// [contextText] is a short snippet of the surrounding lesson content so
  /// the model can keep the diagram thematically consistent (e.g. variable
  /// names, units). Pass an empty string when not relevant.
  Future<String?> generateCanvasArt(String canvasPrompt, {String contextText = '', String? errorContext, String? forcedApiKey}) async {
    if (canvasPrompt.trim().isEmpty) return null;

    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getPrimaryGraphicsModels();
    // Cap context to keep prompts small — the SVG diagram doesn\'t need the
    // entire lesson, only a few sentences for tone matching.
    final trimmedContext = contextText.length > 800 ? contextText.substring(0, 800) : contextText;
    String hydrated = PromptService.canvasArt
        .replaceAll('%canvas_prompt%', canvasPrompt.trim())
        .replaceAll('%lesson_context%', trimmedContext);

    if (errorContext != null && errorContext.isNotEmpty) {
      hydrated += '\n\nPREVIOUS ATTEMPT FAILED WITH JAVASCRIPT ERROR:\n$errorContext\nFix the code so it doesn\'t throw this error.';
    }

    Object? lastErr;
    for (final modelName in modelsToTry) {
      for (final apiKey in keys) {
        try {
          final model = GenerativeModel(model: modelName, apiKey: apiKey);
          final response = await _retryTransient(
            () => model.generateContent([Content.text(hydrated)])
                .timeout(const Duration(minutes: 2)),
            onRetry: (a, e) => print('[AiService] Canvas art transient ($modelName) attempt $a: ${_cleanErrMsg(e)}'),
          );
          final text = response.text;
          if (text == null || text.trim().isEmpty) continue;
          final drawFn = _extractDrawFunction(text);
          if (drawFn != null) return drawFn;
        } catch (e) {
          lastErr = e;
          print('[AiService] Canvas art failed ($modelName): ${_cleanErrMsg(e)}');
        }
      }
    }
    if (lastErr != null) {
      print('[AiService] Canvas art exhausted all models. Last: ${_cleanErrMsg(lastErr)}');
    }
    return null;
  }

  /// Pulls a clean JavaScript program out of the model's raw response.
  /// Accepts either the static `function draw(ctx, W, H)` entry point or
  /// the richer `function sketch(canvas, W, H)` entry point used for
  /// interactive 2D and THREE.js-powered 3D diagrams. Strips Markdown code
  /// fences first, then isolates the chosen function block by brace-matching
  /// so any chatty text the model wrapped around it is dropped. Returns
  /// null when no balanced function is found, so the caller keeps the
  /// lesson art-free rather than embedding broken JS.
  String? _extractDrawFunction(String raw) {
    var s = raw.trim();
    // Strip code fences if present.
    final fence = RegExp(r'```(?:js|javascript)?\s*([\s\S]*?)```', multiLine: true);
    final fenceMatch = fence.firstMatch(s);
    if (fenceMatch != null) s = fenceMatch.group(1)!.trim();

    // Prefer `sketch` (interactive / 3D) when present, otherwise fall back
    // to `draw` (static 2D). Either keyword is acceptable.
    int start = s.indexOf('function sketch');
    if (start < 0) start = s.indexOf('function draw');
    if (start < 0) return null;
    final braceOpen = s.indexOf('{', start);
    if (braceOpen < 0) return null;

    // Walk braces to find the matching close for the function body. Good
    // enough for canvas code (which rarely puts stray braces inside strings).
    int depth = 0;
    for (int i = braceOpen; i < s.length; i++) {
      final c = s[i];
      if (c == '{') {
        depth++;
      } else if (c == '}') {
        depth--;
        if (depth == 0) return s.substring(start, i + 1).trim();
      }
    }
    return null; // unbalanced — discard rather than embed broken JS
  }

  /// Renders the diagram(s) for a SINGLE [lesson]: the lesson-level diagram
  /// plus any proof/step_by_step slide that asked for one. Only fills art that
  /// is missing (a non-null `canvasSvg` is left as-is). Failures are tolerated
  /// — a lesson simply renders without that diagram. Called per-lesson right
  /// after the lesson's text is generated, so visuals appear incrementally.
  Future<Lesson> _attachArtToLesson(Lesson lesson, {String? forcedApiKey}) async {
    // 1. Lesson-level diagram. Use the first slide's content as context so the
    //    art stays thematically consistent with the lesson.
    String? lessonArt = lesson.canvasSvg;
    if (lessonArt == null && (lesson.canvasPrompt?.trim().isNotEmpty ?? false)) {
      final ctx = lesson.slides.isNotEmpty ? lesson.slides.first.content : '';
      lessonArt = await generateCanvasArt(lesson.canvasPrompt!, contextText: ctx, forcedApiKey: forcedApiKey);
    }

    // 2. Per-slide diagrams for proof / step_by_step slides only.
    final List<Slide> updatedSlides = [];
    for (final slide in lesson.slides) {
      final isProofLike = slide.type == 'proof' || slide.type == 'step_by_step';
      String? slideArt = slide.canvasSvg;
      if (isProofLike && slideArt == null && (slide.canvasPrompt?.trim().isNotEmpty ?? false)) {
        slideArt = await generateCanvasArt(slide.canvasPrompt!, contextText: slide.content, forcedApiKey: forcedApiKey);
      }
      updatedSlides.add(slide.copyWith(canvasSvg: slideArt));
    }

    return lesson.copyWith(canvasSvg: lessonArt, slides: updatedSlides);
  }



  /// path continues to work unchanged. [customInstructions] is the planner
  /// guidance captured on the "Plan units" panel (pre-filled from the book's
  /// instructions but editable per-section); injected into the prompt.
  Future<UnitManifestResult> generateUnitManifest(
    Section section,
    Book bookContext, {
    String? customInstructions,
    String? forcedApiKey,
  }) async {
    if (section.pdfPath == null) {
      throw Exception('Section has no PDF chunk — cannot generate unit manifest.');
    }
    final chunkFile = File(section.pdfPath!);
    if (!chunkFile.existsSync()) {
      throw Exception("Local file missing. Tap 'Restore' on the warning banner to re-link source files.");
    }

    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getLiteModels();

    // Build the catalog the AI picks `formatId` from. Each entry is one
    // line: "- <id> :: <name> — <one-line summary>".
    final formatCatalog = bookContext.lessonFormats
        .map((f) => '- ${f.id} :: ${f.name} — ${f.description}')
        .join('\n');

    final hydratedPrompt = PromptService.unitManifest
        .replaceAll('%section_title%', section.title)
        .replaceAll('%section_description%', section.description)
        .replaceAll('%format_catalog%', formatCatalog)
        .replaceAll('%custom_instructions%', PromptService.instructionsBlock(customInstructions));

    final parts = <Part>[TextPart(hydratedPrompt), ...await _buildFileParts([chunkFile])];

    Exception? lastException;
    for (final modelName in modelsToTry) {
      for (final apiKey in keys) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(responseMimeType: 'application/json'),
          );
          final response = await _retryTransient(
            () => model.generateContent([Content.multi(parts)])
                .timeout(const Duration(minutes: 3)),
            onRetry: (a, e) => print('[AiService] Unit manifest transient ($modelName) attempt $a: ${_cleanErrMsg(e)}'),
          );

          final text = response.text;
          if (text == null || text.trim().isEmpty) {
            throw Exception('Empty response from unit manifest call.');
          }
          final jsonMap = _cleanAndDecodeJson(text);
          final unitsData = jsonMap['units'] as List?;
          if (unitsData == null || unitsData.isEmpty) {
            throw Exception('Unit manifest contained no units.');
          }

          final units = <Unit>[];
          for (var i = 0; i < unitsData.length; i++) {
            final raw = unitsData[i];
            if (raw is! Map) continue;
            final base = Unit.fromJson(Map<String, dynamic>.from(raw));
            final id = base.id.isNotEmpty ? base.id : 'u${i + 1}';
            units.add(base.copyWith(
              id: '${section.id}-$id',
              isGenerated: false,
              lessons: const [],
              // The unit shares the section's PDF chunk — it does not get
              // its own pdfPath or page range.
              pdfPath: null,
              startPage: null,
              endPage: null,
            ));
          }
          if (units.isEmpty) throw Exception('Unit manifest had no usable entries.');

          final newFormats = <LessonFormat>[];
          final formatsData = jsonMap['newLessonFormats'] as List?;
          if (formatsData != null) {
            for (final f in formatsData) {
              if (f is Map) {
                try {
                  newFormats.add(LessonFormat.fromJson(Map<String, dynamic>.from(f)));
                } catch (_) {}
              }
            }
          }

          return UnitManifestResult(units: units, newFormats: newFormats);
        } on TimeoutException {
          lastException = Exception('Unit manifest request timed out ($modelName).');
        } catch (e) {
          lastException = Exception('Unit manifest failed ($modelName): ${_cleanErrMsg(e)}');
        }
      }
    }
    throw lastException ?? Exception('Failed to generate unit manifest. All models/keys exhausted.');
  }

  Future<QuestionPaper> generateQuestionPaper(List<File> files, String qpTitle, String? systemPrompt, {String? customInstructions, String? forcedApiKey}) async {
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getPrimaryTextModels();

    final hydratedPrompt = PromptService.qpJson
        .replaceAll('%system_prompt%', systemPrompt ?? "You are an expert tutor.")
        .replaceAll('%custom_instructions%', PromptService.instructionsBlock(customInstructions));

    List<Part> parts = [TextPart(hydratedPrompt)];
    parts.addAll(await _buildFileParts(files));

    Exception? lastException;

    for (var modelName in modelsToTry) {
      for (var apiKey in keys) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(responseMimeType: 'application/json'),
          );

          final response = await _retryTransient(
            () => model.generateContent([Content.multi(parts)])
                .timeout(const Duration(minutes: 6)),
            onRetry: (a, e) => print('[AiService] QP transient ($modelName) attempt $a: ${_cleanErrMsg(e)}'),
          );

          if (response.text != null) {
            final jsonMap = _cleanAndDecodeJson(response.text!);
            final qp = QuestionPaper.fromJson(jsonMap);
            return QuestionPaper(
                id: qp.id,
                title: qpTitle.isNotEmpty ? qpTitle : qp.title,
                sections: qp.sections
            );
          }
        } catch (e) {
          lastException = Exception('QP Generation failed ($modelName): ${_cleanErrMsg(e)}');
        }
      }
    }
    throw lastException ?? Exception('Failed to generate Question Paper.');
  }

  Future<List<Slide>> extractPyqQuestionsForSection({
    required List<dynamic> files,
    required Section section,
    required List<Slide> existingQuestions,
    required List<Map<String, String>> otherSections,
    String? customInstructions,
    String? forcedApiKey,
  }) async {
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getLiteModels();
    
    final prompt = PromptService.getPyqExtractionPrompt(
      sectionTitle: section.title,
      sectionDesc: section.description,
      unitTitles: section.units.map((u) => u.title).toList(),
      existingQuestions: existingQuestions,
      otherSections: otherSections,
      customInstructions: customInstructions,
    );

    List<Part> parts = [TextPart(prompt)];
    parts.addAll(await _buildFileParts(files));

    Exception? lastException;
    for (var modelName in modelsToTry) {
      for (var apiKey in keys) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(responseMimeType: 'application/json'),
          );

          final response = await _retryTransient(
            () => model.generateContent([Content.multi(parts)])
                .timeout(const Duration(minutes: 5)),
            onRetry: (a, e) => print('[AiService] PYQ extract transient ($modelName) attempt $a: ${_cleanErrMsg(e)}'),
          );

          if (response.text != null) {
            final jsonMap = _cleanAndDecodeJson(response.text!);
            final questionsList = jsonMap['questions'] as List?;
            if (questionsList == null) return [];
            return questionsList.map((q) => Slide.fromJson(Map<String, dynamic>.from(q))).toList();
          }
        } catch (e) {
          lastException = Exception('PYQ extraction failed ($modelName): ${_cleanErrMsg(e)}');
        }
      }
    }
    throw lastException ?? Exception('Failed to extract PYQ questions.');
  }

  Future<List<Map<String, dynamic>>> gradePyqAnswers({
    required List<Map<String, dynamic>> answersToGrade,
    String? forcedApiKey,
  }) async {
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getLiteModels();
    
    final prompt = PromptService.getPyqGradingPrompt(answersToGrade: answersToGrade);

    Exception? lastException;
    for (var modelName in modelsToTry) {
      for (var apiKey in keys) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(responseMimeType: 'application/json'),
          );

          final response = await _retryTransient(
            () => model.generateContent([Content.text(prompt)])
                .timeout(const Duration(minutes: 3)),
            onRetry: (a, e) => print('[AiService] PYQ grading transient ($modelName) attempt $a: ${_cleanErrMsg(e)}'),
          );

          if (response.text != null) {
            final jsonMap = _cleanAndDecodeJson(response.text!);
            final results = jsonMap['results'] as List?;
            if (results == null) return [];
            return results.map((r) => Map<String, dynamic>.from(r)).toList();
          }
        } catch (e) {
          lastException = Exception('PYQ grading failed ($modelName): ${_cleanErrMsg(e)}');
        }
      }
    }
    throw lastException ?? Exception('Failed to grade PYQ answers.');
  }
}

class UnitManifestResult {
  final List<Unit> units;
  final List<LessonFormat> newFormats;

  UnitManifestResult({required this.units, required this.newFormats});
}