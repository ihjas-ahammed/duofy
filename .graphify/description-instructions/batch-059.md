# Node Description Batch 60 of 61

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

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-059.json

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
