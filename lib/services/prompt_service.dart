import 'dart:convert';
import '../models/app_models.dart';
import '../widgets/lesson_node.dart' show lessonIconChoices;

/// AI prompt templates. The structural skeleton of each prompt is fixed, but
/// two kinds of runtime substitution happen at call time:
///   - structural placeholders (`%filename%`, `%unit_title%`, …), and
///   - user-supplied `%custom_instructions%` captured at book creation (and,
///     for the planner, optionally tweaked per-section). When the user gives
///     no instructions the caller substitutes an empty string and the
///     surrounding `USER INSTRUCTIONS` block is omitted via [instructionsBlock].
class PromptService {
  /// Wraps free-text user [instructions] into a clearly delimited block so the
  /// model treats it as high-priority guidance. Returns an empty string when
  /// there are no instructions, so prompts stay clean for the common case.
  static String instructionsBlock(String? instructions) {
    final trimmed = instructions?.trim() ?? '';
    if (trimmed.isEmpty) return '';
    return '''

USER INSTRUCTIONS (HIGHEST PRIORITY — follow these unless they conflict with the JSON schema):
$trimmed
''';
  }

  /// Comma-separated list of allowed `icon` values for lessons, derived from
  /// the actual icon vocabulary supported by the renderer. Anything not in
  /// this list will silently fall back to `book-open` at render time.
  static final String _iconChoiceList = lessonIconChoices.join(', ');

  static final String _iconRule =
      'Pick the most thematically appropriate `icon` for each lesson from this exact list (use the kebab-case form): $_iconChoiceList. Examples: a lesson on integration → "sigma" or "function"; on Newton\'s laws → "atom" or "rocket"; on cell biology → "dna" or "microscope"; on World War II → "history" or "swords"; on French vocabulary → "languages". Only use "book-open" when no other icon clearly fits.';

  /// Comprehensive LaTeX/Markdown-math reference inlined into every lesson
  /// JSON prompt. The Gemma / lite text models often emit malformed math —
  /// dropping backslashes, missing the delimiters, or mixing display and
  /// inline mode — so this block enumerates the exact rules and the most
  /// common failure modes verbatim. Keep changes here minimal; small wording
  /// edits change generation outcomes noticeably.
  static const String latexGuide = '''
LATEX / MARKDOWN-MATH GUIDE (READ CAREFULLY — most generation errors come from violating these rules):

1. JSON ESCAPING — every `\\` in your output MUST be written as `\\\\` because the surrounding container is JSON. So you write `\\\\frac{1}{2}`, `\\\\int_0^1`, `\\\\sqrt{x}`, `\\\\alpha`, NOT `\\frac{1}{2}`. Single-backslash LaTeX will not render.

2. INLINE vs DISPLAY MATH
   - Inline math (flows inside a sentence): wrap in single `\$ … \$`. Example: `The area is \$\\\\pi r^2\$.`
   - Display math (own line, centered, larger): wrap in double `\$\$ … \$\$`. Example: `\$\$\\\\int_a^b f(x)\\\\,dx = F(b) - F(a)\$\$`.
   - NEVER put a single short inline equation on its own line — keep it inline with surrounding prose.
   - NEVER mix delimiters: don't write `\$\$ x \$` or `\$ x \$\$`.
   - NEVER nest math: `\$ a + \$ b \$ + c \$` is INVALID. Close the first `\$` before opening another.

3. COMMON COMMANDS (always double-escaped):
   - Fractions: `\\\\frac{a}{b}` — both numerator and denominator in braces.
   - Roots: `\\\\sqrt{x}`, `\\\\sqrt[n]{x}`.
   - Powers / subscripts: `x^2`, `x^{10}`, `a_n`, `a_{ij}`. Multi-char exponents / indices MUST be braced.
   - Greek: `\\\\alpha \\\\beta \\\\gamma \\\\theta \\\\pi \\\\Sigma \\\\Omega`.
   - Operators: `\\\\int`, `\\\\sum`, `\\\\prod`, `\\\\lim_{x \\\\to 0}`, `\\\\sin`, `\\\\cos`, `\\\\ln`, `\\\\log`.
   - Vectors / accents: `\\\\vec{v}`, `\\\\hat{n}`, `\\\\bar{x}`, `\\\\dot{x}`.
   - Sets / logic: `\\\\in`, `\\\\subset`, `\\\\cup`, `\\\\cap`, `\\\\forall`, `\\\\exists`, `\\\\neg`, `\\\\rightarrow`, `\\\\leftrightarrow`.
   - Comparisons: `\\\\le`, `\\\\ge`, `\\\\ne`, `\\\\approx`, `\\\\equiv`.
   - Spacing inside math: `\\\\,` (thin), `\\\\;` (med), `\\\\quad` (em). Do NOT use literal spaces to align.

4. MULTI-LINE & ALIGNED EQUATIONS — wrap in `\$\$ … \$\$` and use `\\\\begin{aligned} … \\\\end{aligned}` with `&` for the alignment column and `\\\\\\\\` for line breaks. Example:
   `\$\$\\\\begin{aligned} x &= a + b \\\\\\\\ &= c \\\\end{aligned}\$\$`
   (Note: `\\\\\\\\` is FOUR backslashes — two for LaTeX line break, doubled again for JSON.)

5. MATRICES — `\$\$\\\\begin{pmatrix} a & b \\\\\\\\ c & d \\\\end{pmatrix}\$\$`. Use `bmatrix` for square brackets, `vmatrix` for determinants.

6. CHEMISTRY / UNITS — write units in plain text outside math: `5\\\\,\\\\text{m/s}` inside math, or just `5 m/s` outside it. For chemistry, prefer `\\\\text{H}_2\\\\text{O}` inside math or plain `H₂O` outside.

7. SAFE PUNCTUATION inside math: never use a Markdown asterisk `*` — use `\\\\cdot` or `\\\\times` for multiplication. Never use `_` as anything other than a subscript inside math (and brace multi-char subscripts).

8. PROSE AROUND MATH — write a sentence and slot the math inline; do not leave math floating without context. Example: `By the Pythagorean theorem, \$a^2 + b^2 = c^2\$, so the hypotenuse is \$c = \\\\sqrt{a^2 + b^2}\$.`

9. NEVER emit:
   - Raw `\\frac` (single backslash) — JSON will strip it.
   - `\\(` … `\\)` or `\\[` … `\\]` — use `\$` / `\$\$` only.
   - HTML inside math (`<sup>`, `<sub>`) — use `^` / `_`.
   - Unicode math glyphs like `½`, `√`, `∫` — always render them through LaTeX commands.

10. SHORT NUMERIC RESULTS — when the answer is a plain number (e.g. for "numerical" slides), the `numericAnswer` field is a JSON number, NOT a LaTeX string. Don't wrap `42` as `"\\\\\$42\\\\\$"`.
11. NO LATEX FOR FILL IN BLANK & ONE WORD SIDES — never use LaTeX math delimiters (\$ or \$\$) in the question `content`, `blankAnswer`, or `blankDistractors` of "fill_in_blank" and "one_word" (type your answer) slides. Keep the question, the answer, and all distractors in plain text (using simple unicode characters like ², ³, or x if math symbols are needed) so they are easy for the user to drag or type directly without LaTeX delimiters.''';

