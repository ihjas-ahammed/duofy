import '../widgets/lesson_node.dart' show lessonIconChoices;

/// Hardcoded AI prompts. Custom user prompts are intentionally not supported —
/// every call uses these defaults verbatim. The only runtime substitutions are
/// for structural placeholders (`%filename%`, `%unit_title%`, etc.); there is
/// no `%user_prompt%` or `%user_interests%`.
class PromptService {
  /// Comma-separated list of allowed `icon` values for lessons, derived from
  /// the actual icon vocabulary supported by the renderer. Anything not in
  /// this list will silently fall back to `book-open` at render time.
  static final String _iconChoiceList = lessonIconChoices.join(', ');

  static final String _iconRule =
      'Pick the most thematically appropriate `icon` for each lesson from this exact list (use the kebab-case form): $_iconChoiceList. Examples: a lesson on integration → "sigma" or "function"; on Newton\'s laws → "atom" or "rocket"; on cell biology → "dna" or "microscope"; on World War II → "history" or "swords"; on French vocabulary → "languages". Only use "book-open" when no other icon clearly fits.';

  /// Skeleton prompt for the new TOC-only flow. The user picks the index/TOC
  /// pages of the source PDF, and tells us which absolute PDF page contains
  /// the start of Chapter 1. We pass that offset so the AI converts the
  /// printed page numbers (TOC page 1) into absolute PDF page numbers.
  ///
  /// The skeleton is now two levels deep:
  ///   - Modules    = Chapters (top-level entries in the TOC).
  ///   - Sections   = Sub-chapters / numbered subtopics (e.g. 2.1, 2.2), each
  ///                  carrying its own absolute startPage/endPage.
  ///   - Units      = NOT generated here. They are produced lazily by a
  ///                  later AI call when the user opens a section.
  static const String skeleton = '''You are an expert curriculum designer. The attached PDF contains ONLY the table of contents / index pages of a textbook.
The original source file is named: "%filename%".

OFFSET CORRECTION (CRITICAL):
The TOC lists the textbook's printed page numbers. We need ABSOLUTE PDF page numbers (1-based, where the first page of the whole source PDF is 1).
The user has told us that Chapter 1 actually starts on absolute PDF page %chapter1_abs_page%. That means: when the TOC says "printed page 1" you must output absolute page %chapter1_abs_page%. The offset to add to every printed page number is therefore (%chapter1_abs_page% - 1).
Apply this offset to EVERY startPage and endPage you output. Never emit printed/TOC page numbers verbatim.

STRUCTURE HIERARCHY:
- "modules" = the main Chapters listed in the TOC (e.g. "Chapter 1: Mechanics").
- "sections" = the numbered subtopics under each chapter (e.g. "1.1 Kinematics", "1.2 Newton\'s Laws"). EVERY section MUST have an absolute startPage and endPage derived from the TOC plus the offset above. If a chapter has no listed subtopics, emit a single section that spans the whole chapter.
- DO NOT generate "units" here. Units will be produced later by a separate AI call when the user opens a section.

CRITICAL INSTRUCTIONS:
1. Generate a suitable, professional `title` for this course based on the TOC content or the filename.
2. Pick an `icon` for the book that reflects the subject matter.
3. End each section\'s endPage one page BEFORE the next section\'s startPage (so ranges are contiguous, not overlapping). The final section in a chapter should end where the chapter ends.
4. In the `systemPrompt` string you generate, STRICTLY instruct the AI to use double-escaped backslashes for all LaTeX (e.g. \\\\frac instead of \\frac).

Return ONLY valid JSON matching this exact structure (note: no "units" array):
{
  "id": "generated-book-123",
  "title": "Generated Course Title Here",
  "description": "Auto-generated book overview",
  "icon": "Book",
  "systemPrompt": "You are an expert tutor...",
  "modules":[
    {
      "id": "m1",
      "title": "Chapter 1: Title",
      "description": "...",
      "sections": [
        {
          "id": "s1",
          "title": "1.1 Subtopic Title",
          "description": "...",
          "color": "duo-blue",
          "startPage": 12,
          "endPage": 18
        }
      ]
    }
  ]
}''';

