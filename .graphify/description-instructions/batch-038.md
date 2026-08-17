# Node Description Batch 39 of 61

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

- "services_database_service_databaseservice": "DatabaseService" | kind=code-symbol | source=lib/services/database_service.dart:L25 | neighbors=[database_service.dart]
- "services_database_service_deletebook": "deleteBook()" | kind=code-symbol | source=lib/services/database_service.dart:L865 | neighbors=[database_service.dart]
- "services_database_service_deletebookfile": "_deleteBookFile()" | kind=code-symbol | source=lib/services/database_service.dart:L400 | neighbors=[database_service.dart]
- "services_database_service_deleteglobalbook": "deleteGlobalBook()" | kind=code-symbol | source=lib/services/database_service.dart:L971 | neighbors=[database_service.dart]
- "services_database_service_fetchglobalbookbyid": "fetchGlobalBookById()" | kind=code-symbol | source=lib/services/database_service.dart:L951 | neighbors=[database_service.dart]
- "services_database_service_function": "Function()" | kind=code-symbol | source=lib/services/database_service.dart:L658 | neighbors=[database_service.dart]
- "services_database_service_getbookfromcache": "getBookFromCache()" | kind=code-symbol | source=lib/services/database_service.dart:L801 | neighbors=[database_service.dart]
- "services_database_service_iscloudenabled": "isCloudEnabled()" | kind=code-symbol | source=lib/services/database_service.dart:L43 | neighbors=[database_service.dart]
- "services_database_service_isguestid": "isGuestId()" | kind=code-symbol | source=lib/services/database_service.dart:L34 | neighbors=[database_service.dart]
- "services_database_service_publishtoglobal": "publishToGlobal()" | kind=code-symbol | source=lib/services/database_service.dart:L929 | neighbors=[database_service.dart]
- "services_database_service_savefolders": "saveFolders()" | kind=code-symbol | source=lib/services/database_service.dart:L1030 | neighbors=[database_service.dart]
- "services_database_service_savegeneratedbook": "saveGeneratedBook()" | kind=code-symbol | source=lib/services/database_service.dart:L832 | neighbors=[database_service.dart]
- "services_database_service_savelearningstate": "saveLearningState()" | kind=code-symbol | source=lib/services/database_service.dart:L81 | neighbors=[database_service.dart]
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
- "services_error_capture_service_capturederror": "CapturedError" | kind=code-symbol | source=lib/services/error_capture_service.dart:L3 | neighbors=[error_capture_service.dart]
- "services_error_capture_service_clearall": "clearAll()" | kind=code-symbol | source=lib/services/error_capture_service.dart:L64 | neighbors=[error_capture_service.dart]
- "services_error_capture_service_dismisserror": "dismissError()" | kind=code-symbol | source=lib/services/error_capture_service.dart:L59 | neighbors=[error_capture_service.dart]
- "services_error_capture_service_errorcaptureservice": "ErrorCaptureService" | kind=code-symbol | source=lib/services/error_capture_service.dart:L23 | neighbors=[error_capture_service.dart]
- "services_error_capture_service_reporterror": "reportError()" | kind=code-symbol | source=lib/services/error_capture_service.dart:L29 | neighbors=[error_capture_service.dart]
- "services_generation_manager_autogeneratemodule1contents": "autoGenerateModule1Contents()" | kind=code-symbol | source=lib/services/generation_manager.dart:L3052 | neighbors=[generation_manager.dart]
- "services_generation_manager_cachemodels": "_cacheModels()" | kind=code-symbol | source=lib/services/generation_manager.dart:L113 | neighbors=[generation_manager.dart]
- "services_generation_manager_cancelalltasks": "cancelAllTasks()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2916 | neighbors=[generation_manager.dart]
- "services_generation_manager_cancelcoursegeneration": "cancelCourseGeneration()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2954 | neighbors=[generation_manager.dart]
- "services_generation_manager_cancelqueuedtask": "cancelQueuedTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2903 | neighbors=[generation_manager.dart]
- "services_generation_manager_checkpagealignment": "checkPageAlignment()" | kind=code-symbol | source=lib/services/generation_manager.dart:L3025 | neighbors=[generation_manager.dart]
- "services_generation_manager_clearcompletedtasks": "clearCompletedTasks()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2936 | neighbors=[generation_manager.dart]
- "services_generation_manager_clearpyqerror": "clearPyqError()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2759 | neighbors=[generation_manager.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-038.json

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
