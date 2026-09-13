# Node Description Batch 53 of 68

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

- "services_update_service_getcurrentversionstring": "getCurrentVersionString()" | kind=code-symbol | source=lib/services/update_service.dart:L61 | neighbors=[update_service.dart]
- "services_update_service_installapk": "installApk()" | kind=code-symbol | source=lib/services/update_service.dart:L327 | neighbors=[update_service.dart]
- "services_update_service_markprompted": "markPrompted()" | kind=code-symbol | source=lib/services/update_service.dart:L198 | neighbors=[update_service.dart]
- "services_update_service_pickabi": "_pickAbi()" | kind=code-symbol | source=lib/services/update_service.dart:L233 | neighbors=[update_service.dart]
- "services_update_service_purgestaledownloads": "_purgeStaleDownloads()" | kind=code-symbol | source=lib/services/update_service.dart:L346 | neighbors=[update_service.dart]
- "services_update_service_updateinfo": "UpdateInfo" | kind=code-symbol | source=lib/services/update_service.dart:L13 | neighbors=[update_service.dart]
- "services_update_service_updatesdir": "_updatesDir()" | kind=code-symbol | source=lib/services/update_service.dart:L248 | neighbors=[update_service.dart]
- "services_update_service_updateservice": "UpdateService" | kind=code-symbol | source=lib/services/update_service.dart:L39 | neighbors=[update_service.dart]
- "services_usage_limit_service_arealllimitshit": "areAllLimitsHit()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L259 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_getcapacity": "getCapacity()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L204 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_getkeyscount": "getKeysCount()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L151 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_getlimit": "getLimit()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L226 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_getplatformofmodel": "getPlatformOfModel()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L189 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_getusage": "getUsage()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L239 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_hasownapikey": "hasOwnApiKey()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L184 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_hasownapikeysync": "hasOwnApiKeySync()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L179 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_incrementusage": "incrementUsage()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L245 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_init": "init()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L56 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_islimitexceeded": "isLimitExceeded()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L252 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_resetlocalusage": "_resetLocalUsage()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L140 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_syncwithbackend": "_syncWithBackend()" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L92 | neighbors=[usage_limit_service.dart]
- "services_usage_limit_service_usagelimitservice": "UsageLimitService" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L8 | neighbors=[usage_limit_service.dart]
- "services_walkthrough_service_advanceto": "advanceTo()" | kind=code-symbol | source=lib/services/walkthrough_service.dart:L69 | neighbors=[walkthrough_service.dart]
- "services_walkthrough_service_finish": "finish()" | kind=code-symbol | source=lib/services/walkthrough_service.dart:L74 | neighbors=[walkthrough_service.dart]
- "services_walkthrough_service_isdone": "isDone()" | kind=code-symbol | source=lib/services/walkthrough_service.dart:L82 | neighbors=[walkthrough_service.dart]
- "services_walkthrough_service_maybestart": "maybeStart()" | kind=code-symbol | source=lib/services/walkthrough_service.dart:L60 | neighbors=[walkthrough_service.dart]
- "services_walkthrough_service_seedexamplecourse": "seedExampleCourse()" | kind=code-symbol | source=lib/services/walkthrough_service.dart:L90 | neighbors=[walkthrough_service.dart]
- "services_walkthrough_service_walkthroughservice": "WalkthroughService" | kind=code-symbol | source=lib/services/walkthrough_service.dart:L33 | neighbors=[walkthrough_service.dart]
- "slide_views_code_runner_view_build": "build()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L795 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_capture_plot": "_capture_plot()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L938 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_coderunnerhtml": "CodeRunnerHtml" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L792 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_coderunnerview": "CodeRunnerView" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L16 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_coderunnerviewstate": "_CodeRunnerViewState" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L30 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L68 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_initstate": "initState()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L60 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_insertkey": "_insertKey()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L75 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_latex": "_latex()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L1013 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_loadscript": "loadScript()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L891 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_python": "_python()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L862 | neighbors=[code_runner_view.dart]
- "slide_views_code_runner_view_render": "render()" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L1004 | neighbors=[code_runner_view.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-052.json

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
