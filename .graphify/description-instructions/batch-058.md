# Node Description Batch 59 of 68

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

- "test_math_evaluator_test_main": "main()" | kind=code-symbol | source=test/math_evaluator_test.dart:L5 | neighbors=[math_evaluator_test.dart]
- "test_module_notes_test_main": "main()" | kind=code-symbol | source=test/module_notes_test.dart:L7 | neighbors=[module_notes_test.dart]
- "test_page_mapping_test_main": "main()" | kind=code-symbol | source=test/page_mapping_test.dart:L4 | neighbors=[page_mapping_test.dart]
- "test_pdfx_test_main": "main()" | kind=code-symbol | source=test/pdfx_test.dart:L6 | neighbors=[pdfx_test.dart]
- "test_python_runner_test_invalid_syntax": "invalid_syntax()" | kind=code-symbol | source=test/python_runner_test.dart:L22 | neighbors=[python_runner_test.dart]
- "test_python_runner_test_main": "main()" | kind=code-symbol | source=test/python_runner_test.dart:L4 | neighbors=[python_runner_test.dart]
- "test_review_scheduler_test_main": "main()" | kind=code-symbol | source=test/review_scheduler_test.dart:L9 | neighbors=[review_scheduler_test.dart]
- "test_slide_parsing_test_main": "main()" | kind=code-symbol | source=test/slide_parsing_test.dart:L4 | neighbors=[slide_parsing_test.dart]
- "test_slide_parsing_test_para": "para()" | kind=code-symbol | source=test/slide_parsing_test.dart:L149 | neighbors=[slide_parsing_test.dart]
- "test_syncfusion_math_test_cleanlatexforsyncfusion": "cleanLatexForSyncfusion()" | kind=code-symbol | source=test/syncfusion_math_test.dart:L106 | neighbors=[syncfusion_math_test.dart]
- "test_syncfusion_math_test_main": "main()" | kind=code-symbol | source=test/syncfusion_math_test.dart:L7 | neighbors=[syncfusion_math_test.dart]
- "test_toc_matcher_test_main": "main()" | kind=code-symbol | source=test/toc_matcher_test.dart:L48 | neighbors=[toc_matcher_test.dart]
- "test_walkthrough_course_test_main": "main()" | kind=code-symbol | source=test/walkthrough_course_test.dart:L10 | neighbors=[walkthrough_course_test.dart]
- "test_webview_cef_method_channel_test": "webview_cef_method_channel_test.dart" | kind=code-symbol | source=packages/webview_cef/test/webview_cef_method_channel_test.dart:L1 | neighbors=[main()]
- "test_webview_cef_method_channel_test_main": "main()" | kind=code-symbol | source=packages/webview_cef/test/webview_cef_method_channel_test.dart:L5 | neighbors=[webview_cef_method_channel_test.dart]
- "test_webview_cef_test_getplatformversion": "getPlatformVersion()" | kind=code-symbol | source=packages/webview_cef/test/webview_cef_test.dart:L11 | neighbors=[webview_cef_test.dart]
- "test_webview_cef_test_main": "main()" | kind=code-symbol | source=packages/webview_cef/test/webview_cef_test.dart:L14 | neighbors=[webview_cef_test.dart]
- "test_webview_cef_test_mockwebviewcefplatform": "MockWebviewCefPlatform" | kind=code-symbol | source=packages/webview_cef/test/webview_cef_test.dart:L7 | neighbors=[webview_cef_test.dart]
- "test_webview_main_test": "webview_main_test.dart" | kind=code-symbol | source=packages/webview_cef/test/webview_main_test.dart:L1 | neighbors=[main()]
- "test_webview_main_test_main": "main()" | kind=code-symbol | source=packages/webview_cef/test/webview_main_test.dart:L6 | neighbors=[webview_main_test.dart]
- "test_widget_test_main": "main()" | kind=code-symbol | source=test/widget_test.dart:L10 | neighbors=[widget_test.dart]
- "theme_app_theme_appcolors": "AppColors" | kind=code-symbol | source=lib/theme/app_theme.dart:L9 | neighbors=[app_theme.dart]
- "theme_app_theme_apptheme": "AppTheme" | kind=code-symbol | source=lib/theme/app_theme.dart:L92 | neighbors=[app_theme.dart]
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

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-058.json

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