  /// Generates the unit list (manifest) for a single section. Called lazily
  /// when the user first opens a section in the new-flow. The attached PDF
  /// is the section\'s pre-chunked content (already offset-corrected at
  /// skeleton time), so the AI does NOT need to think about page numbers.
  static const String unitManifest = '''You are an expert curriculum designer. The attached PDF is the content of ONE section of a textbook:
Section title: "%section_title%"
Section description: "%section_description%"

TASK:
Break this section into a small number of pedagogical units (typically 2-5). Each unit groups a few closely related lessons. Do NOT generate lesson slides here — just the unit metadata.

CRITICAL RULES:
1. Cover the entire content of the attached PDF. Do not skip topics.
2. Each unit should be roughly self-contained and digestible in one short study session.

Return ONLY valid JSON matching this exact structure:
{
  "units": [
    {
      "id": "u1",
      "title": "Unit Title",
      "description": "Short summary of what this unit covers"
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
3. NO STORY MODE: never frame content as a story, scenario, anecdote, or narrative ("Imagine you are...", "Sara walks into a shop...", etc.). Present theory and concepts directly and factually.
''';

  static final String json = '''SYSTEM PROMPT:
%system_prompt%

TASK:
You previously created this optimal learning plan for the unit "%unit_title%":
%lesson_plan%

Based strictly on this plan and the attached content chunk, generate the full JSON content.

CRITICAL SCHEMA & MICRO-LEARNING RULES:
1. "theory" slides: `content` MUST be a few sentences explaining a concept DIRECTLY. Use Markdown. NEVER use storytelling, narrative framings, characters, or imagined scenarios — present facts and definitions plainly.
2. "quiz" slides: `content` MUST CONTAIN THE ACTUAL QUESTION TEXT. Provide exactly 4 `options`. Make sure exactly one option has `isCorrect: true`.
3. "fill_in_blank" slides: `content` MUST contain the question with exactly three underscores (`___`). `blankAnswer` is the exact word. Include an array of 3 `blankDistractors` (wrong words) for the user to choose from.
4. "step_by_step" or "proof" slides: `content` is the overall problem statement. `interactiveSteps` is an array mapping the stages. An interactive step can be static (`stepText` only) or a question (`prompt` and `options`).
5. LaTeX formatting must be double-escaped (e.g., \\\\frac{1}{2}). Markdown math is wrapped in \$ for inline (must flow inside a sentence) or \$\$ for display blocks. Do NOT put a single short inline equation on its own line — keep it inline with surrounding text.
6. $_iconRule

YOU MUST RETURN ONLY VALID JSON MATCHING THIS EXACT STRUCTURE:
{
  "lessons": [
    {
      "id": "l1", "title": "Lesson 1", "description": "...", "icon": "<one value from the icon list>",
      "slides": [ ... ]
    }
  ]
}''';

  /// Used by Gemma path which generates one lesson at a time to keep each
  /// request small and reduce the chance of malformed or truncated JSON output.
  static final String singleLessonJson = '''SYSTEM PROMPT:
%system_prompt%

TASK:
You previously created this learning plan for the unit "%unit_title%":
%lesson_plan%

Now generate ONLY lesson number %lesson_index% from that plan, with full slide content.
Do not generate any other lessons in this response.

CRITICAL SCHEMA & MICRO-LEARNING RULES:
1. "theory" slides: `content` MUST be a few sentences explaining a concept DIRECTLY. Use Markdown. NEVER use storytelling, narrative framings, characters, or imagined scenarios — present facts and definitions plainly.
2. "quiz" slides: `content` MUST CONTAIN THE ACTUAL QUESTION TEXT. Provide exactly 4 `options`. Make sure exactly one option has `isCorrect: true`.
3. "fill_in_blank" slides: `content` MUST contain the question with exactly three underscores (`___`). `blankAnswer` is the exact word. Include an array of 3 `blankDistractors` (wrong words) for the user to choose from.
4. "step_by_step" or "proof" slides: `content` is the overall problem statement. `interactiveSteps` is an array mapping the stages. An interactive step can be static (`stepText` only) or a question (`prompt` and `options`).
5. LaTeX formatting must be double-escaped (e.g., \\\\frac{1}{2}). Markdown math is wrapped in \$ for inline (must flow inside a sentence) or \$\$ for display blocks. Do NOT put a single short inline equation on its own line — keep it inline with surrounding text.
6. $_iconRule

RETURN ONLY VALID JSON FOR THIS ONE LESSON (no wrapping array, no other keys):
{
  "id": "l%lesson_index%",
  "title": "Lesson Title",
  "description": "...",
  "icon": "<one value from the icon list>",
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
