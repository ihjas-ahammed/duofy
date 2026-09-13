# Node Description Batch 15 of 68

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

- "runner_win32_window_win32window": "Win32Window()" | kind=code-symbol | source=windows/runner/win32_window.cpp:L114 | neighbors=[win32_window.h, Destroy()]
- "runner_win32_window_windowclassregistrar": "WindowClassRegistrar" | kind=code-symbol | source=windows/runner/win32_window.cpp:L59 | neighbors=[win32_window.h, .WindowClassRegistrar()]
- "src_webview_events_listener": "webview_events_listener.dart" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_events_listener.dart:L1 | neighbors=[Function(), WebviewEventsListener]
- "test_latex_json_mapping_test": "latex_json_mapping_test.dart" | kind=code-symbol | source=test/latex_json_mapping_test.dart:L1 | neighbors=[e52e844 feat(release): v26.8.27 - LaTeX…, main()]
- "test_lesson_formats_limit_and_filter_test": "lesson_formats_limit_and_filter_test.dart" | kind=code-symbol | source=test/lesson_formats_limit_and_filter_test.dart:L1 | neighbors=[e52e844 feat(release): v26.8.27 - LaTeX…, main()]
- "test_math_evaluator_test": "math_evaluator_test.dart" | kind=code-symbol | source=test/math_evaluator_test.dart:L1 | neighbors=[4ead8b6 z, main()]
- "update": "update.py" | kind=code-symbol | source=update.py:L1 | neighbors=[parse_snapshot(), update_project_from_snapshot()]
- "widgets_realtime_progress_bar": "realtime_progress_bar.dart" | kind=code-symbol | source=lib/widgets/realtime_progress_bar.dart:L1 | neighbors=[859f766 new, RealtimeProgressBar]
- "widgets_web_webview_stub": "web_webview_stub.dart" | kind=code-symbol | source=lib/widgets/web_webview_stub.dart:L1 | neighbors=[8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …]
- "windows_webview_cef_plugin_encode_flvalue_to_wvalue": "encode_flvalue_to_wvalue()" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_plugin.cpp:L143 | neighbors=[webview_cef_plugin.h, HandleMethodCall()]
- "windows_webview_cef_plugin_webviewtexturerenderer": "WebviewTextureRenderer" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_plugin.cpp:L20 | neighbors=[webview_cef_plugin.h, .WebviewTextureRenderer()]
- "bottom_sheets_section_bottom_sheet_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/bottom_sheets/section_bottom_sheet.dart:L47 | neighbors=[section_bottom_sheet.dart]
- "bottom_sheets_section_bottom_sheet_initstate": "initState()" | kind=code-symbol | source=lib/widgets/bottom_sheets/section_bottom_sheet.dart:L38 | neighbors=[section_bottom_sheet.dart]
- "bottom_sheets_section_bottom_sheet_scrolltoactivesection": "_scrollToActiveSection()" | kind=code-symbol | source=lib/widgets/bottom_sheets/section_bottom_sheet.dart:L52 | neighbors=[section_bottom_sheet.dart]
- "bottom_sheets_section_bottom_sheet_sectionbottomsheet": "SectionBottomSheet" | kind=code-symbol | source=lib/widgets/bottom_sheets/section_bottom_sheet.dart:L12 | neighbors=[section_bottom_sheet.dart]
- "bottom_sheets_section_bottom_sheet_sectionbottomsheetstate": "_SectionBottomSheetState" | kind=code-symbol | source=lib/widgets/bottom_sheets/section_bottom_sheet.dart:L34 | neighbors=[section_bottom_sheet.dart]
- "bottom_sheets_section_bottom_sheet_sectioncard": "_SectionCard" | kind=code-symbol | source=lib/widgets/bottom_sheets/section_bottom_sheet.dart:L220 | neighbors=[section_bottom_sheet.dart]
- "classes_webviewceftexture": "WebviewCefTexture.h" | kind=code-symbol | source=packages/webview_cef/macos/Classes/WebviewCefTexture.h:L1 | neighbors=[WebviewCefTexture()]
- "classes_webviewceftexture_webviewceftexture": "WebviewCefTexture()" | kind=code-symbol | source=packages/webview_cef/macos/Classes/WebviewCefTexture.h:L12 | neighbors=[WebviewCefTexture.h]
- "common_webview_app_getprocesstype": "GetProcessType()" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L83 | neighbors=[webview_app.h]
- "common_webview_app_onbeforechildprocesslaunch": "OnBeforeChildProcessLaunch()" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L284 | neighbors=[webview_app.h]
- "common_webview_app_onbeforecommandlineprocessing": "OnBeforeCommandLineProcessing()" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L101 | neighbors=[webview_app.h]
- "common_webview_app_onbrowsercreated": "OnBrowserCreated()" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L267 | neighbors=[webview_app.h]
- "common_webview_app_onbrowserdestroyed": "OnBrowserDestroyed()" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L288 | neighbors=[webview_app.h]
- "common_webview_app_oncontextcreated": "OnContextCreated()" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L292 | neighbors=[webview_app.h]
- "common_webview_app_oncontextinitialized": "OnContextInitialized()" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L168 | neighbors=[webview_app.h]
- "common_webview_app_oncontextreleased": "OnContextReleased()" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L296 | neighbors=[webview_app.h]
- "common_webview_app_onfocusednodechanged": "OnFocusedNodeChanged()" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L308 | neighbors=[webview_app.h]
- "common_webview_app_onprocessmessagereceived": "OnProcessMessageReceived()" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L323 | neighbors=[webview_app.h]
- "common_webview_app_onuncaughtexception": "OnUncaughtException()" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L304 | neighbors=[webview_app.h]
- "common_webview_app_onwebkitinitialized": "OnWebKitInitialized()" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L192 | neighbors=[webview_app.h]
- "common_webview_app_setenablegpu": "SetEnableGPU()" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L279 | neighbors=[webview_app.h]
- "common_webview_app_setprocessmode": "SetProcessMode()" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L274 | neighbors=[webview_app.h]
- "common_webview_app_setunsafelytreatinsecureoriginassecure": "SetUnSafelyTreatInsecureOriginAsSecure()" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L187 | neighbors=[webview_app.h]
- "common_webview_app_simplebrowserviewdelegate_simplebrowserviewdelegate": ".SimpleBrowserViewDelegate()" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L58 | neighbors=[SimpleBrowserViewDelegate]
- "common_webview_app_simplewindowdelegate_simplewindowdelegate": ".SimpleWindowDelegate()" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L21 | neighbors=[SimpleWindowDelegate]
- "common_webview_app_webviewapp": "WebviewApp()" | kind=code-symbol | source=packages/webview_cef/common/webview_app.cc:L79 | neighbors=[webview_app.h]
- "common_webview_cookievisitor_setonvisitcomplete": "setOnVisitComplete()" | kind=code-symbol | source=packages/webview_cef/common/webview_cookieVisitor.cc:L10 | neighbors=[webview_cookieVisitor.h]
- "common_webview_cookievisitor_webviewcookievisitor": "WebviewCookieVisitor()" | kind=code-symbol | source=packages/webview_cef/common/webview_cookieVisitor.h:L10 | neighbors=[webview_cookieVisitor.h]
- "common_webview_handler_changesize": "changeSize()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L308 | neighbors=[webview_handler.h]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-014.json

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
