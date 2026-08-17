# Node Description Batch 55 of 61

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

- "widgets_code_highlighter_push": "push()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L80 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_startswith": "startsWith()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L88 | neighbors=[code_highlighter.dart]
- "widgets_code_highlighter_stringend": "_stringEnd()" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L188 | neighbors=[code_highlighter.dart]
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
- "widgets_daily_goal_card_applyreminder": "_applyReminder()" | kind=code-symbol | source=lib/widgets/daily_goal_card.dart:L58 | neighbors=[daily_goal_card.dart]
- "widgets_daily_goal_card_dailygoalcard": "DailyGoalCard" | kind=code-symbol | source=lib/widgets/daily_goal_card.dart:L13 | neighbors=[daily_goal_card.dart]
- "widgets_daily_goal_card_dailygoalcardstate": "_DailyGoalCardState" | kind=code-symbol | source=lib/widgets/daily_goal_card.dart:L20 | neighbors=[daily_goal_card.dart]
- "widgets_daily_goal_card_initstate": "initState()" | kind=code-symbol | source=lib/widgets/daily_goal_card.dart:L29 | neighbors=[daily_goal_card.dart]
- "widgets_daily_goal_card_load": "_load()" | kind=code-symbol | source=lib/widgets/daily_goal_card.dart:L34 | neighbors=[daily_goal_card.dart]
- "widgets_daily_goal_card_savegoal": "_saveGoal()" | kind=code-symbol | source=lib/widgets/daily_goal_card.dart:L52 | neighbors=[daily_goal_card.dart]
- "widgets_daily_goals_complete_card_dailygoalscompletecard": "DailyGoalsCompleteCard" | kind=code-symbol | source=lib/widgets/daily_goals_complete_card.dart:L8 | neighbors=[daily_goals_complete_card.dart]
- "widgets_daily_goals_complete_card_dailygoalscompletecardstate": "_DailyGoalsCompleteCardState" | kind=code-symbol | source=lib/widgets/daily_goals_complete_card.dart:L15 | neighbors=[daily_goals_complete_card.dart]
- "widgets_daily_goals_complete_card_initstate": "initState()" | kind=code-symbol | source=lib/widgets/daily_goals_complete_card.dart:L19 | neighbors=[daily_goals_complete_card.dart]
- "widgets_daily_goals_popup_checkandshow": "checkAndShow()" | kind=code-symbol | source=lib/widgets/daily_goals_popup.dart:L15 | neighbors=[daily_goals_popup.dart]
- "widgets_daily_goals_popup_dailygoalspopup": "DailyGoalsPopup" | kind=code-symbol | source=lib/widgets/daily_goals_popup.dart:L10 | neighbors=[daily_goals_popup.dart]
- "widgets_desktop_webview_io_desktopwebview": "DesktopWebView" | kind=code-symbol | source=lib/widgets/desktop_webview_io.dart:L31 | neighbors=[desktop_webview_io.dart]
- "widgets_desktop_webview_io_desktopwebviewensureinitialized": "desktopWebViewEnsureInitialized()" | kind=code-symbol | source=lib/widgets/desktop_webview_io.dart:L26 | neighbors=[desktop_webview_io.dart]
- "widgets_desktop_webview_io_desktopwebviewstate": "_DesktopWebViewState" | kind=code-symbol | source=lib/widgets/desktop_webview_io.dart:L49 | neighbors=[desktop_webview_io.dart]
- "widgets_desktop_webview_io_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/desktop_webview_io.dart:L67 | neighbors=[desktop_webview_io.dart]
- "widgets_desktop_webview_io_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/desktop_webview_io.dart:L229 | neighbors=[desktop_webview_io.dart]
- "widgets_desktop_webview_io_function": "Function()" | kind=code-symbol | source=lib/widgets/desktop_webview_io.dart:L35 | neighbors=[desktop_webview_io.dart]
- "widgets_desktop_webview_io_initstate": "initState()" | kind=code-symbol | source=lib/widgets/desktop_webview_io.dart:L61 | neighbors=[desktop_webview_io.dart]
- "widgets_desktop_webview_io_load": "_load()" | kind=code-symbol | source=lib/widgets/desktop_webview_io.dart:L72 | neighbors=[desktop_webview_io.dart]
- "widgets_desktop_webview_io_loadcef": "_loadCef()" | kind=code-symbol | source=lib/widgets/desktop_webview_io.dart:L133 | neighbors=[desktop_webview_io.dart]
- "widgets_desktop_webview_io_loadwindows": "_loadWindows()" | kind=code-symbol | source=lib/widgets/desktop_webview_io.dart:L80 | neighbors=[desktop_webview_io.dart]
- "widgets_desktop_webview_stub_desktopwebview": "DesktopWebView" | kind=code-symbol | source=lib/widgets/desktop_webview_stub.dart:L12 | neighbors=[desktop_webview_stub.dart]
- "widgets_desktop_webview_stub_desktopwebviewensureinitialized": "desktopWebViewEnsureInitialized()" | kind=code-symbol | source=lib/widgets/desktop_webview_stub.dart:L10 | neighbors=[desktop_webview_stub.dart]
- "widgets_desktop_webview_stub_function": "Function()" | kind=code-symbol | source=lib/widgets/desktop_webview_stub.dart:L16 | neighbors=[desktop_webview_stub.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-054.json

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
