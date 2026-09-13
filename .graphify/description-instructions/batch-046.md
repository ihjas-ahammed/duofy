# Node Description Batch 47 of 68

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

- "services_pdf_service_extracttextfrompdf": "extractTextFromPdf()" | kind=code-symbol | source=lib/services/pdf_service.dart:L158 | neighbors=[pdf_service.dart]
- "services_pdf_service_extracttextfrompdfbytes": "extractTextFromPdfBytes()" | kind=code-symbol | source=lib/services/pdf_service.dart:L140 | neighbors=[pdf_service.dart]
- "services_pdf_service_function": "Function()" | kind=code-symbol | source=lib/services/pdf_service.dart:L424 | neighbors=[pdf_service.dart]
- "services_pdf_service_generateplaceholderpdf": "generatePlaceholderPdf()" | kind=code-symbol | source=lib/services/pdf_service.dart:L303 | neighbors=[pdf_service.dart]
- "services_pdf_service_getendpage": "getEndPage()" | kind=code-symbol | source=lib/services/pdf_service.dart:L716 | neighbors=[pdf_service.dart]
- "services_pdf_service_getpagecount": "getPageCount()" | kind=code-symbol | source=lib/services/pdf_service.dart:L275 | neighbors=[pdf_service.dart]
- "services_pdf_service_hasbookmarks": "hasBookmarks()" | kind=code-symbol | source=lib/services/pdf_service.dart:L635 | neighbors=[pdf_service.dart]
- "services_pdf_service_in": "in" | kind=code-symbol | source=lib/services/pdf_service.dart:L540 | neighbors=[pdf_service.dart]
- "services_pdf_service_maxdepth": "maxDepth()" | kind=code-symbol | source=lib/services/pdf_service.dart:L703 | neighbors=[pdf_service.dart]
- "services_pdf_service_mergefiles": "mergeFiles()" | kind=code-symbol | source=lib/services/pdf_service.dart:L203 | neighbors=[pdf_service.dart]
- "services_pdf_service_pdfbookmarknode": "PdfBookmarkNode" | kind=code-symbol | source=lib/services/pdf_service.dart:L1081 | neighbors=[pdf_service.dart]
- "services_pdf_service_pdfservice": "PdfService" | kind=code-symbol | source=lib/services/pdf_service.dart:L14 | neighbors=[pdf_service.dart]
- "services_pdf_service_renderpagetoimage": "_renderPageToImage()" | kind=code-symbol | source=lib/services/pdf_service.dart:L910 | neighbors=[pdf_service.dart]
- "services_pdf_service_splitbookpdf": "splitBookPdf()" | kind=code-symbol | source=lib/services/pdf_service.dart:L421 | neighbors=[pdf_service.dart]
- "services_pdf_service_traversebookmarks": "_traverseBookmarks()" | kind=code-symbol | source=lib/services/pdf_service.dart:L659 | neighbors=[pdf_service.dart]
- "services_pdf_service_writechunk": "writeChunk()" | kind=code-symbol | source=lib/services/pdf_service.dart:L453 | neighbors=[pdf_service.dart]
- "services_personalization_service_as": "as" | kind=code-symbol | source=lib/services/personalization_service.dart:L70 | neighbors=[personalization_service.dart]
- "services_personalization_service_being": "being" | kind=code-symbol | source=lib/services/personalization_service.dart:L11 | neighbors=[personalization_service.dart]
- "services_personalization_service_compilesystemprompt": "compileSystemPrompt()" | kind=code-symbol | source=lib/services/personalization_service.dart:L21 | neighbors=[personalization_service.dart]
- "services_personalization_service_personalizationservice": "PersonalizationService" | kind=code-symbol | source=lib/services/personalization_service.dart:L14 | neighbors=[personalization_service.dart]
- "services_progress_service_clearbookprogress": "clearBookProgress()" | kind=code-symbol | source=lib/services/progress_service.dart:L209 | neighbors=[progress_service.dart]
- "services_progress_service_clearlessonprogress": "clearLessonProgress()" | kind=code-symbol | source=lib/services/progress_service.dart:L205 | neighbors=[progress_service.dart]
- "services_progress_service_clearlessonsprogress": "clearLessonsProgress()" | kind=code-symbol | source=lib/services/progress_service.dart:L86 | neighbors=[progress_service.dart]
- "services_progress_service_clearmoduleprogress": "clearModuleProgress()" | kind=code-symbol | source=lib/services/progress_service.dart:L274 | neighbors=[progress_service.dart]
- "services_progress_service_clearsectionprogress": "clearSectionProgress()" | kind=code-symbol | source=lib/services/progress_service.dart:L251 | neighbors=[progress_service.dart]
- "services_progress_service_clearunitprogress": "clearUnitProgress()" | kind=code-symbol | source=lib/services/progress_service.dart:L235 | neighbors=[progress_service.dart]
- "services_progress_service_getbookprogress": "getBookProgress()" | kind=code-symbol | source=lib/services/progress_service.dart:L160 | neighbors=[progress_service.dart]
- "services_progress_service_getxp": "getXp()" | kind=code-symbol | source=lib/services/progress_service.dart:L121 | neighbors=[progress_service.dart]
- "services_progress_service_getxpforcourse": "getXpForCourse()" | kind=code-symbol | source=lib/services/progress_service.dart:L129 | neighbors=[progress_service.dart]
- "services_progress_service_logactivity": "logActivity()" | kind=code-symbol | source=lib/services/progress_service.dart:L291 | neighbors=[progress_service.dart]
- "services_progress_service_marklessoncompleted": "markLessonCompleted()" | kind=code-symbol | source=lib/services/progress_service.dart:L117 | neighbors=[progress_service.dart]
- "services_progress_service_marklessonscompleted": "markLessonsCompleted()" | kind=code-symbol | source=lib/services/progress_service.dart:L36 | neighbors=[progress_service.dart]
- "services_progress_service_marklessonscompletedsilent": "markLessonsCompletedSilent()" | kind=code-symbol | source=lib/services/progress_service.dart:L70 | neighbors=[progress_service.dart]
- "services_progress_service_markmodulecompleted": "markModuleCompleted()" | kind=code-symbol | source=lib/services/progress_service.dart:L261 | neighbors=[progress_service.dart]
- "services_progress_service_marksectioncompleted": "markSectionCompleted()" | kind=code-symbol | source=lib/services/progress_service.dart:L241 | neighbors=[progress_service.dart]
- "services_progress_service_markunitcompleted": "markUnitCompleted()" | kind=code-symbol | source=lib/services/progress_service.dart:L229 | neighbors=[progress_service.dart]
- "services_progress_service_onprogresschanged": "_onProgressChanged()" | kind=code-symbol | source=lib/services/progress_service.dart:L23 | neighbors=[progress_service.dart]
- "services_progress_service_progressservice": "ProgressService" | kind=code-symbol | source=lib/services/progress_service.dart:L11 | neighbors=[progress_service.dart]
- "services_prompt_service_check": "check()" | kind=code-symbol | source=lib/services/prompt_service.dart:L116 | neighbors=[prompt_service.dart]
- "services_prompt_service_densityblock": "densityBlock()" | kind=code-symbol | source=lib/services/prompt_service.dart:L511 | neighbors=[prompt_service.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-046.json

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
