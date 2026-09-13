# Node Description Batch 49 of 68

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

- "services_python_runner_service_capture_plt": "_capture_plt()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L364 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_checkandsyncpythonassets": "_checkAndSyncPythonAssets()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L979 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_choice": "choice()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L245 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_classification_report": "classification_report()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L894 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_clf": "clf()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L457 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_close": "close()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L462 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_confusion_matrix": "confusion_matrix()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L891 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_copy": "copy()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L141 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_cos": "cos()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L316 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_countplot": "countplot()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L681 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_dataframe": "_DataFrame" | kind=code-symbol | source=lib/services/python_runner_service.dart:L573 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_degrees": "degrees()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L326 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_describe": "describe()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L604 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_despine": "despine()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L633 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_dot": "dot()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L343 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_dummy_fn": "_dummy_fn()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L121 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_elem_op": "_elem_op()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L180 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_exp": "exp()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L318 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_extract_xy": "_extract_xy()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L635 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_figure": "figure()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L455 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_fit": "fit()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L787 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_fit_transform": "fit_transform()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L855 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_flatten": "flatten()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L163 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_full": "full()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L311 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_function": "Function()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L1004 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_get_fignums": "get_fignums()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L463 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_getitem": "__getitem__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L169 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_grid": "grid()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L453 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_head": "head()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L568 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_heatmap": "heatmap()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L670 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_hist": "hist()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L421 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_histplot": "histplot()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L664 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_imshow": "imshow()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L434 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_init": "__init__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L113 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_installpackage": "installPackage()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L163 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_interactive_input": "_interactive_input()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L67 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_iter": "__iter__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L177 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_kmeans": "_KMeans" | kind=code-symbol | source=lib/services/python_runner_service.dart:L831 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_legend": "legend()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L454 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_len": "__len__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L166 | neighbors=[python_runner_service.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-048.json

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
