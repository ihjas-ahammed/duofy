# Node Description Batch 66 of 68

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

- "widgets_real_progress_bar_initstate": "initState()" | kind=code-symbol | source=lib/widgets/real_progress_bar.dart:L39 | neighbors=[real_progress_bar.dart]
- "widgets_real_progress_bar_realprogressbar": "RealProgressBar" | kind=code-symbol | source=lib/widgets/real_progress_bar.dart:L11 | neighbors=[real_progress_bar.dart]
- "widgets_real_progress_bar_realprogressbarstate": "_RealProgressBarState" | kind=code-symbol | source=lib/widgets/real_progress_bar.dart:L35 | neighbors=[real_progress_bar.dart]
- "widgets_real_progress_bar_starttimerifneeded": "_startTimerIfNeeded()" | kind=code-symbol | source=lib/widgets/real_progress_bar.dart:L50 | neighbors=[real_progress_bar.dart]
- "widgets_realtime_progress_bar_realtimeprogressbar": "RealtimeProgressBar" | kind=code-symbol | source=lib/widgets/realtime_progress_bar.dart:L5 | neighbors=[realtime_progress_bar.dart]
- "widgets_repair_alignment_dialog_showrepairalignmentflow": "showRepairAlignmentFlow()" | kind=code-symbol | source=lib/widgets/repair_alignment_dialog.dart:L17 | neighbors=[repair_alignment_dialog.dart]
- "widgets_responsive_center_responsivecenter": "ResponsiveCenter" | kind=code-symbol | source=lib/widgets/responsive_center.dart:L33 | neighbors=[responsive_center.dart]
- "widgets_responsive_center_responsivemaxwidth": "ResponsiveMaxWidth" | kind=code-symbol | source=lib/widgets/responsive_center.dart:L5 | neighbors=[responsive_center.dart]
- "widgets_safe_pdf_viewer_checkready": "checkReady()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L654 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_clear": "clear()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L58 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_clearsearch": "clearSearch()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L932 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_clearselection": "clearSelection()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L177 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_createpageplaceholder": "createPagePlaceholder()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L710 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L266 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L280 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_firstpage": "firstPage()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L146 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_function": "Function()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L15 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_handlemessage": "_handleMessage()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L339 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_importformdata": "importFormData()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L184 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_initcontroller": "_initController()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L250 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_initstate": "initState()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L244 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_jumpto": "jumpTo()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L116 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_jumptopage": "jumpToPage()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L824 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_jumptosearchinstance": "jumpToSearchInstance()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L912 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_lastpage": "lastPage()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L151 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_loadpdfdata": "_loadPdfData()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L287 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_loadpdffrombase64": "loadPdfFromBase64()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L666 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_nextinstance": "nextInstance()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L48 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_nextpage": "nextPage()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L128 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_nextsearchinstance": "nextSearchInstance()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L918 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_performsearch": "performSearch()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L865 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_postduoerror": "postDuoError()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L642 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_postduomessage": "postDuoMessage()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L632 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_previousinstance": "previousInstance()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L53 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_previouspage": "previousPage()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L137 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_prevsearchinstance": "prevSearchInstance()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L925 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_renderpage": "renderPage()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L743 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_reportsearchresults": "reportSearchResults()" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L938 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_safepdfviewer": "SafePdfViewer" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L203 | neighbors=[safe_pdf_viewer.dart]
- "widgets_safe_pdf_viewer_safepdfviewercontroller": "SafePdfViewerController" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L67 | neighbors=[safe_pdf_viewer.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-065.json

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
