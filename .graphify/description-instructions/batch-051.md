# Node Description Batch 52 of 61

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

- "src_webview_opendevtools": "openDevTools()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L128 | neighbors=[webview.dart]
- "src_webview_reload": "reload()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L104 | neighbors=[webview.dart]
- "src_webview_reportsurfacesize": "_reportSurfaceSize()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L456 | neighbors=[webview.dart]
- "src_webview_sendjavascriptchannelcallback": "sendJavaScriptChannelCallBack()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L177 | neighbors=[webview.dart]
- "src_webview_setclientfocus": "setClientFocus()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L154 | neighbors=[webview.dart]
- "src_webview_setjavascriptchannels": "setJavaScriptChannels()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L162 | neighbors=[webview.dart]
- "src_webview_setscrolldelta": "_setScrollDelta()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L242 | neighbors=[webview.dart]
- "src_webview_setsize": "_setSize()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L252 | neighbors=[webview.dart]
- "src_webview_textinput": "webview_textinput.dart" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_textinput.dart:L1 | neighbors=[onFocusReceived()]
- "src_webview_textinput_onfocusreceived": "onFocusReceived()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_textinput.dart:L79 | neighbors=[webview_textinput.dart]
- "src_webview_tooltip_buildoverlayentry": "_buildOverlayEntry()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_tooltip.dart:L19 | neighbors=[webview_tooltip.dart]
- "src_webview_tooltip_showtooltip": "showToolTip()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_tooltip.dart:L80 | neighbors=[webview_tooltip.dart]
- "src_webview_tooltip_webviewtooltip": "WebviewTooltip" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_tooltip.dart:L5 | neighbors=[webview_tooltip.dart]
- "src_webview_webview": "WebView" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L281 | neighbors=[webview.dart]
- "src_webview_webviewcontroller": "WebViewController" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L15 | neighbors=[webview.dart]
- "src_webview_webviewstate": "WebViewState" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L290 | neighbors=[webview.dart]
- "test_auto_index_pipeline_test_harness": "Harness" | kind=code-symbol | source=test/auto_index_pipeline_test.dart:L40 | neighbors=[auto_index_pipeline_test.dart]
- "test_auto_index_pipeline_test_main": "main()" | kind=code-symbol | source=test/auto_index_pipeline_test.dart:L61 | neighbors=[auto_index_pipeline_test.dart]
- "test_auto_index_pipeline_test_noprogress": "noProgress()" | kind=code-symbol | source=test/auto_index_pipeline_test.dart:L37 | neighbors=[auto_index_pipeline_test.dart]
- "test_mapping_verifier_test_fakepdfservice": "_FakePdfService" | kind=code-symbol | source=test/mapping_verifier_test.dart:L11 | neighbors=[mapping_verifier_test.dart]
- "test_mapping_verifier_test_main": "main()" | kind=code-symbol | source=test/mapping_verifier_test.dart:L68 | neighbors=[mapping_verifier_test.dart]
- "test_mapping_verifier_test_noai": "_NoAi" | kind=code-symbol | source=test/mapping_verifier_test.dart:L22 | neighbors=[mapping_verifier_test.dart]
- "test_mapping_verifier_test_verifysectionmapping": "verifySectionMapping()" | kind=code-symbol | source=test/mapping_verifier_test.dart:L24 | neighbors=[mapping_verifier_test.dart]
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

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-051.json

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
