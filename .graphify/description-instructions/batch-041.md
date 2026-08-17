# Node Description Batch 42 of 61

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

- "services_guest_service_getguestidshort": "getGuestIdShort()" | kind=code-symbol | source=lib/services/guest_service.dart:L54 | neighbors=[guest_service.dart]
- "services_guest_service_guestservice": "GuestService" | kind=code-symbol | source=lib/services/guest_service.dart:L8 | neighbors=[guest_service.dart]
- "services_guest_service_isguestid": "isGuestId()" | kind=code-symbol | source=lib/services/guest_service.dart:L64 | neighbors=[guest_service.dart]
- "services_guest_service_resetguestsession": "resetGuestSession()" | kind=code-symbol | source=lib/services/guest_service.dart:L71 | neighbors=[guest_service.dart]
- "services_ide_settings_service_idesettings": "IdeSettings" | kind=code-symbol | source=lib/services/ide_settings_service.dart:L4 | neighbors=[ide_settings_service.dart]
- "services_ide_settings_service_idesettingsservice": "IdeSettingsService" | kind=code-symbol | source=lib/services/ide_settings_service.dart:L32 | neighbors=[ide_settings_service.dart]
- "services_ide_settings_service_loadsettings": "loadSettings()" | kind=code-symbol | source=lib/services/ide_settings_service.dart:L47 | neighbors=[ide_settings_service.dart]
- "services_ide_settings_service_updatesettings": "updateSettings()" | kind=code-symbol | source=lib/services/ide_settings_service.dart:L70 | neighbors=[ide_settings_service.dart]
- "services_learning_sync_learningsync": "LearningSync" | kind=code-symbol | source=lib/services/learning_sync.dart:L17 | neighbors=[learning_sync.dart]
- "services_learning_sync_maxint": "_maxInt()" | kind=code-symbol | source=lib/services/learning_sync.dart:L243 | neighbors=[learning_sync.dart]
- "services_learning_sync_migratelegacykeys": "migrateLegacyKeys()" | kind=code-symbol | source=lib/services/learning_sync.dart:L191 | neighbors=[learning_sync.dart]
- "services_learning_sync_minint": "_minInt()" | kind=code-symbol | source=lib/services/learning_sync.dart:L235 | neighbors=[learning_sync.dart]
- "services_learning_sync_pullandmerge": "pullAndMerge()" | kind=code-symbol | source=lib/services/learning_sync.dart:L75 | neighbors=[learning_sync.dart]
- "services_learning_sync_push": "push()" | kind=code-symbol | source=lib/services/learning_sync.dart:L33 | neighbors=[learning_sync.dart]
- "services_loading_progress_controller_loadingprogresscontroller": "LoadingProgressController" | kind=code-symbol | source=lib/services/loading_progress_controller.dart:L33 | neighbors=[loading_progress_controller.dart]
- "services_loading_progress_controller_loadingstep": "LoadingStep" | kind=code-symbol | source=lib/services/loading_progress_controller.dart:L3 | neighbors=[loading_progress_controller.dart]
- "services_loading_progress_controller_startloading": "startLoading()" | kind=code-symbol | source=lib/services/loading_progress_controller.dart:L39 | neighbors=[loading_progress_controller.dart]
- "services_loading_progress_controller_stoploading": "stopLoading()" | kind=code-symbol | source=lib/services/loading_progress_controller.dart:L56 | neighbors=[loading_progress_controller.dart]
- "services_loading_progress_controller_updatestep": "updateStep()" | kind=code-symbol | source=lib/services/loading_progress_controller.dart:L47 | neighbors=[loading_progress_controller.dart]
- "services_mapping_verifier_describe": "describe()" | kind=code-symbol | source=lib/services/mapping_verifier.dart:L40 | neighbors=[mapping_verifier.dart]
- "services_mapping_verifier_detectshift": "_detectShift()" | kind=code-symbol | source=lib/services/mapping_verifier.dart:L259 | neighbors=[mapping_verifier.dart]
- "services_mapping_verifier_function": "Function()" | kind=code-symbol | source=lib/services/mapping_verifier.dart:L80 | neighbors=[mapping_verifier.dart]
- "services_mapping_verifier_mappingreport": "MappingReport" | kind=code-symbol | source=lib/services/mapping_verifier.dart:L11 | neighbors=[mapping_verifier.dart]
- "services_mapping_verifier_mappingverifier": "MappingVerifier" | kind=code-symbol | source=lib/services/mapping_verifier.dart:L57 | neighbors=[mapping_verifier.dart]
- "services_mapping_verifier_matches": "_matches()" | kind=code-symbol | source=lib/services/mapping_verifier.dart:L249 | neighbors=[mapping_verifier.dart]
- "services_mapping_verifier_verify": "verify()" | kind=code-symbol | source=lib/services/mapping_verifier.dart:L76 | neighbors=[mapping_verifier.dart]
- "services_mapping_verifier_verifypostcreatefirstchunk": "verifyPostCreateFirstChunk()" | kind=code-symbol | source=lib/services/mapping_verifier.dart:L303 | neighbors=[mapping_verifier.dart]
- "services_math_evaluator_service_call": "call()" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L215 | neighbors=[math_evaluator_service.dart]
- "services_math_evaluator_service_callfunction": "_callFunction()" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L246 | neighbors=[math_evaluator_service.dart]
- "services_math_evaluator_service_combination": "_combination()" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L349 | neighbors=[math_evaluator_service.dart]
- "services_math_evaluator_service_consume": "_consume()" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L46 | neighbors=[math_evaluator_service.dart]
- "services_math_evaluator_service_factorial": "_factorial()" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L328 | neighbors=[math_evaluator_service.dart]
- "services_math_evaluator_service_isdigit": "_isDigit()" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L324 | neighbors=[math_evaluator_service.dart]
- "services_math_evaluator_service_isletter": "_isLetter()" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L325 | neighbors=[math_evaluator_service.dart]
- "services_math_evaluator_service_mathevaluatorservice": "MathEvaluatorService" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L7 | neighbors=[math_evaluator_service.dart]
- "services_math_evaluator_service_mathparser": "_MathParser" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L40 | neighbors=[math_evaluator_service.dart]
- "services_math_evaluator_service_parse": "parse()" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L61 | neighbors=[math_evaluator_service.dart]
- "services_math_evaluator_service_parseexpression": "_parseExpression()" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L71 | neighbors=[math_evaluator_service.dart]
- "services_math_evaluator_service_parsefactor": "_parseFactor()" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L122 | neighbors=[math_evaluator_service.dart]
- "services_math_evaluator_service_parseidentifierorfunction": "_parseIdentifierOrFunction()" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L207 | neighbors=[math_evaluator_service.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-041.json

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
