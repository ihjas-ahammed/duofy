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

  /// Robust JSON parser that handles Markdown ticks and invalid string literal types
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
      print("[AiService] JSON Decoded Successfully.");
      return decoded;
    } catch (e1) {
      print("[AiService] Initial parse failed. Trying fallback cleanup... $e1");
      try {
        // Fallback: fix literal unescaped newlines which AI might fail to properly escape
        String agg = cleaned.replaceAll('\n', '\\n').replaceAll('\r', '');
        return jsonDecode(agg) as Map<String, dynamic>;
      } catch (e2) {
        print("\n[AiService] JSON PARSE ERROR: $e2");
        print("[AiService] === PROBLEMATIC PAYLOAD SEGMENT ===");
        print(cleaned.substring(0, cleaned.length > 500 ? 500 : cleaned.length));
        print("=============================================\n");
        throw Exception('Failed to parse AI JSON response: $e2');
      }
    }
  }

  /// STAGE 1: Extracts the table of contents and creates the Book Skeleton
  Future<Book?> generateBookSkeleton(File pdfFile, String filename) async {
    print("\n[AiService] === STARTING STAGE 1: BOOK SKELETON GENERATION ===");
    final keys = await _getKeys();
    final models = await _getModels();
    final pdfBytes = await pdfFile.readAsBytes();
    
    final rawPrompt = await PromptService.getSkeletonPrompt();
    final hydratedPrompt = rawPrompt.replaceAll('%filename%', filename);
    
    final prompt = TextPart(hydratedPrompt);

    Exception? lastException;
    
    for (var modelName in models) {
      for (var apiKey in keys) {
        try {
          print("[AiService] Requesting Skeleton via $modelName [Key: ...${apiKey.substring(apiKey.length > 4 ? apiKey.length - 4 : 0)}]");
          
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(responseMimeType: 'application/json'),
          );

          final stopwatch = Stopwatch()..start();
          final response = await model.generateContent([
            Content.multi([prompt, DataPart('application/pdf', pdfBytes)])
          ]).timeout(const Duration(minutes: 5));
          stopwatch.stop();

          if (response.text != null) {
            print("[AiService] Skeleton Generation Success! Took ${stopwatch.elapsed.inSeconds} seconds.");
            final jsonMap = _cleanAndDecodeJson(response.text!);
            print("[AiService] === SKELETON GENERATION COMPLETE ===\n");
            return Book.fromJson(jsonMap);
          }
        } on TimeoutException {
          print("[AiService] Warning: Request timed out for $modelName.");
          lastException = Exception('Request timed out ($modelName).');
        } catch (e) {
          print("[AiService] Error using $modelName: $e");
          lastException = Exception('Generation failed: $e');
        }
      }
    }
    print("[AiService] FATAL: All models/keys exhausted for Skeleton generation.");
    throw lastException ?? Exception('Failed to generate skeleton. All models/keys exhausted.');
  }

  /// STAGE 2: Generates deep lesson content for a specific chunked PDF Unit
  Future<Unit> generateUnitContent(Unit unit, Book bookContext, Function(String) onProgress) async {
    print("\n[AiService] === STARTING UNIT CONTENT GENERATION (TWO-STAGE) ===");
    print("[AiService] Target Unit: ${unit.title}");
    
    final keys = await _getKeys();
    final models = await _getModels();
    
    if (unit.pdfPath == null) throw Exception("No PDF chunk available for this unit.");
    final pdfBytes = await File(unit.pdfPath!).readAsBytes();

    Exception? lastException;

    for (var modelName in models) {
      for (var apiKey in keys) {
        try {
          print("\n[AiService] Attempting generation pipeline with $modelName [Key: ...${apiKey.substring(apiKey.length > 4 ? apiKey.length - 4 : 0)}]");
          
          final modelText = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
          );
          
          final modelJson = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(responseMimeType: 'application/json'),
          );

          // ------------------------------------------------------------------
          // STEP 1: Lesson Planning (Text Generation)
          // ------------------------------------------------------------------
          print("[AiService] [Stage 2.1] Requesting Pedagogical Lesson Plan...");
          onProgress("Analyzing PDF & Planning Layout...");
          
          final rawPlanPrompt = await PromptService.getPlanPrompt();
          final hydratedPlanPrompt = rawPlanPrompt.replaceAll('%unit_title%', unit.title);
          
          final planPrompt = TextPart(hydratedPlanPrompt);

          final planStopwatch = Stopwatch()..start();
          final planResponse = await modelText.generateContent([
            Content.multi([planPrompt, DataPart('application/pdf', pdfBytes)])
          ]).timeout(const Duration(minutes: 4));
          planStopwatch.stop();

          final lessonPlan = planResponse.text ?? '';
          if (lessonPlan.isEmpty) throw Exception("AI failed to generate a lesson plan.");
          
          print("[AiService] [Stage 2.1] Lesson Plan Acquired in ${planStopwatch.elapsed.inSeconds}s.");

          // ------------------------------------------------------------------
          // STEP 2: JSON Instantiation
          // ------------------------------------------------------------------
          print("[AiService] [Stage 2.2] Requesting JSON Instantiation based on Plan...");
          onProgress("Generating Interactive Content...");

          final rawJsonPrompt = await PromptService.getJsonPrompt();
          final hydratedJsonPrompt = rawJsonPrompt
              .replaceAll('%system_prompt%', bookContext.systemPrompt ?? "You are an expert tutor.")
              .replaceAll('%unit_title%', unit.title)
              .replaceAll('%lesson_plan%', lessonPlan);

          final jsonPrompt = TextPart(hydratedJsonPrompt);

          final jsonStopwatch = Stopwatch()..start();
          final response = await modelJson.generateContent([
            Content.multi([jsonPrompt, DataPart('application/pdf', pdfBytes)])
          ]).timeout(const Duration(minutes: 5));
          jsonStopwatch.stop();

          if (response.text != null) {
            print("[AiService] [Stage 2.2] JSON Generation Success! Took ${jsonStopwatch.elapsed.inSeconds}s.");
            
            onProgress("Parsing content...");
            final jsonMap = _cleanAndDecodeJson(response.text!);
            final lessonsData = jsonMap['lessons'] as List?;
            
            final newLessons = lessonsData?.map((l) {
              if (l is Map) {
                var lesson = Lesson.fromJson(Map<String, dynamic>.from(l));
                // Ensure globally unique IDs across different unit generations
                final uniqueLessonId = '${unit.id}-${lesson.id}';
                return lesson.copyWith(
                  id: uniqueLessonId,
                  slides: lesson.slides.map((s) => s.copyWith(id: '$uniqueLessonId-${s.id}')).toList()
                );
              }
              return null;
            }).whereType<Lesson>().toList() ?? [];
            
            print("[AiService] === UNIT CONTENT GENERATION COMPLETE ===\n");
            return unit.copyWith(isGenerated: true, lessons: newLessons);
          }
        } on TimeoutException {
          print("[AiService] Warning: Request timed out for $modelName.");
          lastException = Exception('Request timed out ($modelName).');
        } catch (e) {
          print("[AiService] Error in pipeline using $modelName: $e");
          lastException = Exception('Failed: $e');
        }
      }
    }
    print("[AiService] FATAL: All models/keys exhausted for Unit generation.");
    throw lastException ?? Exception('Failed to generate unit content. All models/keys exhausted.');
  }
}