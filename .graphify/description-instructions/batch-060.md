# Node Description Batch 61 of 61

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

- "widgets_unit_header_resumeiconbutton": "_ResumeIconButton" | kind=code-symbol | source=lib/widgets/unit_header.dart:L165 | neighbors=[unit_header.dart]
- "widgets_unit_header_resumeiconbuttonstate": "_ResumeIconButtonState" | kind=code-symbol | source=lib/widgets/unit_header.dart:L174 | neighbors=[unit_header.dart]
- "widgets_unit_header_unitheader": "UnitHeader" | kind=code-symbol | source=lib/widgets/unit_header.dart:L12 | neighbors=[unit_header.dart]
- "widgets_update_dialog_download": "_download()" | kind=code-symbol | source=lib/widgets/update_dialog.dart:L50 | neighbors=[update_dialog.dart]
- "widgets_update_dialog_downloadprogress": "_DownloadProgress" | kind=code-symbol | source=lib/widgets/update_dialog.dart:L219 | neighbors=[update_dialog.dart]
- "widgets_update_dialog_initstate": "initState()" | kind=code-symbol | source=lib/widgets/update_dialog.dart:L36 | neighbors=[update_dialog.dart]
- "widgets_update_dialog_install": "_install()" | kind=code-symbol | source=lib/widgets/update_dialog.dart:L60 | neighbors=[update_dialog.dart]
- "widgets_update_dialog_showupdatedialog": "showUpdateDialog()" | kind=code-symbol | source=lib/widgets/update_dialog.dart:L11 | neighbors=[update_dialog.dart]
- "widgets_update_dialog_updatedialog": "UpdateDialog" | kind=code-symbol | source=lib/widgets/update_dialog.dart:L22 | neighbors=[update_dialog.dart]
- "widgets_update_dialog_updatedialogstate": "_UpdateDialogState" | kind=code-symbol | source=lib/widgets/update_dialog.dart:L30 | neighbors=[update_dialog.dart]
- "widgets_walkthrough_banner_card": "_Card" | kind=code-symbol | source=lib/widgets/walkthrough_banner.dart:L45 | neighbors=[walkthrough_banner.dart]
- "widgets_walkthrough_banner_walkthroughbanner": "WalkthroughBanner" | kind=code-symbol | source=lib/widgets/walkthrough_banner.dart:L11 | neighbors=[walkthrough_banner.dart]
- "widgets_web_webview_helper_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/web_webview_helper.dart:L107 | neighbors=[web_webview_helper.dart]
- "widgets_web_webview_helper_initstate": "initState()" | kind=code-symbol | source=lib/widgets/web_webview_helper.dart:L41 | neighbors=[web_webview_helper.dart]
- "widgets_web_webview_helper_webwebviewwidget": "WebWebViewWidget" | kind=code-symbol | source=lib/widgets/web_webview_helper.dart:L15 | neighbors=[web_webview_helper.dart]
- "widgets_web_webview_helper_webwebviewwidgetstate": "_WebWebViewWidgetState" | kind=code-symbol | source=lib/widgets/web_webview_helper.dart:L31 | neighbors=[web_webview_helper.dart]
- "windows_webview_cef_plugin_c_api_handlewndprocforcef": "handleWndProcForCEF()" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_plugin_c_api.cpp:L15 | neighbors=[webview_cef_plugin_c_api.cpp]
- "windows_webview_cef_plugin_c_api_initcefprocesses": "initCEFProcesses()" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_plugin_c_api.cpp:L10 | neighbors=[webview_cef_plugin_c_api.cpp]
- "windows_webview_cef_plugin_c_api_webviewcefplugincapiregisterwithregistrar": "WebviewCefPluginCApiRegisterWithRegistrar()" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_plugin_c_api.cpp:L5 | neighbors=[webview_cef_plugin_c_api.cpp]
- "windows_webview_cef_plugin_handlemessageproc": "handleMessageProc()" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_plugin.cpp:L276 | neighbors=[webview_cef_plugin.h]
- "windows_webview_cef_plugin_webview_cef": "webview_cef()" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_plugin.h:L10 | neighbors=[webview_cef_plugin.h]
- "windows_webview_cef_plugin_webviewcefplugin": "WebviewCefPlugin()" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_plugin.cpp:L245 | neighbors=[webview_cef_plugin.h]
- "windows_webview_cef_plugin_webviewtexturerenderer_webviewtexturerenderer": ".WebviewTextureRenderer()" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_plugin.cpp:L22 | neighbors=[WebviewTextureRenderer]
- "classes_cef_bridge": "cef_bridge.cc" | kind=code-symbol | source=packages/webview_cef/macos/Classes/cef_bridge.cc:L1
- "classes_cefwrapper": "CefWrapper.h" | kind=code-symbol | source=packages/webview_cef/macos/Classes/CefWrapper.h:L1
- "classes_webviewcefplugin": "WebviewCefPlugin.h" | kind=code-symbol | source=packages/webview_cef/macos/Classes/WebviewCefPlugin.h:L1
- "disable_keyboard": "disable-keyboard.py" | kind=code-symbol | source=disable-keyboard.py:L1
- "lib_webview_cef": "webview_cef.dart" | kind=code-symbol | source=packages/webview_cef/lib/webview_cef.dart:L1
- "runner_resource": "resource.h" | kind=code-symbol | source=windows/runner/resource.h:L1
- "runner_runner_bridging_header": "Runner-Bridging-Header.h" | kind=code-symbol | source=ios/Runner/Runner-Bridging-Header.h:L1
- "webview_cef_webview_cef_plugin": "webview_cef_plugin.h" | kind=code-symbol | source=packages/webview_cef/linux/include/webview_cef/webview_cef_plugin.h:L1
- "webview_cef_webview_cef_plugin_c_api": "webview_cef_plugin_c_api.h" | kind=code-symbol | source=packages/webview_cef/windows/include/webview_cef/webview_cef_plugin_c_api.h:L1

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-060.json

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
