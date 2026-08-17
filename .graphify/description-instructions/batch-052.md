# Node Description Batch 53 of 61

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
For an entity node (any other kind — e.g. a person, place, event, object),
describe what the entity is and its role, grounded in its type, its
relations (neighbors) and the provided citations/evidence — e.g.
"Lady Carfax, a wealthy heiress who disappears en route to Lausanne.".
Ground entity descriptions in the citations/evidence when present; do not
speculate beyond the context, so a node with no supporting context may be
left out of the reply.
Write every description in English (en). Do not switch languages.
No marketing language.
Respond ONLY with a JSON object mapping each node id (as a string) to its
one-sentence description — no prose, no markdown fences.

- "test_webview_cef_test_mockwebviewcefplatform": "MockWebviewCefPlatform" | kind=code-symbol | source=packages/webview_cef/test/webview_cef_test.dart:L7 | neighbors=[webview_cef_test.dart]
- "test_webview_main_test": "webview_main_test.dart" | kind=code-symbol | source=packages/webview_cef/test/webview_main_test.dart:L1 | neighbors=[main()]
- "test_webview_main_test_main": "main()" | kind=code-symbol | source=packages/webview_cef/test/webview_main_test.dart:L6 | neighbors=[webview_main_test.dart]
- "test_widget_test_main": "main()" | kind=code-symbol | source=test/widget_test.dart:L10 | neighbors=[widget_test.dart]
- "theme_app_theme_appcolors": "AppColors" | kind=code-symbol | source=lib/theme/app_theme.dart:L9 | neighbors=[app_theme.dart]
- "theme_app_theme_apptheme": "AppTheme" | kind=code-symbol | source=lib/theme/app_theme.dart:L74 | neighbors=[app_theme.dart]
- "update_rationale_13": "Parses the snapshot content and yields (filename, file_content) tuples." | kind=entity | source=update.py:L13 | neighbors=[parse_snapshot()]
- "update_rationale_71": "Reads the snapshot file and updates the project files accordingly." | kind=entity | source=update.py:L71 | neighbors=[update_project_from_snapshot()]
- "utils_latex_utils_autowrapbarelatexinsegment": "_autoWrapBareLatexInSegment()" | kind=code-symbol | source=lib/utils/latex_utils.dart:L122 | neighbors=[latex_utils.dart]
- "utils_latex_utils_fixuncloseddisplaymath": "_fixUnclosedDisplayMath()" | kind=code-symbol | source=lib/utils/latex_utils.dart:L48 | neighbors=[latex_utils.dart]
- "utils_latex_utils_fixunclosedinlinemath": "_fixUnclosedInlineMath()" | kind=code-symbol | source=lib/utils/latex_utils.dart:L68 | neighbors=[latex_utils.dart]
- "utils_latex_utils_fixunclosedlatex": "fixUnclosedLatex()" | kind=code-symbol | source=lib/utils/latex_utils.dart:L22 | neighbors=[latex_utils.dart]
- "utils_latex_utils_latexutils": "LatexUtils" | kind=code-symbol | source=lib/utils/latex_utils.dart:L5 | neighbors=[latex_utils.dart]
- "utils_latex_utils_textpart": "_TextPart" | kind=code-symbol | source=lib/utils/latex_utils.dart:L217 | neighbors=[latex_utils.dart]
- "utils_latex_utils_wrapbarelatexcommands": "_wrapBareLatexCommands()" | kind=code-symbol | source=lib/utils/latex_utils.dart:L107 | neighbors=[latex_utils.dart]
- "utils_progress_utils_calculatemoduleprogress": "calculateModuleProgress()" | kind=code-symbol | source=lib/utils/progress_utils.dart:L48 | neighbors=[progress_utils.dart]
- "utils_progress_utils_calculatemoduleprogressdouble": "calculateModuleProgressDouble()" | kind=code-symbol | source=lib/utils/progress_utils.dart:L34 | neighbors=[progress_utils.dart]
- "utils_progress_utils_calculatesectionprogress": "calculateSectionProgress()" | kind=code-symbol | source=lib/utils/progress_utils.dart:L30 | neighbors=[progress_utils.dart]
- "utils_progress_utils_calculatesectionprogressdouble": "calculateSectionProgressDouble()" | kind=code-symbol | source=lib/utils/progress_utils.dart:L16 | neighbors=[progress_utils.dart]
- "utils_progress_utils_calculateunitprogress": "calculateUnitProgress()" | kind=code-symbol | source=lib/utils/progress_utils.dart:L5 | neighbors=[progress_utils.dart]
- "utils_progress_utils_sectioncolors": "SectionColors" | kind=code-symbol | source=lib/utils/progress_utils.dart:L52 | neighbors=[progress_utils.dart]
- "utils_toast_utils_showtoast": "showToast()" | kind=code-symbol | source=lib/utils/toast_utils.dart:L5 | neighbors=[toast_utils.dart]
- "widgets_analytics_view_analyticsview": "AnalyticsView" | kind=code-symbol | source=lib/widgets/analytics_view.dart:L9 | neighbors=[analytics_view.dart]
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

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-052.json

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
