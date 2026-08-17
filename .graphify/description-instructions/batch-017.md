# Node Description Batch 18 of 61

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

- "ide_code_ide_screen_openproject": "_openProject()" | kind=code-symbol | source=lib/screens/ide/code_ide_screen.dart:L40 | neighbors=[code_ide_screen.dart]
- "ide_html_ide_screen_changecolor": "changeColor()" | kind=code-symbol | source=lib/screens/ide/html_ide_screen.dart:L87 | neighbors=[html_ide_screen.dart]
- "ide_html_ide_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/ide/html_ide_screen.dart:L98 | neighbors=[html_ide_screen.dart]
- "ide_html_ide_screen_htmlidescreen": "HtmlIdeScreen" | kind=code-symbol | source=lib/screens/ide/html_ide_screen.dart:L10 | neighbors=[html_ide_screen.dart]
- "ide_html_ide_screen_htmlidescreenstate": "_HtmlIdeScreenState" | kind=code-symbol | source=lib/screens/ide/html_ide_screen.dart:L19 | neighbors=[html_ide_screen.dart]
- "ide_html_ide_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/ide/html_ide_screen.dart:L32 | neighbors=[html_ide_screen.dart]
- "ide_html_ide_screen_saveproject": "_saveProject()" | kind=code-symbol | source=lib/screens/ide/html_ide_screen.dart:L126 | neighbors=[html_ide_screen.dart]
- "ide_latex_ide_screen_addlog": "_addLog()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L613 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_addrule": "_addRule()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1765 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_compileandopendocumentviewer": "_compileAndOpenDocumentViewer()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L624 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_dashedborderpainter": "DashedBorderPainter" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1656 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L269 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_generatejspreprocessor": "generateJsPreprocessor()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1596 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_generateofflinepdf": "_generateOfflinePdf()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L787 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L250 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_latexidescreen": "LatexIdeScreen" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L20 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_latexidescreenstate": "_LatexIdeScreenState" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L29 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_latexjsenginemanager": "LatexJsEngineManager" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1544 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_latexjsscripteditordialog": "LatexJsScriptEditorDialog" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1697 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_latexjsscripteditordialogstate": "_LatexJsScriptEditorDialogState" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1734 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_latexpdfpreviewscreen": "LatexPdfPreviewScreen" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L595 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_latexpdfpreviewscreenstate": "_LatexPdfPreviewScreenState" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L609 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_load": "_load()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1748 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_loadcustomjsscript": "_loadCustomJsScript()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L634 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_loadscript": "loadScript()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1649 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_loadtemplate": "_loadTemplate()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L287 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_ontextchanged": "_onTextChanged()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L278 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_openpdfinviewer": "_openPdfInViewer()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L709 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_openpdfpreview": "_openPdfPreview()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L295 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_paint": "paint()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1672 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_preprocessrule": "PreprocessRule" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1515 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_preprocesstex": "preprocessTeX()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1261 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_renderlatex": "renderLaTeX()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1291 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_resetrules": "resetRules()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1591 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_resetscript": "resetScript()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1629 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_saveproject": "_saveProject()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L429 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_saverules": "saveRules()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1585 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_savescript": "saveScript()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1624 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_sendlog": "sendLog()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1102 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_shouldrepaint": "shouldRepaint()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1692 | neighbors=[latex_ide_screen.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-017.json

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
