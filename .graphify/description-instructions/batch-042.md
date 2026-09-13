# Node Description Batch 43 of 68

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

- "services_generation_manager_startbookcontentgeneration": "startBookContentGeneration()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2385 | neighbors=[generation_manager.dart]
- "services_generation_manager_startbookgeneration": "startBookGeneration()" | kind=code-symbol | source=lib/services/generation_manager.dart:L1853 | neighbors=[generation_manager.dart]
- "services_generation_manager_startbookgenerationfrombookmarks": "startBookGenerationFromBookmarks()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2998 | neighbors=[generation_manager.dart]
- "services_generation_manager_startbookskeletongenerationtask": "startBookSkeletonGenerationTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L766 | neighbors=[generation_manager.dart]
- "services_generation_manager_startcustomlessongeneration": "startCustomLessonGeneration()" | kind=code-symbol | source=lib/services/generation_manager.dart:L1816 | neighbors=[generation_manager.dart]
- "services_generation_manager_startmodulegeneration": "startModuleGeneration()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2358 | neighbors=[generation_manager.dart]
- "services_generation_manager_startpyqanalysis": "startPyqAnalysis()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2764 | neighbors=[generation_manager.dart]
- "services_generation_manager_startqpgeneration": "startQpGeneration()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2716 | neighbors=[generation_manager.dart]
- "services_generation_manager_startqueuetimer": "_startQueueTimer()" | kind=code-symbol | source=lib/services/generation_manager.dart:L327 | neighbors=[generation_manager.dart]
- "services_generation_manager_startsectiongeneration": "startSectionGeneration()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2329 | neighbors=[generation_manager.dart]
- "services_generation_manager_startsectionunitmanifest": "startSectionUnitManifest()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2292 | neighbors=[generation_manager.dart]
- "services_generation_manager_startunitgeneration": "startUnitGeneration()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2255 | neighbors=[generation_manager.dart]
- "services_generation_manager_syncactivemapswithqueue": "_syncActiveMapsWithQueue()" | kind=code-symbol | source=lib/services/generation_manager.dart:L244 | neighbors=[generation_manager.dart]
- "services_generation_manager_the": "the" | kind=code-symbol | source=lib/services/generation_manager.dart:L1503 | neighbors=[generation_manager.dart]
- "services_generation_manager_triggerbookupdate": "triggerBookUpdate()" | kind=code-symbol | source=lib/services/generation_manager.dart:L127 | neighbors=[generation_manager.dart]
- "services_generation_manager_unitgentask": "UnitGenTask" | kind=code-symbol | source=lib/services/generation_manager.dart:L55 | neighbors=[generation_manager.dart]
- "services_generation_manager_unregisteractiverequest": "unregisterActiveRequest()" | kind=code-symbol | source=lib/services/generation_manager.dart:L239 | neighbors=[generation_manager.dart]
- "services_generation_manager_updateprogress": "updateProgress()" | kind=code-symbol | source=lib/services/generation_manager.dart:L898 | neighbors=[generation_manager.dart]
- "services_generation_manager_when": "when" | kind=code-symbol | source=lib/services/generation_manager.dart:L1503 | neighbors=[generation_manager.dart]
- "services_global_state_addxp": "addXp()" | kind=code-symbol | source=lib/services/global_state.dart:L74 | neighbors=[global_state.dart]
- "services_global_state_bumpbookmarks": "bumpBookmarks()" | kind=code-symbol | source=lib/services/global_state.dart:L25 | neighbors=[global_state.dart]
- "services_global_state_bumpprogress": "bumpProgress()" | kind=code-symbol | source=lib/services/global_state.dart:L24 | neighbors=[global_state.dart]
- "services_global_state_completeonboarding": "completeOnboarding()" | kind=code-symbol | source=lib/services/global_state.dart:L68 | neighbors=[global_state.dart]
- "services_global_state_globalstate": "GlobalState" | kind=code-symbol | source=lib/services/global_state.dart:L7 | neighbors=[global_state.dart]
- "services_global_state_incrementcombo": "incrementCombo()" | kind=code-symbol | source=lib/services/global_state.dart:L26 | neighbors=[global_state.dart]
- "services_global_state_is": "is" | kind=code-symbol | source=lib/services/global_state.dart:L12 | neighbors=[global_state.dart]
- "services_global_state_resetcombo": "resetCombo()" | kind=code-symbol | source=lib/services/global_state.dart:L27 | neighbors=[global_state.dart]
- "services_global_state_setdropdownreaderflow": "setDropdownReaderFlow()" | kind=code-symbol | source=lib/services/global_state.dart:L62 | neighbors=[global_state.dart]
- "services_guest_service_generateuniqueguestid": "_generateUniqueGuestId()" | kind=code-symbol | source=lib/services/guest_service.dart:L47 | neighbors=[guest_service.dart]
- "services_guest_service_getguestid": "getGuestId()" | kind=code-symbol | source=lib/services/guest_service.dart:L17 | neighbors=[guest_service.dart]
- "services_guest_service_getguestidshort": "getGuestIdShort()" | kind=code-symbol | source=lib/services/guest_service.dart:L54 | neighbors=[guest_service.dart]
- "services_guest_service_guestservice": "GuestService" | kind=code-symbol | source=lib/services/guest_service.dart:L8 | neighbors=[guest_service.dart]
- "services_guest_service_isguestid": "isGuestId()" | kind=code-symbol | source=lib/services/guest_service.dart:L64 | neighbors=[guest_service.dart]
- "services_guest_service_resetguestsession": "resetGuestSession()" | kind=code-symbol | source=lib/services/guest_service.dart:L71 | neighbors=[guest_service.dart]
- "services_home_widget_service_dispatch": "_dispatch()" | kind=code-symbol | source=lib/services/home_widget_service.dart:L43 | neighbors=[home_widget_service.dart]
- "services_home_widget_service_dispose": "dispose()" | kind=code-symbol | source=lib/services/home_widget_service.dart:L38 | neighbors=[home_widget_service.dart]
- "services_home_widget_service_function": "Function()" | kind=code-symbol | source=lib/services/home_widget_service.dart:L16 | neighbors=[home_widget_service.dart]
- "services_home_widget_service_homewidgetservice": "HomeWidgetService" | kind=code-symbol | source=lib/services/home_widget_service.dart:L8 | neighbors=[home_widget_service.dart]
- "services_home_widget_service_init": "init()" | kind=code-symbol | source=lib/services/home_widget_service.dart:L19 | neighbors=[home_widget_service.dart]
- "services_home_widget_service_publishstreak": "publishStreak()" | kind=code-symbol | source=lib/services/home_widget_service.dart:L53 | neighbors=[home_widget_service.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-042.json

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
