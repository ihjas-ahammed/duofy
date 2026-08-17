# Node Description Batch 28 of 61

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

- "screens_generate_book_screen_selectfromstore": "_selectFromStore()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L172 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_showhandoutprompt": "_showHandoutPrompt()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L1078 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_showsyllabusbooksdialog": "_showSyllabusBooksDialog()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L454 | neighbors=[generate_book_screen.dart]
- "screens_generate_book_screen_startdownload": "_startDownload()" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L2061 | neighbors=[generate_book_screen.dart]
- "screens_generate_qp_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/generate_qp_screen.dart:L26 | neighbors=[generate_qp_screen.dart]
- "screens_generate_qp_screen_generate": "_generate()" | kind=code-symbol | source=lib/screens/generate_qp_screen.dart:L50 | neighbors=[generate_qp_screen.dart]
- "screens_generate_qp_screen_generateqpscreen": "GenerateQpScreen" | kind=code-symbol | source=lib/screens/generate_qp_screen.dart:L11 | neighbors=[generate_qp_screen.dart]
- "screens_generate_qp_screen_generateqpscreenstate": "_GenerateQpScreenState" | kind=code-symbol | source=lib/screens/generate_qp_screen.dart:L20 | neighbors=[generate_qp_screen.dart]
- "screens_generate_qp_screen_pickfiles": "_pickFiles()" | kind=code-symbol | source=lib/screens/generate_qp_screen.dart:L32 | neighbors=[generate_qp_screen.dart]
- "screens_home_screen_checkforappupdate": "_checkForAppUpdate()" | kind=code-symbol | source=lib/screens/home_screen.dart:L144 | neighbors=[home_screen.dart]
- "screens_home_screen_deletelocalbook": "_deleteLocalBook()" | kind=code-symbol | source=lib/screens/home_screen.dart:L395 | neighbors=[home_screen.dart]
- "screens_home_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/home_screen.dart:L167 | neighbors=[home_screen.dart]
- "screens_home_screen_extractsnippet": "_extractSnippet()" | kind=code-symbol | source=lib/screens/home_screen.dart:L3268 | neighbors=[home_screen.dart]
- "screens_home_screen_getdensitykey": "getDensityKey()" | kind=code-symbol | source=lib/screens/home_screen.dart:L2811 | neighbors=[home_screen.dart]
- "screens_home_screen_getfolderprogress": "_getFolderProgress()" | kind=code-symbol | source=lib/screens/home_screen.dart:L3606 | neighbors=[home_screen.dart]
- "screens_home_screen_handlegeneratingcardtap": "_handleGeneratingCardTap()" | kind=code-symbol | source=lib/screens/home_screen.dart:L325 | neighbors=[home_screen.dart]
- "screens_home_screen_handlegenerationtaskschange": "_handleGenerationTasksChange()" | kind=code-symbol | source=lib/screens/home_screen.dart:L183 | neighbors=[home_screen.dart]
- "screens_home_screen_handleprogresschange": "_handleProgressChange()" | kind=code-symbol | source=lib/screens/home_screen.dart:L177 | neighbors=[home_screen.dart]
- "screens_home_screen_handlewalkthroughstep": "_handleWalkthroughStep()" | kind=code-symbol | source=lib/screens/home_screen.dart:L162 | neighbors=[home_screen.dart]
- "screens_home_screen_homescreen": "HomeScreen" | kind=code-symbol | source=lib/screens/home_screen.dart:L48 | neighbors=[home_screen.dart]
- "screens_home_screen_homescreenstate": "_HomeScreenState" | kind=code-symbol | source=lib/screens/home_screen.dart:L55 | neighbors=[home_screen.dart]
- "screens_home_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/home_screen.dart:L99 | neighbors=[home_screen.dart]
- "screens_home_screen_loadalldata": "_loadAllData()" | kind=code-symbol | source=lib/screens/home_screen.dart:L199 | neighbors=[home_screen.dart]
- "screens_home_screen_loadlistviewpreference": "_loadListViewPreference()" | kind=code-symbol | source=lib/screens/home_screen.dart:L83 | neighbors=[home_screen.dart]
- "screens_home_screen_maybestartwalkthrough": "_maybeStartWalkthrough()" | kind=code-symbol | source=lib/screens/home_screen.dart:L152 | neighbors=[home_screen.dart]
- "screens_home_screen_promptgenerateorschedulebook": "_promptGenerateOrScheduleBook()" | kind=code-symbol | source=lib/screens/home_screen.dart:L3135 | neighbors=[home_screen.dart]
- "screens_home_screen_resetbookprogress": "_resetBookProgress()" | kind=code-symbol | source=lib/screens/home_screen.dart:L3087 | neighbors=[home_screen.dart]
- "screens_home_screen_searchresultitem": "SearchResultItem" | kind=code-symbol | source=lib/screens/home_screen.dart:L4109 | neighbors=[home_screen.dart]
- "screens_home_screen_showbooklongpressmenu": "_showBookLongPressMenu()" | kind=code-symbol | source=lib/screens/home_screen.dart:L2416 | neighbors=[home_screen.dart]
- "screens_home_screen_showcreatefolderdialog": "_showCreateFolderDialog()" | kind=code-symbol | source=lib/screens/home_screen.dart:L3619 | neighbors=[home_screen.dart]
- "screens_home_screen_showeditcustomindexdialog": "_showEditCustomIndexDialog()" | kind=code-symbol | source=lib/screens/home_screen.dart:L2782 | neighbors=[home_screen.dart]
- "screens_home_screen_showfolderoptions": "_showFolderOptions()" | kind=code-symbol | source=lib/screens/home_screen.dart:L3684 | neighbors=[home_screen.dart]
- "screens_home_screen_showmovebooktofolderdialog": "_showMoveBookToFolderDialog()" | kind=code-symbol | source=lib/screens/home_screen.dart:L4026 | neighbors=[home_screen.dart]
- "screens_home_screen_showpublishedbooklongpressmenu": "_showPublishedBookLongPressMenu()" | kind=code-symbol | source=lib/screens/home_screen.dart:L1350 | neighbors=[home_screen.dart]
- "screens_home_screen_showrenamefolderdialog": "_showRenameFolderDialog()" | kind=code-symbol | source=lib/screens/home_screen.dart:L3791 | neighbors=[home_screen.dart]
- "screens_home_screen_syncremotedata": "_syncRemoteData()" | kind=code-symbol | source=lib/screens/home_screen.dart:L256 | neighbors=[home_screen.dart]
- "screens_home_screen_togglelistview": "_toggleListView()" | kind=code-symbol | source=lib/screens/home_screen.dart:L90 | neighbors=[home_screen.dart]
- "screens_lesson_complete_screen_difficulty": "difficulty" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L20 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_complete_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L82 | neighbors=[lesson_complete_screen.dart]
- "screens_lesson_complete_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L59 | neighbors=[lesson_complete_screen.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-027.json

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
