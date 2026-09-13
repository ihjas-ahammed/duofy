# Node Description Batch 31 of 68

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

- "screens_lesson_screen_promptdeleteslide": "_promptDeleteSlide()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L1292 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_promptregenerateslide": "_promptRegenerateSlide()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L1038 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_recordfirstattempt": "_recordFirstAttempt()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L769 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_refreshfromcache": "_refreshFromCache()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L417 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_showdiscomfortalertdialog": "_showDiscomfortAlertDialog()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L799 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_togglebookmark": "_toggleBookmark()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L382 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_trackdiscomfort": "_trackDiscomfort()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L782 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_triggerbackgroundcanvasgeneration": "_triggerBackgroundCanvasGeneration()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L332 | neighbors=[lesson_screen.dart]
- "screens_main_layout_screen_currently": "currently" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L46 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L76 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_formatlastsyncdate": "_formatLastSyncDate()" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L243 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_handlepublishorsync": "_handlePublishOrSync()" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L235 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L52 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_mainlayoutscreen": "MainLayoutScreen" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L24 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_mainlayoutscreenstate": "_MainLayoutScreenState" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L40 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_onbookupdated": "_onBookUpdated()" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L83 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_opencoursesettings": "_openCourseSettings()" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L98 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_promptsyncpublishedbook": "_promptSyncPublishedBook()" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L254 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_publishbook": "_publishBook()" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L199 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_syncbook": "_syncBook()" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L220 | neighbors=[main_layout_screen.dart]
- "screens_metacognition_setup_screen_countsentences": "_countSentences()" | kind=code-symbol | source=lib/screens/metacognition_setup_screen.dart:L66 | neighbors=[metacognition_setup_screen.dart]
- "screens_metacognition_setup_screen_countwords": "_countWords()" | kind=code-symbol | source=lib/screens/metacognition_setup_screen.dart:L61 | neighbors=[metacognition_setup_screen.dart]
- "screens_metacognition_setup_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/metacognition_setup_screen.dart:L39 | neighbors=[metacognition_setup_screen.dart]
- "screens_metacognition_setup_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/metacognition_setup_screen.dart:L32 | neighbors=[metacognition_setup_screen.dart]
- "screens_metacognition_setup_screen_metacognitionsetupscreen": "MetacognitionSetupScreen" | kind=code-symbol | source=lib/screens/metacognition_setup_screen.dart:L10 | neighbors=[metacognition_setup_screen.dart]
- "screens_metacognition_setup_screen_metacognitionsetupscreenstate": "_MetacognitionSetupScreenState" | kind=code-symbol | source=lib/screens/metacognition_setup_screen.dart:L20 | neighbors=[metacognition_setup_screen.dart]
- "screens_metacognition_setup_screen_skip": "_skip()" | kind=code-symbol | source=lib/screens/metacognition_setup_screen.dart:L131 | neighbors=[metacognition_setup_screen.dart]
- "screens_metacognition_setup_screen_submit": "_submit()" | kind=code-symbol | source=lib/screens/metacognition_setup_screen.dart:L79 | neighbors=[metacognition_setup_screen.dart]
- "screens_metacognition_setup_screen_updatecounts1": "_updateCounts1()" | kind=code-symbol | source=lib/screens/metacognition_setup_screen.dart:L45 | neighbors=[metacognition_setup_screen.dart]
- "screens_metacognition_setup_screen_updatecounts2": "_updateCounts2()" | kind=code-symbol | source=lib/screens/metacognition_setup_screen.dart:L53 | neighbors=[metacognition_setup_screen.dart]
- "screens_module_notes_viewer_screen_confirmdeletenotes": "_confirmDeleteNotes()" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L308 | neighbors=[module_notes_viewer_screen.dart]
- "screens_module_notes_viewer_screen_function": "Function()" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L18 | neighbors=[module_notes_viewer_screen.dart]
- "screens_module_notes_viewer_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L43 | neighbors=[module_notes_viewer_screen.dart]
- "screens_module_notes_viewer_screen_loadhtmlnotes": "_loadHtmlNotes()" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L48 | neighbors=[module_notes_viewer_screen.dart]
- "screens_module_notes_viewer_screen_modulenotesviewerscreen": "ModuleNotesViewerScreen" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L13 | neighbors=[module_notes_viewer_screen.dart]
- "screens_module_notes_viewer_screen_modulenotesviewerscreenstate": "_ModuleNotesViewerScreenState" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L37 | neighbors=[module_notes_viewer_screen.dart]
- "screens_module_notes_viewer_screen_onjsmessage": "_onJsMessage()" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L72 | neighbors=[module_notes_viewer_screen.dart]
- "screens_module_notes_viewer_screen_openinexternalbrowser": "_openInExternalBrowser()" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L84 | neighbors=[module_notes_viewer_screen.dart]
- "screens_module_notes_viewer_screen_printandsharepdf": "_printAndSharePdf()" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L105 | neighbors=[module_notes_viewer_screen.dart]
- "screens_module_notes_viewer_screen_promptregenerate": "_promptRegenerate()" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L145 | neighbors=[module_notes_viewer_screen.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-030.json

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
