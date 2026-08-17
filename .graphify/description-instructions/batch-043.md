# Node Description Batch 44 of 61

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

- "services_module_notes_service_modulenotesjob": "ModuleNotesJob" | kind=code-symbol | source=lib/services/module_notes_service.dart:L14 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_modulenotesservice": "ModuleNotesService" | kind=code-symbol | source=lib/services/module_notes_service.dart:L57 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_notes": "notes" | kind=code-symbol | source=lib/services/module_notes_service.dart:L88 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_notify": "notify()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L48 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_prefkey": "_prefKey()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L61 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_readpdftext": "_readPdfText()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L584 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_removelistener": "removeListener()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L44 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_saverenderedhtml": "saveRenderedHtml()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L139 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_sequentially": "sequentially" | kind=code-symbol | source=lib/services/module_notes_service.dart:L278 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_startbackgroundnotesgeneration": "startBackgroundNotesGeneration()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L153 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_textbook": "textbook" | kind=code-symbol | source=lib/services/module_notes_service.dart:L313 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_title": "Title" | kind=code-symbol | source=lib/services/module_notes_service.dart:L389 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_trychromeprinttopdf": "_tryChromePrintToPdf()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L512 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_validatepdfbytes": "_validatePdfBytes()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L598 | neighbors=[module_notes_service.dart]
- "services_next_up_service_nextup": "NextUp" | kind=code-symbol | source=lib/services/next_up_service.dart:L6 | neighbors=[next_up_service.dart]
- "services_next_up_service_nextupservice": "NextUpService" | kind=code-symbol | source=lib/services/next_up_service.dart:L24 | neighbors=[next_up_service.dart]
- "services_next_up_service_resolve": "resolve()" | kind=code-symbol | source=lib/services/next_up_service.dart:L29 | neighbors=[next_up_service.dart]
- "services_next_up_service_xptoday": "xpToday()" | kind=code-symbol | source=lib/services/next_up_service.dart:L75 | neighbors=[next_up_service.dart]
- "services_notification_service_cancel": "cancel()" | kind=code-symbol | source=lib/services/notification_service.dart:L183 | neighbors=[notification_service.dart]
- "services_notification_service_canceldailyreminder": "cancelDailyReminder()" | kind=code-symbol | source=lib/services/notification_service.dart:L230 | neighbors=[notification_service.dart]
- "services_notification_service_init": "init()" | kind=code-symbol | source=lib/services/notification_service.dart:L17 | neighbors=[notification_service.dart]
- "services_notification_service_notificationservice": "NotificationService" | kind=code-symbol | source=lib/services/notification_service.dart:L11 | neighbors=[notification_service.dart]
- "services_notification_service_onselectnotification": "_onSelectNotification()" | kind=code-symbol | source=lib/services/notification_service.dart:L92 | neighbors=[notification_service.dart]
- "services_notification_service_scheduledailyreminder": "scheduleDailyReminder()" | kind=code-symbol | source=lib/services/notification_service.dart:L194 | neighbors=[notification_service.dart]
- "services_notification_service_showactionable": "showActionable()" | kind=code-symbol | source=lib/services/notification_service.dart:L161 | neighbors=[notification_service.dart]
- "services_notification_service_showprogress": "showProgress()" | kind=code-symbol | source=lib/services/notification_service.dart:L127 | neighbors=[notification_service.dart]
- "services_page_mapping_chooseeffectiveoffset": "chooseEffectiveOffset()" | kind=code-symbol | source=lib/services/page_mapping.dart:L40 | neighbors=[page_mapping.dart]
- "services_page_mapping_computeoffset": "computeOffset()" | kind=code-symbol | source=lib/services/page_mapping.dart:L30 | neighbors=[page_mapping.dart]
- "services_page_mapping_enforceincreasing": "_enforceIncreasing()" | kind=code-symbol | source=lib/services/page_mapping.dart:L271 | neighbors=[page_mapping.dart]
- "services_page_mapping_fillmissingstarts": "_fillMissingStarts()" | kind=code-symbol | source=lib/services/page_mapping.dart:L231 | neighbors=[page_mapping.dart]
- "services_page_mapping_normalize": "_normalize()" | kind=code-symbol | source=lib/services/page_mapping.dart:L222 | neighbors=[page_mapping.dart]
- "services_page_mapping_pagemapping": "PageMapping" | kind=code-symbol | source=lib/services/page_mapping.dart:L22 | neighbors=[page_mapping.dart]
- "services_page_mapping_resolvedranges": "ResolvedRanges" | kind=code-symbol | source=lib/services/page_mapping.dart:L9 | neighbors=[page_mapping.dart]
- "services_page_mapping_titlematchscore": "titleMatchScore()" | kind=code-symbol | source=lib/services/page_mapping.dart:L195 | neighbors=[page_mapping.dart]
- "services_pdf_service_extractpages": "extractPages()" | kind=code-symbol | source=lib/services/pdf_service.dart:L21 | neighbors=[pdf_service.dart]
- "services_pdf_service_extractpagetext": "extractPageText()" | kind=code-symbol | source=lib/services/pdf_service.dart:L961 | neighbors=[pdf_service.dart]
- "services_pdf_service_extracttextfrompdf": "extractTextFromPdf()" | kind=code-symbol | source=lib/services/pdf_service.dart:L157 | neighbors=[pdf_service.dart]
- "services_pdf_service_extracttextfrompdfbytes": "extractTextFromPdfBytes()" | kind=code-symbol | source=lib/services/pdf_service.dart:L140 | neighbors=[pdf_service.dart]
- "services_pdf_service_function": "Function()" | kind=code-symbol | source=lib/services/pdf_service.dart:L383 | neighbors=[pdf_service.dart]
- "services_pdf_service_generateplaceholderpdf": "generatePlaceholderPdf()" | kind=code-symbol | source=lib/services/pdf_service.dart:L262 | neighbors=[pdf_service.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-043.json

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
