# Node Description Batch 32 of 68

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

- "screens_module_selection_screen_bookmarkmatch": "_BookmarkMatch" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L1725 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_checknotesavailability": "_checkNotesAvailability()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L100 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_deletenotes": "_deleteNotes()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L325 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L66 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_final": "final" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L1414 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L48 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_loadlastlessoninfo": "_loadLastLessonInfo()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L445 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_loadprogress": "_loadProgress()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L419 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_menuactionitem": "_MenuActionItem" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L1709 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_moduleselectionscreen": "ModuleSelectionScreen" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L24 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_moduleselectionscreenstate": "_ModuleSelectionScreenState" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L33 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_now": "now" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L1011 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_ongenmanagerchanged": "_onGenManagerChanged()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L82 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_onjobupdate": "onJobUpdate()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L394 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_onnotesserviceupdated": "_onNotesServiceUpdated()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L75 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_openmodulenotes": "_openModuleNotes()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L118 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_openreelview": "_openReelView()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L144 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_promptgenerateorschedulemodule": "_promptGenerateOrScheduleModule()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L1067 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_promptregeneratenotes": "_promptRegenerateNotes()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L158 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_refreshbookfromstorage": "_refreshBookFromStorage()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L88 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_showbookmarksdialog": "_showBookmarksDialog()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L1334 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_showmodulelongpressmenu": "_showModuleLongPressMenu()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L974 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_startnotegeneration": "_startNoteGeneration()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L378 | neighbors=[module_selection_screen.dart]
- "screens_module_summary_detail_screen_list": "List" | kind=code-symbol | source=lib/screens/module_summary_detail_screen.dart:L15 | neighbors=[module_summary_detail_screen.dart]
- "screens_module_summary_detail_screen_modulesummarydetailscreen": "ModuleSummaryDetailScreen" | kind=code-symbol | source=lib/screens/module_summary_detail_screen.dart:L8 | neighbors=[module_summary_detail_screen.dart]
- "screens_pdf_browser_screen_deletefolder": "_deleteFolder()" | kind=code-symbol | source=lib/screens/pdf_browser_screen.dart:L111 | neighbors=[pdf_browser_screen.dart]
- "screens_pdf_browser_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/pdf_browser_screen.dart:L39 | neighbors=[pdf_browser_screen.dart]
- "screens_pdf_browser_screen_loadfolders": "_loadFolders()" | kind=code-symbol | source=lib/screens/pdf_browser_screen.dart:L44 | neighbors=[pdf_browser_screen.dart]
- "screens_pdf_browser_screen_openfolder": "_openFolder()" | kind=code-symbol | source=lib/screens/pdf_browser_screen.dart:L154 | neighbors=[pdf_browser_screen.dart]
- "screens_pdf_browser_screen_pdfbrowserscreen": "PdfBrowserScreen" | kind=code-symbol | source=lib/screens/pdf_browser_screen.dart:L27 | neighbors=[pdf_browser_screen.dart]
- "screens_pdf_browser_screen_pdfbrowserscreenstate": "_PdfBrowserScreenState" | kind=code-symbol | source=lib/screens/pdf_browser_screen.dart:L34 | neighbors=[pdf_browser_screen.dart]
- "screens_pdf_browser_screen_pdffoldermeta": "PdfFolderMeta" | kind=code-symbol | source=lib/screens/pdf_browser_screen.dart:L11 | neighbors=[pdf_browser_screen.dart]
- "screens_pdf_folder_screen_deletefile": "_deleteFile()" | kind=code-symbol | source=lib/screens/pdf_folder_screen.dart:L219 | neighbors=[pdf_folder_screen.dart]
- "screens_pdf_folder_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/pdf_folder_screen.dart:L47 | neighbors=[pdf_folder_screen.dart]
- "screens_pdf_folder_screen_loadfiles": "_loadFiles()" | kind=code-symbol | source=lib/screens/pdf_folder_screen.dart:L52 | neighbors=[pdf_folder_screen.dart]
- "screens_pdf_folder_screen_openpdf": "_openPdf()" | kind=code-symbol | source=lib/screens/pdf_folder_screen.dart:L144 | neighbors=[pdf_folder_screen.dart]
- "screens_pdf_folder_screen_pdffilemeta": "PdfFileMeta" | kind=code-symbol | source=lib/screens/pdf_folder_screen.dart:L12 | neighbors=[pdf_folder_screen.dart]
- "screens_pdf_folder_screen_pdffolderscreen": "PdfFolderScreen" | kind=code-symbol | source=lib/screens/pdf_folder_screen.dart:L26 | neighbors=[pdf_folder_screen.dart]
- "screens_pdf_folder_screen_pdffolderscreenstate": "_PdfFolderScreenState" | kind=code-symbol | source=lib/screens/pdf_folder_screen.dart:L42 | neighbors=[pdf_folder_screen.dart]
- "screens_pdf_folder_screen_sharepdf": "_sharePdf()" | kind=code-symbol | source=lib/screens/pdf_folder_screen.dart:L183 | neighbors=[pdf_folder_screen.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-031.json

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
