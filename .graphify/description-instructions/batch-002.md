# Node Description Batch 3 of 68

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
Write every description in English (en). Do not switch languages.
No marketing language.
Respond ONLY with a JSON object mapping each node id (as a string) to its
one-sentence description — no prose, no markdown fences.

- "commit:repo:github.com/ihjas-ahammed/duofy@a15c42ed53242587f99e28dbb8047710be8365e8": "a15c42e feat(daily-goals): Add Gamified Daily Goals system with 20 templates, i…" | kind=Commit | source=git | neighbors=[main, 7e90faf chore: add Android builds v26.8…, main.dart, daily_goal.dart, daily_goals_screen.dart, home_screen.dart]
- "screens_pyq_panel_screen": "pyq_panel_screen.dart" | kind=code-symbol | source=lib/screens/pyq_panel_screen.dart:L1 | neighbors=[bccabe4 pyq_meta all set, and, _attachBackgroundJobListener(), dispose(), initState(), _loadPyqBank()]
- "services_notification_service": "notification_service.dart" | kind=code-symbol | source=lib/services/notification_service.dart:L1 | neighbors=[1393ac9 6th, 1fa1705 OK, 7b676e4 v26.8.12: Update latest.md, ver…, 7dbab59 Merge pull request #2 from ihja…, 8554e22 feat: the web build compiles an…, 9864444 feat: onboarding walkthrough, a…]
- "slide_views_descriptive_view": "descriptive_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/descriptive_view.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 1c58056 feat(release): v26.8.31 - Compl…, 3e9b205 theme: migrate descriptive/inte…, 4ea5161 Merge pull request #3 from ihja…, 8554e22 feat: the web build compiles an…]
- "slide_views_numerical_view": "numerical_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/numerical_view.dart:L1 | neighbors=[10204b5 theme: migrate one_word/numeric…, 12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 1c58056 feat(release): v26.8.31 - Compl…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…]
- "commit:repo:github.com/ihjas-ahammed/duofy@9864444876bea0b6e1ba6ac9134f234180f720ac": "9864444 feat: onboarding walkthrough, advanced mode, next-up hero, daily goal (…" | kind=Commit | source=git | neighbors=[0270948 feat: move shared secrets to au…, main, f10ef09 feat: metacognitive loop, four …, generated_plugin_registrant.h, main.dart, onboarding_screen.dart]
- "screens_ai_queue_screen": "ai_queue_screen.dart" | kind=code-symbol | source=lib/screens/ai_queue_screen.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4337110 feat: remove AI 10-page chunk s…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, d6812c1 feat: add Run now quick-run for…]
- "screens_pdf_folder_screen": "pdf_folder_screen.dart" | kind=code-symbol | source=lib/screens/pdf_folder_screen.dart:L1 | neighbors=[039f2fe theme: migrate generate_qp, pdf…, 1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …]
- "services_global_state": "global_state.dart" | kind=code-symbol | source=lib/services/global_state.dart:L1 | neighbors=[3cff7f6 REALLY!, 7dbab59 Merge pull request #2 from ihja…, 9864444 feat: onboarding walkthrough, a…, a15c42e feat(daily-goals): Add Gamified…, a22f95b feat: complete celestial light …, ea88f41 Farsan]
- "services_update_service": "update_service.dart" | kind=code-symbol | source=lib/services/update_service.dart:L1 | neighbors=[a22f95b feat: complete celestial light …, a292b18 feat: instant update check cach…, b99cbf3 OK, _apkFileFor(), cachedApk(), checkForUpdate()]
- "common_webview_plugin": "webview_plugin.h" | kind=code-symbol | source=packages/webview_cef/common/webview_plugin.h:L1 | neighbors=[cursorAction(), doMessageLoopWork(), getAnyBrowserFocused(), HandleMethodCall(), initCallback(), initCEFProcesses()]
- "common_webview_value_webview_value_equals": "webview_value_equals()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L367 | neighbors=[webview_value.h, webview_value_get_bool(), webview_value_get_by_key(), webview_value_get_double(), webview_value_get_double_list(), webview_value_get_float()]
- "common_webview_value_webview_value_new": "webview_value_new()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L143 | neighbors=[webview_value.h, webview_value_new_bool(), webview_value_new_double(), webview_value_new_double_list(), webview_value_new_float(), webview_value_new_float_list()]
- "common_webview_value_webview_value_to_string": "webview_value_to_string()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L773 | neighbors=[webview_value.h, webview_value_get_bool(), webview_value_get_double(), webview_value_get_double_list(), webview_value_get_float(), webview_value_get_float_list()]
- "screens_metacognition_setup_screen": "metacognition_setup_screen.dart" | kind=code-symbol | source=lib/screens/metacognition_setup_screen.dart:L1 | neighbors=[1393ac9 6th, 2934308 theme: migrate metacognition_se…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, _countSentences()]
- "slide_views_flashcard_view": "flashcard_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/flashcard_view.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 1c58056 feat(release): v26.8.31 - Compl…, 25fb4a6 fix: reset FlashcardView state …, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…]
- "widgets_next_up_card": "next_up_card.dart" | kind=code-symbol | source=lib/widgets/next_up_card.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea21ab fix: loadPyodide loading timing…, 4ea5161 Merge pull request #3 from ihja…, 9535e64 k, 9864444 feat: onboarding walkthrough, a…]
- "commit:repo:github.com/ihjas-ahammed/duofy@f7824555c7dc337311f934f36b143c90c26e94e1": "f782455 feat: implement target section deadlines, fix canvas art loading bug, c…" | kind=Commit | source=git | neighbors=[269329e chore: add Android builds v26.7…, main, 2e3bece chore: add Android builds v26.7…, main.dart, document_store_screen.dart, generate_book_screen.dart]
- "runner_my_application": "my_application.h" | kind=code-symbol | source=linux/runner/my_application.h:L1 | neighbors=[1fa1705 OK, 7dbab59 Merge pull request #2 from ihja…, e9979c0 rebrand: rename app display nam…, eb38f80 Fix Linux quit handling, Linux …, first_frame_cb(), my_application_activate()]
- "services_pyq_exam_service": "pyq_exam_service.dart" | kind=code-symbol | source=lib/services/pyq_exam_service.dart:L1 | neighbors=[bccabe4 pyq_meta all set, addListener(), addPyqItems(), _bankKey(), evaluateExamPaper(), Function()]
- "widgets_coach_mark": "coach_mark.dart" | kind=code-symbol | source=lib/widgets/coach_mark.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 9864444 feat: onboarding walkthrough, a…, a22f95b feat: complete celestial light …, ea88f41 Farsan]
- "widgets_desktop_webview_io": "desktop_webview_io.dart" | kind=code-symbol | source=lib/widgets/desktop_webview_io.dart:L1 | neighbors=[11cc12c feat: cumulative sequential dea…, 1fa1705 OK, 8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …, DesktopWebView, desktopWebViewEnsureInitialized()]
- "commit:repo:github.com/ihjas-ahammed/duofy@4c8673eec1848eb9815b9e42ecf8957c27f017bd": "4c8673e OKKK" | kind=Commit | source=git | neighbors=[0eaaf59 chore: add Android builds v26.7…, main, 18142cc chore: add Android builds v26.7…, document_store_screen.dart, generate_book_screen.dart, lesson_screen.dart]
- "commit:repo:github.com/ihjas-ahammed/duofy@859f76662ae5c714614aadcd80746bbd95d8332c": "859f766 new" | kind=Commit | source=git | neighbors=[2b1de87 chore: add Android builds v26.7…, main, 67c2b34 chore: add Android builds v26.7…, bccabe4 pyq_meta all set, main.dart, auth_gate.dart]
- "commit:repo:github.com/ihjas-ahammed/duofy@8a51c1300e53ee4afd52f6ca9e23f5b06911f33c": "8a51c13 fix(python & formats): disable R8 JNI minification for SeriousPython cr…" | kind=Commit | source=git | neighbors=[main, 358ddb3 chore: add Android builds v26.7…, main.dart, app_models.dart, app_crash_recovery_screen.dart, lesson_screen.dart]
- "commit:repo:github.com/ihjas-ahammed/duofy@9535e6432f71d843795cf072261705ca0520620b": "9535e64 k" | kind=Commit | source=git | neighbors=[main, 7a4966f chore: add Android builds v26.7…, book_dashboard_screen.dart, home_screen.dart, lesson_screen.dart, database_service.dart]
- "commit:repo:github.com/ihjas-ahammed/duofy@9981c729b77e0962fee7c8ac454fd4b514fe164b": "9981c72 z" | kind=Commit | source=git | neighbors=[main, 2dfddb1 z, experiments_screen.dart, generate_book_screen.dart, settings_screen.dart, summary_screen.dart]
- "commit:repo:github.com/ihjas-ahammed/duofy@b807fe55a9fa5e590b5cbe87faccecacd9ca918c": "b807fe5 sd" | kind=Commit | source=git | neighbors=[main, da7e93c Merge branch 'main' of https://…, fb_auth.dart, fb_core.dart, document_store_screen.dart, home_screen.dart]
- "fb_fb_auth": "fb_auth.dart" | kind=code-symbol | source=lib/services/fb/fb_auth.dart:L1 | neighbors=[8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …, createUserWithEmailAndPassword(), _FaAuth, _FaUser, FbAuth]
- "fb_fb_firestore": "fb_firestore.dart" | kind=code-symbol | source=lib/services/fb/fb_firestore.dart:L1 | neighbors=[8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …, _CfCollection, _CfDoc, _CfFirestore, delete()]
- "ide_python_notebook_screen": "python_notebook_screen.dart" | kind=code-symbol | source=lib/screens/ide/python_notebook_screen.dart:L1 | neighbors=[329bdab ny, 5621c28 v26.8.8: Integrated SeriousPyth…, df34d11 Fix latex, peace, _addCell(), _deleteCell(), dispose()]
- "screens_module_notes_viewer_screen": "module_notes_viewer_screen.dart" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L1 | neighbors=[14e7263 feat: Quick Generate Module Not…, 5fcf739 update: tactical sync, e52e844 feat(release): v26.8.27 - LaTeX…, _confirmDeleteNotes(), Function(), initState()]
- "screens_pdf_browser_screen": "pdf_browser_screen.dart" | kind=code-symbol | source=lib/screens/pdf_browser_screen.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …, df7e28f theme: migrate pdf_browser, exp…]
- "services_deadline_service": "deadline_service.dart" | kind=code-symbol | source=lib/services/deadline_service.dart:L1 | neighbors=[11cc12c feat: cumulative sequential dea…, a22f95b feat: complete celestial light …, ab7968d it ignored my command lets see …, b5b2ecb fix: resolve incorrect deadline…, c04f5ba fix: resolve static analyzer in…, f782455 feat: implement target section …]
- "slide_views_ordering_view": "ordering_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/ordering_view.dart:L1 | neighbors=[10204b5 theme: migrate one_word/numeric…, 12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 1c58056 feat(release): v26.8.31 - Compl…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…]
- "slide_views_program_view": "program_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/program_view.dart:L1 | neighbors=[1c58056 feat(release): v26.8.31 - Compl…, 81cf620 Fix Python IDE title bar overfl…, 9d1d7bc NAA, a22f95b feat: complete celestial light …, _buildSuggestions(), _CodePanel]
- "slide_views_pyq_one_word_view": "pyq_one_word_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/pyq_one_word_view.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 3e9b205 theme: migrate descriptive/inte…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, a292b18 feat: instant update check cach…]
- "slide_views_quiz_view": "quiz_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/quiz_view.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, 1322f3d ASZ, 1393ac9 6th, 1c58056 feat(release): v26.8.31 - Compl…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…]
- "slide_views_theory_view": "theory_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/theory_view.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 1bb5af4 theme: migrate theory_view, 1c58056 feat(release): v26.8.31 - Compl…, 3a768f9 style: dart format the files to…, 3d09abf fix: slide interaction and cont…]
- "widgets_daily_goal_card": "daily_goal_card.dart" | kind=code-symbol | source=lib/widgets/daily_goal_card.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 7b676e4 v26.8.12: Update latest.md, ver…, 9864444 feat: onboarding walkthrough, a…, a22f95b feat: complete celestial light …]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-002.json

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
