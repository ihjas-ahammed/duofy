# Node Description Batch 12 of 68

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

- "commit:repo:github.com/ihjas-ahammed/duofy@f9191cfaca514d7471307b04e7758c76ef57de2c": "f9191cf chore: add Android builds v26.7.28 [skip ci]" | kind=Commit | source=git | neighbors=[845dfcb feat: fast offline-speed initia…, main, ea88f41 Farsan]
- "common_webview_handler_getcallbackid": "GetCallbackId()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L597 | neighbors=[webview_handler.h, executeJavaScript(), to_string()]
- "common_webview_handler_onloaderror": "OnLoadError()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L198 | neighbors=[webview_handler.h, GetDataURI(), IsChromeRuntimeEnabled()]
- "common_webview_handler_to_string": "to_string()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L29 | neighbors=[webview_handler.h, GetCallbackId(), OnProcessMessageReceived()]
- "common_webview_value_webview_ptr_array_add": "webview_ptr_array_add()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L111 | neighbors=[webview_value.h, webview_value_append_take(), webview_value_set_take()]
- "common_webview_value_webview_ptr_array_new_with_free_func": "webview_ptr_array_new_with_free_func()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L86 | neighbors=[webview_value.h, webview_value_new_list(), webview_value_new_map()]
- "common_webview_value_webview_ptr_array_unref": "webview_ptr_array_unref()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L105 | neighbors=[webview_value.h, webview_ptr_array_free(), webview_value_unref()]
- "common_webview_value_webview_value_append": "webview_value_append()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L532 | neighbors=[webview_value.h, webview_value_append_take(), webview_value_ref()]
- "common_webview_value_webview_value_append_take": "webview_value_append_take()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L522 | neighbors=[webview_value.h, webview_value_append(), webview_ptr_array_add()]
- "common_webview_value_webview_value_destroy": "webview_value_destroy()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L163 | neighbors=[webview_value.h, webview_value_unref(), webview_value_set_take()]
- "common_webview_value_webview_value_get_bool": "webview_value_get_bool()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L579 | neighbors=[webview_value.h, webview_value_equals(), webview_value_to_string()]
- "common_webview_value_webview_value_get_double": "webview_value_get_double()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L600 | neighbors=[webview_value.h, webview_value_equals(), webview_value_to_string()]
- "common_webview_value_webview_value_get_double_list": "webview_value_get_double_list()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L642 | neighbors=[webview_value.h, webview_value_equals(), webview_value_to_string()]
- "common_webview_value_webview_value_get_float": "webview_value_get_float()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L593 | neighbors=[webview_value.h, webview_value_equals(), webview_value_to_string()]
- "common_webview_value_webview_value_get_float_list": "webview_value_get_float_list()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L635 | neighbors=[webview_value.h, webview_value_equals(), webview_value_to_string()]
- "common_webview_value_webview_value_get_int": "webview_value_get_int()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L586 | neighbors=[webview_value.h, webview_value_equals(), webview_value_to_string()]
- "common_webview_value_webview_value_get_int32_list": "webview_value_get_int32_list()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L621 | neighbors=[webview_value.h, webview_value_equals(), webview_value_to_string()]
- "common_webview_value_webview_value_get_int64_list": "webview_value_get_int64_list()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L628 | neighbors=[webview_value.h, webview_value_equals(), webview_value_to_string()]
- "common_webview_value_webview_value_get_map_key": "webview_value_get_map_key()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L736 | neighbors=[webview_value.h, webview_ptr_array_index(), webview_value_to_string()]
- "common_webview_value_webview_value_get_uint8_list": "webview_value_get_uint8_list()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L614 | neighbors=[webview_value.h, webview_value_equals(), webview_value_to_string()]
- "common_webview_value_webview_value_new_list": "webview_value_new_list()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L270 | neighbors=[webview_value.h, webview_ptr_array_new_with_free_func(), webview_value_new()]
- "common_webview_value_webview_value_new_map": "webview_value_new_map()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L277 | neighbors=[webview_value.h, webview_ptr_array_new_with_free_func(), webview_value_new()]
- "common_webview_value_webview_value_set": "webview_value_set()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L561 | neighbors=[webview_value.h, webview_value_ref(), webview_value_set_take()]
- "lib_webview_cef_platform_interface": "webview_cef_platform_interface.dart" | kind=code-symbol | source=packages/webview_cef/lib/webview_cef_platform_interface.dart:L1 | neighbors=[getPlatformVersion(), that, WebviewCefPlatform]
- "linux_webview_cef_plugin_encode_wavlue_to_flvalue": "encode_wavlue_to_flvalue()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_plugin.cc:L60 | neighbors=[webview_cef_plugin.cc, webview_cef_plugin_handle_method_call(), webview_cef_plugin_register_with_regist…]
- "models_daily_goal": "daily_goal.dart" | kind=code-symbol | source=lib/models/daily_goal.dart:L1 | neighbors=[a15c42e feat(daily-goals): Add Gamified…, DailyGoal, DailyGoalUpdateEvent]
- "packup_is_likely_binary_file": "is_likely_binary_file()" | kind=code-symbol | source=packup.py:L162 | neighbors=[packup.py, pack_project(), Checks if a file is likely binary based…]
- "packup_load_gitignore_patterns": "load_gitignore_patterns()" | kind=code-symbol | source=packup.py:L56 | neighbors=[packup.py, pack_project(), Loads patterns from .gitignore file in …]
- "packup_should_ignore": "should_ignore()" | kind=code-symbol | source=packup.py:L80 | neighbors=[packup.py, pack_project(), Checks if a given path (relative to pro…]
- "runner_utils": "utils.h" | kind=code-symbol | source=windows/runner/utils.h:L1 | neighbors=[CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16()]
- "runner_win32_window_getclientarea": "GetClientArea()" | kind=code-symbol | source=windows/runner/win32_window.cpp:L252 | neighbors=[win32_window.h, MessageHandler(), SetChildContent()]
- "runner_win32_window_getwindowclass": "GetWindowClass()" | kind=code-symbol | source=windows/runner/win32_window.cpp:L89 | neighbors=[win32_window.h, Create(), CreateAndShow()]
- "runner_win32_window_oncreate": "OnCreate()" | kind=code-symbol | source=windows/runner/win32_window.cpp:L266 | neighbors=[win32_window.h, Create(), CreateAndShow()]
- "runner_win32_window_scale": "Scale()" | kind=code-symbol | source=windows/runner/win32_window.cpp:L36 | neighbors=[win32_window.h, Create(), CreateAndShow()]
- "runner_win32_window_updatetheme": "UpdateTheme()" | kind=code-symbol | source=windows/runner/win32_window.cpp:L275 | neighbors=[win32_window.h, Create(), MessageHandler()]
- "screens_reel_view_screen": "reel_view_screen.dart" | kind=code-symbol | source=lib/screens/reel_view_screen.dart:L1 | neighbors=[0b36b76 feat(release): v26.9.1 - Multi-…, are, ReelViewScreen]
- "slide_views_slide_feedback_sheet": "slide_feedback_sheet.dart" | kind=code-symbol | source=lib/widgets/slide_views/slide_feedback_sheet.dart:L1 | neighbors=[1c58056 feat(release): v26.8.31 - Compl…, SlideFeedbackSheet, _SlideFeedbackSheetState]
- "src_webview_inject_user_script": "webview_inject_user_script.dart" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_inject_user_script.dart:L1 | neighbors=[add(), InjectUserScripts, UserScript]
- "src_webview_javascript": "webview_javascript.dart" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_javascript.dart:L1 | neighbors=[JavascriptChannel, JavascriptMessage, JavascriptMessageHandler()]
- "src_webview_tooltip": "webview_tooltip.dart" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_tooltip.dart:L1 | neighbors=[_buildOverlayEntry(), showToolTip(), WebviewTooltip]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-011.json

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