  /// Shared offset-correction block reused by both skeleton-stage prompts so
  /// the model converts the TOC's printed page numbers into absolute PDF page
  /// numbers identically in each call.
  static const String _offsetBlock = '''OFFSET CORRECTION (CRITICAL):
The TOC lists the textbook's printed page numbers. We need ABSOLUTE PDF page numbers (1-based, where the first page of the whole source PDF is 1).
The user has told us that Chapter 1 actually starts on absolute PDF page %chapter1_abs_page%. That means: when the TOC says "printed page 1" you must output absolute page %chapter1_abs_page%. The offset to add to every printed page number is therefore (%chapter1_abs_page% - 1).
Apply this offset to EVERY startPage and endPage you output. Never emit printed/TOC page numbers verbatim.''';

  /// Stage 1 of the batched TOC flow: enumerate ONLY the top-level chapters.
  ///
  /// Splitting chapter enumeration into its own focused call fixes two failure
  /// modes the single-shot skeleton had with the lite model: skipping whole
  /// chapters, and silently merging adjacent chapters. Here the model has one
  /// job — list every chapter, in order, with absolute page ranges — and the
  /// per-chapter [sectionList] call fills in subtopics afterwards.
  static const String chapterList = '''You are an expert curriculum designer. The attached PDF contains ONLY the table of contents / index pages of a textbook named "%filename%".
%custom_instructions%
$_offsetBlock

TASK: List EVERY top-level chapter (the main numbered entries / parts) in the TOC, in order. Do NOT break them into sub-topics yet. COMPLETENESS IS CRITICAL — do not skip, merge, or combine chapters; if the TOC lists 14 chapters you must return 14 chapter objects.

For each chapter provide:
- "title": the chapter heading exactly as printed (keep its number, e.g. "Chapter 3: Thermodynamics").
- "description": a one-line summary of the chapter.
- "startPage": the ABSOLUTE PDF page where the chapter begins (apply the offset above).
- "endPage": the ABSOLUTE PDF page where the chapter ends — one page before the next chapter begins (for the final chapter, its last content page per the TOC).

Also generate, for the whole course:
- a professional `title` (from the TOC content or filename),
- an `icon` reflecting the subject matter,
- a `description`,
- a `systemPrompt` for a tutor AI that STRICTLY instructs it to use double-escaped backslashes for all LaTeX (e.g. \\\\frac instead of \\frac).

Return ONLY valid JSON matching this exact structure:
{
  "title": "Generated Course Title Here",
  "icon": "Book",
  "description": "Auto-generated book overview",
  "systemPrompt": "You are an expert tutor...",
  "chapters": [
    { "id": "m1", "title": "Chapter 1: Title", "description": "...", "startPage": 12, "endPage": 34 }
  ]
}''';

  /// Handout course skeleton generator (one-shot).
  static const String handoutSkeleton = '''You are an expert curriculum designer. The attached file contains a handout / document named "%filename%".
This handout has a total of %total_pages% pages.
%custom_instructions%

TASK: Create a structured study course based on the content of this handout. 
Analyze the document and break it down into logical study modules (typically 1-3 modules) and sub-topics/sections (typically 2-4 per module).

Rules:
1. Cover all key concepts present in the handout.
2. Assign page ranges (startPage and endPage) for each section. These MUST correspond to the absolute PDF pages of the handout (1-based, within [1, %total_pages%]).
3. Keep ranges contiguous.

For each section provide "title", "description", a "color" (one of: duo-blue, duo-green, duo-violet, duo-orange, duo-red), and absolute "startPage"/"endPage".

Return ONLY valid JSON matching this exact structure:
{
  "title": "Handout Course Title",
  "icon": "BookOpen",
  "description": "Short overview of the handout",
  "systemPrompt": "You are an expert tutor...",
  "modules": [
    {
      "id": "m1",
      "title": "Module Title",
      "description": "...",
      "sections": [
        { "id": "m1-s1", "title": "Section Title", "description": "...", "color": "duo-blue", "startPage": 1, "endPage": 2 }
      ]
    }
  ]
}''';

