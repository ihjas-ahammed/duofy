import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';

class AiService {
  Future<List<String>> _getKeys() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs.getStringList('gemini_api_keys_list') ?? [];
    if (keys.isEmpty) {
      final keysString = prefs.getString('gemini_api_keys') ?? '';
      keys = keysString.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    if (keys.isEmpty) throw Exception('No API Keys configured.');
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
    
    // Fallback sanitation: Escape any unescaped backslashes outside of valid JSON quotes
    // This is a common issue when AI outputs raw \n instead of \\n
    cleaned = cleaned.replaceAll(r'\"', r'\\"').replaceAll(r'\n', r'\\n');
    
    try {
      final decoded = jsonDecode(cleaned);
      if (decoded is! Map<String, dynamic>) {
        throw Exception('Expected a JSON Object (Map), but got ${decoded.runtimeType}.');
      }
      return decoded;
    } catch (e) {
      print("JSON Parse Error: $e\nPayload Segment: ${cleaned.substring(0, cleaned.length > 200 ? 200 : cleaned.length)}");
      throw Exception('Failed to parse AI JSON response: $e');
    }
  }

  /// STAGE 1: Extracts the table of contents and creates the Book Skeleton
  Future<Book?> generateBookSkeleton(File pdfFile, String title) async {
    final keys = await _getKeys();
    final models = await _getModels();
    final pdfBytes = await pdfFile.readAsBytes();
    
    final prompt = TextPart('''
You are an expert curriculum designer. Analyze the attached PDF document to create a high-level course skeleton.
You need to extract the Table of Contents and structure it into Modules -> Sections -> Units.

CRITICAL INSTRUCTIONS:
1. The `startPage` and `endPage` MUST refer to the ABSOLUTE PDF PAGE INDEX (1-based index where the absolute first page of the file is 1), NOT the printed page number.
2. In the custom `systemPrompt` string you generate, STRICTLY instruct the AI to use double-escaped backslashes for all LaTeX (e.g. \\\\frac instead of \\frac).

Return ONLY valid JSON matching this exact structure:
{
  "id": "generated-book-${DateTime.now().millisecondsSinceEpoch}",
  "title": "$title",
  "description": "Auto-generated book overview",
  "icon": "Book",
  "systemPrompt": "You are an expert tutor... Remember to double-escape LaTeX strings as \\\\frac ...",
  "modules":[
    {
      "id": "m-1",
      "title": "Module Title",
      "description": "Module Desc",
      "practiceQuestions": [],
      "examQuestions": [],
      "sections":[
        {
          "id": "s-1",
          "title": "Section Title",
          "description": "Section Desc",
          "color": "duo-green",
          "units":[
            {
              "id": "u-1",
              "title": "Unit Title",
              "description": "Unit Desc",
              "startPage": 1,
              "endPage": 10
            }
          ]
        }
      ]
    }
  ]
}
''');

    Exception? lastException;
    
    // Cycle models, then cycle keys
    for (var modelName in models) {
      for (var apiKey in keys) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(responseMimeType: 'application/json'),
          );

          final response = await model.generateContent([
            Content.multi([prompt, DataPart('application/pdf', pdfBytes)])
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

  /// STAGE 2: Generates deep lesson content for a specific chunked PDF Unit
  Future<Unit> generateUnitContent(Unit unit, Book bookContext) async {
    final keys = await _getKeys();
    final models = await _getModels();
    
    if (unit.pdfPath == null) throw Exception("No PDF chunk available for this unit.");
    final pdfBytes = await File(unit.pdfPath!).readAsBytes();

    final prompt = TextPart('''
SYSTEM PROMPT:
${bookContext.systemPrompt ?? "You are an expert tutor."}

TASK:
Generate interactive lesson content for the unit: "${unit.title}".
Rely on the provided attached PDF chunk.
You MUST use LaTeX formatting inside Markdown by wrapping math in \$ (inline) or \$\$ (block).
CRITICAL: All backslashes in LaTeX MUST be double-escaped for JSON compatibility (e.g., use \\\\frac{1}{2} instead of \\frac{1}{2}).

Return ONLY valid JSON representing the "lessons" array.
Format:
{
  "lessons": [
    {
      "id": "l-${DateTime.now().millisecondsSinceEpoch}-1",
      "title": "Lesson Title",
      "description": "Short Description",
      "icon": "BookOpen",
      "slides": [
        {
          "id": "sl-1",
          "type": "theory",
          "title": "Slide Title",
          "content": "Theory text here..."
        }
      ]
    }
  ]
}
''');

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
            Content.multi([prompt, DataPart('application/pdf', pdfBytes)])
          ]).timeout(const Duration(minutes: 5));

          if (response.text != null) {
            final jsonMap = _cleanAndDecodeJson(response.text!);
            final lessonsData = jsonMap['lessons'] as List?;
            final newLessons = lessonsData?.map((l) => Lesson.fromJson(Map<String, dynamic>.from(l))).toList() ?? [];
            
            return unit.copyWith(isGenerated: true, lessons: newLessons);
          }
        } on TimeoutException {
          lastException = Exception('Request timed out.');
        } catch (e) {
          lastException = Exception('Failed: $e');
        }
      }
    }
    throw lastException ?? Exception('Failed to generate unit content. All models/keys exhausted.');
  }
}