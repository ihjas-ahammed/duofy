# Node Description Batch 46 of 61

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

- "services_prompt_service_getpyqgradingprompt": "getPyqGradingPrompt()" | kind=code-symbol | source=lib/services/prompt_service.dart:L1216 | neighbors=[prompt_service.dart]
- "services_prompt_service_greet": "greet()" | kind=code-symbol | source=lib/services/prompt_service.dart:L200 | neighbors=[prompt_service.dart]
- "services_prompt_service_instructionsblock": "instructionsBlock()" | kind=code-symbol | source=lib/services/prompt_service.dart:L16 | neighbors=[prompt_service.dart]
- "services_prompt_service_numbered": "_numbered()" | kind=code-symbol | source=lib/services/prompt_service.dart:L125 | neighbors=[prompt_service.dart]
- "services_prompt_service_ondown": "onDown()" | kind=code-symbol | source=lib/services/prompt_service.dart:L917 | neighbors=[prompt_service.dart]
- "services_prompt_service_onmove": "onMove()" | kind=code-symbol | source=lib/services/prompt_service.dart:L922 | neighbors=[prompt_service.dart]
- "services_prompt_service_onup": "onUp()" | kind=code-symbol | source=lib/services/prompt_service.dart:L928 | neighbors=[prompt_service.dart]
- "services_prompt_service_plannerchoicesblock": "plannerChoicesBlock()" | kind=code-symbol | source=lib/services/prompt_service.dart:L27 | neighbors=[prompt_service.dart]
- "services_prompt_service_promptservice": "PromptService" | kind=code-symbol | source=lib/services/prompt_service.dart:L12 | neighbors=[prompt_service.dart]
- "services_prompt_service_render": "render()" | kind=code-symbol | source=lib/services/prompt_service.dart:L119 | neighbors=[prompt_service.dart]
- "services_prompt_service_sketch": "sketch()" | kind=code-symbol | source=lib/services/prompt_service.dart:L837 | neighbors=[prompt_service.dart]
- "services_prompt_service_title": "title" | kind=code-symbol | source=lib/services/prompt_service.dart:L328 | neighbors=[prompt_service.dart]
- "services_pyq_exam_service_addlistener": "addListener()" | kind=code-symbol | source=lib/services/pyq_exam_service.dart:L335 | neighbors=[pyq_exam_service.dart]
- "services_pyq_exam_service_addpyqitems": "addPyqItems()" | kind=code-symbol | source=lib/services/pyq_exam_service.dart:L67 | neighbors=[pyq_exam_service.dart]
- "services_pyq_exam_service_bankkey": "_bankKey()" | kind=code-symbol | source=lib/services/pyq_exam_service.dart:L13 | neighbors=[pyq_exam_service.dart]
- "services_pyq_exam_service_evaluateexampaper": "evaluateExamPaper()" | kind=code-symbol | source=lib/services/pyq_exam_service.dart:L108 | neighbors=[pyq_exam_service.dart]
- "services_pyq_exam_service_function": "Function()" | kind=code-symbol | source=lib/services/pyq_exam_service.dart:L322 | neighbors=[pyq_exam_service.dart]
- "services_pyq_exam_service_historykey": "_historyKey()" | kind=code-symbol | source=lib/services/pyq_exam_service.dart:L14 | neighbors=[pyq_exam_service.dart]
- "services_pyq_exam_service_notify": "notify()" | kind=code-symbol | source=lib/services/pyq_exam_service.dart:L343 | neighbors=[pyq_exam_service.dart]
- "services_pyq_exam_service_pyqanalysisjob": "PyqAnalysisJob" | kind=code-symbol | source=lib/services/pyq_exam_service.dart:L313 | neighbors=[pyq_exam_service.dart]
- "services_pyq_exam_service_pyqexamservice": "PyqExamService" | kind=code-symbol | source=lib/services/pyq_exam_service.dart:L9 | neighbors=[pyq_exam_service.dart]
- "services_pyq_exam_service_removelistener": "removeListener()" | kind=code-symbol | source=lib/services/pyq_exam_service.dart:L339 | neighbors=[pyq_exam_service.dart]
- "services_pyq_exam_service_saveexamattempt": "saveExamAttempt()" | kind=code-symbol | source=lib/services/pyq_exam_service.dart:L98 | neighbors=[pyq_exam_service.dart]
- "services_pyq_exam_service_savepyqbank": "savePyqBank()" | kind=code-symbol | source=lib/services/pyq_exam_service.dart:L60 | neighbors=[pyq_exam_service.dart]
- "services_pyq_exam_service_startbackgroundanalysis": "startBackgroundAnalysis()" | kind=code-symbol | source=lib/services/pyq_exam_service.dart:L231 | neighbors=[pyq_exam_service.dart]
- "services_python_runner_service_bar": "bar()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L155 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_capture_plt": "_capture_plt()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L105 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_checkandsyncpythonassets": "_checkAndSyncPythonAssets()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L314 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_clf": "clf()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L176 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_close": "close()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L182 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_dummy_fn": "_dummy_fn()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L121 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_figure": "figure()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L173 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_function": "Function()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L339 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_get_fignums": "get_fignums()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L185 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_grid": "grid()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L167 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_init": "__init__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L126 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_installpackage": "installPackage()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L163 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_interactive_input": "_interactive_input()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L67 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_legend": "legend()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L170 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_map_x": "map_x()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L213 | neighbors=[python_runner_service.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-045.json

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