  /// Stage 1 of the syllabus-based course flow: enumerate chapters based on the syllabus.
  static const String syllabusChapterList = '''You are an expert curriculum designer. We are designing a structured study course based on the attached SYLLABUS.
The reference textbook named "%filename%" has its table of contents / index pages attached.

TASK: Generate the top-level modules/chapters for this course. 
These modules/chapters MUST align with the syllabus. 
For each module/chapter, identify the corresponding content in the textbook's table of contents and assign the starting and ending page range in the reference textbook.

%custom_instructions%
$_offsetBlock

For each chapter provide:
- "title": the chapter heading (e.g. "Chapter 1: Title" or matching the syllabus module title).
- "description": a one-line summary.
- "startPage": the ABSOLUTE PDF page in the reference textbook where the chapter's content begins.
- "endPage": the ABSOLUTE PDF page where it ends (typically before the next chapter starts).

Also generate, for the whole course:
- a professional `title` (matching the syllabus),
- an `icon` reflecting the subject matter,
- a `description`,
- a `systemPrompt` for a tutor AI that STRICTLY instructs it to use double-escaped backslashes for all LaTeX (e.g. \\\\frac instead of \\frac).

Return ONLY valid JSON matching this exact structure:
{
  "title": "Course Title from Syllabus",
  "icon": "GraduationCap",
  "description": "Short overview of the syllabus-based course",
  "systemPrompt": "You are an expert tutor...",
  "chapters": [
    { "id": "m1", "title": "Module/Chapter Title", "description": "...", "startPage": 12, "endPage": 34 }
  ]
}''';

  /// Stage 2 of the syllabus-based course flow: detail sections for a chapter based on the syllabus.
  static const String syllabusSectionList = '''You are an expert curriculum designer. We are detailing sections for the chapter "%chapter_title%" (pages %chapter_start% to %chapter_end% in reference textbook "%filename%") based on the attached SYLLABUS.

TASK: Identify the subtopics/sections from the SYLLABUS that belong to this chapter. 
Assign absolute page ranges in the reference textbook for each subtopic/section.
The page ranges must be contiguous, in order, and stay strictly within the chapter's range [%chapter_start%, %chapter_end%].

%custom_instructions%
$_offsetBlock

For each section provide "title", "description", a "color" (one of: duo-blue, duo-green, duo-violet, duo-orange, duo-red), and absolute "startPage"/"endPage" within the reference textbook.

Return ONLY valid JSON matching this exact structure (no "units" array):
{
  "sections": [
    { "id": "s1", "title": "Section Title", "description": "...", "color": "duo-blue", "startPage": 12, "endPage": 18 }
  ]
}''';

  /// Stage 2 of the batched TOC flow: detail the sections of ONE chapter.
  ///
  /// Called once per chapter returned by [chapterList], with that chapter's
  /// absolute page bounds inlined so the model keeps every section strictly
  /// inside the chapter (no bleeding into neighbours, no merging subtopics).
  static const String sectionList = '''You are an expert curriculum designer. The attached PDF contains ONLY the table of contents / index pages of the textbook "%filename%".
%custom_instructions%
$_offsetBlock

We are now detailing exactly ONE chapter:
- Chapter: "%chapter_title%"
- This chapter spans ABSOLUTE PDF pages %chapter_start% to %chapter_end% (inclusive).

TASK: From the TOC, list the numbered sub-topics / sections that belong ONLY to this chapter (e.g. "3.1 ...", "3.2 ..."). Rules:
1. Do NOT include sub-topics from any other chapter.
2. Do NOT merge two sub-topics into one entry — keep them separate so each gets its own page range.
3. If this chapter lists no sub-topics, return a SINGLE section that spans the whole chapter.
4. Keep ranges contiguous and inside [%chapter_start%, %chapter_end%]: end each section one page before the next begins; the last section ends at %chapter_end%.

For each section provide "title", "description", a "color" (one of: duo-blue, duo-green, duo-violet, duo-orange, duo-red), and absolute "startPage"/"endPage".

Return ONLY valid JSON matching this exact structure (no "units" array):
{
  "sections": [
    { "id": "s1", "title": "3.1 Subtopic Title", "description": "...", "color": "duo-blue", "startPage": 12, "endPage": 18 }
  ]
}''';

  /// Generates the unit list (manifest) for a single section. Called lazily
  /// when the user first opens a section in the new-flow. The attached PDF
  /// is the section\'s pre-chunked content (already offset-corrected at
  /// skeleton time), so the AI does NOT need to think about page numbers.
  ///
  /// The book\'s available lesson formats are inlined into the prompt so
  /// the AI can tag each unit with the format most appropriate for the
  /// pedagogical content (theory recap, worked example, proof, etc.). The
  /// user then confirms / edits those assignments before lessons are
  /// generated.
  static const String unitManifest = '''You are an expert curriculum designer. The attached PDF is the content of ONE section of a textbook:
Section title: "%section_title%"
Section description: "%section_description%"
%custom_instructions%
TASK:
1. Break this section into a small number of pedagogical units (typically 2-5). Each unit groups a few closely related lessons. Do NOT generate lesson slides here — just the unit metadata.
2. Analyze the unique pedagogical needs of the PDF content. If the existing lesson formats (%format_catalog%) are not optimal or sufficient for teaching this content, CREATE 1-3 new custom lesson formats tailored specifically to the material (e.g., an "Experimental Analysis" format for lab data, or "Derivation Focus" for math/physics). Each new format should define a name, description, and list of slide templates (type, condition, description).

CRITICAL RULES:
1. Cover the entire content of the attached PDF. Do not skip topics.
2. Each unit should be roughly self-contained and digestible in one short study session.
3. For custom formats, the slide `type` must be one of: "theory", "quiz", "fill_in_blank", "one_word", "numerical", "proof", "step_by_step".

Return ONLY valid JSON matching this exact structure:
{
  "units": [
    {
      "id": "u1",
      "title": "Unit Title",
      "description": "Short summary of what this unit covers"
    }
  ],
  "newLessonFormats": [
    {
      "id": "custom-format-id",
      "name": "Custom Format Name",
      "description": "Pedagogical description of when to use this format.",
      "slides": [
        {
          "type": "theory",
          "condition": "Always",
          "description": "What this slide should cover."
        }
      ]
    }
  ]
}''';

