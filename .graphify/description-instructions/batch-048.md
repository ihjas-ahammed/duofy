# Node Description Batch 49 of 61

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

- "slide_views_custom_html_view_handlemessage": "_handleMessage()" | kind=code-symbol | source=lib/widgets/slide_views/custom_html_view.dart:L146 | neighbors=[custom_html_view.dart]
- "slide_views_custom_html_view_setupchannelshim": "setupChannelShim()" | kind=code-symbol | source=lib/widgets/slide_views/custom_html_view.dart:L51 | neighbors=[custom_html_view.dart]
- "slide_views_custom_html_view_wraphtml": "_wrapHtml()" | kind=code-symbol | source=lib/widgets/slide_views/custom_html_view.dart:L38 | neighbors=[custom_html_view.dart]
- "slide_views_descriptive_view_checkanswer": "_checkAnswer()" | kind=code-symbol | source=lib/widgets/slide_views/descriptive_view.dart:L100 | neighbors=[descriptive_view.dart]
- "slide_views_descriptive_view_descriptiveview": "DescriptiveView" | kind=code-symbol | source=lib/widgets/slide_views/descriptive_view.dart:L13 | neighbors=[descriptive_view.dart]
- "slide_views_descriptive_view_descriptiveviewstate": "_DescriptiveViewState" | kind=code-symbol | source=lib/widgets/slide_views/descriptive_view.dart:L29 | neighbors=[descriptive_view.dart]
- "slide_views_descriptive_view_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/slide_views/descriptive_view.dart:L44 | neighbors=[descriptive_view.dart]
- "slide_views_descriptive_view_pickphotos": "_pickPhotos()" | kind=code-symbol | source=lib/widgets/slide_views/descriptive_view.dart:L71 | neighbors=[descriptive_view.dart]
- "slide_views_descriptive_view_removephoto": "_removePhoto()" | kind=code-symbol | source=lib/widgets/slide_views/descriptive_view.dart:L94 | neighbors=[descriptive_view.dart]
- "slide_views_descriptive_view_retry": "_retry()" | kind=code-symbol | source=lib/widgets/slide_views/descriptive_view.dart:L144 | neighbors=[descriptive_view.dart]
- "slide_views_descriptive_view_starttimer": "_startTimer()" | kind=code-symbol | source=lib/widgets/slide_views/descriptive_view.dart:L50 | neighbors=[descriptive_view.dart]
- "slide_views_error_spotting_view_errorspottingview": "ErrorSpottingView" | kind=code-symbol | source=lib/widgets/slide_views/error_spotting_view.dart:L4 | neighbors=[error_spotting_view.dart]
- "slide_views_fill_in_blank_view_blankoption": "_BlankOption" | kind=code-symbol | source=lib/widgets/slide_views/fill_in_blank_view.dart:L33 | neighbors=[fill_in_blank_view.dart]
- "slide_views_fill_in_blank_view_buildsuggestions": "_buildSuggestions()" | kind=code-symbol | source=lib/widgets/slide_views/fill_in_blank_view.dart:L54 | neighbors=[fill_in_blank_view.dart]
- "slide_views_fill_in_blank_view_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/slide_views/fill_in_blank_view.dart:L79 | neighbors=[fill_in_blank_view.dart]
- "slide_views_fill_in_blank_view_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/slide_views/fill_in_blank_view.dart:L91 | neighbors=[fill_in_blank_view.dart]
- "slide_views_fill_in_blank_view_fillinblankview": "FillInBlankView" | kind=code-symbol | source=lib/widgets/slide_views/fill_in_blank_view.dart:L8 | neighbors=[fill_in_blank_view.dart]
- "slide_views_fill_in_blank_view_fillinblankviewstate": "_FillInBlankViewState" | kind=code-symbol | source=lib/widgets/slide_views/fill_in_blank_view.dart:L40 | neighbors=[fill_in_blank_view.dart]
- "slide_views_fill_in_blank_view_initstate": "initState()" | kind=code-symbol | source=lib/widgets/slide_views/fill_in_blank_view.dart:L47 | neighbors=[fill_in_blank_view.dart]
- "slide_views_fill_in_blank_view_onsuggestiontapped": "_onSuggestionTapped()" | kind=code-symbol | source=lib/widgets/slide_views/fill_in_blank_view.dart:L96 | neighbors=[fill_in_blank_view.dart]
- "slide_views_flashcard_view_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/slide_views/flashcard_view.dart:L34 | neighbors=[flashcard_view.dart]
- "slide_views_flashcard_view_flashcardview": "FlashcardView" | kind=code-symbol | source=lib/widgets/slide_views/flashcard_view.dart:L15 | neighbors=[flashcard_view.dart]
- "slide_views_flashcard_view_flashcardviewstate": "_FlashcardViewState" | kind=code-symbol | source=lib/widgets/slide_views/flashcard_view.dart:L29 | neighbors=[flashcard_view.dart]
- "slide_views_flashcard_view_function": "Function()" | kind=code-symbol | source=lib/widgets/slide_views/flashcard_view.dart:L17 | neighbors=[flashcard_view.dart]
- "slide_views_interactive_proof_view_checkanswer": "_checkAnswer()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L91 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L62 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_edittext": "_editText()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L142 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_function": "Function()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L16 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_handlenextinteractive": "_handleNextInteractive()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L107 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_handlenextstatic": "_handleNextStatic()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L76 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_initstate": "initState()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L56 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_interactiveproofview": "InteractiveProofView" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L9 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_interactiveproofviewstate": "_InteractiveProofViewState" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L45 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_resetinteraction": "_resetInteraction()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L134 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_saverevealedstep": "_saveRevealedStep()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L223 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_savestepoption": "_saveStepOption()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L213 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_savestepprompt": "_saveStepPrompt()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L206 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_proof_view_savesteptext": "_saveStepText()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L199 | neighbors=[interactive_proof_view.dart]
- "slide_views_interactive_webview_interactivewebview": "InteractiveWebview" | kind=code-symbol | source=lib/widgets/slide_views/interactive_webview.dart:L7 | neighbors=[interactive_webview.dart]
- "slide_views_interactive_webview_wraphtml": "_wrapHtml()" | kind=code-symbol | source=lib/widgets/slide_views/interactive_webview.dart:L12 | neighbors=[interactive_webview.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-048.json

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
