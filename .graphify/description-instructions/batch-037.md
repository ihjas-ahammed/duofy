# Node Description Batch 38 of 68

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

- "services_ai_estimator_estimatedurationsync": "estimateDurationSync()" | kind=code-symbol | source=lib/services/ai_estimator.dart:L53 | neighbors=[ai_estimator.dart]
- "services_ai_estimator_estimateunitdurationsync": "estimateUnitDurationSync()" | kind=code-symbol | source=lib/services/ai_estimator.dart:L60 | neighbors=[ai_estimator.dart]
- "services_ai_estimator_function": "Function()" | kind=code-symbol | source=lib/services/ai_estimator.dart:L28 | neighbors=[ai_estimator.dart]
- "services_ai_estimator_init": "init()" | kind=code-symbol | source=lib/services/ai_estimator.dart:L32 | neighbors=[ai_estimator.dart]
- "services_ai_estimator_recordrequest": "recordRequest()" | kind=code-symbol | source=lib/services/ai_estimator.dart:L81 | neighbors=[ai_estimator.dart]
- "services_ai_service_aiservice": "AiService" | kind=code-symbol | source=lib/services/ai_service.dart:L23 | neighbors=[ai_service.dart]
- "services_ai_service_analyzeandextractpyqquestions": "analyzeAndExtractPyqQuestions()" | kind=code-symbol | source=lib/services/ai_service.dart:L4417 | neighbors=[ai_service.dart]
- "services_ai_service_attacharttolesson": "_attachArtToLesson()" | kind=code-symbol | source=lib/services/ai_service.dart:L2705 | neighbors=[ai_service.dart]
- "services_ai_service_buildneighborcontext": "_buildNeighborContext()" | kind=code-symbol | source=lib/services/ai_service.dart:L1885 | neighbors=[ai_service.dart]
- "services_ai_service_buildpreviousunitscontent": "_buildPreviousUnitsContent()" | kind=code-symbol | source=lib/services/ai_service.dart:L1906 | neighbors=[ai_service.dart]
- "services_ai_service_callcerebras": "_callCerebras()" | kind=code-symbol | source=lib/services/ai_service.dart:L172 | neighbors=[ai_service.dart]
- "services_ai_service_callgroq": "_callGroq()" | kind=code-symbol | source=lib/services/ai_service.dart:L68 | neighbors=[ai_service.dart]
- "services_ai_service_callopenrouter": "_callOpenRouter()" | kind=code-symbol | source=lib/services/ai_service.dart:L276 | neighbors=[ai_service.dart]
- "services_ai_service_checkpause": "_checkPause()" | kind=code-symbol | source=lib/services/ai_service.dart:L31 | neighbors=[ai_service.dart]
- "services_ai_service_classifyerror": "_classifyError()" | kind=code-symbol | source=lib/services/ai_service.dart:L593 | neighbors=[ai_service.dart]
- "services_ai_service_cleanerrmsg": "_cleanErrMsg()" | kind=code-symbol | source=lib/services/ai_service.dart:L631 | neighbors=[ai_service.dart]
- "services_ai_service_cleanjsontext": "_cleanJsonText()" | kind=code-symbol | source=lib/services/ai_service.dart:L4410 | neighbors=[ai_service.dart]
- "services_ai_service_draw": "draw()" | kind=code-symbol | source=lib/services/ai_service.dart:L2498 | neighbors=[ai_service.dart]
- "services_ai_service_empty": "empty()" | kind=code-symbol | source=lib/services/ai_service.dart:L1802 | neighbors=[ai_service.dart]
- "services_ai_service_explainquickreviewstatement": "explainQuickReviewStatement()" | kind=code-symbol | source=lib/services/ai_service.dart:L4224 | neighbors=[ai_service.dart]
- "services_ai_service_findreusablecanvasart": "findReusableCanvasArt()" | kind=code-symbol | source=lib/services/ai_service.dart:L2544 | neighbors=[ai_service.dart]
- "services_ai_service_function": "Function()" | kind=code-symbol | source=lib/services/ai_service.dart:L694 | neighbors=[ai_service.dart]
- "services_ai_service_generatebookskeleton": "generateBookSkeleton()" | kind=code-symbol | source=lib/services/ai_service.dart:L933 | neighbors=[ai_service.dart]
- "services_ai_service_generatecanvasart": "generateCanvasArt()" | kind=code-symbol | source=lib/services/ai_service.dart:L2421 | neighbors=[ai_service.dart]
- "services_ai_service_generatecontentwithtiming": "_generateContentWithTiming()" | kind=code-symbol | source=lib/services/ai_service.dart:L3422 | neighbors=[ai_service.dart]
- "services_ai_service_generatecustomlessonslide": "generateCustomLessonSlide()" | kind=code-symbol | source=lib/services/ai_service.dart:L3246 | neighbors=[ai_service.dart]
- "services_ai_service_generateonelesson": "_generateOneLesson()" | kind=code-symbol | source=lib/services/ai_service.dart:L1947 | neighbors=[ai_service.dart]
- "services_ai_service_generatequestionpaper": "generateQuestionPaper()" | kind=code-symbol | source=lib/services/ai_service.dart:L2944 | neighbors=[ai_service.dart]
- "services_ai_service_generatesimpletext": "generateSimpleText()" | kind=code-symbol | source=lib/services/ai_service.dart:L460 | neighbors=[ai_service.dart]
- "services_ai_service_generateunitcontent": "generateUnitContent()" | kind=code-symbol | source=lib/services/ai_service.dart:L1583 | neighbors=[ai_service.dart]
- "services_ai_service_generateunitmanifest": "generateUnitManifest()" | kind=code-symbol | source=lib/services/ai_service.dart:L2813 | neighbors=[ai_service.dart]
- "services_ai_service_generatewithgroqfallback": "_generateWithGroqFallback()" | kind=code-symbol | source=lib/services/ai_service.dart:L3312 | neighbors=[ai_service.dart]
- "services_ai_service_getapikey": "getApiKey()" | kind=code-symbol | source=lib/services/ai_service.dart:L453 | neighbors=[ai_service.dart]
- "services_ai_service_getlivemodelname": "getLiveModelName()" | kind=code-symbol | source=lib/services/ai_service.dart:L443 | neighbors=[ai_service.dart]
- "services_ai_service_getprimarytextmodelname": "getPrimaryTextModelName()" | kind=code-symbol | source=lib/services/ai_service.dart:L448 | neighbors=[ai_service.dart]
- "services_ai_service_getsuggestedshift": "getSuggestedShift()" | kind=code-symbol | source=lib/services/ai_service.dart:L650 | neighbors=[ai_service.dart]
- "services_ai_service_in": "in" | kind=code-symbol | source=lib/services/ai_service.dart:L2552 | neighbors=[ai_service.dart]
- "services_ai_service_isratelimiterror": "_isRateLimitError()" | kind=code-symbol | source=lib/services/ai_service.dart:L383 | neighbors=[ai_service.dart]
- "services_ai_service_istransient": "_isTransient()" | kind=code-symbol | source=lib/services/ai_service.dart:L563 | neighbors=[ai_service.dart]
- "services_ai_service_matchsyllabusbooktomarketplace": "matchSyllabusBookToMarketplace()" | kind=code-symbol | source=lib/services/ai_service.dart:L4042 | neighbors=[ai_service.dart]

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
