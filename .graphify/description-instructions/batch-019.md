# Node Description Batch 20 of 61

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

- "lib_main_synccurrentbrightness": "_syncCurrentBrightness()" | kind=code-symbol | source=lib/main.dart:L524 | neighbors=[main.dart]
- "lib_webview_cef_method_channel_getplatformversion": "getPlatformVersion()" | kind=code-symbol | source=packages/webview_cef/lib/webview_cef_method_channel.dart:L13 | neighbors=[webview_cef_method_channel.dart]
- "lib_webview_cef_method_channel_methodchannelwebviewcef": "MethodChannelWebviewCef" | kind=code-symbol | source=packages/webview_cef/lib/webview_cef_method_channel.dart:L7 | neighbors=[webview_cef_method_channel.dart]
- "lib_webview_cef_platform_interface_getplatformversion": "getPlatformVersion()" | kind=code-symbol | source=packages/webview_cef/lib/webview_cef_platform_interface.dart:L26 | neighbors=[webview_cef_platform_interface.dart]
- "lib_webview_cef_platform_interface_that": "that" | kind=code-symbol | source=packages/webview_cef/lib/webview_cef_platform_interface.dart:L19 | neighbors=[webview_cef_platform_interface.dart]
- "lib_webview_cef_platform_interface_webviewcefplatform": "WebviewCefPlatform" | kind=code-symbol | source=packages/webview_cef/lib/webview_cef_platform_interface.dart:L5 | neighbors=[webview_cef_platform_interface.dart]
- "linux_main": "main.cc" | kind=code-symbol | source=packages/webview_cef/example/linux/main.cc:L1 | neighbors=[main()]
- "linux_main_main": "main()" | kind=code-symbol | source=packages/webview_cef/example/linux/main.cc:L4 | neighbors=[main.cc]
- "linux_my_application_my_application_activate": "my_application_activate()" | kind=code-symbol | source=packages/webview_cef/example/linux/my_application.cc:L19 | neighbors=[my_application.h]
- "linux_my_application_my_application_class_init": "my_application_class_init()" | kind=code-symbol | source=packages/webview_cef/example/linux/my_application.cc:L94 | neighbors=[my_application.h]
- "linux_my_application_my_application_dispose": "my_application_dispose()" | kind=code-symbol | source=packages/webview_cef/example/linux/my_application.cc:L88 | neighbors=[my_application.h]
- "linux_my_application_my_application_init": "my_application_init()" | kind=code-symbol | source=packages/webview_cef/example/linux/my_application.cc:L100 | neighbors=[my_application.h]
- "linux_my_application_my_application_local_command_line": "my_application_local_command_line()" | kind=code-symbol | source=packages/webview_cef/example/linux/my_application.cc:L69 | neighbors=[my_application.h]
- "linux_my_application_my_application_new": "my_application_new()" | kind=code-symbol | source=packages/webview_cef/example/linux/my_application.cc:L102 | neighbors=[my_application.h]
- "linux_webview_cef_keyevent_getcefstatemodifiers": "GetCefStateModifiers()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_keyevent.h:L778 | neighbors=[webview_cef_keyevent.h]
- "linux_webview_cef_keyevent_getcontrolcharacter": "GetControlCharacter()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_keyevent.h:L808 | neighbors=[webview_cef_keyevent.h]
- "linux_webview_cef_keyevent_getwindowskeycodewithoutlocation": "GetWindowsKeyCodeWithoutLocation()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_keyevent.h:L762 | neighbors=[webview_cef_keyevent.h]
- "linux_webview_cef_plugin_initcefprocesses": "initCEFProcesses()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_plugin.cc:L292 | neighbors=[webview_cef_plugin.cc]
- "linux_webview_cef_plugin_processkeyeventforcef": "processKeyEventForCEF()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_plugin.cc:L298 | neighbors=[webview_cef_plugin.cc]
- "linux_webview_cef_plugin_webview_cef_plugin_class_init": "webview_cef_plugin_class_init()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_plugin.cc:L243 | neighbors=[webview_cef_plugin.cc]
- "linux_webview_cef_plugin_webview_cef_plugin_dispose": "webview_cef_plugin_dispose()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_plugin.cc:L233 | neighbors=[webview_cef_plugin.cc]
- "linux_webview_cef_plugin_webview_cef_plugin_init": "webview_cef_plugin_init()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_plugin.cc:L248 | neighbors=[webview_cef_plugin.cc]
- "linux_webview_cef_plugin_webviewtexturerenderer_webviewtexturerenderer": ".WebviewTextureRenderer()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_plugin.cc:L32 | neighbors=[WebviewTextureRenderer]
- "linux_webview_cef_texture_webview_cef_texture_class_init": "webview_cef_texture_class_init()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_texture.h:L51 | neighbors=[webview_cef_texture.h]
- "linux_webview_cef_texture_webview_cef_texture_copy_pixels": "webview_cef_texture_copy_pixels()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_texture.h:L25 | neighbors=[webview_cef_texture.h]
- "linux_webview_cef_texture_webview_cef_texture_init": "webview_cef_texture_init()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_texture.h:L55 | neighbors=[webview_cef_texture.h]
- "linux_webview_cef_texture_webview_cef_texture_new": "webview_cef_texture_new()" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_texture.h:L47 | neighbors=[webview_cef_texture.h]
- "models_ai_task_aitask": "AiTask" | kind=code-symbol | source=lib/models/ai_task.dart:L3 | neighbors=[ai_task.dart]
- "models_app_models_book": "Book" | kind=code-symbol | source=lib/models/app_models.dart:L846 | neighbors=[app_models.dart]
- "models_app_models_bool": "_bool()" | kind=code-symbol | source=lib/models/app_models.dart:L24 | neighbors=[app_models.dart]
- "models_app_models_copywith": "copyWith" | kind=code-symbol | source=lib/models/app_models.dart:L1683 | neighbors=[app_models.dart]
- "models_app_models_coursefolder": "CourseFolder" | kind=code-symbol | source=lib/models/app_models.dart:L2590 | neighbors=[app_models.dart]
- "models_app_models_getcompletedlessonsuptosection": "getCompletedLessonsUpToSection()" | kind=code-symbol | source=lib/models/app_models.dart:L1323 | neighbors=[app_models.dart]
- "models_app_models_getestimatedlessonsforsection": "getEstimatedLessonsForSection()" | kind=code-symbol | source=lib/models/app_models.dart:L1218 | neighbors=[app_models.dart]
- "models_app_models_getestimatedlessonsuptosection": "getEstimatedLessonsUpToSection()" | kind=code-symbol | source=lib/models/app_models.dart:L1251 | neighbors=[app_models.dart]
- "models_app_models_getestimatedunitsforsection": "getEstimatedUnitsForSection()" | kind=code-symbol | source=lib/models/app_models.dart:L1178 | neighbors=[app_models.dart]
- "models_app_models_hasprogrammingslidesorname": "hasProgrammingSlidesOrName()" | kind=code-symbol | source=lib/models/app_models.dart:L951 | neighbors=[app_models.dart]
- "models_app_models_interactivestep": "InteractiveStep" | kind=code-symbol | source=lib/models/app_models.dart:L2149 | neighbors=[app_models.dart]
- "models_app_models_isprogrammingcourse": "isProgrammingCourse()" | kind=code-symbol | source=lib/models/app_models.dart:L939 | neighbors=[app_models.dart]
- "models_app_models_lesson": "Lesson" | kind=code-symbol | source=lib/models/app_models.dart:L1982 | neighbors=[app_models.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-019.json

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
