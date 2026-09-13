# Node Description Batch 51 of 68

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

- "services_python_runner_service_radd": "__radd__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L195 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_radians": "radians()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L325 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_rand": "rand()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L227 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_randint": "randint()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L237 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_randn": "randn()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L232 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_read_csv": "read_csv()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L614 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_relem_op": "_relem_op()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L188 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_render_svg_plot": "_render_svg_plot()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L473 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_repr": "__repr__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L207 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_reshape": "reshape()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L160 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_rmul": "__rmul__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L199 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_rpow": "__rpow__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L203 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_rsub": "__rsub__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L197 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_rtruediv": "__rtruediv__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L201 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_runcode": "runCode()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L1001 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_savefig": "savefig()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L469 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_scatter": "scatter()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L415 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_scatterplot": "scatterplot()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L646 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_score": "score()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L805 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_seabornstub": "_SeabornStub" | kind=code-symbol | source=lib/services/python_runner_service.dart:L628 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_seed": "seed()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L252 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_series": "_Series" | kind=code-symbol | source=lib/services/python_runner_service.dart:L560 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_set": "set()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L632 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_set_palette": "set_palette()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L631 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_set_style": "set_style()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L630 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_set_theme": "set_theme()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L629 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_set_title": "set_title()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L445 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_set_xlabel": "set_xlabel()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L447 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_set_ylabel": "set_ylabel()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L449 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_setitem": "__setitem__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L174 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_shape": "shape()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L123 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_show": "show()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L464 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_shuffle": "shuffle()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L255 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_sin": "sin()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L315 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_size": "size()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L131 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_sklearncluster": "_SklearnCluster" | kind=code-symbol | source=lib/services/python_runner_service.dart:L845 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_sklearndatasets": "_SklearnDatasets" | kind=code-symbol | source=lib/services/python_runner_service.dart:L714 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_sklearnlinearmodel": "_SklearnLinearModel" | kind=code-symbol | source=lib/services/python_runner_service.dart:L826 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_sklearnmetrics": "_SklearnMetrics" | kind=code-symbol | source=lib/services/python_runner_service.dart:L870 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_sklearnmodelselection": "_SklearnModelSelection" | kind=code-symbol | source=lib/services/python_runner_service.dart:L762 | neighbors=[python_runner_service.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-050.json

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
