# Node Description Batch 68 of 68

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

- "windows_webview_cef_plugin_webview_cef": "webview_cef()" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_plugin.h:L10 | neighbors=[webview_cef_plugin.h]
- "windows_webview_cef_plugin_webviewcefplugin": "WebviewCefPlugin()" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_plugin.cpp:L245 | neighbors=[webview_cef_plugin.h]
- "windows_webview_cef_plugin_webviewtexturerenderer_webviewtexturerenderer": ".WebviewTextureRenderer()" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_plugin.cpp:L22 | neighbors=[WebviewTextureRenderer]
- "classes_cef_bridge": "cef_bridge.cc" | kind=code-symbol | source=packages/webview_cef/macos/Classes/cef_bridge.cc:L1
- "classes_cefwrapper": "CefWrapper.h" | kind=code-symbol | source=packages/webview_cef/macos/Classes/CefWrapper.h:L1
- "classes_webviewcefplugin": "WebviewCefPlugin.h" | kind=code-symbol | source=packages/webview_cef/macos/Classes/WebviewCefPlugin.h:L1
- "disable_keyboard": "disable-keyboard.py" | kind=code-symbol | source=disable-keyboard.py:L1
- "lib_webview_cef": "webview_cef.dart" | kind=code-symbol | source=packages/webview_cef/lib/webview_cef.dart:L1
- "runner_resource": "resource.h" | kind=code-symbol | source=windows/runner/resource.h:L1
- "runner_runner_bridging_header": "Runner-Bridging-Header.h" | kind=code-symbol | source=ios/Runner/Runner-Bridging-Header.h:L1
- "webview_cef_webview_cef_plugin": "webview_cef_plugin.h" | kind=code-symbol | source=packages/webview_cef/linux/include/webview_cef/webview_cef_plugin.h:L1
- "webview_cef_webview_cef_plugin_c_api": "webview_cef_plugin_c_api.h" | kind=code-symbol | source=packages/webview_cef/windows/include/webview_cef/webview_cef_plugin_c_api.h:L1

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-067.json

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
