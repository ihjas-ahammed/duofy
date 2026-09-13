# Node Description Batch 65 of 68

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

- "widgets_math_markdown_measure": "_measure()" | kind=code-symbol | source=lib/widgets/math_markdown.dart:L650 | neighbors=[math_markdown.dart]
- "widgets_math_markdown_onmatch": "onMatch()" | kind=code-symbol | source=lib/widgets/math_markdown.dart:L184 | neighbors=[math_markdown.dart]
- "widgets_math_markdown_ontext": "_onText()" | kind=code-symbol | source=lib/widgets/math_markdown.dart:L646 | neighbors=[math_markdown.dart]
- "widgets_math_markdown_permissivelatexinlinesyntax": "_PermissiveLatexInlineSyntax" | kind=code-symbol | source=lib/widgets/math_markdown.dart:L160 | neighbors=[math_markdown.dart]
- "widgets_math_markdown_sanitize": "_sanitize()" | kind=code-symbol | source=lib/widgets/math_markdown.dart:L44 | neighbors=[math_markdown.dart]
- "widgets_mini_progress_bar_miniprogressbar": "MiniProgressBar" | kind=code-symbol | source=lib/widgets/mini_progress_bar.dart:L4 | neighbors=[mini_progress_bar.dart]
- "widgets_missing_files_banner_missingfilesbanner": "MissingFilesBanner" | kind=code-symbol | source=lib/widgets/missing_files_banner.dart:L7 | neighbors=[missing_files_banner.dart]
- "widgets_missing_files_banner_restorefiles": "_restoreFiles()" | kind=code-symbol | source=lib/widgets/missing_files_banner.dart:L12 | neighbors=[missing_files_banner.dart]
- "widgets_next_up_card_initstate": "initState()" | kind=code-symbol | source=lib/widgets/next_up_card.dart:L202 | neighbors=[next_up_card.dart]
- "widgets_next_up_card_lessonloadingscreen": "LessonLoadingScreen" | kind=code-symbol | source=lib/widgets/next_up_card.dart:L182 | neighbors=[next_up_card.dart]
- "widgets_next_up_card_lessonloadingscreenstate": "_LessonLoadingScreenState" | kind=code-symbol | source=lib/widgets/next_up_card.dart:L200 | neighbors=[next_up_card.dart]
- "widgets_next_up_card_load": "_load()" | kind=code-symbol | source=lib/widgets/next_up_card.dart:L21 | neighbors=[next_up_card.dart]
- "widgets_next_up_card_nextupcard": "NextUpCard" | kind=code-symbol | source=lib/widgets/next_up_card.dart:L15 | neighbors=[next_up_card.dart]
- "widgets_platform_webview_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/platform_webview.dart:L52 | neighbors=[platform_webview.dart]
- "widgets_platform_webview_ensureinitialized": "ensureInitialized()" | kind=code-symbol | source=lib/widgets/platform_webview.dart:L113 | neighbors=[platform_webview.dart]
- "widgets_platform_webview_function": "Function()" | kind=code-symbol | source=lib/widgets/platform_webview.dart:L19 | neighbors=[platform_webview.dart]
- "widgets_platform_webview_initstate": "initState()" | kind=code-symbol | source=lib/widgets/platform_webview.dart:L46 | neighbors=[platform_webview.dart]
- "widgets_platform_webview_load": "_load()" | kind=code-symbol | source=lib/widgets/platform_webview.dart:L57 | neighbors=[platform_webview.dart]
- "widgets_platform_webview_platformwebview": "PlatformWebView" | kind=code-symbol | source=lib/widgets/platform_webview.dart:L23 | neighbors=[platform_webview.dart]
- "widgets_platform_webview_platformwebviewbootstrap": "PlatformWebViewBootstrap" | kind=code-symbol | source=lib/widgets/platform_webview.dart:L112 | neighbors=[platform_webview.dart]
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

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-064.json

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
