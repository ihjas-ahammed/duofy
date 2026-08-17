# Node Description Batch 27 of 61

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

- "screens_document_store_screen_showcontextmenu": "_showContextMenu()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L666 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_showcreatesemesterdialog": "_showCreateSemesterDialog()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L492 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_showcreatesubjectdialog": "_showCreateSubjectDialog()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L428 | neighbors=[document_store_screen.dart]
- "screens_exam_screen_examscreen": "ExamScreen" | kind=code-symbol | source=lib/screens/exam_screen.dart:L11 | neighbors=[exam_screen.dart]
- "screens_exam_screen_openqp": "_openQp()" | kind=code-symbol | source=lib/screens/exam_screen.dart:L16 | neighbors=[exam_screen.dart]
- "screens_experiments_screen_cancheck": "_canCheck()" | kind=code-symbol | source=lib/screens/experiments_screen.dart:L612 | neighbors=[experiments_screen.dart]
- "screens_experiments_screen_checkanswer": "_checkAnswer()" | kind=code-symbol | source=lib/screens/experiments_screen.dart:L552 | neighbors=[experiments_screen.dart]
- "screens_experiments_screen_experimentpreviewscreen": "ExperimentPreviewScreen" | kind=code-symbol | source=lib/screens/experiments_screen.dart:L511 | neighbors=[experiments_screen.dart]
- "screens_experiments_screen_experimentpreviewscreenstate": "_ExperimentPreviewScreenState" | kind=code-symbol | source=lib/screens/experiments_screen.dart:L520 | neighbors=[experiments_screen.dart]
- "screens_experiments_screen_experimentsscreen": "ExperimentsScreen" | kind=code-symbol | source=lib/screens/experiments_screen.dart:L24 | neighbors=[experiments_screen.dart]
- "screens_experiments_screen_experimentsscreenstate": "_ExperimentsScreenState" | kind=code-symbol | source=lib/screens/experiments_screen.dart:L31 | neighbors=[experiments_screen.dart]
- "screens_experiments_screen_getcorrectanswertext": "_getCorrectAnswerText()" | kind=code-symbol | source=lib/screens/experiments_screen.dart:L637 | neighbors=[experiments_screen.dart]
- "screens_experiments_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/experiments_screen.dart:L265 | neighbors=[experiments_screen.dart]
- "screens_experiments_screen_iscustombottombar": "_isCustomBottomBar()" | kind=code-symbol | source=lib/screens/experiments_screen.dart:L629 | neighbors=[experiments_screen.dart]
- "screens_experiments_screen_loadpreset": "_loadPreset()" | kind=code-symbol | source=lib/screens/experiments_screen.dart:L270 | neighbors=[experiments_screen.dart]
- "screens_experiments_screen_parseandsetslide": "_parseAndSetSlide()" | kind=code-symbol | source=lib/screens/experiments_screen.dart:L279 | neighbors=[experiments_screen.dart]
- "screens_experiments_screen_resetslidestate": "_resetSlideState()" | kind=code-symbol | source=lib/screens/experiments_screen.dart:L540 | neighbors=[experiments_screen.dart]
- "screens_generate_book_screen_deepsearchbookusingai": "_deepSearchBookUsingAi()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L813 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L138 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_documentstorepickerdialog": "_DocumentStorePickerDialog" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L1611 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_documentstorepickerdialogstate": "_DocumentStorePickerDialogState" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L1621 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_downloadandselectb2objectpdf": "_downloadAndSelectB2ObjectPdf()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L892 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_downloadandselectbookpdf": "_downloadAndSelectBookPdf()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L865 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_downloadprogressdialog": "_DownloadProgressDialog" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L2040 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_downloadprogressdialogstate": "_DownloadProgressDialogState" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L2050 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_generate": "_generate()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L984 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_generatebookscreen": "GenerateBookScreen" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L22 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_generatebookscreenstate": "_GenerateBookScreenState" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L29 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_handlefileselection": "_handleFileSelection()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L222 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_initcachedir": "_initCacheDir()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L1649 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L94 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_ispdfcached": "_isPdfCached()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L1685 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_issyllabusbookmatch": "_isSyllabusBookMatch()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L921 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_loadfiles": "_loadFiles()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L1658 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_loadpreferences": "_loadPreferences()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L128 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_matchbookusingai": "_matchBookUsingAi()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L398 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_ontextchanged": "_onTextChanged()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L112 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_pickfiles": "_pickFiles()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L145 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_scansyllabusforbooks": "_scanSyllabusForBooks()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L262 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_seedwalkthroughcourse": "_seedWalkthroughCourse()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L957 | neighbors=[generate_book_screen.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-026.json

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
