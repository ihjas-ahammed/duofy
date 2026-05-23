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

  Future<List<String>> _getModels() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> models = prefs.getStringList('gemini_models_list') ?? [];
    if (models.isEmpty) {
      final oldModel = prefs.getString('gemini_model') ?? 'gemini-1.5-flash';
      models = [oldModel];
    }
    return models;
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

  /// Gemma models on the Gemini API are less reliable at returning large
  /// well-formed JSON blobs — we generate one lesson per call for them.
  bool _isGemma(String modelName) => modelName.toLowerCase().contains('gemma');

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

  /// True for upstream-server failures that are typically transient — HTML
  /// error pages (502/503/504), socket drops, generic timeouts. We retry these
  /// before falling back to the next model/key.
  bool _isTransient(Object e) {
    final s = e.toString().toLowerCase();
    return s.contains('502') ||
        s.contains('503') ||
        s.contains('504') ||
        s.contains('bad gateway') ||
        s.contains('service unavailable') ||
        s.contains('gateway timeout') ||
        s.contains('doctype html') ||
        s.contains('<html') ||
        s.contains('socketexception') ||
        s.contains('connection closed') ||
        s.contains('connection reset');
  }

  /// Strips HTML error pages out of error strings for cleaner UI display.
  String _cleanErrMsg(Object e) {
    final s = e.toString();
    final lower = s.toLowerCase();
    if (lower.contains('<html') || lower.contains('doctype html')) {
      if (lower.contains('502')) return 'Server error 502 (Bad Gateway) — the model is temporarily unavailable. Try again in a moment.';
      if (lower.contains('503')) return 'Server error 503 — the model is overloaded.';
      if (lower.contains('504')) return 'Server error 504 — upstream timeout.';
      return 'Upstream returned an HTML error page (model unavailable).';
    }
    return s;
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

  /// Generates the course skeleton from a TOC-only PDF.
  ///
  /// [indexFiles] is the cropped index/TOC PDF (typically a few pages cut
  /// out of the full source PDF by [PdfService.extractPages]).
  /// [chapter1AbsolutePage] is the ABSOLUTE PDF page number (1-based) where
  /// Chapter 1 actually starts in the original full source PDF. We pass it
  /// through to the prompt so the AI offsets every TOC page number into
  /// absolute coordinates.
  Future<Book?> generateBookSkeleton(
    List<File> indexFiles,
    String filename, {
    required int chapter1AbsolutePage,
  }) async {
    final keys = await _getKeys();
    final liteModels = await _getLiteModels();
    final fallbackModels = await _getModels();
    // Try each preferred lite model in user order, then any extra fallback
    // models the user added in the generic models list (without duplicates).
    final List<String> modelsToTry = [
      ...liteModels,
      ...fallbackModels.where((m) => !liteModels.contains(m)),
    ];

    final hydratedPrompt = PromptService.skeleton
        .replaceAll('%filename%', filename)
        .replaceAll('%chapter1_abs_page%', '$chapter1AbsolutePage');

    List<Part> parts = [TextPart(hydratedPrompt)];
    parts.addAll(await _buildFileParts(indexFiles));

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
            onRetry: (a, e) => print('[AiService] Skeleton transient ($modelName) attempt $a: ${_cleanErrMsg(e)}'),
          );

          if (response.text != null) {
            final jsonMap = _cleanAndDecodeJson(response.text!);
            return Book.fromJson(jsonMap);
          }
        } on TimeoutException {
          lastException = Exception('Request timed out ($modelName).');
        } catch (e) {
          lastException = Exception('Generation failed ($modelName): ${_cleanErrMsg(e)}');
        }
      }
    }
    throw lastException ?? Exception('Failed to generate skeleton. All models/keys exhausted.');
  }

  Future<Unit> generateUnitContent(Unit unit, Book bookContext, Function(String) onProgress, {String? sectionPdfPath}) async {
    final keys = await _getKeys();
    final textModels = await _getPrimaryTextModels();
    final liteModels = await _getLiteModels();
    final fallbackModels = await _getModels();

    final List<String> liteModelsToTry = [
      ...liteModels,
      ...fallbackModels.where((m) => !liteModels.contains(m)),
    ];
    final List<String> textModelsToTry = [
      ...textModels,
      ...fallbackModels.where((m) => !textModels.contains(m)),
    ];

    // New-flow units share the section\'s PDF chunk; old-flow units have
    // their own pdfPath. Either way, we need a real, on-disk file.
    final String? chunkPath = unit.pdfPath ?? sectionPdfPath;
    if (chunkPath == null) throw Exception("No PDF/Image chunk available for this unit.");
    final chunkFile = File(chunkPath);
    if (!chunkFile.existsSync()) {
      throw Exception("Local file missing. Tap 'Restore' on the warning banner to re-link source files.");
    }

    // Pick the format for THIS unit. Books carry multiple formats so units
    // teaching different things (theory vs example vs proof) get generated
    // against different slide structures. Falls back to the book default
    // when unit.formatId is unset or stale.
    final LessonFormat format = bookContext.formatForUnit(unit);
    final List<SlideTemplate> template = format.slides;
    final String templateLayoutString = template
        .map((t) => "- Type: ${t.type} | Condition: ${t.condition} | Instructions: ${t.description}")
        .join('\n');

    Exception? lastException;

    for (int idx = 0; idx < textModelsToTry.length; idx++) {
      final currentTextModel = textModelsToTry[idx];
      final currentLiteModel = idx < liteModelsToTry.length ? liteModelsToTry[idx] : liteModelsToTry.first;

      for (var apiKey in keys) {
        try {
          final modelText = GenerativeModel(model: currentLiteModel, apiKey: apiKey);
          final modelJson = GenerativeModel(model: currentTextModel, apiKey: apiKey, generationConfig: GenerationConfig(responseMimeType: 'application/json'));

          onProgress("Analyzing PDF & Planning Layout...");

          final hydratedPlanPrompt = PromptService.plan
              .replaceAll('%unit_title%', unit.title)
              .replaceAll('%template_layout%', templateLayoutString);

          List<Part> planParts = [TextPart(hydratedPlanPrompt)];
          planParts.addAll(await _buildFileParts([chunkFile]));

          final planResponse = await _retryTransient(
            () => modelText.generateContent([Content.multi(planParts)])
                .timeout(const Duration(minutes: 4)),
            onRetry: (a, e) {
              final msg = _cleanErrMsg(e);
              print('[AiService] Unit plan transient ($currentLiteModel) attempt $a: $msg');
              onProgress('Server hiccup — retrying ($a/3)...');
            },
          );

          final lessonPlan = planResponse.text ?? '';
          if (lessonPlan.isEmpty) throw Exception("AI failed to generate a lesson plan.");

          final List<Lesson> newLessons;
          if (_isGemma(currentTextModel)) {
            // Gemma: generate one lesson at a time. Smaller, more reliable
            // requests; user sees concrete per-lesson progress.
            newLessons = await _generateLessonsBatched(
              modelJson: modelJson,
              modelName: currentTextModel,
              chunkFile: chunkFile,
              unit: unit,
              bookContext: bookContext,
              lessonPlan: lessonPlan,
              onProgress: onProgress,
            );
          } else {
            // Gemini: single bulk JSON call (faster when it succeeds).
            onProgress("Generating Interactive Content...");

            final hydratedJsonPrompt = PromptService.json
                .replaceAll('%system_prompt%', bookContext.systemPrompt ?? "You are an expert tutor.")
                .replaceAll('%unit_title%', unit.title)
                .replaceAll('%lesson_plan%', lessonPlan);

            List<Part> jsonParts = [TextPart(hydratedJsonPrompt)];
            jsonParts.addAll(await _buildFileParts([chunkFile]));

            final response = await _retryTransient(
              () => modelJson.generateContent([Content.multi(jsonParts)])
                  .timeout(const Duration(minutes: 5)),
              onRetry: (a, e) {
                final msg = _cleanErrMsg(e);
                print('[AiService] Unit json transient ($currentTextModel) attempt $a: $msg');
                onProgress('Server hiccup — retrying ($a/3)...');
              },
            );

            if (response.text == null) {
              throw Exception('AI returned a null response body.');
            }

            onProgress("Parsing content...");
            final jsonMap = _cleanAndDecodeJson(response.text!);
            final lessonsData = jsonMap['lessons'] as List?;

            newLessons = lessonsData?.map((l) {
              if (l is Map) {
                var lesson = Lesson.fromJson(Map<String, dynamic>.from(l));
                final uniqueLessonId = '${unit.id}-${lesson.id}';
                return lesson.copyWith(
                  id: uniqueLessonId,
                  slides: lesson.slides.map((s) => s.copyWith(id: '$uniqueLessonId-${s.id}')).toList(),
                );
              }
              return null;
            }).whereType<Lesson>().toList() ?? [];
          }

          if (newLessons.isEmpty) {
            throw Exception('AI returned no usable lessons.');
          }
          return unit.copyWith(isGenerated: true, lessons: newLessons);
        } catch (e) {
          lastException = Exception('Failed ($currentTextModel): ${_cleanErrMsg(e)}');
        }
      }
    }
    throw lastException ?? Exception('Failed to generate unit content. All models/keys exhausted.');
  }

  /// Asks the AI to break a section\'s PDF chunk into a list of units
  /// (manifest only — no slides). Used by the new TOC-only flow the first
  /// time a section is opened. Returns units with empty `lessons` and
  /// `isGenerated == false`, so the existing per-unit lesson generation
  /// Stage-2 graphics call: turn a single natural-language `canvasPrompt`
  /// into SVG markup using the user\'s configured graphics models (with
  /// fallback). Returns null when every model/key combination fails so the
  /// caller can persist the lesson without art rather than blow up the
  /// whole generation.
  ///
  /// [contextText] is a short snippet of the surrounding lesson content so
  /// the model can keep the diagram thematically consistent (e.g. variable
  /// names, units). Pass an empty string when not relevant.
  Future<String?> generateCanvasArt(String canvasPrompt, {String contextText = ''}) async {
    if (canvasPrompt.trim().isEmpty) return null;

    final keys = await _getKeys();
    final graphicsModels = await _getPrimaryGraphicsModels();
    final fallbackModels = await _getModels();
    // Cap context to keep prompts small — the SVG diagram doesn\'t need the
    // entire lesson, only a few sentences for tone matching.
    final trimmedContext = contextText.length > 800 ? contextText.substring(0, 800) : contextText;
    final hydrated = PromptService.canvasArt
        .replaceAll('%canvas_prompt%', canvasPrompt.trim())
        .replaceAll('%lesson_context%', trimmedContext);

    final List<String> modelsToTry = [
      ...graphicsModels,
      ...fallbackModels.where((m) => !graphicsModels.contains(m)),
    ];

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
          final svg = _extractSvg(text);
          if (svg != null) return svg;
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

  /// Pulls a clean `<svg ...>...</svg>` substring out of the model\'s raw
  /// response. Strips Markdown code fences (```svg / ```xml / ```), and any
  /// chatty text the model added around the diagram.
  String? _extractSvg(String raw) {
    var s = raw.trim();
    // Strip code fences if present.
    final fence = RegExp(r'```(?:svg|xml|html)?\s*([\s\S]*?)```', multiLine: true);
    final fenceMatch = fence.firstMatch(s);
    if (fenceMatch != null) s = fenceMatch.group(1)!.trim();
    // Find the SVG envelope.
    final svgOpen = s.indexOf('<svg');
    final svgClose = s.lastIndexOf('</svg>');
    if (svgOpen < 0 || svgClose < 0 || svgClose < svgOpen) return null;
    return s.substring(svgOpen, svgClose + '</svg>'.length).trim();
  }

  /// Walks every lesson + every proof/step_by_step slide in [unit] that has
  /// a `canvasPrompt` but no `canvasSvg` yet, and fills the SVG in via
  /// [generateCanvasArt]. Failures are tolerated — missing art just means
  /// the corresponding screen renders without a diagram. [onProgress] is
  /// invoked after each lesson so the UI can show "Rendering diagrams…".
  Future<Unit> generateCanvasArtForUnit(Unit unit, {void Function(String status)? onProgress}) async {
    final List<Lesson> updatedLessons = [];
    int idx = 0;
    final total = unit.lessons.length;
    for (final lesson in unit.lessons) {
      idx++;
      onProgress?.call('Rendering diagrams $idx of $total...');

      // 1. Lesson-level diagram.
      String? lessonSvg = lesson.canvasSvg;
      if (lessonSvg == null && (lesson.canvasPrompt?.trim().isNotEmpty ?? false)) {
        // Use the lesson\'s first theory slide (or whatever\'s first) as
        // context so the SVG is thematically consistent.
        final ctx = lesson.slides.isNotEmpty ? lesson.slides.first.content : '';
        lessonSvg = await generateCanvasArt(lesson.canvasPrompt!, contextText: ctx);
      }

      // 2. Per-slide diagrams for proof / step_by_step slides only.
      final List<Slide> updatedSlides = [];
      for (final slide in lesson.slides) {
        final isProofLike = slide.type == 'proof' || slide.type == 'step_by_step';
        String? slideSvg = slide.canvasSvg;
        if (isProofLike && slideSvg == null && (slide.canvasPrompt?.trim().isNotEmpty ?? false)) {
          slideSvg = await generateCanvasArt(slide.canvasPrompt!, contextText: slide.content);
        }
        updatedSlides.add(slide.copyWith(canvasSvg: slideSvg));
      }

      updatedLessons.add(lesson.copyWith(canvasSvg: lessonSvg, slides: updatedSlides));
    }
    return unit.copyWith(lessons: updatedLessons);
  }

  /// path continues to work unchanged.
  Future<List<Unit>> generateUnitManifest(Section section, Book bookContext) async {
    if (section.pdfPath == null) {
      throw Exception('Section has no PDF chunk — cannot generate unit manifest.');
    }
    final chunkFile = File(section.pdfPath!);
    if (!chunkFile.existsSync()) {
      throw Exception("Local file missing. Tap 'Restore' on the warning banner to re-link source files.");
    }

    final keys = await _getKeys();
    final liteModels = await _getLiteModels();
    final fallbackModels = await _getModels();
    final List<String> modelsToTry = [
      ...liteModels,
      ...fallbackModels.where((m) => !liteModels.contains(m)),
    ];

    // Build the catalog the AI picks `formatId` from. Each entry is one
    // line: "- <id> :: <name> — <one-line summary>".
    final formatCatalog = bookContext.lessonFormats
        .map((f) => '- ${f.id} :: ${f.name} — ${f.description}')
        .join('\n');

    final hydratedPrompt = PromptService.unitManifest
        .replaceAll('%section_title%', section.title)
        .replaceAll('%section_description%', section.description)
        .replaceAll('%format_catalog%', formatCatalog);

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

          final validFormatIds = bookContext.lessonFormats.map((f) => f.id).toSet();
          final units = <Unit>[];
          for (var i = 0; i < unitsData.length; i++) {
            final raw = unitsData[i];
            if (raw is! Map) continue;
            final base = Unit.fromJson(Map<String, dynamic>.from(raw));
            final id = base.id.isNotEmpty ? base.id : 'u${i + 1}';
            // Validate the AI\'s formatId — models sometimes invent ids,
            // case-mangle them, or omit them entirely. We accept only ids
            // that match one of the configured formats; everything else
            // falls back to the book default so unit generation never
            // breaks on a bad suggestion.
            final claimedFormat = base.formatId;
            final acceptedFormat = (claimedFormat != null && validFormatIds.contains(claimedFormat))
                ? claimedFormat
                : bookContext.defaultFormatId;
            units.add(base.copyWith(
              id: '${section.id}-$id',
              isGenerated: false,
              lessons: const [],
              // The unit shares the section\'s PDF chunk — it does not get
              // its own pdfPath or page range.
              pdfPath: null,
              startPage: null,
              endPage: null,
              formatId: acceptedFormat,
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

  /// Per-lesson generation used for Gemma models. Builds [Lesson]s one by one
  /// off the plan; partial successes are kept so users don't lose work if a
  /// late lesson fails after several earlier ones already succeeded.
  Future<List<Lesson>> _generateLessonsBatched({
    required GenerativeModel modelJson,
    required String modelName,
    required File chunkFile,
    required Unit unit,
    required Book bookContext,
    required String lessonPlan,
    required Function(String) onProgress,
  }) async {
    int lessonCount = _parseLessonCount(lessonPlan);
    if (lessonCount <= 0) {
      throw Exception(
        'Could not determine lesson count from plan. Expected a "TOTAL_LESSONS: N" line.',
      );
    }
    // Soft cap so a hallucinated count of, say, 99 doesn't blow up the unit.
    if (lessonCount > 30) lessonCount = 30;

    final filePartsForLesson = await _buildFileParts([chunkFile]);
    final List<Lesson> collected = [];
    Object? lastLessonError;

    for (int i = 1; i <= lessonCount; i++) {
      onProgress('Generating lesson $i of $lessonCount...');

      final hydratedPrompt = PromptService.singleLessonJson
          .replaceAll('%system_prompt%', bookContext.systemPrompt ?? 'You are an expert tutor.')
          .replaceAll('%unit_title%', unit.title)
          .replaceAll('%lesson_plan%', lessonPlan)
          .replaceAll('%lesson_index%', '$i');

      final parts = <Part>[TextPart(hydratedPrompt), ...filePartsForLesson];

      try {
        final response = await _retryTransient(
          () => modelJson.generateContent([Content.multi(parts)])
              .timeout(const Duration(minutes: 3)),
          onRetry: (a, e) {
            print('[AiService] Lesson $i/$lessonCount transient ($modelName) attempt $a: ${_cleanErrMsg(e)}');
            onProgress('Lesson $i of $lessonCount — retrying ($a/3)...');
          },
        );

        final text = response.text;
        if (text == null || text.trim().isEmpty) {
          throw Exception('Empty response for lesson $i.');
        }

        final jsonMap = _cleanAndDecodeJson(text);
        final lesson = Lesson.fromJson(jsonMap);
        final uniqueLessonId = '${unit.id}-${lesson.id.isNotEmpty ? lesson.id : 'l$i'}';
        collected.add(lesson.copyWith(
          id: uniqueLessonId,
          slides: lesson.slides.map((s) => s.copyWith(id: '$uniqueLessonId-${s.id}')).toList(),
        ));
      } catch (e) {
        lastLessonError = e;
        print('[AiService] Lesson $i failed permanently ($modelName): ${_cleanErrMsg(e)}');
        // Continue with remaining lessons — partial unit is better than none.
      }
    }

    if (collected.isEmpty && lastLessonError != null) {
      throw Exception('All lessons failed. Last error: ${_cleanErrMsg(lastLessonError)}');
    }
    return collected;
  }

  Future<QuestionPaper> generateQuestionPaper(List<File> files, String qpTitle, String? systemPrompt) async {
    final keys = await _getKeys();
    final textModels = await _getPrimaryTextModels();
    final fallbackModels = await _getModels();
    final List<String> modelsToTry = [
      ...textModels,
      ...fallbackModels.where((m) => !textModels.contains(m)),
    ];

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