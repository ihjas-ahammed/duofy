import 'package:shared_preferences/shared_preferences.dart';

class PromptService {
  static const String _kSkeleton = 'prompt_skeleton';
  static const String _kPlan = 'prompt_plan';
  static const String _kJson = 'prompt_json';
  static const String _kQpJson = 'prompt_qp_json';

  static const String defaultSkeleton = '''You are an expert curriculum designer. Analyze the attached document/images to create a high-level course skeleton.
The user uploaded a file named: "%filename%". 
User Custom Instructions (if any): "%user_prompt%"

CRITICAL INSTRUCTIONS:
1. Generate a suitable, professional `title` for this course based on the document content or the filename.
2. STRUCTURE HIERARCHY:
   - "modules" represent the main Chapters.
   - "sections" represent the subtopics within a chapter (e.g., 2.1, 2.2).
   - "units" go deeper into the specific topics within each section.
3. The `startPage` and `endPage` MUST refer to the ABSOLUTE PAGE INDEX (1-based index where the absolute first page of the file is 1). Ensure they accurately reflect logical splits.
4. In the custom `systemPrompt` string you generate, STRICTLY instruct the AI to use double-escaped backslashes for all LaTeX (e.g. \\\\frac instead of \\frac). Account for any specific tone requested in the User Custom Instructions.

Return ONLY valid JSON matching this exact structure:
{
  "id": "generated-book-123",
  "title": "Generated Course Title Here",
  "description": "Auto-generated book overview",
  "icon": "Book",
  "systemPrompt": "You are an expert tutor...",
  "modules":[
    {
      "id": "m1",
      "title": "Module Title",
      "description": "...",
      "sections": [
        {
          "id": "s1",
          "title": "Section Title",
          "description": "...",
          "color": "duo-blue",
          "units": [
            {
              "id": "u1",
              "title": "Unit Title",
              "description": "...",
              "startPage": 1,
              "endPage": 5
            }
          ]
        }
      ]
    }
  ]
}''';

  static const String defaultPlan = '''You are an expert curriculum designer. Analyze the attached chunk for the unit: "%unit_title%".
Design a pedagogical lesson plan in PLAIN TEXT (do NOT output JSON yet).
Break this unit down into multiple logical lessons based on the content.

CRITICAL DUOLINGO-STYLE MICRO-LEARNING RULES:
1. MAXIMIZE the number of lessons. Break concepts down into extremely bite-sized pieces.
2. For EACH lesson, list the exact sequence of slides.
3. Theory/Concepts MUST be split across many small slides. NO MORE than 1-3 sentences per slide!
4. Each lesson must contain:
   - Several short Theory slides.
   - 1 "interactive_canvas" slide that uses a 2D canvas to visually animate/illustrate the theory.
   - 2 "fill_in_blank" slides (one question per slide).
   - 4 "quiz" (multiple choice) objective questions (one question per slide).
   - 1 "numerical" slide (if applicable, calculating a value).
   - 1 "proof" or "step_by_step" interactive solution (ONE combined slide mapping the multiple stages of the problem).''';

  static const String defaultJson = '''SYSTEM PROMPT:
%system_prompt%

TASK:
You previously created this optimal learning plan for the unit "%unit_title%":
%lesson_plan%

Based strictly on this plan and the attached content chunk, generate the full JSON content.

CRITICAL SCHEMA & MICRO-LEARNING RULES:
1. "theory" slides: `content` MUST be a few sentences explaining a concept.
2. "interactive_canvas" slides: `content` MUST be the theory explanation. `interactiveCanvasHtml` MUST contain ONLY the raw HTML `<canvas id="myCanvas"></canvas>` and `<script>` that draws an engaging, responsive 2D visualization of the topic.
3. "quiz" slides: `content` MUST CONTAIN THE ACTUAL QUESTION TEXT. Do not leave it empty! Provide exactly 4 `options`. Make sure exactly one option has `isCorrect: true`.
4. "fill_in_blank" slides: `content` MUST contain the question with exactly three underscores (`___`). `blankAnswer` is the exact word. Include an array of 3 `blankDistractors` (wrong words) for the user to choose from.
5. "step_by_step" or "proof" slides: `content` is the overall problem statement. `interactiveSteps` is an array mapping the stages. An interactive step can be static (`stepText` only) or a question (`prompt` and `options`).
6. LaTeX formatting must be double-escaped (e.g., \\\\frac{1}{2}). Markdown math is wrapped in \$ or \$\$.

YOU MUST RETURN ONLY VALID JSON MATCHING THIS EXACT STRUCTURE:
{
  "lessons": [
    {
      "id": "l1", "title": "Lesson 1", "description": "...", "icon": "BookOpen",
      "slides": [ ... ]
    }
  ]
}''';

  static const String defaultQpJson = '''SYSTEM PROMPT:
%system_prompt%

User Custom Instructions (if any): "%user_prompt%"

TASK:
Analyze the attached Question Paper (PDF or Images). 
Extract each question, solve it step-by-step, and convert it into interactive learning slides based on the user's custom instructions if provided.

RULES:
1. Create a "step_by_step" or "numerical" or "quiz" slide for each question depending on its nature.
2. Break down large math proofs into `interactiveSteps`.
3. Ensure accurate math using double-escaped LaTeX (e.g. \\\\frac).
4. Return ONLY valid JSON matching this schema:
{
  "id": "qp1",
  "title": "Extracted Past Paper Title",
  "slides": [ 
      {
         "id": "s1", "type": "step_by_step", "title": "Q1", "content": "The original question...", "interactiveSteps": [...]
      }
  ]
}''';

  // Loaders
  static Future<String> getSkeletonPrompt() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kSkeleton) ?? defaultSkeleton;
  }

  static Future<String> getPlanPrompt() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kPlan) ?? defaultPlan;
  }

  static Future<String> getJsonPrompt() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kJson) ?? defaultJson;
  }

  static Future<String> getQpJsonPrompt() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kQpJson) ?? defaultQpJson;
  }

  // Savers
  static Future<void> saveSkeletonPrompt(String text) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kSkeleton, text.trim());
  }

  static Future<void> savePlanPrompt(String text) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kPlan, text.trim());
  }

  static Future<void> saveJsonPrompt(String text) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kJson, text.trim());
  }

  static Future<void> resetToDefaults() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kSkeleton);
    await prefs.remove(_kPlan);
    await prefs.remove(_kJson);
    await prefs.remove(_kQpJson);
  }
}