# Node Description Batch 46 of 68

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

- "services_module_notes_service_getnotespdfpath": "getNotesPdfPath()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L149 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_hasnotes": "hasNotes()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L134 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_jobkey": "_jobKey()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L79 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_modulenotesjob": "ModuleNotesJob" | kind=code-symbol | source=lib/services/module_notes_service.dart:L15 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_modulenotesservice": "ModuleNotesService" | kind=code-symbol | source=lib/services/module_notes_service.dart:L58 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_notes": "notes" | kind=code-symbol | source=lib/services/module_notes_service.dart:L133 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_notify": "notify()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L49 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_prefkey": "_prefKey()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L78 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_readpdftext": "_readPdfText()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L859 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_removelistener": "removeListener()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L45 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_saverenderedhtml": "saveRenderedHtml()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L184 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_sequentially": "sequentially" | kind=code-symbol | source=lib/services/module_notes_service.dart:L376 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_startbackgroundnotesgeneration": "startBackgroundNotesGeneration()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L198 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_textbook": "textbook" | kind=code-symbol | source=lib/services/module_notes_service.dart:L433 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_title": "Title" | kind=code-symbol | source=lib/services/module_notes_service.dart:L389 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_trychromeprinttopdf": "_tryChromePrintToPdf()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L787 | neighbors=[module_notes_service.dart]
- "services_module_notes_service_validatepdfbytes": "_validatePdfBytes()" | kind=code-symbol | source=lib/services/module_notes_service.dart:L873 | neighbors=[module_notes_service.dart]
- "services_next_up_service_nextup": "NextUp" | kind=code-symbol | source=lib/services/next_up_service.dart:L6 | neighbors=[next_up_service.dart]
- "services_next_up_service_nextupservice": "NextUpService" | kind=code-symbol | source=lib/services/next_up_service.dart:L24 | neighbors=[next_up_service.dart]
- "services_next_up_service_resolve": "resolve()" | kind=code-symbol | source=lib/services/next_up_service.dart:L29 | neighbors=[next_up_service.dart]
- "services_next_up_service_xptoday": "xpToday()" | kind=code-symbol | source=lib/services/next_up_service.dart:L75 | neighbors=[next_up_service.dart]
- "services_notification_service_cancel": "cancel()" | kind=code-symbol | source=lib/services/notification_service.dart:L188 | neighbors=[notification_service.dart]
- "services_notification_service_canceldailyreminder": "cancelDailyReminder()" | kind=code-symbol | source=lib/services/notification_service.dart:L258 | neighbors=[notification_service.dart]
- "services_notification_service_ensureautoscheduledreminder": "ensureAutoScheduledReminder()" | kind=code-symbol | source=lib/services/notification_service.dart:L236 | neighbors=[notification_service.dart]
- "services_notification_service_init": "init()" | kind=code-symbol | source=lib/services/notification_service.dart:L19 | neighbors=[notification_service.dart]
- "services_notification_service_notificationservice": "NotificationService" | kind=code-symbol | source=lib/services/notification_service.dart:L13 | neighbors=[notification_service.dart]
- "services_notification_service_onselectnotification": "_onSelectNotification()" | kind=code-symbol | source=lib/services/notification_service.dart:L97 | neighbors=[notification_service.dart]
- "services_notification_service_scheduledailyreminder": "scheduleDailyReminder()" | kind=code-symbol | source=lib/services/notification_service.dart:L199 | neighbors=[notification_service.dart]
- "services_notification_service_showactionable": "showActionable()" | kind=code-symbol | source=lib/services/notification_service.dart:L166 | neighbors=[notification_service.dart]
- "services_notification_service_showprogress": "showProgress()" | kind=code-symbol | source=lib/services/notification_service.dart:L132 | neighbors=[notification_service.dart]
- "services_page_mapping_chooseeffectiveoffset": "chooseEffectiveOffset()" | kind=code-symbol | source=lib/services/page_mapping.dart:L40 | neighbors=[page_mapping.dart]
- "services_page_mapping_computeoffset": "computeOffset()" | kind=code-symbol | source=lib/services/page_mapping.dart:L30 | neighbors=[page_mapping.dart]
- "services_page_mapping_enforceincreasing": "_enforceIncreasing()" | kind=code-symbol | source=lib/services/page_mapping.dart:L271 | neighbors=[page_mapping.dart]
- "services_page_mapping_fillmissingstarts": "_fillMissingStarts()" | kind=code-symbol | source=lib/services/page_mapping.dart:L231 | neighbors=[page_mapping.dart]
- "services_page_mapping_normalize": "_normalize()" | kind=code-symbol | source=lib/services/page_mapping.dart:L222 | neighbors=[page_mapping.dart]
- "services_page_mapping_pagemapping": "PageMapping" | kind=code-symbol | source=lib/services/page_mapping.dart:L22 | neighbors=[page_mapping.dart]
- "services_page_mapping_resolvedranges": "ResolvedRanges" | kind=code-symbol | source=lib/services/page_mapping.dart:L9 | neighbors=[page_mapping.dart]
- "services_page_mapping_titlematchscore": "titleMatchScore()" | kind=code-symbol | source=lib/services/page_mapping.dart:L195 | neighbors=[page_mapping.dart]
- "services_pdf_service_extractpages": "extractPages()" | kind=code-symbol | source=lib/services/pdf_service.dart:L21 | neighbors=[pdf_service.dart]
- "services_pdf_service_extractpagetext": "extractPageText()" | kind=code-symbol | source=lib/services/pdf_service.dart:L1002 | neighbors=[pdf_service.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-045.json

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
