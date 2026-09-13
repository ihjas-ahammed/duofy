# Node Description Batch 16 of 68

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

- "common_webview_handler_closeallbrowsers": "CloseAllBrowsers()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L239 | neighbors=[webview_handler.h]
- "common_webview_handler_closebrowser": "closeBrowser()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L262 | neighbors=[webview_handler.h]
- "common_webview_handler_createbrowser": "createBrowser()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L272 | neighbors=[webview_handler.h]
- "common_webview_handler_cursorclick": "cursorClick()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L319 | neighbors=[webview_handler.h]
- "common_webview_handler_cursormove": "cursorMove()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L337 | neighbors=[webview_handler.h]
- "common_webview_handler_deletecookie": "deleteCookie()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L519 | neighbors=[webview_handler.h]
- "common_webview_handler_doclose": "DoClose()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L157 | neighbors=[webview_handler.h]
- "common_webview_handler_getdisplayhandler": "GetDisplayHandler()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.h:L59 | neighbors=[webview_handler.h]
- "common_webview_handler_getfocushandler": "GetFocusHandler()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.h:L65 | neighbors=[webview_handler.h]
- "common_webview_handler_getlifespanhandler": "GetLifeSpanHandler()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.h:L62 | neighbors=[webview_handler.h]
- "common_webview_handler_getloadhandler": "GetLoadHandler()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.h:L68 | neighbors=[webview_handler.h]
- "common_webview_handler_getrenderhandler": "GetRenderHandler()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.h:L69 | neighbors=[webview_handler.h]
- "common_webview_handler_getscreeninfo": "GetScreenInfo()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L651 | neighbors=[webview_handler.h]
- "common_webview_handler_getviewrect": "GetViewRect()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L630 | neighbors=[webview_handler.h]
- "common_webview_handler_goback": "goBack()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L421 | neighbors=[webview_handler.h]
- "common_webview_handler_goforward": "goForward()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L414 | neighbors=[webview_handler.h]
- "common_webview_handler_imecommittext": "imeCommitText()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L471 | neighbors=[webview_handler.h]
- "common_webview_handler_imesetcomposition": "imeSetComposition()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L446 | neighbors=[webview_handler.h]
- "common_webview_handler_onaddresschange": "OnAddressChange()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L111 | neighbors=[webview_handler.h]
- "common_webview_handler_onaftercreated": "OnAfterCreated()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L149 | neighbors=[webview_handler.h]
- "common_webview_handler_onbeforeclose": "OnBeforeClose()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L164 | neighbors=[webview_handler.h]
- "common_webview_handler_onconsolemessage": "OnConsoleMessage()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L138 | neighbors=[webview_handler.h]
- "common_webview_handler_oncursorchange": "OnCursorChange()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L119 | neighbors=[webview_handler.h]
- "common_webview_handler_ongotfocus": "OnGotFocus()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L194 | neighbors=[webview_handler.h]
- "common_webview_handler_onimecompositionrangechanged": "OnImeCompositionRangeChanged()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L372 | neighbors=[webview_handler.h]
- "common_webview_handler_onloadend": "OnLoadEnd()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L231 | neighbors=[webview_handler.h]
- "common_webview_handler_onloadstart": "OnLoadStart()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L223 | neighbors=[webview_handler.h]
- "common_webview_handler_onpaint": "OnPaint()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L657 | neighbors=[webview_handler.h]
- "common_webview_handler_onsetfocus": "OnSetFocus()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L189 | neighbors=[webview_handler.h]
- "common_webview_handler_ontitlechange": "OnTitleChange()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L103 | neighbors=[webview_handler.h]
- "common_webview_handler_ontooltip": "OnTooltip()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L130 | neighbors=[webview_handler.h]
- "common_webview_handler_opendevtools": "openDevTools()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L435 | neighbors=[webview_handler.h]
- "common_webview_handler_reload": "reload()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L428 | neighbors=[webview_handler.h]
- "common_webview_handler_sendjavascriptchannelcallback": "sendJavaScriptChannelCallBack()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L570 | neighbors=[webview_handler.h]
- "common_webview_handler_sendkeyevent": "sendKeyEvent()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L397 | neighbors=[webview_handler.h]
- "common_webview_handler_sendscrollevent": "sendScrollEvent()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L287 | neighbors=[webview_handler.h]
- "common_webview_handler_setclientfocus": "setClientFocus()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L491 | neighbors=[webview_handler.h]
- "common_webview_handler_setcookie": "setCookie()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L500 | neighbors=[webview_handler.h]
- "common_webview_handler_startdragging": "StartDragging()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L355 | neighbors=[webview_handler.h]
- "common_webview_handler_visitallcookies": "visitAllCookies()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L528 | neighbors=[webview_handler.h]

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
