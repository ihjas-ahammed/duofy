# Node Description Batch 13 of 61

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

- "common_webview_handler_ontakefocus": "OnTakeFocus()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L184 | neighbors=[webview_handler.h, executeJavaScript()]
- "common_webview_handler_setjavascriptchannels": "setJavaScriptChannels()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L556 | neighbors=[webview_handler.h, executeJavaScript()]
- "common_webview_js_handler_callcppfunction": "CallCppFunction()" | kind=code-symbol | source=packages/webview_cef/common/webview_js_handler.cc:L247 | neighbors=[webview_js_handler.h, Execute()]
- "common_webview_js_handler_convertcefv8valuetojsvalue": "ConvertCefV8ValueToJSValue()" | kind=code-symbol | source=packages/webview_cef/common/webview_js_handler.cc:L6 | neighbors=[webview_js_handler.h, Execute()]
- "common_webview_js_handler_evaluatecallback": "EvaluateCallback()" | kind=code-symbol | source=packages/webview_cef/common/webview_js_handler.cc:L169 | neighbors=[webview_js_handler.h, Execute()]
- "common_webview_js_handler_getnextreqid": "GetNextReqID()" | kind=code-symbol | source=packages/webview_cef/common/webview_js_handler.cc:L231 | neighbors=[webview_js_handler.h, Execute()]
- "common_webview_js_handler_startrequest": "StartRequest()" | kind=code-symbol | source=packages/webview_cef/common/webview_js_handler.cc:L137 | neighbors=[webview_js_handler.h, Execute()]
- "common_webview_plugin_cursoraction": "cursorAction()" | kind=code-symbol | source=packages/webview_cef/common/webview_plugin.cc:L516 | neighbors=[webview_plugin.h, HandleMethodCall()]
- "common_webview_plugin_initcallback": "initCallback()" | kind=code-symbol | source=packages/webview_cef/common/webview_plugin.cc:L33 | neighbors=[webview_plugin.h, HandleMethodCall()]
- "common_webview_plugin_startcef": "startCEF()" | kind=code-symbol | source=packages/webview_cef/common/webview_plugin.cc:L564 | neighbors=[webview_plugin.h, HandleMethodCall()]
- "common_webview_plugin_stopcef": "stopCEF()" | kind=code-symbol | source=packages/webview_cef/common/webview_plugin.cc:L621 | neighbors=[webview_plugin.h, HandleMethodCall()]
- "common_webview_plugin_uninitcallback": "uninitCallback()" | kind=code-symbol | source=packages/webview_cef/common/webview_plugin.cc:L222 | neighbors=[webview_plugin.h, WebviewPlugin()]
- "common_webview_plugin_webviewplugin": "WebviewPlugin()" | kind=code-symbol | source=packages/webview_cef/common/webview_plugin.cc:L20 | neighbors=[webview_plugin.h, uninitCallback()]
- "common_webview_value_webview_ptr_array_free": "webview_ptr_array_free()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L95 | neighbors=[webview_value.h, webview_ptr_array_unref()]
- "common_webview_value_webview_value_get_string": "webview_value_get_string()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L607 | neighbors=[webview_value.h, webview_value_to_string()]
- "common_webview_value_webview_value_get_value": "webview_value_get_value()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L727 | neighbors=[webview_value.h, webview_ptr_array_index()]
- "common_webview_value_webview_value_new_bool": "webview_value_new_bool()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L171 | neighbors=[webview_value.h, webview_value_new()]
- "common_webview_value_webview_value_new_double": "webview_value_new_double()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L192 | neighbors=[webview_value.h, webview_value_new()]
- "common_webview_value_webview_value_new_double_list": "webview_value_new_double_list()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L260 | neighbors=[webview_value.h, webview_value_new()]
- "common_webview_value_webview_value_new_float": "webview_value_new_float()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L185 | neighbors=[webview_value.h, webview_value_new()]
- "common_webview_value_webview_value_new_float_list": "webview_value_new_float_list()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L250 | neighbors=[webview_value.h, webview_value_new()]
- "common_webview_value_webview_value_new_int": "webview_value_new_int()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L178 | neighbors=[webview_value.h, webview_value_new()]
- "common_webview_value_webview_value_new_int32_list": "webview_value_new_int32_list()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L230 | neighbors=[webview_value.h, webview_value_new()]
- "common_webview_value_webview_value_new_int64_list": "webview_value_new_int64_list()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L240 | neighbors=[webview_value.h, webview_value_new()]
- "common_webview_value_webview_value_new_null": "webview_value_new_null()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L167 | neighbors=[webview_value.h, webview_value_new()]
- "common_webview_value_webview_value_new_string_len": "webview_value_new_string_len()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L206 | neighbors=[webview_value.h, webview_value_new()]
- "common_webview_value_webview_value_new_uint8_list": "webview_value_new_uint8_list()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L220 | neighbors=[webview_value.h, webview_value_new()]
- "data_mock_books": "mock_books.dart" | kind=code-symbol | source=lib/data/mock_books.dart:L1 | neighbors=[draw(), resize()]
- "lib_webview_cef_method_channel": "webview_cef_method_channel.dart" | kind=code-symbol | source=packages/webview_cef/lib/webview_cef_method_channel.dart:L1 | neighbors=[getPlatformVersion(), MethodChannelWebviewCef]
- "linux_webview_cef_keyevent_gdkeventtowindowskeycode": "GdkEventToWindowsKeyCode()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_keyevent.h:L608 | neighbors=[webview_cef_keyevent.h, KeyboardCodeFromXKeysym()]
- "linux_webview_cef_keyevent_keyboardcodefromxkeysym": "KeyboardCodeFromXKeysym()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_keyevent.h:L207 | neighbors=[webview_cef_keyevent.h, GdkEventToWindowsKeyCode()]
- "linux_webview_cef_plugin_encode_flvalue_to_wvalue": "encode_flvalue_to_wvalue()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_plugin.cc:L136 | neighbors=[webview_cef_plugin.cc, webview_cef_plugin_handle_method_call()]
- "linux_webview_cef_plugin_method_call_cb": "method_call_cb()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_plugin.cc:L252 | neighbors=[webview_cef_plugin.cc, webview_cef_plugin_handle_method_call()]
- "linux_webview_cef_plugin_webview_cef_plugin_register_with_registrar": "webview_cef_plugin_register_with_registrar()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_plugin.cc:L259 | neighbors=[webview_cef_plugin.cc, encode_wavlue_to_flvalue()]
- "linux_webview_cef_plugin_webviewtexturerenderer": "WebviewTextureRenderer" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_plugin.cc:L29 | neighbors=[webview_cef_plugin.cc, .WebviewTextureRenderer()]
- "platform_file_image_io": "file_image_io.dart" | kind=code-symbol | source=lib/platform/file_image_io.dart:L1 | neighbors=[8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …]
- "platform_file_image_shim": "file_image_shim.dart" | kind=code-symbol | source=lib/platform/file_image_shim.dart:L1 | neighbors=[8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …]
- "platform_file_image_web": "file_image_web.dart" | kind=code-symbol | source=lib/platform/file_image_web.dart:L1 | neighbors=[8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …]
- "platform_io_shim": "io_shim.dart" | kind=code-symbol | source=lib/platform/io_shim.dart:L1 | neighbors=[8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …]
- "platform_isolate_shim": "isolate_shim.dart" | kind=code-symbol | source=lib/platform/isolate_shim.dart:L1 | neighbors=[8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-012.json

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
