# Node Description Batch 30 of 61

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

- "screens_main_layout_screen_onbookupdated": "_onBookUpdated()" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L80 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_opencoursesettings": "_openCourseSettings()" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L95 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_promptsyncpublishedbook": "_promptSyncPublishedBook()" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L234 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_publishbook": "_publishBook()" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L179 | neighbors=[main_layout_screen.dart]
- "screens_main_layout_screen_syncbook": "_syncBook()" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L200 | neighbors=[main_layout_screen.dart]
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
- "screens_module_notes_viewer_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L39 | neighbors=[module_notes_viewer_screen.dart]
- "screens_module_notes_viewer_screen_loadhtmlnotes": "_loadHtmlNotes()" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L44 | neighbors=[module_notes_viewer_screen.dart]
- "screens_module_notes_viewer_screen_modulenotesviewerscreen": "ModuleNotesViewerScreen" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L13 | neighbors=[module_notes_viewer_screen.dart]
- "screens_module_notes_viewer_screen_modulenotesviewerscreenstate": "_ModuleNotesViewerScreenState" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L33 | neighbors=[module_notes_viewer_screen.dart]
- "screens_module_notes_viewer_screen_onjsmessage": "_onJsMessage()" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L68 | neighbors=[module_notes_viewer_screen.dart]
- "screens_module_notes_viewer_screen_openinexternalbrowser": "_openInExternalBrowser()" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L80 | neighbors=[module_notes_viewer_screen.dart]
- "screens_module_notes_viewer_screen_printandsharepdf": "_printAndSharePdf()" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L101 | neighbors=[module_notes_viewer_screen.dart]
- "screens_module_selection_screen_bookmarkmatch": "_BookmarkMatch" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L1538 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_checknotesavailability": "_checkNotesAvailability()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L90 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L64 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_final": "final" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L1227 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L47 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_loadlastlessoninfo": "_loadLastLessonInfo()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L268 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_loadprogress": "_loadProgress()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L242 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_menuactionitem": "_MenuActionItem" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L1522 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_moduleselectionscreen": "ModuleSelectionScreen" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L23 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_moduleselectionscreenstate": "_ModuleSelectionScreenState" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L32 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_now": "now" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L824 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_ongenmanagerchanged": "_onGenManagerChanged()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L72 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_onjobupdate": "onJobUpdate()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L217 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_openmodulenotes": "_openModuleNotes()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L108 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_promptgenerateorschedulemodule": "_promptGenerateOrScheduleModule()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L880 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_promptregeneratenotes": "_promptRegenerateNotes()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L131 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_refreshbookfromstorage": "_refreshBookFromStorage()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L78 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_showbookmarksdialog": "_showBookmarksDialog()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L1147 | neighbors=[module_selection_screen.dart]

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
