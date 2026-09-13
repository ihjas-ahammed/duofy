# Node Description Batch 9 of 68

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

- "commit:repo:github.com/ihjas-ahammed/duofy@d361f24f296c431b931dd3adb299c1c7d33c5c31": "d361f24 chore: add Android builds v26.7.10 [skip ci]" | kind=Commit | source=git | neighbors=[main, 7dbab59 Merge pull request #2 from ihja…, e9979c0 rebrand: rename app display nam…, d68d72b XZ] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@d5b97ce691fdb039989ae583ba7af5a6164c7664": "d5b97ce theme: migrate book_dashboard_screen" | kind=Commit | source=git | neighbors=[9c0e7f3 theme: migrate safe_pdf_viewer,…, main, ef45a4f theme: migrate document_store_s…, book_dashboard_screen.dart] | lang=fr
- "commit:repo:github.com/ihjas-ahammed/duofy@d5c7c966ab702f553e9b3bdb7d5205e575094d17": "d5c7c96 theme: migrate generate_book_screen" | kind=Commit | source=git | neighbors=[main, d1dbb62 theme: migrate course_edit_stru…, generate_book_screen.dart, ef45a4f theme: migrate document_store_s…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@d7af759a21ebef9e11067468f259b0f94110a258": "d7af759 feat(release & python): add release.txt, update builds/latest.json, add…" | kind=Commit | source=git | neighbors=[main, 137f329 chore: add Android builds v26.7…, python_runner_service.dart, df113f4 chore: add Android builds v26.7…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@d843901af3fd62c2c959421cce8636085d2f2132": "d843901 theme: migrate ai_queue_screen" | kind=Commit | source=git | neighbors=[7976120 theme: migrate practice_screen, main, 2934308 theme: migrate metacognition_se…, ai_queue_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@e02893dec2071867e1e4822dd40d6920b69404ff": "e02893d ux: answer feedback and interaction polish in lessons" | kind=Commit | source=git | neighbors=[1322f3d ASZ, main, be9dc1e ux: confetti burst and XP count…, lesson_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@e6b51ae9239254930ffacdd7b02e3c85f08e72a7": "e6b51ae theme: migrate course_settings_screen" | kind=Commit | source=git | neighbors=[af53b52 theme: migrate pyq_tab_screen, main, f8116b9 theme: migrate summary_screen, course_settings_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@eb1723ae71839c568506848ec2b30b1f5d3a1539": "eb1723a fix: preserve Navigator result on LessonScreen replacement to support A…" | kind=Commit | source=git | neighbors=[6b3299a chore: add Android builds v26.7…, main, 4026742 chore: add Android builds v26.7…, lesson_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@ee65d46b13a584981788717ad0109bb688b007bb": "ee65d46 theme: migrate lesson_accordion" | kind=Commit | source=git | neighbors=[07c7464 theme: migrate lesson_path, main, 9280539 theme: migrate lesson_assistant…, lesson_accordion.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@ef45a4f6a790ee48f3a36eb40a9d3e71f3c31610": "ef45a4f theme: migrate document_store_screen" | kind=Commit | source=git | neighbors=[d5b97ce theme: migrate book_dashboard_s…, main, d5c7c96 theme: migrate generate_book_sc…, document_store_screen.dart] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@f6d94bfc80cd6576ac7834fc947b65f5461a3efa": "f6d94bf theme: migrate section_bottom_sheet" | kind=Commit | source=git | neighbors=[996d33b theme: migrate remaining small …, section_bottom_sheet.dart, main, 6a6426e theme: migrate module_selector,…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@f8116b963dfa1a81180c5d7fa2527e8231d64332": "f8116b9 theme: migrate summary_screen" | kind=Commit | source=git | neighbors=[e6b51ae theme: migrate course_settings_…, main, 6ed78cc theme: migrate pdf_split_previe…, summary_screen.dart] | lang=en
- "common_webview_cookievisitor": "webview_cookieVisitor.h" | kind=code-symbol | source=packages/webview_cef/common/webview_cookieVisitor.h:L1 | neighbors=[getVisitedCookies(), setOnVisitComplete(), Visit(), WebviewCookieVisitor()] | lang=en
- "common_webview_handler_executejavascript": "executeJavaScript()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L604 | neighbors=[webview_handler.h, GetCallbackId(), OnTakeFocus(), setJavaScriptChannels()] | lang=en
- "common_webview_value_webview_value_get_by_string": "webview_value_get_by_string()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L763 | neighbors=[webview_value.h, webview_value_get_by_key(), webview_value_new_string(), webview_value_unref()] | lang=en
- "common_webview_value_webview_value_get_key": "webview_value_get_key()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L718 | neighbors=[webview_value.h, webview_value_equals(), webview_ptr_array_index(), webview_value_lookup_index()] | lang=en
- "common_webview_value_webview_value_get_len": "webview_value_get_len()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L649 | neighbors=[webview_value.h, webview_value_equals(), webview_value_lookup_index(), webview_value_to_string()] | lang=en
- "common_webview_value_webview_value_get_list_value": "webview_value_get_list_value()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L710 | neighbors=[webview_value.h, webview_value_equals(), webview_ptr_array_index(), webview_value_to_string()] | lang=en
- "common_webview_value_webview_value_get_map_value": "webview_value_get_map_value()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L744 | neighbors=[webview_value.h, webview_value_get_by_key(), webview_ptr_array_index(), webview_value_to_string()] | lang=en
- "common_webview_value_webview_value_new_string": "webview_value_new_string()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L199 | neighbors=[webview_value.h, webview_value_get_by_string(), webview_value_new(), webview_value_set_string()] | lang=en
- "common_webview_value_webview_value_ref": "webview_value_ref()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L285 | neighbors=[webview_value.h, webview_value_append(), webview_value_set(), webview_value_set_string()] | lang=en
- "common_webview_value_webview_value_set_string": "webview_value_set_string()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L570 | neighbors=[webview_value.h, webview_value_new_string(), webview_value_ref(), webview_value_set_take()] | lang=en
- "common_webview_value_webview_value_unref": "webview_value_unref()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L291 | neighbors=[webview_value.h, webview_value_destroy(), webview_value_get_by_string(), webview_ptr_array_unref()] | lang=en
- "flutter_generated_plugin_registrant": "generated_plugin_registrant.h" | kind=code-symbol | source=windows/flutter/generated_plugin_registrant.h:L1 | neighbors=[9864444 feat: onboarding walkthrough, a…, eb38f80 Fix Linux quit handling, Linux …, fl_register_plugins(), RegisterPlugins()] | lang=en
- "linux_webview_cef_plugin_webview_cef_plugin_handle_method_call": "webview_cef_plugin_handle_method_call()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_plugin.cc:L211 | neighbors=[webview_cef_plugin.cc, method_call_cb(), encode_flvalue_to_wvalue(), encode_wavlue_to_flvalue()] | lang=en
- "linux_webview_cef_texture": "webview_cef_texture.h" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_texture.h:L1 | neighbors=[webview_cef_texture_class_init(), webview_cef_texture_copy_pixels(), webview_cef_texture_init(), webview_cef_texture_new()] | lang=en
- "models_ai_task": "ai_task.dart" | kind=code-symbol | source=lib/models/ai_task.dart:L1 | neighbors=[4337110 feat: remove AI 10-page chunk s…, a22f95b feat: complete celestial light …, d6812c1 feat: add Run now quick-run for…, AiTask] | lang=en
- "models_pyq_models": "pyq_models.dart" | kind=code-symbol | source=lib/models/pyq_models.dart:L1 | neighbors=[bccabe4 pyq_meta all set, PyqExamAttempt, PyqItem, PyqQuestionAnswer] | lang=en
- "packup": "packup.py" | kind=code-symbol | source=packup.py:L1 | neighbors=[is_likely_binary_file(), load_gitignore_patterns(), pack_project(), should_ignore()] | lang=en
- "runner_flutter_window": "flutter_window.h" | kind=code-symbol | source=windows/runner/flutter_window.h:L1 | neighbors=[FlutterWindow(), MessageHandler(), OnCreate(), OnDestroy()] | lang=en
- "runner_win32_window_win32window_wndproc": "Win32Window::WndProc()" | kind=code-symbol | source=windows/runner/win32_window.cpp:L157 | neighbors=[win32_window.h, EnableFullDpiSupportIfAvailable(), GetThisFromHandle(), MessageHandler()] | lang=en
- "screens_auth_gate": "auth_gate.dart" | kind=code-symbol | source=lib/screens/auth_gate.dart:L1 | neighbors=[845dfcb feat: fast offline-speed initia…, 859f766 new, 9864444 feat: onboarding walkthrough, a…, AuthGate] | lang=en
- "slide_views_slide_action_button": "slide_action_button.dart" | kind=code-symbol | source=lib/widgets/slide_views/slide_action_button.dart:L1 | neighbors=[1c58056 feat(release): v26.8.31 - Compl…, _handleTapUp(), SlideActionButton, _SlideActionButtonState] | lang=en
- "test_canvas_html_eval_test": "canvas_html_eval_test.dart" | kind=code-symbol | source=test/canvas_html_eval_test.dart:L1 | neighbors=[a292b18 feat: instant update check cach…, draw(), main(), sketch()] | lang=en
- "test_python_runner_test": "python_runner_test.dart" | kind=code-symbol | source=test/python_runner_test.dart:L1 | neighbors=[37cdd6b Support interactive Python inpu…, eb38f80 Fix Linux quit handling, Linux …, invalid_syntax(), main()] | lang=en
- "widgets_daily_goals_complete_card": "daily_goals_complete_card.dart" | kind=code-symbol | source=lib/widgets/daily_goals_complete_card.dart:L1 | neighbors=[a15c42e feat(daily-goals): Add Gamified…, DailyGoalsCompleteCard, _DailyGoalsCompleteCardState, initState()] | lang=en
- "widgets_global_error_capture_layer": "global_error_capture_layer.dart" | kind=code-symbol | source=lib/widgets/global_error_capture_layer.dart:L1 | neighbors=[859f766 new, e52e844 feat(release): v26.8.27 - LaTeX…, GlobalErrorCaptureLayer, _GlobalErrorCaptureLayerState] | lang=en
- "windows_webview_cef_plugin_handlemethodcall": "HandleMethodCall()" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_plugin.cpp:L258 | neighbors=[webview_cef_plugin.h, encode_flvalue_to_wvalue(), encode_wvalue_to_flvalue(), RegisterWithRegistrar()] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@00fdc1aa53994a322a854c47a419067f08997e70": "00fdc1a chore: add Android builds v26.7.12 [skip ci]" | kind=Commit | source=git | neighbors=[main, 11cc12c feat: cumulative sequential dea…, c04f5ba fix: resolve static analyzer in…] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@010c32d02d88bd6695ac1b72df5efceb9557f83c": "010c32d chore: add Android and Windows builds v26.6.30 [skip ci]" | kind=Commit | source=git | neighbors=[main, 693d260 GRAPHYFI FIX, 2dfddb1 z] | lang=en

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-008.json

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
