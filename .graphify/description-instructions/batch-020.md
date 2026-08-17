# Node Description Batch 21 of 61

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
For an entity node (any other kind — e.g. a person, place, event, object),
describe what the entity is and its role, grounded in its type, its
relations (neighbors) and the provided citations/evidence — e.g.
"Lady Carfax, a wealthy heiress who disappears en route to Lausanne.".
Ground entity descriptions in the citations/evidence when present; do not
speculate beyond the context, so a node with no supporting context may be
left out of the reply.
LANGUAGE: each entry has a `lang=` marker giving the language of its source.
Write that entry's description in EXACTLY that language. Do not translate to
a single common language — match each node's source language individually.
No marketing language.
Respond ONLY with a JSON object mapping each node id (as a string) to its
one-sentence description — no prose, no markdown fences.

- "models_app_models_lessonformat": "LessonFormat" | kind=code-symbol | source=lib/models/app_models.dart:L139 | neighbors=[app_models.dart] | lang=en
- "models_app_models_matchpair": "MatchPair" | kind=code-symbol | source=lib/models/app_models.dart:L2512 | neighbors=[app_models.dart] | lang=en
- "models_app_models_module": "Module" | kind=code-symbol | source=lib/models/app_models.dart:L1624 | neighbors=[app_models.dart] | lang=en
- "models_app_models_qpquestion": "QpQuestion" | kind=code-symbol | source=lib/models/app_models.dart:L1466 | neighbors=[app_models.dart] | lang=en
- "models_app_models_qpsection": "QpSection" | kind=code-symbol | source=lib/models/app_models.dart:L1504 | neighbors=[app_models.dart] | lang=en
- "models_app_models_questionpaper": "QuestionPaper" | kind=code-symbol | source=lib/models/app_models.dart:L1538 | neighbors=[app_models.dart] | lang=en
- "models_app_models_quickreviewitem": "QuickReviewItem" | kind=code-symbol | source=lib/models/app_models.dart:L1603 | neighbors=[app_models.dart] | lang=en
- "models_app_models_quizoption": "QuizOption" | kind=code-symbol | source=lib/models/app_models.dart:L2526 | neighbors=[app_models.dart] | lang=en
- "models_app_models_section": "Section" | kind=code-symbol | source=lib/models/app_models.dart:L1703 | neighbors=[app_models.dart] | lang=en
- "models_app_models_slide": "Slide" | kind=code-symbol | source=lib/models/app_models.dart:L2199 | neighbors=[app_models.dart] | lang=en
- "models_app_models_slidetemplate": "SlideTemplate" | kind=code-symbol | source=lib/models/app_models.dart:L32 | neighbors=[app_models.dart] | lang=en
- "models_app_models_str": "_str()" | kind=code-symbol | source=lib/models/app_models.dart:L3 | neighbors=[app_models.dart] | lang=en
- "models_app_models_tree": "tree" | kind=code-symbol | source=lib/models/app_models.dart:L901 | neighbors=[app_models.dart] | lang=en
- "models_app_models_trees": "trees" | kind=code-symbol | source=lib/models/app_models.dart:L898 | neighbors=[app_models.dart] | lang=en
- "models_app_models_unit": "Unit" | kind=code-symbol | source=lib/models/app_models.dart:L1894 | neighbors=[app_models.dart] | lang=en
- "models_app_models_updateid": "updateId()" | kind=code-symbol | source=lib/models/app_models.dart:L1411 | neighbors=[app_models.dart] | lang=en
- "models_app_models_wordcount": "_wordCount()" | kind=code-symbol | source=lib/models/app_models.dart:L2069 | neighbors=[app_models.dart] | lang=en
- "models_daily_goal_dailygoal": "DailyGoal" | kind=code-symbol | source=lib/models/daily_goal.dart:L4 | neighbors=[daily_goal.dart] | lang=en
- "models_daily_goal_dailygoalupdateevent": "DailyGoalUpdateEvent" | kind=code-symbol | source=lib/models/daily_goal.dart:L117 | neighbors=[daily_goal.dart] | lang=en
- "models_pyq_models_pyqexamattempt": "PyqExamAttempt" | kind=code-symbol | source=lib/models/pyq_models.dart:L103 | neighbors=[pyq_models.dart] | lang=en
- "models_pyq_models_pyqitem": "PyqItem" | kind=code-symbol | source=lib/models/pyq_models.dart:L3 | neighbors=[pyq_models.dart] | lang=en
- "models_pyq_models_pyqquestionanswer": "PyqQuestionAnswer" | kind=code-symbol | source=lib/models/pyq_models.dart:L57 | neighbors=[pyq_models.dart] | lang=en
- "onboarding_onboarding_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/onboarding/onboarding_screen.dart:L67 | neighbors=[onboarding_screen.dart] | lang=en
- "onboarding_onboarding_screen_finish": "_finish()" | kind=code-symbol | source=lib/screens/onboarding/onboarding_screen.dart:L72 | neighbors=[onboarding_screen.dart] | lang=en
- "onboarding_onboarding_screen_onboardingpage": "_OnboardingPage" | kind=code-symbol | source=lib/screens/onboarding/onboarding_screen.dart:L10 | neighbors=[onboarding_screen.dart] | lang=en
- "onboarding_onboarding_screen_onboardingscreen": "OnboardingScreen" | kind=code-symbol | source=lib/screens/onboarding/onboarding_screen.dart:L22 | neighbors=[onboarding_screen.dart] | lang=en
- "onboarding_onboarding_screen_onboardingscreenstate": "_OnboardingScreenState" | kind=code-symbol | source=lib/screens/onboarding/onboarding_screen.dart:L29 | neighbors=[onboarding_screen.dart] | lang=en
- "packup_rationale_163": "Checks if a file is likely binary based on its extension or content." | kind=entity | source=packup.py:L163 | neighbors=[is_likely_binary_file()] | lang=en
- "packup_rationale_189": "Packs all relevant files into a single text file." | kind=entity | source=packup.py:L189 | neighbors=[pack_project()] | lang=pt
- "packup_rationale_57": "Loads patterns from .gitignore file in the root directory." | kind=entity | source=packup.py:L57 | neighbors=[load_gitignore_patterns()] | lang=en
- "packup_rationale_81": "Checks if a given path (relative to project root) should be ignored.     Uses .g" | kind=entity | source=packup.py:L81 | neighbors=[should_ignore()] | lang=en
- "platform_io_stub_add": "add()" | kind=code-symbol | source=lib/platform/io_stub.dart:L182 | neighbors=[io_stub.dart] | lang=en
- "platform_io_stub_close": "close()" | kind=code-symbol | source=lib/platform/io_stub.dart:L186 | neighbors=[io_stub.dart] | lang=en
- "platform_io_stub_connect": "connect()" | kind=code-symbol | source=lib/platform/io_stub.dart:L179 | neighbors=[io_stub.dart] | lang=en
- "platform_io_stub_copy": "copy()" | kind=code-symbol | source=lib/platform/io_stub.dart:L85 | neighbors=[io_stub.dart] | lang=en
- "platform_io_stub_create": "create()" | kind=code-symbol | source=lib/platform/io_stub.dart:L61 | neighbors=[io_stub.dart] | lang=en
- "platform_io_stub_createsync": "createSync()" | kind=code-symbol | source=lib/platform/io_stub.dart:L63 | neighbors=[io_stub.dart] | lang=en
- "platform_io_stub_createtemp": "createTemp()" | kind=code-symbol | source=lib/platform/io_stub.dart:L115 | neighbors=[io_stub.dart] | lang=en
- "platform_io_stub_delete": "delete()" | kind=code-symbol | source=lib/platform/io_stub.dart:L37 | neighbors=[io_stub.dart] | lang=en
- "platform_io_stub_deletesync": "deleteSync()" | kind=code-symbol | source=lib/platform/io_stub.dart:L38 | neighbors=[io_stub.dart] | lang=en

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-020.json

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
