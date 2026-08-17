# Node Description Batch 22 of 61

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

- "platform_io_stub_directory": "Directory" | kind=code-symbol | source=lib/platform/io_stub.dart:L100 | neighbors=[io_stub.dart]
- "platform_io_stub_exists": "exists()" | kind=code-symbol | source=lib/platform/io_stub.dart:L35 | neighbors=[io_stub.dart]
- "platform_io_stub_existssync": "existsSync()" | kind=code-symbol | source=lib/platform/io_stub.dart:L36 | neighbors=[io_stub.dart]
- "platform_io_stub_file": "File" | kind=code-symbol | source=lib/platform/io_stub.dart:L43 | neighbors=[io_stub.dart]
- "platform_io_stub_filesystementity": "FileSystemEntity" | kind=code-symbol | source=lib/platform/io_stub.dart:L33 | neighbors=[io_stub.dart]
- "platform_io_stub_filesystemexception": "FileSystemException" | kind=code-symbol | source=lib/platform/io_stub.dart:L151 | neighbors=[io_stub.dart]
- "platform_io_stub_function": "Function()" | kind=code-symbol | source=lib/platform/io_stub.dart:L183 | neighbors=[io_stub.dart]
- "platform_io_stub_httpexception": "HttpException" | kind=code-symbol | source=lib/platform/io_stub.dart:L168 | neighbors=[io_stub.dart]
- "platform_io_stub_ioexception": "IOException" | kind=code-symbol | source=lib/platform/io_stub.dart:L159 | neighbors=[io_stub.dart]
- "platform_io_stub_isdirectory": "isDirectory()" | kind=code-symbol | source=lib/platform/io_stub.dart:L39 | neighbors=[io_stub.dart]
- "platform_io_stub_isfile": "isFile()" | kind=code-symbol | source=lib/platform/io_stub.dart:L40 | neighbors=[io_stub.dart]
- "platform_io_stub_lastmodified": "lastModified()" | kind=code-symbol | source=lib/platform/io_stub.dart:L89 | neighbors=[io_stub.dart]
- "platform_io_stub_length": "length()" | kind=code-symbol | source=lib/platform/io_stub.dart:L87 | neighbors=[io_stub.dart]
- "platform_io_stub_lengthsync": "lengthSync()" | kind=code-symbol | source=lib/platform/io_stub.dart:L88 | neighbors=[io_stub.dart]
- "platform_io_stub_platform": "Platform" | kind=code-symbol | source=lib/platform/io_stub.dart:L18 | neighbors=[io_stub.dart]
- "platform_io_stub_process": "Process" | kind=code-symbol | source=lib/platform/io_stub.dart:L142 | neighbors=[io_stub.dart]
- "platform_io_stub_processresult": "ProcessResult" | kind=code-symbol | source=lib/platform/io_stub.dart:L134 | neighbors=[io_stub.dart]
- "platform_io_stub_readasbytes": "readAsBytes()" | kind=code-symbol | source=lib/platform/io_stub.dart:L66 | neighbors=[io_stub.dart]
- "platform_io_stub_readasstring": "readAsString()" | kind=code-symbol | source=lib/platform/io_stub.dart:L68 | neighbors=[io_stub.dart]
- "platform_io_stub_readasstringsync": "readAsStringSync()" | kind=code-symbol | source=lib/platform/io_stub.dart:L70 | neighbors=[io_stub.dart]
- "platform_io_stub_rename": "rename()" | kind=code-symbol | source=lib/platform/io_stub.dart:L86 | neighbors=[io_stub.dart]
- "platform_io_stub_run": "run()" | kind=code-symbol | source=lib/platform/io_stub.dart:L144 | neighbors=[io_stub.dart]
- "platform_io_stub_socketexception": "SocketException" | kind=code-symbol | source=lib/platform/io_stub.dart:L161 | neighbors=[io_stub.dart]
- "platform_io_stub_tostring": "toString()" | kind=code-symbol | source=lib/platform/io_stub.dart:L156 | neighbors=[io_stub.dart]
- "platform_io_stub_websocket": "WebSocket" | kind=code-symbol | source=lib/platform/io_stub.dart:L177 | neighbors=[io_stub.dart]
- "platform_io_stub_writeasbytes": "writeAsBytes()" | kind=code-symbol | source=lib/platform/io_stub.dart:L74 | neighbors=[io_stub.dart]
- "platform_io_stub_writeasbytessync": "writeAsBytesSync()" | kind=code-symbol | source=lib/platform/io_stub.dart:L77 | neighbors=[io_stub.dart]
- "platform_io_stub_writeasstring": "writeAsString()" | kind=code-symbol | source=lib/platform/io_stub.dart:L79 | neighbors=[io_stub.dart]
- "platform_io_stub_writeasstringsync": "writeAsStringSync()" | kind=code-symbol | source=lib/platform/io_stub.dart:L82 | neighbors=[io_stub.dart]
- "python_app_main": "main.py" | kind=code-symbol | source=python_app/main.py:L1 | neighbors=[5621c28 v26.8.8: Integrated SeriousPyth…]
- "runner_flutter_window_flutterwindow": "FlutterWindow()" | kind=code-symbol | source=windows/runner/flutter_window.h:L12 | neighbors=[flutter_window.h]
- "runner_flutter_window_messagehandler": "MessageHandler()" | kind=code-symbol | source=windows/runner/flutter_window.cpp:L50 | neighbors=[flutter_window.h]
- "runner_flutter_window_oncreate": "OnCreate()" | kind=code-symbol | source=windows/runner/flutter_window.cpp:L12 | neighbors=[flutter_window.h]
- "runner_flutter_window_ondestroy": "OnDestroy()" | kind=code-symbol | source=windows/runner/flutter_window.cpp:L42 | neighbors=[flutter_window.h]
- "runner_main_main": "main()" | kind=code-symbol | source=linux/runner/main.cc:L5 | neighbors=[main.cpp]
- "runner_main_wwinmain": "wWinMain()" | kind=code-symbol | source=windows/runner/main.cpp:L8 | neighbors=[main.cpp]
- "runner_my_application_first_frame_cb": "first_frame_cb()" | kind=code-symbol | source=linux/runner/my_application.cc:L19 | neighbors=[my_application.h]
- "runner_my_application_my_application_activate": "my_application_activate()" | kind=code-symbol | source=linux/runner/my_application.cc:L24 | neighbors=[my_application.h]
- "runner_my_application_my_application_class_init": "my_application_class_init()" | kind=code-symbol | source=linux/runner/my_application.cc:L133 | neighbors=[my_application.h]
- "runner_my_application_my_application_dispose": "my_application_dispose()" | kind=code-symbol | source=linux/runner/my_application.cc:L127 | neighbors=[my_application.h]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-021.json

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
