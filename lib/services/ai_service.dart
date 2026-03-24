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
      print("[AiService] FATAL: No API Keys configured.");
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

  Map<String, dynamic> _cleanAndDecodeJson(String text) {
    print("[AiService] Initiating JSON Cleanup and Decoding...");
    String cleaned = text;
    if (cleaned.contains('```json')) {
      cleaned = cleaned.split('```json')[1].split('```')[0];
    } else if (cleaned.contains('```')) {
      cleaned = cleaned.split('```')[1].split('```')[0];
    }
    
    cleaned = cleaned.trim();
    int start = cleaned.indexOf('{');
    int end = cleaned.lastIndexOf('}');
    
    if (start != -1 && end != -1) {
      cleaned = cleaned.substring(start, end + 1);
    }
    
    try {
      final decoded = jsonDecode(cleaned);
      if (decoded is! Map<String, dynamic>) {
        throw Exception('Expected a JSON Object (Map), but got ${decoded.runtimeType}.');
      }
      return decoded;
    } catch (e1) {
      print("[AiService] Initial parse failed. Trying fallback cleanup... $e1");
      try {
        String agg = cleaned.replaceAll('\n', '\\n').replaceAll('\r', '');
        return jsonDecode(agg) as Map<String, dynamic>;
      } catch (e2) {
        throw Exception('Failed to parse AI JSON response: $e2');
      }
    }
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

  Future<Book?> generateBookSkeleton(List<File> inputFiles, String filename, String? userPrompt) async {
    print("\n[AiService] === STARTING STAGE 1: BOOK SKELETON GENERATION ===");
    final keys = await _getKeys();
    final models = await _getModels();
    
    final rawPrompt = await PromptService.getSkeletonPrompt();
    final hydratedPrompt = rawPrompt
        .replaceAll('%filename%', filename)
        .replaceAll('%user_prompt%', userPrompt ?? 'None');
    
    List<Part> parts = [TextPart(hydratedPrompt)];
    parts.addAll(await _buildFileParts(inputFiles));

    Exception? lastException;
    
    for (var modelName in models) {
      for (var apiKey in keys) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(responseMimeType: 'application/json'),
          );

          final response = await model.generateContent([
            Content.multi(parts)
          ]).timeout(const Duration(minutes: 5));

          if (response.text != null) {
            final jsonMap = _cleanAndDecodeJson(response.text!);
            return Book.fromJson(jsonMap);
          }
        } on TimeoutException {
          lastException = Exception('Request timed out ($modelName).');
        } catch (e) {
          lastException = Exception('Generation failed: $e');
        }
      }
    }
    throw lastException ?? Exception('Failed to generate skeleton. All models/keys exhausted.');
  }

  Future<Unit> generateUnitContent(Unit unit, Book bookContext, Function(String) onProgress) async {
    final keys = await _getKeys();
    final models = await _getModels();
    
    if (unit.pdfPath == null) throw Exception("No PDF/Image chunk available for this unit.");
    final chunkFile = File(unit.pdfPath!);
    if (!chunkFile.existsSync()) {
      throw Exception("Local file missing. Tap 'Restore' on the warning banner to re-link source files.");
    }

    Exception? lastException;

    for (var modelName in models) {
      for (var apiKey in keys) {
        try {
          final modelText = GenerativeModel(model: modelName, apiKey: apiKey);
          final modelJson = GenerativeModel(model: modelName, apiKey: apiKey, generationConfig: GenerationConfig(responseMimeType: 'application/json'));

          onProgress("Analyzing PDF & Planning Layout...");
          
          final rawPlanPrompt = await PromptService.getPlanPrompt();
          final hydratedPlanPrompt = rawPlanPrompt.replaceAll('%unit_title%', unit.title);
          
          List<Part> planParts = [TextPart(hydratedPlanPrompt)];
          planParts.addAll(await _buildFileParts([chunkFile]));

          final planResponse = await modelText.generateContent([
            Content.multi(planParts)
          ]).timeout(const Duration(minutes: 4));

          final lessonPlan = planResponse.text ?? '';
          if (lessonPlan.isEmpty) throw Exception("AI failed to generate a lesson plan.");
          
          onProgress("Generating Interactive Content...");

          final rawJsonPrompt = await PromptService.getJsonPrompt();
          final hydratedJsonPrompt = rawJsonPrompt
              .replaceAll('%system_prompt%', bookContext.systemPrompt ?? "You are an expert tutor.")
              .replaceAll('%unit_title%', unit.title)
              .replaceAll('%lesson_plan%', lessonPlan);

          List<Part> jsonParts = [TextPart(hydratedJsonPrompt)];
          jsonParts.addAll(await _buildFileParts([chunkFile]));

          final response = await modelJson.generateContent([
            Content.multi(jsonParts)
          ]).timeout(const Duration(minutes: 5));

          if (response.text != null) {
            onProgress("Parsing content...");
            final jsonMap = _cleanAndDecodeJson(response.text!);
            final lessonsData = jsonMap['lessons'] as List?;
            
            final newLessons = lessonsData?.map((l) {
              if (l is Map) {
                var lesson = Lesson.fromJson(Map<String, dynamic>.from(l));
                final uniqueLessonId = '${unit.id}-${lesson.id}';
                return lesson.copyWith(
                  id: uniqueLessonId,
                  slides: lesson.slides.map((s) => s.copyWith(id: '$uniqueLessonId-${s.id}')).toList()
                );
              }
              return null;
            }).whereType<Lesson>().toList() ?? [];
            
            return unit.copyWith(isGenerated: true, lessons: newLessons);
          }
        } catch (e) {
          lastException = Exception('Failed: $e');
        }
      }
    }
    throw lastException ?? Exception('Failed to generate unit content. All models/keys exhausted.');
  }

  Future<QuestionPaper> generateQuestionPaper(List<File> files, String qpTitle, String? systemPrompt, String? userPrompt) async {
    print("\n[AiService] === STARTING QP GENERATION ===");
    final keys = await _getKeys();
    final models = await _getModels();

    final rawPrompt = await PromptService.getQpJsonPrompt();
    final hydratedPrompt = rawPrompt
        .replaceAll('%system_prompt%', systemPrompt ?? "You are an expert tutor.")
        .replaceAll('%user_prompt%', userPrompt ?? 'None');

    List<Part> parts = [TextPart(hydratedPrompt)];
    parts.addAll(await _buildFileParts(files));

    Exception? lastException;

    for (var modelName in models) {
      for (var apiKey in keys) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(responseMimeType: 'application/json'),
          );

          final response = await model.generateContent([
            Content.multi(parts)
          ]).timeout(const Duration(minutes: 6));

          if (response.text != null) {
            final jsonMap = _cleanAndDecodeJson(response.text!);
            final qp = QuestionPaper.fromJson(jsonMap);
            // Ensure Title fallback overrides
            return QuestionPaper(
                id: qp.id, 
                title: qpTitle.isNotEmpty ? qpTitle : qp.title, 
                slides: qp.slides
            );
          }
        } catch (e) {
          lastException = Exception('QP Generation failed: $e');
        }
      }
    }
    throw lastException ?? Exception('Failed to generate Question Paper.');
  }
}