  static const String plan = '''You are an expert curriculum designer. Analyze the attached chunk for the unit: "%unit_title%".
Design a pedagogical lesson plan in PLAIN TEXT (do NOT output JSON yet).
Break this unit down into multiple logical lessons based on the content.
%custom_instructions%
UNIT SCOPE (CRITICAL — the attached PDF is shared by several units, so stay strictly inside THIS unit's boundary):
%neighbor_context%
Only plan lessons for the content belonging to "%unit_title%". Do NOT plan lessons that belong to the previous or next unit listed above — those are generated separately and duplicating them creates repeated lessons.

OUTPUT FORMAT (STRICT):
- The VERY FIRST line of your response MUST be exactly: "TOTAL_LESSONS: <N>" where <N> is an integer.
- Then list each lesson, starting each one on its own line with: "Lesson <i>: <title>" (i is the 1-based index).
- Under each "Lesson i:" heading, describe the content, the slide types to use, and the order.

CRITICAL DUOLINGO-STYLE MICRO-LEARNING RULES:
1. MAXIMIZE the number of lessons. Break concepts down into extremely bite-sized pieces.
2. For EACH lesson, choose the most appropriate format from the available formats:
%formats_layout%
For the chosen format, evaluate its slide templates. Only include a slide if its condition logically applies.
3. NO STORY MODE: never frame content as a story, scenario, anecdote, or narrative ("Imagine you are...", "Sara walks into a shop...", etc.). Present theory and concepts directly and factually.
''';

  static final String json = '''SYSTEM PROMPT:
%system_prompt%

TASK:
You previously created this optimal learning plan for the unit "%unit_title%":
%lesson_plan%

Based strictly on this plan and the attached content chunk, generate the full JSON content.

$latexGuide

CRITICAL SCHEMA & MICRO-LEARNING RULES:
1. "theory" slides: `content` MUST be a few sentences explaining a concept DIRECTLY. Use Markdown. NEVER use storytelling, narrative framings, characters, or imagined scenarios — present facts and definitions plainly.
2. "quiz" slides: `content` MUST CONTAIN THE ACTUAL QUESTION TEXT. Provide exactly 4 `options`. Make sure exactly one option has `isCorrect: true`.
3. "fill_in_blank" slides: `content` MUST contain the question with exactly three underscores (`___`). `blankAnswer` is the exact word. Include an array of 3 `blankDistractors` (wrong words) for the user to choose from.
4. "one_word" slides: `content` is a question whose answer is a SINGLE word or very short term — do NOT put a `___` blank in it. `blankAnswer` is that exact word/term; the learner types it freely, so do NOT provide `options` or `blankDistractors`. Only use questions that have one unambiguous answer.
5. "numerical" slides: `content` is a problem whose answer is a NUMBER the learner computes and types. `numericAnswer` is that answer as a plain number (no units, no commas, no thousands separators). `numericTolerance` is the allowed absolute error (use 0.01 for precise answers, or a larger value scaled to the magnitude). Do NOT provide `options`. State any required units inside `content`, never in the answer.
6. "step_by_step" or "proof" slides: `content` is the overall problem statement. `interactiveSteps` is an array mapping the stages. An interactive step can be static (`stepText` only) or a question (`prompt` and `options`).
7. LaTeX formatting must follow the LATEX GUIDE above (double-escaped, correct delimiters, no inline-on-its-own-line).
8. $_iconRule
9. Each lesson MUST include a `canvasPrompt` field: a 1–2 sentence natural-language description of the single most useful diagram for this lesson. Prefer concrete visual structures (free-body diagram, vector triangle, graph of a function, circuit, geometry construction). When the topic genuinely benefits from interactivity or three dimensions (animated process, 3D shape, draggable parameter), say so explicitly in the prompt — e.g. "Interactive: drag a slider for ω to see the sine wave change frequency", "3D: rotatable cube showing diagonal d = a√3". Otherwise keep it static.
10. For "proof" and "step_by_step" slides ONLY: include a `canvasPrompt` on the slide itself if and only if the proof or worked example genuinely needs a figure to follow (geometry, circuits, triangles, graphs, free-body diagrams, etc.). If the proof is purely algebraic and no figure adds value, omit `canvasPrompt` on the slide.
11. Each lesson MUST specify a `formatId` corresponding to the lesson format type it follows (e.g., "theory", "example", or "proof" based on the available formats).

YOU MUST RETURN ONLY VALID JSON MATCHING THIS EXACT STRUCTURE:
{
  "lessons": [
    {
      "id": "l1", "title": "Lesson 1", "description": "...", "icon": "<one value from the icon list>",
      "formatId": "<the format id for this lesson>",
      "canvasPrompt": "One concise sentence describing the lesson\'s key diagram.",
      "slides": [ ... ]
    }
  ]
}''';

