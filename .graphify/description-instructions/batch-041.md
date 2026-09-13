# Node Description Batch 42 of 68

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

- "services_generation_manager_generatecanvasarttask": "generateCanvasArtTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L805 | neighbors=[generation_manager.dart]
- "services_generation_manager_generationmanager": "GenerationManager" | kind=code-symbol | source=lib/services/generation_manager.dart:L80 | neighbors=[generation_manager.dart]
- "services_generation_manager_generationtask": "GenerationTask" | kind=code-symbol | source=lib/services/generation_manager.dart:L24 | neighbors=[generation_manager.dart]
- "services_generation_manager_getaverageruntime": "_getAverageRunTime()" | kind=code-symbol | source=lib/services/generation_manager.dart:L141 | neighbors=[generation_manager.dart]
- "services_generation_manager_isduplicate": "isDuplicate()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2805 | neighbors=[generation_manager.dart]
- "services_generation_manager_loadqueuefromprefs": "_loadQueueFromPrefs()" | kind=code-symbol | source=lib/services/generation_manager.dart:L205 | neighbors=[generation_manager.dart]
- "services_generation_manager_notifytaskfailure": "_notifyTaskFailure()" | kind=code-symbol | source=lib/services/generation_manager.dart:L171 | neighbors=[generation_manager.dart]
- "services_generation_manager_onlessongenerated": "onLessonGenerated()" | kind=code-symbol | source=lib/services/generation_manager.dart:L1088 | neighbors=[generation_manager.dart]
- "services_generation_manager_onstatus": "onStatus()" | kind=code-symbol | source=lib/services/generation_manager.dart:L1941 | neighbors=[generation_manager.dart]
- "services_generation_manager_pauseallothertasks": "_pauseAllOtherTasks()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2850 | neighbors=[generation_manager.dart]
- "services_generation_manager_processqueue": "_processQueue()" | kind=code-symbol | source=lib/services/generation_manager.dart:L337 | neighbors=[generation_manager.dart]
- "services_generation_manager_qpgentask": "QpGenTask" | kind=code-symbol | source=lib/services/generation_manager.dart:L73 | neighbors=[generation_manager.dart]
- "services_generation_manager_recordruntime": "_recordRunTime()" | kind=code-symbol | source=lib/services/generation_manager.dart:L133 | neighbors=[generation_manager.dart]
- "services_generation_manager_regeneratelesson": "regenerateLesson()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2554 | neighbors=[generation_manager.dart]
- "services_generation_manager_regeneratelessoncanvas": "regenerateLessonCanvas()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2409 | neighbors=[generation_manager.dart]
- "services_generation_manager_regenerateslide": "regenerateSlide()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2599 | neighbors=[generation_manager.dart]
- "services_generation_manager_regenerateslidecanvas": "regenerateSlideCanvas()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2452 | neighbors=[generation_manager.dart]
- "services_generation_manager_regenerateslidetask": "regenerateSlideTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L829 | neighbors=[generation_manager.dart]
- "services_generation_manager_registeractiverequest": "registerActiveRequest()" | kind=code-symbol | source=lib/services/generation_manager.dart:L234 | neighbors=[generation_manager.dart]
- "services_generation_manager_repairpagealignment": "repairPageAlignment()" | kind=code-symbol | source=lib/services/generation_manager.dart:L3039 | neighbors=[generation_manager.dart]
- "services_generation_manager_resolveconcurrency": "_resolveConcurrency()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2943 | neighbors=[generation_manager.dart]
- "services_generation_manager_restorebookfiles": "restoreBookFiles()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2165 | neighbors=[generation_manager.dart]
- "services_generation_manager_resumeallpausedtasks": "_resumeAllPausedTasks()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2881 | neighbors=[generation_manager.dart]
- "services_generation_manager_runbookcontentgenerationfortask": "_runBookContentGenerationForTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L1388 | neighbors=[generation_manager.dart]
- "services_generation_manager_runbookskeletonfortask": "_runBookSkeletonForTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L870 | neighbors=[generation_manager.dart]
- "services_generation_manager_runcanvasregenfortask": "_runCanvasRegenForTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L994 | neighbors=[generation_manager.dart]
- "services_generation_manager_runcustomlessongenfortask": "_runCustomLessonGenForTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L1716 | neighbors=[generation_manager.dart]
- "services_generation_manager_runlessonregenfortask": "_runLessonRegenForTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L1644 | neighbors=[generation_manager.dart]
- "services_generation_manager_runmanifestgenerationfortask": "_runManifestGenerationForTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L1176 | neighbors=[generation_manager.dart]
- "services_generation_manager_runmodulegenerationfortask": "_runModuleGenerationForTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L1363 | neighbors=[generation_manager.dart]
- "services_generation_manager_runpyqgenerationfortask": "_runPyqGenerationForTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L1462 | neighbors=[generation_manager.dart]
- "services_generation_manager_runqpgenerationfortask": "_runQpGenerationForTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L1410 | neighbors=[generation_manager.dart]
- "services_generation_manager_runsectiongenerationfortask": "_runSectionGenerationForTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L1286 | neighbors=[generation_manager.dart]
- "services_generation_manager_runslideregenfortask": "_runSlideRegenForTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L1009 | neighbors=[generation_manager.dart]
- "services_generation_manager_runtasknow": "runTaskNow()" | kind=code-symbol | source=lib/services/generation_manager.dart:L153 | neighbors=[generation_manager.dart]
- "services_generation_manager_rununitgenerationfortask": "_runUnitGenerationForTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L1031 | neighbors=[generation_manager.dart]
- "services_generation_manager_savequeuetoprefs": "_saveQueueToPrefs()" | kind=code-symbol | source=lib/services/generation_manager.dart:L195 | neighbors=[generation_manager.dart]
- "services_generation_manager_saveslideedit": "saveSlideEdit()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2500 | neighbors=[generation_manager.dart]
- "services_generation_manager_selectapikeyfortask": "_selectApiKeyForTask()" | kind=code-symbol | source=lib/services/generation_manager.dart:L497 | neighbors=[generation_manager.dart]
- "services_generation_manager_startbackgroundsplitandsave": "startBackgroundSplitAndSave()" | kind=code-symbol | source=lib/services/generation_manager.dart:L2041 | neighbors=[generation_manager.dart]

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
