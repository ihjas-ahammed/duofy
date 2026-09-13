# Node Description Batch 62 of 68

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

- "widgets_daily_goal_card_load": "_load()" | kind=code-symbol | source=lib/widgets/daily_goal_card.dart:L35 | neighbors=[daily_goal_card.dart]
- "widgets_daily_goal_card_savegoal": "_saveGoal()" | kind=code-symbol | source=lib/widgets/daily_goal_card.dart:L53 | neighbors=[daily_goal_card.dart]
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
- "widgets_duo_button_duobutton": "DuoButton" | kind=code-symbol | source=lib/widgets/duo_button.dart:L3 | neighbors=[duo_button.dart]
- "widgets_duo_button_duobuttonstate": "_DuoButtonState" | kind=code-symbol | source=lib/widgets/duo_button.dart:L27 | neighbors=[duo_button.dart]
- "widgets_duo_button_duoiconbutton": "DuoIconButton" | kind=code-symbol | source=lib/widgets/duo_button.dart:L95 | neighbors=[duo_button.dart]
- "widgets_duo_button_duoiconbuttonstate": "_DuoIconButtonState" | kind=code-symbol | source=lib/widgets/duo_button.dart:L117 | neighbors=[duo_button.dart]
- "widgets_duo_button_handletapup": "_handleTapUp()" | kind=code-symbol | source=lib/widgets/duo_button.dart:L35 | neighbors=[duo_button.dart]
- "widgets_file_selection_list_fileselectionlist": "FileSelectionList" | kind=code-symbol | source=lib/widgets/file_selection_list.dart:L7 | neighbors=[file_selection_list.dart]
- "widgets_floating_daily_goal_toast_dismiss": "_dismiss()" | kind=code-symbol | source=lib/widgets/floating_daily_goal_toast.dart:L75 | neighbors=[floating_daily_goal_toast.dart]
- "widgets_floating_daily_goal_toast_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/floating_daily_goal_toast.dart:L85 | neighbors=[floating_daily_goal_toast.dart]
- "widgets_floating_daily_goal_toast_floatingdailygoallistener": "FloatingDailyGoalListener" | kind=code-symbol | source=lib/widgets/floating_daily_goal_toast.dart:L265 | neighbors=[floating_daily_goal_toast.dart]
- "widgets_floating_daily_goal_toast_floatingdailygoallistenerstate": "_FloatingDailyGoalListenerState" | kind=code-symbol | source=lib/widgets/floating_daily_goal_toast.dart:L275 | neighbors=[floating_daily_goal_toast.dart]
- "widgets_floating_daily_goal_toast_floatingdailygoaltoast": "FloatingDailyGoalToast" | kind=code-symbol | source=lib/widgets/floating_daily_goal_toast.dart:L10 | neighbors=[floating_daily_goal_toast.dart]
- "widgets_floating_daily_goal_toast_floatingdailygoaltoaststate": "_FloatingDailyGoalToastState" | kind=code-symbol | source=lib/widgets/floating_daily_goal_toast.dart:L24 | neighbors=[floating_daily_goal_toast.dart]
- "widgets_floating_daily_goal_toast_initstate": "initState()" | kind=code-symbol | source=lib/widgets/floating_daily_goal_toast.dart:L32 | neighbors=[floating_daily_goal_toast.dart]
- "widgets_floating_daily_goal_toast_ongoalupdate": "_onGoalUpdate()" | kind=code-symbol | source=lib/widgets/floating_daily_goal_toast.dart:L291 | neighbors=[floating_daily_goal_toast.dart]
- "widgets_floating_daily_goal_toast_opengoalsscreen": "_openGoalsScreen()" | kind=code-symbol | source=lib/widgets/floating_daily_goal_toast.dart:L66 | neighbors=[floating_daily_goal_toast.dart]
- "widgets_generating_book_card_generatingbookcard": "GeneratingBookCard" | kind=code-symbol | source=lib/widgets/generating_book_card.dart:L8 | neighbors=[generating_book_card.dart]
- "widgets_glassy_nav_bar_glassynavbar": "GlassyNavBar" | kind=code-symbol | source=lib/widgets/glassy_nav_bar.dart:L5 | neighbors=[glassy_nav_bar.dart]
- "widgets_global_error_capture_layer_globalerrorcapturelayer": "GlobalErrorCaptureLayer" | kind=code-symbol | source=lib/widgets/global_error_capture_layer.dart:L8 | neighbors=[global_error_capture_layer.dart]
- "widgets_global_error_capture_layer_globalerrorcapturelayerstate": "_GlobalErrorCaptureLayerState" | kind=code-symbol | source=lib/widgets/global_error_capture_layer.dart:L20 | neighbors=[global_error_capture_layer.dart]
- "widgets_ide_config_dialog_ideconfigdialog": "IdeConfigDialog" | kind=code-symbol | source=lib/widgets/ide_config_dialog.dart:L6 | neighbors=[ide_config_dialog.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-061.json

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
