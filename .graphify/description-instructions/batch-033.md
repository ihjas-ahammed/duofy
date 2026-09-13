# Node Description Batch 34 of 68

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

- "screens_practice_session_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L72 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_istargettype": "_isTargetType()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L228 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_loadallslidesandextract": "_loadAllSlidesAndExtract()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L78 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_practicesessionscreen": "PracticeSessionScreen" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L25 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_practicesessionscreenstate": "_PracticeSessionScreenState" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L49 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_processnext": "_processNext()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L423 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_processnextpyqoneword": "_processNextPyqOneWord()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L398 | neighbors=[practice_session_screen.dart]
- "screens_pyq_complete_screen_formatduration": "_formatDuration()" | kind=code-symbol | source=lib/screens/pyq_complete_screen.dart:L20 | neighbors=[pyq_complete_screen.dart]
- "screens_pyq_complete_screen_pyqcompletescreen": "PyqCompleteScreen" | kind=code-symbol | source=lib/screens/pyq_complete_screen.dart:L8 | neighbors=[pyq_complete_screen.dart]
- "screens_pyq_complete_screen_statcard": "_StatCard" | kind=code-symbol | source=lib/screens/pyq_complete_screen.dart:L306 | neighbors=[pyq_complete_screen.dart]
- "screens_pyq_exam_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/pyq_exam_screen.dart:L47 | neighbors=[pyq_exam_screen.dart]
- "screens_pyq_exam_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/pyq_exam_screen.dart:L36 | neighbors=[pyq_exam_screen.dart]
- "screens_pyq_exam_screen_pickimageforquestion": "_pickImageForQuestion()" | kind=code-symbol | source=lib/screens/pyq_exam_screen.dart:L54 | neighbors=[pyq_exam_screen.dart]
- "screens_pyq_exam_screen_pyqexamscreen": "PyqExamScreen" | kind=code-symbol | source=lib/screens/pyq_exam_screen.dart:L12 | neighbors=[pyq_exam_screen.dart]
- "screens_pyq_exam_screen_pyqexamscreenstate": "_PyqExamScreenState" | kind=code-symbol | source=lib/screens/pyq_exam_screen.dart:L30 | neighbors=[pyq_exam_screen.dart]
- "screens_pyq_exam_screen_removeimage": "_removeImage()" | kind=code-symbol | source=lib/screens/pyq_exam_screen.dart:L77 | neighbors=[pyq_exam_screen.dart]
- "screens_pyq_exam_screen_submitexam": "_submitExam()" | kind=code-symbol | source=lib/screens/pyq_exam_screen.dart:L83 | neighbors=[pyq_exam_screen.dart]
- "screens_pyq_panel_screen_and": "and" | kind=code-symbol | source=lib/screens/pyq_panel_screen.dart:L235 | neighbors=[pyq_panel_screen.dart]
- "screens_pyq_panel_screen_attachbackgroundjoblistener": "_attachBackgroundJobListener()" | kind=code-symbol | source=lib/screens/pyq_panel_screen.dart:L64 | neighbors=[pyq_panel_screen.dart]
- "screens_pyq_panel_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/pyq_panel_screen.dart:L57 | neighbors=[pyq_panel_screen.dart]
- "screens_pyq_panel_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/pyq_panel_screen.dart:L49 | neighbors=[pyq_panel_screen.dart]
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

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-033.json

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
