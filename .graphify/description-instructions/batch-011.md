# Node Description Batch 12 of 61

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

- "packup_should_ignore": "should_ignore()" | kind=code-symbol | source=packup.py:L80 | neighbors=[packup.py, pack_project(), Checks if a given path (relative to pro…]
- "runner_utils": "utils.h" | kind=code-symbol | source=windows/runner/utils.h:L1 | neighbors=[CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16()]
- "runner_win32_window_getclientarea": "GetClientArea()" | kind=code-symbol | source=windows/runner/win32_window.cpp:L252 | neighbors=[win32_window.h, MessageHandler(), SetChildContent()]
- "runner_win32_window_getwindowclass": "GetWindowClass()" | kind=code-symbol | source=windows/runner/win32_window.cpp:L89 | neighbors=[win32_window.h, Create(), CreateAndShow()]
- "runner_win32_window_oncreate": "OnCreate()" | kind=code-symbol | source=windows/runner/win32_window.cpp:L266 | neighbors=[win32_window.h, Create(), CreateAndShow()]
- "runner_win32_window_scale": "Scale()" | kind=code-symbol | source=windows/runner/win32_window.cpp:L36 | neighbors=[win32_window.h, Create(), CreateAndShow()]
- "runner_win32_window_updatetheme": "UpdateTheme()" | kind=code-symbol | source=windows/runner/win32_window.cpp:L275 | neighbors=[win32_window.h, Create(), MessageHandler()]
- "src_webview_inject_user_script": "webview_inject_user_script.dart" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_inject_user_script.dart:L1 | neighbors=[add(), InjectUserScripts, UserScript]
- "src_webview_javascript": "webview_javascript.dart" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_javascript.dart:L1 | neighbors=[JavascriptChannel, JavascriptMessage, JavascriptMessageHandler()]
- "src_webview_tooltip": "webview_tooltip.dart" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_tooltip.dart:L1 | neighbors=[_buildOverlayEntry(), showToolTip(), WebviewTooltip]
- "test_page_mapping_test": "page_mapping_test.dart" | kind=code-symbol | source=test/page_mapping_test.dart:L1 | neighbors=[1fa1705 OK, ed71b03 io, main()]
- "test_pdfx_test": "pdfx_test.dart" | kind=code-symbol | source=test/pdfx_test.dart:L1 | neighbors=[1fa1705 OK, 64cd7e0 XA, main()]
- "test_review_scheduler_test": "review_scheduler_test.dart" | kind=code-symbol | source=test/review_scheduler_test.dart:L1 | neighbors=[1fa1705 OK, f10ef09 feat: metacognitive loop, four …, main()]
- "test_syncfusion_math_test": "syncfusion_math_test.dart" | kind=code-symbol | source=test/syncfusion_math_test.dart:L1 | neighbors=[14e7263 feat: Quick Generate Module Not…, cleanLatexForSyncfusion(), main()]
- "test_toc_matcher_test": "toc_matcher_test.dart" | kind=code-symbol | source=test/toc_matcher_test.dart:L1 | neighbors=[1fa1705 OK, 742f017 feat: add offline TocMatcher he…, main()]
- "test_walkthrough_course_test": "walkthrough_course_test.dart" | kind=code-symbol | source=test/walkthrough_course_test.dart:L1 | neighbors=[9d1d7bc NAA, ea4994a Support program & try_yourself …, main()]
- "test_webview_cef_test": "webview_cef_test.dart" | kind=code-symbol | source=packages/webview_cef/test/webview_cef_test.dart:L1 | neighbors=[getPlatformVersion(), main(), MockWebviewCefPlatform]
- "test_widget_test": "widget_test.dart" | kind=code-symbol | source=test/widget_test.dart:L1 | neighbors=[1fa1705 OK, ed71b03 io, main()]
- "update_parse_snapshot": "parse_snapshot()" | kind=code-symbol | source=update.py:L12 | neighbors=[update.py, Parses the snapshot content and yields …, update_project_from_snapshot()]
- "update_update_project_from_snapshot": "update_project_from_snapshot()" | kind=code-symbol | source=update.py:L70 | neighbors=[update.py, Reads the snapshot file and updates the…, parse_snapshot()]
- "widgets_daily_goals_popup": "daily_goals_popup.dart" | kind=code-symbol | source=lib/widgets/daily_goals_popup.dart:L1 | neighbors=[a15c42e feat(daily-goals): Add Gamified…, checkAndShow(), DailyGoalsPopup]
- "widgets_global_error_capture_layer": "global_error_capture_layer.dart" | kind=code-symbol | source=lib/widgets/global_error_capture_layer.dart:L1 | neighbors=[859f766 new, GlobalErrorCaptureLayer, _GlobalErrorCaptureLayerState]
- "widgets_responsive_center": "responsive_center.dart" | kind=code-symbol | source=lib/widgets/responsive_center.dart:L1 | neighbors=[a22f95b feat: complete celestial light …, ResponsiveCenter, ResponsiveMaxWidth]
- "windows_webview_cef_keyevent": "webview_cef_keyevent.h" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_keyevent.h:L1 | neighbors=[GetCefKeyboardModifiers(), getCefKeyEvent(), IsKeyDown()]
- "windows_webview_cef_keyevent_getcefkeyboardmodifiers": "GetCefKeyboardModifiers()" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_keyevent.h:L9 | neighbors=[webview_cef_keyevent.h, IsKeyDown(), getCefKeyEvent()]
- "windows_webview_cef_keyevent_getcefkeyevent": "getCefKeyEvent()" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_keyevent.h:L91 | neighbors=[webview_cef_keyevent.h, GetCefKeyboardModifiers(), IsKeyDown()]
- "windows_webview_cef_keyevent_iskeydown": "IsKeyDown()" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_keyevent.h:L4 | neighbors=[webview_cef_keyevent.h, GetCefKeyboardModifiers(), getCefKeyEvent()]
- "windows_webview_cef_plugin_c_api": "webview_cef_plugin_c_api.cpp" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_plugin_c_api.cpp:L1 | neighbors=[handleWndProcForCEF(), initCEFProcesses(), WebviewCefPluginCApiRegisterWithRegistr…]
- "windows_webview_cef_plugin_encode_wvalue_to_flvalue": "encode_wvalue_to_flvalue()" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_plugin.cpp:L77 | neighbors=[webview_cef_plugin.h, HandleMethodCall(), RegisterWithRegistrar()]
- "windows_webview_cef_plugin_registerwithregistrar": "RegisterWithRegistrar()" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_plugin.cpp:L209 | neighbors=[webview_cef_plugin.h, encode_wvalue_to_flvalue(), HandleMethodCall()]
- "commit:repo:github.com/ihjas-ahammed/duofy@63ce97321564a5f037d5128c4e660e46c401910e": "63ce973 Update app.zip and app.zip.hash for multi-arch x86_64 emulator support" | kind=Commit | source=git | neighbors=[5621c28 v26.8.8: Integrated SeriousPyth…, main]
- "common_webview_app_simplebrowserviewdelegate": "SimpleBrowserViewDelegate" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L56 | neighbors=[webview_app.h, .SimpleBrowserViewDelegate()]
- "common_webview_app_simplewindowdelegate": "SimpleWindowDelegate" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L19 | neighbors=[webview_app.h, .SimpleWindowDelegate()]
- "common_webview_cookievisitor_getvisitedcookies": "getVisitedCookies()" | kind=code-symbol | source=packages/webview_cef/common/webview_cookieVisitor.cc:L35 | neighbors=[webview_cookieVisitor.h, Visit()]
- "common_webview_cookievisitor_visit": "Visit()" | kind=code-symbol | source=packages/webview_cef/common/webview_cookieVisitor.cc:L15 | neighbors=[webview_cookieVisitor.h, getVisitedCookies()]
- "common_webview_handler_getdatauri": "GetDataURI()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L44 | neighbors=[webview_handler.h, OnLoadError()]
- "common_webview_handler_ischromeruntimeenabled": "IsChromeRuntimeEnabled()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L252 | neighbors=[webview_handler.h, OnLoadError()]
- "common_webview_handler_loadurl": "loadUrl()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L406 | neighbors=[webview_handler.h, OnBeforePopup()]
- "common_webview_handler_onbeforepopup": "OnBeforePopup()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L168 | neighbors=[webview_handler.h, loadUrl()]
- "common_webview_handler_onprocessmessagereceived": "OnProcessMessageReceived()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L61 | neighbors=[webview_handler.h, to_string()]

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
