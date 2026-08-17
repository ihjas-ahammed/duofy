# Node Description Batch 34 of 61

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

- "screens_python_ide_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/python_ide_screen.dart:L52 | neighbors=[python_ide_screen.dart]
- "screens_python_ide_screen_notebookcell": "NotebookCell" | kind=code-symbol | source=lib/screens/python_ide_screen.dart:L11 | neighbors=[python_ide_screen.dart]
- "screens_python_ide_screen_pythonidescreen": "PythonIdeScreen" | kind=code-symbol | source=lib/screens/python_ide_screen.dart:L39 | neighbors=[python_ide_screen.dart]
- "screens_python_ide_screen_pythonidescreenstate": "_PythonIdeScreenState" | kind=code-symbol | source=lib/screens/python_ide_screen.dart:L46 | neighbors=[python_ide_screen.dart]
- "screens_python_ide_screen_runallcells": "_runAllCells()" | kind=code-symbol | source=lib/screens/python_ide_screen.dart:L149 | neighbors=[python_ide_screen.dart]
- "screens_python_ide_screen_runcell": "_runCell()" | kind=code-symbol | source=lib/screens/python_ide_screen.dart:L108 | neighbors=[python_ide_screen.dart]
- "screens_python_ide_screen_seeddefaultnotebook": "_seedDefaultNotebook()" | kind=code-symbol | source=lib/screens/python_ide_screen.dart:L57 | neighbors=[python_ide_screen.dart]
- "screens_python_ide_screen_submitrealtimeinput": "_submitRealtimeInput()" | kind=code-symbol | source=lib/screens/python_ide_screen.dart:L98 | neighbors=[python_ide_screen.dart]
- "screens_qp_detail_screen_qpdetailscreen": "QpDetailScreen" | kind=code-symbol | source=lib/screens/qp_detail_screen.dart:L8 | neighbors=[qp_detail_screen.dart]
- "screens_reference_pdf_viewer_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/reference_pdf_viewer_screen.dart:L62 | neighbors=[reference_pdf_viewer_screen.dart]
- "screens_reference_pdf_viewer_screen_gotonextsection": "_goToNextSection()" | kind=code-symbol | source=lib/screens/reference_pdf_viewer_screen.dart:L132 | neighbors=[reference_pdf_viewer_screen.dart]
- "screens_reference_pdf_viewer_screen_gotoprevioussection": "_goToPreviousSection()" | kind=code-symbol | source=lib/screens/reference_pdf_viewer_screen.dart:L122 | neighbors=[reference_pdf_viewer_screen.dart]
- "screens_reference_pdf_viewer_screen_in": "in" | kind=code-symbol | source=lib/screens/reference_pdf_viewer_screen.dart:L42 | neighbors=[reference_pdf_viewer_screen.dart]
- "screens_reference_pdf_viewer_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/reference_pdf_viewer_screen.dart:L37 | neighbors=[reference_pdf_viewer_screen.dart]
- "screens_reference_pdf_viewer_screen_openexternalpdf": "_openExternalPdf()" | kind=code-symbol | source=lib/screens/reference_pdf_viewer_screen.dart:L106 | neighbors=[reference_pdf_viewer_screen.dart]
- "screens_reference_pdf_viewer_screen_referencepdfviewerscreen": "ReferencePdfViewerScreen" | kind=code-symbol | source=lib/screens/reference_pdf_viewer_screen.dart:L12 | neighbors=[reference_pdf_viewer_screen.dart]
- "screens_reference_pdf_viewer_screen_referencepdfviewerscreenstate": "_ReferencePdfViewerScreenState" | kind=code-symbol | source=lib/screens/reference_pdf_viewer_screen.dart:L27 | neighbors=[reference_pdf_viewer_screen.dart]
- "screens_reference_pdf_viewer_screen_resetzoom": "_resetZoom()" | kind=code-symbol | source=lib/screens/reference_pdf_viewer_screen.dart:L89 | neighbors=[reference_pdf_viewer_screen.dart]
- "screens_reference_pdf_viewer_screen_sharepdf": "_sharePdf()" | kind=code-symbol | source=lib/screens/reference_pdf_viewer_screen.dart:L97 | neighbors=[reference_pdf_viewer_screen.dart]
- "screens_reference_pdf_viewer_screen_zoomin": "_zoomIn()" | kind=code-symbol | source=lib/screens/reference_pdf_viewer_screen.dart:L67 | neighbors=[reference_pdf_viewer_screen.dart]
- "screens_reference_pdf_viewer_screen_zoomout": "_zoomOut()" | kind=code-symbol | source=lib/screens/reference_pdf_viewer_screen.dart:L77 | neighbors=[reference_pdf_viewer_screen.dart]
- "screens_section_selection_screen_bookmarkmatch": "_BookmarkMatch" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L1562 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_checknotesstatus": "_checkNotesStatus()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L101 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L72 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L55 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_loaddeadlines": "_loadDeadlines()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L199 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_loadprogress": "_loadProgress()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L168 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_menuactionitem": "_MenuActionItem" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L1546 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_ongenmanagerchanged": "_onGenManagerChanged()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L81 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_onjobupdate": "onJobUpdate()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L143 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_opennotes": "_openNotes()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L112 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_promptgenerateorschedulesection": "_promptGenerateOrScheduleSection()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L1320 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_refreshbookfromstorage": "_refreshBookFromStorage()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L87 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_scrolltoandhighlight": "_scrollToAndHighlight()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L221 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_sectionselectionscreen": "SectionSelectionScreen" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L20 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_sectionselectionscreenstate": "_SectionSelectionScreenState" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L38 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_selectsectiondeadline": "_selectSectionDeadline()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L704 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_showbookmarksdialog": "_showBookmarksDialog()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L840 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_showdeadlinemenu": "_showDeadlineMenu()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L747 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_showsectionlongpressmenu": "_showSectionLongPressMenu()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L1212 | neighbors=[section_selection_screen.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-033.json

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
