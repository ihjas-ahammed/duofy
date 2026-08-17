# Node Description Batch 36 of 61

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

- "screens_summary_screen_searchvideosforsection": "_searchVideosForSection()" | kind=code-symbol | source=lib/screens/summary_screen.dart:L206 | neighbors=[summary_screen.dart]
- "screens_summary_screen_searchvideosforunit": "_searchVideosForUnit()" | kind=code-symbol | source=lib/screens/summary_screen.dart:L171 | neighbors=[summary_screen.dart]
- "screens_summary_screen_sortvideosbypriority": "_sortVideosByPriority()" | kind=code-symbol | source=lib/screens/summary_screen.dart:L237 | neighbors=[summary_screen.dart]
- "screens_summary_screen_summaryscreen": "SummaryScreen" | kind=code-symbol | source=lib/screens/summary_screen.dart:L31 | neighbors=[summary_screen.dart]
- "screens_summary_screen_summaryscreenstate": "_SummaryScreenState" | kind=code-symbol | source=lib/screens/summary_screen.dart:L47 | neighbors=[summary_screen.dart]
- "screens_summary_screen_updateactivesection": "_updateActiveSection()" | kind=code-symbol | source=lib/screens/summary_screen.dart:L103 | neighbors=[summary_screen.dart]
- "screens_summary_screen_youtubevideo": "YoutubeVideo" | kind=code-symbol | source=lib/screens/summary_screen.dart:L11 | neighbors=[summary_screen.dart]
- "selectors_module_selector_modulerow": "_ModuleRow" | kind=code-symbol | source=lib/widgets/selectors/module_selector.dart:L177 | neighbors=[module_selector.dart]
- "selectors_module_selector_moduleselectorsheet": "ModuleSelectorSheet" | kind=code-symbol | source=lib/widgets/selectors/module_selector.dart:L11 | neighbors=[module_selector.dart]
- "selectors_module_selector_show": "show()" | kind=code-symbol | source=lib/widgets/selectors/module_selector.dart:L27 | neighbors=[module_selector.dart]
- "selectors_section_selector_sectionselector": "SectionSelector" | kind=code-symbol | source=lib/widgets/selectors/section_selector.dart:L5 | neighbors=[section_selector.dart]
- "services_ai_estimator_activerequestinfo": "ActiveRequestInfo" | kind=code-symbol | source=lib/services/ai_estimator.dart:L3 | neighbors=[ai_estimator.dart]
- "services_ai_estimator_aiestimator": "AiEstimator" | kind=code-symbol | source=lib/services/ai_estimator.dart:L15 | neighbors=[ai_estimator.dart]
- "services_ai_estimator_estimatedurationsync": "estimateDurationSync()" | kind=code-symbol | source=lib/services/ai_estimator.dart:L53 | neighbors=[ai_estimator.dart]
- "services_ai_estimator_estimateunitdurationsync": "estimateUnitDurationSync()" | kind=code-symbol | source=lib/services/ai_estimator.dart:L60 | neighbors=[ai_estimator.dart]
- "services_ai_estimator_function": "Function()" | kind=code-symbol | source=lib/services/ai_estimator.dart:L28 | neighbors=[ai_estimator.dart]
- "services_ai_estimator_init": "init()" | kind=code-symbol | source=lib/services/ai_estimator.dart:L32 | neighbors=[ai_estimator.dart]
- "services_ai_estimator_recordrequest": "recordRequest()" | kind=code-symbol | source=lib/services/ai_estimator.dart:L81 | neighbors=[ai_estimator.dart]
- "services_ai_service_aiservice": "AiService" | kind=code-symbol | source=lib/services/ai_service.dart:L23 | neighbors=[ai_service.dart]
- "services_ai_service_analyzeandextractpyqquestions": "analyzeAndExtractPyqQuestions()" | kind=code-symbol | source=lib/services/ai_service.dart:L4346 | neighbors=[ai_service.dart]
- "services_ai_service_attacharttolesson": "_attachArtToLesson()" | kind=code-symbol | source=lib/services/ai_service.dart:L2705 | neighbors=[ai_service.dart]
- "services_ai_service_buildneighborcontext": "_buildNeighborContext()" | kind=code-symbol | source=lib/services/ai_service.dart:L1885 | neighbors=[ai_service.dart]
- "services_ai_service_buildpreviousunitscontent": "_buildPreviousUnitsContent()" | kind=code-symbol | source=lib/services/ai_service.dart:L1906 | neighbors=[ai_service.dart]
- "services_ai_service_callcerebras": "_callCerebras()" | kind=code-symbol | source=lib/services/ai_service.dart:L172 | neighbors=[ai_service.dart]
- "services_ai_service_callgroq": "_callGroq()" | kind=code-symbol | source=lib/services/ai_service.dart:L68 | neighbors=[ai_service.dart]
- "services_ai_service_callopenrouter": "_callOpenRouter()" | kind=code-symbol | source=lib/services/ai_service.dart:L276 | neighbors=[ai_service.dart]
- "services_ai_service_checkpause": "_checkPause()" | kind=code-symbol | source=lib/services/ai_service.dart:L31 | neighbors=[ai_service.dart]
- "services_ai_service_classifyerror": "_classifyError()" | kind=code-symbol | source=lib/services/ai_service.dart:L593 | neighbors=[ai_service.dart]
- "services_ai_service_cleanerrmsg": "_cleanErrMsg()" | kind=code-symbol | source=lib/services/ai_service.dart:L631 | neighbors=[ai_service.dart]
- "services_ai_service_cleanjsontext": "_cleanJsonText()" | kind=code-symbol | source=lib/services/ai_service.dart:L4339 | neighbors=[ai_service.dart]
- "services_ai_service_draw": "draw()" | kind=code-symbol | source=lib/services/ai_service.dart:L2498 | neighbors=[ai_service.dart]
- "services_ai_service_empty": "empty()" | kind=code-symbol | source=lib/services/ai_service.dart:L1802 | neighbors=[ai_service.dart]
- "services_ai_service_explainquickreviewstatement": "explainQuickReviewStatement()" | kind=code-symbol | source=lib/services/ai_service.dart:L4153 | neighbors=[ai_service.dart]
- "services_ai_service_findreusablecanvasart": "findReusableCanvasArt()" | kind=code-symbol | source=lib/services/ai_service.dart:L2544 | neighbors=[ai_service.dart]
- "services_ai_service_function": "Function()" | kind=code-symbol | source=lib/services/ai_service.dart:L694 | neighbors=[ai_service.dart]
- "services_ai_service_generatebookskeleton": "generateBookSkeleton()" | kind=code-symbol | source=lib/services/ai_service.dart:L933 | neighbors=[ai_service.dart]
- "services_ai_service_generatecanvasart": "generateCanvasArt()" | kind=code-symbol | source=lib/services/ai_service.dart:L2421 | neighbors=[ai_service.dart]
- "services_ai_service_generatecontentwithtiming": "_generateContentWithTiming()" | kind=code-symbol | source=lib/services/ai_service.dart:L3422 | neighbors=[ai_service.dart]
- "services_ai_service_generatecustomlessonslide": "generateCustomLessonSlide()" | kind=code-symbol | source=lib/services/ai_service.dart:L3246 | neighbors=[ai_service.dart]
- "services_ai_service_generateonelesson": "_generateOneLesson()" | kind=code-symbol | source=lib/services/ai_service.dart:L1947 | neighbors=[ai_service.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-035.json

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
