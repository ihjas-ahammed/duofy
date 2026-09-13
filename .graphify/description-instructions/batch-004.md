# Node Description Batch 5 of 68

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
Write every description in English (en). Do not switch languages.
No marketing language.
Respond ONLY with a JSON object mapping each node id (as a string) to its
one-sentence description — no prose, no markdown fences.

- "widgets_lesson_accordion": "lesson_accordion.dart" | kind=code-symbol | source=lib/widgets/lesson_accordion.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, ee65d46 theme: migrate lesson_accordion, _findActiveUnit()]
- "widgets_missing_files_banner": "missing_files_banner.dart" | kind=code-symbol | source=lib/widgets/missing_files_banner.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 8554e22 feat: the web build compiles an…, 9c0e7f3 theme: migrate safe_pdf_viewer,…, a22f95b feat: complete celestial light …]
- "widgets_string_list_manager": "string_list_manager.dart" | kind=code-symbol | source=lib/widgets/string_list_manager.dart:L1 | neighbors=[3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, f23bb62 theme: migrate calibration/lear…, _addItem(), commitPending()]
- "commit:repo:github.com/ihjas-ahammed/duofy@0b36b76850c0f7dfcd367532906e01d19fff7355": "0b36b76 feat(release): v26.9.1 - Multi-file LaTeX Studio, Navigation Drawer wor…" | kind=Commit | source=git | neighbors=[main, bc59a6e chore: add Android builds v26.9…, latex_ide_screen.dart, module_selection_screen.dart, reel_view_screen.dart, section_selection_screen.dart]
- "commit:repo:github.com/ihjas-ahammed/duofy@4337110deca6ea1d73d493f71316b3c198dfac90": "4337110 feat: remove AI 10-page chunk scan; auto-index failures go straight to …" | kind=Commit | source=git | neighbors=[main, ddd874e feat: toast all AI task failure…, ai_task.dart, ai_queue_screen.dart, auto_index_pipeline.dart, auto_index_service.dart]
- "commit:repo:github.com/ihjas-ahammed/duofy@5fcf739121f1b45aa8a2fea47cb5896b7d46ebfe": "5fcf739 update: tactical sync" | kind=Commit | source=git | neighbors=[1a59536 chore: add Android builds v26.8…, main, dbdfb95 chore: add Android builds v26.8…, module_notes_viewer_screen.dart, module_selection_screen.dart, section_selection_screen.dart]
- "commit:repo:github.com/ihjas-ahammed/duofy@67b95dbe21397f91a2688737ba1bb0d865a8160d": "67b95db OK" | kind=Commit | source=git | neighbors=[05a15cd chore: add Android builds v26.7…, main, 75e16eb ok, home_screen.dart, lesson_screen.dart, main_layout_screen.dart]
- "commit:repo:github.com/ihjas-ahammed/duofy@996d33bf88aefabc47e1615e57ded23e0f1aed70": "996d33b theme: migrate remaining small slide_views" | kind=Commit | source=git | neighbors=[10204b5 theme: migrate one_word/numeric…, main, f6d94bf theme: migrate section_bottom_s…, concept_pieces_view.dart, custom_html_view.dart, error_spotting_view.dart]
- "commit:repo:github.com/ihjas-ahammed/duofy@df34d111f1d4cd8ebdb651b24d8f56ebead08730": "df34d11 Fix latex, peace" | kind=Commit | source=git | neighbors=[main, 0c1e4c0 chore: add Android builds v26.8…, html_ide_screen.dart, latex_ide_screen.dart, python_notebook_screen.dart, universal_code_runner_screen.dart]
- "screens_auth_screen": "auth_screen.dart" | kind=code-symbol | source=lib/screens/auth_screen.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 859f766 new, a22f95b feat: complete celestial light …, c216a16 theme: migrate home, auth, sett…]
- "screens_bookmarks_screen": "bookmarks_screen.dart" | kind=code-symbol | source=lib/screens/bookmarks_screen.dart:L1 | neighbors=[1393ac9 6th, 2934308 theme: migrate metacognition_se…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, BookmarksScreen]
- "screens_pyq_score_history_screen": "pyq_score_history_screen.dart" | kind=code-symbol | source=lib/screens/pyq_score_history_screen.dart:L1 | neighbors=[bccabe4 pyq_meta all set, _formatDate(), initState(), _loadHistory(), _openDetail(), PyqExamDetailScreen]
- "services_bookmark_service": "bookmark_service.dart" | kind=code-symbol | source=lib/services/bookmark_service.dart:L1 | neighbors=[a22f95b feat: complete celestial light …, add(), Bookmark, BookmarkService, isBookmarked(), markOpened()]
- "services_error_capture_service": "error_capture_service.dart" | kind=code-symbol | source=lib/services/error_capture_service.dart:L1 | neighbors=[859f766 new, e52e844 feat(release): v26.8.27 - LaTeX…, CapturedError, clearAll(), dismissError(), ErrorCaptureService]
- "services_module_notes_html_builder": "module_notes_html_builder.dart" | kind=code-symbol | source=lib/services/module_notes_html_builder.dart:L1 | neighbors=[14e7263 feat: Quick Generate Module Not…, 5621c28 v26.8.8: Integrated SeriousPyth…, 5fcf739 update: tactical sync, e52e844 feat(release): v26.8.27 - LaTeX…, buildHtml(), _escapeHtml()]
- "services_toc_matcher": "toc_matcher.dart" | kind=code-symbol | source=lib/services/toc_matcher.dart:L1 | neighbors=[a22f95b feat: complete celestial light …, hasPrintedPageNumbers(), index, isChapterStart(), _normalize(), overview]
- "slide_views_slide_capsule_toolbar": "slide_capsule_toolbar.dart" | kind=code-symbol | source=lib/widgets/slide_views/slide_capsule_toolbar.dart:L1 | neighbors=[1c58056 feat(release): v26.8.31 - Compl…, _BotAvatarPainter, dispose(), initState(), _LiquidWavePainter, paint()]
- "widgets_compact_book_card": "compact_book_card.dart" | kind=code-symbol | source=lib/widgets/compact_book_card.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 92086cd theme: migrate duo_button, mini…, a22f95b feat: complete celestial light …, CompactBookCard]
- "widgets_compact_book_list_item": "compact_book_list_item.dart" | kind=code-symbol | source=lib/widgets/compact_book_list_item.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, e63dbac theme: migrate next_up_card, co…, CompactBookListItem]
- "widgets_smart_review_card": "smart_review_card.dart" | kind=code-symbol | source=lib/widgets/smart_review_card.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 9c0e7f3 theme: migrate safe_pdf_viewer,…, a22f95b feat: complete celestial light …, bccabe4 pyq_meta all set]
- "widgets_update_dialog": "update_dialog.dart" | kind=code-symbol | source=lib/widgets/update_dialog.dart:L1 | neighbors=[a22f95b feat: complete celestial light …, b99cbf3 OK, _download(), _DownloadProgress, initState(), _install()]
- "commit:repo:github.com/ihjas-ahammed/duofy@039f2fe9bfa763e9a1654ff4fb76c6e81ba7b90c": "039f2fe theme: migrate generate_qp, pdf_folder, reference_pdf_viewer, qp_detail…" | kind=Commit | source=git | neighbors=[main, c216a16 theme: migrate home, auth, sett…, book_route_loader_screen.dart, generate_qp_screen.dart, pdf_folder_screen.dart, qp_detail_screen.dart]
- "commit:repo:github.com/ihjas-ahammed/duofy@4ead8b66ec4f9b08ae880848429d6cec5ff1168b": "4ead8b6 z" | kind=Commit | source=git | neighbors=[061977c chore: add Android builds v26.7…, main, 9d00f5b chore: add Android builds v26.7…, lesson_screen.dart, practice_session_screen.dart, math_evaluator_service.dart]
- "commit:repo:github.com/ihjas-ahammed/duofy@5d06f7a2ef7d070a5e1937538127eb1c0279265b": "5d06f7a feat: implement Auto-Next lesson flow and AI-CROSS check QA verification" | kind=Commit | source=git | neighbors=[1e1860b chore: add Android builds v26.7…, main, 39500a4 fix: correct deadline target co…, lesson_complete_screen.dart, lesson_screen.dart, ai_service.dart]
- "commit:repo:github.com/ihjas-ahammed/duofy@845dfcb55bf2dd04436413063dcf99c82d19731f": "845dfcb feat: fast offline-speed initial loading, real-time progress bar & back…" | kind=Commit | source=git | neighbors=[2ca4f58 chore: add Android builds v26.7…, main, f9191cf chore: add Android builds v26.7…, auth_gate.dart, home_screen.dart, database_service.dart]
- "commit:repo:github.com/ihjas-ahammed/duofy@9c0e7f39e7484226ab547aa5ec6cb3bb4a9b2442": "9c0e7f3 theme: migrate safe_pdf_viewer, qp_card, canvas_html_view, smart_review…" | kind=Commit | source=git | neighbors=[main, d5b97ce theme: migrate book_dashboard_s…, canvas_html_view.dart, missing_files_banner.dart, qp_card.dart, safe_pdf_viewer.dart]
- "commit:repo:github.com/ihjas-ahammed/duofy@ab7968dd124c2780606e7be76d50c1b35cd106da": "ab7968d it ignored my command lets see whta this will be" | kind=Commit | source=git | neighbors=[main, 3f4d091 Merge branch 'main' of https://…, app_models.dart, book_dashboard_screen.dart, home_screen.dart, deadline_service.dart]
- "commit:repo:github.com/ihjas-ahammed/duofy@f77a46a52d73a1d5971a68a0d25edf18829339cd": "f77a46a ux: fix dead-ends and silent failures across lessons and home" | kind=Commit | source=git | neighbors=[06c30be theme: migrate lesson-complete …, main, 92086cd theme: migrate duo_button, mini…, home_screen.dart, lesson_screen.dart, fill_in_blank_view.dart]
- "ide_html_ide_screen": "html_ide_screen.dart" | kind=code-symbol | source=lib/screens/ide/html_ide_screen.dart:L1 | neighbors=[329bdab ny, df34d11 Fix latex, peace, changeColor(), dispose(), HtmlIdeScreen, _HtmlIdeScreenState]
- "screens_book_route_loader_screen": "book_route_loader_screen.dart" | kind=code-symbol | source=lib/screens/book_route_loader_screen.dart:L1 | neighbors=[039f2fe theme: migrate generate_qp, pdf…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, BookRouteLoaderScreen, _BookRouteLoaderScreenState]
- "screens_module_summary_detail_screen": "module_summary_detail_screen.dart" | kind=code-symbol | source=lib/screens/module_summary_detail_screen.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, df7e28f theme: migrate pdf_browser, exp…, List]
- "screens_pyq_exam_screen": "pyq_exam_screen.dart" | kind=code-symbol | source=lib/screens/pyq_exam_screen.dart:L1 | neighbors=[bccabe4 pyq_meta all set, dispose(), initState(), _pickImageForQuestion(), PyqExamScreen, _PyqExamScreenState]
- "selectors_module_selector": "module_selector.dart" | kind=code-symbol | source=lib/widgets/selectors/module_selector.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 6a6426e theme: migrate module_selector,…, a22f95b feat: complete celestial light …, _ModuleRow]
- "services_ai_estimator": "ai_estimator.dart" | kind=code-symbol | source=lib/services/ai_estimator.dart:L1 | neighbors=[a22f95b feat: complete celestial light …, ActiveRequestInfo, AiEstimator, estimateDurationSync(), estimateUnitDurationSync(), Function()]
- "services_daily_goals_service": "daily_goals_service.dart" | kind=code-symbol | source=lib/services/daily_goals_service.dart:L1 | neighbors=[a15c42e feat(daily-goals): Add Gamified…, claimReward(), DailyGoalsService, getTodayString(), isFirstLaunchToday(), markFirstLaunchSeen()]
- "services_walkthrough_service": "walkthrough_service.dart" | kind=code-symbol | source=lib/services/walkthrough_service.dart:L1 | neighbors=[9d1d7bc NAA, a22f95b feat: complete celestial light …, advanceTo(), finish(), isDone(), maybeStart()]
- "theme_app_theme": "app_theme.dart" | kind=code-symbol | source=lib/theme/app_theme.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, 1c58056 feat(release): v26.8.31 - Compl…, 7dbab59 Merge pull request #2 from ihja…, a15c42e feat(daily-goals): Add Gamified…, a22f95b feat: complete celestial light …, f2613a9 theme: celestial palette with l…]
- "utils_latex_utils": "latex_utils.dart" | kind=code-symbol | source=lib/utils/latex_utils.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, _autoWrapBareLatexInSegment(), _fixUnclosedDisplayMath(), _fixUnclosedInlineMath(), fixUnclosedLatex(), LatexUtils]
- "utils_progress_utils": "progress_utils.dart" | kind=code-symbol | source=lib/utils/progress_utils.dart:L1 | neighbors=[8938325 feat: layout-based course progr…, a22f95b feat: complete celestial light …, calculateModuleProgress(), calculateModuleProgressDouble(), calculateSectionProgress(), calculateSectionProgressDouble()]
- "widgets_combo_badge": "combo_badge.dart" | kind=code-symbol | source=lib/widgets/combo_badge.dart:L1 | neighbors=[5621c28 v26.8.8: Integrated SeriousPyth…, ea88f41 Farsan, ComboBadge, _ComboBadgeState, _ComboStyle, didUpdateWidget()]

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
