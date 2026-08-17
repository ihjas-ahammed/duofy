# Node Description Batch 45 of 61

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

- "services_pdf_service_getendpage": "getEndPage()" | kind=code-symbol | source=lib/services/pdf_service.dart:L675 | neighbors=[pdf_service.dart]
- "services_pdf_service_getpagecount": "getPageCount()" | kind=code-symbol | source=lib/services/pdf_service.dart:L234 | neighbors=[pdf_service.dart]
- "services_pdf_service_hasbookmarks": "hasBookmarks()" | kind=code-symbol | source=lib/services/pdf_service.dart:L594 | neighbors=[pdf_service.dart]
- "services_pdf_service_in": "in" | kind=code-symbol | source=lib/services/pdf_service.dart:L499 | neighbors=[pdf_service.dart]
- "services_pdf_service_maxdepth": "maxDepth()" | kind=code-symbol | source=lib/services/pdf_service.dart:L662 | neighbors=[pdf_service.dart]
- "services_pdf_service_mergefiles": "mergeFiles()" | kind=code-symbol | source=lib/services/pdf_service.dart:L162 | neighbors=[pdf_service.dart]
- "services_pdf_service_pdfbookmarknode": "PdfBookmarkNode" | kind=code-symbol | source=lib/services/pdf_service.dart:L1021 | neighbors=[pdf_service.dart]
- "services_pdf_service_pdfservice": "PdfService" | kind=code-symbol | source=lib/services/pdf_service.dart:L14 | neighbors=[pdf_service.dart]
- "services_pdf_service_renderpagetoimage": "_renderPageToImage()" | kind=code-symbol | source=lib/services/pdf_service.dart:L869 | neighbors=[pdf_service.dart]
- "services_pdf_service_splitbookpdf": "splitBookPdf()" | kind=code-symbol | source=lib/services/pdf_service.dart:L380 | neighbors=[pdf_service.dart]
- "services_pdf_service_traversebookmarks": "_traverseBookmarks()" | kind=code-symbol | source=lib/services/pdf_service.dart:L618 | neighbors=[pdf_service.dart]
- "services_pdf_service_writechunk": "writeChunk()" | kind=code-symbol | source=lib/services/pdf_service.dart:L412 | neighbors=[pdf_service.dart]
- "services_personalization_service_as": "as" | kind=code-symbol | source=lib/services/personalization_service.dart:L70 | neighbors=[personalization_service.dart]
- "services_personalization_service_being": "being" | kind=code-symbol | source=lib/services/personalization_service.dart:L11 | neighbors=[personalization_service.dart]
- "services_personalization_service_compilesystemprompt": "compileSystemPrompt()" | kind=code-symbol | source=lib/services/personalization_service.dart:L21 | neighbors=[personalization_service.dart]
- "services_personalization_service_personalizationservice": "PersonalizationService" | kind=code-symbol | source=lib/services/personalization_service.dart:L14 | neighbors=[personalization_service.dart]
- "services_progress_service_clearbookprogress": "clearBookProgress()" | kind=code-symbol | source=lib/services/progress_service.dart:L207 | neighbors=[progress_service.dart]
- "services_progress_service_clearlessonprogress": "clearLessonProgress()" | kind=code-symbol | source=lib/services/progress_service.dart:L203 | neighbors=[progress_service.dart]
- "services_progress_service_clearlessonsprogress": "clearLessonsProgress()" | kind=code-symbol | source=lib/services/progress_service.dart:L84 | neighbors=[progress_service.dart]
- "services_progress_service_clearmoduleprogress": "clearModuleProgress()" | kind=code-symbol | source=lib/services/progress_service.dart:L272 | neighbors=[progress_service.dart]
- "services_progress_service_clearsectionprogress": "clearSectionProgress()" | kind=code-symbol | source=lib/services/progress_service.dart:L249 | neighbors=[progress_service.dart]
- "services_progress_service_clearunitprogress": "clearUnitProgress()" | kind=code-symbol | source=lib/services/progress_service.dart:L233 | neighbors=[progress_service.dart]
- "services_progress_service_getbookprogress": "getBookProgress()" | kind=code-symbol | source=lib/services/progress_service.dart:L158 | neighbors=[progress_service.dart]
- "services_progress_service_getxp": "getXp()" | kind=code-symbol | source=lib/services/progress_service.dart:L119 | neighbors=[progress_service.dart]
- "services_progress_service_getxpforcourse": "getXpForCourse()" | kind=code-symbol | source=lib/services/progress_service.dart:L127 | neighbors=[progress_service.dart]
- "services_progress_service_logactivity": "logActivity()" | kind=code-symbol | source=lib/services/progress_service.dart:L289 | neighbors=[progress_service.dart]
- "services_progress_service_marklessoncompleted": "markLessonCompleted()" | kind=code-symbol | source=lib/services/progress_service.dart:L115 | neighbors=[progress_service.dart]
- "services_progress_service_marklessonscompleted": "markLessonsCompleted()" | kind=code-symbol | source=lib/services/progress_service.dart:L34 | neighbors=[progress_service.dart]
- "services_progress_service_marklessonscompletedsilent": "markLessonsCompletedSilent()" | kind=code-symbol | source=lib/services/progress_service.dart:L68 | neighbors=[progress_service.dart]
- "services_progress_service_markmodulecompleted": "markModuleCompleted()" | kind=code-symbol | source=lib/services/progress_service.dart:L259 | neighbors=[progress_service.dart]
- "services_progress_service_marksectioncompleted": "markSectionCompleted()" | kind=code-symbol | source=lib/services/progress_service.dart:L239 | neighbors=[progress_service.dart]
- "services_progress_service_markunitcompleted": "markUnitCompleted()" | kind=code-symbol | source=lib/services/progress_service.dart:L227 | neighbors=[progress_service.dart]
- "services_progress_service_onprogresschanged": "_onProgressChanged()" | kind=code-symbol | source=lib/services/progress_service.dart:L22 | neighbors=[progress_service.dart]
- "services_progress_service_progressservice": "ProgressService" | kind=code-symbol | source=lib/services/progress_service.dart:L10 | neighbors=[progress_service.dart]
- "services_prompt_service_check": "check()" | kind=code-symbol | source=lib/services/prompt_service.dart:L116 | neighbors=[prompt_service.dart]
- "services_prompt_service_densityblock": "densityBlock()" | kind=code-symbol | source=lib/services/prompt_service.dart:L509 | neighbors=[prompt_service.dart]
- "services_prompt_service_draw": "draw()" | kind=code-symbol | source=lib/services/prompt_service.dart:L836 | neighbors=[prompt_service.dart]
- "services_prompt_service_frame": "frame()" | kind=code-symbol | source=lib/services/prompt_service.dart:L933 | neighbors=[prompt_service.dart]
- "services_prompt_service_getmultisectionpyqextractionprompt": "getMultiSectionPyqExtractionPrompt()" | kind=code-symbol | source=lib/services/prompt_service.dart:L1040 | neighbors=[prompt_service.dart]
- "services_prompt_service_getpyqextractionprompt": "getPyqExtractionPrompt()" | kind=code-symbol | source=lib/services/prompt_service.dart:L1115 | neighbors=[prompt_service.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-044.json

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
