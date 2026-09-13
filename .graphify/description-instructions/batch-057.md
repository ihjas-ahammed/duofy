# Node Description Batch 58 of 68

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

- "src_webview_manager_initialize": "initialize()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_manager.dart:L49 | neighbors=[webview_manager.dart]
- "src_webview_manager_injectuserscriptifneeds": "_injectUserScriptIfNeeds()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_manager.dart:L157 | neighbors=[webview_manager.dart]
- "src_webview_manager_methodcallhandler": "methodCallhandler()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_manager.dart:L80 | neighbors=[webview_manager.dart]
- "src_webview_manager_onbrowsercreated": "onBrowserCreated()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_manager.dart:L75 | neighbors=[webview_manager.dart]
- "src_webview_manager_quit": "quit()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_manager.dart:L187 | neighbors=[webview_manager.dart]
- "src_webview_manager_removewebview": "removeWebView()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_manager.dart:L41 | neighbors=[webview_manager.dart]
- "src_webview_manager_setcookie": "setCookie()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_manager.dart:L167 | neighbors=[webview_manager.dart]
- "src_webview_manager_visitallcookies": "visitAllCookies()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_manager.dart:L177 | neighbors=[webview_manager.dart]
- "src_webview_manager_visiturlcookies": "visitUrlCookies()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_manager.dart:L182 | neighbors=[webview_manager.dart]
- "src_webview_manager_webviewmanager": "WebviewManager" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_manager.dart:L10 | neighbors=[webview_manager.dart]
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
- "test_canvas_html_eval_test_draw": "draw()" | kind=code-symbol | source=test/canvas_html_eval_test.dart:L9 | neighbors=[canvas_html_eval_test.dart]
- "test_canvas_html_eval_test_main": "main()" | kind=code-symbol | source=test/canvas_html_eval_test.dart:L5 | neighbors=[canvas_html_eval_test.dart]
- "test_canvas_html_eval_test_sketch": "sketch()" | kind=code-symbol | source=test/canvas_html_eval_test.dart:L41 | neighbors=[canvas_html_eval_test.dart]
- "test_latex_ide_test_apostrophes": "apostrophes()" | kind=code-symbol | source=test/latex_ide_test.dart:L17 | neighbors=[latex_ide_test.dart]
- "test_latex_ide_test_main": "main()" | kind=code-symbol | source=test/latex_ide_test.dart:L6 | neighbors=[latex_ide_test.dart]
- "test_latex_json_mapping_test_main": "main()" | kind=code-symbol | source=test/latex_json_mapping_test.dart:L5 | neighbors=[latex_json_mapping_test.dart]
- "test_lesson_formats_limit_and_filter_test_main": "main()" | kind=code-symbol | source=test/lesson_formats_limit_and_filter_test.dart:L4 | neighbors=[lesson_formats_limit_and_filter_test.da…]
- "test_mapping_verifier_test_fakepdfservice": "_FakePdfService" | kind=code-symbol | source=test/mapping_verifier_test.dart:L11 | neighbors=[mapping_verifier_test.dart]
- "test_mapping_verifier_test_main": "main()" | kind=code-symbol | source=test/mapping_verifier_test.dart:L68 | neighbors=[mapping_verifier_test.dart]
- "test_mapping_verifier_test_noai": "_NoAi" | kind=code-symbol | source=test/mapping_verifier_test.dart:L22 | neighbors=[mapping_verifier_test.dart]
- "test_mapping_verifier_test_verifysectionmapping": "verifySectionMapping()" | kind=code-symbol | source=test/mapping_verifier_test.dart:L24 | neighbors=[mapping_verifier_test.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-057.json

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
