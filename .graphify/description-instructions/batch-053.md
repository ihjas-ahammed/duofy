# Node Description Batch 54 of 68

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

- "slide_views_code_runner_view_runcode": "runCode()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L954 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_s_onerror": "s.onerror()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L895 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_s_onload": "s.onload()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L894 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_shell": "_shell()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L815 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_submitrealtimeinput": "_submitRealtimeInput()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L96 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_unsupported": "_unsupported()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L1049 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_web": "_web()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L976 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_window_initrunner": "window.__initRunner()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L998 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_window_onerror": "window.onerror()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L874 | neighbors=[code_runner_view.dart]
- "slide_views_concept_pieces_view_conceptpiecesview": "ConceptPiecesView" | kind=code-symbol | source=lib/widgets/slide_views/concept_pieces_view.dart:L10 | neighbors=[concept_pieces_view.dart]
- "slide_views_concept_pieces_view_conceptpiecesviewstate": "_ConceptPiecesViewState" | kind=code-symbol | source=lib/widgets/slide_views/concept_pieces_view.dart:L30 | neighbors=[concept_pieces_view.dart]
- "slide_views_concept_pieces_view_conceptschematicpainter": "_ConceptSchematicPainter" | kind=code-symbol | source=lib/widgets/slide_views/concept_pieces_view.dart:L690 | neighbors=[concept_pieces_view.dart]
- "slide_views_concept_pieces_view_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/slide_views/concept_pieces_view.dart:L54 | neighbors=[concept_pieces_view.dart]
- "slide_views_concept_pieces_view_initstate": "initState()" | kind=code-symbol | source=lib/widgets/slide_views/concept_pieces_view.dart:L45 | neighbors=[concept_pieces_view.dart]
- "slide_views_concept_pieces_view_openassemblesheet": "_openAssembleSheet()" | kind=code-symbol | source=lib/widgets/slide_views/concept_pieces_view.dart:L125 | neighbors=[concept_pieces_view.dart]
- "slide_views_concept_pieces_view_paint": "paint()" | kind=code-symbol | source=lib/widgets/slide_views/concept_pieces_view.dart:L708 | neighbors=[concept_pieces_view.dart]
- "slide_views_concept_pieces_view_parsedconceptpiece": "_ParsedConceptPiece" | kind=code-symbol | source=lib/widgets/slide_views/concept_pieces_view.dart:L673 | neighbors=[concept_pieces_view.dart]
- "slide_views_concept_pieces_view_shouldrepaint": "shouldRepaint()" | kind=code-symbol | source=lib/widgets/slide_views/concept_pieces_view.dart:L856 | neighbors=[concept_pieces_view.dart]
- "slide_views_concept_pieces_view_timelinelinepainter": "_TimelineLinePainter" | kind=code-symbol | source=lib/widgets/slide_views/concept_pieces_view.dart:L204 | neighbors=[concept_pieces_view.dart]
- "slide_views_custom_html_view_customhtmlview": "CustomHtmlView" | kind=code-symbol | source=lib/widgets/slide_views/custom_html_view.dart:L8 | neighbors=[custom_html_view.dart]
- "slide_views_custom_html_view_customhtmlviewstate": "_CustomHtmlViewState" | kind=code-symbol | source=lib/widgets/slide_views/custom_html_view.dart:L22 | neighbors=[custom_html_view.dart]
- "slide_views_custom_html_view_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/slide_views/custom_html_view.dart:L26 | neighbors=[custom_html_view.dart]
- "slide_views_custom_html_view_handlemessage": "_handleMessage()" | kind=code-symbol | source=lib/widgets/slide_views/custom_html_view.dart:L146 | neighbors=[custom_html_view.dart]
- "slide_views_custom_html_view_setupchannelshim": "setupChannelShim()" | kind=code-symbol | source=lib/widgets/slide_views/custom_html_view.dart:L51 | neighbors=[custom_html_view.dart]
- "slide_views_custom_html_view_wraphtml": "_wrapHtml()" | kind=code-symbol | source=lib/widgets/slide_views/custom_html_view.dart:L38 | neighbors=[custom_html_view.dart]
- "slide_views_descriptive_view_checkanswer": "_checkAnswer()" | kind=code-symbol | source=lib/widgets/slide_views/descriptive_view.dart:L101 | neighbors=[descriptive_view.dart]
- "slide_views_descriptive_view_descriptiveview": "DescriptiveView" | kind=code-symbol | source=lib/widgets/slide_views/descriptive_view.dart:L13 | neighbors=[descriptive_view.dart]
- "slide_views_descriptive_view_descriptiveviewstate": "_DescriptiveViewState" | kind=code-symbol | source=lib/widgets/slide_views/descriptive_view.dart:L29 | neighbors=[descriptive_view.dart]
- "slide_views_descriptive_view_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/slide_views/descriptive_view.dart:L44 | neighbors=[descriptive_view.dart]
- "slide_views_descriptive_view_pickphotos": "_pickPhotos()" | kind=code-symbol | source=lib/widgets/slide_views/descriptive_view.dart:L71 | neighbors=[descriptive_view.dart]
- "slide_views_descriptive_view_removephoto": "_removePhoto()" | kind=code-symbol | source=lib/widgets/slide_views/descriptive_view.dart:L95 | neighbors=[descriptive_view.dart]
- "slide_views_descriptive_view_retry": "_retry()" | kind=code-symbol | source=lib/widgets/slide_views/descriptive_view.dart:L145 | neighbors=[descriptive_view.dart]
- "slide_views_descriptive_view_starttimer": "_startTimer()" | kind=code-symbol | source=lib/widgets/slide_views/descriptive_view.dart:L50 | neighbors=[descriptive_view.dart]
- "slide_views_error_spotting_view_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/slide_views/error_spotting_view.dart:L42 | neighbors=[error_spotting_view.dart]
- "slide_views_error_spotting_view_errorspottingview": "ErrorSpottingView" | kind=code-symbol | source=lib/widgets/slide_views/error_spotting_view.dart:L10 | neighbors=[error_spotting_view.dart]
- "slide_views_error_spotting_view_errorspottingviewstate": "_ErrorSpottingViewState" | kind=code-symbol | source=lib/widgets/slide_views/error_spotting_view.dart:L32 | neighbors=[error_spotting_view.dart]
- "slide_views_error_spotting_view_initstate": "initState()" | kind=code-symbol | source=lib/widgets/slide_views/error_spotting_view.dart:L36 | neighbors=[error_spotting_view.dart]
- "slide_views_error_spotting_view_onsteptap": "_onStepTap()" | kind=code-symbol | source=lib/widgets/slide_views/error_spotting_view.dart:L51 | neighbors=[error_spotting_view.dart]
- "slide_views_fill_in_blank_view_blankoption": "_BlankOption" | kind=code-symbol | source=lib/widgets/slide_views/fill_in_blank_view.dart:L9 | neighbors=[fill_in_blank_view.dart]
- "slide_views_fill_in_blank_view_buildsuggestions": "_buildSuggestions()" | kind=code-symbol | source=lib/widgets/slide_views/fill_in_blank_view.dart:L55 | neighbors=[fill_in_blank_view.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-053.json

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
