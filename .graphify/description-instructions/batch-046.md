# Node Description Batch 47 of 61

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

- "services_python_runner_service_map_y": "map_y()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L216 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_plot": "plot()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L134 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_preparewrappercode": "_prepareWrapperCode()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L37 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_pyplotstub": "_PyplotStub" | kind=code-symbol | source=lib/services/python_runner_service.dart:L125 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_pythonexecutionresult": "PythonExecutionResult" | kind=code-symbol | source=lib/services/python_runner_service.dart:L11 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_pythonrunnerservice": "PythonRunnerService" | kind=code-symbol | source=lib/services/python_runner_service.dart:L30 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_render_svg_plot": "_render_svg_plot()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L198 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_runcode": "runCode()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L336 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_scatter": "scatter()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L152 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_show": "show()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L188 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_title": "title()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L158 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_xlabel": "xlabel()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L161 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_ylabel": "ylabel()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L164 | neighbors=[python_runner_service.dart]
- "services_toc_matcher_hasprintedpagenumbers": "hasPrintedPageNumbers()" | kind=code-symbol | source=lib/services/toc_matcher.dart:L155 | neighbors=[toc_matcher.dart]
- "services_toc_matcher_index": "index" | kind=code-symbol | source=lib/services/toc_matcher.dart:L31 | neighbors=[toc_matcher.dart]
- "services_toc_matcher_ischapterstart": "isChapterStart()" | kind=code-symbol | source=lib/services/toc_matcher.dart:L126 | neighbors=[toc_matcher.dart]
- "services_toc_matcher_normalize": "_normalize()" | kind=code-symbol | source=lib/services/toc_matcher.dart:L74 | neighbors=[toc_matcher.dart]
- "services_toc_matcher_overview": "overview" | kind=code-symbol | source=lib/services/toc_matcher.dart:L31 | neighbors=[toc_matcher.dart]
- "services_toc_matcher_tocmatcher": "TocMatcher" | kind=code-symbol | source=lib/services/toc_matcher.dart:L5 | neighbors=[toc_matcher.dart]
- "services_toc_matcher_tocscore": "tocScore()" | kind=code-symbol | source=lib/services/toc_matcher.dart:L85 | neighbors=[toc_matcher.dart]
- "services_update_service_apkfilefor": "_apkFileFor()" | kind=code-symbol | source=lib/services/update_service.dart:L192 | neighbors=[update_service.dart]
- "services_update_service_cachedapk": "cachedApk()" | kind=code-symbol | source=lib/services/update_service.dart:L199 | neighbors=[update_service.dart]
- "services_update_service_checkforupdate": "checkForUpdate()" | kind=code-symbol | source=lib/services/update_service.dart:L72 | neighbors=[update_service.dart]
- "services_update_service_downloadapk": "downloadApk()" | kind=code-symbol | source=lib/services/update_service.dart:L207 | neighbors=[update_service.dart]
- "services_update_service_fetchchangelog": "_fetchChangelog()" | kind=code-symbol | source=lib/services/update_service.dart:L145 | neighbors=[update_service.dart]
- "services_update_service_getcurrentversionstring": "getCurrentVersionString()" | kind=code-symbol | source=lib/services/update_service.dart:L61 | neighbors=[update_service.dart]
- "services_update_service_installapk": "installApk()" | kind=code-symbol | source=lib/services/update_service.dart:L264 | neighbors=[update_service.dart]
- "services_update_service_markprompted": "markPrompted()" | kind=code-symbol | source=lib/services/update_service.dart:L143 | neighbors=[update_service.dart]
- "services_update_service_pickabi": "_pickAbi()" | kind=code-symbol | source=lib/services/update_service.dart:L170 | neighbors=[update_service.dart]
- "services_update_service_purgestaledownloads": "_purgeStaleDownloads()" | kind=code-symbol | source=lib/services/update_service.dart:L283 | neighbors=[update_service.dart]
- "services_update_service_updateinfo": "UpdateInfo" | kind=code-symbol | source=lib/services/update_service.dart:L13 | neighbors=[update_service.dart]
- "services_update_service_updatesdir": "_updatesDir()" | kind=code-symbol | source=lib/services/update_service.dart:L185 | neighbors=[update_service.dart]
- "services_update_service_updateservice": "UpdateService" | kind=code-symbol | source=lib/services/update_service.dart:L39 | neighbors=[update_service.dart]
- "services_usage_limit_service_arealllimitshit": "areAllLimitsHit()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L259 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_getcapacity": "getCapacity()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L204 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_getkeyscount": "getKeysCount()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L151 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_getlimit": "getLimit()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L226 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_getplatformofmodel": "getPlatformOfModel()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L189 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_getusage": "getUsage()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L239 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_hasownapikey": "hasOwnApiKey()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L184 | neighbors=[usage_limit_service.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-046.json

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
