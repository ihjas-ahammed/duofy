# Node Description Batch 19 of 61

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

- "ide_latex_ide_screen_show": "show()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1711 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_showcompilationerrordialog": "_showCompilationErrorDialog()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L741 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_showlogsmodalsheet": "_showLogsModalSheet()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1405 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_switchview": "switchView()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1254 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_triggercompileandopenpdf": "triggerCompileAndOpenPdf()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1110 | neighbors=[latex_ide_screen.dart]
- "ide_python_notebook_screen_addcell": "_addCell()" | kind=code-symbol | source=lib/screens/ide/python_notebook_screen.dart:L125 | neighbors=[python_notebook_screen.dart]
- "ide_python_notebook_screen_deletecell": "_deleteCell()" | kind=code-symbol | source=lib/screens/ide/python_notebook_screen.dart:L146 | neighbors=[python_notebook_screen.dart]
- "ide_python_notebook_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/ide/python_notebook_screen.dart:L114 | neighbors=[python_notebook_screen.dart]
- "ide_python_notebook_screen_initcontrollers": "_initControllers()" | kind=code-symbol | source=lib/screens/ide/python_notebook_screen.dart:L100 | neighbors=[python_notebook_screen.dart]
- "ide_python_notebook_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/ide/python_notebook_screen.dart:L33 | neighbors=[python_notebook_screen.dart]
- "ide_python_notebook_screen_pythonnotebookscreen": "PythonNotebookScreen" | kind=code-symbol | source=lib/screens/ide/python_notebook_screen.dart:L14 | neighbors=[python_notebook_screen.dart]
- "ide_python_notebook_screen_pythonnotebookscreenstate": "_PythonNotebookScreenState" | kind=code-symbol | source=lib/screens/ide/python_notebook_screen.dart:L23 | neighbors=[python_notebook_screen.dart]
- "ide_python_notebook_screen_runcell": "_runCell()" | kind=code-symbol | source=lib/screens/ide/python_notebook_screen.dart:L157 | neighbors=[python_notebook_screen.dart]
- "ide_python_notebook_screen_savenotebook": "_saveNotebook()" | kind=code-symbol | source=lib/screens/ide/python_notebook_screen.dart:L240 | neighbors=[python_notebook_screen.dart]
- "ide_python_notebook_screen_showpipinstalldialog": "_showPipInstallDialog()" | kind=code-symbol | source=lib/screens/ide/python_notebook_screen.dart:L288 | neighbors=[python_notebook_screen.dart]
- "ide_universal_code_runner_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/ide/universal_code_runner_screen.dart:L90 | neighbors=[universal_code_runner_screen.dart]
- "ide_universal_code_runner_screen_getstartercode": "_getStarterCode()" | kind=code-symbol | source=lib/screens/ide/universal_code_runner_screen.dart:L66 | neighbors=[universal_code_runner_screen.dart]
- "ide_universal_code_runner_screen_greet": "greet()" | kind=code-symbol | source=lib/screens/ide/universal_code_runner_screen.dart:L69 | neighbors=[universal_code_runner_screen.dart]
- "ide_universal_code_runner_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/ide/universal_code_runner_screen.dart:L48 | neighbors=[universal_code_runner_screen.dart]
- "ide_universal_code_runner_screen_main": "Main" | kind=code-symbol | source=lib/screens/ide/universal_code_runner_screen.dart:L79 | neighbors=[universal_code_runner_screen.dart]
- "ide_universal_code_runner_screen_runcode": "_runCode()" | kind=code-symbol | source=lib/screens/ide/universal_code_runner_screen.dart:L97 | neighbors=[universal_code_runner_screen.dart]
- "ide_universal_code_runner_screen_saveproject": "_saveProject()" | kind=code-symbol | source=lib/screens/ide/universal_code_runner_screen.dart:L134 | neighbors=[universal_code_runner_screen.dart]
- "ide_universal_code_runner_screen_universalcoderunnerscreen": "UniversalCodeRunnerScreen" | kind=code-symbol | source=lib/screens/ide/universal_code_runner_screen.dart:L12 | neighbors=[universal_code_runner_screen.dart]
- "ide_universal_code_runner_screen_universalcoderunnerscreenstate": "_UniversalCodeRunnerScreenState" | kind=code-symbol | source=lib/screens/ide/universal_code_runner_screen.dart:L22 | neighbors=[universal_code_runner_screen.dart]
- "lib_firebase_options": "firebase_options.dart" | kind=code-symbol | source=lib/firebase_options.dart:L1 | neighbors=[DefaultFirebaseOptions]
- "lib_firebase_options_defaultfirebaseoptions": "DefaultFirebaseOptions" | kind=code-symbol | source=lib/firebase_options.dart:L17 | neighbors=[firebase_options.dart]
- "lib_lucide_icons": "lucide_icons.dart" | kind=code-symbol | source=packages/lucide_icons/lib/lucide_icons.dart:L1 | neighbors=[LucideIcons]
- "lib_lucide_icons_lucideicons": "LucideIcons" | kind=code-symbol | source=packages/lucide_icons/lib/lucide_icons.dart:L7 | neighbors=[lucide_icons.dart]
- "lib_main_abc": "abc()" | kind=code-symbol | source=packages/webview_cef/example/lib/main.dart:L94 | neighbors=[main.dart]
- "lib_main_dispose": "dispose()" | kind=code-symbol | source=packages/webview_cef/example/lib/main.dart:L59 | neighbors=[main.dart]
- "lib_main_flowapp": "FlowApp" | kind=code-symbol | source=lib/main.dart:L532 | neighbors=[main.dart]
- "lib_main_initplatformstate": "initPlatformState()" | kind=code-symbol | source=packages/webview_cef/example/lib/main.dart:L66 | neighbors=[main.dart]
- "lib_main_initstate": "initState()" | kind=code-symbol | source=packages/webview_cef/example/lib/main.dart:L27 | neighbors=[main.dart]
- "lib_main_looksnonfatal": "_looksNonFatal()" | kind=code-symbol | source=lib/main.dart:L36 | neighbors=[main.dart]
- "lib_main_main": "main()" | kind=code-symbol | source=packages/webview_cef/example/lib/main.dart:L7 | neighbors=[main.dart]
- "lib_main_myapp": "MyApp" | kind=code-symbol | source=packages/webview_cef/example/lib/main.dart:L11 | neighbors=[main.dart]
- "lib_main_myappstate": "_MyAppState" | kind=code-symbol | source=packages/webview_cef/example/lib/main.dart:L18 | neighbors=[main.dart]
- "lib_main_popintent": "PopIntent" | kind=code-symbol | source=lib/main.dart:L520 | neighbors=[main.dart]
- "lib_main_showglobalerroralert": "showGlobalErrorAlert()" | kind=code-symbol | source=lib/main.dart:L82 | neighbors=[main.dart]
- "lib_main_showratelimitdialog": "showRateLimitDialog()" | kind=code-symbol | source=lib/main.dart:L189 | neighbors=[main.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-018.json

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
