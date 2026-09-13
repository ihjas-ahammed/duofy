# Node Description Batch 33 of 68

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

- "screens_pdf_split_preview_screen_addsection": "_addSection()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L144 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_addunit": "_addUnit()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L186 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_commitsplits": "_commitSplits()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L509 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L659 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_generateuniqueid": "_generateUniqueId()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L140 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_in": "in" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L109 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_initcontrollers": "_initControllers()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L108 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L58 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_pdfsplitpreviewscreen": "PdfSplitPreviewScreen" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L13 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_pdfsplitpreviewscreenstate": "_PdfSplitPreviewScreenState" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L29 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_removemodule": "_removeModule()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L245 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_removesection": "_removeSection()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L171 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_removeunit": "_removeUnit()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L221 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_savetitle": "_saveTitle()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L293 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_shiftallpages": "_shiftAllPages()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L395 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_showshiftdialog": "_showShiftDialog()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L416 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_viewpage": "_viewPage()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L267 | neighbors=[pdf_split_preview_screen.dart]
- "screens_practice_screen_configureandstartpyq": "_configureAndStartPyq()" | kind=code-symbol | source=lib/screens/practice_screen.dart:L302 | neighbors=[practice_screen.dart]
- "screens_practice_screen_countfor": "_countFor()" | kind=code-symbol | source=lib/screens/practice_screen.dart:L281 | neighbors=[practice_screen.dart]
- "screens_practice_screen_function": "Function()" | kind=code-symbol | source=lib/screens/practice_screen.dart:L721 | neighbors=[practice_screen.dart]
- "screens_practice_screen_in": "in" | kind=code-symbol | source=lib/screens/practice_screen.dart:L141 | neighbors=[practice_screen.dart]
- "screens_practice_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/practice_screen.dart:L133 | neighbors=[practice_screen.dart]
- "screens_practice_screen_matchestype": "_matchesType()" | kind=code-symbol | source=lib/screens/practice_screen.dart:L222 | neighbors=[practice_screen.dart]
- "screens_practice_screen_modecard": "_ModeCard" | kind=code-symbol | source=lib/screens/practice_screen.dart:L859 | neighbors=[practice_screen.dart]
- "screens_practice_screen_moduleref": "_ModuleRef" | kind=code-symbol | source=lib/screens/practice_screen.dart:L38 | neighbors=[practice_screen.dart]
- "screens_practice_screen_practicemode": "_PracticeMode" | kind=code-symbol | source=lib/screens/practice_screen.dart:L44 | neighbors=[practice_screen.dart]
- "screens_practice_screen_practicescreen": "PracticeScreen" | kind=code-symbol | source=lib/screens/practice_screen.dart:L59 | neighbors=[practice_screen.dart]
- "screens_practice_screen_practicescreenstate": "_PracticeScreenState" | kind=code-symbol | source=lib/screens/practice_screen.dart:L68 | neighbors=[practice_screen.dart]
- "screens_practice_screen_resetsectionrange": "_resetSectionRange()" | kind=code-symbol | source=lib/screens/practice_screen.dart:L210 | neighbors=[practice_screen.dart]
- "screens_practice_screen_resetunitrange": "_resetUnitRange()" | kind=code-symbol | source=lib/screens/practice_screen.dart:L217 | neighbors=[practice_screen.dart]
- "screens_practice_screen_sectionref": "_SectionRef" | kind=code-symbol | source=lib/screens/practice_screen.dart:L24 | neighbors=[practice_screen.dart]
- "screens_practice_screen_startpractice": "_startPractice()" | kind=code-symbol | source=lib/screens/practice_screen.dart:L289 | neighbors=[practice_screen.dart]
- "screens_practice_screen_that": "that" | kind=code-symbol | source=lib/screens/practice_screen.dart:L37 | neighbors=[practice_screen.dart]
- "screens_practice_screen_unitref": "_UnitRef" | kind=code-symbol | source=lib/screens/practice_screen.dart:L10 | neighbors=[practice_screen.dart]
- "screens_practice_session_screen_cancheck": "_canCheck()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L528 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_checkanswer": "_checkAnswer()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L448 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_extractinteractiveslides": "_extractInteractiveSlides()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L130 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_finishpractice": "_finishPractice()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L247 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_getcorrectanswertext": "_getCorrectAnswerText()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L548 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_in": "in" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L88 | neighbors=[practice_session_screen.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-032.json

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
