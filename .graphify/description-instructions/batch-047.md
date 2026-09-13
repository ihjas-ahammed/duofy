# Node Description Batch 48 of 68

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

- "services_prompt_service_draw": "draw()" | kind=code-symbol | source=lib/services/prompt_service.dart:L838 | neighbors=[prompt_service.dart]
- "services_prompt_service_frame": "frame()" | kind=code-symbol | source=lib/services/prompt_service.dart:L940 | neighbors=[prompt_service.dart]
- "services_prompt_service_getmultisectionpyqextractionprompt": "getMultiSectionPyqExtractionPrompt()" | kind=code-symbol | source=lib/services/prompt_service.dart:L1044 | neighbors=[prompt_service.dart]
- "services_prompt_service_getpyqextractionprompt": "getPyqExtractionPrompt()" | kind=code-symbol | source=lib/services/prompt_service.dart:L1119 | neighbors=[prompt_service.dart]
- "services_prompt_service_getpyqgradingprompt": "getPyqGradingPrompt()" | kind=code-symbol | source=lib/services/prompt_service.dart:L1220 | neighbors=[prompt_service.dart]
- "services_prompt_service_greet": "greet()" | kind=code-symbol | source=lib/services/prompt_service.dart:L202 | neighbors=[prompt_service.dart]
- "services_prompt_service_instructionsblock": "instructionsBlock()" | kind=code-symbol | source=lib/services/prompt_service.dart:L16 | neighbors=[prompt_service.dart]
- "services_prompt_service_numbered": "_numbered()" | kind=code-symbol | source=lib/services/prompt_service.dart:L125 | neighbors=[prompt_service.dart]
- "services_prompt_service_ondown": "onDown()" | kind=code-symbol | source=lib/services/prompt_service.dart:L924 | neighbors=[prompt_service.dart]
- "services_prompt_service_onmove": "onMove()" | kind=code-symbol | source=lib/services/prompt_service.dart:L929 | neighbors=[prompt_service.dart]
- "services_prompt_service_onup": "onUp()" | kind=code-symbol | source=lib/services/prompt_service.dart:L935 | neighbors=[prompt_service.dart]
- "services_prompt_service_plannerchoicesblock": "plannerChoicesBlock()" | kind=code-symbol | source=lib/services/prompt_service.dart:L27 | neighbors=[prompt_service.dart]
- "services_prompt_service_promptservice": "PromptService" | kind=code-symbol | source=lib/services/prompt_service.dart:L12 | neighbors=[prompt_service.dart]
- "services_prompt_service_render": "render()" | kind=code-symbol | source=lib/services/prompt_service.dart:L119 | neighbors=[prompt_service.dart]
- "services_prompt_service_sketch": "sketch()" | kind=code-symbol | source=lib/services/prompt_service.dart:L839 | neighbors=[prompt_service.dart]
- "services_prompt_service_title": "title" | kind=code-symbol | source=lib/services/prompt_service.dart:L330 | neighbors=[prompt_service.dart]
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
- "services_python_runner_service_abs": "__abs__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L205 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_absolute": "absolute()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L324 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_accuracy_score": "accuracy_score()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L871 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_add": "__add__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L194 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_apply_ufunc": "_apply_ufunc()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L218 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_arange": "arange()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L289 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_array": "array()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L280 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_bar": "bar()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L418 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_barplot": "barplot()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L658 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_boxplot": "boxplot()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L675 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_bunch": "_Bunch" | kind=code-symbol | source=lib/services/python_runner_service.dart:L708 | neighbors=[python_runner_service.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-047.json

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
