# Node Description Batch 51 of 61

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

- "slide_views_quiz_view_function": "Function()" | kind=code-symbol | source=lib/widgets/slide_views/quiz_view.dart:L17 | neighbors=[quiz_view.dart]
- "slide_views_quiz_view_quizview": "QuizView" | kind=code-symbol | source=lib/widgets/slide_views/quiz_view.dart:L8 | neighbors=[quiz_view.dart]
- "slide_views_step_by_step_view_stepbystepview": "StepByStepView" | kind=code-symbol | source=lib/widgets/slide_views/step_by_step_view.dart:L8 | neighbors=[step_by_step_view.dart]
- "slide_views_step_by_step_view_stepbystepviewstate": "_StepByStepViewState" | kind=code-symbol | source=lib/widgets/slide_views/step_by_step_view.dart:L22 | neighbors=[step_by_step_view.dart]
- "slide_views_theory_view_theoryview": "TheoryView" | kind=code-symbol | source=lib/widgets/slide_views/theory_view.dart:L6 | neighbors=[theory_view.dart]
- "src_webview_assertjavascriptchannelnamesareunique": "_assertJavascriptChannelNamesAreUnique()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L267 | neighbors=[webview.dart]
- "src_webview_cursorclickdown": "_cursorClickDown()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L223 | neighbors=[webview.dart]
- "src_webview_cursorclickup": "_cursorClickUp()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L232 | neighbors=[webview.dart]
- "src_webview_cursordragging": "_cursorDragging()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L214 | neighbors=[webview.dart]
- "src_webview_cursormove": "_cursorMove()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L205 | neighbors=[webview.dart]
- "src_webview_dispose": "dispose()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L84 | neighbors=[webview.dart]
- "src_webview_evaluatejavascript": "evaluateJavascript()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L195 | neighbors=[webview.dart]
- "src_webview_events_listener_function": "Function()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_events_listener.dart:L3 | neighbors=[webview_events_listener.dart]
- "src_webview_events_listener_webvieweventslistener": "WebviewEventsListener" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_events_listener.dart:L20 | neighbors=[webview_events_listener.dart]
- "src_webview_executejavascript": "executeJavaScript()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L187 | neighbors=[webview.dart]
- "src_webview_goback": "goBack()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L120 | neighbors=[webview.dart]
- "src_webview_goforward": "goForward()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L112 | neighbors=[webview.dart]
- "src_webview_imecommittext": "imeCommitText()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L145 | neighbors=[webview.dart]
- "src_webview_imesetcomposition": "imeSetComposition()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L136 | neighbors=[webview.dart]
- "src_webview_initialize": "initialize()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L58 | neighbors=[webview.dart]
- "src_webview_initstate": "initState()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L334 | neighbors=[webview.dart]
- "src_webview_inject_user_script_add": "add()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_inject_user_script.dart:L13 | neighbors=[webview_inject_user_script.dart]
- "src_webview_inject_user_script_injectuserscripts": "InjectUserScripts" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_inject_user_script.dart:L10 | neighbors=[webview_inject_user_script.dart]
- "src_webview_inject_user_script_userscript": "UserScript" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_inject_user_script.dart:L3 | neighbors=[webview_inject_user_script.dart]
- "src_webview_javascript_javascriptchannel": "JavascriptChannel" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_javascript.dart:L21 | neighbors=[webview_javascript.dart]
- "src_webview_javascript_javascriptmessage": "JavascriptMessage" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_javascript.dart:L3 | neighbors=[webview_javascript.dart]
- "src_webview_javascript_javascriptmessagehandler": "JavascriptMessageHandler()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_javascript.dart:L48 | neighbors=[webview_javascript.dart]
- "src_webview_loadurl": "loadUrl()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L95 | neighbors=[webview.dart]
- "src_webview_manager_deletecookie": "deleteCookie()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_manager.dart:L172 | neighbors=[webview_manager.dart]
- "src_webview_manager_dispose": "dispose()" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_manager.dart:L69 | neighbors=[webview_manager.dart]
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

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-050.json

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
