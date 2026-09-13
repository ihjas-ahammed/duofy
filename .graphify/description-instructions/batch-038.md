# Node Description Batch 39 of 68

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

- "services_ai_service_module": "module" | kind=code-symbol | source=lib/services/ai_service.dart:L4117 | neighbors=[ai_service.dart]
- "services_ai_service_needsart": "needsArt()" | kind=code-symbol | source=lib/services/ai_service.dart:L1801 | neighbors=[ai_service.dart]
- "services_ai_service_outlines": "outlines" | kind=code-symbol | source=lib/services/ai_service.dart:L4290 | neighbors=[ai_service.dart]
- "services_ai_service_parselessoncount": "_parseLessonCount()" | kind=code-symbol | source=lib/services/ai_service.dart:L536 | neighbors=[ai_service.dart]
- "services_ai_service_pyqextractionresult": "PyqExtractionResult" | kind=code-symbol | source=lib/services/ai_service.dart:L4536 | neighbors=[ai_service.dart]
- "services_ai_service_regeneratelesson": "regenerateLesson()" | kind=code-symbol | source=lib/services/ai_service.dart:L2199 | neighbors=[ai_service.dart]
- "services_ai_service_regenerateslide": "regenerateSlide()" | kind=code-symbol | source=lib/services/ai_service.dart:L2304 | neighbors=[ai_service.dart]
- "services_ai_service_resolveconcurrency": "_resolveConcurrency()" | kind=code-symbol | source=lib/services/ai_service.dart:L1926 | neighbors=[ai_service.dart]
- "services_ai_service_sketch": "sketch()" | kind=code-symbol | source=lib/services/ai_service.dart:L2499 | neighbors=[ai_service.dart]
- "services_ai_service_switchbookdensityprofile": "switchBookDensityProfile()" | kind=code-symbol | source=lib/services/ai_service.dart:L4273 | neighbors=[ai_service.dart]
- "services_ai_service_title": "title" | kind=code-symbol | source=lib/services/ai_service.dart:L4432 | neighbors=[ai_service.dart]
- "services_ai_service_to": "to" | kind=code-symbol | source=lib/services/ai_service.dart:L986 | neighbors=[ai_service.dart]
- "services_ai_service_unitmanifestresult": "UnitManifestResult" | kind=code-symbol | source=lib/services/ai_service.dart:L4529 | neighbors=[ai_service.dart]
- "services_ai_service_updatecoursefromcustomindex": "updateCourseFromCustomIndex()" | kind=code-symbol | source=lib/services/ai_service.dart:L4311 | neighbors=[ai_service.dart]
- "services_ai_service_verifyfirstchunkmatch": "verifyFirstChunkMatch()" | kind=code-symbol | source=lib/services/ai_service.dart:L3987 | neighbors=[ai_service.dart]
- "services_ai_service_verifysectionmapping": "verifySectionMapping()" | kind=code-symbol | source=lib/services/ai_service.dart:L3930 | neighbors=[ai_service.dart]
- "services_ai_service_worker": "worker()" | kind=code-symbol | source=lib/services/ai_service.dart:L1362 | neighbors=[ai_service.dart]
- "services_auto_index_pipeline_autoindexpipeline": "AutoIndexPipeline" | kind=code-symbol | source=lib/services/auto_index_pipeline.dart:L21 | neighbors=[auto_index_pipeline.dart]
- "services_auto_index_pipeline_autoindexresult": "AutoIndexResult" | kind=code-symbol | source=lib/services/auto_index_pipeline.dart:L3 | neighbors=[auto_index_pipeline.dart]
- "services_auto_index_pipeline_chapter1fromlinks": "_chapter1FromLinks()" | kind=code-symbol | source=lib/services/auto_index_pipeline.dart:L125 | neighbors=[auto_index_pipeline.dart]
- "services_auto_index_pipeline_finish": "_finish()" | kind=code-symbol | source=lib/services/auto_index_pipeline.dart:L159 | neighbors=[auto_index_pipeline.dart]
- "services_auto_index_pipeline_function": "Function()" | kind=code-symbol | source=lib/services/auto_index_pipeline.dart:L12 | neighbors=[auto_index_pipeline.dart]
- "services_auto_index_pipeline_run": "run()" | kind=code-symbol | source=lib/services/auto_index_pipeline.dart:L47 | neighbors=[auto_index_pipeline.dart]
- "services_auto_index_pipeline_scanchapter1": "_scanChapter1()" | kind=code-symbol | source=lib/services/auto_index_pipeline.dart:L139 | neighbors=[auto_index_pipeline.dart]
- "services_auto_index_service_autoindexservice": "AutoIndexService" | kind=code-symbol | source=lib/services/auto_index_service.dart:L13 | neighbors=[auto_index_service.dart]
- "services_auto_index_service_collectbookmarks": "_collectBookmarks()" | kind=code-symbol | source=lib/services/auto_index_service.dart:L131 | neighbors=[auto_index_service.dart]
- "services_auto_index_service_findindexandchapter1": "findIndexAndChapter1()" | kind=code-symbol | source=lib/services/auto_index_service.dart:L19 | neighbors=[auto_index_service.dart]
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
