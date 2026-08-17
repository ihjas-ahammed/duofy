# Node Description Batch 59 of 61

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

- "widgets_platform_webview_platformwebviewcontroller": "PlatformWebViewController" | kind=code-symbol | source=lib/widgets/platform_webview.dart:L18 | neighbors=[platform_webview.dart]
- "widgets_platform_webview_platformwebviewstate": "_PlatformWebViewState" | kind=code-symbol | source=lib/widgets/platform_webview.dart:L41 | neighbors=[platform_webview.dart]
- "widgets_qp_card_qpcard": "QpCard" | kind=code-symbol | source=lib/widgets/qp_card.dart:L6 | neighbors=[qp_card.dart]
- "widgets_quick_review_sheet_changestatus": "_changeStatus()" | kind=code-symbol | source=lib/widgets/quick_review_sheet.dart:L361 | neighbors=[quick_review_sheet.dart]
- "widgets_quick_review_sheet_emptyreviewpanel": "_EmptyReviewPanel" | kind=code-symbol | source=lib/widgets/quick_review_sheet.dart:L270 | neighbors=[quick_review_sheet.dart]
- "widgets_quick_review_sheet_generatereview": "_generateReview()" | kind=code-symbol | source=lib/widgets/quick_review_sheet.dart:L39 | neighbors=[quick_review_sheet.dart]
- "widgets_quick_review_sheet_initstate": "initState()" | kind=code-symbol | source=lib/widgets/quick_review_sheet.dart:L34 | neighbors=[quick_review_sheet.dart]
- "widgets_quick_review_sheet_loadexplanation": "_loadExplanation()" | kind=code-symbol | source=lib/widgets/quick_review_sheet.dart:L537 | neighbors=[quick_review_sheet.dart]
- "widgets_quick_review_sheet_loadingpanel": "_LoadingPanel" | kind=code-symbol | source=lib/widgets/quick_review_sheet.dart:L338 | neighbors=[quick_review_sheet.dart]
- "widgets_quick_review_sheet_loadingpanelstate": "_LoadingPanelState" | kind=code-symbol | source=lib/widgets/quick_review_sheet.dart:L345 | neighbors=[quick_review_sheet.dart]
- "widgets_quick_review_sheet_matchinglessonresult": "MatchingLessonResult" | kind=code-symbol | source=lib/widgets/quick_review_sheet.dart:L257 | neighbors=[quick_review_sheet.dart]
- "widgets_quick_review_sheet_navigatetolesson": "_navigateToLesson()" | kind=code-symbol | source=lib/widgets/quick_review_sheet.dart:L559 | neighbors=[quick_review_sheet.dart]
- "widgets_quick_review_sheet_quickreviewsheet": "QuickReviewSheet" | kind=code-symbol | source=lib/widgets/quick_review_sheet.dart:L11 | neighbors=[quick_review_sheet.dart]
- "widgets_quick_review_sheet_quickreviewsheetstate": "_QuickReviewSheetState" | kind=code-symbol | source=lib/widgets/quick_review_sheet.dart:L29 | neighbors=[quick_review_sheet.dart]
- "widgets_quick_review_sheet_reviewitemcard": "_ReviewItemCard" | kind=code-symbol | source=lib/widgets/quick_review_sheet.dart:L407 | neighbors=[quick_review_sheet.dart]
- "widgets_quick_review_sheet_showdetaildialog": "_showDetailDialog()" | kind=code-symbol | source=lib/widgets/quick_review_sheet.dart:L137 | neighbors=[quick_review_sheet.dart]
- "widgets_quick_review_sheet_statementdetailsheet": "_StatementDetailSheet" | kind=code-symbol | source=lib/widgets/quick_review_sheet.dart:L508 | neighbors=[quick_review_sheet.dart]
- "widgets_quick_review_sheet_statementdetailsheetstate": "_StatementDetailSheetState" | kind=code-symbol | source=lib/widgets/quick_review_sheet.dart:L527 | neighbors=[quick_review_sheet.dart]
- "widgets_real_progress_bar_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/real_progress_bar.dart:L45 | neighbors=[real_progress_bar.dart]
- "widgets_real_progress_bar_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/real_progress_bar.dart:L69 | neighbors=[real_progress_bar.dart]
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

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-058.json

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
