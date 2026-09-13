# Node Description Batch 4 of 68

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

- "widgets_duo_button": "duo_button.dart" | kind=code-symbol | source=lib/widgets/duo_button.dart:L1 | neighbors=[3a768f9 style: dart format the files to…, 4ea21ab fix: loadPyodide loading timing…, 4ea5161 Merge pull request #3 from ihja…, 67b95db OK, 92086cd theme: migrate duo_button, mini…, a22f95b feat: complete celestial light …] | lang=en
- "widgets_learner_profile_card": "learner_profile_card.dart" | kind=code-symbol | source=lib/widgets/learner_profile_card.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, f10ef09 feat: metacognitive loop, four …, f23bb62 theme: migrate calibration/lear…] | lang=en
- "widgets_platform_webview": "platform_webview.dart" | kind=code-symbol | source=lib/widgets/platform_webview.dart:L1 | neighbors=[4c8673e OKKK, 8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …, didUpdateWidget(), ensureInitialized(), Function()] | lang=en
- "bottom_sheets_section_bottom_sheet": "section_bottom_sheet.dart" | kind=code-symbol | source=lib/widgets/bottom_sheets/section_bottom_sheet.dart:L1 | neighbors=[dispose(), initState(), _scrollToActiveSection(), SectionBottomSheet, _SectionBottomSheetState, _SectionCard] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@11cc12c06ca98ffb285f63fa0cf6bbc4ce7860a3": "11cc12c feat: cumulative sequential deadline targets, dynamic page-scaled lesso…" | kind=Commit | source=git | neighbors=[00fdc1a chore: add Android builds v26.7…, main, 1e1860b chore: add Android builds v26.7…, app_models.dart, lesson_complete_screen.dart, module_selection_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@3d09abfb41ec7f3e1bf3df602b6b00f913be138f": "3d09abf fix: slide interaction and content-quality issues" | kind=Commit | source=git | neighbors=[main, 1322f3d ASZ, app_models.dart, experiments_screen.dart, lesson_screen.dart, prompt_service.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@a08a7bded78705b709fb004286d19c9ad1357a67": "a08a7bd FIX #1" | kind=Commit | source=git | neighbors=[main, 13b10df chore: add Android builds v27.0…, course_edit_structure_screen.dart, experiments_screen.dart, home_screen.dart, settings_screen.dart] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@b99cbf37013f71d1d17e2467b12ef4a2546d1c09": "b99cbf3 OK" | kind=Commit | source=git | neighbors=[88176b7 chore: add Android builds v26.7…, main, f25268e chore: add Android builds v26.7…, document_store_screen.dart, home_screen.dart, lesson_complete_screen.dart] | lang=en
- "onboarding_onboarding_screen": "onboarding_screen.dart" | kind=code-symbol | source=lib/screens/onboarding/onboarding_screen.dart:L1 | neighbors=[1322f3d ASZ, 1393ac9 6th, 7dbab59 Merge pull request #2 from ihja…, 9864444 feat: onboarding walkthrough, a…, 9d1d7bc NAA, a22f95b feat: complete celestial light …] | lang=en
- "services_mapping_verifier": "mapping_verifier.dart" | kind=code-symbol | source=lib/services/mapping_verifier.dart:L1 | neighbors=[3cff7f6 REALLY!, 8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …, ed71b03 io, describe(), _detectShift()] | lang=en
- "slide_views_error_spotting_view": "error_spotting_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/error_spotting_view.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, 1c58056 feat(release): v26.8.31 - Compl…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 996d33b theme: migrate remaining small …, a22f95b feat: complete celestial light …] | lang=en
- "slide_views_one_word_view": "one_word_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/one_word_view.dart:L1 | neighbors=[10204b5 theme: migrate one_word/numeric…, 12bf472 feat(release): overhaul PYQ tab…, 1c58056 feat(release): v26.8.31 - Compl…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …] | lang=en
- "src_webview_manager": "webview_manager.dart" | kind=code-symbol | source=packages/webview_cef/lib/src/webview_manager.dart:L1 | neighbors=[deleteCookie(), dispose(), initialize(), _injectUserScriptIfNeeds(), methodCallhandler(), onBrowserCreated()] | lang=en
- "widgets_lesson_node": "lesson_node.dart" | kind=code-symbol | source=lib/widgets/lesson_node.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, b6ffe85 theme: migrate lesson_node, syn…, didUpdateWidget()] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@0a59fe516b659e1f1971c14e359fe1e36ecddc71": "0a59fe5 Merge pull request #4 from ihjas-ahammed/sirius" | kind=Commit | source=git | neighbors=[main, 06c076e chore: add Android builds v26.7…, app_models.dart, book_dashboard_screen.dart, generate_book_screen.dart, source_pdf_upload_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@1322f3d15a2e11e6062239e911f4b7b73e400671": "1322f3d ASZ" | kind=Commit | source=git | neighbors=[main, 7dbab59 Merge pull request #2 from ihja…, e02893d ux: answer feedback and interac…, onboarding_screen.dart, home_screen.dart, main_layout_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@2dfddb1d3217f0980bb583bb0cd9f548e6eef016": "2dfddb1 z" | kind=Commit | source=git | neighbors=[main, 010c32d chore: add Android and Windows …, app_models.dart, book_dashboard_screen.dart, home_screen.dart, main_layout_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@4ac399087f7cab0a38270abe6719eed87f6dbad7": "4ac3990 new db" | kind=Commit | source=git | neighbors=[main, 317ac5d Merge branch 'main' of https://…, app_models.dart, course_settings_screen.dart, lesson_screen.dart, practice_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@d68d72b468323211432bba344afb0b7b4fd1c240": "d68d72b XZ" | kind=Commit | source=git | neighbors=[7cb1aa6 RMY, main, d361f24 chore: add Android builds v26.7…, book_dashboard_screen.dart, generate_book_screen.dart, main_layout_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@eb38f80b605604e1435a6b7f7460f0ce9b867f4b": "eb38f80 Fix Linux quit handling, Linux CMake build flags, and integrate Python …" | kind=Commit | source=git | neighbors=[3b989f1 Bump version to 26.7.22+2026072…, main, 5aeefed chore: add Android builds v26.7…, generated_plugin_registrant.h, main.cpp, my_application.h] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@f23bb624710f53d1d634afb4d1dfe5cefc65399b": "f23bb62 theme: migrate calibration/learner_profile/file_selection/daily_goal/ r…" | kind=Commit | source=git | neighbors=[6fe7291 theme: migrate canvas_art_view …, main, e63dbac theme: migrate next_up_card, co…, calibration_card.dart, coach_mark.dart, daily_goal_card.dart] | lang=en
- "ide_universal_code_runner_screen": "universal_code_runner_screen.dart" | kind=code-symbol | source=lib/screens/ide/universal_code_runner_screen.dart:L1 | neighbors=[329bdab ny, df34d11 Fix latex, peace, dispose(), _getStarterCode(), greet(), initState()] | lang=en
- "linux_webview_cef_plugin": "webview_cef_plugin.cc" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_plugin.cc:L1 | neighbors=[encode_flvalue_to_wvalue(), encode_wavlue_to_flvalue(), initCEFProcesses(), method_call_cb(), processKeyEventForCEF(), webview_cef_plugin_class_init()] | lang=en
- "services_learning_sync": "learning_sync.dart" | kind=code-symbol | source=lib/services/learning_sync.dart:L1 | neighbors=[1393ac9 6th, 3b989f1 Bump version to 26.7.22+2026072…, 845dfcb feat: fast offline-speed initia…, 9535e64 k, a22f95b feat: complete celestial light …, LearningSync] | lang=en
- "slide_views_custom_html_view": "custom_html_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/custom_html_view.dart:L1 | neighbors=[3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 996d33b theme: migrate remaining small …, a22f95b feat: complete celestial light …, CustomHtmlView, _CustomHtmlViewState] | lang=en
- "widgets_real_progress_bar": "real_progress_bar.dart" | kind=code-symbol | source=lib/widgets/real_progress_bar.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, f23bb62 theme: migrate calibration/lear…, didUpdateWidget()] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@14e726335d4b4ab4007d1cbcfab1018504a03d43": "14e7263 feat: Quick Generate Module Notes with MathJax TeX rendering, mobile re…" | kind=Commit | source=git | neighbors=[0c1e4c0 chore: add Android builds v26.8…, main, e0cfdd0 chore: add Android builds v26.8…, module_notes_viewer_screen.dart, module_selection_screen.dart, section_selection_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@3b989f15e92476fbec1c4b445cca970877fecc7c": "3b989f1 Bump version to 26.7.22+2026072201, fix concept split view, and expand …" | kind=Commit | source=git | neighbors=[main, eb38f80 Fix Linux quit handling, Linux …, ai_providers_screen.dart, settings_screen.dart, database_service.dart, learning_sync.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@7b676e415d5a01596bc69e102471c71bd8061465": "7b676e4 v26.8.12: Update latest.md, version name to 26.8.12 and increment versi…" | kind=Commit | source=git | neighbors=[main, a411ccb docs: Update flow-research agri…, main.dart, home_widget_service.dart, notification_service.dart, progress_service.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@7f9ff8ec46d856ec2a12fe88ff4c520104d7234d": "7f9ff8e io" | kind=Commit | source=git | neighbors=[main, 0a59fe5 Merge pull request #4 from ihja…, app_models.dart, book_dashboard_screen.dart, generate_book_screen.dart, source_pdf_upload_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@893832526ae559a24d897ea7881f29813a5d8b30": "8938325 feat: layout-based course progress bars and secured Firestore API keys" | kind=Commit | source=git | neighbors=[5f9d253 chore: add Android builds v26.7…, main, 269329e chore: add Android builds v26.7…, module_selection_screen.dart, section_selection_screen.dart, settings_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@e9979c0e2cfdf4ed9422670f60d295e2b45fe747": "e9979c0 rebrand: rename app display name to Sirius" | kind=Commit | source=git | neighbors=[d361f24 chore: add Android builds v26.7…, main, 573536b rebrand: new Sirius black-hole …, main.dart, onboarding_screen.dart, my_application.h] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@f2613a948e4410b981d61468ff4a1a72e9f76e36": "f2613a9 theme: celestial palette with light + dark support" | kind=Commit | source=git | neighbors=[573536b rebrand: new Sirius black-hole …, main, 99745d3 theme: migrate GlassyNavBar and…, main.dart, book_dashboard_screen.dart, generate_book_screen.dart] | lang=en
- "common_webview_js_handler": "webview_js_handler.h" | kind=code-symbol | source=packages/webview_cef/common/webview_js_handler.h:L1 | neighbors=[CallCppFunction(), CefJSBridge(), CefJSHandler(), ConvertCefV8ValueToJSValue(), EvaluateCallback(), Execute()] | lang=en
- "screens_generate_qp_screen": "generate_qp_screen.dart" | kind=code-symbol | source=lib/screens/generate_qp_screen.dart:L1 | neighbors=[039f2fe theme: migrate generate_qp, pdf…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …, dispose()] | lang=en
- "screens_pyq_complete_screen": "pyq_complete_screen.dart" | kind=code-symbol | source=lib/screens/pyq_complete_screen.dart:L1 | neighbors=[1393ac9 6th, 2934308 theme: migrate metacognition_se…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 5621c28 v26.8.8: Integrated SeriousPyth…, a15c42e feat(daily-goals): Add Gamified…] | lang=en
- "services_auto_index_pipeline": "auto_index_pipeline.dart" | kind=code-symbol | source=lib/services/auto_index_pipeline.dart:L1 | neighbors=[4337110 feat: remove AI 10-page chunk s…, a22f95b feat: complete celestial light …, AutoIndexPipeline, AutoIndexResult, _chapter1FromLinks(), _finish()] | lang=en
- "services_auto_index_service": "auto_index_service.dart" | kind=code-symbol | source=lib/services/auto_index_service.dart:L1 | neighbors=[4337110 feat: remove AI 10-page chunk s…, 8554e22 feat: the web build compiles an…, a08a7bd FIX #1, a22f95b feat: complete celestial light …, AutoIndexService, _collectBookmarks()] | lang=en
- "services_page_mapping": "page_mapping.dart" | kind=code-symbol | source=lib/services/page_mapping.dart:L1 | neighbors=[a22f95b feat: complete celestial light …, ed71b03 io, chooseEffectiveOffset(), computeOffset(), _enforceIncreasing(), _fillMissingStarts()] | lang=en
- "widgets_floating_daily_goal_toast": "floating_daily_goal_toast.dart" | kind=code-symbol | source=lib/widgets/floating_daily_goal_toast.dart:L1 | neighbors=[a15c42e feat(daily-goals): Add Gamified…, _dismiss(), dispose(), FloatingDailyGoalListener, _FloatingDailyGoalListenerState, FloatingDailyGoalToast] | lang=en

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-003.json

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
