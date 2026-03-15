import 'dart:convert';
import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';

class AiService {
  Future<Book?> generateBookFromPdf(File pdfFile, String title) async {
    final prefs = await SharedPreferences.getInstance();
    final keysString = prefs.getString('gemini_api_keys') ?? '';
    final modelName = prefs.getString('gemini_model') ?? 'gemini-1.5-flash';

    final keys = keysString.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    if (keys.isEmpty) {
      throw Exception('No API Keys configured. Please configure them in Settings.');
    }

    final pdfBytes = await pdfFile.readAsBytes();
    final prompt = TextPart(r'''
You are an expert curriculum designer. Convert the provided document into a structured JSON interactive lesson plan.
The app supports these slide types: 'theory', 'quiz', 'fill_in_blank', 'numerical', 'interactive_canvas'.
For 'interactive_canvas', generate RAW valid HTML/JS inside "interactiveCanvasHtml" that simulates the concept visually. Make sure the canvas resizes to the window. 
For 'fill_in_blank', format the question with `___` (three underscores) where the user should type the answer inline.
You MUST use LaTeX formatting inside Markdown by wrapping math in $ (inline) or $$ (block). Be careful to add spaces around $ symbols so they don't stick directly to underscores or punctuation.

The JSON must perfectly match this structure (return ONLY JSON):
{
  "id": "generated-book-id",
  "title": "Title Here",
  "description": "Auto-generated book",
  "icon": "Book",
  "modules": [
    {
      "id": "m-1",
      "title": "Module Title",
      "description": "Module Desc",
      "practiceQuestions": [
        {
          "id": "pq-1",
          "type": "quiz",
          "title": "Practice Quiz",
          "content": "Question text...",
          "options": [
            {"id": "a", "text": "Option A", "isCorrect": true, "explanation": "Why"}
          ]
        }
      ],
      "examQuestions": [
        {
          "id": "eq-1",
          "type": "numerical",
          "title": "Exam Numerical",
          "content": "Calculate $x$...",
          "numericAnswer": 5,
          "numericTolerance": 0.1
        }
      ],
      "sections": [
        {
          "id": "s-1",
          "title": "Section Title",
          "description": "Section Desc",
          "color": "duo-green",
          "units": [
            {
              "id": "u-1",
              "title": "Unit Title",
              "description": "Unit Desc",
              "lessons": [
                {
                  "id": "l-1",
                  "title": "Lesson Title",
                  "description": "Lesson Desc",
                  "icon": "BookOpen",
                  "slides": [
                    {
                      "id": "sl-1",
                      "type": "theory",
                      "title": "Slide Title",
                      "content": "Markdown text with $ math $..."
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
''');

    Exception? lastException;

    for (var apiKey in keys) {
      try {
        final model = GenerativeModel(
          model: modelName,
          apiKey: apiKey,
          generationConfig: GenerationConfig(responseMimeType: 'application/json'),
        );

        final response = await model.generateContent([
          Content.multi([
            prompt,
            DataPart('application/pdf', pdfBytes),
          ])
        ]);

        if (response.text != null) {
          final Map<String, dynamic> jsonMap = jsonDecode(response.text!);
          return Book.fromJson(jsonMap);
        }
      } catch (e) {
        print('Key $apiKey failed: $e');
        lastException = Exception('Failed with key: $e');
      }
    }

    throw lastException ?? Exception('Failed to generate book.');
  }
}