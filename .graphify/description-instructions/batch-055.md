# Node Description Batch 56 of 68

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

- "slide_views_numerical_view_clear": "_clear()" | kind=code-symbol | source=lib/widgets/slide_views/numerical_view.dart:L116 | neighbors=[numerical_view.dart]
- "slide_views_numerical_view_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/slide_views/numerical_view.dart:L45 | neighbors=[numerical_view.dart]
- "slide_views_numerical_view_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/slide_views/numerical_view.dart:L56 | neighbors=[numerical_view.dart]
- "slide_views_numerical_view_initstate": "initState()" | kind=code-symbol | source=lib/widgets/slide_views/numerical_view.dart:L38 | neighbors=[numerical_view.dart]
- "slide_views_numerical_view_inserttext": "_insertText()" | kind=code-symbol | source=lib/widgets/slide_views/numerical_view.dart:L62 | neighbors=[numerical_view.dart]
- "slide_views_numerical_view_numericalview": "NumericalView" | kind=code-symbol | source=lib/widgets/slide_views/numerical_view.dart:L10 | neighbors=[numerical_view.dart]
- "slide_views_numerical_view_numericalviewstate": "_NumericalViewState" | kind=code-symbol | source=lib/widgets/slide_views/numerical_view.dart:L32 | neighbors=[numerical_view.dart]
- "slide_views_numerical_view_togglesign": "_toggleSign()" | kind=code-symbol | source=lib/widgets/slide_views/numerical_view.dart:L123 | neighbors=[numerical_view.dart]
- "slide_views_one_word_view_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/slide_views/one_word_view.dart:L42 | neighbors=[one_word_view.dart]
- "slide_views_one_word_view_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/slide_views/one_word_view.dart:L53 | neighbors=[one_word_view.dart]
- "slide_views_one_word_view_initstate": "initState()" | kind=code-symbol | source=lib/widgets/slide_views/one_word_view.dart:L36 | neighbors=[one_word_view.dart]
- "slide_views_one_word_view_onewordview": "OneWordView" | kind=code-symbol | source=lib/widgets/slide_views/one_word_view.dart:L9 | neighbors=[one_word_view.dart]
- "slide_views_one_word_view_onewordviewstate": "_OneWordViewState" | kind=code-symbol | source=lib/widgets/slide_views/one_word_view.dart:L31 | neighbors=[one_word_view.dart]
- "slide_views_one_word_view_revealfirstletter": "_revealFirstLetter()" | kind=code-symbol | source=lib/widgets/slide_views/one_word_view.dart:L58 | neighbors=[one_word_view.dart]
- "slide_views_ordering_view_function": "Function()" | kind=code-symbol | source=lib/widgets/slide_views/ordering_view.dart:L16 | neighbors=[ordering_view.dart]
- "slide_views_ordering_view_initstate": "initState()" | kind=code-symbol | source=lib/widgets/slide_views/ordering_view.dart:L36 | neighbors=[ordering_view.dart]
- "slide_views_ordering_view_listequals": "_listEquals()" | kind=code-symbol | source=lib/widgets/slide_views/ordering_view.dart:L51 | neighbors=[ordering_view.dart]
- "slide_views_ordering_view_orderingview": "OrderingView" | kind=code-symbol | source=lib/widgets/slide_views/ordering_view.dart:L12 | neighbors=[ordering_view.dart]
- "slide_views_ordering_view_orderingviewstate": "_OrderingViewState" | kind=code-symbol | source=lib/widgets/slide_views/ordering_view.dart:L32 | neighbors=[ordering_view.dart]
- "slide_views_program_view_buildsuggestions": "_buildSuggestions()" | kind=code-symbol | source=lib/widgets/slide_views/program_view.dart:L54 | neighbors=[program_view.dart]
- "slide_views_program_view_codepanel": "_CodePanel" | kind=code-symbol | source=lib/widgets/slide_views/program_view.dart:L346 | neighbors=[program_view.dart]
- "slide_views_program_view_codepanelstate": "_CodePanelState" | kind=code-symbol | source=lib/widgets/slide_views/program_view.dart:L363 | neighbors=[program_view.dart]
- "slide_views_program_view_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/slide_views/program_view.dart:L69 | neighbors=[program_view.dart]
- "slide_views_program_view_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/slide_views/program_view.dart:L80 | neighbors=[program_view.dart]
- "slide_views_program_view_initstate": "initState()" | kind=code-symbol | source=lib/widgets/slide_views/program_view.dart:L48 | neighbors=[program_view.dart]
- "slide_views_program_view_programview": "ProgramView" | kind=code-symbol | source=lib/widgets/slide_views/program_view.dart:L13 | neighbors=[program_view.dart]
- "slide_views_program_view_programviewstate": "_ProgramViewState" | kind=code-symbol | source=lib/widgets/slide_views/program_view.dart:L37 | neighbors=[program_view.dart]
- "slide_views_program_view_runcode": "_runCode()" | kind=code-symbol | source=lib/widgets/slide_views/program_view.dart:L369 | neighbors=[program_view.dart]
- "slide_views_pyq_one_word_view_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/slide_views/pyq_one_word_view.dart:L32 | neighbors=[pyq_one_word_view.dart]
- "slide_views_pyq_one_word_view_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/slide_views/pyq_one_word_view.dart:L41 | neighbors=[pyq_one_word_view.dart]
- "slide_views_pyq_one_word_view_disposecontrollers": "_disposeControllers()" | kind=code-symbol | source=lib/widgets/slide_views/pyq_one_word_view.dart:L53 | neighbors=[pyq_one_word_view.dart]
- "slide_views_pyq_one_word_view_initcontrollers": "_initControllers()" | kind=code-symbol | source=lib/widgets/slide_views/pyq_one_word_view.dart:L46 | neighbors=[pyq_one_word_view.dart]
- "slide_views_pyq_one_word_view_initstate": "initState()" | kind=code-symbol | source=lib/widgets/slide_views/pyq_one_word_view.dart:L26 | neighbors=[pyq_one_word_view.dart]
- "slide_views_pyq_one_word_view_pyqonewordview": "PyqOneWordView" | kind=code-symbol | source=lib/widgets/slide_views/pyq_one_word_view.dart:L6 | neighbors=[pyq_one_word_view.dart]
- "slide_views_pyq_one_word_view_pyqonewordviewstate": "_PyqOneWordViewState" | kind=code-symbol | source=lib/widgets/slide_views/pyq_one_word_view.dart:L22 | neighbors=[pyq_one_word_view.dart]
- "slide_views_quiz_view_editoption": "_editOption()" | kind=code-symbol | source=lib/widgets/slide_views/quiz_view.dart:L27 | neighbors=[quiz_view.dart]
- "slide_views_quiz_view_function": "Function()" | kind=code-symbol | source=lib/widgets/slide_views/quiz_view.dart:L14 | neighbors=[quiz_view.dart]
- "slide_views_quiz_view_quizview": "QuizView" | kind=code-symbol | source=lib/widgets/slide_views/quiz_view.dart:L9 | neighbors=[quiz_view.dart]
- "slide_views_slide_action_button_handletapup": "_handleTapUp()" | kind=code-symbol | source=lib/widgets/slide_views/slide_action_button.dart:L33 | neighbors=[slide_action_button.dart]
- "slide_views_slide_action_button_slideactionbutton": "SlideActionButton" | kind=code-symbol | source=lib/widgets/slide_views/slide_action_button.dart:L6 | neighbors=[slide_action_button.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-055.json

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
