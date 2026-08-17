# Node Description Batch 16 of 61

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

- "common_webview_handler_reload": "reload()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L428 | neighbors=[webview_handler.h]
- "common_webview_handler_sendjavascriptchannelcallback": "sendJavaScriptChannelCallBack()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L570 | neighbors=[webview_handler.h]
- "common_webview_handler_sendkeyevent": "sendKeyEvent()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L397 | neighbors=[webview_handler.h]
- "common_webview_handler_sendscrollevent": "sendScrollEvent()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L287 | neighbors=[webview_handler.h]
- "common_webview_handler_setclientfocus": "setClientFocus()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L491 | neighbors=[webview_handler.h]
- "common_webview_handler_setcookie": "setCookie()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L500 | neighbors=[webview_handler.h]
- "common_webview_handler_startdragging": "StartDragging()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L355 | neighbors=[webview_handler.h]
- "common_webview_handler_visitallcookies": "visitAllCookies()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L528 | neighbors=[webview_handler.h]
- "common_webview_handler_visiturlcookies": "visitUrlCookies()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L541 | neighbors=[webview_handler.h]
- "common_webview_handler_webviewhandler": "WebviewHandler()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L52 | neighbors=[webview_handler.h]
- "common_webview_js_handler_cefjsbridge": "CefJSBridge()" | kind=code-symbol | source=packages/webview_cef/common/webview_js_handler.h:L31 | neighbors=[webview_js_handler.h]
- "common_webview_js_handler_cefjshandler": "CefJSHandler()" | kind=code-symbol | source=packages/webview_cef/common/webview_js_handler.h:L53 | neighbors=[webview_js_handler.h]
- "common_webview_js_handler_executejscallbackfunc": "ExecuteJSCallbackFunc()" | kind=code-symbol | source=packages/webview_cef/common/webview_js_handler.cc:L301 | neighbors=[webview_js_handler.h]
- "common_webview_js_handler_removecallbackfuncwithframe": "RemoveCallbackFuncWithFrame()" | kind=code-symbol | source=packages/webview_cef/common/webview_js_handler.cc:L276 | neighbors=[webview_js_handler.h]
- "common_webview_plugin_domessageloopwork": "doMessageLoopWork()" | kind=code-symbol | source=packages/webview_cef/common/webview_plugin.cc:L601 | neighbors=[webview_plugin.h]
- "common_webview_plugin_getanybrowserfocused": "getAnyBrowserFocused()" | kind=code-symbol | source=packages/webview_cef/common/webview_plugin.cc:L507 | neighbors=[webview_plugin.h]
- "common_webview_plugin_initcefprocesses": "initCEFProcesses()" | kind=code-symbol | source=packages/webview_cef/common/webview_plugin.cc:L541 | neighbors=[webview_plugin.h]
- "common_webview_plugin_sendkeyevent": "sendKeyEvent()" | kind=code-symbol | source=packages/webview_cef/common/webview_plugin.cc:L486 | neighbors=[webview_plugin.h]
- "common_webview_plugin_setcreatetexturefunc": "setCreateTextureFunc()" | kind=code-symbol | source=packages/webview_cef/common/webview_plugin.cc:L502 | neighbors=[webview_plugin.h]
- "common_webview_plugin_setinvokemethodfunc": "setInvokeMethodFunc()" | kind=code-symbol | source=packages/webview_cef/common/webview_plugin.cc:L498 | neighbors=[webview_plugin.h]
- "common_webview_plugin_swapbufferfrombgratorgba": "SwapBufferFromBgraToRgba()" | kind=code-symbol | source=packages/webview_cef/common/webview_plugin.cc:L605 | neighbors=[webview_plugin.h]
- "common_webview_plugin_webview_cef": "webview_cef()" | kind=code-symbol | source=packages/webview_cef/common/webview_plugin.h:L9 | neighbors=[webview_plugin.h]
- "common_webview_value_webview_value_get_type": "webview_value_get_type()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L362 | neighbors=[webview_value.h]
- "data_mock_books_draw": "draw()" | kind=code-symbol | source=lib/data/mock_books.dart:L134 | neighbors=[mock_books.dart]
- "data_mock_books_resize": "resize()" | kind=code-symbol | source=lib/data/mock_books.dart:L128 | neighbors=[mock_books.dart]
- "dev_programming_slides_screen_programcard": "_ProgramCard" | kind=code-symbol | source=lib/screens/dev/programming_slides_screen.dart:L134 | neighbors=[programming_slides_screen.dart]
- "dev_programming_slides_screen_programcardstate": "_ProgramCardState" | kind=code-symbol | source=lib/screens/dev/programming_slides_screen.dart:L142 | neighbors=[programming_slides_screen.dart]
- "dev_programming_slides_screen_programmingslidesscreen": "ProgrammingSlidesScreen" | kind=code-symbol | source=lib/screens/dev/programming_slides_screen.dart:L13 | neighbors=[programming_slides_screen.dart]
- "dev_programming_slides_screen_runnercard": "_RunnerCard" | kind=code-symbol | source=lib/screens/dev/programming_slides_screen.dart:L184 | neighbors=[programming_slides_screen.dart]
- "fb_fb_auth_createuserwithemailandpassword": "createUserWithEmailAndPassword()" | kind=code-symbol | source=lib/services/fb/fb_auth.dart:L46 | neighbors=[fb_auth.dart]
- "fb_fb_auth_faauth": "_FaAuth" | kind=code-symbol | source=lib/services/fb/fb_auth.dart:L51 | neighbors=[fb_auth.dart]
- "fb_fb_auth_fauser": "_FaUser" | kind=code-symbol | source=lib/services/fb/fb_auth.dart:L26 | neighbors=[fb_auth.dart]
- "fb_fb_auth_fbauth": "FbAuth" | kind=code-symbol | source=lib/services/fb/fb_auth.dart:L39 | neighbors=[fb_auth.dart]
- "fb_fb_auth_fbauthexception": "FbAuthException" | kind=code-symbol | source=lib/services/fb/fb_auth.dart:L5 | neighbors=[fb_auth.dart]
- "fb_fb_auth_fbuser": "FbUser" | kind=code-symbol | source=lib/services/fb/fb_auth.dart:L15 | neighbors=[fb_auth.dart]
- "fb_fb_auth_signinwithemailandpassword": "signInWithEmailAndPassword()" | kind=code-symbol | source=lib/services/fb/fb_auth.dart:L44 | neighbors=[fb_auth.dart]
- "fb_fb_auth_signout": "signOut()" | kind=code-symbol | source=lib/services/fb/fb_auth.dart:L48 | neighbors=[fb_auth.dart]
- "fb_fb_auth_tostring": "toString()" | kind=code-symbol | source=lib/services/fb/fb_auth.dart:L9 | neighbors=[fb_auth.dart]
- "fb_fb_auth_updatedisplayname": "updateDisplayName()" | kind=code-symbol | source=lib/services/fb/fb_auth.dart:L23 | neighbors=[fb_auth.dart]
- "fb_fb_core_fbcore": "FbCore" | kind=code-symbol | source=lib/services/fb/fb_core.dart:L22 | neighbors=[fb_core.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-015.json

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
