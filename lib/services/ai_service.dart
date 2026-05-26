import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import 'prompt_service.dart';

class AiService {
  Future<List<String>> _getKeys() async {
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
      _getModelsForSlot('model_primary_text_list', 'model_primary_text', 'gemma4');

  Future<List<String>> _getPrimaryGraphicsModels() =>
      _getModelsForSlot('model_primary_graphics_list', 'model_primary_graphics', 'gemini-3.5-flash');

  Future<List<String>> _getLiteModels() =>
      _getModelsForSlot('model_lite_list', 'model_lite', 'gemini-flash-lite-latest');

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
    void Function(int attempt, Object err)? onRetry,
  }) async {
    Object? last;
    for (int attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        return await op();
      } catch (e) {
        last = e;
        if (!_isTransient(e) || attempt == maxAttempts) rethrow;
        onRetry?.call(attempt, e);
        await Future.delayed(baseDelay * (1 << (attempt - 1)));
      }
    }
    throw last ?? Exception('Retry exhausted');
  }

  Future<List<Part>> _buildFileParts(List<File> files) async {
    List<Part> parts = [];
    for (var f in files) {
      final ext = f.path.split('.').last.toLowerCase();
      if (ext == 'pdf') {
        parts.add(DataPart('application/pdf', await f.readAsBytes()));
      } else {
        final mime = ext == 'png' ? 'image/png' : 'image/jpeg';
        parts.add(DataPart(mime, await f.readAsBytes()));
      }
    }
    return parts;
  }

  int? _asInt(dynamic v) {
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v.trim());
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
    required int chapter1AbsolutePage,
    String? customInstructions,
    void Function(String status, double? progress)? onProgress,
  }) async {
    final keys = await _getKeys();
    final modelsToTry = await _getLiteModels();
    final instructionsBlock = PromptService.instructionsBlock(customInstructions);
    final fileParts = await _buildFileParts(indexFiles);

    // ---- Stage 1: chapter list (one focused call → indeterminate) ----------
    onProgress?.call('Mapping chapters…', null);
    final chapterPrompt = PromptService.chapterList
        .replaceAll('%filename%', filename)
        .replaceAll('%chapter1_abs_page%', '$chapter1AbsolutePage')
        .replaceAll('%custom_instructions%', instructionsBlock);

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
            () => model.generateContent([Content.multi([TextPart(chapterPrompt), ...fileParts])])
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
      });
    }
    // Resolve bounds left-to-right: a missing/invalid endPage falls back to the
    // page before the next chapter starts, so every section call has a range.
    for (var i = 0; i < chapters.length; i++) {
      int? start = chapters[i]['startPage'] as int?;
      start ??= (i == 0 ? chapter1AbsolutePage : null);
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
        List<Map<String, dynamic>>? secs;
        try {
          secs = await _generateSectionsForChapter(
            chapter: ch,
            filename: filename,
            chapter1AbsolutePage: chapter1AbsolutePage,
            instructionsBlock: instructionsBlock,
            fileParts: fileParts,
            models: modelsToTry,
            keys: keys,
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
            'sections': sectionSlots[i] ?? const <Map<String, dynamic>>[],
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
  }) async {
    final prompt = PromptService.sectionList
        .replaceAll('%filename%', filename)
        .replaceAll('%chapter1_abs_page%', '$chapter1AbsolutePage')
        .replaceAll('%custom_instructions%', instructionsBlock)
        .replaceAll('%chapter_title%', chapter['title']?.toString() ?? '')
        .replaceAll('%chapter_start%', (chapter['startPage'])?.toString() ?? '?')
        .replaceAll('%chapter_end%', (chapter['endPage'])?.toString() ?? '?');

    final parts = <Part>[TextPart(prompt), ...fileParts];
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
  /// run in parallel (bounded by [_resolveConcurrency]) and streamed back via
  /// [onLessonGenerated] so the UI can reveal lessons one at a time.
  ///
  /// When [generateGraphics] is true, each lesson's diagram(s) are rendered
  /// *right after that lesson's text* (and streamed again), so art pops in
  /// lesson-by-lesson during generation instead of in a separate whole-unit
  /// pass at the end — much better perceived progress.
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
  }) async {
    final keys = await _getKeys();
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
                .timeout(const Duration(minutes: 4)),
            onRetry: (a, e) {
              print('[AiService] Unit plan transient ($liteModel) attempt $a: ${_cleanErrMsg(e)}');
              onProgress('Server hiccup — retrying ($a/3)...');
            },
          );
          final text = planResponse.text ?? '';
          if (text.trim().isNotEmpty) {
            lessonPlan = text;
            break;
          }
        } catch (e) {
          planError = Exception('Plan failed ($liteModel): ${_cleanErrMsg(e)}');
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

    // --- Stage 2: per-lesson generation, parallelised ---------------------
    // Each lesson is an independent request, so we run several at once (bounded
    // by the user's concurrency setting / an auto device heuristic). Each
    // lesson's text streams back immediately via [onLessonGenerated]; when
    // diagrams are on, that lesson's art is rendered right after and streamed
    // again, so visuals appear lesson-by-lesson rather than in a final pass.
    final int concurrency = (await _resolveConcurrency()).clamp(1, lessonCount);
    final lessonFileParts = await _buildFileParts([chunkFile]);
    final List<Lesson?> slots = List<Lesson?>.filled(lessonCount, null);
    // Combined step accounting: one text step per lesson, plus one art step
    // per lesson when diagrams are enabled, so progress covers the whole run.
    final int totalSteps = generateGraphics ? lessonCount * 2 : lessonCount;
    int doneSteps = 0;
    Object? lastLessonError;

    List<Lesson> collected() => slots.whereType<Lesson>().toList();
    int landed() => slots.whereType<Lesson>().length;

    int nextIndex = 0;
    Future<void> worker() async {
      while (true) {
        final i = nextIndex;
        if (i >= lessonCount) break;
        nextIndex++;

        Lesson? lesson;
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

        // Stream the lesson text right away so it shows up immediately.
        if (lesson != null) slots[i] = lesson;
        doneSteps++;
        onProgress('Generating lessons (${landed()}/$lessonCount)...', doneSteps / totalSteps);
        onLessonGenerated?.call(collected());

        // Then render this lesson's diagram(s) and stream the updated lesson.
        if (generateGraphics) {
          if (lesson != null) {
            try {
              slots[i] = await _attachArtToLesson(lesson);
            } catch (e) {
              print('[AiService] Art for lesson ${i + 1} failed: ${_cleanErrMsg(e)}');
            }
          }
          doneSteps++; // counted even on a failed/empty lesson so totals reconcile
          onProgress('Rendering diagrams (${i + 1}/$lessonCount)...', doneSteps / totalSteps);
          if (lesson != null) onLessonGenerated?.call(collected());
        }
      }
    }

    await Future.wait(List.generate(concurrency, (_) => worker()));

    final newLessons = collected();
    if (newLessons.isEmpty) {
      throw Exception(
        'AI returned no usable lessons.${lastLessonError != null ? ' Last error: ${_cleanErrMsg(lastLessonError!)}' : ''}',
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
      final cores = Platform.numberOfProcessors;
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
  }) async {
    final keys = await _getKeys();
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
        .replaceAll('%slide_content%', slide.content)
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
  Future<String?> generateCanvasArt(String canvasPrompt, {String contextText = ''}) async {
    if (canvasPrompt.trim().isEmpty) return null;

    final keys = await _getKeys();
    final modelsToTry = await _getPrimaryGraphicsModels();
    // Cap context to keep prompts small — the SVG diagram doesn\'t need the
    // entire lesson, only a few sentences for tone matching.
    final trimmedContext = contextText.length > 800 ? contextText.substring(0, 800) : contextText;
    final hydrated = PromptService.canvasArt
        .replaceAll('%canvas_prompt%', canvasPrompt.trim())
        .replaceAll('%lesson_context%', trimmedContext);

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

  /// Pulls a clean JavaScript `draw(ctx, W, H)` function out of the model\'s
  /// raw response. Strips Markdown code fences (```js / ```javascript / ```),
  /// then isolates the `function draw(...) { ... }` block by brace-matching so
  /// any chatty text the model wrapped around it is dropped. Returns null when
  /// no balanced function is found, so the caller keeps the lesson art-free
  /// rather than embedding broken JS.
  String? _extractDrawFunction(String raw) {
    var s = raw.trim();
    // Strip code fences if present.
    final fence = RegExp(r'```(?:js|javascript)?\s*([\s\S]*?)```', multiLine: true);
    final fenceMatch = fence.firstMatch(s);
    if (fenceMatch != null) s = fenceMatch.group(1)!.trim();

    final start = s.indexOf('function draw');
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
  Future<Lesson> _attachArtToLesson(Lesson lesson) async {
    // 1. Lesson-level diagram. Use the first slide's content as context so the
    //    art stays thematically consistent with the lesson.
    String? lessonArt = lesson.canvasSvg;
    if (lessonArt == null && (lesson.canvasPrompt?.trim().isNotEmpty ?? false)) {
      final ctx = lesson.slides.isNotEmpty ? lesson.slides.first.content : '';
      lessonArt = await generateCanvasArt(lesson.canvasPrompt!, contextText: ctx);
    }

    // 2. Per-slide diagrams for proof / step_by_step slides only.
    final List<Slide> updatedSlides = [];
    for (final slide in lesson.slides) {
      final isProofLike = slide.type == 'proof' || slide.type == 'step_by_step';
      String? slideArt = slide.canvasSvg;
      if (isProofLike && slideArt == null && (slide.canvasPrompt?.trim().isNotEmpty ?? false)) {
        slideArt = await generateCanvasArt(slide.canvasPrompt!, contextText: slide.content);
      }
      updatedSlides.add(slide.copyWith(canvasSvg: slideArt));
    }

    return lesson.copyWith(canvasSvg: lessonArt, slides: updatedSlides);
  }

  /// path continues to work unchanged. [customInstructions] is the planner
  /// guidance captured on the "Plan units" panel (pre-filled from the book's
  /// instructions but editable per-section); injected into the prompt.
  Future<List<Unit>> generateUnitManifest(
    Section section,
    Book bookContext, {
    String? customInstructions,
  }) async {
    if (section.pdfPath == null) {
      throw Exception('Section has no PDF chunk — cannot generate unit manifest.');
    }
    final chunkFile = File(section.pdfPath!);
    if (!chunkFile.existsSync()) {
      throw Exception("Local file missing. Tap 'Restore' on the warning banner to re-link source files.");
    }

    final keys = await _getKeys();
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
          return units;
        } on TimeoutException {
          lastException = Exception('Unit manifest request timed out ($modelName).');
        } catch (e) {
          lastException = Exception('Unit manifest failed ($modelName): ${_cleanErrMsg(e)}');
        }
      }
    }
    throw lastException ?? Exception('Failed to generate unit manifest. All models/keys exhausted.');
  }

  Future<QuestionPaper> generateQuestionPaper(List<File> files, String qpTitle, String? systemPrompt) async {
    final keys = await _getKeys();
    final modelsToTry = await _getPrimaryTextModels();

    final hydratedPrompt = PromptService.qpJson
        .replaceAll('%system_prompt%', systemPrompt ?? "You are an expert tutor.");

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
}