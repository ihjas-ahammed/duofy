# Node Description Batch 48 of 61

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

- "services_usage_limit_service_hasownapikeysync": "hasOwnApiKeySync()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L179 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_incrementusage": "incrementUsage()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L245 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_init": "init()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L56 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_islimitexceeded": "isLimitExceeded()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L252 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_resetlocalusage": "_resetLocalUsage()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L140 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_syncwithbackend": "_syncWithBackend()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L92 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_usagelimitservice": "UsageLimitService" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L8 | neighbors=[usage_limit_service.dart]
- "services_walkthrough_service_advanceto": "advanceTo()" | kind=code-symbol | source=lib/services/walkthrough_service.dart:L69 | neighbors=[walkthrough_service.dart]
- "services_walkthrough_service_finish": "finish()" | kind=code-symbol | source=lib/services/walkthrough_service.dart:L74 | neighbors=[walkthrough_service.dart]
- "services_walkthrough_service_isdone": "isDone()" | kind=code-symbol | source=lib/services/walkthrough_service.dart:L82 | neighbors=[walkthrough_service.dart]
- "services_walkthrough_service_maybestart": "maybeStart()" | kind=code-symbol | source=lib/services/walkthrough_service.dart:L60 | neighbors=[walkthrough_service.dart]
- "services_walkthrough_service_seedexamplecourse": "seedExampleCourse()" | kind=code-symbol | source=lib/services/walkthrough_service.dart:L90 | neighbors=[walkthrough_service.dart]
- "services_walkthrough_service_walkthroughservice": "WalkthroughService" | kind=code-symbol | source=lib/services/walkthrough_service.dart:L33 | neighbors=[walkthrough_service.dart]
- "slide_views_code_runner_view_build": "build()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L528 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_capture_plot": "_capture_plot()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L674 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_coderunnerhtml": "CodeRunnerHtml" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L525 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_coderunnerview": "CodeRunnerView" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L18 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_coderunnerviewstate": "_CodeRunnerViewState" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L32 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L59 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_initstate": "initState()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L51 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_latex": "_latex()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L752 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_loadscript": "loadScript()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L626 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_python": "_python()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L596 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_render": "render()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L742 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_runcode": "runCode()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L690 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_s_onerror": "s.onerror()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L630 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_s_onload": "s.onload()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L629 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_shell": "_shell()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L549 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_submitrealtimeinput": "_submitRealtimeInput()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L66 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_unsupported": "_unsupported()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L789 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_web": "_web()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L713 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_window_initrunner": "window.__initRunner()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L736 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_window_onerror": "window.onerror()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L609 | neighbors=[code_runner_view.dart]
- "slide_views_concept_pieces_view_conceptpiecesview": "ConceptPiecesView" | kind=code-symbol | source=lib/widgets/slide_views/concept_pieces_view.dart:L7 | neighbors=[concept_pieces_view.dart]
- "slide_views_concept_pieces_view_paint": "paint()" | kind=code-symbol | source=lib/widgets/slide_views/concept_pieces_view.dart:L218 | neighbors=[concept_pieces_view.dart]
- "slide_views_concept_pieces_view_shouldrepaint": "shouldRepaint()" | kind=code-symbol | source=lib/widgets/slide_views/concept_pieces_view.dart:L276 | neighbors=[concept_pieces_view.dart]
- "slide_views_concept_pieces_view_timelinelinepainter": "_TimelineLinePainter" | kind=code-symbol | source=lib/widgets/slide_views/concept_pieces_view.dart:L204 | neighbors=[concept_pieces_view.dart]
- "slide_views_custom_html_view_customhtmlview": "CustomHtmlView" | kind=code-symbol | source=lib/widgets/slide_views/custom_html_view.dart:L8 | neighbors=[custom_html_view.dart]
- "slide_views_custom_html_view_customhtmlviewstate": "_CustomHtmlViewState" | kind=code-symbol | source=lib/widgets/slide_views/custom_html_view.dart:L22 | neighbors=[custom_html_view.dart]
- "slide_views_custom_html_view_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/slide_views/custom_html_view.dart:L26 | neighbors=[custom_html_view.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-047.json

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
