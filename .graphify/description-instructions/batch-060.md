# Node Description Batch 61 of 68

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

- "widgets_canvas_html_view_window_console_error": "window.console.error()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L199 | neighbors=[canvas_html_view.dart]
- "widgets_canvas_html_view_window_console_log": "window.console.log()" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L193 | neighbors=[canvas_html_view.dart]
- "widgets_coach_mark_coachmark": "CoachMark" | kind=code-symbol | source=lib/widgets/coach_mark.dart:L8 | neighbors=[coach_mark.dart]
- "widgets_coach_mark_coachmarkcontroller": "CoachMarkController" | kind=code-symbol | source=lib/widgets/coach_mark.dart:L23 | neighbors=[coach_mark.dart]
- "widgets_coach_mark_holepainter": "_HolePainter" | kind=code-symbol | source=lib/widgets/coach_mark.dart:L165 | neighbors=[coach_mark.dart]
- "widgets_coach_mark_maybeshow": "maybeShow()" | kind=code-symbol | source=lib/widgets/coach_mark.dart:L26 | neighbors=[coach_mark.dart]
- "widgets_coach_mark_paint": "paint()" | kind=code-symbol | source=lib/widgets/coach_mark.dart:L170 | neighbors=[coach_mark.dart]
- "widgets_coach_mark_shouldrepaint": "shouldRepaint()" | kind=code-symbol | source=lib/widgets/coach_mark.dart:L183 | neighbors=[coach_mark.dart]
- "widgets_coach_mark_showone": "_showOne()" | kind=code-symbol | source=lib/widgets/coach_mark.dart:L50 | neighbors=[coach_mark.dart]
- "widgets_code_highlighter_apostrophes": "apostrophes()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L212 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_codeeditingcontroller": "CodeEditingController" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L298 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_codehighlighter": "CodeHighlighter" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L7 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_codetheme": "CodeTheme" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L254 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_isalpha": "_isAlpha()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L237 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_isdigit": "_isDigit()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L236 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_isidentpart": "_isIdentPart()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L249 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_isidentstart": "_isIdentStart()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L244 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_isnumberchar": "_isNumberChar()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L241 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_linecomment": "_lineComment()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L63 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_push": "push()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L96 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_quotes": "quotes()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L212 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_startswith": "startsWith()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L104 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_stringend": "_stringEnd()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L223 | neighbors=[code_highlighter.dart]
- "widgets_combo_badge_combobadge": "ComboBadge" | kind=code-symbol | source=lib/widgets/combo_badge.dart:L5 | neighbors=[combo_badge.dart]
- "widgets_combo_badge_combobadgestate": "_ComboBadgeState" | kind=code-symbol | source=lib/widgets/combo_badge.dart:L19 | neighbors=[combo_badge.dart]
- "widgets_combo_badge_combostyle": "_ComboStyle" | kind=code-symbol | source=lib/widgets/combo_badge.dart:L243 | neighbors=[combo_badge.dart]
- "widgets_combo_badge_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/combo_badge.dart:L91 | neighbors=[combo_badge.dart]
- "widgets_combo_badge_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/combo_badge.dart:L99 | neighbors=[combo_badge.dart]
- "widgets_combo_badge_initstate": "initState()" | kind=code-symbol | source=lib/widgets/combo_badge.dart:L30 | neighbors=[combo_badge.dart]
- "widgets_community_book_card_communitybookcard": "CommunityBookCard" | kind=code-symbol | source=lib/widgets/community_book_card.dart:L6 | neighbors=[community_book_card.dart]
- "widgets_compact_book_card_compactbookcard": "CompactBookCard" | kind=code-symbol | source=lib/widgets/compact_book_card.dart:L7 | neighbors=[compact_book_card.dart]
- "widgets_compact_book_card_getmostusedicon": "_getMostUsedIcon()" | kind=code-symbol | source=lib/widgets/compact_book_card.dart:L23 | neighbors=[compact_book_card.dart]
- "widgets_compact_book_card_in": "in" | kind=code-symbol | source=lib/widgets/compact_book_card.dart:L25 | neighbors=[compact_book_card.dart]
- "widgets_compact_book_list_item_compactbooklistitem": "CompactBookListItem" | kind=code-symbol | source=lib/widgets/compact_book_list_item.dart:L8 | neighbors=[compact_book_list_item.dart]
- "widgets_compact_book_list_item_getmostusedicon": "_getMostUsedIcon()" | kind=code-symbol | source=lib/widgets/compact_book_list_item.dart:L24 | neighbors=[compact_book_list_item.dart]
- "widgets_compact_book_list_item_in": "in" | kind=code-symbol | source=lib/widgets/compact_book_list_item.dart:L26 | neighbors=[compact_book_list_item.dart]
- "widgets_daily_goal_card_applyreminder": "_applyReminder()" | kind=code-symbol | source=lib/widgets/daily_goal_card.dart:L60 | neighbors=[daily_goal_card.dart]
- "widgets_daily_goal_card_dailygoalcard": "DailyGoalCard" | kind=code-symbol | source=lib/widgets/daily_goal_card.dart:L14 | neighbors=[daily_goal_card.dart]
- "widgets_daily_goal_card_dailygoalcardstate": "_DailyGoalCardState" | kind=code-symbol | source=lib/widgets/daily_goal_card.dart:L21 | neighbors=[daily_goal_card.dart]
- "widgets_daily_goal_card_initstate": "initState()" | kind=code-symbol | source=lib/widgets/daily_goal_card.dart:L30 | neighbors=[daily_goal_card.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-060.json

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
