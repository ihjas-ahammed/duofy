# Node Description Batch 26 of 61

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

- "screens_course_settings_screen_coursesettingsscreenstate": "_CourseSettingsScreenState" | kind=code-symbol | source=lib/screens/course_settings_screen.dart:L31 | neighbors=[course_settings_screen.dart]
- "screens_course_settings_screen_deleteformat": "_deleteFormat()" | kind=code-symbol | source=lib/screens/course_settings_screen.dart:L85 | neighbors=[course_settings_screen.dart]
- "screens_course_settings_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/course_settings_screen.dart:L458 | neighbors=[course_settings_screen.dart]
- "screens_course_settings_screen_editslide": "_editSlide()" | kind=code-symbol | source=lib/screens/course_settings_screen.dart:L476 | neighbors=[course_settings_screen.dart]
- "screens_course_settings_screen_formateditorscreen": "FormatEditorScreen" | kind=code-symbol | source=lib/screens/course_settings_screen.dart:L435 | neighbors=[course_settings_screen.dart]
- "screens_course_settings_screen_formateditorscreenstate": "_FormatEditorScreenState" | kind=code-symbol | source=lib/screens/course_settings_screen.dart:L444 | neighbors=[course_settings_screen.dart]
- "screens_course_settings_screen_genformatid": "_genFormatId()" | kind=code-symbol | source=lib/screens/course_settings_screen.dart:L53 | neighbors=[course_settings_screen.dart]
- "screens_course_settings_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/course_settings_screen.dart:L37 | neighbors=[course_settings_screen.dart]
- "screens_course_settings_screen_openeditor": "_openEditor()" | kind=code-symbol | source=lib/screens/course_settings_screen.dart:L74 | neighbors=[course_settings_screen.dart]
- "screens_course_settings_screen_resetdefaults": "_resetDefaults()" | kind=code-symbol | source=lib/screens/course_settings_screen.dart:L101 | neighbors=[course_settings_screen.dart]
- "screens_course_settings_screen_save": "_save()" | kind=code-symbol | source=lib/screens/course_settings_screen.dart:L116 | neighbors=[course_settings_screen.dart]
- "screens_daily_goals_screen_claimreward": "_claimReward()" | kind=code-symbol | source=lib/screens/daily_goals_screen.dart:L40 | neighbors=[daily_goals_screen.dart]
- "screens_daily_goals_screen_dailygoalsscreen": "DailyGoalsScreen" | kind=code-symbol | source=lib/screens/daily_goals_screen.dart:L9 | neighbors=[daily_goals_screen.dart]
- "screens_daily_goals_screen_dailygoalsscreenstate": "_DailyGoalsScreenState" | kind=code-symbol | source=lib/screens/daily_goals_screen.dart:L16 | neighbors=[daily_goals_screen.dart]
- "screens_daily_goals_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/daily_goals_screen.dart:L22 | neighbors=[daily_goals_screen.dart]
- "screens_daily_goals_screen_refresh": "_refresh()" | kind=code-symbol | source=lib/screens/daily_goals_screen.dart:L27 | neighbors=[daily_goals_screen.dart]
- "screens_document_store_screen_b2pdfviewerscreen": "B2PdfViewerScreen" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L2009 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_categorytabs": "CategoryTabs" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L2273 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_changedocumentcategory": "_changeDocumentCategory()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L796 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_checkconfigandload": "_checkConfigAndLoad()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L88 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_confirmnamedialog": "ConfirmNameDialog" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L2366 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_confirmnamedialogstate": "_ConfirmNameDialogState" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L2380 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_deletefile": "_deleteFile()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L875 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L2114 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L74 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_documentstorescreen": "DocumentStoreScreen" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L42 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_documentstorescreenstate": "_DocumentStoreScreenState" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L49 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_downloadandview": "_downloadAndView()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L558 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_getaisuggestion": "_getAiSuggestion()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L2399 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_initcachedir": "_initCacheDir()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L79 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L67 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_ispdfcached": "_isPdfCached()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L1563 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_loadfiles": "_loadFiles()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L108 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_loadthumbnail": "_loadThumbnail()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L2121 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_onfabpressed": "_onFabPressed()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L412 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_openpdfviewer": "_openPdfViewer()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L866 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_pdfthumbnailwidget": "PdfThumbnailWidget" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L2089 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_pdfthumbnailwidgetstate": "_PdfThumbnailWidgetState" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L2103 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_pickandupload": "_pickAndUpload()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L261 | neighbors=[document_store_screen.dart]
- "screens_document_store_screen_showcategoryselectiondialog": "_showCategorySelectionDialog()" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L136 | neighbors=[document_store_screen.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-025.json

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
