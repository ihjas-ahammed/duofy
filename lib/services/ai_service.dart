import 'dart:convert';
import '../platform/io_shim.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdfx/pdfx.dart' as pdfx;
import '../models/app_models.dart';
import '../main.dart' show showRateLimitDialog;
import 'prompt_service.dart';
import 'page_mapping.dart';
import 'pdf_service.dart';
import 'personalization_service.dart';
import 'secrets_service.dart';
import 'database_service.dart';
import 'fb/fb_firestore.dart';
import 'ai_estimator.dart';

class AiService {
  static int activeCanvasRegensCount = 0;

  /// Tracks whether the most recent _getKeys call returned the shared
  /// fallback key (from Firestore via SecretsService). When true,
  /// rate-limit errors trigger the "add your own key" dialog.
  bool _usingDefaultKey = false;

  Future<void> _checkPause() async {
    while (activeCanvasRegensCount > 0) {
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  Future<List<String>> _getKeys({String? forcedApiKey}) async {
    _usingDefaultKey = false;
    if (forcedApiKey != null && forcedApiKey.trim().isNotEmpty) {
      return [forcedApiKey.trim()];
    }
    final prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs.getStringList('gemini_api_keys_list') ?? [];
    if (keys.isEmpty) {
      final keysString = prefs.getString('gemini_api_keys') ?? '';
      keys = keysString
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }
    if (keys.isNotEmpty) return keys;

    // --- Fallback: shared keys fetched at runtime from Firestore ---
    final defaultKeys = await SecretsService.instance.geminiKeys();
    if (defaultKeys.isNotEmpty) {
      _usingDefaultKey = true;
      return defaultKeys;
    }
    throw Exception(
      'No API Keys configured. Go to Settings to add your Gemini API key, or sign in to use the shared keys.',
    );
  }

  Future<List<String>> getKeys({String? forcedApiKey}) =>
      _getKeys(forcedApiKey: forcedApiKey);

  Future<String> _callGroq({
    required String prompt,
    required String slotName,
    bool responseJson = false,
    List<Uint8List>? attachedImages,
    String? systemPrompt,
  }) async {
    final keys = await SecretsService.instance.groqKeys();
    if (keys.isEmpty) {
      throw Exception("No Groq API Keys available.");
    }
    final apiKey = keys.first;

    final prefs = await SharedPreferences.getInstance();
    List<String> models = [];
    if (slotName == 'Primary - Text') {
      models = prefs.getStringList('groq_model_primary_text_list') ?? const ['llama-3.3-70b-versatile', 'groq/compound'];
    } else if (slotName == 'Primary - Graphics') {
      models = prefs.getStringList('groq_model_primary_graphics_list') ?? const ['llama-3.3-70b-versatile', 'groq/compound'];
    } else if (slotName == 'Lite') {
      models = prefs.getStringList('groq_model_lite_list') ?? const ['llama-3.1-8b-instant', 'groq/compound-mini'];
    } else if (slotName == 'Live') {
      models = prefs.getStringList('groq_model_live_list') ?? const ['llama-3.1-8b-instant', 'groq/compound-mini'];
    }
    if (models.isEmpty) {
      models = const ['llama-3.3-70b-versatile'];
    }
    final modelName = models.first;

    final url = Uri.parse('https://api.groq.com/openai/v1/chat/completions');

    final List<Map<String, dynamic>> messages = [];
    if (systemPrompt != null && systemPrompt.trim().isNotEmpty) {
      messages.add({
        "role": "system",
        "content": systemPrompt.trim(),
      });
    }

    final List<Map<String, dynamic>> contentParts = [];
    contentParts.add({
      "type": "text",
      "text": prompt,
    });

    if (attachedImages != null) {
      for (final img in attachedImages) {
        final base64Img = base64Encode(img);
        contentParts.add({
          "type": "image_url",
          "image_url": {
            "url": "data:image/jpeg;base64,$base64Img",
          }
        });
      }
    }

    messages.add({
      "role": "user",
      "content": contentParts.length == 1 ? prompt : contentParts,
    });

    final Map<String, dynamic> body = {
      "model": modelName,
      "messages": messages,
    };
    if (responseJson) {
      body["response_format"] = {
        "type": "json_object"
      };
    }

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    ).timeout(const Duration(minutes: 2));

    if (response.statusCode != 200) {
      throw Exception("Groq API error (${response.statusCode}): ${response.body}");
    }

    final jsonMap = jsonDecode(response.body);
    final String? text = jsonMap["choices"]?[0]?["message"]?["content"] as String?;
    if (text == null || text.trim().isEmpty) {
      throw Exception("Empty response from Groq model $modelName");
    }
    return text;
  }

  Future<String> _callCerebras({
    required String prompt,
    required String slotName,
    bool responseJson = false,
    List<Uint8List>? attachedImages,
    String? systemPrompt,
  }) async {
    final keys = await SecretsService.instance.cerebrasKeys();
    if (keys.isEmpty) {
      throw Exception("No Cerebras API Keys available.");
    }
    final apiKey = keys.first;

    final prefs = await SharedPreferences.getInstance();
    List<String> models = [];
    if (slotName == 'Primary - Text') {
      models = prefs.getStringList('cerebras_model_primary_text_list') ?? const ['llama-3.3-70b', 'llama-3.1-70b'];
    } else if (slotName == 'Primary - Graphics') {
      models = prefs.getStringList('cerebras_model_primary_graphics_list') ?? const ['llama-3.3-70b', 'llama-3.1-70b'];
    } else if (slotName == 'Lite') {
      models = prefs.getStringList('cerebras_model_lite_list') ?? const ['llama-3.1-8b'];
    } else if (slotName == 'Live') {
      models = prefs.getStringList('cerebras_model_live_list') ?? const ['llama-3.1-8b'];
    }
    if (models.isEmpty) {
      models = const ['llama-3.3-70b'];
    }
    final modelName = models.first;

    final url = Uri.parse('https://api.cerebras.ai/v1/chat/completions');

    final List<Map<String, dynamic>> messages = [];
    if (systemPrompt != null && systemPrompt.trim().isNotEmpty) {
      messages.add({
        "role": "system",
        "content": systemPrompt.trim(),
      });
    }

    final List<Map<String, dynamic>> contentParts = [];
    contentParts.add({
      "type": "text",
      "text": prompt,
    });

    if (attachedImages != null) {
      for (final img in attachedImages) {
        final base64Img = base64Encode(img);
        contentParts.add({
          "type": "image_url",
          "image_url": {
            "url": "data:image/jpeg;base64,$base64Img",
          }
        });
      }
    }

    messages.add({
      "role": "user",
      "content": contentParts.length == 1 ? prompt : contentParts,
    });

    final Map<String, dynamic> body = {
      "model": modelName,
      "messages": messages,
    };
    if (responseJson) {
      body["response_format"] = {
        "type": "json_object"
      };
    }

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    ).timeout(const Duration(minutes: 2));

    if (response.statusCode != 200) {
      throw Exception("Cerebras API error (${response.statusCode}): ${response.body}");
    }

    final jsonMap = jsonDecode(response.body);
    final String? text = jsonMap["choices"]?[0]?["message"]?["content"] as String?;
    if (text == null || text.trim().isEmpty) {
      throw Exception("Empty response from Cerebras model $modelName");
    }
    return text;
  }

