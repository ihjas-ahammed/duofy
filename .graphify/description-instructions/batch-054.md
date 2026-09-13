# Node Description Batch 55 of 68

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

- "slide_views_fill_in_blank_view_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/slide_views/fill_in_blank_view.dart:L82 | neighbors=[fill_in_blank_view.dart]
- "slide_views_fill_in_blank_view_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/slide_views/fill_in_blank_view.dart:L94 | neighbors=[fill_in_blank_view.dart]
- "slide_views_fill_in_blank_view_fillinblankview": "FillInBlankView" | kind=code-symbol | source=lib/widgets/slide_views/fill_in_blank_view.dart:L17 | neighbors=[fill_in_blank_view.dart]
- "slide_views_fill_in_blank_view_fillinblankviewstate": "_FillInBlankViewState" | kind=code-symbol | source=lib/widgets/slide_views/fill_in_blank_view.dart:L41 | neighbors=[fill_in_blank_view.dart]
- "slide_views_fill_in_blank_view_initstate": "initState()" | kind=code-symbol | source=lib/widgets/slide_views/fill_in_blank_view.dart:L48 | neighbors=[fill_in_blank_view.dart]
- "slide_views_fill_in_blank_view_onsuggestiontapped": "_onSuggestionTapped()" | kind=code-symbol | source=lib/widgets/slide_views/fill_in_blank_view.dart:L99 | neighbors=[fill_in_blank_view.dart]
- "slide_views_flashcard_view_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/slide_views/flashcard_view.dart:L31 | neighbors=[flashcard_view.dart]
- "slide_views_flashcard_view_flashcardview": "FlashcardView" | kind=code-symbol | source=lib/widgets/slide_views/flashcard_view.dart:L12 | neighbors=[flashcard_view.dart]
- "slide_views_flashcard_view_flashcardviewstate": "_FlashcardViewState" | kind=code-symbol | source=lib/widgets/slide_views/flashcard_view.dart:L26 | neighbors=[flashcard_view.dart]
- "slide_views_flashcard_view_function": "Function()" | kind=code-symbol | source=lib/widgets/slide_views/flashcard_view.dart:L14 | neighbors=[flashcard_view.dart]
- "slide_views_flashcard_view_handlegrade": "_handleGrade()" | kind=code-symbol | source=lib/widgets/slide_views/flashcard_view.dart:L44 | neighbors=[flashcard_view.dart]
- "slide_views_flashcard_view_toggleflip": "_toggleFlip()" | kind=code-symbol | source=lib/widgets/slide_views/flashcard_view.dart:L39 | neighbors=[flashcard_view.dart]
- "slide_views_interactive_proof_view_checkanswer": "_checkAnswer()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L77 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L49 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_edittext": "_editText()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L142 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_function": "Function()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L13 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_handlenextinteractive": "_handleNextInteractive()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L99 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_handlenextstatic": "_handleNextStatic()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L63 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_handlepreviousstep": "_handlePreviousStep()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L134 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_initstate": "initState()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L43 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_interactiveproofview": "InteractiveProofView" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L10 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_interactiveproofviewstate": "_InteractiveProofViewState" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L32 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_resetinteraction": "_resetInteraction()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L126 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_saverevealedstep": "_saveRevealedStep()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L223 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_savestepoption": "_saveStepOption()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L213 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_savestepprompt": "_saveStepPrompt()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L206 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_savesteptext": "_saveStepText()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L199 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_webview_interactivewebview": "InteractiveWebview" | kind=code-symbol | source=lib/widgets/slide_views/interactive_webview.dart:L7 | neighbors=[interactive_webview.dart]
- "slide_views_interactive_webview_wraphtml": "_wrapHtml()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_webview.dart:L12 | neighbors=[interactive_webview.dart]
- "slide_views_matching_view_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/slide_views/matching_view.dart:L54 | neighbors=[matching_view.dart]
- "slide_views_matching_view_function": "Function()" | kind=code-symbol | source=lib/widgets/slide_views/matching_view.dart:L16 | neighbors=[matching_view.dart]
- "slide_views_matching_view_initslide": "_initSlide()" | kind=code-symbol | source=lib/widgets/slide_views/matching_view.dart:L61 | neighbors=[matching_view.dart]
- "slide_views_matching_view_initstate": "initState()" | kind=code-symbol | source=lib/widgets/slide_views/matching_view.dart:L48 | neighbors=[matching_view.dart]
- "slide_views_matching_view_ispaircorrect": "_isPairCorrect()" | kind=code-symbol | source=lib/widgets/slide_views/matching_view.dart:L72 | neighbors=[matching_view.dart]
- "slide_views_matching_view_matchingview": "MatchingView" | kind=code-symbol | source=lib/widgets/slide_views/matching_view.dart:L12 | neighbors=[matching_view.dart]
- "slide_views_matching_view_matchingviewstate": "_MatchingViewState" | kind=code-symbol | source=lib/widgets/slide_views/matching_view.dart:L32 | neighbors=[matching_view.dart]
- "slide_views_matching_view_resetmatches": "_resetMatches()" | kind=code-symbol | source=lib/widgets/slide_views/matching_view.dart:L117 | neighbors=[matching_view.dart]
- "slide_views_matching_view_tapleft": "_tapLeft()" | kind=code-symbol | source=lib/widgets/slide_views/matching_view.dart:L87 | neighbors=[matching_view.dart]
- "slide_views_matching_view_tapright": "_tapRight()" | kind=code-symbol | source=lib/widgets/slide_views/matching_view.dart:L96 | neighbors=[matching_view.dart]
- "slide_views_numerical_view_backspace": "_backspace()" | kind=code-symbol | source=lib/widgets/slide_views/numerical_view.dart:L84 | neighbors=[numerical_view.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-054.json

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
