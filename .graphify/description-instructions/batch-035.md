# Node Description Batch 36 of 68

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

- "screens_reference_pdf_viewer_screen_resetzoom": "_resetZoom()" | kind=code-symbol | source=lib/screens/reference_pdf_viewer_screen.dart:L89 | neighbors=[reference_pdf_viewer_screen.dart]
- "screens_reference_pdf_viewer_screen_sharepdf": "_sharePdf()" | kind=code-symbol | source=lib/screens/reference_pdf_viewer_screen.dart:L97 | neighbors=[reference_pdf_viewer_screen.dart]
- "screens_reference_pdf_viewer_screen_zoomin": "_zoomIn()" | kind=code-symbol | source=lib/screens/reference_pdf_viewer_screen.dart:L67 | neighbors=[reference_pdf_viewer_screen.dart]
- "screens_reference_pdf_viewer_screen_zoomout": "_zoomOut()" | kind=code-symbol | source=lib/screens/reference_pdf_viewer_screen.dart:L77 | neighbors=[reference_pdf_viewer_screen.dart]
- "screens_section_selection_screen_bookmarkmatch": "_BookmarkMatch" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L1878 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_checknotesstatus": "_checkNotesStatus()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L111 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_deletenotes": "_deleteNotes()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L324 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L74 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L56 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_loaddeadlines": "_loadDeadlines()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L445 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_loadprogress": "_loadProgress()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L414 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_menuactionitem": "_MenuActionItem" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L1862 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_ongenmanagerchanged": "_onGenManagerChanged()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L91 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_onjobupdate": "onJobUpdate()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L389 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_onnotesserviceupdated": "_onNotesServiceUpdated()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L84 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_opennotes": "_openNotes()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L122 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_openreelview": "_openReelView()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L147 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_promptgenerateorregeneratenotes": "_promptGenerateOrRegenerateNotes()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L160 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_promptgenerateorschedulesection": "_promptGenerateOrScheduleSection()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L1636 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_refreshbookfromstorage": "_refreshBookFromStorage()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L97 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_scrolltoandhighlight": "_scrollToAndHighlight()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L467 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_sectionselectionscreen": "SectionSelectionScreen" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L21 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_sectionselectionscreenstate": "_SectionSelectionScreenState" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L39 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_selectsectiondeadline": "_selectSectionDeadline()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L1020 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_showbookmarksdialog": "_showBookmarksDialog()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L1156 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_showdeadlinemenu": "_showDeadlineMenu()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L1063 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_showsectionlongpressmenu": "_showSectionLongPressMenu()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L1528 | neighbors=[section_selection_screen.dart]
- "screens_section_selection_screen_startnotegen": "_startNoteGen()" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L376 | neighbors=[section_selection_screen.dart]
- "screens_settings_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/settings_screen.dart:L69 | neighbors=[settings_screen.dart]
- "screens_settings_screen_formattime": "formatTime()" | kind=code-symbol | source=lib/screens/settings_screen.dart:L122 | neighbors=[settings_screen.dart]
- "screens_settings_screen_formattimeofday": "_formatTimeOfDay()" | kind=code-symbol | source=lib/screens/settings_screen.dart:L1048 | neighbors=[settings_screen.dart]
- "screens_settings_screen_handlecheckforupdates": "_handleCheckForUpdates()" | kind=code-symbol | source=lib/screens/settings_screen.dart:L2341 | neighbors=[settings_screen.dart]
- "screens_settings_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/settings_screen.dart:L63 | neighbors=[settings_screen.dart]
- "screens_settings_screen_loadsettings": "_loadSettings()" | kind=code-symbol | source=lib/screens/settings_screen.dart:L88 | neighbors=[settings_screen.dart]
- "screens_settings_screen_savesettings": "_saveSettings()" | kind=code-symbol | source=lib/screens/settings_screen.dart:L165 | neighbors=[settings_screen.dart]
- "screens_settings_screen_settingsscreen": "SettingsScreen" | kind=code-symbol | source=lib/screens/settings_screen.dart:L28 | neighbors=[settings_screen.dart]
- "screens_settings_screen_settingsscreenstate": "_SettingsScreenState" | kind=code-symbol | source=lib/screens/settings_screen.dart:L35 | neighbors=[settings_screen.dart]
- "screens_settings_screen_triggerquicksync": "_triggerQuickSync()" | kind=code-symbol | source=lib/screens/settings_screen.dart:L133 | neighbors=[settings_screen.dart]
- "screens_source_pdf_upload_screen_clearslot": "_clearSlot()" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L199 | neighbors=[source_pdf_upload_screen.dart]
- "screens_source_pdf_upload_screen_dispose": "dispose()" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L67 | neighbors=[source_pdf_upload_screen.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-035.json

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
