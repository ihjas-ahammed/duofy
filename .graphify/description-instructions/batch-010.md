# Node Description Batch 11 of 61

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
Write every description in Portuguese (pt). Do not switch languages.
No marketing language.
Respond ONLY with a JSON object mapping each node id (as a string) to its
one-sentence description — no prose, no markdown fences.

- "commit:repo:github.com/ihjas-ahammed/duofy@d277e5543e8c9b5d05abafe8a4d115d03a60d9a8": "d277e55 chore: add Android builds v27.0.0 [skip ci]" | kind=Commit | source=git | neighbors=[64cd7e0 XA, main, a08a7bd FIX #1]
- "commit:repo:github.com/ihjas-ahammed/duofy@d55a1baed230e2aa39afafc80f430e8b3c2df8d8": "d55a1ba chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[75e16eb ok, main, 4ea21ab fix: loadPyodide loading timing…]
- "commit:repo:github.com/ihjas-ahammed/duofy@da201f8317b5fde2537d01c53aa71d9b53ac2970": "da201f8 chore: add Android builds v26.7.25 [skip ci]" | kind=Commit | source=git | neighbors=[348ad55 fx g, main, 7be050f Merge branch 'main' of https://…]
- "commit:repo:github.com/ihjas-ahammed/duofy@da7e93cd83c5a7600345c85efdc459e0dbaf915a": "da7e93c Merge branch 'main' of https://github.com/ihjas-ahammed/duofy" | kind=Commit | source=git | neighbors=[main, c476ed9 555555555555555555555555555upp, b807fe5 sd]
- "commit:repo:github.com/ihjas-ahammed/duofy@de5fd9a195530b85efaacab53556b372ef448991": "de5fd9a chore: add Android builds v26.7.25 [skip ci]" | kind=Commit | source=git | neighbors=[a22f95b feat: complete celestial light …, main, 12bf472 feat(release): overhaul PYQ tab…]
- "commit:repo:github.com/ihjas-ahammed/duofy@df113f4d35a6ccb73fa77ec5bb61b83e20728e84": "df113f4 chore: add Android builds v26.7.22 [skip ci]" | kind=Commit | source=git | neighbors=[1dc8e69 fix(python & flashcard): fix An…, main, d7af759 feat(release & python): add rel…]
- "commit:repo:github.com/ihjas-ahammed/duofy@e0b1be47b07a82d0088505250166c1b5fb661d31": "e0b1be4 fix1" | kind=Commit | source=git | neighbors=[3fb655e chore: update knowledge graph a…, main, 5608612 chore: add Android and Windows …]
- "commit:repo:github.com/ihjas-ahammed/duofy@e0cfdd09f818f63230e09bba4f0808237c90bebe": "e0cfdd0 chore: add Android builds v26.8.7 [skip ci]" | kind=Commit | source=git | neighbors=[14e7263 feat: Quick Generate Module Not…, main, 5621c28 v26.8.8: Integrated SeriousPyth…]
- "commit:repo:github.com/ihjas-ahammed/duofy@e18a31ce3e95325fe0366f4813529f940607e0bd": "e18a31c chore: add Android builds v26.7.22 [skip ci]" | kind=Commit | source=git | neighbors=[2d60cdb feat: add AI provider model tes…, main, 8a51c13 fix(python & formats): disable …]
- "commit:repo:github.com/ihjas-ahammed/duofy@f25268e8e53cbe86dd1dc477fab94d5d116df7be": "f25268e chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[b99cbf3 OK, main, 9d1d7bc NAA]
- "commit:repo:github.com/ihjas-ahammed/duofy@f2b17bb161d4a4503e930a159f1a2c07221d2b72": "f2b17bb chore: add Android builds v26.7.10 [skip ci]" | kind=Commit | source=git | neighbors=[7dbab59 Merge pull request #2 from ihja…, main, 4ea5161 Merge pull request #3 from ihja…]
- "commit:repo:github.com/ihjas-ahammed/duofy@f916a64b1835597f159ce094cfa1a7d170713c2c": "f916a64 chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[4ea21ab fix: loadPyodide loading timing…, main, ea4994a Support program & try_yourself …]
- "commit:repo:github.com/ihjas-ahammed/duofy@f9191cfaca514d7471307b04e7758c76ef57de2c": "f9191cf chore: add Android builds v26.7.28 [skip ci]" | kind=Commit | source=git | neighbors=[845dfcb feat: fast offline-speed initia…, main, ea88f41 Farsan]
- "common_webview_handler_getcallbackid": "GetCallbackId()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L597 | neighbors=[webview_handler.h, executeJavaScript(), to_string()]
- "common_webview_handler_onloaderror": "OnLoadError()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L198 | neighbors=[webview_handler.h, GetDataURI(), IsChromeRuntimeEnabled()]
- "common_webview_handler_to_string": "to_string()" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.cc:L29 | neighbors=[webview_handler.h, GetCallbackId(), OnProcessMessageReceived()]
- "common_webview_value_webview_ptr_array_add": "webview_ptr_array_add()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L111 | neighbors=[webview_value.h, webview_value_append_take(), webview_value_set_take()]
- "common_webview_value_webview_ptr_array_new_with_free_func": "webview_ptr_array_new_with_free_func()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L86 | neighbors=[webview_value.h, webview_value_new_list(), webview_value_new_map()]
- "common_webview_value_webview_ptr_array_unref": "webview_ptr_array_unref()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L105 | neighbors=[webview_value.h, webview_ptr_array_free(), webview_value_unref()]
- "common_webview_value_webview_value_append": "webview_value_append()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L532 | neighbors=[webview_value.h, webview_value_append_take(), webview_value_ref()]
- "common_webview_value_webview_value_append_take": "webview_value_append_take()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L522 | neighbors=[webview_value.h, webview_value_append(), webview_ptr_array_add()]
- "common_webview_value_webview_value_destroy": "webview_value_destroy()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L163 | neighbors=[webview_value.h, webview_value_unref(), webview_value_set_take()]
- "common_webview_value_webview_value_get_bool": "webview_value_get_bool()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L579 | neighbors=[webview_value.h, webview_value_equals(), webview_value_to_string()]
- "common_webview_value_webview_value_get_double": "webview_value_get_double()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L600 | neighbors=[webview_value.h, webview_value_equals(), webview_value_to_string()]
- "common_webview_value_webview_value_get_double_list": "webview_value_get_double_list()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L642 | neighbors=[webview_value.h, webview_value_equals(), webview_value_to_string()]
- "common_webview_value_webview_value_get_float": "webview_value_get_float()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L593 | neighbors=[webview_value.h, webview_value_equals(), webview_value_to_string()]
- "common_webview_value_webview_value_get_float_list": "webview_value_get_float_list()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L635 | neighbors=[webview_value.h, webview_value_equals(), webview_value_to_string()]
- "common_webview_value_webview_value_get_int": "webview_value_get_int()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L586 | neighbors=[webview_value.h, webview_value_equals(), webview_value_to_string()]
- "common_webview_value_webview_value_get_int32_list": "webview_value_get_int32_list()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L621 | neighbors=[webview_value.h, webview_value_equals(), webview_value_to_string()]
- "common_webview_value_webview_value_get_int64_list": "webview_value_get_int64_list()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L628 | neighbors=[webview_value.h, webview_value_equals(), webview_value_to_string()]
- "common_webview_value_webview_value_get_map_key": "webview_value_get_map_key()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L736 | neighbors=[webview_value.h, webview_ptr_array_index(), webview_value_to_string()]
- "common_webview_value_webview_value_get_uint8_list": "webview_value_get_uint8_list()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L614 | neighbors=[webview_value.h, webview_value_equals(), webview_value_to_string()]
- "common_webview_value_webview_value_new_list": "webview_value_new_list()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L270 | neighbors=[webview_value.h, webview_ptr_array_new_with_free_func(), webview_value_new()]
- "common_webview_value_webview_value_new_map": "webview_value_new_map()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L277 | neighbors=[webview_value.h, webview_ptr_array_new_with_free_func(), webview_value_new()]
- "common_webview_value_webview_value_set": "webview_value_set()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L561 | neighbors=[webview_value.h, webview_value_ref(), webview_value_set_take()]
- "lib_webview_cef_platform_interface": "webview_cef_platform_interface.dart" | kind=code-symbol | source=packages/webview_cef/lib/webview_cef_platform_interface.dart:L1 | neighbors=[getPlatformVersion(), that, WebviewCefPlatform]
- "linux_webview_cef_plugin_encode_wavlue_to_flvalue": "encode_wavlue_to_flvalue()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_plugin.cc:L60 | neighbors=[webview_cef_plugin.cc, webview_cef_plugin_handle_method_call(), webview_cef_plugin_register_with_regist…]
- "models_daily_goal": "daily_goal.dart" | kind=code-symbol | source=lib/models/daily_goal.dart:L1 | neighbors=[a15c42e feat(daily-goals): Add Gamified…, DailyGoal, DailyGoalUpdateEvent]
- "packup_is_likely_binary_file": "is_likely_binary_file()" | kind=code-symbol | source=packup.py:L162 | neighbors=[packup.py, pack_project(), Checks if a file is likely binary based…]
- "packup_load_gitignore_patterns": "load_gitignore_patterns()" | kind=code-symbol | source=packup.py:L56 | neighbors=[packup.py, pack_project(), Loads patterns from .gitignore file in …]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-010.json

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
