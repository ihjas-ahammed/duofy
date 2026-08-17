# Node Description Batch 23 of 61

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

- "runner_my_application_my_application_init": "my_application_init()" | kind=code-symbol | source=linux/runner/my_application.cc:L142 | neighbors=[my_application.h]
- "runner_my_application_my_application_local_command_line": "my_application_local_command_line()" | kind=code-symbol | source=linux/runner/my_application.cc:L88 | neighbors=[my_application.h]
- "runner_my_application_my_application_new": "my_application_new()" | kind=code-symbol | source=linux/runner/my_application.cc:L144 | neighbors=[my_application.h]
- "runner_my_application_my_application_shutdown": "my_application_shutdown()" | kind=code-symbol | source=linux/runner/my_application.cc:L118 | neighbors=[my_application.h]
- "runner_my_application_my_application_startup": "my_application_startup()" | kind=code-symbol | source=linux/runner/my_application.cc:L109 | neighbors=[my_application.h]
- "runner_utils_createandattachconsole": "CreateAndAttachConsole()" | kind=code-symbol | source=windows/runner/utils.cpp:L10 | neighbors=[utils.h]
- "runner_win32_window_gethandle": "GetHandle()" | kind=code-symbol | source=windows/runner/win32_window.cpp:L258 | neighbors=[win32_window.h]
- "runner_win32_window_setquitonclose": "SetQuitOnClose()" | kind=code-symbol | source=windows/runner/win32_window.cpp:L262 | neighbors=[win32_window.h]
- "runner_win32_window_show": "Show()" | kind=code-symbol | source=windows/runner/win32_window.cpp:L152 | neighbors=[win32_window.h]
- "runner_win32_window_windowclassregistrar_windowclassregistrar": ".WindowClassRegistrar()" | kind=code-symbol | source=windows/runner/win32_window.cpp:L61 | neighbors=[WindowClassRegistrar]
- "scratch": "scratch.dart" | kind=code-symbol | source=scratch.dart:L1 | neighbors=[main()]
- "scratch_main": "main()" | kind=code-symbol | source=scratch.dart:L4 | neighbors=[scratch.dart]
- "screens_ai_providers_screen_addmodeltoslot": "_addModelToSlot()" | kind=code-symbol | source=lib/screens/ai_providers_screen.dart:L453 | neighbors=[ai_providers_screen.dart]
- "screens_ai_providers_screen_aiprovidersscreen": "AiProvidersScreen" | kind=code-symbol | source=lib/screens/ai_providers_screen.dart:L16 | neighbors=[ai_providers_screen.dart]
- "screens_ai_providers_screen_aiprovidersscreenstate": "_AiProvidersScreenState" | kind=code-symbol | source=lib/screens/ai_providers_screen.dart:L23 | neighbors=[ai_providers_screen.dart]
- "screens_ai_providers_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/ai_providers_screen.dart:L1328 | neighbors=[ai_providers_screen.dart]
- "screens_ai_providers_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/ai_providers_screen.dart:L64 | neighbors=[ai_providers_screen.dart]
- "screens_ai_providers_screen_loadsettings": "_loadSettings()" | kind=code-symbol | source=lib/screens/ai_providers_screen.dart:L82 | neighbors=[ai_providers_screen.dart]
- "screens_ai_providers_screen_opentestaidialog": "_openTestAiDialog()" | kind=code-symbol | source=lib/screens/ai_providers_screen.dart:L861 | neighbors=[ai_providers_screen.dart]
- "screens_ai_providers_screen_rank": "rank()" | kind=code-symbol | source=lib/screens/ai_providers_screen.dart:L440 | neighbors=[ai_providers_screen.dart]
- "screens_ai_providers_screen_removefromslot": "_removeFromSlot()" | kind=code-symbol | source=lib/screens/ai_providers_screen.dart:L390 | neighbors=[ai_providers_screen.dart]
- "screens_ai_providers_screen_reorderslot": "_reorderSlot()" | kind=code-symbol | source=lib/screens/ai_providers_screen.dart:L381 | neighbors=[ai_providers_screen.dart]
- "screens_ai_providers_screen_savesettings": "_saveSettings()" | kind=code-symbol | source=lib/screens/ai_providers_screen.dart:L256 | neighbors=[ai_providers_screen.dart]
- "screens_ai_providers_screen_scrolltobottom": "_scrollToBottom()" | kind=code-symbol | source=lib/screens/ai_providers_screen.dart:L1578 | neighbors=[ai_providers_screen.dart]
- "screens_ai_providers_screen_sendmessage": "_sendMessage()" | kind=code-symbol | source=lib/screens/ai_providers_screen.dart:L1457 | neighbors=[ai_providers_screen.dart]
- "screens_ai_providers_screen_testaichatmessage": "TestAiChatMessage" | kind=code-symbol | source=lib/screens/ai_providers_screen.dart:L1238 | neighbors=[ai_providers_screen.dart]
- "screens_ai_providers_screen_testaidialog": "TestAiDialog" | kind=code-symbol | source=lib/screens/ai_providers_screen.dart:L1252 | neighbors=[ai_providers_screen.dart]
- "screens_ai_providers_screen_testaidialogstate": "_TestAiDialogState" | kind=code-symbol | source=lib/screens/ai_providers_screen.dart:L1308 | neighbors=[ai_providers_screen.dart]
- "screens_ai_providers_screen_updateselectedmodel": "_updateSelectedModel()" | kind=code-symbol | source=lib/screens/ai_providers_screen.dart:L1374 | neighbors=[ai_providers_screen.dart]
- "screens_ai_queue_screen_aiqueuescreen": "AiQueueScreen" | kind=code-symbol | source=lib/screens/ai_queue_screen.dart:L13 | neighbors=[ai_queue_screen.dart]
- "screens_ai_queue_screen_aiqueuescreenstate": "_AiQueueScreenState" | kind=code-symbol | source=lib/screens/ai_queue_screen.dart:L20 | neighbors=[ai_queue_screen.dart]
- "screens_ai_queue_screen_formattime": "formatTime()" | kind=code-symbol | source=lib/screens/ai_queue_screen.dart:L51 | neighbors=[ai_queue_screen.dart]
- "screens_ai_queue_screen_in": "in" | kind=code-symbol | source=lib/screens/ai_queue_screen.dart:L690 | neighbors=[ai_queue_screen.dart]
- "screens_ai_queue_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/ai_queue_screen.dart:L25 | neighbors=[ai_queue_screen.dart]
- "screens_ai_queue_screen_loadbooksandschedule": "_loadBooksAndSchedule()" | kind=code-symbol | source=lib/screens/ai_queue_screen.dart:L30 | neighbors=[ai_queue_screen.dart]
- "screens_ai_queue_screen_loadschedulehours": "_loadScheduleHours()" | kind=code-symbol | source=lib/screens/ai_queue_screen.dart:L44 | neighbors=[ai_queue_screen.dart]
- "screens_ai_queue_screen_showcancelalldialog": "_showCancelAllDialog()" | kind=code-symbol | source=lib/screens/ai_queue_screen.dart:L64 | neighbors=[ai_queue_screen.dart]
- "screens_ai_queue_screen_tasks": "tasks" | kind=code-symbol | source=lib/screens/ai_queue_screen.dart:L748 | neighbors=[ai_queue_screen.dart]
- "screens_app_crash_recovery_screen_appcrashrecoveryscreen": "AppCrashRecoveryScreen" | kind=code-symbol | source=lib/screens/app_crash_recovery_screen.dart:L7 | neighbors=[app_crash_recovery_screen.dart]
- "screens_app_crash_recovery_screen_clearrecordedcrash": "clearRecordedCrash()" | kind=code-symbol | source=lib/screens/app_crash_recovery_screen.dart:L40 | neighbors=[app_crash_recovery_screen.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-022.json

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
