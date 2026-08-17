# Node Description Batch 32 of 61

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
- "screens_practice_session_screen_cancheck": "_canCheck()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L521 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_checkanswer": "_checkAnswer()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L445 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_extractinteractiveslides": "_extractInteractiveSlides()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L129 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_finishpractice": "_finishPractice()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L246 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_getcorrectanswertext": "_getCorrectAnswerText()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L541 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_in": "in" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L87 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L71 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_istargettype": "_isTargetType()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L227 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_loadallslidesandextract": "_loadAllSlidesAndExtract()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L77 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_practicesessionscreen": "PracticeSessionScreen" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L25 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_practicesessionscreenstate": "_PracticeSessionScreenState" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L49 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_processnext": "_processNext()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L420 | neighbors=[practice_session_screen.dart]
- "screens_practice_session_screen_processnextpyqoneword": "_processNextPyqOneWord()" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L395 | neighbors=[practice_session_screen.dart]
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

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-031.json

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
