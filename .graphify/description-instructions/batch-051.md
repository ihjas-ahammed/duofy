# Node Description Batch 52 of 68

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

- "services_python_runner_service_sklearnpreprocessing": "_SklearnPreprocessing" | kind=code-symbol | source=lib/services/python_runner_service.dart:L865 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_sqrt": "sqrt()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L322 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_standardscaler": "_StandardScaler" | kind=code-symbol | source=lib/services/python_runner_service.dart:L849 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_std": "std()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L150 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_str": "__str__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L215 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_sub": "__sub__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L196 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_subplots": "subplots()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L456 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_sum": "sum()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L144 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_t": "T()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L135 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_tail": "tail()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L569 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_tan": "tan()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L317 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_title": "title()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L444 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_to_list": "_to_list()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L396 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_tolist": "tolist()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L138 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_train_test_split": "train_test_split()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L763 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_transform": "transform()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L854 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_truediv": "__truediv__()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L200 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_violinplot": "violinplot()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L678 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_xlabel": "xlabel()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L446 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_xlim": "xlim()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L451 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_ylabel": "ylabel()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L448 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_ylim": "ylim()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L452 | neighbors=[python_runner_service.dart]
- "services_python_runner_service_zeros": "zeros()" | kind=code-symbol | source=lib/services/python_runner_service.dart:L303 | neighbors=[python_runner_service.dart]
- "services_streak_service_daystreakdata": "DayStreakData" | kind=code-symbol | source=lib/services/streak_service.dart:L4 | neighbors=[streak_service.dart]
- "services_streak_service_formatdate": "_formatDate()" | kind=code-symbol | source=lib/services/streak_service.dart:L37 | neighbors=[streak_service.dart]
- "services_streak_service_getstreakinfo": "getStreakInfo()" | kind=code-symbol | source=lib/services/streak_service.dart:L41 | neighbors=[streak_service.dart]
- "services_streak_service_streakinfo": "StreakInfo" | kind=code-symbol | source=lib/services/streak_service.dart:L20 | neighbors=[streak_service.dart]
- "services_streak_service_streakservice": "StreakService" | kind=code-symbol | source=lib/services/streak_service.dart:L36 | neighbors=[streak_service.dart]
- "services_toc_matcher_hasprintedpagenumbers": "hasPrintedPageNumbers()" | kind=code-symbol | source=lib/services/toc_matcher.dart:L155 | neighbors=[toc_matcher.dart]
- "services_toc_matcher_index": "index" | kind=code-symbol | source=lib/services/toc_matcher.dart:L31 | neighbors=[toc_matcher.dart]
- "services_toc_matcher_ischapterstart": "isChapterStart()" | kind=code-symbol | source=lib/services/toc_matcher.dart:L126 | neighbors=[toc_matcher.dart]
- "services_toc_matcher_normalize": "_normalize()" | kind=code-symbol | source=lib/services/toc_matcher.dart:L74 | neighbors=[toc_matcher.dart]
- "services_toc_matcher_overview": "overview" | kind=code-symbol | source=lib/services/toc_matcher.dart:L31 | neighbors=[toc_matcher.dart]
- "services_toc_matcher_tocmatcher": "TocMatcher" | kind=code-symbol | source=lib/services/toc_matcher.dart:L5 | neighbors=[toc_matcher.dart]
- "services_toc_matcher_tocscore": "tocScore()" | kind=code-symbol | source=lib/services/toc_matcher.dart:L85 | neighbors=[toc_matcher.dart]
- "services_update_service_apkfilefor": "_apkFileFor()" | kind=code-symbol | source=lib/services/update_service.dart:L255 | neighbors=[update_service.dart]
- "services_update_service_cachedapk": "cachedApk()" | kind=code-symbol | source=lib/services/update_service.dart:L262 | neighbors=[update_service.dart]
- "services_update_service_checkforupdate": "checkForUpdate()" | kind=code-symbol | source=lib/services/update_service.dart:L72 | neighbors=[update_service.dart]
- "services_update_service_downloadapk": "downloadApk()" | kind=code-symbol | source=lib/services/update_service.dart:L270 | neighbors=[update_service.dart]
- "services_update_service_fetchchangelog": "_fetchChangelog()" | kind=code-symbol | source=lib/services/update_service.dart:L200 | neighbors=[update_service.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-051.json

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
