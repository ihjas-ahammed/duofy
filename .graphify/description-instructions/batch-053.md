# Node Description Batch 54 of 61

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

- "widgets_canvas_art_view_handlejserror": "_handleJsError()" | kind=code-symbol | source=lib/widgets/canvas_art_view.dart:L65 | neighbors=[canvas_art_view.dart]
- "widgets_canvas_art_view_handlesvgerror": "_handleSvgError()" | kind=code-symbol | source=lib/widgets/canvas_art_view.dart:L75 | neighbors=[canvas_art_view.dart]
- "widgets_canvas_art_view_initstate": "initState()" | kind=code-symbol | source=lib/widgets/canvas_art_view.dart:L293 | neighbors=[canvas_art_view.dart]
- "widgets_canvas_art_view_starttimerifneeded": "_startTimerIfNeeded()" | kind=code-symbol | source=lib/widgets/canvas_art_view.dart:L304 | neighbors=[canvas_art_view.dart]
- "widgets_canvas_html_view_buildcanvashtml": "buildCanvasHtml()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L118 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_canvasaspect": "canvasAspect()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L63 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_canvasdoubletapdetector": "CanvasDoubleTapDetector" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L491 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_canvasdoubletapdetectorstate": "_CanvasDoubleTapDetectorState" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L506 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_canvasfullscreenscreen": "_CanvasFullScreenScreen" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L423 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_canvashtmlview": "CanvasHtmlView" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L351 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_draw": "draw()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L115 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_issvgcanvas": "isSvgCanvas()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L24 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_needsthreejs": "_needsThreeJs()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L105 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_render": "_render()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L254 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_send": "send()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L231 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_setupchannelshim": "setupChannelShim()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L143 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_showcanvascodedialog": "showCanvasCodeDialog()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L528 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_showcanvasfullscreen": "showCanvasFullScreen()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L414 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_showerror": "_showError()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L219 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_sizecanvas": "_sizeCanvas()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L209 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_sketch": "sketch()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L114 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_svgaspect": "svgAspect()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L33 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_waitforlayout": "_waitForLayout()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L319 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_window_console_error": "window.console.error()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L198 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_window_console_log": "window.console.log()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L192 | neighbors=[canvas_html_view.dart]
- "widgets_coach_mark_coachmark": "CoachMark" | kind=code-symbol | source=lib/widgets/coach_mark.dart:L8 | neighbors=[coach_mark.dart]
- "widgets_coach_mark_coachmarkcontroller": "CoachMarkController" | kind=code-symbol | source=lib/widgets/coach_mark.dart:L23 | neighbors=[coach_mark.dart]
- "widgets_coach_mark_holepainter": "_HolePainter" | kind=code-symbol | source=lib/widgets/coach_mark.dart:L165 | neighbors=[coach_mark.dart]
- "widgets_coach_mark_maybeshow": "maybeShow()" | kind=code-symbol | source=lib/widgets/coach_mark.dart:L26 | neighbors=[coach_mark.dart]
- "widgets_coach_mark_paint": "paint()" | kind=code-symbol | source=lib/widgets/coach_mark.dart:L170 | neighbors=[coach_mark.dart]
- "widgets_coach_mark_shouldrepaint": "shouldRepaint()" | kind=code-symbol | source=lib/widgets/coach_mark.dart:L183 | neighbors=[coach_mark.dart]
- "widgets_coach_mark_showone": "_showOne()" | kind=code-symbol | source=lib/widgets/coach_mark.dart:L50 | neighbors=[coach_mark.dart]
- "widgets_code_highlighter_codeeditingcontroller": "CodeEditingController" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L259 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_codehighlighter": "CodeHighlighter" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L7 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_codetheme": "CodeTheme" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L215 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_isdigit": "_isDigit()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L201 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_isidentpart": "_isIdentPart()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L210 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_isidentstart": "_isIdentStart()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L205 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_isnumberchar": "_isNumberChar()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L202 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_linecomment": "_lineComment()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L49 | neighbors=[code_highlighter.dart]

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
