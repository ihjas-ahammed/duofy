# Node Description Batch 50 of 68

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

- "services_python_runner_service_linearregression": "_LinearRegression" | kind=code-symbol | source=lib/services/python_runner_service.dart:L783 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_lineplot": "lineplot()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L652 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_linspace": "linspace()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L283 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_load_dataset": "load_dataset()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L686 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_load_digits": "load_digits()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L754 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_load_iris": "load_iris()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L742 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_log": "log()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L319 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_log10": "log10()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L320 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_log2": "log2()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L321 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_logisticregression": "_LogisticRegression" | kind=code-symbol | source=lib/services/python_runner_service.dart:L813 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_make_blobs": "make_blobs()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L722 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_make_classification": "make_classification()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L735 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_make_regression": "make_regression()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L715 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_map_x": "map_x()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L488 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_map_y": "map_y()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L491 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_max": "max()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L157 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_mean": "mean()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L147 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_mean_squared_error": "mean_squared_error()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L876 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_min": "min()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L154 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_minmaxscaler": "_MinMaxScaler" | kind=code-symbol | source=lib/services/python_runner_service.dart:L857 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_mul": "__mul__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L198 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_ndim": "ndim()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L127 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_neg": "__neg__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L204 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_norm": "norm()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L262 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_numpyarray": "_NumpyArray" | kind=code-symbol | source=lib/services/python_runner_service.dart:L112 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_numpylinalgstub": "_NumpyLinalgStub" | kind=code-symbol | source=lib/services/python_runner_service.dart:L261 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_numpymodulestub": "_NumpyModuleStub" | kind=code-symbol | source=lib/services/python_runner_service.dart:L266 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_numpyrandomstub": "_NumpyRandomStub" | kind=code-symbol | source=lib/services/python_runner_service.dart:L226 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_ones": "ones()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L307 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_pairplot": "pairplot()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L684 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_pandasmodulestub": "_PandasModuleStub" | kind=code-symbol | source=lib/services/python_runner_service.dart:L611 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_plot": "plot()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L393 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_pow": "__pow__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L202 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_predict": "predict()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L801 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_predict_proba": "predict_proba()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L821 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_preparewrappercode": "_prepareWrapperCode()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L37 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_pyplotstub": "_PyplotStub" | kind=code-symbol | source=lib/services/python_runner_service.dart:L384 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_pythonexecutionresult": "PythonExecutionResult" | kind=code-symbol | source=lib/services/python_runner_service.dart:L11 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_pythonrunnerservice": "PythonRunnerService" | kind=code-symbol | source=lib/services/python_runner_service.dart:L30 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_r2_score": "r2_score()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L883 | neighbors=[python_runner_service.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-049.json

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
