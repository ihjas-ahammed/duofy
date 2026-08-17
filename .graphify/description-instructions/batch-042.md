# Node Description Batch 43 of 61

Graphify is running in assistant/skill mode (no API key). You are the host
assistant (Claude Code / Codex / Gemini CLI). Read the prompt below and write
your JSON answer to the answer file.

## Prompt

You are documenting nodes in a knowledge graph.
For each entry below, write ONE concise factual plain-language sentence
describing what it is or does. Use only the provided context.
For a code symbol (kind=code-symbol — a function, class, or constant),
describe what the function/symbol does based on its name, source location
and neighbors — e.g. "Resolves the configured ontology profile from graphify.yaml.".
Write every description in English (en). Do not switch languages.
No marketing language.
Respond ONLY with a JSON object mapping each node id (as a string) to its
one-sentence description — no prose, no markdown fences.

- "services_math_evaluator_service_parsenumber": "_parseNumber()" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L186 | neighbors=[math_evaluator_service.dart]
- "services_math_evaluator_service_parsepower": "_parsePower()" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L145 | neighbors=[math_evaluator_service.dart]
- "services_math_evaluator_service_parseprimary": "_parsePrimary()" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L159 | neighbors=[math_evaluator_service.dart]
- "services_math_evaluator_service_parseterm": "_parseTerm()" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L90 | neighbors=[math_evaluator_service.dart]
- "services_math_evaluator_service_permutation": "_permutation()" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L338 | neighbors=[math_evaluator_service.dart]
- "services_math_evaluator_service_skipwhitespace": "_skipWhitespace()" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L50 | neighbors=[math_evaluator_service.dart]
- "services_metacognition_service_calibrationstats": "CalibrationStats" | kind=code-symbol | source=lib/services/metacognition_service.dart:L93 | neighbors=[metacognition_service.dart]
- "services_metacognition_service_defaultuid": "_defaultUid()" | kind=code-symbol | source=lib/services/metacognition_service.dart:L158 | neighbors=[metacognition_service.dart]
- "services_metacognition_service_difficulty": "difficulty" | kind=code-symbol | source=lib/services/metacognition_service.dart:L135 | neighbors=[metacognition_service.dart]
- "services_metacognition_service_difficultysignal": "difficultySignal()" | kind=code-symbol | source=lib/services/metacognition_service.dart:L497 | neighbors=[metacognition_service.dart]
- "services_metacognition_service_duecount": "dueCount()" | kind=code-symbol | source=lib/services/metacognition_service.dart:L394 | neighbors=[metacognition_service.dart]
- "services_metacognition_service_findslideasync": "_findSlideAsync()" | kind=code-symbol | source=lib/services/metacognition_service.dart:L450 | neighbors=[metacognition_service.dart]
- "services_metacognition_service_function": "Function()" | kind=code-symbol | source=lib/services/metacognition_service.dart:L156 | neighbors=[metacognition_service.dart]
- "services_metacognition_service_markslidereviewedtoday": "markSlideReviewedToday()" | kind=code-symbol | source=lib/services/metacognition_service.dart:L371 | neighbors=[metacognition_service.dart]
- "services_metacognition_service_metacogevent": "MetacogEvent" | kind=code-symbol | source=lib/services/metacognition_service.dart:L14 | neighbors=[metacognition_service.dart]
- "services_metacognition_service_metacognitionservice": "MetacognitionService" | kind=code-symbol | source=lib/services/metacognition_service.dart:L143 | neighbors=[metacognition_service.dart]
- "services_metacognition_service_pullandmerge": "pullAndMerge()" | kind=code-symbol | source=lib/services/metacognition_service.dart:L281 | neighbors=[metacognition_service.dart]
- "services_metacognition_service_push": "push()" | kind=code-symbol | source=lib/services/metacognition_service.dart:L250 | neighbors=[metacognition_service.dart]
- "services_metacognition_service_recordanswer": "recordAnswer()" | kind=code-symbol | source=lib/services/metacognition_service.dart:L179 | neighbors=[metacognition_service.dart]
- "services_metacognition_service_recordreflection": "recordReflection()" | kind=code-symbol | source=lib/services/metacognition_service.dart:L476 | neighbors=[metacognition_service.dart]
- "services_metacognition_service_reviewedtodayprefkey": "_reviewedTodayPrefKey()" | kind=code-symbol | source=lib/services/metacognition_service.dart:L363 | neighbors=[metacognition_service.dart]
- "services_metacognition_service_reviewitem": "ReviewItem" | kind=code-symbol | source=lib/services/metacognition_service.dart:L57 | neighbors=[metacognition_service.dart]
- "services_metacognition_service_should": "should" | kind=code-symbol | source=lib/services/metacognition_service.dart:L494 | neighbors=[metacognition_service.dart]
- "services_metacognition_service_todaykey": "_todayKey()" | kind=code-symbol | source=lib/services/metacognition_service.dart:L358 | neighbors=[metacognition_service.dart]
- "services_metacognition_service_writequeue": "_writeQueue()" | kind=code-symbol | source=lib/services/metacognition_service.dart:L566 | neighbors=[metacognition_service.dart]
- "services_module_notes_html_builder_buildhtml": "buildHtml()" | kind=code-symbol | source=lib/services/module_notes_html_builder.dart:L4 | neighbors=[module_notes_html_builder.dart]
- "services_module_notes_html_builder_escapehtml": "_escapeHtml()" | kind=code-symbol | source=lib/services/module_notes_html_builder.dart:L608 | neighbors=[module_notes_html_builder.dart]
- "services_module_notes_html_builder_modulenoteshtmlbuilder": "ModuleNotesHtmlBuilder" | kind=code-symbol | source=lib/services/module_notes_html_builder.dart:L3 | neighbors=[module_notes_html_builder.dart]
- "services_module_notes_html_builder_study": "study" | kind=code-symbol | source=lib/services/module_notes_html_builder.dart:L1 | neighbors=[module_notes_html_builder.dart]
- "services_module_notes_service_addlistener": "addListener()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L40 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_and": "and" | kind=code-symbol | source=lib/services/module_notes_service.dart:L232 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_buildnativepdffromnotes": "_buildNativePdfFromNotes()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L668 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_cleanlatexfornativepdf": "_cleanLatexForNativePdf()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L611 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_ensurelocalmathjax": "_ensureLocalMathJax()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L69 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_function": "Function()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L25 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_generatemodulenotes": "generateModuleNotes()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L233 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_getnoteshtmlpath": "getNotesHtmlPath()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L124 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_getnotespdfpath": "getNotesPdfPath()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L104 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_hasnotes": "hasNotes()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L89 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_jobkey": "_jobKey()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L62 | neighbors=[module_notes_service.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-042.json

Keep each description factual and concise (one sentence). No markdown, no prose
outside the JSON object. It is acceptable to omit a node if context is
insufficient — but include every node you can ground confidently.

Example answer format:
```json
{
  "node_id_1": "Resolves the configured ontology profile from graphify.yaml.",
  "node_id_2": "Colonel James Barclay, an antagonist in The Crooked Man."
}
```
