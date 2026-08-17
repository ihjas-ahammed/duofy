# Node Description Batch 2 of 61

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

- "screens_main_layout_screen": "main_layout_screen.dart" | kind=code-symbol | source=lib/screens/main_layout_screen.dart:L1 | neighbors=[1322f3d ASZ, 1393ac9 6th, 1fa1705 OK, 2dfddb1 z, 675d2a1 EXPRESS, 67b95db OK] | lang=en
- "screens_pyq_tab_screen": "pyq_tab_screen.dart" | kind=code-symbol | source=lib/screens/pyq_tab_screen.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 3a768f9 style: dart format the files to…, 4c8673e OKKK, 4ea5161 Merge pull request #3 from ihja…, 8554e22 feat: the web build compiles an…] | lang=en
- "screens_summary_screen": "summary_screen.dart" | kind=code-symbol | source=lib/screens/summary_screen.dart:L1 | neighbors=[085e90d quick fix, 1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 675d2a1 EXPRESS, 8554e22 feat: the web build compiles an…] | lang=en
- "services_b2_service": "b2_service.dart" | kind=code-symbol | source=lib/services/b2_service.dart:L1 | neighbors=[0270948 feat: move shared secrets to au…, 1393ac9 6th, 4c8673e OKKK, a22f95b feat: complete celestial light …, b99cbf3 OK, f782455 feat: implement target section …] | lang=en
- "services_metacognition_service": "metacognition_service.dart" | kind=code-symbol | source=lib/services/metacognition_service.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, 3b989f1 Bump version to 26.7.22+2026072…, 845dfcb feat: fast offline-speed initia…, a22f95b feat: complete celestial light …, bccabe4 pyq_meta all set, f10ef09 feat: metacognitive loop, four …] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@f10ef0909e68de48114bee8d5086782b79f48b54": "f10ef09 feat: metacognitive loop, four new exercise types, learner profile v2, …" | kind=Commit | source=git | neighbors=[9864444 feat: onboarding walkthrough, a…, main, 8554e22 feat: the web build compiles an…, app_models.dart, experiments_screen.dart, home_screen.dart] | lang=en
- "services_progress_service": "progress_service.dart" | kind=code-symbol | source=lib/services/progress_service.dart:L1 | neighbors=[1393ac9 6th, 5621c28 v26.8.8: Integrated SeriousPyth…, 8938325 feat: layout-based course progr…, 9535e64 k, a15c42e feat(daily-goals): Add Gamified…, a22f95b feat: complete celestial light …] | lang=en
- "screens_experiments_screen": "experiments_screen.dart" | kind=code-symbol | source=lib/screens/experiments_screen.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 3a768f9 style: dart format the files to…, 3d09abf fix: slide interaction and cont…, 4ea5161 Merge pull request #3 from ihja…, 7dbab59 Merge pull request #2 from ihja…] | lang=en
- "screens_practice_session_screen": "practice_session_screen.dart" | kind=code-symbol | source=lib/screens/practice_session_screen.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ac3990 new db, 4ea5161 Merge pull request #3 from ihja…, 4ead8b6 z, 675d2a1 EXPRESS] | lang=en
- "services_pdf_service": "pdf_service.dart" | kind=code-symbol | source=lib/services/pdf_service.dart:L1 | neighbors=[1393ac9 6th, 8554e22 feat: the web build compiles an…, 9981c72 z, a055e9b PRE-RE, ed71b03 io, extractPages()] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@ea88f41b3959623c4c9304d89e1ce0e1b7164762": "ea88f41 Farsan" | kind=Commit | source=git | neighbors=[main, a15c42e feat(daily-goals): Add Gamified…, main.dart, app_models.dart, app_crash_recovery_screen.dart, lesson_complete_screen.dart] | lang=en
- "screens_ai_providers_screen": "ai_providers_screen.dart" | kind=code-symbol | source=lib/screens/ai_providers_screen.dart:L1 | neighbors=[1393ac9 6th, 2d60cdb feat: add AI provider model tes…, 3b989f1 Bump version to 26.7.22+2026072…, a22f95b feat: complete celestial light …, c71d757 orgainze apis, _addModelToSlot()] | lang=en
- "screens_course_settings_screen": "course_settings_screen.dart" | kind=code-symbol | source=lib/screens/course_settings_screen.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, 3a768f9 style: dart format the files to…, 4ac3990 new db, 4ea5161 Merge pull request #3 from ihja…, 675d2a1 EXPRESS, a055e9b PRE-RE] | lang=en
- "slide_views_matching_view": "matching_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/matching_view.dart:L1 | neighbors=[10204b5 theme: migrate one_word/numeric…, 12bf472 feat(release): overhaul PYQ tab…, 1322f3d ASZ, 1393ac9 6th, 329bdab ny, 3a768f9 style: dart format the files to…] | lang=en
- "widgets_canvas_art_view": "canvas_art_view.dart" | kind=code-symbol | source=lib/widgets/canvas_art_view.dart:L1 | neighbors=[06c30be theme: migrate lesson-complete …, 11cc12c feat: cumulative sequential dea…, 1393ac9 6th, 3a768f9 style: dart format the files to…, 3cff7f6 REALLY!, 3d09abf fix: slide interaction and cont…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@1fa1705cb1ac5f33cb77c0a179169ce95f59d96e": "1fa1705 OK" | kind=Commit | source=git | neighbors=[18142cc chore: add Android builds v26.7…, main, 88176b7 chore: add Android builds v26.7…, main.dart, main.cpp, my_application.h] | lang=en
- "services_math_evaluator_service": "math_evaluator_service.dart" | kind=code-symbol | source=lib/services/math_evaluator_service.dart:L1 | neighbors=[4ead8b6 z, a22f95b feat: complete celestial light …, call(), _callFunction(), _combination(), _consume()] | lang=en
- "widgets_quick_review_sheet": "quick_review_sheet.dart" | kind=code-symbol | source=lib/widgets/quick_review_sheet.dart:L1 | neighbors=[1393ac9 6th, 2dfddb1 z, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 61c1ed4 theme: migrate quick_review_she…, a22f95b feat: complete celestial light …] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@3cff7f6fe7d28c150ff5aa90b25e06c1cb89160e": "3cff7f6 REALLY!" | kind=Commit | source=git | neighbors=[06c076e chore: add Android builds v26.7…, main, 5f9d253 chore: add Android builds v26.7…, main.dart, book_dashboard_screen.dart, course_edit_structure_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@5621c2846632cb0372192d68fb1cf2def8a4c6c7": "5621c28 v26.8.8: Integrated SeriousPython multi-arch runtime, interactive noteb…" | kind=Commit | source=git | neighbors=[main, 63ce973 Update app.zip and app.zip.hash…, programming_slides_screen.dart, latex_ide_screen.dart, python_notebook_screen.dart, main.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@a055e9b7afd2ffd1f6a61bfe27e00d71e3971ad8": "a055e9b PRE-RE" | kind=Commit | source=git | neighbors=[994c7de chore: add Android and Windows …, main, 74cc3a6 chore: add Android and Windows …, app_models.dart, my_application.h, book_dashboard_screen.dart] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@bccabe475a72627cafe29d4760ac919a2ab6c322": "bccabe4 pyq_meta all set" | kind=Commit | source=git | neighbors=[859f766 new, main, 01d6dd3 Merge branch 'main' of https://…, fb_core.dart, main.dart, pyq_models.dart] | lang=en
- "runner_win32_window": "win32_window.h" | kind=code-symbol | source=windows/runner/win32_window.h:L1 | neighbors=[Create(), CreateAndShow(), Destroy(), EnableFullDpiSupportIfAvailable(), GetClientArea(), GetHandle()] | lang=en
- "slide_views_interactive_proof_view": "interactive_proof_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/interactive_proof_view.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 3e9b205 theme: migrate descriptive/inte…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, ea88f41 Farsan] | lang=en
- "widgets_analytics_view": "analytics_view.dart" | kind=code-symbol | source=lib/widgets/analytics_view.dart:L1 | neighbors=[0184924 theme: migrate analytics_view, 1393ac9 6th, 3a768f9 style: dart format the files to…, 4c8673e OKKK, 4ea5161 Merge pull request #3 from ihja…, 5621c28 v26.8.8: Integrated SeriousPyth…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@9d1d7bc74012546c4b607ebce91035f992d48f8e": "9d1d7bc NAA" | kind=Commit | source=git | neighbors=[main, 07c4665 chore: add Android builds v26.7…, 1393ac9 6th, programming_slides_screen.dart, main.dart, app_models.dart] | lang=en
- "fb_fd_backend": "fd_backend.dart" | kind=code-symbol | source=lib/services/fb/fd_backend.dart:L1 | neighbors=[8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …, createUserWithEmailAndPassword(), delete(), _extractFiredartError(), FdAuthBackend] | lang=en
- "screens_reference_pdf_viewer_screen": "reference_pdf_viewer_screen.dart" | kind=code-symbol | source=lib/screens/reference_pdf_viewer_screen.dart:L1 | neighbors=[039f2fe theme: migrate generate_qp, pdf…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …, e53d2de Share PDF] | lang=en
- "services_usage_limit_service": "usage_limit_service.dart" | kind=code-symbol | source=lib/services/usage_limit_service.dart:L1 | neighbors=[1393ac9 6th, a22f95b feat: complete celestial light …, aaf383b fix: update free capacity limit…, c71d757 orgainze apis, f782455 feat: implement target section …, areAllLimitsHit()] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@329bdabdce9984316bb9cb6d6ce3801d79e4b59d": "329bdab ny" | kind=Commit | source=git | neighbors=[main, 7be050f Merge branch 'main' of https://…, code_ide_screen.dart, html_ide_screen.dart, latex_ide_screen.dart, python_notebook_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@ed71b0390d7f4cd952ef2ae35fe92ba1d4b8b3b5": "ed71b03 io" | kind=Commit | source=git | neighbors=[5608612 chore: add Android and Windows …, main, 589f5de feat: deterministic contents-to…, 9fa942f chore: add Android and Windows …, app_models.dart, book_dashboard_screen.dart] | lang=en
- "common_webview_app": "webview_app.h" | kind=code-symbol | source=packages/webview_cef/common/webview_app.h:L1 | neighbors=[GetProcessType(), OnBeforeChildProcessLaunch(), OnBeforeCommandLineProcessing(), OnBrowserCreated(), OnBrowserDestroyed(), OnContextCreated()] | lang=en
- "screens_lesson_complete_screen": "lesson_complete_screen.dart" | kind=code-symbol | source=lib/screens/lesson_complete_screen.dart:L1 | neighbors=[06c30be theme: migrate lesson-complete …, 11cc12c feat: cumulative sequential dea…, 1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 5621c28 v26.8.8: Integrated SeriousPyth…] | lang=en
- "screens_python_ide_screen": "python_ide_screen.dart" | kind=code-symbol | source=lib/screens/python_ide_screen.dart:L1 | neighbors=[081eccf Implement real-time Jupyter-sty…, 37cdd6b Support interactive Python inpu…, 4147f0b Fix Android ProcessEnvironment …, 81cf620 Fix Python IDE title bar overfl…, a22f95b feat: complete celestial light …, eb38f80 Fix Linux quit handling, Linux …] | lang=en
- "slide_views_fill_in_blank_view": "fill_in_blank_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/fill_in_blank_view.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, 1322f3d ASZ, 1393ac9 6th, 3a768f9 style: dart format the files to…, 3e9b205 theme: migrate descriptive/inte…, 4ea5161 Merge pull request #3 from ihja…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@a15c42ed53242587f99e28dbb8047710be8365e8": "a15c42e feat(daily-goals): Add Gamified Daily Goals system with 20 templates, i…" | kind=Commit | source=git | neighbors=[main, 7e90faf chore: add Android builds v26.8…, main.dart, daily_goal.dart, daily_goals_screen.dart, home_screen.dart] | lang=en
- "screens_pyq_panel_screen": "pyq_panel_screen.dart" | kind=code-symbol | source=lib/screens/pyq_panel_screen.dart:L1 | neighbors=[bccabe4 pyq_meta all set, and, _attachBackgroundJobListener(), dispose(), initState(), _loadPyqBank()] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@9864444876bea0b6e1ba6ac9134f234180f720ac": "9864444 feat: onboarding walkthrough, advanced mode, next-up hero, daily goal (…" | kind=Commit | source=git | neighbors=[0270948 feat: move shared secrets to au…, main, f10ef09 feat: metacognitive loop, four …, generated_plugin_registrant.h, main.dart, onboarding_screen.dart] | lang=en
- "screens_ai_queue_screen": "ai_queue_screen.dart" | kind=code-symbol | source=lib/screens/ai_queue_screen.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4337110 feat: remove AI 10-page chunk s…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, d6812c1 feat: add Run now quick-run for…] | lang=en
- "screens_pdf_folder_screen": "pdf_folder_screen.dart" | kind=code-symbol | source=lib/screens/pdf_folder_screen.dart:L1 | neighbors=[039f2fe theme: migrate generate_qp, pdf…, 1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 675d2a1 EXPRESS, 8554e22 feat: the web build compiles an…] | lang=en

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-001.json

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
