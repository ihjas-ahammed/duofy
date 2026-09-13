# Node Description Batch 41 of 68

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

- "services_database_service_savemetacognitionstate": "saveMetacognitionState()" | kind=code-symbol | source=lib/services/database_service.dart:L135 | neighbors=[database_service.dart]
- "services_database_service_saveusersettings": "saveUserSettings()" | kind=code-symbol | source=lib/services/database_service.dart:L442 | neighbors=[database_service.dart]
- "services_database_service_seedguestmocks": "_seedGuestMocks()" | kind=code-symbol | source=lib/services/database_service.dart:L789 | neighbors=[database_service.dart]
- "services_database_service_setcloudenabled": "setCloudEnabled()" | kind=code-symbol | source=lib/services/database_service.dart:L48 | neighbors=[database_service.dart]
- "services_database_service_setlistifnotempty": "setListIfNotEmpty()" | kind=code-symbol | source=lib/services/database_service.dart:L590 | neighbors=[database_service.dart]
- "services_database_service_syncusersettingstolocal": "syncUserSettingsToLocal()" | kind=code-symbol | source=lib/services/database_service.dart:L585 | neighbors=[database_service.dart]
- "services_database_service_writebookfile": "_writeBookFile()" | kind=code-symbol | source=lib/services/database_service.dart:L281 | neighbors=[database_service.dart]
- "services_deadline_service_clearsectiondeadline": "clearSectionDeadline()" | kind=code-symbol | source=lib/services/deadline_service.dart:L45 | neighbors=[deadline_service.dart]
- "services_deadline_service_deadlineservice": "DeadlineService" | kind=code-symbol | source=lib/services/deadline_service.dart:L5 | neighbors=[deadline_service.dart]
- "services_deadline_service_getdeadlinekey": "_getDeadlineKey()" | kind=code-symbol | source=lib/services/deadline_service.dart:L9 | neighbors=[deadline_service.dart]
- "services_deadline_service_getsectiondeadline": "getSectionDeadline()" | kind=code-symbol | source=lib/services/deadline_service.dart:L34 | neighbors=[deadline_service.dart]
- "services_deadline_service_getstartdaycompletedkey": "_getStartDayCompletedKey()" | kind=code-symbol | source=lib/services/deadline_service.dart:L13 | neighbors=[deadline_service.dart]
- "services_deadline_service_gettodaystr": "_getTodayStr()" | kind=code-symbol | source=lib/services/deadline_service.dart:L17 | neighbors=[deadline_service.dart]
- "services_deadline_service_setsectiondeadline": "setSectionDeadline()" | kind=code-symbol | source=lib/services/deadline_service.dart:L21 | neighbors=[deadline_service.dart]
- "services_error_capture_service_capturederror": "CapturedError" | kind=code-symbol | source=lib/services/error_capture_service.dart:L7 | neighbors=[error_capture_service.dart]
- "services_error_capture_service_clearall": "clearAll()" | kind=code-symbol | source=lib/services/error_capture_service.dart:L124 | neighbors=[error_capture_service.dart]
- "services_error_capture_service_dismisserror": "dismissError()" | kind=code-symbol | source=lib/services/error_capture_service.dart:L119 | neighbors=[error_capture_service.dart]
- "services_error_capture_service_errorcaptureservice": "ErrorCaptureService" | kind=code-symbol | source=lib/services/error_capture_service.dart:L27 | neighbors=[error_capture_service.dart]
- "services_error_capture_service_flushpendinguploads": "_flushPendingUploads()" | kind=code-symbol | source=lib/services/error_capture_service.dart:L99 | neighbors=[error_capture_service.dart]
- "services_error_capture_service_queueerrorupload": "_queueErrorUpload()" | kind=code-symbol | source=lib/services/error_capture_service.dart:L73 | neighbors=[error_capture_service.dart]
- "services_error_capture_service_reporterror": "reportError()" | kind=code-symbol | source=lib/services/error_capture_service.dart:L35 | neighbors=[error_capture_service.dart]
- "services_generation_manager_autogeneratemodule1contents": "autoGenerateModule1Contents()" | kind=code-symbol | source=lib/services/generation_manager.dart:L3052 | neighbors=[generation_manager.dart]
- "services_generation_manager_cachemodels": "_cacheModels()" | kind=code-symbol | source=lib/services/generation_manager.dart:L113 | neighbors=[generation_manager.dart]
- "services_generation_manager_cancelalltasks": "cancelAllTasks()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2916 | neighbors=[generation_manager.dart]
- "services_generation_manager_cancelcoursegeneration": "cancelCourseGeneration()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2954 | neighbors=[generation_manager.dart]
- "services_generation_manager_cancelqueuedtask": "cancelQueuedTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2903 | neighbors=[generation_manager.dart]
- "services_generation_manager_checkpagealignment": "checkPageAlignment()" | kind=code-symbol | source=lib/services/generation_manager.dart:L3025 | neighbors=[generation_manager.dart]
- "services_generation_manager_clearcompletedtasks": "clearCompletedTasks()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2936 | neighbors=[generation_manager.dart]
- "services_generation_manager_clearpyqerror": "clearPyqError()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2759 | neighbors=[generation_manager.dart]
- "services_generation_manager_clearqperror": "clearQpError()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2754 | neighbors=[generation_manager.dart]
- "services_generation_manager_clearsectionmanifesterror": "clearSectionManifestError()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2711 | neighbors=[generation_manager.dart]
- "services_generation_manager_cleartasknotification": "_clearTaskNotification()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2820 | neighbors=[generation_manager.dart]
- "services_generation_manager_clearuniterror": "clearUnitError()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2749 | neighbors=[generation_manager.dart]
- "services_generation_manager_crosscheckunit": "_crossCheckUnit()" | kind=code-symbol | source=lib/services/generation_manager.dart:L3102 | neighbors=[generation_manager.dart]
- "services_generation_manager_deleteslide": "deleteSlide()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2526 | neighbors=[generation_manager.dart]
- "services_generation_manager_dismisstask": "dismissTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2814 | neighbors=[generation_manager.dart]
- "services_generation_manager_enqueue": "_enqueue()" | kind=code-symbol | source=lib/services/generation_manager.dart:L735 | neighbors=[generation_manager.dart]
- "services_generation_manager_enqueuetaskobject": "_enqueueTaskObject()" | kind=code-symbol | source=lib/services/generation_manager.dart:L716 | neighbors=[generation_manager.dart]
- "services_generation_manager_executetask": "_executeTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L519 | neighbors=[generation_manager.dart]
- "services_generation_manager_function": "Function()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2561 | neighbors=[generation_manager.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-040.json

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