  /// Used by Gemma path which generates one lesson at a time to keep each
  /// request small and reduce the chance of malformed or truncated JSON output.
  static final String singleLessonJson = '''SYSTEM PROMPT:
%system_prompt%
%custom_instructions%
TASK:
You previously created this learning plan for the unit "%unit_title%":
%lesson_plan%

Now generate ONLY lesson number %lesson_index% from that plan, with full slide content.
Do not generate any other lessons in this response.

UNIT SCOPE (the attached PDF is shared by several units — stay strictly inside THIS unit):
%neighbor_context%

ALREADY-COVERED CONTENT (from previously generated units in this section — do NOT re-teach or duplicate any of this; build on it instead):
%previous_units_content%

$latexGuide

CRITICAL SCHEMA & MICRO-LEARNING RULES:
1. "theory" slides: `content` MUST be a few sentences explaining a concept DIRECTLY. Use Markdown. NEVER use storytelling, narrative framings, characters, or imagined scenarios — present facts and definitions plainly.
2. "quiz" slides: `content` MUST CONTAIN THE ACTUAL QUESTION TEXT. Provide exactly 4 `options`. Make sure exactly one option has `isCorrect: true`.
3. "fill_in_blank" slides: `content` MUST contain the question with exactly three underscores (`___`). `blankAnswer` is the exact word. Include an array of 3 `blankDistractors` (wrong words) for the user to choose from.
4. "one_word" slides: `content` is a question whose answer is a SINGLE word or very short term — no `___` blank. `blankAnswer` is that exact word/term; the learner types it freely, so do NOT provide `options` or `blankDistractors`. Only use questions with one unambiguous answer.
5. "numerical" slides: `content` is a problem whose answer is a NUMBER the learner computes and types. `numericAnswer` is that answer as a plain number (no units, no commas). `numericTolerance` is the allowed absolute error (0.01 for precise answers, larger when scaled to the magnitude). Do NOT provide `options`. State any units inside `content`.
6. "step_by_step" or "proof" slides: `content` is the overall problem statement. `interactiveSteps` is an array mapping the stages. An interactive step can be static (`stepText` only) or a question (`prompt` and `options`).
7. LaTeX formatting must follow the LATEX GUIDE above (double-escaped, correct delimiters, no inline-on-its-own-line).
8. $_iconRule
9. Include a `canvasPrompt` field on the lesson: a 1–2 sentence natural-language description of the single most useful diagram. Prefer concrete visual structures (free-body diagram, vector triangle, graph, circuit, geometry). When the topic genuinely benefits from interactivity or three dimensions, explicitly say so — e.g. "Interactive: drag a charge to see the field lines update", "3D: rotatable molecule of methane". Otherwise keep the diagram static.
10. For "proof" and "step_by_step" slides ONLY: include a `canvasPrompt` on the slide itself if and only if the proof / worked example genuinely needs a figure (geometry, circuits, triangles, graphs, free-body diagrams). Omit on purely algebraic slides.
11. Specify the `formatId` corresponding to the lesson format type this lesson follows (e.g., "theory", "example", or "proof" based on the available formats).

RETURN ONLY VALID JSON FOR THIS ONE LESSON (no wrapping array, no other keys):
{
  "id": "l%lesson_index%",
  "title": "Lesson Title",
  "description": "...",
  "icon": "<one value from the icon list>",
  "formatId": "<the format id for this lesson>",
  "canvasPrompt": "One concise sentence describing the lesson\'s key diagram.",
  "slides": [ ... ]
}''';

  /// Regenerates a SINGLE slide inside an already-generated lesson. The user
  /// taps "regenerate" on a slide they're unhappy with and can optionally add
  /// a steering note (e.g. "make it simpler", "use a different example"). We
  /// feed the lesson title, the slide's current type + content, and the
  /// source chunk back in, and ask for one fresh slide JSON object of the
  /// same `type`.
  static final String singleSlideJson = '''SYSTEM PROMPT:
%system_prompt%
%custom_instructions%
TASK:
You are regenerating ONE slide inside the lesson "%lesson_title%" (part of the unit "%unit_title%").
The slide you must regenerate has type "%slide_type%". Here is its current complete JSON data, which the user wants replaced:
-------- CURRENT SLIDE --------
%slide_content%
-------------------------------
%regen_note%
Produce a single, improved slide of the SAME type ("%slide_type%") covering the same pedagogical point, using the attached source content for accuracy. Keep it self-contained — do not reference "the previous slide".

$latexGuide

CRITICAL SCHEMA & MICRO-LEARNING RULES:
1. "theory" slides: `content` MUST be a few sentences explaining a concept DIRECTLY. Use Markdown. NEVER use storytelling, narrative framings, characters, or imagined scenarios.
2. "quiz" slides: `content` MUST CONTAIN THE ACTUAL QUESTION TEXT. Provide exactly 4 `options`. Make sure exactly one option has `isCorrect: true`.
3. "fill_in_blank" slides: `content` MUST contain the question with exactly three underscores (`___`). `blankAnswer` is the exact word. Include an array of 3 `blankDistractors`.
4. "one_word" slides: `content` is a question with a SINGLE-word answer (no `___`). `blankAnswer` is that exact word; no `options` or `blankDistractors`.
5. "numerical" slides: `content` is a problem with a numeric answer. `numericAnswer` is that plain number (no units); `numericTolerance` is the allowed absolute error (0.01 default). No `options`.
6. "step_by_step" or "proof" slides: `content` is the overall problem statement. `interactiveSteps` is an array of stages; a step can be static (`stepText` only) or a question (`prompt` and `options`). Include a `canvasPrompt` only if a figure is genuinely needed.
7. LaTeX must follow the LATEX GUIDE above (double-escaped, correct delimiters, no inline-on-its-own-line).

RETURN ONLY VALID JSON FOR THIS ONE SLIDE (no wrapping array, no other keys). Make sure to include all fields required for the slide type matching the schema of the current slide:
- "theory": {"id": "%slide_id%", "type": "theory", "title": "Title", "content": "..."}
- "quiz": {"id": "%slide_id%", "type": "quiz", "title": "Title", "content": "...", "options": [{"id": "opt1", "text": "Option A", "isCorrect": true, "explanation": "..."}, ...]}
- "fill_in_blank": {"id": "%slide_id%", "type": "fill_in_blank", "title": "Title", "content": "... ___ ...", "blankAnswer": "word", "blankDistractors": ["wrong1", "wrong2", "wrong3"]}
- "one_word": {"id": "%slide_id%", "type": "one_word", "title": "Title", "content": "...", "blankAnswer": "word"}
- "numerical": {"id": "%slide_id%", "type": "numerical", "title": "Title", "content": "...", "numericAnswer": 12.3, "numericTolerance": 0.01}
- "proof" / "step_by_step": {"id": "%slide_id%", "type": "proof", "title": "Title", "content": "...", "interactiveSteps": [{"prompt": "...", "options": [...]}, {"stepText": "..."}]}''';

