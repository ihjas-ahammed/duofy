# Node Description Batch 67 of 68

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

- "widgets_safe_pdf_viewer_safepdfviewerstate": "_SafePdfViewerState" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L233 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_scrolltooffset": "scrollToOffset()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L855 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_setupobservers": "setupObservers()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L782 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_setzoom": "setZoom()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L832 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_trysendpdftojs": "_trySendPdfToJs()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L327 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_update": "update()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L27 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_updatepagecount": "_updatePageCount()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L83 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_updatepagenumber": "_updatePageNumber()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L76 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_updatezoomlevel": "_updateZoomLevel()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L90 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_webpdftextsearchresult": "WebPdfTextSearchResult" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L10 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_window_onerror": "window.onerror()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L499 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_window_onload": "window.onload()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L660 | neighbors=[safe_pdf_viewer.dart]
- "widgets_smart_review_card_smartreviewcard": "SmartReviewCard" | kind=code-symbol | source=lib/widgets/smart_review_card.dart:L15 | neighbors=[smart_review_card.dart]
- "widgets_smart_review_card_startsession": "_startSession()" | kind=code-symbol | source=lib/widgets/smart_review_card.dart:L23 | neighbors=[smart_review_card.dart]
- "widgets_string_list_manager_additem": "_addItem()" | kind=code-symbol | source=lib/widgets/string_list_manager.dart:L39 | neighbors=[string_list_manager.dart]
- "widgets_string_list_manager_commitpending": "commitPending()" | kind=code-symbol | source=lib/widgets/string_list_manager.dart:L35 | neighbors=[string_list_manager.dart]
- "widgets_string_list_manager_initstate": "initState()" | kind=code-symbol | source=lib/widgets/string_list_manager.dart:L28 | neighbors=[string_list_manager.dart]
- "widgets_string_list_manager_removeitem": "_removeItem()" | kind=code-symbol | source=lib/widgets/string_list_manager.dart:L58 | neighbors=[string_list_manager.dart]
- "widgets_string_list_manager_stringlistmanager": "StringListManager" | kind=code-symbol | source=lib/widgets/string_list_manager.dart:L5 | neighbors=[string_list_manager.dart]
- "widgets_string_list_manager_stringlistmanagerstate": "StringListManagerState" | kind=code-symbol | source=lib/widgets/string_list_manager.dart:L23 | neighbors=[string_list_manager.dart]
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

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-066.json

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
