# Node Description Batch 35 of 61

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

- "screens_section_selection_screen_startnotegen": "_startNoteGen()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L134 | neighbors=[section_selection_screen.dart]
- "screens_settings_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/settings_screen.dart:L66 | neighbors=[settings_screen.dart]
- "screens_settings_screen_formattime": "formatTime()" | kind=code-symbol | source=lib/screens/settings_screen.dart:L119 | neighbors=[settings_screen.dart]
- "screens_settings_screen_formattimeofday": "_formatTimeOfDay()" | kind=code-symbol | source=lib/screens/settings_screen.dart:L785 | neighbors=[settings_screen.dart]
- "screens_settings_screen_handlecheckforupdates": "_handleCheckForUpdates()" | kind=code-symbol | source=lib/screens/settings_screen.dart:L2052 | neighbors=[settings_screen.dart]
- "screens_settings_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/settings_screen.dart:L60 | neighbors=[settings_screen.dart]
- "screens_settings_screen_loadsettings": "_loadSettings()" | kind=code-symbol | source=lib/screens/settings_screen.dart:L85 | neighbors=[settings_screen.dart]
- "screens_settings_screen_savesettings": "_saveSettings()" | kind=code-symbol | source=lib/screens/settings_screen.dart:L162 | neighbors=[settings_screen.dart]
- "screens_settings_screen_settingsscreen": "SettingsScreen" | kind=code-symbol | source=lib/screens/settings_screen.dart:L25 | neighbors=[settings_screen.dart]
- "screens_settings_screen_settingsscreenstate": "_SettingsScreenState" | kind=code-symbol | source=lib/screens/settings_screen.dart:L32 | neighbors=[settings_screen.dart]
- "screens_settings_screen_triggerquicksync": "_triggerQuickSync()" | kind=code-symbol | source=lib/screens/settings_screen.dart:L130 | neighbors=[settings_screen.dart]
- "screens_source_pdf_upload_screen_clearslot": "_clearSlot()" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L199 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L67 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_documentstorepickerdialog": "DocumentStorePickerDialog" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L985 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_documentstorepickerdialogstate": "DocumentStorePickerDialogState" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L1000 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_downloadprogressdialog": "DownloadProgressDialog" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L1428 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_downloadprogressdialogstate": "DownloadProgressDialogState" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L1438 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_gettopicsforbookidx": "_getTopicsForBookIdx()" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L157 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_in": "in" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L33 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_initcachedir": "_initCacheDir()" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L57 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L48 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_ispdfcached": "_isPdfCached()" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L1064 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_isslotrestoredondisk": "_isSlotRestoredOnDisk()" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L107 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_loadfiles": "_loadFiles()" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L1037 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_ongenerationmanagerchange": "_onGenerationManagerChange()" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L72 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_pickallfiles": "_pickAllFiles()" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L206 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_pickfileforslot": "_pickFileForSlot()" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L181 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_showdocumentstorepicker": "_showDocumentStorePicker()" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L338 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_showsourcepicker": "_showSourcePicker()" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L229 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_sourcepdfuploadscreen": "SourcePdfUploadScreen" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L15 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_sourcepdfuploadscreenstate": "_SourcePdfUploadScreenState" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L24 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_startdownload": "_startDownload()" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L1449 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_startrestore": "_startRestore()" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L412 | neighbors=[source_pdf_upload_screen.dart]
- "screens_summary_screen_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/screens/summary_screen.dart:L73 | neighbors=[summary_screen.dart]
- "screens_summary_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/summary_screen.dart:L87 | neighbors=[summary_screen.dart]
- "screens_summary_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/summary_screen.dart:L65 | neighbors=[summary_screen.dart]
- "screens_summary_screen_lecture": "lecture" | kind=code-symbol | source=lib/screens/summary_screen.dart:L109 | neighbors=[summary_screen.dart]
- "screens_summary_screen_loadpreferences": "_loadPreferences()" | kind=code-symbol | source=lib/screens/summary_screen.dart:L128 | neighbors=[summary_screen.dart]
- "screens_summary_screen_onactivemoduleorsectionchanged": "_onActiveModuleOrSectionChanged()" | kind=code-symbol | source=lib/screens/summary_screen.dart:L97 | neighbors=[summary_screen.dart]
- "screens_summary_screen_playvideo": "_playVideo()" | kind=code-symbol | source=lib/screens/summary_screen.dart:L407 | neighbors=[summary_screen.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-034.json

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
