# Node Description Batch 58 of 61

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

- "widgets_lesson_path_pathconnectorpainter": "_PathConnectorPainter" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L760 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_pathpoint": "_PathPoint" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L686 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_plan": "_plan()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L880 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_scrolltonextelement": "_scrollToNextElement()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L141 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_sectionmanifestpanel": "_SectionManifestPanel" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L836 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_sectionmanifestpanelstate": "_SectionManifestPanelState" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L864 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_shouldrepaint": "shouldRepaint()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L822 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_unitformatconfirmpanel": "_UnitFormatConfirmPanel" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L1116 | neighbors=[lesson_path.dart]
- "widgets_math_markdown_blankbuilder": "_BlankBuilder" | kind=code-symbol | source=lib/widgets/math_markdown.dart:L575 | neighbors=[math_markdown.dart]
- "widgets_math_markdown_blanksyntax": "_BlankSyntax" | kind=code-symbol | source=lib/widgets/math_markdown.dart:L565 | neighbors=[math_markdown.dart]
- "widgets_math_markdown_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/math_markdown.dart:L632 | neighbors=[math_markdown.dart]
- "widgets_math_markdown_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/math_markdown.dart:L641 | neighbors=[math_markdown.dart]
- "widgets_math_markdown_esc": "_esc()" | kind=code-symbol | source=lib/widgets/math_markdown.dart:L169 | neighbors=[math_markdown.dart]
- "widgets_math_markdown_fixlatex": "_fixLatex()" | kind=code-symbol | source=lib/widgets/math_markdown.dart:L311 | neighbors=[math_markdown.dart]
- "widgets_math_markdown_initstate": "initState()" | kind=code-symbol | source=lib/widgets/math_markdown.dart:L626 | neighbors=[math_markdown.dart]
- "widgets_math_markdown_inlineblankfield": "_InlineBlankField" | kind=code-symbol | source=lib/widgets/math_markdown.dart:L603 | neighbors=[math_markdown.dart]
- "widgets_math_markdown_inlineblankfieldstate": "_InlineBlankFieldState" | kind=code-symbol | source=lib/widgets/math_markdown.dart:L620 | neighbors=[math_markdown.dart]
- "widgets_math_markdown_latextoplaintext": "_latexToPlainText()" | kind=code-symbol | source=lib/widgets/math_markdown.dart:L476 | neighbors=[math_markdown.dart]
- "widgets_math_markdown_mathbuilder": "_MathBuilder" | kind=code-symbol | source=lib/widgets/math_markdown.dart:L219 | neighbors=[math_markdown.dart]
- "widgets_math_markdown_mathmarkdown": "MathMarkdown" | kind=code-symbol | source=lib/widgets/math_markdown.dart:L14 | neighbors=[math_markdown.dart]
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

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-057.json

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
