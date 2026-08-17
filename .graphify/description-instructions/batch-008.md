# Node Description Batch 9 of 61

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
- "test_python_runner_test": "python_runner_test.dart" | kind=code-symbol | source=test/python_runner_test.dart:L1 | neighbors=[37cdd6b Support interactive Python inpu…, eb38f80 Fix Linux quit handling, Linux …, invalid_syntax(), main()] | lang=en
- "widgets_daily_goals_complete_card": "daily_goals_complete_card.dart" | kind=code-symbol | source=lib/widgets/daily_goals_complete_card.dart:L1 | neighbors=[a15c42e feat(daily-goals): Add Gamified…, DailyGoalsCompleteCard, _DailyGoalsCompleteCardState, initState()] | lang=en
- "windows_webview_cef_plugin_handlemethodcall": "HandleMethodCall()" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_plugin.cpp:L258 | neighbors=[webview_cef_plugin.h, encode_flvalue_to_wvalue(), encode_wvalue_to_flvalue(), RegisterWithRegistrar()] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@00fdc1aa53994a322a854c47a419067f08997e70": "00fdc1a chore: add Android builds v26.7.12 [skip ci]" | kind=Commit | source=git | neighbors=[main, 11cc12c feat: cumulative sequential dea…, c04f5ba fix: resolve static analyzer in…] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@010c32d02d88bd6695ac1b72df5efceb9557f83c": "010c32d chore: add Android and Windows builds v26.6.30 [skip ci]" | kind=Commit | source=git | neighbors=[main, 693d260 GRAPHYFI FIX, 2dfddb1 z] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@05a15cd03bcdc85bb0dfb94006b041dca733913c": "05a15cd chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[main, 67b95db OK, 274559d Merge branch 'main' of https://…] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@061977c28bb3f79db86b1b99685cf8ca80ee97c9": "061977c chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[main, 4ead8b6 z, 317ac5d Merge branch 'main' of https://…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@06c076ecdd64fe4e8b89daee7fd7fa840a4f1ecc": "06c076e chore: add Android builds v26.7.10 [skip ci]" | kind=Commit | source=git | neighbors=[main, 3cff7f6 REALLY!, 0a59fe5 Merge pull request #4 from ihja…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@077461072e581570e421351b507f645bf6310e76": "0774610 Update graphify index for CMake site packages fix" | kind=Commit | source=git | neighbors=[main, 37cdd6b Support interactive Python inpu…, d19afe4 Fix serious_python_linux copyin…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@07c466580207ca4c576619e9a58a5ac301faa14f": "07c4665 chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[main, 274559d Merge branch 'main' of https://…, 9d1d7bc NAA] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@0c1e4c05f06e595cdfa05ee4b7393ba57690556c": "0c1e4c0 chore: add Android builds v26.8.6 [skip ci]" | kind=Commit | source=git | neighbors=[main, 14e7263 feat: Quick Generate Module Not…, df34d11 Fix latex, peace] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@0eaaf59f05af27a1f9a4183b30b3a956e3862f57": "0eaaf59 chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[main, 4c8673e OKKK, c71d757 orgainze apis] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@137f3293862fd11400f70d2f7a7e9f019a0be09f": "137f329 chore: add Android builds v26.7.22 [skip ci]" | kind=Commit | source=git | neighbors=[main, a22f95b feat: complete celestial light …, d7af759 feat(release & python): add rel…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@13b10dfe8bb41033e5ee598c9c9fbb06ba85d55b": "13b10df chore: add Android builds v27.0.0 [skip ci]" | kind=Commit | source=git | neighbors=[main, 7cb1aa6 RMY, a08a7bd FIX #1] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@18142cca164d02e24945f56a804012932b8e7c36": "18142cc chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[main, 1fa1705 OK, 4c8673e OKKK] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@1e1860b2daca90cc726d5ccce22b00563db2a65b": "1e1860b chore: add Android builds v26.7.12 [skip ci]" | kind=Commit | source=git | neighbors=[11cc12c feat: cumulative sequential dea…, main, 5d06f7a feat: implement Auto-Next lesso…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@2508966eeb5a9520769f76b4fb338cfa9aa69b61": "2508966 chore: add Android builds v26.7.12 [skip ci]" | kind=Commit | source=git | neighbors=[main, b5b2ecb fix: resolve incorrect deadline…, b59e77b fix: auto resolve sync conflict…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@269329e1f02f9395bfd0701867e0d3765aa01c3d": "269329e chore: add Android builds v26.7.12 [skip ci]" | kind=Commit | source=git | neighbors=[main, f782455 feat: implement target section …, 8938325 feat: layout-based course progr…] | lang=en

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
