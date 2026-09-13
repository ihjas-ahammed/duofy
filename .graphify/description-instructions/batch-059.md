# Node Description Batch 60 of 68

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

- "widgets_analytics_view_analyticsviewstate": "_AnalyticsViewState" | kind=code-symbol | source=lib/widgets/analytics_view.dart:L18 | neighbors=[analytics_view.dart]
- "widgets_analytics_view_calculateavgaccuracy": "_calculateAvgAccuracy()" | kind=code-symbol | source=lib/widgets/analytics_view.dart:L178 | neighbors=[analytics_view.dart]
- "widgets_analytics_view_calculatestreak": "_calculateStreak()" | kind=code-symbol | source=lib/widgets/analytics_view.dart:L138 | neighbors=[analytics_view.dart]
- "widgets_analytics_view_formatdate": "formatDate()" | kind=code-symbol | source=lib/widgets/analytics_view.dart:L149 | neighbors=[analytics_view.dart]
- "widgets_analytics_view_formatdatestring": "_formatDateString()" | kind=code-symbol | source=lib/widgets/analytics_view.dart:L198 | neighbors=[analytics_view.dart]
- "widgets_analytics_view_formattimespent": "_formatTimeSpent()" | kind=code-symbol | source=lib/widgets/analytics_view.dart:L184 | neighbors=[analytics_view.dart]
- "widgets_analytics_view_initstate": "initState()" | kind=code-symbol | source=lib/widgets/analytics_view.dart:L22 | neighbors=[analytics_view.dart]
- "widgets_analytics_view_loaddata": "_loadData()" | kind=code-symbol | source=lib/widgets/analytics_view.dart:L27 | neighbors=[analytics_view.dart]
- "widgets_book_card_bookcard": "BookCard" | kind=code-symbol | source=lib/widgets/book_card.dart:L6 | neighbors=[book_card.dart]
- "widgets_calibration_card_calibrationcard": "CalibrationCard" | kind=code-symbol | source=lib/widgets/calibration_card.dart:L10 | neighbors=[calibration_card.dart]
- "widgets_canvas_art_view_canvasartview": "CanvasArtView" | kind=code-symbol | source=lib/widgets/canvas_art_view.dart:L23 | neighbors=[canvas_art_view.dart]
- "widgets_canvas_art_view_canvasartviewstate": "_CanvasArtViewState" | kind=code-symbol | source=lib/widgets/canvas_art_view.dart:L53 | neighbors=[canvas_art_view.dart]
- "widgets_canvas_art_view_canvasplaceholder": "_CanvasPlaceholder" | kind=code-symbol | source=lib/widgets/canvas_art_view.dart:L275 | neighbors=[canvas_art_view.dart]
- "widgets_canvas_art_view_canvasplaceholderstate": "_CanvasPlaceholderState" | kind=code-symbol | source=lib/widgets/canvas_art_view.dart:L289 | neighbors=[canvas_art_view.dart]
- "widgets_canvas_art_view_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/canvas_art_view.dart:L57 | neighbors=[canvas_art_view.dart]
- "widgets_canvas_art_view_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/canvas_art_view.dart:L318 | neighbors=[canvas_art_view.dart]
- "widgets_canvas_art_view_function": "Function()" | kind=code-symbol | source=lib/widgets/canvas_art_view.dart:L31 | neighbors=[canvas_art_view.dart]
- "widgets_canvas_art_view_handlejserror": "_handleJsError()" | kind=code-symbol | source=lib/widgets/canvas_art_view.dart:L65 | neighbors=[canvas_art_view.dart]
- "widgets_canvas_art_view_handlesvgerror": "_handleSvgError()" | kind=code-symbol | source=lib/widgets/canvas_art_view.dart:L75 | neighbors=[canvas_art_view.dart]
- "widgets_canvas_art_view_initstate": "initState()" | kind=code-symbol | source=lib/widgets/canvas_art_view.dart:L293 | neighbors=[canvas_art_view.dart]
- "widgets_canvas_art_view_starttimerifneeded": "_startTimerIfNeeded()" | kind=code-symbol | source=lib/widgets/canvas_art_view.dart:L304 | neighbors=[canvas_art_view.dart]
- "widgets_canvas_html_view_buildcanvashtml": "buildCanvasHtml()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L118 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_canvasaspect": "canvasAspect()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L63 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_canvasdoubletapdetector": "CanvasDoubleTapDetector" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L493 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_canvasdoubletapdetectorstate": "_CanvasDoubleTapDetectorState" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L508 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_canvasfullscreenscreen": "_CanvasFullScreenScreen" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L425 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_canvashtmlview": "CanvasHtmlView" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L353 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_draw": "draw()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L115 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_issvgcanvas": "isSvgCanvas()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L24 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_needsthreejs": "_needsThreeJs()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L105 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_render": "_render()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L256 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_send": "send()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L233 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_setupchannelshim": "setupChannelShim()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L144 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_showcanvascodedialog": "showCanvasCodeDialog()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L530 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_showcanvasfullscreen": "showCanvasFullScreen()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L416 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_showerror": "_showError()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L221 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_sizecanvas": "_sizeCanvas()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L210 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_sketch": "sketch()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L114 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_svgaspect": "svgAspect()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L33 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_waitforlayout": "_waitForLayout()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L321 | neighbors=[canvas_html_view.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-059.json

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
