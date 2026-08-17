# Node Description Batch 31 of 61

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

- "screens_module_selection_screen_showmodulelongpressmenu": "_showModuleLongPressMenu()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L787 | neighbors=[module_selection_screen.dart]
- "screens_module_selection_screen_startnotegeneration": "_startNoteGeneration()" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L204 | neighbors=[module_selection_screen.dart]
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
- "screens_pdf_split_preview_screen_addsection": "_addSection()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L144 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_addunit": "_addUnit()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L186 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_commitsplits": "_commitSplits()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L509 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L659 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_generateuniqueid": "_generateUniqueId()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L140 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_in": "in" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L109 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_initcontrollers": "_initControllers()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L108 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L58 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_pdfsplitpreviewscreen": "PdfSplitPreviewScreen" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L13 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_pdfsplitpreviewscreenstate": "_PdfSplitPreviewScreenState" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L29 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_removemodule": "_removeModule()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L245 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_removesection": "_removeSection()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L171 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_removeunit": "_removeUnit()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L221 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_savetitle": "_saveTitle()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L293 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_shiftallpages": "_shiftAllPages()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L395 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_showshiftdialog": "_showShiftDialog()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L416 | neighbors=[pdf_split_preview_screen.dart]
- "screens_pdf_split_preview_screen_viewpage": "_viewPage()" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L267 | neighbors=[pdf_split_preview_screen.dart]
- "screens_practice_screen_configureandstartpyq": "_configureAndStartPyq()" | kind=code-symbol | source=lib/screens/practice_screen.dart:L302 | neighbors=[practice_screen.dart]
- "screens_practice_screen_countfor": "_countFor()" | kind=code-symbol | source=lib/screens/practice_screen.dart:L281 | neighbors=[practice_screen.dart]
- "screens_practice_screen_function": "Function()" | kind=code-symbol | source=lib/screens/practice_screen.dart:L721 | neighbors=[practice_screen.dart]
- "screens_practice_screen_in": "in" | kind=code-symbol | source=lib/screens/practice_screen.dart:L141 | neighbors=[practice_screen.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-030.json

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
