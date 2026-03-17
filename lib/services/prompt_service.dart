import 'package:shared_preferences/shared_preferences.dart';

class PromptService {
  static const String _kSkeleton = 'prompt_skeleton';
  static const String _kPlan = 'prompt_plan';
  static const String _kJson = 'prompt_json';

  // The default robust AI prompts
  static const String defaultSkeleton = '''You are an expert curriculum designer. Analyze the attached PDF document to create a high-level course skeleton.
The user uploaded a file named: "%filename%". 

CRITICAL INSTRUCTIONS:
1. Generate a suitable, professional `title` for this course based on the document content or the filename.
2. STRUCTURE HIERARCHY:
   - "modules" represent the main Chapters.
   - "sections" represent the subtopics within a chapter (e.g., 2.1, 2.2).
   - "units" go deeper into the specific topics within each section.
3. The `startPage` and `endPage` MUST refer to the ABSOLUTE PDF PAGE INDEX (1-based index where the absolute first page of the file is 1), NOT the printed page number. Ensure they accurately reflect logical splits.
4. In the custom `systemPrompt` string you generate, STRICTLY instruct the AI to use double-escaped backslashes for all LaTeX (e.g. \\\\frac instead of \\frac).

Return ONLY valid JSON matching this exact structure:
{
  "id": "generated-book-...",
  "title": "Generated Course Title Here",
  "description": "Auto-generated book overview",
  "icon": "Book",
  "systemPrompt": "You are an expert tutor...",
  "modules":[ ... ]
}''';

  static const String defaultPlan = '''You are an expert curriculum designer. Analyze the attached PDF chunk for the unit: "%unit_title%".
Design a pedagogical lesson plan in PLAIN TEXT (do NOT output JSON yet).
Break this unit down into multiple logical lessons based on the PDF content.

CRITICAL DUOLINGO-STYLE MICRO-LEARNING RULES:
1. MAXIMIZE the number of lessons. Break concepts down into extremely bite-sized pieces.
2. For EACH lesson, list the exact sequence of slides.
3. Theory/Concepts MUST be split across many small slides. NO MORE than 1-3 sentences per slide!
4. Each lesson must contain:
   - Several short Theory slides.
   - 2 "fill_in_blank" slides (one question per slide).
   - 4 "quiz" (multiple choice) objective questions (one question per slide).
   - 1 "numerical" slide (if applicable, calculating a value).
   - 1 "proof" or "step_by_step" interactive solution (if applicable).''';

  static const String defaultJson = '''SYSTEM PROMPT:
%system_prompt%

TASK:
You previously created this optimal learning plan for the unit "%unit_title%":
%lesson_plan%

Based strictly on this plan and the attached PDF chunk, generate the full JSON content.

CRITICAL SCHEMA & MICRO-LEARNING RULES:
1. EXTREME MICRO-LEARNING: "content" fields MUST be very short (1-3 sentences max).
2. `slide.title` should be a short category (e.g. "Concept Check"), DO NOT duplicate the question text in the title.
3. `fill_in_blank` slides: "content" MUST be a single plain-text string containing exactly three underscores (`___`). `blankAnswer` MUST be the exact single correct word/phrase (e.g. "generalization"), DO NOT provide alternatives like "a or b".
4. `quiz` slides MUST have exactly 4 options. EACH option MUST have a non-empty `text` field containing the choice.
5. `numerical` slides: "content" is the word problem. Must provide `numericAnswer` (a float/number) and optionally `numericTolerance`.
6. LaTeX formatting must be double-escaped (e.g., \\\\frac{1}{2}).
7. Markdown math is wrapped in \$ or \$\$.

Return ONLY valid JSON representing the "lessons" array. Format:
{ "lessons": [ { "id": "...", "title": "...", "description": "...", "icon": "BookOpen", "slides": [ ... ] } ] }''';

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
  }
}