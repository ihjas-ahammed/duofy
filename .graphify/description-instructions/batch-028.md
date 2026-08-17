# Node Description Batch 29 of 61

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

- "screens_lesson_complete_screen_lessoncompletescreen": "LessonCompleteScreen" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L13 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_complete_screen_lessoncompletescreenstate": "_LessonCompleteScreenState" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L49 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_screen_applyslideedit": "_applySlideEdit()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L1423 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_buildslidequeue": "_buildSlideQueue()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L483 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_cancheck": "_canCheck()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L932 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_checkandpromptnextunitgeneration": "_checkAndPromptNextUnitGeneration()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L193 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_checkanswer": "_checkAnswer()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L646 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_confirmexit": "_confirmExit()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L1239 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L403 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_finishlesson": "_finishLesson()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L534 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_getcorrectanswertext": "_getCorrectAnswerText()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L970 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_hasenteredanswer": "_hasEnteredAnswer()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L949 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_initafterslidesready": "_initAfterSlidesReady()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L163 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L136 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_iscustombottombar": "_isCustomBottomBar()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L961 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_lessonscreen": "LessonScreen" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L39 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_lessonscreenstate": "_LessonScreenState" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L68 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_loadbookmarkstate": "_loadBookmarkState()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L375 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_loadslidesasync": "_loadSlidesAsync()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L150 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_nextmodidx": "nextModIdx" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L222 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_nextsecidx": "nextSecIdx" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L216 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_nextslide": "_nextSlide()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L506 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_ongenerationmanagerchange": "_onGenerationManagerChange()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L409 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_ontheorycontinue": "_onTheoryContinue()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L927 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_openassistant": "_openAssistant()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L1365 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_promptdeleteslide": "_promptDeleteSlide()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L1287 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_promptregenerateslide": "_promptRegenerateSlide()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L1033 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_recordfirstattempt": "_recordFirstAttempt()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L764 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_refreshfromcache": "_refreshFromCache()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L415 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_showdiscomfortalertdialog": "_showDiscomfortAlertDialog()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L794 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_togglebookmark": "_toggleBookmark()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L380 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_trackdiscomfort": "_trackDiscomfort()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L777 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_triggerbackgroundcanvasgeneration": "_triggerBackgroundCanvasGeneration()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L330 | neighbors=[lesson_screen.dart]
- "screens_main_layout_screen_currently": "currently" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L43 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L73 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_formatlastsyncdate": "_formatLastSyncDate()" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L223 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_handlepublishorsync": "_handlePublishOrSync()" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L215 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L49 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_mainlayoutscreen": "MainLayoutScreen" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L21 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_mainlayoutscreenstate": "_MainLayoutScreenState" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L37 | neighbors=[main_layout_screen.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-028.json

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
