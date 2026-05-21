/// Hardcoded AI prompts. Custom user prompts are intentionally not supported —
/// every call uses these defaults verbatim. The only runtime substitutions are
/// for structural placeholders (`%filename%`, `%unit_title%`, etc.); there is
/// no `%user_prompt%` or `%user_interests%`.
class PromptService {
  static const String skeleton = '''You are an expert curriculum designer. Analyze the attached document/images to create a high-level course skeleton.
The user uploaded a file named: "%filename%".

CRITICAL INSTRUCTIONS:
1. Generate a suitable, professional `title` for this course based on the document content or the filename.
2. STRUCTURE HIERARCHY:
   - "modules" represent the main Chapters.
   - "sections" represent the subtopics within a chapter (e.g., 2.1, 2.2).
   - "units" go deeper into the specific topics within each section.
3. The `startPage` and `endPage` MUST refer to the ABSOLUTE PAGE INDEX (1-based index where the absolute first page of the file is 1). Ensure they accurately reflect logical splits.
4. In the `systemPrompt` string you generate, STRICTLY instruct the AI to use double-escaped backslashes for all LaTeX (e.g. \\\\frac instead of \\frac).

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

  static const String plan = '''You are an expert curriculum designer. Analyze the attached chunk for the unit: "%unit_title%".
Design a pedagogical lesson plan in PLAIN TEXT (do NOT output JSON yet).
Break this unit down into multiple logical lessons based on the content.

OUTPUT FORMAT (STRICT):
- The VERY FIRST line of your response MUST be exactly: "TOTAL_LESSONS: <N>" where <N> is an integer.
- Then list each lesson, starting each one on its own line with: "Lesson <i>: <title>" (i is the 1-based index).
- Under each "Lesson i:" heading, describe the content, the slide types to use, and the order.

CRITICAL DUOLINGO-STYLE MICRO-LEARNING RULES:
1. MAXIMIZE the number of lessons. Break concepts down into extremely bite-sized pieces.
2. For EACH lesson, evaluate the possible slide types and their conditions:
%template_layout%
EVALUATE THE "CONDITION" FOR EACH SLIDE. ONLY include a slide if the condition logically applies to the topic.
Do not force a slide type if its condition is not met!

For example slides, use universally understood real-world everyday examples that directly illustrate the underlying concept.
''';

  static const String json = '''SYSTEM PROMPT:
%system_prompt%

TASK:
You previously created this optimal learning plan for the unit "%unit_title%":
%lesson_plan%

Based strictly on this plan and the attached content chunk, generate the full JSON content.

CRITICAL SCHEMA & MICRO-LEARNING RULES:
1. "theory" slides: `content` MUST be a few sentences explaining a concept. Use Markdown.
2. "quiz" slides: `content` MUST CONTAIN THE ACTUAL QUESTION TEXT. Provide exactly 4 `options`. Make sure exactly one option has `isCorrect: true`.
3. "fill_in_blank" slides: `content` MUST contain the question with exactly three underscores (`___`). `blankAnswer` is the exact word. Include an array of 3 `blankDistractors` (wrong words) for the user to choose from.
4. "step_by_step" or "proof" slides: `content` is the overall problem statement. `interactiveSteps` is an array mapping the stages. An interactive step can be static (`stepText` only) or a question (`prompt` and `options`).
5. LaTeX formatting must be double-escaped (e.g., \\\\frac{1}{2}). Markdown math is wrapped in \$ or \$\$.

YOU MUST RETURN ONLY VALID JSON MATCHING THIS EXACT STRUCTURE:
{
  "lessons": [
    {
      "id": "l1", "title": "Lesson 1", "description": "...", "icon": "BookOpen",
      "slides": [ ... ]
    }
  ]
}''';

  /// Used by Gemma path which generates one lesson at a time to keep each
  /// request small and reduce the chance of malformed or truncated JSON output.
  static const String singleLessonJson = '''SYSTEM PROMPT:
%system_prompt%

TASK:
You previously created this learning plan for the unit "%unit_title%":
%lesson_plan%

Now generate ONLY lesson number %lesson_index% from that plan, with full slide content.
Do not generate any other lessons in this response.

CRITICAL SCHEMA & MICRO-LEARNING RULES:
1. "theory" slides: `content` MUST be a few sentences explaining a concept. Use Markdown.
2. "quiz" slides: `content` MUST CONTAIN THE ACTUAL QUESTION TEXT. Provide exactly 4 `options`. Make sure exactly one option has `isCorrect: true`.
3. "fill_in_blank" slides: `content` MUST contain the question with exactly three underscores (`___`). `blankAnswer` is the exact word. Include an array of 3 `blankDistractors` (wrong words) for the user to choose from.
4. "step_by_step" or "proof" slides: `content` is the overall problem statement. `interactiveSteps` is an array mapping the stages. An interactive step can be static (`stepText` only) or a question (`prompt` and `options`).
5. LaTeX formatting must be double-escaped (e.g., \\\\frac{1}{2}). Markdown math is wrapped in \$ or \$\$.

RETURN ONLY VALID JSON FOR THIS ONE LESSON (no wrapping array, no other keys):
{
  "id": "l%lesson_index%",
  "title": "Lesson Title",
  "description": "...",
  "icon": "BookOpen",
  "slides": [ ... ]
}''';

  static const String qpJson = '''SYSTEM PROMPT:
%system_prompt%

TASK:
Analyze the attached Question Paper (PDF or Images).
Extract the questions and provide a comprehensive, step-by-step solution for each.
Group the questions logically into sections (e.g., "Section A: Multiple Choice", "Section B: Long Answer", or by topic).

RULES:
1. Ensure accurate math using double-escaped LaTeX (e.g. \\\\frac).
2. Return ONLY valid JSON matching this schema:
{
  "id": "qp1",
  "title": "Extracted Past Paper Title",
  "sections": [
    {
      "title": "Section A: Multiple Choice",
      "questions": [
        {
          "id": "q1",
          "questionText": "The original question text...",
          "solutionText": "**Answer:** ... \\n\\n**Step-by-step:** ..."
        }
      ]
    }
  ]
}''';
}
