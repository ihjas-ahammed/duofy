# Node Description Batch 19 of 68

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

- "ide_latex_ide_screen_addrule": "_addRule()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1765 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_closetab": "_closeTab()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L446 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_compileandopendocumentviewer": "_compileAndOpenDocumentViewer()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L624 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_dashedborderpainter": "DashedBorderPainter" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1656 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L410 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_explainerrorwithai": "_explainErrorWithAi()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1781 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_fetchexplanation": "_fetchExplanation()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L2105 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_generatejspreprocessor": "generateJsPreprocessor()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1596 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_generateofflinepdf": "_generateOfflinePdf()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1807 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_getlanguageforfile": "_getLanguageForFile()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L387 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L336 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_latexerroraiexplainersheet": "_LatexErrorAiExplainerSheet" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L2076 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_latexerroraiexplainersheetstate": "_LatexErrorAiExplainerSheetState" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L2092 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_latexidescreen": "LatexIdeScreen" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L22 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_latexidescreenstate": "_LatexIdeScreenState" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L31 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_latexjsenginemanager": "LatexJsEngineManager" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1544 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_latexjsscripteditordialog": "LatexJsScriptEditorDialog" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1697 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_latexjsscripteditordialogstate": "_LatexJsScriptEditorDialogState" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1734 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_latexpdfpreviewscreen": "LatexPdfPreviewScreen" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L595 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_latexpdfpreviewscreenstate": "_LatexPdfPreviewScreenState" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L609 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_load": "_load()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1748 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_loadcustomjsscript": "_loadCustomJsScript()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L634 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_loadscript": "loadScript()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1649 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_loadtemplate": "_loadTemplate()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L721 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_ontextchanged": "_onTextChanged()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L419 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_openpdfinviewer": "_openPdfInViewer()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1681 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_openpdfpreview": "_openPdfPreview()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L745 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_paint": "paint()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1672 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_parsefield": "parseField()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1868 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_preprocessrule": "PreprocessRule" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1515 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_preprocesstex": "preprocessTeX()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1261 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_promptcreatenewfile": "_promptCreateNewFile()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L461 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_promptdeletefile": "_promptDeleteFile()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L647 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_promptrenamefile": "_promptRenameFile()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L572 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_reassemble": "reassemble()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L958 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_renderlatex": "renderLaTeX()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1291 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_resetrules": "resetRules()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1591 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_resetscript": "resetScript()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1629 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_saveproject": "_saveProject()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L916 | neighbors=[latex_ide_screen.dart]
- "ide_latex_ide_screen_saverules": "saveRules()" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1585 | neighbors=[latex_ide_screen.dart]

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
