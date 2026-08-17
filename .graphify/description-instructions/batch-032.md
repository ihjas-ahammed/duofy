# Node Description Batch 33 of 61

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

- "screens_pyq_panel_screen_loadpyqbank": "_loadPyqBank()" | kind=code-symbol | source=lib/screens/pyq_panel_screen.dart:L93 | neighbors=[pyq_panel_screen.dart]
- "screens_pyq_panel_screen_onjobupdated": "_onJobUpdated()" | kind=code-symbol | source=lib/screens/pyq_panel_screen.dart:L72 | neighbors=[pyq_panel_screen.dart]
- "screens_pyq_panel_screen_openexamsetup": "_openExamSetup()" | kind=code-symbol | source=lib/screens/pyq_panel_screen.dart:L113 | neighbors=[pyq_panel_screen.dart]
- "screens_pyq_panel_screen_openscorehistory": "_openScoreHistory()" | kind=code-symbol | source=lib/screens/pyq_panel_screen.dart:L105 | neighbors=[pyq_panel_screen.dart]
- "screens_pyq_panel_screen_pickfromdocumentstore": "_pickFromDocumentStore()" | kind=code-symbol | source=lib/screens/pyq_panel_screen.dart:L304 | neighbors=[pyq_panel_screen.dart]
- "screens_pyq_panel_screen_picklocalfiles": "_pickLocalFiles()" | kind=code-symbol | source=lib/screens/pyq_panel_screen.dart:L285 | neighbors=[pyq_panel_screen.dart]
- "screens_pyq_panel_screen_pyqpanelscreen": "PyqPanelScreen" | kind=code-symbol | source=lib/screens/pyq_panel_screen.dart:L19 | neighbors=[pyq_panel_screen.dart]
- "screens_pyq_panel_screen_pyqpanelscreenstate": "_PyqPanelScreenState" | kind=code-symbol | source=lib/screens/pyq_panel_screen.dart:L31 | neighbors=[pyq_panel_screen.dart]
- "screens_pyq_panel_screen_saveanalyzedquestions": "_saveAnalyzedQuestions()" | kind=code-symbol | source=lib/screens/pyq_panel_screen.dart:L392 | neighbors=[pyq_panel_screen.dart]
- "screens_pyq_panel_screen_startanalysis": "_startAnalysis()" | kind=code-symbol | source=lib/screens/pyq_panel_screen.dart:L360 | neighbors=[pyq_panel_screen.dart]
- "screens_pyq_panel_screen_startexam": "_startExam()" | kind=code-symbol | source=lib/screens/pyq_panel_screen.dart:L234 | neighbors=[pyq_panel_screen.dart]
- "screens_pyq_panel_screen_syncstatewithjob": "_syncStateWithJob()" | kind=code-symbol | source=lib/screens/pyq_panel_screen.dart:L82 | neighbors=[pyq_panel_screen.dart]
- "screens_pyq_score_history_screen_formatdate": "_formatDate()" | kind=code-symbol | source=lib/screens/pyq_score_history_screen.dart:L52 | neighbors=[pyq_score_history_screen.dart]
- "screens_pyq_score_history_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/pyq_score_history_screen.dart:L29 | neighbors=[pyq_score_history_screen.dart]
- "screens_pyq_score_history_screen_loadhistory": "_loadHistory()" | kind=code-symbol | source=lib/screens/pyq_score_history_screen.dart:L34 | neighbors=[pyq_score_history_screen.dart]
- "screens_pyq_score_history_screen_opendetail": "_openDetail()" | kind=code-symbol | source=lib/screens/pyq_score_history_screen.dart:L44 | neighbors=[pyq_score_history_screen.dart]
- "screens_pyq_score_history_screen_pyqexamdetailscreen": "PyqExamDetailScreen" | kind=code-symbol | source=lib/screens/pyq_score_history_screen.dart:L160 | neighbors=[pyq_score_history_screen.dart]
- "screens_pyq_score_history_screen_pyqscorehistoryscreen": "PyqScoreHistoryScreen" | kind=code-symbol | source=lib/screens/pyq_score_history_screen.dart:L12 | neighbors=[pyq_score_history_screen.dart]
- "screens_pyq_score_history_screen_pyqscorehistoryscreenstate": "_PyqScoreHistoryScreenState" | kind=code-symbol | source=lib/screens/pyq_score_history_screen.dart:L24 | neighbors=[pyq_score_history_screen.dart]
- "screens_pyq_score_history_screen_retakeexam": "_retakeExam()" | kind=code-symbol | source=lib/screens/pyq_score_history_screen.dart:L170 | neighbors=[pyq_score_history_screen.dart]
- "screens_pyq_tab_screen_addquestion": "_addQuestion()" | kind=code-symbol | source=lib/screens/pyq_tab_screen.dart:L271 | neighbors=[pyq_tab_screen.dart]
- "screens_pyq_tab_screen_checkandshownoquestionsalert": "_checkAndShowNoQuestionsAlert()" | kind=code-symbol | source=lib/screens/pyq_tab_screen.dart:L845 | neighbors=[pyq_tab_screen.dart]
- "screens_pyq_tab_screen_currently": "currently" | kind=code-symbol | source=lib/screens/pyq_tab_screen.dart:L22 | neighbors=[pyq_tab_screen.dart]
- "screens_pyq_tab_screen_deletequestion": "_deleteQuestion()" | kind=code-symbol | source=lib/screens/pyq_tab_screen.dart:L760 | neighbors=[pyq_tab_screen.dart]
- "screens_pyq_tab_screen_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/screens/pyq_tab_screen.dart:L61 | neighbors=[pyq_tab_screen.dart]
- "screens_pyq_tab_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/pyq_tab_screen.dart:L176 | neighbors=[pyq_tab_screen.dart]
- "screens_pyq_tab_screen_editquestion": "_editQuestion()" | kind=code-symbol | source=lib/screens/pyq_tab_screen.dart:L616 | neighbors=[pyq_tab_screen.dart]
- "screens_pyq_tab_screen_initcachedir": "_initCacheDir()" | kind=code-symbol | source=lib/screens/pyq_tab_screen.dart:L68 | neighbors=[pyq_tab_screen.dart]
- "screens_pyq_tab_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/pyq_tab_screen.dart:L46 | neighbors=[pyq_tab_screen.dart]
- "screens_pyq_tab_screen_pickfiles": "_pickFiles()" | kind=code-symbol | source=lib/screens/pyq_tab_screen.dart:L183 | neighbors=[pyq_tab_screen.dart]
- "screens_pyq_tab_screen_pyqtabscreen": "PyqTabScreen" | kind=code-symbol | source=lib/screens/pyq_tab_screen.dart:L18 | neighbors=[pyq_tab_screen.dart]
- "screens_pyq_tab_screen_pyqtabscreenstate": "_PyqTabScreenState" | kind=code-symbol | source=lib/screens/pyq_tab_screen.dart:L37 | neighbors=[pyq_tab_screen.dart]
- "screens_pyq_tab_screen_saveallquestions": "_saveAllQuestions()" | kind=code-symbol | source=lib/screens/pyq_tab_screen.dart:L257 | neighbors=[pyq_tab_screen.dart]
- "screens_pyq_tab_screen_selectfromstore": "_selectFromStore()" | kind=code-symbol | source=lib/screens/pyq_tab_screen.dart:L77 | neighbors=[pyq_tab_screen.dart]
- "screens_pyq_tab_screen_startanalysis": "_startAnalysis()" | kind=code-symbol | source=lib/screens/pyq_tab_screen.dart:L197 | neighbors=[pyq_tab_screen.dart]
- "screens_pyq_tab_screen_updatebookandsave": "_updateBookAndSave()" | kind=code-symbol | source=lib/screens/pyq_tab_screen.dart:L249 | neighbors=[pyq_tab_screen.dart]
- "screens_python_ide_screen_addcell": "_addCell()" | kind=code-symbol | source=lib/screens/python_ide_screen.dart:L162 | neighbors=[python_ide_screen.dart]
- "screens_python_ide_screen_clearoutputs": "_clearOutputs()" | kind=code-symbol | source=lib/screens/python_ide_screen.dart:L173 | neighbors=[python_ide_screen.dart]
- "screens_python_ide_screen_deletecell": "_deleteCell()" | kind=code-symbol | source=lib/screens/python_ide_screen.dart:L182 | neighbors=[python_ide_screen.dart]
- "screens_python_ide_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/python_ide_screen.dart:L89 | neighbors=[python_ide_screen.dart]

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
