# Node Description Batch 3 of 61

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

- "common_webview_plugin": "webview_plugin.h" | kind=code-symbol | source=packages/webview_cef/common/webview_plugin.h:L1 | neighbors=[cursorAction(), doMessageLoopWork(), getAnyBrowserFocused(), HandleMethodCall(), initCallback(), initCEFProcesses()] | lang=en
- "common_webview_value_webview_value_equals": "webview_value_equals()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L367 | neighbors=[webview_value.h, webview_value_get_bool(), webview_value_get_by_key(), webview_value_get_double(), webview_value_get_double_list(), webview_value_get_float()] | lang=en
- "common_webview_value_webview_value_new": "webview_value_new()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L143 | neighbors=[webview_value.h, webview_value_new_bool(), webview_value_new_double(), webview_value_new_double_list(), webview_value_new_float(), webview_value_new_float_list()] | lang=en
- "common_webview_value_webview_value_to_string": "webview_value_to_string()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L773 | neighbors=[webview_value.h, webview_value_get_bool(), webview_value_get_double(), webview_value_get_double_list(), webview_value_get_float(), webview_value_get_float_list()] | lang=en
- "screens_metacognition_setup_screen": "metacognition_setup_screen.dart" | kind=code-symbol | source=lib/screens/metacognition_setup_screen.dart:L1 | neighbors=[1393ac9 6th, 2934308 theme: migrate metacognition_se…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, _countSentences()] | lang=en
- "services_global_state": "global_state.dart" | kind=code-symbol | source=lib/services/global_state.dart:L1 | neighbors=[3cff7f6 REALLY!, 7dbab59 Merge pull request #2 from ihja…, 9864444 feat: onboarding walkthrough, a…, a15c42e feat(daily-goals): Add Gamified…, a22f95b feat: complete celestial light …, ea88f41 Farsan] | lang=en
- "services_notification_service": "notification_service.dart" | kind=code-symbol | source=lib/services/notification_service.dart:L1 | neighbors=[1393ac9 6th, 1fa1705 OK, 7dbab59 Merge pull request #2 from ihja…, 8554e22 feat: the web build compiles an…, 9864444 feat: onboarding walkthrough, a…, bccabe4 pyq_meta all set] | lang=en
- "services_update_service": "update_service.dart" | kind=code-symbol | source=lib/services/update_service.dart:L1 | neighbors=[a22f95b feat: complete celestial light …, b99cbf3 OK, _apkFileFor(), cachedApk(), checkForUpdate(), downloadApk()] | lang=en
- "slide_views_descriptive_view": "descriptive_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/descriptive_view.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 3e9b205 theme: migrate descriptive/inte…, 4ea5161 Merge pull request #3 from ihja…, 675d2a1 EXPRESS, 8554e22 feat: the web build compiles an…] | lang=en
- "slide_views_numerical_view": "numerical_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/numerical_view.dart:L1 | neighbors=[10204b5 theme: migrate one_word/numeric…, 12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 4ead8b6 z] | lang=en
- "widgets_code_highlighter": "code_highlighter.dart" | kind=code-symbol | source=lib/widgets/code_highlighter.dart:L1 | neighbors=[4147f0b Fix Android ProcessEnvironment …, 9d1d7bc NAA, a22f95b feat: complete celestial light …, df34d11 Fix latex, peace, CodeEditingController, CodeHighlighter] | lang=en
- "widgets_next_up_card": "next_up_card.dart" | kind=code-symbol | source=lib/widgets/next_up_card.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea21ab fix: loadPyodide loading timing…, 4ea5161 Merge pull request #3 from ihja…, 9535e64 k, 9864444 feat: onboarding walkthrough, a…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@f7824555c7dc337311f934f36b143c90c26e94e1": "f782455 feat: implement target section deadlines, fix canvas art loading bug, c…" | kind=Commit | source=git | neighbors=[269329e chore: add Android builds v26.7…, main, 2e3bece chore: add Android builds v26.7…, main.dart, document_store_screen.dart, generate_book_screen.dart] | lang=en
- "runner_my_application": "my_application.h" | kind=code-symbol | source=linux/runner/my_application.h:L1 | neighbors=[1fa1705 OK, 7dbab59 Merge pull request #2 from ihja…, a055e9b PRE-RE, e9979c0 rebrand: rename app display nam…, eb38f80 Fix Linux quit handling, Linux …, first_frame_cb()] | lang=en
- "services_pyq_exam_service": "pyq_exam_service.dart" | kind=code-symbol | source=lib/services/pyq_exam_service.dart:L1 | neighbors=[bccabe4 pyq_meta all set, addListener(), addPyqItems(), _bankKey(), evaluateExamPaper(), Function()] | lang=en
- "widgets_coach_mark": "coach_mark.dart" | kind=code-symbol | source=lib/widgets/coach_mark.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 9864444 feat: onboarding walkthrough, a…, a22f95b feat: complete celestial light …, ea88f41 Farsan] | lang=en
- "widgets_desktop_webview_io": "desktop_webview_io.dart" | kind=code-symbol | source=lib/widgets/desktop_webview_io.dart:L1 | neighbors=[11cc12c feat: cumulative sequential dea…, 1fa1705 OK, 8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …, DesktopWebView, desktopWebViewEnsureInitialized()] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@4c8673eec1848eb9815b9e42ecf8957c27f017bd": "4c8673e OKKK" | kind=Commit | source=git | neighbors=[0eaaf59 chore: add Android builds v26.7…, main, 18142cc chore: add Android builds v26.7…, document_store_screen.dart, generate_book_screen.dart, lesson_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@859f76662ae5c714614aadcd80746bbd95d8332c": "859f766 new" | kind=Commit | source=git | neighbors=[2b1de87 chore: add Android builds v26.7…, main, 67c2b34 chore: add Android builds v26.7…, bccabe4 pyq_meta all set, main.dart, auth_gate.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@8a51c1300e53ee4afd52f6ca9e23f5b06911f33c": "8a51c13 fix(python & formats): disable R8 JNI minification for SeriousPython cr…" | kind=Commit | source=git | neighbors=[main, 358ddb3 chore: add Android builds v26.7…, main.dart, app_models.dart, app_crash_recovery_screen.dart, lesson_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@9535e6432f71d843795cf072261705ca0520620b": "9535e64 k" | kind=Commit | source=git | neighbors=[main, 7a4966f chore: add Android builds v26.7…, book_dashboard_screen.dart, home_screen.dart, lesson_screen.dart, database_service.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@9981c729b77e0962fee7c8ac454fd4b514fe164b": "9981c72 z" | kind=Commit | source=git | neighbors=[main, 2dfddb1 z, experiments_screen.dart, generate_book_screen.dart, settings_screen.dart, summary_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@b807fe55a9fa5e590b5cbe87faccecacd9ca918c": "b807fe5 sd" | kind=Commit | source=git | neighbors=[main, da7e93c Merge branch 'main' of https://…, fb_auth.dart, fb_core.dart, document_store_screen.dart, home_screen.dart] | lang=en
- "fb_fb_auth": "fb_auth.dart" | kind=code-symbol | source=lib/services/fb/fb_auth.dart:L1 | neighbors=[8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …, createUserWithEmailAndPassword(), _FaAuth, _FaUser, FbAuth] | lang=en
- "fb_fb_firestore": "fb_firestore.dart" | kind=code-symbol | source=lib/services/fb/fb_firestore.dart:L1 | neighbors=[8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …, _CfCollection, _CfDoc, _CfFirestore, delete()] | lang=en
- "ide_python_notebook_screen": "python_notebook_screen.dart" | kind=code-symbol | source=lib/screens/ide/python_notebook_screen.dart:L1 | neighbors=[329bdab ny, 5621c28 v26.8.8: Integrated SeriousPyth…, df34d11 Fix latex, peace, _addCell(), _deleteCell(), dispose()] | lang=en
- "screens_pdf_browser_screen": "pdf_browser_screen.dart" | kind=code-symbol | source=lib/screens/pdf_browser_screen.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …, df7e28f theme: migrate pdf_browser, exp…] | lang=en
- "services_deadline_service": "deadline_service.dart" | kind=code-symbol | source=lib/services/deadline_service.dart:L1 | neighbors=[11cc12c feat: cumulative sequential dea…, a22f95b feat: complete celestial light …, ab7968d it ignored my command lets see …, b5b2ecb fix: resolve incorrect deadline…, c04f5ba fix: resolve static analyzer in…, f782455 feat: implement target section …] | lang=en
- "widgets_duo_button": "duo_button.dart" | kind=code-symbol | source=lib/widgets/duo_button.dart:L1 | neighbors=[3a768f9 style: dart format the files to…, 4ea21ab fix: loadPyodide loading timing…, 4ea5161 Merge pull request #3 from ihja…, 675d2a1 EXPRESS, 67b95db OK, 92086cd theme: migrate duo_button, mini…] | lang=en
- "widgets_learner_profile_card": "learner_profile_card.dart" | kind=code-symbol | source=lib/widgets/learner_profile_card.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, f10ef09 feat: metacognitive loop, four …, f23bb62 theme: migrate calibration/lear…] | lang=en
- "widgets_platform_webview": "platform_webview.dart" | kind=code-symbol | source=lib/widgets/platform_webview.dart:L1 | neighbors=[4c8673e OKKK, 675d2a1 EXPRESS, 8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …, didUpdateWidget(), ensureInitialized()] | lang=en
- "bottom_sheets_section_bottom_sheet": "section_bottom_sheet.dart" | kind=code-symbol | source=lib/widgets/bottom_sheets/section_bottom_sheet.dart:L1 | neighbors=[dispose(), initState(), _scrollToActiveSection(), SectionBottomSheet, _SectionBottomSheetState, _SectionCard] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@11cc12c06ca98ffb285f63fa0cf6bbc4ce7860a3": "11cc12c feat: cumulative sequential deadline targets, dynamic page-scaled lesso…" | kind=Commit | source=git | neighbors=[00fdc1a chore: add Android builds v26.7…, main, 1e1860b chore: add Android builds v26.7…, app_models.dart, lesson_complete_screen.dart, module_selection_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@3d09abfb41ec7f3e1bf3df602b6b00f913be138f": "3d09abf fix: slide interaction and content-quality issues" | kind=Commit | source=git | neighbors=[main, 1322f3d ASZ, app_models.dart, experiments_screen.dart, lesson_screen.dart, prompt_service.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@a08a7bded78705b709fb004286d19c9ad1357a67": "a08a7bd FIX #1" | kind=Commit | source=git | neighbors=[main, 13b10df chore: add Android builds v27.0…, course_edit_structure_screen.dart, experiments_screen.dart, home_screen.dart, settings_screen.dart] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@b99cbf37013f71d1d17e2467b12ef4a2546d1c09": "b99cbf3 OK" | kind=Commit | source=git | neighbors=[88176b7 chore: add Android builds v26.7…, main, f25268e chore: add Android builds v26.7…, document_store_screen.dart, home_screen.dart, lesson_complete_screen.dart] | lang=en
- "onboarding_onboarding_screen": "onboarding_screen.dart" | kind=code-symbol | source=lib/screens/onboarding/onboarding_screen.dart:L1 | neighbors=[1322f3d ASZ, 1393ac9 6th, 7dbab59 Merge pull request #2 from ihja…, 9864444 feat: onboarding walkthrough, a…, 9d1d7bc NAA, a22f95b feat: complete celestial light …] | lang=en
- "services_mapping_verifier": "mapping_verifier.dart" | kind=code-symbol | source=lib/services/mapping_verifier.dart:L1 | neighbors=[3cff7f6 REALLY!, 8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …, ed71b03 io, describe(), _detectShift()] | lang=en
- "slide_views_flashcard_view": "flashcard_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/flashcard_view.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 25fb4a6 fix: reset FlashcardView state …, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 996d33b theme: migrate remaining small …] | lang=en
- "slide_views_ordering_view": "ordering_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/ordering_view.dart:L1 | neighbors=[10204b5 theme: migrate one_word/numeric…, 12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …] | lang=en

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
