# Node Description Batch 5 of 61

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
For an entity node (any other kind — e.g. a person, place, event, object),
describe what the entity is and its role, grounded in its type, its
relations (neighbors) and the provided citations/evidence — e.g.
"Lady Carfax, a wealthy heiress who disappears en route to Lausanne.".
Ground entity descriptions in the citations/evidence when present; do not
speculate beyond the context, so a node with no supporting context may be
left out of the reply.
LANGUAGE: each entry has a `lang=` marker giving the language of its source.
Write that entry's description in EXACTLY that language. Do not translate to
a single common language — match each node's source language individually.
No marketing language.
Respond ONLY with a JSON object mapping each node id (as a string) to its
one-sentence description — no prose, no markdown fences.

- "screens_auth_screen": "auth_screen.dart" | kind=code-symbol | source=lib/screens/auth_screen.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 859f766 new, a22f95b feat: complete celestial light …, c216a16 theme: migrate home, auth, sett…] | lang=en
- "screens_bookmarks_screen": "bookmarks_screen.dart" | kind=code-symbol | source=lib/screens/bookmarks_screen.dart:L1 | neighbors=[1393ac9 6th, 2934308 theme: migrate metacognition_se…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, BookmarksScreen] | lang=en
- "screens_pyq_score_history_screen": "pyq_score_history_screen.dart" | kind=code-symbol | source=lib/screens/pyq_score_history_screen.dart:L1 | neighbors=[bccabe4 pyq_meta all set, _formatDate(), initState(), _loadHistory(), _openDetail(), PyqExamDetailScreen] | lang=en
- "services_bookmark_service": "bookmark_service.dart" | kind=code-symbol | source=lib/services/bookmark_service.dart:L1 | neighbors=[a22f95b feat: complete celestial light …, add(), Bookmark, BookmarkService, isBookmarked(), markOpened()] | lang=en
- "services_toc_matcher": "toc_matcher.dart" | kind=code-symbol | source=lib/services/toc_matcher.dart:L1 | neighbors=[742f017 feat: add offline TocMatcher he…, a22f95b feat: complete celestial light …, hasPrintedPageNumbers(), index, isChapterStart(), _normalize()] | lang=en
- "widgets_compact_book_card": "compact_book_card.dart" | kind=code-symbol | source=lib/widgets/compact_book_card.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 92086cd theme: migrate duo_button, mini…, a055e9b PRE-RE, a22f95b feat: complete celestial light …] | lang=en
- "widgets_compact_book_list_item": "compact_book_list_item.dart" | kind=code-symbol | source=lib/widgets/compact_book_list_item.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a055e9b PRE-RE, a22f95b feat: complete celestial light …, e63dbac theme: migrate next_up_card, co…] | lang=en
- "widgets_smart_review_card": "smart_review_card.dart" | kind=code-symbol | source=lib/widgets/smart_review_card.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 9c0e7f3 theme: migrate safe_pdf_viewer,…, a22f95b feat: complete celestial light …, bccabe4 pyq_meta all set] | lang=en
- "widgets_update_dialog": "update_dialog.dart" | kind=code-symbol | source=lib/widgets/update_dialog.dart:L1 | neighbors=[a22f95b feat: complete celestial light …, b99cbf3 OK, _download(), _DownloadProgress, initState(), _install()] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@039f2fe9bfa763e9a1654ff4fb76c6e81ba7b90c": "039f2fe theme: migrate generate_qp, pdf_folder, reference_pdf_viewer, qp_detail…" | kind=Commit | source=git | neighbors=[main, c216a16 theme: migrate home, auth, sett…, book_route_loader_screen.dart, generate_qp_screen.dart, pdf_folder_screen.dart, qp_detail_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@4ead8b66ec4f9b08ae880848429d6cec5ff1168b": "4ead8b6 z" | kind=Commit | source=git | neighbors=[061977c chore: add Android builds v26.7…, main, 9d00f5b chore: add Android builds v26.7…, lesson_screen.dart, practice_session_screen.dart, math_evaluator_service.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@5d06f7a2ef7d070a5e1937538127eb1c0279265b": "5d06f7a feat: implement Auto-Next lesson flow and AI-CROSS check QA verification" | kind=Commit | source=git | neighbors=[1e1860b chore: add Android builds v26.7…, main, 39500a4 fix: correct deadline target co…, lesson_complete_screen.dart, lesson_screen.dart, ai_service.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@845dfcb55bf2dd04436413063dcf99c82d19731f": "845dfcb feat: fast offline-speed initial loading, real-time progress bar & back…" | kind=Commit | source=git | neighbors=[2ca4f58 chore: add Android builds v26.7…, main, f9191cf chore: add Android builds v26.7…, auth_gate.dart, home_screen.dart, database_service.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@9c0e7f39e7484226ab547aa5ec6cb3bb4a9b2442": "9c0e7f3 theme: migrate safe_pdf_viewer, qp_card, canvas_html_view, smart_review…" | kind=Commit | source=git | neighbors=[main, d5b97ce theme: migrate book_dashboard_s…, canvas_html_view.dart, missing_files_banner.dart, qp_card.dart, safe_pdf_viewer.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@ab7968dd124c2780606e7be76d50c1b35cd106da": "ab7968d it ignored my command lets see whta this will be" | kind=Commit | source=git | neighbors=[main, 3f4d091 Merge branch 'main' of https://…, app_models.dart, book_dashboard_screen.dart, home_screen.dart, deadline_service.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@f77a46a52d73a1d5971a68a0d25edf18829339cd": "f77a46a ux: fix dead-ends and silent failures across lessons and home" | kind=Commit | source=git | neighbors=[06c30be theme: migrate lesson-complete …, main, 92086cd theme: migrate duo_button, mini…, home_screen.dart, lesson_screen.dart, fill_in_blank_view.dart] | lang=en
- "ide_html_ide_screen": "html_ide_screen.dart" | kind=code-symbol | source=lib/screens/ide/html_ide_screen.dart:L1 | neighbors=[329bdab ny, df34d11 Fix latex, peace, changeColor(), dispose(), HtmlIdeScreen, _HtmlIdeScreenState] | lang=en
- "screens_book_route_loader_screen": "book_route_loader_screen.dart" | kind=code-symbol | source=lib/screens/book_route_loader_screen.dart:L1 | neighbors=[039f2fe theme: migrate generate_qp, pdf…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, BookRouteLoaderScreen, _BookRouteLoaderScreenState] | lang=en
- "screens_module_notes_viewer_screen": "module_notes_viewer_screen.dart" | kind=code-symbol | source=lib/screens/module_notes_viewer_screen.dart:L1 | neighbors=[14e7263 feat: Quick Generate Module Not…, initState(), _loadHtmlNotes(), ModuleNotesViewerScreen, _ModuleNotesViewerScreenState, _onJsMessage()] | lang=en
- "screens_module_summary_detail_screen": "module_summary_detail_screen.dart" | kind=code-symbol | source=lib/screens/module_summary_detail_screen.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 675d2a1 EXPRESS, a22f95b feat: complete celestial light …, df7e28f theme: migrate pdf_browser, exp…] | lang=en
- "screens_pyq_exam_screen": "pyq_exam_screen.dart" | kind=code-symbol | source=lib/screens/pyq_exam_screen.dart:L1 | neighbors=[bccabe4 pyq_meta all set, dispose(), initState(), _pickImageForQuestion(), PyqExamScreen, _PyqExamScreenState] | lang=en
- "selectors_module_selector": "module_selector.dart" | kind=code-symbol | source=lib/widgets/selectors/module_selector.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 6a6426e theme: migrate module_selector,…, a22f95b feat: complete celestial light …, _ModuleRow] | lang=en
- "services_ai_estimator": "ai_estimator.dart" | kind=code-symbol | source=lib/services/ai_estimator.dart:L1 | neighbors=[a22f95b feat: complete celestial light …, ActiveRequestInfo, AiEstimator, estimateDurationSync(), estimateUnitDurationSync(), Function()] | lang=en
- "services_daily_goals_service": "daily_goals_service.dart" | kind=code-symbol | source=lib/services/daily_goals_service.dart:L1 | neighbors=[a15c42e feat(daily-goals): Add Gamified…, claimReward(), DailyGoalsService, getTodayString(), isFirstLaunchToday(), markFirstLaunchSeen()] | lang=en
- "services_walkthrough_service": "walkthrough_service.dart" | kind=code-symbol | source=lib/services/walkthrough_service.dart:L1 | neighbors=[9d1d7bc NAA, a22f95b feat: complete celestial light …, advanceTo(), finish(), isDone(), maybeStart()] | lang=en
- "utils_latex_utils": "latex_utils.dart" | kind=code-symbol | source=lib/utils/latex_utils.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, _autoWrapBareLatexInSegment(), _fixUnclosedDisplayMath(), _fixUnclosedInlineMath(), fixUnclosedLatex(), LatexUtils] | lang=en
- "utils_progress_utils": "progress_utils.dart" | kind=code-symbol | source=lib/utils/progress_utils.dart:L1 | neighbors=[8938325 feat: layout-based course progr…, a22f95b feat: complete celestial light …, calculateModuleProgress(), calculateModuleProgressDouble(), calculateSectionProgress(), calculateSectionProgressDouble()] | lang=en
- "widgets_combo_badge": "combo_badge.dart" | kind=code-symbol | source=lib/widgets/combo_badge.dart:L1 | neighbors=[5621c28 v26.8.8: Integrated SeriousPyth…, ea88f41 Farsan, ComboBadge, _ComboBadgeState, _ComboStyle, didUpdateWidget()] | lang=en
- "widgets_file_selection_list": "file_selection_list.dart" | kind=code-symbol | source=lib/widgets/file_selection_list.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4c8673e OKKK, 4ea5161 Merge pull request #3 from ihja…, 8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …] | lang=en
- "widgets_repair_alignment_dialog": "repair_alignment_dialog.dart" | kind=code-symbol | source=lib/widgets/repair_alignment_dialog.dart:L1 | neighbors=[1393ac9 6th, 1eb22ce theme: migrate generating_book_…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …] | lang=en
- "widgets_unit_header": "unit_header.dart" | kind=code-symbol | source=lib/widgets/unit_header.dart:L1 | neighbors=[3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 9965175 feat: remove Pause AI feature; …, a22f95b feat: complete celestial light …, f23bb62 theme: migrate calibration/lear…, _ResumeIconButton] | lang=en
- "windows_webview_cef_plugin": "webview_cef_plugin.h" | kind=code-symbol | source=packages/webview_cef/windows/webview_cef_plugin.h:L1 | neighbors=[encode_flvalue_to_wvalue(), encode_wvalue_to_flvalue(), handleMessageProc(), HandleMethodCall(), RegisterWithRegistrar(), webview_cef()] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@10204b56f47cf1305229fadd8f44521168d6ad1c": "10204b5 theme: migrate one_word/numerical/matching/ordering views" | kind=Commit | source=git | neighbors=[main, 996d33b theme: migrate remaining small …, matching_view.dart, numerical_view.dart, one_word_view.dart, ordering_view.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@2d60cdb15b6b61961e99f42b03585397cb4d430f": "2d60cdb feat: add AI provider model test debugger, practice-first programming p…" | kind=Commit | source=git | neighbors=[main, e18a31c chore: add Android builds v26.7…, app_models.dart, ai_providers_screen.dart, book_dashboard_screen.dart, prompt_service.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@3e9b205ea773632c1119447fb134582f076b886c": "3e9b205 theme: migrate descriptive/interactive_proof/fill_in_blank/pyq_one_word…" | kind=Commit | source=git | neighbors=[main, 10204b5 theme: migrate one_word/numeric…, descriptive_view.dart, fill_in_blank_view.dart, interactive_proof_view.dart, pyq_one_word_view.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@4ea21ab0f9ac30d6abcd019a13b8e67f2148508d": "4ea21ab fix: loadPyodide loading timing, bottom check button animations, slide …" | kind=Commit | source=git | neighbors=[main, f916a64 chore: add Android builds v26.7…, lesson_screen.dart, code_runner_view.dart, duo_button.dart, next_up_card.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@99651751ecb88f85540058165343297fed33dded": "9965175 feat: remove Pause AI feature; interrupted tasks auto-resume" | kind=Commit | source=git | neighbors=[main, d6812c1 feat: add Run now quick-run for…, home_screen.dart, settings_screen.dart, generation_manager.dart, unit_header.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@b59e77ba07412bc3f9cd049254d5b5367c125e96": "b59e77b fix: auto resolve sync conflicts with latest version, clean up sync con…" | kind=Commit | source=git | neighbors=[aaf383b fix: update free capacity limit…, main, 2508966 chore: add Android builds v26.7…, home_screen.dart, settings_screen.dart, database_service.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@c216a163d89b820bee6e4839bb3df624f73d17a5": "c216a16 theme: migrate home, auth, settings, practice_session, onboarding scree…" | kind=Commit | source=git | neighbors=[039f2fe theme: migrate generate_qp, pdf…, main, 3a768f9 style: dart format the files to…, auth_screen.dart, home_screen.dart, practice_session_screen.dart] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@c71d7570e48b95a4726450b892621c62507309f9": "c71d757 orgainze apis" | kind=Commit | source=git | neighbors=[bed7aca chore: add Android builds v26.7…, main, 0eaaf59 chore: add Android builds v26.7…, ai_providers_screen.dart, home_screen.dart, settings_screen.dart] | lang=en

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-004.json

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
