import 'dart:convert';
import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';

class AiService {
  Future<String?> getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('gemini_api_key');
  }

  Future<Book?> generateBookFromPdf(File pdfFile, String title) async {
    final apiKey = await getApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API Key not set. Please configure in Settings.');
    }

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );

    final pdfBytes = await pdfFile.readAsBytes();
    final prompt = TextPart('''
You are an expert curriculum designer. Convert the provided document into a structured JSON interactive lesson plan.
The JSON must perfectly match this structure (return ONLY JSON):
{
  "id": "generated-\$title",
  "title": "\$title",
  "description": "Auto-generated book",
  "icon": "Book",
  "modules": [
    {
      "id": "m-1",
      "title": "Module Title",
      "description": "Module Desc",
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
                      "content": "Markdown text..."
                    },
                    {
                      "id": "sl-2",
                      "type": "quiz",
                      "title": "Quiz Title",
                      "content": "Question here...",
                      "options": [
                        {"id": "a", "text": "Option A", "isCorrect": true, "explanation": "Why"}
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
  ]
}
''');

    try {
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
      print('AI Generation Error: \$e');
      throw Exception('Failed to generate book: \$e');
    }
    return null;
  }
}