# Node Description Batch 25 of 68

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

- "screens_ai_queue_screen_loadschedulehours": "_loadScheduleHours()" | kind=code-symbol | source=lib/screens/ai_queue_screen.dart:L44 | neighbors=[ai_queue_screen.dart]
- "screens_ai_queue_screen_showcancelalldialog": "_showCancelAllDialog()" | kind=code-symbol | source=lib/screens/ai_queue_screen.dart:L64 | neighbors=[ai_queue_screen.dart]
- "screens_ai_queue_screen_tasks": "tasks" | kind=code-symbol | source=lib/screens/ai_queue_screen.dart:L748 | neighbors=[ai_queue_screen.dart]
- "screens_app_crash_recovery_screen_appcrashrecoveryscreen": "AppCrashRecoveryScreen" | kind=code-symbol | source=lib/screens/app_crash_recovery_screen.dart:L7 | neighbors=[app_crash_recovery_screen.dart]
- "screens_app_crash_recovery_screen_clearrecordedcrash": "clearRecordedCrash()" | kind=code-symbol | source=lib/screens/app_crash_recovery_screen.dart:L40 | neighbors=[app_crash_recovery_screen.dart]
- "screens_app_crash_recovery_screen_recordcrash": "recordCrash()" | kind=code-symbol | source=lib/screens/app_crash_recovery_screen.dart:L19 | neighbors=[app_crash_recovery_screen.dart]
- "screens_auth_gate_authgate": "AuthGate" | kind=code-symbol | source=lib/screens/auth_gate.dart:L10 | neighbors=[auth_gate.dart]
- "screens_auth_screen_authscreen": "AuthScreen" | kind=code-symbol | source=lib/screens/auth_screen.dart:L12 | neighbors=[auth_screen.dart]
- "screens_auth_screen_authscreenstate": "_AuthScreenState" | kind=code-symbol | source=lib/screens/auth_screen.dart:L19 | neighbors=[auth_screen.dart]
- "screens_auth_screen_submit": "_submit()" | kind=code-symbol | source=lib/screens/auth_screen.dart:L24 | neighbors=[auth_screen.dart]
- "screens_book_dashboard_screen_bookdashboardscreen": "BookDashboardScreen" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L35 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_bookdashboardscreenstate": "_BookDashboardScreenState" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L61 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_checkmissingfiles": "_checkMissingFiles()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L201 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_confirmandresetsectionplan": "_confirmAndResetSectionPlan()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L2452 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_customfloatingactionbuttonlocation": "_CustomFloatingActionButtonLocation" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L3509 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L191 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L137 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_handlerestoresyllabus": "_handleRestoreSyllabus()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L1067 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_has": "has" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L122 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_iconheaderbutton": "_IconHeaderButton" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L3459 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_in": "in" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L128 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L78 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_issectionpdfmissing": "_isSectionPdfMissing()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L905 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_loadlastresumed": "_loadLastResumed()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L162 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_loadprogress": "_loadProgress()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L233 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_menuactionitem": "_MenuActionItem" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L3443 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_navigatetoprerequisite": "_navigateToPrerequisite()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L3299 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_now": "now" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L2633 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_onclearunit": "_onClearUnit()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L401 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_ongenmanagerchanged": "_onGenManagerChanged()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L145 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_onsectionpdfpressed": "_onSectionPdfPressed()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L912 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_openmoduleselector": "_openModuleSelector()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L826 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_openquickreview": "_openQuickReview()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L807 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_opensectionselector": "_openSectionSelector()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L859 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_promptandgenerateunit": "_promptAndGenerateUnit()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L705 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_promptgenerateorschedulemodule": "_promptGenerateOrScheduleModule()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L2691 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_promptgenerateorschedulesection": "_promptGenerateOrScheduleSection()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L2530 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_promptregeneratelesson": "_promptRegenerateLesson()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L472 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_refreshbookfromstorage": "_refreshBookFromStorage()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L151 | neighbors=[book_dashboard_screen.dart]
- "screens_book_dashboard_screen_rundependencysearch": "_runDependencySearch()" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L3023 | neighbors=[book_dashboard_screen.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-024.json

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