  Future<String> _callOpenRouter({
    required String prompt,
    required String slotName,
    bool responseJson = false,
    List<Uint8List>? attachedImages,
    String? systemPrompt,
  }) async {
    final keys = await SecretsService.instance.openrouterKeys();
    if (keys.isEmpty) {
      throw Exception("No OpenRouter API Keys available.");
    }
    final apiKey = keys.first;

    final prefs = await SharedPreferences.getInstance();
    List<String> models = [];
    if (slotName == 'Primary - Text') {
      models = prefs.getStringList('openrouter_model_primary_text_list') ?? const ['meta-llama/llama-3.3-70b-instruct', 'google/gemini-2.5-pro'];
    } else if (slotName == 'Primary - Graphics') {
      models = prefs.getStringList('openrouter_model_primary_graphics_list') ?? const ['meta-llama/llama-3.3-70b-instruct', 'google/gemini-2.5-pro'];
    } else if (slotName == 'Lite') {
      models = prefs.getStringList('openrouter_model_lite_list') ?? const ['meta-llama/llama-3.1-8b-instruct', 'google/gemini-2.5-flash'];
    } else if (slotName == 'Live') {
      models = prefs.getStringList('openrouter_model_live_list') ?? const ['meta-llama/llama-3.1-8b-instruct', 'google/gemini-2.5-flash'];
    }
    if (models.isEmpty) {
      models = const ['meta-llama/llama-3.3-70b-instruct'];
    }
    final modelName = models.first;

    final url = Uri.parse('https://openrouter.ai/api/v1/chat/completions');

    final List<Map<String, dynamic>> messages = [];
    if (systemPrompt != null && systemPrompt.trim().isNotEmpty) {
      messages.add({
        "role": "system",
        "content": systemPrompt.trim(),
      });
    }

    final List<Map<String, dynamic>> contentParts = [];
    contentParts.add({
      "type": "text",
      "text": prompt,
    });

    if (attachedImages != null) {
      for (final img in attachedImages) {
        final base64Img = base64Encode(img);
        contentParts.add({
          "type": "image_url",
          "image_url": {
            "url": "data:image/jpeg;base64,$base64Img",
          }
        });
      }
    }

    messages.add({
      "role": "user",
      "content": contentParts.length == 1 ? prompt : contentParts,
    });

    final Map<String, dynamic> body = {
      "model": modelName,
      "messages": messages,
    };
    if (responseJson) {
      body["response_format"] = {
        "type": "json_object"
      };
    }

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
        "HTTP-Referer": "https://duofy.app",
        "X-Title": "Duofy app",
      },
      body: jsonEncode(body),
    ).timeout(const Duration(minutes: 2));

    if (response.statusCode != 200) {
      throw Exception("OpenRouter API error (${response.statusCode}): ${response.body}");
    }

    final jsonMap = jsonDecode(response.body);
    final String? text = jsonMap["choices"]?[0]?["message"]?["content"] as String?;
    if (text == null || text.trim().isEmpty) {
      throw Exception("Empty response from OpenRouter model $modelName");
    }
    return text;
  }

  /// Returns true when the error looks like a rate-limit / quota error.
  bool _isRateLimitError(Object e) {
    final s = e.toString().toLowerCase();
    return s.contains('429') ||
        s.contains('rate limit') ||
        s.contains('resource exhausted') ||
        s.contains('quota');
  }

  /// Reads an ordered list of preferred models for one slot. Falls back to
  /// the legacy single-string key when the new list key is empty so older
  /// installs keep working without migration. The returned list is never
  /// empty — the caller can safely iterate it as a model-fallback ladder.
  Future<List<String>> _getModelsForSlot(
    String slotKey,
    String legacyKey,
    List<String> fallbackList,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(slotKey) ?? [];
    if (list.isNotEmpty) return list;
    final legacy = prefs.getString(legacyKey);
    if (legacy != null && legacy.trim().isNotEmpty) return [legacy.trim()];
    return fallbackList;
  }

  Future<List<String>> _getPrimaryTextModels() =>
      _getModelsForSlot('model_primary_text_list', 'model_primary_text', const [
        'gemini-flash-lite-latest',
        'gemini-2.5-flash-lite',
        'gemma-4-26b-a4b-it',
        'gemma-4-31b-it',
      ]);

  Future<List<String>> _getPrimaryGraphicsModels() => _getModelsForSlot(
    'model_primary_graphics_list',
    'model_primary_graphics',
    const [
      'gemini-3.5-flash',
      'gemini-3-flash-preview',
      'gemini-2.5-flash',
      'gemma-4-31b-it',
    ],
  );

  Future<List<String>> _getLiteModels() =>
      _getModelsForSlot('model_lite_list', 'model_lite', const [
        'gemini-flash-lite-latest',
        'gemini-3.1-flash-lite',
        'gemini-3.1-flash-lite-preview',
        'gemini-2.5-flash-lite',
        'gemma-4-26b-a4b-it',
        'gemini-2.0-flash-lite',
      ]);

  Future<List<String>> _getLiveModels() => _getModelsForSlot(
    'model_live_list',
    'model_live',
    const ['gemini-3.1-flash-live-preview'],
  );

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
      final preview = cleaned.length > 200
          ? '${cleaned.substring(0, 200)}…'
          : cleaned;
      throw Exception(
        'AI response did not contain a JSON object. Got: $preview',
      );
    }

    cleaned = cleaned.substring(start, end + 1);

    try {
      final decoded = jsonDecode(cleaned);
      if (decoded is! Map<String, dynamic>) {
        throw Exception(
          'Expected a JSON Object (Map), but got ${decoded.runtimeType}.',
        );
      }
      return decoded;
    } catch (e1) {
      try {
        // Some models emit raw newlines inside string literals — escape them.
        final agg = cleaned.replaceAll('\n', '\\n').replaceAll('\r', '');
        final decoded = jsonDecode(agg);
        if (decoded is! Map<String, dynamic>) {
          throw Exception(
            'Expected a JSON Object after sanitization, got ${decoded.runtimeType}.',
          );
        }
        return decoded;
      } catch (e2) {
        final preview = cleaned.length > 200
            ? '${cleaned.substring(0, 200)}…'
            : cleaned;
        throw Exception(
          'Failed to parse AI JSON. First parse: $e1. After sanitization: $e2. Snippet: $preview',
        );
      }
    }
  }

  /// Reads "TOTAL_LESSONS: N" from the first non-empty lines of the plan, or
  /// falls back to the highest "Lesson N" index found in the text.
  int _parseLessonCount(String plan) {
    final headerRe = RegExp(
      r'TOTAL[_ ]?LESSONS\s*[:=]\s*(\d+)',
      caseSensitive: false,
    );
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
    if (s.contains('internal error') ||
        s.contains('500') ||
        s.contains('internal server')) {
      return 'Model internal error';
    }
    if (s.contains('429') ||
        s.contains('rate limit') ||
        s.contains('resource exhausted') ||
        s.contains('quota')) {
      return 'Rate limited / quota exceeded';
    }
    if (s.contains('overloaded') ||
        s.contains('503') ||
        s.contains('unavailable')) {
      return 'Model overloaded';
    }
    if (s.contains('timeout') || s.contains('deadline exceeded')) {
      return 'Request timed out';
    }
    if (s.contains('api key') ||
        s.contains('permission') ||
        s.contains('401') ||
        s.contains('403')) {
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
      if (lower.contains('502'))
        return '$category — server 502 (Bad Gateway), model temporarily unavailable.';
      if (lower.contains('503'))
        return '$category — server 503, model overloaded.';
      if (lower.contains('504'))
        return '$category — server 504, upstream timeout.';
      return '$category — upstream returned an HTML error page (model unavailable).';
    }
    return '$category: $s';
  }

  Future<int> getSuggestedShift(String promptText) async {
    final keys = await _getKeys();
    final modelsToTry = await _getLiteModels();
    Map<String, dynamic>? map;
    for (final modelName in modelsToTry) {
      for (final apiKey in keys) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
            ),
          );
          final resp = await _retryTransient(
            () => model
                .generateContent([Content.text(promptText)])
                .timeout(const Duration(minutes: 1)),
            onRetry: (a, e) => print(
              '[AiService] Offset crosscheck transient ($modelName) attempt $a: ${_cleanErrMsg(e)}',
            ),
          );
          if (resp.text != null) {
            map = _cleanAndDecodeJson(resp.text!);
            break;
          }
        } catch (e) {
          print(
            '[AiService] Offset crosscheck failed on $modelName: ${_cleanErrMsg(e)}',
          );
        }
      }
      if (map != null) break;
    }
    if (map != null && map['suggestedShift'] is num) {
      return (map['suggestedShift'] as num).toInt();
    }
    return 0;
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
        // Surface rate-limit dialog when the shared default key is exhausted.
        if (_usingDefaultKey && _isRateLimitError(e)) {
          showRateLimitDialog();
        }
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

  Future<List<Part>> _buildFileParts(
    List<dynamic> files, {
    bool extractText = false,
    List<String>? fileLabels,
  }) async {
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
        final bool useTextOnly = extractText || (!kIsWeb && Platform.isLinux);
        if (useTextOnly) {
          final text = await PdfService().extractTextFromPdfBytes(bytes);
          if (text.trim().isNotEmpty) {
            parts.add(
              TextPart(
                extractText
                    ? '--- SYLLABUS CONTENT START ---\n$text\n--- SYLLABUS CONTENT END ---'
                    : '--- CONTENT START ---\n$text\n--- CONTENT END ---',
              ),
            );
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
              parts.add(
                TextPart('--- CONTENT START ---\n$text\n--- CONTENT END ---'),
              );
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

  Future<Map<String, dynamic>?> extractWritingStyleProfile({
    required List<String> answers,
    String? forcedApiKey,
  }) async {
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getLiteModels();

    final formattedAnswers = answers
        .asMap()
        .entries
        .map((e) => "Question ${e.key + 1}: ${e.value}")
        .join('\n\n');
    final prompt = PromptService.extractWritingStyleProfilePrompt.replaceAll(
      '%user_answers%',
      formattedAnswers,
    );

    for (var key in keys) {
      for (var modelName in modelsToTry) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: key,
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
            ),
          );
          final response = await _retryTransient(
            () => model
                .generateContent([Content.text(prompt)])
                .timeout(const Duration(minutes: 2)),
          );
          if (response.text != null) {
            return _cleanAndDecodeJson(response.text!);
          }
        } catch (e) {
          print(
            '[AiService] extractWritingStyleProfile ($modelName) failed: ${_cleanErrMsg(e)}',
          );
        }
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> scanIndexChunk(
    File chunkPdf,
    int startPage,
    int endPage, {
    String? forcedApiKey,
  }) async {
    await _checkPause();
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getLiteModels();
    final pdfBytes = await chunkPdf.readAsBytes();

    final prompt =
        '''
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

    try {
      final text = await _generateWithGroqFallback(
        geminiModels: modelsToTry,
        geminiKeys: keys,
        contents: [
          Content.multi([
            TextPart(prompt),
            DataPart('application/pdf', pdfBytes),
          ]),
        ],
        slotName: 'Lite',
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
        ),
        onRetry: (a, e) => print(
          '[AiService] Index scan transient attempt $a: ${_cleanErrMsg(e)}',
        ),
      );
      return _cleanAndDecodeJson(text);
    } catch (e) {
      print(
        '[AiService] scanIndexChunk failed: ${_cleanErrMsg(e)}',
      );
      return null;
    }
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
  /// Context parts for knowledge-mode generation (no PDF chunk): the book's
  /// saved syllabus when it exists on disk, otherwise nothing — keeping the
  /// prompt grounded in whatever the user actually provided.
  Future<List<Part>> _knowledgeContextParts(Book bookContext) async {
    final path = bookContext.syllabusPath;
    if (path != null && path.isNotEmpty) {
      final f = File(path);
      if (f.existsSync()) {
        return _buildFileParts([f], extractText: true);
      }
    }
    return const [];
  }

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
    await _checkPause();
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getLiteModels();
    final instructionsBlock = PromptService.instructionsBlock(
      customInstructions,
    );

    // Create the labels for files. Deliberately no absolute-page hints here:
    // the model must report printed TOC numbers verbatim (PageMapping does
    // the printed→absolute conversion in code).
    final List<String> fileLabels = [];
    for (int i = 0; i < indexFiles.length; i++) {
      final name = indexFiles[i].path.split(RegExp(r'[\\/]')).last;
      fileLabels.add('\n--- INDEX FOR BOOK $i: "$name" ---\n');
    }

    final fileParts = await _buildFileParts(indexFiles, fileLabels: fileLabels);
    final syllabusParts = await _buildFileParts(
      syllabusFiles,
      extractText: true,
    );

    // Chapter Starts Mode (Method Two)
    if (chapterStarts != null && chapterStarts.isNotEmpty) {
      onProgress?.call('Mapping chapter starts…', null);

      String multiBookInstruction = '';
      if (indexFiles.length > 1) {
        final bookDescriptions = List.generate(
          indexFiles.length,
          (i) =>
              'Book $i: "${indexFiles[i].path.split(RegExp(r'[\\/]')).last}"',
        ).join('\n');

        multiBookInstruction =
            '''
IMPORTANT: We are using MULTIPLE reference textbooks. Here is the list of books and their indices:
$bookDescriptions

You must map each chapter/module to its corresponding book.
In the returned JSON, for every chapter object in the "chapters" array, you MUST include a "bookIndex" field (0-based integer, e.g. 0 for Book 0, 1 for Book 1, etc.) indicating which textbook contains this chapter.
''';
      }

      final chapterPrompt = PromptService.chapterStartsList
          .replaceAll('%filename%', filename)
          .replaceAll(
            '%custom_instructions%',
            '$instructionsBlock\n$multiBookInstruction',
          );

      Map<String, dynamic>? meta;
      try {
        final text = await _generateWithGroqFallback(
          geminiModels: modelsToTry,
          geminiKeys: keys,
          contents: [
            Content.multi([
              TextPart(chapterPrompt),
              ...syllabusParts,
              ...fileParts,
            ]),
          ],
          slotName: 'Lite',
          generationConfig: GenerationConfig(
            responseMimeType: 'application/json',
          ),
          timeout: const Duration(minutes: 4),
          onRetry: (a, e) => print(
            '[AiService] Chapter starts transient attempt $a: ${_cleanErrMsg(e)}',
          ),
        );
        meta = _cleanAndDecodeJson(text);
      } catch (e) {
        throw Exception('Failed to map chapters. Error: $e');
      }

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
        final c = rawChapters[i] is Map
            ? Map<String, dynamic>.from(rawChapters[i])
            : <String, dynamic>{};
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

        final cid = (c['id']?.toString().trim().isNotEmpty ?? false)
            ? c['id'].toString()
            : 'm${i + 1}';

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
        'description':
            meta['description']?.toString() ?? 'Auto-generated course',
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
                },
              ],
            },
        ],
      };
      onProgress?.call('Finalizing structure…', 1.0);
      return Book.fromJson(
        assembled,
      ).copyWith(customInstructions: customInstructions);
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
      try {
        final text = await _generateWithGroqFallback(
          geminiModels: modelsToTry,
          geminiKeys: keys,
          contents: [
            Content.multi([TextPart(handoutPrompt), ...fileParts]),
          ],
          slotName: 'Lite',
          generationConfig: GenerationConfig(
            responseMimeType: 'application/json',
          ),
          timeout: const Duration(minutes: 4),
          onRetry: (a, e) => print(
            '[AiService] Handout skeleton transient attempt $a: ${_cleanErrMsg(e)}',
          ),
        );
        handoutMeta = _cleanAndDecodeJson(text);
      } catch (e) {
        throw Exception('Failed to analyze handout. Error: $e');
      }

      onProgress?.call('Finalizing handout structure…', 1.0);
      return Book.fromJson(
        handoutMeta,
      ).copyWith(customInstructions: customInstructions);
    }

    // ---- Stage 1: chapter list (one focused call → indeterminate) ----------
    onProgress?.call('Mapping chapters…', null);
    final bool isCourse = syllabusFiles.isNotEmpty;
    // Knowledge-only flow: no reference textbook attached. The skeleton comes
    // from the syllabus (when attached) and/or the model's own subject
    // knowledge, and carries no page mappings at all.
    final bool noReference = indexFiles.isEmpty;
    final promptTemplate = noReference
        ? PromptService.knowledgeChapterList
        : (isCourse
              ? PromptService.syllabusChapterList
              : PromptService.chapterList);

    String multiBookInstruction = '';
    if (indexFiles.length > 1) {
      final bookDescriptions = List.generate(
        indexFiles.length,
        (i) => 'Book $i: "${indexFiles[i].path.split(RegExp(r'[\\/]')).last}"',
      ).join('\n');

      multiBookInstruction =
          '''
IMPORTANT: We are using MULTIPLE reference textbooks. Here is the list of books and their indices:
$bookDescriptions

You must map each chapter/module to its corresponding book.
In the returned JSON, for every chapter object in the "chapters" array, you MUST include a "bookIndex" field (0-based integer, e.g. 0 for Book 0, 1 for Book 1, etc.) indicating which textbook contains this chapter, and "printedStartPage" must be the page number as printed in THAT textbook's own table of contents.
''';
    }

    final chapterPrompt = promptTemplate
        .replaceAll('%filename%', filename)
        .replaceAll(
          '%custom_instructions%',
          '$instructionsBlock\n$multiBookInstruction',
        );

    Map<String, dynamic>? meta;
    Exception? lastException;
    for (final modelName in modelsToTry) {
      for (final apiKey in keys) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
            ),
          );
          final response = await _retryTransient(
            () => model
                .generateContent([
                  Content.multi([
                    TextPart(chapterPrompt),
                    ...syllabusParts,
                    ...fileParts,
                  ]),
                ])
                .timeout(const Duration(minutes: 4)),
            onRetry: (a, e) => print(
              '[AiService] Chapter list transient ($modelName) attempt $a: ${_cleanErrMsg(e)}',
            ),
          );
          if (response.text != null) {
            meta = _cleanAndDecodeJson(response.text!);
            break;
          }
        } on TimeoutException {
          lastException = Exception('Chapter mapping timed out ($modelName).');
        } catch (e) {
          lastException = Exception(
            'Chapter mapping failed ($modelName): ${_cleanErrMsg(e)}',
          );
        }
      }
      if (meta != null) break;
    }
    if (meta == null)
      throw lastException ??
          Exception('Failed to map chapters. All models/keys exhausted.');

    final rawChapters = (meta['chapters'] ?? meta['modules']) as List?;
    if (rawChapters == null || rawChapters.isEmpty) {
      throw Exception(
        'The model returned no chapters for this table of contents.',
      );
    }

    // Normalize: stable ids + the printed TOC number the model read out.
    // `printedStartPage` is the new contract; `startPage` is accepted as a
    // fallback for models that ignore the rename (its value still follows
    // whatever the prompt asked for, i.e. printed numbers).
    final chapters = <Map<String, dynamic>>[];
    for (var i = 0; i < rawChapters.length; i++) {
      final c = rawChapters[i] is Map
          ? Map<String, dynamic>.from(rawChapters[i])
          : <String, dynamic>{};
      final cid = (c['id']?.toString().trim().isNotEmpty ?? false)
          ? c['id'].toString()
          : 'm${i + 1}';
      final rawBookIdx = _asInt(c['bookIndex']) ?? 0;
      chapters.add({
        'id': cid,
        'title': c['title']?.toString() ?? 'Chapter ${i + 1}',
        'description': c['description']?.toString() ?? '',
        'printedStart': _asInt(c['printedStartPage'] ?? c['startPage']),
        'bookIndex': (rawBookIdx >= 0 && rawBookIdx < indexFiles.length)
            ? rawBookIdx
            : 0,
      });
    }

    // Resolve absolute page ranges per source book IN CODE — the model never
    // does offset arithmetic anymore, so the offset can no longer be applied
    // twice, skipped, or hallucinated. The anchor is the model's own
    // first-chapter printed number vs the user-confirmed absolute start of
    // chapter 1, so a model that (wrongly) emitted absolute numbers
    // self-corrects to offset 0. Knowledge-only books skip this entirely:
    // their sections carry no page ranges and are never split.
    if (!noReference) {
      final byBook = <int, List<int>>{};
      for (var i = 0; i < chapters.length; i++) {
        byBook.putIfAbsent(chapters[i]['bookIndex'] as int, () => []).add(i);
      }
      for (final entry in byBook.entries) {
        final bookIdx = entry.key;
        final idxs = entry.value;
        final ch1Abs = bookIdx < chapter1AbsolutePages.length
            ? chapter1AbsolutePages[bookIdx]
            : 1;
        final printedStarts = [
          for (final i in idxs) chapters[i]['printedStart'] as int?,
        ];
        final ch1Printed =
            printedStarts.firstWhere((p) => p != null, orElse: () => 1) ?? 1;
        final offset = PageMapping.computeOffset(
          chapter1AbsPage: ch1Abs,
          chapter1PrintedPage: ch1Printed,
        );
        int totalPages = 0;
        if (sourceFiles != null && bookIdx < sourceFiles.length) {
          try {
            totalPages = await PdfService().getPageCount(sourceFiles[bookIdx]);
          } catch (e) {
            print(
              '[AiService] getPageCount failed for book $bookIdx: ${_cleanErrMsg(e)}',
            );
          }
        }
        if (totalPages <= 0) {
          // No source page count available: leave generous room past the last
          // chapter; the splitter clamps to the real page count anyway.
          var maxPrinted = ch1Printed;
          for (final p in printedStarts) {
            if (p != null && p > maxPrinted) maxPrinted = p;
          }
          totalPages = maxPrinted + offset + 30;
        }
        final resolved = PageMapping.resolveChapterRanges(
          printedStarts,
          offset: offset,
          totalPages: totalPages,
        );
        for (var k = 0; k < idxs.length; k++) {
          chapters[idxs[k]]['startPage'] = resolved.ranges[k].start;
          chapters[idxs[k]]['endPage'] = resolved.ranges[k].end;
          chapters[idxs[k]]['pageOffset'] = offset;
        }
        for (final note in resolved.corrections) {
          print('[AiService] Page mapping (book $bookIdx): $note');
        }
      }
    }

    // Stage 1.5 (AI crosscheck) has been moved to GenerationManager after splitting.

    // ---- Stage 2: sections per chapter (real progress, bounded concurrency) -
    final int chapterCount = chapters.length;
    onProgress?.call('Mapping sections (0/$chapterCount)…', 0);
    final List<List<Map<String, dynamic>>?> sectionSlots =
        List<List<Map<String, dynamic>>?>.filled(chapterCount, null);
    int done = 0;
    int nextIdx = 0;
    final int concurrency = (await _resolveConcurrency()).clamp(
      1,
      chapterCount,
    );

    Future<void> worker() async {
      while (true) {
        final i = nextIdx;
        if (i >= chapterCount) break;
        nextIdx++;
        final ch = chapters[i];

        String name = filename;
        List<Part> specificFileParts = const [];
        if (!noReference) {
          final int bookIdx = ch['bookIndex'] as int? ?? 0;
          final File specificIndexFile =
              (bookIdx >= 0 && bookIdx < indexFiles.length)
              ? indexFiles[bookIdx]
              : indexFiles.first;
          name = specificIndexFile.path.split(RegExp(r'[\\/]')).last;
          specificFileParts = await _buildFileParts(
            [specificIndexFile],
            fileLabels: ['\n--- INDEX FOR BOOK $bookIdx: "$name" ---\n'],
          );
        }

        List<Map<String, dynamic>>? secs;
        try {
          secs = await _generateSectionsForChapter(
            chapter: ch,
            filename: name,
            pageOffset: ch['pageOffset'] as int? ?? 0,
            instructionsBlock: instructionsBlock,
            fileParts: specificFileParts,
            models: modelsToTry,
            keys: keys,
            isCourse: isCourse,
            syllabusParts: syllabusParts,
            noReference: noReference,
          );
        } catch (e) {
          print(
            '[AiService] Sections for chapter ${ch['id']} failed: ${_cleanErrMsg(e)}',
          );
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
            },
          ];
        }
        sectionSlots[i] = secs;
        done++;
        onProgress?.call(
          'Mapping sections ($done/$chapterCount)…',
          done / chapterCount,
        );
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
      if (chapters.isNotEmpty && chapters.first['pageOffset'] != null)
        'pageOffset': chapters.first['pageOffset'],
      'modules': [
        for (var i = 0; i < chapterCount; i++)
          {
            'id': chapters[i]['id'],
            'title': chapters[i]['title'],
            'description': chapters[i]['description'],
            'sections': [
              for (var s in (sectionSlots[i] ?? const <Map<String, dynamic>>[]))
                {...s, 'bookIndex': chapters[i]['bookIndex'] ?? 0},
            ],
          },
      ],
    };
    onProgress?.call('Finalizing structure…', 1.0);
    return Book.fromJson(
      assembled,
    ).copyWith(customInstructions: customInstructions);
  }

  /// Stage-2 helper: details the sections of ONE [chapter] via
  /// [PromptService.sectionList]. The prompt speaks the TOC's language —
  /// PRINTED page numbers (the chapter's bounds are converted back via
  /// [pageOffset]) — and the model's printed answers are converted to
  /// absolute pages and normalized in code by [PageMapping], so no offset
  /// arithmetic ever happens inside the model.
  /// Returns normalized section JSON maps (chapter-scoped ids), or null when
  /// every model/key combination fails so the caller can fall back to a
  /// single whole-chapter section rather than lose the chapter.
  Future<List<Map<String, dynamic>>?> _generateSectionsForChapter({
    required Map<String, dynamic> chapter,
    required String filename,
    required int pageOffset,
    required String instructionsBlock,
    required List<Part> fileParts,
    required List<String> models,
    required List<String> keys,
    bool isCourse = false,
    List<Part> syllabusParts = const [],
    bool noReference = false,
  }) async {
    final promptTemplate = noReference
        ? PromptService.knowledgeSectionList
        : (isCourse
              ? PromptService.syllabusSectionList
              : PromptService.sectionList);
    final int? chStart = chapter['startPage'] as int?;
    final int? chEnd = chapter['endPage'] as int?;
    final prompt = promptTemplate
        .replaceAll('%filename%', filename)
        .replaceAll('%custom_instructions%', instructionsBlock)
        .replaceAll('%chapter_title%', chapter['title']?.toString() ?? '')
        .replaceAll(
          '%chapter_start%',
          chStart != null ? '${chStart - pageOffset}' : '?',
        )
        .replaceAll(
          '%chapter_end%',
          chEnd != null ? '${chEnd - pageOffset}' : '?',
        );

    final parts = <Part>[TextPart(prompt), ...syllabusParts, ...fileParts];
    try {
      final text = await _generateWithGroqFallback(
        geminiModels: models,
        geminiKeys: keys,
        contents: [Content.multi(parts)],
        slotName: 'Lite',
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
        ),
        onRetry: (a, e) => print(
          '[AiService] Sections (${chapter['id']}) transient attempt $a: ${_cleanErrMsg(e)}',
        ),
      );
      final jsonMap = _cleanAndDecodeJson(text);
      final rawSecs = jsonMap['sections'] as List?;
      if (rawSecs != null && rawSecs.isNotEmpty) {
        final out = <Map<String, dynamic>>[];
        final rawBounds = <({int? start, int? end})>[];
        for (var j = 0; j < rawSecs.length; j++) {
          final s = rawSecs[j] is Map
              ? Map<String, dynamic>.from(rawSecs[j])
              : <String, dynamic>{};
          final sid = (s['id']?.toString().trim().isNotEmpty ?? false)
              ? s['id'].toString()
              : 's${j + 1}';
          out.add({
            'id': '${chapter['id']}-$sid',
            'title': s['title']?.toString() ?? 'Section ${j + 1}',
            'description': s['description']?.toString() ?? '',
            'color': s['color']?.toString() ?? 'duo-blue',
          });
          rawBounds.add((
            start: _asInt(s['printedStartPage'] ?? s['startPage']),
            end: _asInt(s['printedEndPage'] ?? s['endPage']),
          ));
        }
        if (out.isNotEmpty) {
          if (chStart != null && chEnd != null) {
            final resolved = PageMapping.resolveSectionRanges(
              rawBounds,
              chapterStart: chStart,
              chapterEnd: chEnd,
              offset: pageOffset,
            );
            for (var j = 0; j < out.length; j++) {
              out[j]['startPage'] = resolved.ranges[j].start;
              out[j]['endPage'] = resolved.ranges[j].end;
            }
            for (final note in resolved.corrections) {
              print('[AiService] Sections (${chapter['id']}): $note');
            }
          }
          return out;
        }
      }
    } catch (e) {
      print(
        '[AiService] Sections (${chapter['id']}) failed: ${_cleanErrMsg(e)}',
      );
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
    void Function(String status, {double? progress, int? plannedLessons})
    onProgress, {
    String? sectionPdfPath,
    Unit? previousUnit,
    Unit? nextUnit,
    List<Unit> previousGeneratedUnits = const [],
    bool generateGraphics = true,
    void Function(List<Lesson> lessonsSoFar)? onLessonGenerated,
    String? forcedApiKey,
  }) async {
    await _checkPause();
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final textModelsToTry = await _getPrimaryTextModels();
    final liteModelsToTry = await _getLiteModels();

    // New-flow units share the section\'s PDF chunk; old-flow units have
    // their own pdfPath. Knowledge-only units have neither: lessons are then
    // authored from the syllabus (when saved) and the model's own knowledge.
    final String? chunkPath = unit.pdfPath ?? sectionPdfPath;
    final bool noSource = chunkPath == null;
    List<Part> contextParts = const [];
    if (!noSource) {
      final chunkFile = File(chunkPath);
      if (!chunkFile.existsSync()) {
        throw Exception(
          "Local file missing. Tap 'Restore' on the warning banner to re-link source files.",
        );
      }
      contextParts = await _buildFileParts([chunkFile]);
    } else {
      contextParts = await _knowledgeContextParts(bookContext);
    }

    // Build a layout descriptor of all available lesson formats in the book.
    // Different lessons in the same unit can follow different formats.
    final String formatsLayoutString = bookContext.lessonFormats
        .map((f) {
          final slidesStr = f.slides
              .map(
                (t) =>
                    "  * Type: ${t.type} | Condition: ${t.condition} | Instructions: ${t.description}",
              )
              .join('\n');
          return "- Format: ${f.id} (${f.name}) — ${f.description}\n$slidesStr";
        })
        .join('\n\n');

    // Context shared by the plan + per-lesson prompts: the unit's neighbours
    // (so generation stays inside this unit's slice of the shared section PDF)
    // and a summary of already-generated units (so material isn't repeated).
    final String neighborContext = _buildNeighborContext(
      previousUnit,
      unit,
      nextUnit,
    );
    final String previousUnitsContent = _buildPreviousUnitsContent(
      previousGeneratedUnits,
    );
    final String instructionsBlock =
        (noSource ? '${PromptService.noSourceContentNote}\n' : '') +
        PromptService.instructionsBlock(bookContext.customInstructions);

    int modIdx = -1;
    int secIdx = -1;
    int unitIdx = -1;
    for (int m = 0; m < bookContext.modules.length; m++) {
      for (int s = 0; s < bookContext.modules[m].sections.length; s++) {
        for (int u = 0; u < bookContext.modules[m].sections[s].units.length; u++) {
          if (bookContext.modules[m].sections[s].units[u].id == unit.id) {
            modIdx = m;
            secIdx = s;
            unitIdx = u;
            break;
          }
        }
        if (unitIdx != -1) break;
      }
      if (unitIdx != -1) break;
    }

    final layoutBuffer = StringBuffer();
    for (int m = 0; m < bookContext.modules.length; m++) {
      final module = bookContext.modules[m];
      layoutBuffer.writeln('Module ${m + 1}: ${module.title}');
      for (int s = 0; s < module.sections.length; s++) {
        final section = module.sections[s];
        layoutBuffer.writeln('  Section ${s + 1}: ${section.title}');
        for (int u = 0; u < section.units.length; u++) {
          final targetUnit = section.units[u];
          final isCurrent = (m == modIdx && s == secIdx && u == unitIdx);
          final currentMarker = isCurrent ? ' [CURRENT UNIT WE ARE PLANNING NOW]' : '';
          layoutBuffer.writeln('    Unit ${u + 1}: ${targetUnit.title}$currentMarker');
          if (targetUnit.lessons.isNotEmpty) {
            layoutBuffer.writeln('      Existing Lessons:');
            for (final l in targetUnit.lessons) {
              layoutBuffer.writeln('        - ${l.title}: ${l.description}');
            }
          }
        }
      }
    }
    final String entireLayout = layoutBuffer.toString().trim();

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
        .replaceAll('%neighbor_context%', neighborContext)
        .replaceAll('%entire_layout%', entireLayout);

    final compiledMetacognitiveSystemPrompt =
        await PersonalizationService.compileSystemPrompt(
          baseSystemPrompt:
              bookContext.systemPrompt ?? 'You are an expert tutor.',
          bloomLevel: bookContext.bloomLevel,
          book: bookContext,
          unitId: unit.id,
        );

    final planFileParts = contextParts;
    String? lessonPlan;
    Exception? planError;
    try {
      lessonPlan = await _generateWithGroqFallback(
        geminiModels: liteModelsToTry,
        geminiKeys: keys,
        contents: [
          Content.multi([
            TextPart(hydratedPlanPrompt),
            ...planFileParts,
          ]),
        ],
        slotName: 'Lite',
        timeout: planTimeout,
        systemInstruction: compiledMetacognitiveSystemPrompt,
        onRetry: (a, e) {
          print(
            '[AiService] Unit plan transient attempt $a: ${_cleanErrMsg(e)}',
          );
          onProgress('Server hiccup — retrying...');
        },
      );
    } catch (e) {
      planError = e as Exception;
    }
    if (lessonPlan == null) {
      throw planError ?? Exception('AI failed to generate a lesson plan.');
    }
    // Capture into a final non-nullable so the worker closure below can read
    // it without null-promotion concerns.
    final String planText = lessonPlan;

    int lessonCount = _parseLessonCount(planText);
    if (lessonCount <= 0) {
      throw Exception(
        'Could not determine lesson count from plan. Expected a "TOTAL_LESSONS: N" line.',
      );
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
    final lessonFileParts = contextParts;
    final List<Lesson> existing = List.of(unit.lessons);
    final int total = lessonCount > existing.length
        ? lessonCount
        : existing.length;
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
      if ((l.canvasPrompt?.trim().isNotEmpty ?? false) && empty(l.canvasSvg))
        return true;
      return l.slides.any(
        (s) =>
            (s.type == 'proof' || s.type == 'step_by_step') &&
            (s.canvasPrompt?.trim().isNotEmpty ?? false) &&
            empty(s.canvasSvg),
      );
    }

    for (int i = 0; i < total; i++) {
      await _checkPause();
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
          print(
            '[AiService] Lesson ${i + 1} failed permanently: ${_cleanErrMsg(e)}',
          );
        }
        if (lesson != null) slots[i] = lesson;
      }
      doneSteps++;
      onProgress(
        'Generating lessons (${collected().length}/$total)...',
        progress: doneSteps / totalSteps,
        plannedLessons: total,
      );
      onLessonGenerated?.call(collected()); // show this lesson right away

      // 2. This lesson's diagram(s), then stream the lesson again with its art.
      if (generateGraphics) {
        if (lesson != null && needsArt(lesson)) {
          try {
            slots[i] = await _attachArtToLesson(
              lesson,
              forcedApiKey: forcedApiKey,
            );
            onLessonGenerated?.call(collected());
          } catch (e) {
            print(
              '[AiService] Art for lesson ${i + 1} failed: ${_cleanErrMsg(e)}',
            );
          }
        }
        doneSteps++; // counted even when skipped/failed so totals reconcile
        onProgress(
          'Rendering diagrams (${i + 1}/$total)...',
          progress: doneSteps / totalSteps,
          plannedLessons: total,
        );
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
    b.writeln(
      '- CURRENT unit (generate ONLY this): "${current.title}" — ${current.description}',
    );
    b.writeln(
      prev != null
          ? '- PREVIOUS unit (already handled — do NOT cover): "${prev.title}" — ${prev.description}'
          : '- PREVIOUS unit: (none — this is the first unit in the section)',
    );
    b.writeln(
      next != null
          ? '- NEXT unit (handled separately later — do NOT cover): "${next.title}" — ${next.description}'
          : '- NEXT unit: (none — this is the last unit in the section)',
    );
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
    final compiledMetacognitiveSystemPrompt =
        await PersonalizationService.compileSystemPrompt(
          baseSystemPrompt:
              bookContext.systemPrompt ?? 'You are an expert tutor.',
          bloomLevel: bookContext.bloomLevel,
          book: bookContext,
          unitId: unit.id,
        );

    final prompt = PromptService.singleLessonJson
        .replaceAll(
          '%system_prompt%',
          bookContext.systemPrompt ?? 'You are an expert tutor.',
        )
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
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
            ),
            systemInstruction: Content.system(
              compiledMetacognitiveSystemPrompt,
            ),
          );
          final response = await _retryTransient(
            () => _generateContentWithTiming(
              model: model,
              modelName: modelName,
              contents: [Content.multi(parts)],
              requestType: 'lesson_gen',
              targetId: '${unit.id}-pending-${index - 1}',
              generationConfig: GenerationConfig(
                responseMimeType: 'application/json',
              ),
            ).timeout(const Duration(minutes: 3)),
            onRetry: (a, e) => print(
              '[AiService] Lesson $index transient ($modelName) attempt $a: ${_cleanErrMsg(e)}',
            ),
          );
          final text = response.text;
          if (text == null || text.trim().isEmpty) {
            throw Exception('Empty response for lesson $index.');
          }
          final jsonMap = _cleanAndDecodeJson(text);
          final lesson = Lesson.fromJson(jsonMap);
          final uniqueLessonId =
              '${unit.id}-${lesson.id.isNotEmpty ? lesson.id : 'l$index'}';
          final claimedFormat = lesson.formatId;
          final acceptedFormat =
              (claimedFormat != null && validFormatIds.contains(claimedFormat))
              ? claimedFormat
              : bookContext.defaultFormatId;
          int slideIdx = 1;
          final Set<String> seenSuffixes = {};
          final updatedSlides = lesson.slides.map((s) {
            var suffix = s.id.split('-').last.trim();
            if (suffix.isEmpty ||
                suffix == '%slide_id%' ||
                suffix == 'null' ||
                suffix == s.id ||
                seenSuffixes.contains(suffix)) {
              suffix = 's${slideIdx++}';
              while (seenSuffixes.contains(suffix)) {
                suffix = 's${slideIdx++}';
              }
            }
            seenSuffixes.add(suffix);
            return s.copyWith(id: '$uniqueLessonId-$suffix');
          }).toList();
          return lesson.copyWith(
            id: uniqueLessonId,
            formatId: acceptedFormat,
            slides: updatedSlides,
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
    String? customPrompt,
    String? newFormatId,
  }) async {
    await _checkPause();
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final textModels = await _getPrimaryTextModels();

    // Knowledge-only units have no chunk: regenerate from the syllabus (when
    // saved) and the model's own knowledge, like initial generation.
    final String? chunkPath = unit.pdfPath ?? sectionPdfPath;
    final bool noSource = chunkPath == null;
    List<Part> contextParts = const [];
    if (!noSource) {
      final chunkFile = File(chunkPath);
      if (!chunkFile.existsSync()) {
        throw Exception(
          "Local file missing. Tap 'Restore' on the warning banner to re-link source files.",
        );
      }
      contextParts = await _buildFileParts([chunkFile]);
    } else {
      contextParts = await _knowledgeContextParts(bookContext);
    }

    final neighborContext = _buildNeighborContext(previousUnit, unit, nextUnit);
    final instructionsBlock =
        (noSource ? '${PromptService.noSourceContentNote}\n' : '') +
        PromptService.instructionsBlock(bookContext.customInstructions);

    final String targetFormatId =
        newFormatId ?? lesson.formatId ?? bookContext.defaultFormatId;

    // Synthesise a one-lesson plan so the model regenerates THIS lesson
    // specifically rather than picking a new topic.
    final synthPlan = StringBuffer()
      ..writeln('TOTAL_LESSONS: 1')
      ..writeln('Lesson 1: ${lesson.title}')
      ..writeln(lesson.description);
    if (lesson.canvasPrompt != null && lesson.canvasPrompt!.trim().isNotEmpty) {
      synthPlan.writeln('Diagram: ${lesson.canvasPrompt!.trim()}');
    }
    if (customPrompt != null && customPrompt.trim().isNotEmpty) {
      synthPlan.writeln(
        'User request/guidelines for this regeneration: ${customPrompt.trim()}',
      );
    }
    synthPlan.writeln(
      'Cover the same pedagogical point. Use the lesson format "$targetFormatId" and a similar slide structure.',
    );

    final fileParts = contextParts;
    Lesson? fresh;
    try {
      fresh = await _generateOneLesson(
        index: 1,
        unit: unit,
        bookContext: bookContext,
        lessonPlan: synthPlan.toString(),
        neighborContext: neighborContext,
        previousUnitsContent:
            '(regeneration of an existing lesson — no prior-unit context needed)',
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

    int slideIdx = 1;
    fresh = fresh.copyWith(
      id: lesson.id,
      formatId: targetFormatId,
      slides: fresh.slides.map((s) {
        // Rewrite slide ids so they're rooted on the kept lesson id.
        var tail = s.id.split('-').last;
        if (tail.isEmpty || tail == s.id) {
          tail = 's${slideIdx++}';
        }
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

  Future<Slide?> regenerateSlide({
    required Slide slide,
    required Lesson lesson,
    required Book bookContext,
    String? chunkPath,
    String? note,
    String? forcedApiKey,
    String? targetType,
    String? screenSizeInfo,
  }) async {
    await _checkPause();
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final textModels = await _getPrimaryTextModels();

    final compiledMetacognitiveSystemPrompt =
        await PersonalizationService.compileSystemPrompt(
          baseSystemPrompt:
              bookContext.systemPrompt ?? 'You are an expert tutor.',
          bloomLevel: bookContext.bloomLevel,
          book: bookContext,
        );

    final noteLine = (note?.trim().isNotEmpty ?? false)
        ? 'USER STEERING NOTE FOR THIS REGENERATION: ${note!.trim()}\n'
        : '';
    final sizeCtx = screenSizeInfo != null && screenSizeInfo.isNotEmpty
        ? screenSizeInfo
        : 'not specified (make it responsive to standard mobile/desktop screen sizes)';
    final prompt = PromptService.singleSlideJson
        .replaceAll(
          '%system_prompt%',
          bookContext.systemPrompt ?? 'You are an expert tutor.',
        )
        .replaceAll(
          '%custom_instructions%',
          PromptService.instructionsBlock(bookContext.customInstructions),
        )
        .replaceAll('%lesson_title%', lesson.title)
        .replaceAll('%unit_title%', lesson.title)
        .replaceAll('%slide_type%', targetType ?? slide.type)
        .replaceAll('%slide_content%', jsonEncode(slide.toJson()))
        .replaceAll('%slide_id%', slide.id)
        .replaceAll('%regen_note%', noteLine)
        .replaceAll('%screen_size_info%', sizeCtx);

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
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
            ),
            systemInstruction: Content.system(
              compiledMetacognitiveSystemPrompt,
            ),
          );
          final response = await _retryTransient(
            () => model
                .generateContent([Content.multi(parts)])
                .timeout(const Duration(minutes: 3)),
            onRetry: (a, e) => print(
              '[AiService] Slide regen transient ($modelName) attempt $a: ${_cleanErrMsg(e)}',
            ),
          );
          final text = response.text;
          if (text == null || text.trim().isEmpty) continue;
          final jsonMap = _cleanAndDecodeJson(text);
          final fresh = Slide.fromJson(jsonMap);
          // Preserve the slide's identity and type; the model only supplies
          // the new content/options. Keep any existing diagram SVG.
          return fresh.copyWith(
            id: slide.id,
            type: targetType ?? slide.type,
            canvasSvg: slide.canvasSvg,
          );
        } catch (e) {
          lastErr = e;
        }
      }
    }
    if (lastErr != null) {
      print(
        '[AiService] Slide regen exhausted all models. Last: ${_cleanErrMsg(lastErr)}',
      );
      throw lastErr is Exception ? lastErr : Exception(_cleanErrMsg(lastErr));
    }
    throw Exception(
      'Failed to regenerate slide: AI returned an empty response.',
    );
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
  Future<String?> generateCanvasArt(
    String canvasPrompt, {
    String contextText = '',
    String? errorContext,
    String? forcedApiKey,
    bool isHighPriority = false,
    String? targetId,
    bool skipReuse = false,
  }) async {
    if (canvasPrompt.trim().isEmpty) return null;

    if (!isHighPriority) {
      await _checkPause();
    }

    if (!skipReuse) {
      final reused = await findReusableCanvasArt(
        canvasPrompt,
        forcedApiKey: forcedApiKey,
      );
      if (reused != null) return reused;
    }

    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getPrimaryGraphicsModels();
    // Cap context to keep prompts small — the SVG diagram doesn't need the
    // entire lesson, only a few sentences for tone matching.
    final trimmedContext = contextText.length > 800
        ? contextText.substring(0, 800)
        : contextText;
    String hydrated = PromptService.canvasArt
        .replaceAll('%canvas_prompt%', canvasPrompt.trim())
        .replaceAll('%lesson_context%', trimmedContext);

    if (errorContext != null && errorContext.isNotEmpty) {
      hydrated +=
          '\n\nPREVIOUS ATTEMPT FAILED WITH JAVASCRIPT ERROR:\n$errorContext\nFix the code so it doesn\'t throw this error.';
    }

    Object? lastErr;
    for (final modelName in modelsToTry) {
      for (final apiKey in keys) {
        try {
          final model = GenerativeModel(model: modelName, apiKey: apiKey);
          final response = await _retryTransient(
            () => _generateContentWithTiming(
              model: model,
              modelName: modelName,
              contents: [Content.text(hydrated)],
              requestType: 'diagram_gen',
              targetId: targetId,
            ).timeout(const Duration(minutes: 2)),
            onRetry: (a, e) => print(
              '[AiService] Canvas art transient ($modelName) attempt $a: ${_cleanErrMsg(e)}',
            ),
          );
          final text = response.text;
          if (text == null || text.trim().isEmpty) continue;
          final drawFn = _extractDrawFunction(text);
          if (drawFn != null) return drawFn;
        } catch (e) {
          lastErr = e;
          print(
            '[AiService] Canvas art failed ($modelName): ${_cleanErrMsg(e)}',
          );
        }
      }
    }
    if (lastErr != null) {
      print(
        '[AiService] Canvas art exhausted all models. Last: ${_cleanErrMsg(lastErr)}',
      );
    }
    return null;
  }

  /// Pulls a clean JavaScript program or raw SVG markup out of the model's raw response.
  /// Accepts either the static `function draw(ctx, W, H)` entry point, the richer
  /// `function sketch(canvas, W, H)` entry point, or raw `<svg>` block.
  /// Strips Markdown code fences first, then isolates the chosen function block or SVG element.
  String? _extractDrawFunction(String raw) {
    var s = raw.trim();
    // Strip code fences if present.
    final fence = RegExp(
      r'```(?:js|javascript|svg|xml|html)?\s*([\s\S]*?)```',
      caseSensitive: false,
      multiLine: true,
    );
    final fenceMatch = fence.firstMatch(s);
    if (fenceMatch != null) s = fenceMatch.group(1)!.trim();

    // Check if it is raw SVG markup.
    final svgStart = s.toLowerCase().indexOf('<svg');
    if (svgStart >= 0) {
      final svgEnd = s.toLowerCase().lastIndexOf('</svg>');
      if (svgEnd >= 0 && svgEnd > svgStart) {
        return s.substring(svgStart, svgEnd + 6).trim();
      }
    }

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

  Future<String?> findReusableCanvasArt(
    String newPrompt, {
    String? forcedApiKey,
  }) async {
    try {
      final books = await DatabaseService().fetchBooks(forceRefresh: false);
      final Map<String, String> candidates = {};
      for (final book in books) {
        for (final module in book.modules) {
          for (final section in module.sections) {
            for (final unit in section.units) {
              for (final lesson in unit.lessons) {
                if (lesson.canvasPrompt != null &&
                    lesson.canvasPrompt!.trim().isNotEmpty &&
                    lesson.canvasSvg != null &&
                    lesson.canvasSvg!.trim().isNotEmpty) {
                  candidates[lesson.canvasPrompt!.trim()] = lesson.canvasSvg!
                      .trim();
                }
                for (final slide in lesson.slides) {
                  if (slide.canvasPrompt != null &&
                      slide.canvasPrompt!.trim().isNotEmpty &&
                      slide.canvasSvg != null &&
                      slide.canvasSvg!.trim().isNotEmpty) {
                    candidates[slide.canvasPrompt!.trim()] = slide.canvasSvg!
                        .trim();
                  }
                }
              }
            }
          }
        }
      }

      if (candidates.isEmpty) return null;

      // Extract 1-2 keywords using a Lite model
      final keys = await _getKeys(forcedApiKey: forcedApiKey);
      final liteModels = await _getLiteModels();
      if (keys.isEmpty || liteModels.isEmpty) return null;

      final keywordPrompt =
          '''
You are a keyword extractor. Extract 1-2 core technical keywords or short phrases from this canvas art prompt.
These keywords will be used to run a fast pre-filter on existing diagram prompts.
Be extremely specific to the concept (e.g. for "draw a resistor and capacitor circuit", extract "resistor, capacitor").
Return ONLY the comma-separated keywords/phrases, no explanation, no markdown.

Prompt: $newPrompt
''';

      String keywordsStr = '';
      for (final modelName in liteModels) {
        for (final apiKey in keys) {
          try {
            final model = GenerativeModel(model: modelName, apiKey: apiKey);
            final response = await model.generateContent([
              Content.text(keywordPrompt),
            ]);
            if (response.text != null && response.text!.trim().isNotEmpty) {
              keywordsStr = response.text!.trim();
              break;
            }
          } catch (_) {}
        }
        if (keywordsStr.isNotEmpty) break;
      }

      if (keywordsStr.isEmpty) return null;

      final keywords = keywordsStr
          .split(',')
          .map((k) => k.trim().toLowerCase())
          .where((k) => k.isNotEmpty)
          .toList();

      if (keywords.isEmpty) return null;

      // Pre-filter candidate prompts
      final List<MapEntry<String, String>> filtered = [];
      for (final entry in candidates.entries) {
        final promptLower = entry.key.toLowerCase();
        bool matches = false;
        for (final kw in keywords) {
          if (promptLower.contains(kw)) {
            matches = true;
            break;
          }
        }
        if (matches) {
          filtered.add(entry);
        }
      }

      if (filtered.isEmpty) return null;

      // Limit to top 10
      final List<MapEntry<String, String>> topFiltered = filtered
          .take(10)
          .toList();

      // Ask Lite model if there is a match
      final candidateListStr = topFiltered
          .asMap()
          .entries
          .map((e) => 'Candidate ${e.key}: "${e.value.key}"')
          .join('\n');
      final matchPrompt =
          '''
You are a diagram matching system. We have a new diagram to create:
New Prompt: "$newPrompt"

Below is a list of existing diagram prompts that we have already drawn.
Check if any of the existing candidates is a direct technical match (meaning they describe the exact same diagram, circuit, or illustration concept). It doesn't have to be identical word-for-word, but must represent the exact same visual content (e.g., "sine wave" matches "a graph showing a sine wave").

List of existing candidates:
$candidateListStr

If there is a match, reply with ONLY the text "MATCH: Index" where Index is the candidate number (e.g. "MATCH: 0").
If there are no matches or you are not sure, reply with ONLY "NO_MATCH".
Do not include any explanation or other text.
''';

      String matchResult = '';
      for (final modelName in liteModels) {
        for (final apiKey in keys) {
          try {
            final model = GenerativeModel(model: modelName, apiKey: apiKey);
            final response = await model.generateContent([
              Content.text(matchPrompt),
            ]);
            if (response.text != null && response.text!.trim().isNotEmpty) {
              matchResult = response.text!.trim();
              break;
            }
          } catch (_) {}
        }
        if (matchResult.isNotEmpty) break;
      }

      if (matchResult.startsWith('MATCH:')) {
        final indexStr = matchResult.substring(6).trim();
        final idx = int.tryParse(indexStr);
        if (idx != null && idx >= 0 && idx < topFiltered.length) {
          print(
            '[AiService] Found reusable canvas art for "$newPrompt" matching candidate "${topFiltered[idx].key}"',
          );
          return topFiltered[idx].value;
        }
      }
    } catch (e) {
      print('[AiService] Error in findReusableCanvasArt: $e');
    }
    return null;
  }

  /// Renders the diagram(s) for a SINGLE [lesson]: the lesson-level diagram
  /// plus any proof/step_by_step slide that asked for one. Only fills art that
  /// is missing (a non-null `canvasSvg` is left as-is). Failures are tolerated
  /// — a lesson simply renders without that diagram. Called per-lesson right
  /// after the lesson's text is generated, so visuals appear incrementally.
  Future<Lesson> _attachArtToLesson(
    Lesson lesson, {
    String? forcedApiKey,
  }) async {
    // 1. Lesson-level diagram. Use the first slide's content as context so the
    //    art stays thematically consistent with the lesson.
    String? lessonArt = lesson.canvasSvg;
    if (lessonArt == null &&
        (lesson.canvasPrompt?.trim().isNotEmpty ?? false)) {
      final ctx = lesson.slides.isNotEmpty ? lesson.slides.first.content : '';
      lessonArt = await generateCanvasArt(
        lesson.canvasPrompt!,
        contextText: ctx,
        forcedApiKey: forcedApiKey,
        targetId: lesson.id,
      );
    }

    // 2. Per-slide diagrams for proof / step_by_step slides only.
    final List<Slide> updatedSlides = [];
    for (final slide in lesson.slides) {
      final isProofLike = slide.type == 'proof' || slide.type == 'step_by_step';
      String? slideArt = slide.canvasSvg;
      if (isProofLike &&
          slideArt == null &&
          (slide.canvasPrompt?.trim().isNotEmpty ?? false)) {
        slideArt = await generateCanvasArt(
          slide.canvasPrompt!,
          contextText: slide.content,
          forcedApiKey: forcedApiKey,
          targetId: slide.id,
        );
      }
      updatedSlides.add(slide.copyWith(canvasSvg: slideArt));
    }

    return lesson.copyWith(canvasSvg: lessonArt, slides: updatedSlides);
  }

  Future<List<LessonFormat>> generateSectionFormats(
    Section section, {
    String? forcedApiKey,
  }) async {
    if (section.pdfPath == null) {
      throw Exception('Section has no PDF chunk — cannot generate formats.');
    }
    final chunkFile = File(section.pdfPath!);
    if (!chunkFile.existsSync()) {
      throw Exception(
        "Local file missing. Tap 'Restore' on the warning banner to re-link source files.",
      );
    }

    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getLiteModels();

    final hydratedPrompt = PromptService.generateLessonFormatsPrompt
        .replaceAll('%section_title%', section.title)
        .replaceAll('%section_description%', section.description);

    final parts = <Part>[
      TextPart(hydratedPrompt),
      ...await _buildFileParts([chunkFile]),
    ];

    Exception? lastException;
    try {
      final text = await _generateWithGroqFallback(
        geminiModels: modelsToTry,
        geminiKeys: keys,
        contents: [Content.multi(parts)],
        slotName: 'Lite',
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
        ),
        onRetry: (a, e) => print(
          '[AiService] Lesson formats transient attempt $a: ${_cleanErrMsg(e)}',
        ),
      );
      final decoded = _cleanAndDecodeJson(text);
      final formatsJson = decoded['lessonFormats'] as List?;
      if (formatsJson != null) {
        return formatsJson
            .map(
              (f) => LessonFormat.fromJson(
                f is Map ? Map<String, dynamic>.from(f) : {},
              ),
            )
            .toList();
      }
    } catch (e) {
      lastException = e as Exception;
    }
    throw lastException ?? Exception('Failed to generate lesson formats.');
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
    // Knowledge-only sections have no PDF chunk: the manifest is generated
    // from the book's syllabus (when saved) and the model's own knowledge.
    final bool noSource = section.pdfPath == null;
    List<Part> contextParts = const [];
    if (!noSource) {
      final chunkFile = File(section.pdfPath!);
      if (!chunkFile.existsSync()) {
        throw Exception(
          "Local file missing. Tap 'Restore' on the warning banner to re-link source files.",
        );
      }
      contextParts = await _buildFileParts([chunkFile]);
    } else {
      contextParts = await _knowledgeContextParts(bookContext);
    }

    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getLiteModels();

    // Build the catalog the AI picks `formatId` from. Each entry is one
    // line: "- <id> :: <name> — <one-line summary>".
    final formats = bookContext.formatsForSection(section);
    final formatCatalog = formats
        .map((f) => '- ${f.id} :: ${f.name} — ${f.description}')
        .join('\n');

    final hydratedPrompt =
        ((noSource ? '${PromptService.noSourceContentNote}\n' : '') +
                PromptService.unitManifest)
            .replaceAll('%section_title%', section.title)
            .replaceAll('%section_description%', section.description)
            .replaceAll('%format_catalog%', formatCatalog)
            .replaceAll('%bloom_level%', bookContext.bloomLevel)
            .replaceAll(
              '%custom_instructions%',
              PromptService.instructionsBlock(customInstructions),
            );

    final parts = <Part>[TextPart(hydratedPrompt), ...contextParts];

    Exception? lastException;
    try {
      final text = await _generateWithGroqFallback(
        geminiModels: modelsToTry,
        geminiKeys: keys,
        contents: [Content.multi(parts)],
        slotName: 'Lite',
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
        ),
        onRetry: (a, e) => print(
          '[AiService] Unit manifest transient attempt $a: ${_cleanErrMsg(e)}',
        ),
      );
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
        units.add(
          base.copyWith(
            id: '${section.id}-$id',
            isGenerated: false,
            lessons: const [],
            pdfPath: null,
            startPage: null,
            endPage: null,
          ),
        );
      }
      if (units.isEmpty)
        throw Exception('Unit manifest had no usable entries.');

      final newFormats = <LessonFormat>[];
      final formatsData = jsonMap['newLessonFormats'] as List?;
      if (formatsData != null) {
        for (final f in formatsData) {
          if (f is Map) {
            try {
              newFormats.add(
                LessonFormat.fromJson(Map<String, dynamic>.from(f)),
              );
            } catch (_) {}
          }
        }
      }

      return UnitManifestResult(units: units, newFormats: newFormats);
    } catch (e) {
      lastException = e as Exception;
    }
    throw lastException ??
        Exception(
          'Failed to generate unit manifest. All models/keys exhausted.',
        );
  }

  Future<QuestionPaper> generateQuestionPaper(
    List<File> files,
    String qpTitle,
    String? systemPrompt, {
    String? customInstructions,
    String? forcedApiKey,
  }) async {
    await _checkPause();
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getPrimaryTextModels();

    final hydratedPrompt = PromptService.qpJson
        .replaceAll(
          '%system_prompt%',
          systemPrompt ?? "You are an expert tutor.",
        )
        .replaceAll(
          '%custom_instructions%',
          PromptService.instructionsBlock(customInstructions),
        );

    List<Part> parts = [TextPart(hydratedPrompt)];
    parts.addAll(await _buildFileParts(files));

    Exception? lastException;

    for (var modelName in modelsToTry) {
      for (var apiKey in keys) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
            ),
          );

          final response = await _retryTransient(
            () => model
                .generateContent([Content.multi(parts)])
                .timeout(const Duration(minutes: 6)),
            onRetry: (a, e) => print(
              '[AiService] QP transient ($modelName) attempt $a: ${_cleanErrMsg(e)}',
            ),
          );

          if (response.text != null) {
            final jsonMap = _cleanAndDecodeJson(response.text!);
            final qp = QuestionPaper.fromJson(jsonMap);
            return QuestionPaper(
              id: qp.id,
              title: qpTitle.isNotEmpty ? qpTitle : qp.title,
              sections: qp.sections,
            );
          }
        } catch (e) {
          lastException = Exception(
            'QP Generation failed ($modelName): ${_cleanErrMsg(e)}',
          );
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
    await _checkPause();
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
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
            ),
          );

          final response = await _retryTransient(
            () => model
                .generateContent([Content.multi(parts)])
                .timeout(const Duration(minutes: 5)),
            onRetry: (a, e) => print(
              '[AiService] PYQ extract transient ($modelName) attempt $a: ${_cleanErrMsg(e)}',
            ),
          );

          if (response.text != null) {
            final jsonMap = _cleanAndDecodeJson(response.text!);
            final questionsList = jsonMap['questions'] as List?;
            if (questionsList == null) return [];
            // Honour the model's self-declared provenance instead of blindly
            // tagging everything as extracted. Only an explicit "extracted"
            // counts as lifted-from-the-paper; anything else (including a
            // missing/unknown value) is treated as AI-generated, so invented
            // questions can never masquerade as real exam questions.
            return questionsList.map((q) {
              final map = Map<String, dynamic>.from(q);
              final declared = (map['source'] ?? '')
                  .toString()
                  .trim()
                  .toLowerCase();
              final source = declared == 'extracted'
                  ? 'extracted'
                  : 'generated';
              return Slide.fromJson(map).copyWith(source: source);
            }).toList();
          }
        } catch (e) {
          lastException = Exception(
            'PYQ extraction failed ($modelName): ${_cleanErrMsg(e)}',
          );
        }
      }
    }
    throw lastException ?? Exception('Failed to extract PYQ questions.');
  }

  Future<List<Map<String, dynamic>>> gradePyqAnswers({
    required List<Map<String, dynamic>> answersToGrade,
    String? forcedApiKey,
  }) async {
    await _checkPause();
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getLiteModels();

    final prompt = PromptService.getPyqGradingPrompt(
      answersToGrade: answersToGrade,
    );

    Exception? lastException;
    for (var modelName in modelsToTry) {
      for (var apiKey in keys) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
            ),
          );

          final response = await _retryTransient(
            () => model
                .generateContent([Content.text(prompt)])
                .timeout(const Duration(minutes: 3)),
            onRetry: (a, e) => print(
              '[AiService] PYQ grading transient ($modelName) attempt $a: ${_cleanErrMsg(e)}',
            ),
          );

          if (response.text != null) {
            final jsonMap = _cleanAndDecodeJson(response.text!);
            final results = jsonMap['results'] as List?;
            if (results == null) return [];
            return results.map((r) => Map<String, dynamic>.from(r)).toList();
          }
        } catch (e) {
          lastException = Exception(
            'PYQ grading failed ($modelName): ${_cleanErrMsg(e)}',
          );
        }
      }
    }
    throw lastException ?? Exception('Failed to grade PYQ answers.');
  }

  Future<Slide?> generateCustomLessonSlide({
    required String lessonTitle,
    required String unitTitle,
    required String slideType,
    required String slideDescription,
    required String userInstructions,
    required List<File> attachedFiles,
    required List<Slide> slidesSoFar,
    required int slideIndex,
    required int totalSlides,
    required Book bookContext,
    String? forcedApiKey,
    String? screenSizeInfo,
  }) async {
    await _checkPause();
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final liteModels = await _getLiteModels(); // We use lite model as requested

    final neighborContext = slidesSoFar.isEmpty
        ? 'No slides generated yet.'
        : 'Slides generated so far: ' +
              jsonEncode(slidesSoFar.map((s) => s.toJson()).toList());

    final sizeCtx = screenSizeInfo != null && screenSizeInfo.isNotEmpty
        ? screenSizeInfo
        : 'not specified (make it responsive to standard mobile/desktop screen sizes)';
    final prompt = PromptService.customSlideJson
        .replaceAll('%lesson_title%', lessonTitle)
        .replaceAll('%unit_title%', unitTitle)
        .replaceAll('%slide_type%', slideType)
        .replaceAll('%slide_description%', slideDescription)
        .replaceAll('%user_prompt%', userInstructions)
        .replaceAll('%slides_so_far%', neighborContext)
        .replaceAll('%slide_index%', '$slideIndex')
        .replaceAll('%total_slides%', '$totalSlides')
        .replaceAll(
          '%slide_id%',
          '${lessonTitle.replaceAll(RegExp(r'\s+'), '_').toLowerCase()}_s$slideIndex',
        )
        .replaceAll('%screen_size_info%', sizeCtx);

    final fileParts = await _buildFileParts(attachedFiles);
    final parts = <Part>[TextPart(prompt), ...fileParts];

    Object? lastErr;
    try {
      final text = await _generateWithGroqFallback(
        geminiModels: liteModels,
        geminiKeys: keys,
        contents: [Content.multi(parts)],
        slotName: 'Lite',
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
        ),
        onRetry: (a, e) => print(
          '[AiService] Custom slide $slideIndex transient attempt $a: ${_cleanErrMsg(e)}',
        ),
      );
      final jsonMap = _cleanAndDecodeJson(text);
      final slide = Slide.fromJson(jsonMap);
      return slide;
    } catch (e) {
      lastErr = e;
    }
    throw lastErr ?? Exception('Failed to generate custom slide $slideIndex.');
  }

  Future<String> _generateWithGroqFallback({
    required List<String> geminiModels,
    required List<String> geminiKeys,
    required List<Content> contents,
    required String slotName,
    GenerationConfig? generationConfig,
    List<SafetySetting>? safetySettings,
    Duration timeout = const Duration(minutes: 3),
    void Function(int attempt, Object err)? onRetry,
    String? systemInstruction,
  }) async {
    Object? lastErr;
    for (final modelName in geminiModels) {
      for (final apiKey in geminiKeys) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: generationConfig,
            safetySettings: safetySettings ?? const [],
            systemInstruction: systemInstruction != null ? Content.system(systemInstruction) : null,
          );
          final response = await _retryTransient(
            () => model.generateContent(contents).timeout(timeout),
            onRetry: onRetry,
          );
          final text = response.text;
          if (text == null || text.trim().isEmpty) {
            throw Exception('Empty response from model $modelName');
          }
          return text;
        } catch (e) {
          lastErr = e;
        }
      }
    }

    // Google Gemini failed! Fall back to Groq, then Cerebras, then OpenRouter
    print('[AiService] Google Gemini failed ($lastErr). Falling back to Groq...');
    final buffer = StringBuffer();
    List<Uint8List> attachedImages = [];
    for (final c in contents) {
      for (final p in c.parts) {
        if (p is TextPart) {
          buffer.writeln(p.text);
        } else if (p is DataPart) {
          attachedImages.add(p.bytes);
        }
      }
    }
    final promptText = buffer.toString();

    Object? groqErr;
    try {
      return await _callGroq(
        prompt: promptText,
        slotName: slotName,
        responseJson: generationConfig?.responseMimeType == 'application/json',
        attachedImages: attachedImages.isNotEmpty ? attachedImages : null,
        systemPrompt: systemInstruction,
      );
    } catch (e) {
      groqErr = e;
      print('[AiService] Groq fallback failed: $e. Falling back to Cerebras...');
    }

    Object? cerebrasErr;
    try {
      return await _callCerebras(
        prompt: promptText,
        slotName: slotName,
        responseJson: generationConfig?.responseMimeType == 'application/json',
        attachedImages: attachedImages.isNotEmpty ? attachedImages : null,
        systemPrompt: systemInstruction,
      );
    } catch (e) {
      cerebrasErr = e;
      print('[AiService] Cerebras fallback failed: $e. Falling back to OpenRouter...');
    }

    try {
      return await _callOpenRouter(
        prompt: promptText,
        slotName: slotName,
        responseJson: generationConfig?.responseMimeType == 'application/json',
        attachedImages: attachedImages.isNotEmpty ? attachedImages : null,
        systemPrompt: systemInstruction,
      );
    } catch (openRouterErr) {
      print('[AiService] OpenRouter fallback failed: $openRouterErr');
      throw lastErr ?? groqErr ?? cerebrasErr ?? openRouterErr;
    }
  }

  Future<GenerateContentResponse> _generateContentWithTiming({
    required GenerativeModel model,
    required String modelName,
    required List<Content> contents,
    required String? targetId,
    String? requestType,
    GenerationConfig? generationConfig,
  }) async {
    final startTime = DateTime.now();
    int payloadSize = 0;
    for (final c in contents) {
      for (final p in c.parts) {
        if (p is TextPart) {
          payloadSize += p.text.length;
        } else if (p is DataPart) {
          payloadSize += p.bytes.length;
        }
      }
    }

    // Estimate duration
    final double estSecs = AiEstimator.estimateDurationSync(
      modelName,
      payloadSize,
    );
    final estDuration = Duration(milliseconds: (estSecs * 1000).toInt());

    // Register active request if targetId is provided
    if (targetId != null) {
      final info = ActiveRequestInfo(
        startTime: startTime,
        estimatedDuration: estDuration,
        label: requestType ?? 'AI processing',
      );
      AiEstimator.activeRequests[targetId] = info;
      AiEstimator.onRegisterActiveRequest?.call(targetId, info);
    }

    try {
      // Find keys for fallback
      final prefs = await SharedPreferences.getInstance();
      List<String> keys = prefs.getStringList('gemini_api_keys_list') ?? [];
      if (keys.isEmpty) {
        final keysString = prefs.getString('gemini_api_keys') ?? '';
        keys = keysString.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
      }
      if (keys.isEmpty) {
        keys = await SecretsService.instance.geminiKeys();
      }

      // Try with fallback logic
      final text = await _generateWithGroqFallback(
        geminiModels: [modelName],
        geminiKeys: keys,
        contents: contents,
        slotName: requestType == 'Lesson Content Generation' || requestType == 'Slide Generation' ? 'Primary - Text' : 'Lite',
        generationConfig: generationConfig,
      );

      final endTime = DateTime.now();
      final actualDuration = endTime.difference(startTime);

      // Record timing
      await AiEstimator.recordRequest(
        modelName,
        payloadSize,
        actualDuration,
        requestType: requestType,
      );

      return GenerateContentResponse([
        Candidate(Content.model([TextPart(text)]), null, null, null, null)
      ], null);
    } finally {
      if (targetId != null) {
        AiEstimator.activeRequests.remove(targetId);
        AiEstimator.onUnregisterActiveRequest?.call(targetId);
      }
    }
  }

  Future<List<String>> analyzePrerequisites({
    required Unit targetUnit,
    required Book targetBook,
    required List<Book> allBooks,
    String? forcedApiKey,
  }) async {
    final List<String> availableStrings = [];
    for (final book in allBooks) {
      for (final module in book.modules) {
        for (final section in module.sections) {
          for (final unit in section.units) {
            if (book.id == targetBook.id && unit.id == targetUnit.id) {
              continue;
            }
            final String uniqueId =
                '${book.id}::${module.id}::${section.id}::${unit.id}';
            availableStrings.add(
              '- Book: "${book.title}", Module: "${module.title}", Section: "${section.title}", Unit: "${unit.title}" (ID: $uniqueId)',
            );
          }
        }
      }
    }

    if (availableStrings.isEmpty) return [];

    final buffer = StringBuffer();
    for (final s in availableStrings) {
      buffer.writeln(s);
    }

    final prompt =
        """
You are an educational planner. Identify which of the available units are direct prerequisites (must-know concepts) for the target unit.
Only return units that are genuinely necessary to understand the target concept.

Target Unit:
- Book/Course: "${targetBook.title}"
- Unit Title: "${targetUnit.title}"
- Description: "${targetUnit.description}"

Available Units in Other Courses:
${buffer.toString()}

Return a JSON array of the IDs of the matched units.
Example output:
["book1::mod1::sec1::unit1", "book2::mod3::sec2::unit4"]
If there are no prerequisites, return an empty array: [].
Do not output markdown code fences, comments, or any extra text. Just the plain JSON array.
""";

    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final liteModels = await _getLiteModels();

    for (final modelName in liteModels) {
      for (final apiKey in keys) {
        try {
          final model = GenerativeModel(model: modelName, apiKey: apiKey);
          final response = await model
              .generateContent([Content.text(prompt)])
              .timeout(const Duration(seconds: 30));
          final text = response.text?.trim() ?? '';
          if (text.isEmpty) continue;

          final cleanText = text
              .replaceAll('```json', '')
              .replaceAll('```', '')
              .trim();
          final List<dynamic> decoded = jsonDecode(cleanText);
          return decoded.cast<String>();
        } catch (e) {
          print('[AiService] analyzePrerequisites error: $e');
        }
      }
    }
    return [];
  }

  Future<Map<String, dynamic>> analyzeDescriptiveAnswer({
    required String question,
    required String userAnswer,
    required List<File> attachedPhotos,
    String? forcedApiKey,
  }) async {
    await _checkPause();
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final liteModels = await _getLiteModels();

    final prompt =
        '''You are an expert grading assistant.
Below is a descriptive question from a lesson, followed by the user's answer (which may consist of text and optional uploaded images/photos).
Analyze the user's answer and determine if it is correct. Be constructive but accurate.

QUESTION:
$question

USER ANSWER (TEXT):
$userAnswer

Determine if the user's answer correctly answers the question.
If the user also provided photos/images, they are attached to this request. Use them to evaluate the correctness of the answer.

Return ONLY a JSON object matching this schema:
{
  "isCorrect": true, // or false
  "feedback": "Constructive explanation of why it is correct or incorrect, pointing out any gaps or errors."
}''';

    final fileParts = await _buildFileParts(attachedPhotos);
    final parts = <Part>[TextPart(prompt), ...fileParts];

    Exception? lastException;
    for (var modelName in liteModels) {
      for (var apiKey in keys) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
            ),
          );

          final response = await _retryTransient(
            () => model
                .generateContent([Content.multi(parts)])
                .timeout(const Duration(seconds: 25)),
            onRetry: (a, e) => print(
              '[AiService] Descriptive analysis transient ($modelName) attempt $a: ${_cleanErrMsg(e)}',
            ),
          );

          if (response.text != null) {
            final jsonMap = _cleanAndDecodeJson(response.text!);
            return Map<String, dynamic>.from(jsonMap);
          }
        } catch (e) {
          lastException = Exception(
            'Descriptive analysis failed ($modelName): ${_cleanErrMsg(e)}',
          );
        }
      }
    }
    throw lastException ?? Exception('Failed to analyze descriptive answer.');
  }

  Future<List<Map<String, String>>?> extractSyllabusBooks(
    String syllabusText, {
    String? forcedApiKey,
  }) async {
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getLiteModels();

    String truncatedText = syllabusText;
    if (truncatedText.length > 30000) {
      truncatedText = truncatedText.substring(0, 30000);
    }

    final prompt =
        '''
Analyze the following text extracted from a syllabus.
Identify all reference books, textbooks, or reading materials mentioned in the course syllabus.
Look for titles and authors, even if they are only partially mentioned (e.g. only title or only author).
Be generous in extracting any book recommendations.

Return strictly in JSON format as a list of objects under the key "books":
{
  "books": [
    {"title": "Book Title", "authors": "Author name(s)"}
  ]
}
If no books are found, return:
{
  "books": []
}

Syllabus text:
$truncatedText
''';

    for (var key in keys) {
      for (var modelName in modelsToTry) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: key,
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
            ),
          );
          final response = await _retryTransient(
            () => model
                .generateContent([Content.text(prompt)])
                .timeout(const Duration(minutes: 2)),
            onRetry: (a, e) => print(
              '[AiService] Syllabus book extraction attempt $a: ${_cleanErrMsg(e)}',
            ),
          );

          if (response.text != null) {
            print(
              '[AiService] Syllabus book extraction response: ${response.text}',
            );
            final jsonMap = _cleanAndDecodeJson(response.text!);
            List? booksList;
            if (jsonMap['books'] is List) {
              booksList = jsonMap['books'] as List;
            } else {
              for (final val in jsonMap.values) {
                if (val is List && val.isNotEmpty && val.first is Map) {
                  booksList = val;
                  break;
                }
              }
            }

            if (booksList != null) {
              return booksList.map((e) {
                final map = Map<String, dynamic>.from(e as Map);
                return {
                  'title': map['title']?.toString() ?? '',
                  'authors': map['authors']?.toString() ?? '',
                };
              }).toList();
            }
          }
        } catch (e) {
          print('[AiService] extractSyllabusBooks failed with $modelName: $e');
        }
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> verifyPageRole(
    String pageText,
    int pageNumber, {
    String? apiKey,
  }) async {
    final keys = await _getKeys(forcedApiKey: apiKey);
    final modelsToTry = await _getLiteModels();

    final prompt =
        '''
Analyze the following text from page $pageNumber of a textbook.
Determine if this page is:
1. Part of the Table of Contents (Contents / TOC).
2. The exact page where the content of Chapter 1 (or the first main content chapter) starts.

Respond strictly in JSON format:
{
  "isContentsPage": true/false,
  "isChapter1Start": true/false
}

Page Text:
$pageText
''';

    for (var key in keys) {
      for (var modelName in modelsToTry) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: key,
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
            ),
          );
          final response = await _retryTransient(
            () => model
                .generateContent([Content.text(prompt)])
                .timeout(const Duration(seconds: 30)),
            onRetry: (a, e) =>
                print('[AiService] Page role verification attempt $a: $e'),
          );
          if (response.text != null) {
            return _cleanAndDecodeJson(response.text!);
          }
        } catch (e) {
          print('[AiService] verifyPageRole error with $modelName: $e');
        }
      }
    }
    return null;
  }

  /// Final cleanup pass over an auto-detected index result. Returns
  /// `{'indexPages': List, 'chapter1StartPage': int}` or null on failure.
  /// Callers must sanity-check the reply; a null return is non-fatal.
  Future<Map<String, dynamic>?> optimizeIndexResult(
    String tocText,
    List<int> indexPages,
    int? chapter1StartPage,
    int pageCount, {
    String? apiKey,
  }) async {
    final keys = await _getKeys(forcedApiKey: apiKey);
    final modelsToTry = await _getLiteModels();

    final prompt =
        '''
A textbook PDF has $pageCount pages. Automatic analysis detected:
- Table of contents on absolute PDF pages: $indexPages
- Chapter 1 content starting on absolute PDF page: $chapter1StartPage

Below is the extracted text of the detected table-of-contents pages. Verify and, if needed, correct the detection:
- Remove pages that are clearly not part of the table of contents.
- chapter1StartPage must be AFTER the last table-of-contents page and within 1..$pageCount.

Respond strictly in JSON format:
{
  "indexPages": [list of ints],
  "chapter1StartPage": int
}

Table of contents text:
$tocText
''';

    for (var key in keys) {
      for (var modelName in modelsToTry) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: key,
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
            ),
          );
          final response = await _retryTransient(
            () => model
                .generateContent([Content.text(prompt)])
                .timeout(const Duration(seconds: 30)),
            onRetry: (a, e) =>
                print('[AiService] optimizeIndexResult attempt $a: $e'),
          );
          if (response.text != null) {
            return _cleanAndDecodeJson(response.text!);
          }
        } catch (e) {
          print('[AiService] optimizeIndexResult error with $modelName: $e');
        }
      }
    }
    return null;
  }

  Future<bool> verifySectionMapping(
    String pageText,
    int pageNumber,
    String sectionTitle,
    String sectionDescription, {
    String? apiKey,
  }) async {
    final keys = await _getKeys(forcedApiKey: apiKey);
    final modelsToTry = await _getLiteModels();

    final prompt =
        '''
Analyze the text of page $pageNumber from the textbook.
We want to verify if this page corresponds to the start of the following section:
Section Title: "$sectionTitle"
Section Description: "$sectionDescription"

Answer with a JSON object:
{
  "isMatch": true/false
}
Set "isMatch" to true if this page indeed discusses, introduces, or contains the start of this section's topic. Set to false if it does not.

Page Text:
$pageText
''';

    for (var key in keys) {
      for (var modelName in modelsToTry) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: key,
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
            ),
          );
          final response = await _retryTransient(
            () => model
                .generateContent([Content.text(prompt)])
                .timeout(const Duration(seconds: 30)),
            onRetry: (a, e) => print(
              '[AiService] Section mapping verification attempt $a: $e',
            ),
          );
          if (response.text != null) {
            final decoded = _cleanAndDecodeJson(response.text!);
            return decoded['isMatch'] == true;
          }
        } catch (e) {
          print('[AiService] verifySectionMapping error with $modelName: $e');
        }
      }
    }
    return false;
  }

  Future<bool> verifyFirstChunkMatch(
    String chunkText,
    String topicTitle,
    String topicDescription, {
    String? apiKey,
  }) async {
    final keys = await _getKeys(forcedApiKey: apiKey);
    final modelsToTry = await _getLiteModels();

    final prompt = '''
Analyze the text of the first page(s) of a book chunk.
We want to verify if this text matches the mapped topic:
Topic Title: "$topicTitle"
Topic Description: "$topicDescription"

Answer with a JSON object:
{
  "isMatch": true/false
}
Set "isMatch" to true if the text discusses, introduces, or corresponds to this topic. Set "isMatch" to false if the text does not contain or correspond to this topic (meaning the page mapping is incorrect or shifted).

Text:
$chunkText
''';

    for (var key in keys) {
      for (var modelName in modelsToTry) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: key,
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
            ),
          );
          final response = await _retryTransient(
            () => model
                .generateContent([Content.text(prompt)])
                .timeout(const Duration(seconds: 30)),
            onRetry: (a, e) => print(
              '[AiService] First chunk verification attempt $a: $e',
            ),
          );
          if (response.text != null) {
            final decoded = _cleanAndDecodeJson(response.text!);
            return decoded['isMatch'] == true;
          }
        } catch (e) {
          print('[AiService] verifyFirstChunkMatch error with $modelName: $e');
        }
      }
    }
    return false;
  }

  Future<int?> matchSyllabusBookToMarketplace({
    required String syllabusBookTitle,
    required String syllabusBookAuthors,
    required List<Map<String, String>> candidateBooks,
    String? apiKey,
  }) async {
    if (candidateBooks.isEmpty) return null;

    final keys = await _getKeys(forcedApiKey: apiKey);
    final modelsToTry = await _getLiteModels();

    final candidateListString = candidateBooks
        .asMap()
        .entries
        .map((e) {
          return 'Index: ${e.key} | Title: "${e.value['title']}" | Author: "${e.value['author']}"';
        })
        .join('\n');

    final prompt =
        '''
We are trying to match a reference book mentioned in a syllabus to a textbook in our database.
Target Syllabus Book:
Title: "$syllabusBookTitle"
Authors: "$syllabusBookAuthors"

Database Candidate Books:
$candidateListString

Identify which database candidate book is the correct match for our target syllabus book.
Look past minor typos, spelling variations, formatting differences, extra tags, edition numbers, or trailing symbols (e.g. "Mathematical ANlysis&29198271" is a match for "Mathematical Analysis").
If a matching book is found, return the Index number of that candidate.
If no book in the candidate list is a match, return -1.

Respond strictly in JSON format:
{
  "matchIndex": [Index number or -1]
}
''';

    for (var key in keys) {
      for (var modelName in modelsToTry) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: key,
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
            ),
          );
          final response = await _retryTransient(
            () => model
                .generateContent([Content.text(prompt)])
                .timeout(const Duration(seconds: 25)),
            onRetry: (a, e) =>
                print('[AiService] Syllabus book matching attempt $a: $e'),
          );
          if (response.text != null) {
            final decoded = _cleanAndDecodeJson(response.text!);
            final idx = decoded['matchIndex'];
            if (idx is int && idx >= 0 && idx < candidateBooks.length) {
              return idx;
            }
          }
        } catch (e) {
          print(
            '[AiService] matchSyllabusBookToMarketplace error with $modelName: $e',
          );
        }
      }
    }
    return null;
  }

  Future<List<QuickReviewItem>> generateQuickReviewForModule(
    Module module, {
    String? forcedApiKey,
  }) async {
    await _checkPause();
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getLiteModels();

    // Extract text from sections
    String textContent = '';
    for (final sec in module.sections) {
      if (sec.pdfPath != null && File(sec.pdfPath!).existsSync()) {
        try {
          final text = await PdfService().extractTextFromPdf(
            File(sec.pdfPath!),
          );
          if (text.trim().isNotEmpty) {
            textContent += '\n\n--- SECTION: ${sec.title} ---\n$text';
          }
        } catch (e) {
          print('Error extracting text for section ${sec.title}: $e');
        }
      }
    }

    // Fallback if no text extracted
    if (textContent.trim().isEmpty) {
      textContent =
          'Module Title: ${module.title}\nDescription: ${module.description}\n';
      for (final sec in module.sections) {
        textContent +=
            '\nSection: ${sec.title}\nDescription: ${sec.description}\n';
        for (final unit in sec.units) {
          textContent += ' - Unit: ${unit.title}\n';
          for (final lesson in unit.lessons) {
            textContent += '   - Lesson: ${lesson.title}\n';
          }
        }
      }
    }

    // Limit text size to avoid exceeding context window (e.g. max ~120k chars)
    if (textContent.length > 120000) {
      textContent = textContent.substring(0, 120000) + '... [truncated]';
    }

    final prompt =
        '''You are an expert academic assistant.
Your task is to generate a comprehensive "Quick Review" sheet for a study module.
Based on the textbook/course content provided below, extract a list of key theory statements, definitions, laws, principles, and equations.

CRITICAL RULES:
1. INCLUDE KEY EQUATIONS: Always include the mathematical equations associated with the concepts. Format them in LaTeX (e.g., using \$...\$ or \$\$...\$\$).
2. EXCLUDE PROOFS: Do NOT include long proofs, derivations, derivations steps, or exercises.
3. CONCISE STATEMENTS: Keep each statement clear, factual, and concise (1-3 sentences).
4. ASSIGN RELATED LESSON TITLE: For each statement, specify the title of the most relevant lesson/subtopic from the module (e.g., "First Law of Thermodynamics"). This will help map the statement back to the lesson.

CONTENT:
$textContent

Return ONLY a JSON array of objects matching this exact schema:
[
  {
    "statement": "The First Law of Thermodynamics states that the change in internal energy of a system is equal to the heat added minus the work done: \$\\Delta U = Q - W\$.",
    "relatedLessonTitle": "First Law of Thermodynamics"
  }
]
''';

    for (var key in keys) {
      for (var modelName in modelsToTry) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: key,
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
            ),
          );
          final response = await _retryTransient(
            () => model
                .generateContent([Content.text(prompt)])
                .timeout(const Duration(seconds: 45)),
            onRetry: (a, e) =>
                print('[AiService] Quick review generation attempt $a: $e'),
          );
          if (response.text != null) {
            final decoded = jsonDecode(_cleanJsonText(response.text!));
            if (decoded is List) {
              return decoded
                  .map(
                    (item) => QuickReviewItem.fromJson(
                      Map<String, dynamic>.from(item),
                    ),
                  )
                  .toList();
            }
          }
        } catch (e) {
          print(
            '[AiService] generateQuickReviewForModule error with $modelName: $e',
          );
        }
      }
    }
    return [];
  }

  Future<String> explainQuickReviewStatement(
    String statement,
    String contextInfo, {
    String? forcedApiKey,
  }) async {
    await _checkPause();
    final keys = await _getKeys(forcedApiKey: forcedApiKey);
    final modelsToTry = await _getLiteModels();

    final prompt =
        '''You are an expert tutor.
Explain the following concept/statement in detail.
Provide a clear, intuitive explanation in 2-3 paragraphs.
Explain any equations, variables, physical/mathematical meaning, and a real-world application if relevant.
Use clean markdown formatting. Format equations in LaTeX (e.g. using \$...\$ or \$\$...\$\$).

STATEMENT TO EXPLAIN:
$statement

CONTEXT/TOPIC:
$contextInfo

Return ONLY the markdown explanation.
''';

    for (var key in keys) {
      for (var modelName in modelsToTry) {
        try {
          final model = GenerativeModel(model: modelName, apiKey: key);
          final response = await _retryTransient(
            () => model
                .generateContent([Content.text(prompt)])
                .timeout(const Duration(seconds: 25)),
            onRetry: (a, e) =>
                print('[AiService] Statement explanation attempt $a: $e'),
          );
          if (response.text != null) {
            return response.text!.trim();
          }
        } catch (e) {
          print(
            '[AiService] explainQuickReviewStatement error with $modelName: $e',
          );
        }
      }
    }
    return 'Failed to generate explanation. Please check your internet connection and API keys.';
  }

  String _cleanJsonText(String text) {
    return text.replaceAll('```json', '').replaceAll('```', '').trim();
  }
}

class UnitManifestResult {
  final List<Unit> units;
  final List<LessonFormat> newFormats;

  UnitManifestResult({required this.units, required this.newFormats});
}
