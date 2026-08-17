# Node Description Batch 38 of 61

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

- "services_auto_index_service_function": "Function()" | kind=code-symbol | source=lib/services/auto_index_service.dart:L21 | neighbors=[auto_index_service.dart]
- "services_b2_service_b2credentials": "B2Credentials" | kind=code-symbol | source=lib/services/b2_service.dart:L58 | neighbors=[b2_service.dart]
- "services_b2_service_b2object": "B2Object" | kind=code-symbol | source=lib/services/b2_service.dart:L10 | neighbors=[b2_service.dart]
- "services_b2_service_b2service": "B2Service" | kind=code-symbol | source=lib/services/b2_service.dart:L78 | neighbors=[b2_service.dart]
- "services_b2_service_copyobjectdirect": "_copyObjectDirect()" | kind=code-symbol | source=lib/services/b2_service.dart:L380 | neighbors=[b2_service.dart]
- "services_b2_service_deleteobject": "deleteObject()" | kind=code-symbol | source=lib/services/b2_service.dart:L319 | neighbors=[b2_service.dart]
- "services_b2_service_deletepartdirect": "_deletePartDirect()" | kind=code-symbol | source=lib/services/b2_service.dart:L712 | neighbors=[b2_service.dart]
- "services_b2_service_downloadobject": "downloadObject()" | kind=code-symbol | source=lib/services/b2_service.dart:L227 | neighbors=[b2_service.dart]
- "services_b2_service_downloadpartdirect": "_downloadPartDirect()" | kind=code-symbol | source=lib/services/b2_service.dart:L683 | neighbors=[b2_service.dart]
- "services_b2_service_formatamzdate": "_formatAmzDate()" | kind=code-symbol | source=lib/services/b2_service.dart:L631 | neighbors=[b2_service.dart]
- "services_b2_service_formatdatestamp": "_formatDateStamp()" | kind=code-symbol | source=lib/services/b2_service.dart:L640 | neighbors=[b2_service.dart]
- "services_b2_service_function": "Function()" | kind=code-symbol | source=lib/services/b2_service.dart:L148 | neighbors=[b2_service.dart]
- "services_b2_service_getcredentials": "getCredentials()" | kind=code-symbol | source=lib/services/b2_service.dart:L87 | neighbors=[b2_service.dart]
- "services_b2_service_hmacsha256hex": "_hmacSha256Hex()" | kind=code-symbol | source=lib/services/b2_service.dart:L626 | neighbors=[b2_service.dart]
- "services_b2_service_isconfigured": "isConfigured()" | kind=code-symbol | source=lib/services/b2_service.dart:L110 | neighbors=[b2_service.dart]
- "services_b2_service_moveobject": "moveObject()" | kind=code-symbol | source=lib/services/b2_service.dart:L413 | neighbors=[b2_service.dart]
- "services_b2_service_runworker": "runWorker()" | kind=code-symbol | source=lib/services/b2_service.dart:L507 | neighbors=[b2_service.dart]
- "services_b2_service_uploadobject": "uploadObject()" | kind=code-symbol | source=lib/services/b2_service.dart:L145 | neighbors=[b2_service.dart]
- "services_b2_service_uploadpartdirect": "_uploadPartDirect()" | kind=code-symbol | source=lib/services/b2_service.dart:L650 | neighbors=[b2_service.dart]
- "services_bookmark_service_add": "add()" | kind=code-symbol | source=lib/services/bookmark_service.dart:L98 | neighbors=[bookmark_service.dart]
- "services_bookmark_service_bookmark": "Bookmark" | kind=code-symbol | source=lib/services/bookmark_service.dart:L9 | neighbors=[bookmark_service.dart]
- "services_bookmark_service_bookmarkservice": "BookmarkService" | kind=code-symbol | source=lib/services/bookmark_service.dart:L65 | neighbors=[bookmark_service.dart]
- "services_bookmark_service_isbookmarked": "isBookmarked()" | kind=code-symbol | source=lib/services/bookmark_service.dart:L92 | neighbors=[bookmark_service.dart]
- "services_bookmark_service_markopened": "markOpened()" | kind=code-symbol | source=lib/services/bookmark_service.dart:L147 | neighbors=[bookmark_service.dart]
- "services_bookmark_service_remove": "remove()" | kind=code-symbol | source=lib/services/bookmark_service.dart:L119 | neighbors=[bookmark_service.dart]
- "services_bookmark_service_toggle": "toggle()" | kind=code-symbol | source=lib/services/bookmark_service.dart:L126 | neighbors=[bookmark_service.dart]
- "services_bookmark_service_write": "_write()" | kind=code-symbol | source=lib/services/bookmark_service.dart:L86 | neighbors=[bookmark_service.dart]
- "services_code_storage_service_codestorageservice": "CodeStorageService" | kind=code-symbol | source=lib/services/code_storage_service.dart:L89 | neighbors=[code_storage_service.dart]
- "services_code_storage_service_deleteproject": "deleteProject()" | kind=code-symbol | source=lib/services/code_storage_service.dart:L130 | neighbors=[code_storage_service.dart]
- "services_code_storage_service_ideproject": "IdeProject" | kind=code-symbol | source=lib/services/code_storage_service.dart:L42 | neighbors=[code_storage_service.dart]
- "services_code_storage_service_notebookcell": "NotebookCell" | kind=code-symbol | source=lib/services/code_storage_service.dart:L4 | neighbors=[code_storage_service.dart]
- "services_code_storage_service_saveproject": "saveProject()" | kind=code-symbol | source=lib/services/code_storage_service.dart:L114 | neighbors=[code_storage_service.dart]
- "services_daily_goals_service_claimreward": "claimReward()" | kind=code-symbol | source=lib/services/daily_goals_service.dart:L429 | neighbors=[daily_goals_service.dart]
- "services_daily_goals_service_dailygoalsservice": "DailyGoalsService" | kind=code-symbol | source=lib/services/daily_goals_service.dart:L9 | neighbors=[daily_goals_service.dart]
- "services_daily_goals_service_gettodaystring": "getTodayString()" | kind=code-symbol | source=lib/services/daily_goals_service.dart:L216 | neighbors=[daily_goals_service.dart]
- "services_daily_goals_service_isfirstlaunchtoday": "isFirstLaunchToday()" | kind=code-symbol | source=lib/services/daily_goals_service.dart:L330 | neighbors=[daily_goals_service.dart]
- "services_daily_goals_service_markfirstlaunchseen": "markFirstLaunchSeen()" | kind=code-symbol | source=lib/services/daily_goals_service.dart:L338 | neighbors=[daily_goals_service.dart]
- "services_daily_goals_service_savegoals": "_saveGoals()" | kind=code-symbol | source=lib/services/daily_goals_service.dart:L322 | neighbors=[daily_goals_service.dart]
- "services_daily_goals_service_updateprogressonactivity": "updateProgressOnActivity()" | kind=code-symbol | source=lib/services/daily_goals_service.dart:L345 | neighbors=[daily_goals_service.dart]
- "services_database_service_booksdir": "_booksDir()" | kind=code-symbol | source=lib/services/database_service.dart:L182 | neighbors=[database_service.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-037.json

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