  /// Stage-2 prompt: feeds a single `canvasPrompt` (produced by the text
  /// model) into the graphics model and asks it for a JavaScript program
  /// that renders the concept. The app embeds that program in a fixed,
  /// reusable HTML5 `<canvas>` host (see [CanvasArtView] / canvas_html_view)
  /// which auto-loads three.js and dispatches to either:
  ///   - `function draw(ctx, W, H)` for STATIC 2D diagrams (default), or
  ///   - `function sketch(canvas, W, H)` for INTERACTIVE 2D and/or 3D
  ///     (animation loops, mouse/touch input, WebGL via THREE.js).
  /// The model only ever supplies the drawing logic, never the page scaffold.
  static const String canvasArt = '''You are a diagram artist who renders explanatory graphics with the HTML5 Canvas API and (when 3D is needed) THREE.js. Write a SINGLE JavaScript program that renders the concept below as a clear, visually strong diagram.

Think VISUALLY: the goal is a strong diagrammatic representation — shapes, structure, spatial relationships, arrows and colour that convey the idea at a glance. Words are a last resort, not the content.

CONCEPT TO ILLUSTRATE:
%canvas_prompt%

LESSON CONTEXT (for tone and reference only — do NOT add unrelated decoration):
%lesson_context%

RENDERING SURFACE & OPTIMIZATION FOR SMALL VIEWPORTS:
- Your drawing is shown inside a fixed card with aspect ratio ~3:2 (landscape; roughly 1.5× wider than tall). Design FOR THAT FRAME — do NOT design for a full-screen / portrait window.
- The host already creates the canvas, scales it for devicePixelRatio, and clears to a dark transparent background BEFORE calling your function. Never resize the canvas yourself, never set a fixed size in CSS, never create a second canvas.
- `W` and `H` are the canvas CSS-pixel width and height of THAT 3:2 card. Compute every coordinate relative to `W`/`H` so the drawing dynamically scales and fills the frame.
- **Design for Small Mobile Preview by Default**: On mobile screens, the preview card size is very small (W is ~300px to ~450px CSS pixels). Design everything to be highly legible and touch-friendly at this small scale:
  - **Thick Lines**: Do NOT use thin 1px/2px strokes. Use `ctx.lineWidth = 3` to `5` for primary paths, vectors, graphs, and borders.
  - **Large Text**: Use readable font sizes like `ctx.font = "14px sans-serif"` or `ctx.font = "15px sans-serif"` (or scale font size dynamically with `H * 0.07`). Keep labels short and sparse.
  - **Touch Hitboxes**: If the canvas is interactive (pointer events), interactive knobs/handles must have a visual radius of at least `12px` to `16px` and a touch hit-detection radius of at least `18px` to `25px` so they are easily draggable with a finger on a mobile screen.
  - **Simplified Preview**: Keep the default preview clean, bold, and uncluttered.
- **Full Screen Prompt (For High-Detail/Complex Diagrams)**: If the diagram requires high detail, complex geometric coordinate mappings, or multi-parameter drag-and-drop interactions that are hard to navigate on a small card:
  - Draw a beautiful, simplified layout in the small view.
  - **ADD TO OUTPUT**: Draw a clear visual indicator/label on the canvas (e.g., in a corner or centered along the bottom, e.g., at `H * 0.9` or `H * 0.15` using `ctx.textAlign = "right"` or `"center"`) prompting the user to view in full screen. For example:
    `ctx.fillStyle = "#94A3B8"; ctx.font = "12px sans-serif"; ctx.fillText("Tap ⛶ for Full Screen", W * 0.95, H * 0.15);` (adjust position and alignment to fit beautifully).

PICK THE RIGHT ENTRY POINT — define EXACTLY ONE of the following (no others). The host detects which is present.

  (A) STATIC 2D — default. Output one function:
        function draw(ctx, W, H) { /* … */ }
      `ctx` is a CanvasRenderingContext2D. Use this for anything that is fundamentally a single frame: free-body diagrams, vector triangles, function graphs, geometry, flowcharts, labeled illustrations.

  (B) INTERACTIVE / ANIMATED 2D — use when the concept benefits from motion or user input (oscillation, particle motion, draggable parameter, click-to-add-point). Output one function:
        function sketch(canvas, W, H) { /* … */ }
      Inside it: get `canvas.getContext('2d')`, attach `canvas.addEventListener('pointermove' | 'pointerdown' | ...)`, drive animation with `requestAnimationFrame`. You MUST clear the canvas at the top of each frame (`ctx.clearRect(0, 0, W, H)`). Animation should be smooth and bounded — do NOT spawn unbounded objects.

  (C) 3D — use when the concept is inherently three-dimensional (rotatable solid, molecule, vector field in 3-space, orbiting body). Output one function:
        function sketch(canvas, W, H) { /* … */ }
      Inside it use the globally-available `THREE` (the host pre-loads three.js r150 on `window.THREE`). Create a `WebGLRenderer({ canvas, alpha: true, antialias: true })`, a `PerspectiveCamera` with `aspect = W/H`, a `Scene`, lights, the geometry, and a render loop with `requestAnimationFrame`. Make the object rotate slowly so all faces are visible; OR attach pointer listeners to spin it on drag. Set `renderer.setSize(W, H, false)` ONCE (the host handles devicePixelRatio).

STYLE RULES (apply to A, B, C):
1. Dark, already-cleared background. Light-on-dark colors: primary strokes `#E2E8F0`, accents `#3B82F6` (blue), `#58CC02` (green), `#FBBF24` (amber), `#F472B6` (pink). Label text `#F8FAFC`. Never assume a white page.
2. Text is SECONDARY. Do NOT draw a title, heading, caption, or sentences. Add at most a few SHORT labels (axis names, a key variable, a single value) only where the diagram is unreadable without them. Use `ctx.font = "14px sans-serif"` or larger. Carry meaning with the drawing itself, not words.
3. No external images, no `fetch`, no `XMLHttpRequest`, no DOM mutation outside the canvas, no popups, no `alert`, no `setInterval` (use `requestAnimationFrame`).
4. Output ONLY the JavaScript — no HTML, no `<script>` tags, no Markdown fences, no prose, no `import` statements.
5. Keep the program SMALL (≲ 120 lines). Prefer clear math over fancy shaders. Pure functions, no globals besides the one entry-point function.
6. If higher detail or complex interactions are needed, draw a prompt directly on the canvas asking the user to view in full screen (e.g. "Tap ⛶ for Full Screen").

EXAMPLE A — STATIC 2D (y = x²):
function draw(ctx, W, H) {
  const pad = W * 0.08;
  ctx.lineWidth = 3;
  ctx.strokeStyle = "#E2E8F0";
  ctx.beginPath();
  ctx.moveTo(pad, H - pad); ctx.lineTo(W - pad, H - pad);
  ctx.moveTo(pad, H - pad); ctx.lineTo(pad, pad);
  ctx.stroke();
  ctx.strokeStyle = "#3B82F6"; ctx.lineWidth = 4;
  ctx.beginPath();
  for (let i = 0; i <= 100; i++) {
    const t = i / 100;
    const x = pad + t * (W - 2 * pad);
    const y = (H - pad) - t * t * (H - 2 * pad);
    if (i === 0) ctx.moveTo(x, y); else ctx.lineTo(x, y);
  }
  ctx.stroke();
  ctx.fillStyle = "#F8FAFC"; ctx.font = "14px sans-serif";
  ctx.fillText("y = x^2", W * 0.58, H * 0.32);
}

EXAMPLE B — INTERACTIVE 2D (drag the slider to change a sine wave's frequency):
function sketch(canvas, W, H) {
  const ctx = canvas.getContext('2d');
  let freq = 2;             // cycles across the canvas
  let dragging = false;
  const sliderY = H * 0.88, knobR = 14, hitR = 25;
  let knobX = W * 0.5;
  function onDown(e) {
    const r = canvas.getBoundingClientRect();
    const x = e.clientX - r.left, y = e.clientY - r.top;
    if (Math.hypot(x - knobX, y - sliderY) < hitR) dragging = true;
  }
  function onMove(e) {
    if (!dragging) return;
    const r = canvas.getBoundingClientRect();
    knobX = Math.max(W * 0.1, Math.min(W * 0.9, e.clientX - r.left));
    freq = 0.5 + 6 * ((knobX - W * 0.1) / (W * 0.8));
  }
  function onUp() { dragging = false; }
  canvas.addEventListener('pointerdown', onDown);
  canvas.addEventListener('pointermove', onMove);
  canvas.addEventListener('pointerup', onUp);
  canvas.addEventListener('pointerleave', onUp);
  function frame() {
    ctx.clearRect(0, 0, W, H);
    // wave
    ctx.strokeStyle = "#3B82F6"; ctx.lineWidth = 4;
    ctx.beginPath();
    const midY = H * 0.42, amp = H * 0.22;
    for (let i = 0; i <= 200; i++) {
      const t = i / 200;
      const x = W * 0.05 + t * W * 0.9;
      const y = midY + amp * Math.sin(2 * Math.PI * freq * t);
      if (i === 0) ctx.moveTo(x, y); else ctx.lineTo(x, y);
    }
    ctx.stroke();
    // slider track
    ctx.strokeStyle = "#334155"; ctx.lineWidth = 6;
    ctx.beginPath(); ctx.moveTo(W * 0.1, sliderY); ctx.lineTo(W * 0.9, sliderY); ctx.stroke();
    // knob
    ctx.fillStyle = "#FBBF24";
    ctx.beginPath(); ctx.arc(knobX, sliderY, knobR, 0, Math.PI * 2); ctx.fill();
    // label
    ctx.fillStyle = "#F8FAFC"; ctx.font = "14px sans-serif";
    ctx.fillText("f = " + freq.toFixed(2), W * 0.05, H * 0.15);
    // Tap to expand callout for full screen interaction
    ctx.fillStyle = "#94A3B8"; ctx.font = "12px sans-serif";
    ctx.textAlign = "right";
    ctx.fillText("Tap ⛶ for Full Screen", W * 0.95, H * 0.15);
    ctx.textAlign = "left";
    requestAnimationFrame(frame);
  }
  frame();
}

EXAMPLE C — 3D (slowly rotating cube using THREE.js):
function sketch(canvas, W, H) {
  const THREE = window.THREE;
  const renderer = new THREE.WebGLRenderer({ canvas, alpha: true, antialias: true });
  renderer.setSize(W, H, false);
  const scene = new THREE.Scene();
  const camera = new THREE.PerspectiveCamera(45, W / H, 0.1, 100);
  camera.position.set(2.4, 2, 3.2);
  camera.lookAt(0, 0, 0);
  scene.add(new THREE.AmbientLight(0xffffff, 0.35));
  const key = new THREE.DirectionalLight(0xffffff, 0.9);
  key.position.set(3, 4, 5); scene.add(key);
  const geo = new THREE.BoxGeometry(1.6, 1.6, 1.6);
  const mat = new THREE.MeshStandardMaterial({ color: 0x3B82F6, roughness: 0.45, metalness: 0.15 });
  const cube = new THREE.Mesh(geo, mat);
  scene.add(cube);
  scene.add(new THREE.LineSegments(
    new THREE.EdgesGeometry(geo),
    new THREE.LineBasicMaterial({ color: 0xE2E8F0 })
  ));
  function frame() {
    cube.rotation.x += 0.006;
    cube.rotation.y += 0.009;
    renderer.render(scene, camera);
    requestAnimationFrame(frame);
  }
  frame();
}

Return ONLY the chosen function (either `draw` or `sketch`). No surrounding text, no fences.''';

