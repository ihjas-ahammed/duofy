# Node Description Batch 30 of 68

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

- "screens_home_screen_syncremotedata": "_syncRemoteData()" | kind=code-symbol | source=lib/screens/home_screen.dart:L256 | neighbors=[home_screen.dart]
- "screens_home_screen_togglelistview": "_toggleListView()" | kind=code-symbol | source=lib/screens/home_screen.dart:L90 | neighbors=[home_screen.dart]
- "screens_lesson_complete_screen_circulargaugepainter": "_CircularGaugePainter" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L1741 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_complete_screen_datestr": "dateStr()" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L1206 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_complete_screen_dayname": "dayName()" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L1205 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_complete_screen_difficulty": "difficulty" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L23 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_complete_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L105 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_complete_screen_dottedlinepainter": "_DottedLinePainter" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L1872 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_complete_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L67 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_complete_screen_lessoncompletescreen": "LessonCompleteScreen" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L16 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_complete_screen_lessoncompletescreenstate": "_LessonCompleteScreenState" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L56 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_complete_screen_openreviewmodal": "_openReviewModal()" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L192 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_complete_screen_paint": "paint()" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L1751 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_complete_screen_shareprogress": "_shareProgress()" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L184 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_complete_screen_shouldrepaint": "shouldRepaint()" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L1797 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_complete_screen_sparklinepainter": "_SparklinePainter" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L1802 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_complete_screen_starttargetedpractice": "_startTargetedPractice()" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L578 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_screen_applyslideedit": "_applySlideEdit()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L1428 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_buildslidequeue": "_buildSlideQueue()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L485 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_cancheck": "_canCheck()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L937 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_checkandpromptnextunitgeneration": "_checkAndPromptNextUnitGeneration()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L195 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_checkanswer": "_checkAnswer()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L650 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_confirmexit": "_confirmExit()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L1244 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L405 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_finishlesson": "_finishLesson()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L536 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_getcorrectanswertext": "_getCorrectAnswerText()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L975 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_hasenteredanswer": "_hasEnteredAnswer()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L954 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_initafterslidesready": "_initAfterSlidesReady()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L165 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L138 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_iscustombottombar": "_isCustomBottomBar()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L966 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_lessonscreen": "LessonScreen" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L40 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_lessonscreenstate": "_LessonScreenState" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L69 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_loadbookmarkstate": "_loadBookmarkState()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L377 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_loadslidesasync": "_loadSlidesAsync()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L152 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_nextmodidx": "nextModIdx" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L224 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_nextsecidx": "nextSecIdx" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L218 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_nextslide": "_nextSlide()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L508 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_ongenerationmanagerchange": "_onGenerationManagerChange()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L411 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_ontheorycontinue": "_onTheoryContinue()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L932 | neighbors=[lesson_screen.dart]
- "screens_lesson_screen_openassistant": "_openAssistant()" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L1370 | neighbors=[lesson_screen.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-029.json

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
