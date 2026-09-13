# Node Description Batch 64 of 68

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

- "widgets_lesson_node_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/lesson_node.dart:L278 | neighbors=[lesson_node.dart]
- "widgets_lesson_node_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/lesson_node.dart:L289 | neighbors=[lesson_node.dart]
- "widgets_lesson_node_initstate": "initState()" | kind=code-symbol | source=lib/widgets/lesson_node.dart:L268 | neighbors=[lesson_node.dart]
- "widgets_lesson_node_lessonnodewidget": "LessonNodeWidget" | kind=code-symbol | source=lib/widgets/lesson_node.dart:L328 | neighbors=[lesson_node.dart]
- "widgets_lesson_node_lessonnodewidgetstate": "_LessonNodeWidgetState" | kind=code-symbol | source=lib/widgets/lesson_node.dart:L363 | neighbors=[lesson_node.dart]
- "widgets_lesson_node_nextnodepop": "NextNodePop" | kind=code-symbol | source=lib/widgets/lesson_node.dart:L254 | neighbors=[lesson_node.dart]
- "widgets_lesson_node_nextnodepopstate": "_NextNodePopState" | kind=code-symbol | source=lib/widgets/lesson_node.dart:L263 | neighbors=[lesson_node.dart]
- "widgets_lesson_path_activegeneratingnodewrapper": "_ActiveGeneratingNodeWrapper" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L1344 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_activegeneratingnodewrapperstate": "_ActiveGeneratingNodeWrapperState" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L1362 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_confirm": "_confirm()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L1135 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L106 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L122 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_element": "_Element" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L695 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_function": "Function()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L37 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_initstate": "initState()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L100 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_launchnextlesson": "_launchNextLesson()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L185 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_lessonpath": "LessonPath" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L21 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_lessonpathstate": "_LessonPathState" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L93 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_loadlastlesson": "_loadLastLesson()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L127 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_paint": "paint()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L787 | neighbors=[lesson_path.dart]
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

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-063.json

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