  static const String qpJson = '''SYSTEM PROMPT:
%system_prompt%
%custom_instructions%

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

  static String getPyqExtractionPrompt({
    required String sectionTitle,
    required String sectionDesc,
    required List<String> unitTitles,
    required List<Slide> existingQuestions,
    required List<Map<String, String>> otherSections,
    String? customInstructions,
  }) {
    final existingBlocks = existingQuestions.isEmpty
        ? "None"
        : existingQuestions.map((q) => "- [ID: ${q.id}] Title: ${q.title}\n  Content/Question: ${q.content}").join("\n");

    final otherSectionsBlocks = otherSections.isEmpty
        ? "None"
        : otherSections.map((s) => "- ID: ${s['id']}, Title: ${s['title']}").join("\n");

    final instBlock = instructionsBlock(customInstructions);

    return '''You are an expert tutor.
Analyze the attached exam paper (PDF/images) and extract questions that align with the following course section.

SECTION DETAILS:
- Title: $sectionTitle
- Description: $sectionDesc
- Subtopics/Units: ${unitTitles.join(', ')}

$instBlock

ALREADY EXTRACTED QUESTIONS (Do NOT extract duplicates of these! Avoid similar questions to support continuous addition):
$existingBlocks

OTHER SECTIONS IN THE COURSE (If an extracted question also fits any of these, specify their IDs in the "otherSupportedSectionIds" list):
$otherSectionsBlocks

TYPES OF QUESTIONS TO EXTRACT:
1. "one_word": Short recall questions that have a one-word or short-phrase answer. You can group multiple related short questions together into a single slide by putting them in the "interactiveSteps" list (where "prompt" is the sub-question and "stepText" is the correct answer).
2. "proof" / Big Question: Detailed, multi-step questions, mathematical proofs, derivations, or long-form calculations. Provide the solution as an interactive step-by-step proof walkthrough in "interactiveSteps". The very first step in "interactiveSteps" MUST be a static step with NO options (leave "options" empty or null). Its "prompt" or "stepText" should simply restate the question and objective to start the proof (e.g. "We want to prove/derive: [Objective]"), so the user has to click "Next Step" to begin solving instead of seeing the first solution step immediately. Subsequent steps should have a "prompt" explaining the step to perform, and a correct option from "options" (with "isCorrect": true) representing the next correct derivation/result, plus a few distractor incorrect options.

RULES:
1. LaTeX formatting: every backslash \\ in math MUST be written as \\\\ because the response must be valid JSON. Wrap inline math in \$...\$ and display math in \$\$...\$\$.
2. For "one_word" types, do not use LaTeX math delimiters in the answer/blank fields.
3. Be highly selective: only extract questions that are directly related to the section details. If none match, return an empty list.
4. Enforce that all "proof" / Big Question types have the static question-restatement first step described above.

Return ONLY a JSON object matching this schema:
{
  "questions": [
    {
      "id": "unique_id_string",
      "type": "one_word" | "proof",
      "title": "Question Title",
      "content": "Full question text / statement.",
      "blankAnswer": "The answer (for a single one-word question). For multiple subquestions, put a comma-separated list of answers.",
      "interactiveSteps": [
        {
          "prompt": "For one-word subquestions: the specific question text. For proofs: instruction/derivation prompt.",
          "stepText": "For one-word subquestions: the correct answer. For proofs: the text of the step revealed after matching.",
          "options": [ // Only for "proof" type steps where you want multiple-choice choices
            {
              "id": "opt_id",
              "text": "Option text",
              "isCorrect": true,
              "explanation": "Why this option is correct/incorrect"
            }
          ]
        }
      ],
      "otherSupportedSectionIds": ["sec_id_1", "sec_id_2"]
    }
  ]
}''';
  }

  static String getPyqGradingPrompt({
    required List<Map<String, dynamic>> answersToGrade,
  }) {
    final listStr = jsonEncode(answersToGrade);
    return '''You are an expert grading assistant.
Below is a JSON list of student answers to short/one-word questions, along with the question text and the correct reference answer.
Evaluate each student answer for correctness. Allow for minor spelling variations, abbreviations, case-insensitivity, or synonyms if they are semantically correct.

STUDENT ANSWERS TO GRADE:
$listStr

Return ONLY a JSON object matching this schema:
{
  "results": [
    {
      "index": 0, // matches the index in the input list
      "isCorrect": true, // or false
      "explanation": "Brief 1-sentence explanation of why it is correct or incorrect (e.g. spelling variation accepted, or incorrect concept)."
    }
  ]
}''';
  }
}
