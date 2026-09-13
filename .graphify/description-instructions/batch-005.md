# Node Description Batch 6 of 68

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
- "commit:repo:github.com/ihjas-ahammed/duofy@c83829c8e4638ab40d79b65824f7b1546ba42ac2": "c83829c deadine v2" | kind=Commit | source=git | neighbors=[4026742 chore: add Android builds v26.7…, main, bed7aca chore: add Android builds v26.7…, book_dashboard_screen.dart, home_screen.dart, module_selection_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@df7e28f644474dfd2f291ea22461c532a87af8a6": "df7e28f theme: migrate pdf_browser, experiments, exam, module_summary_detail sc…" | kind=Commit | source=git | neighbors=[69395fd theme: migrate section_selectio…, main, 039f2fe theme: migrate generate_qp, pdf…, exam_screen.dart, experiments_screen.dart, module_summary_detail_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@e53d2dec00a268967e54bdea15c1e683abc7d4c5": "e53d2de Share PDF" | kind=Commit | source=git | neighbors=[458dd1e chore: add Android builds v26.8…, main, df34d11 Fix latex, peace, book_dashboard_screen.dart, document_store_screen.dart, pdf_folder_screen.dart] | lang=nl
- "commit:repo:github.com/ihjas-ahammed/duofy@ec6f1f9da1c15da3155f9710aff25c8fbe367ddf": "ec6f1f9 feat: unify restore PDF picker with course creation picker and redirect…" | kind=Commit | source=git | neighbors=[7a4966f chore: add Android builds v26.7…, main, ab7968d it ignored my command lets see …, c8874a6 chore: add Android builds v26.7…, pyq_tab_screen.dart, source_pdf_upload_screen.dart] | lang=en
- "dev_programming_slides_screen": "programming_slides_screen.dart" | kind=code-symbol | source=lib/screens/dev/programming_slides_screen.dart:L1 | neighbors=[5621c28 v26.8.8: Integrated SeriousPyth…, 9d1d7bc NAA, a22f95b feat: complete celestial light …, _ProgramCard, _ProgramCardState, ProgrammingSlidesScreen] | lang=en
- "ide_code_ide_screen": "code_ide_screen.dart" | kind=code-symbol | source=lib/screens/ide/code_ide_screen.dart:L1 | neighbors=[329bdab ny, CodeIdeScreen, _CodeIdeScreenState, _deleteProject(), initState(), _loadProjects()] | lang=en
- "runner_win32_window_destroy": "Destroy()" | kind=code-symbol | source=windows/runner/win32_window.cpp:L224 | neighbors=[win32_window.h, Create(), CreateAndShow(), OnDestroy(), UnregisterWindowClass(), MessageHandler()] | lang=en
- "screens_exam_screen": "exam_screen.dart" | kind=code-symbol | source=lib/screens/exam_screen.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, df7e28f theme: migrate pdf_browser, exp…, ExamScreen] | lang=en
- "services_code_storage_service": "code_storage_service.dart" | kind=code-symbol | source=lib/services/code_storage_service.dart:L1 | neighbors=[0b36b76 feat(release): v26.9.1 - Multi-…, 329bdab ny, CodeStorageService, deleteProject(), IdeProject, NotebookCell] | lang=en
- "services_guest_service": "guest_service.dart" | kind=code-symbol | source=lib/services/guest_service.dart:L1 | neighbors=[a22f95b feat: complete celestial light …, _generateUniqueGuestId(), getGuestId(), getGuestIdShort(), GuestService, isGuestId()] | lang=en
- "services_home_widget_service": "home_widget_service.dart" | kind=code-symbol | source=lib/services/home_widget_service.dart:L1 | neighbors=[7b676e4 v26.8.12: Update latest.md, ver…, _dispatch(), dispose(), Function(), HomeWidgetService, init()] | lang=en
- "services_next_up_service": "next_up_service.dart" | kind=code-symbol | source=lib/services/next_up_service.dart:L1 | neighbors=[9535e64 k, 9864444 feat: onboarding walkthrough, a…, a22f95b feat: complete celestial light …, NextUp, NextUpService, resolve()] | lang=en
- "slide_views_interactive_webview": "interactive_webview.dart" | kind=code-symbol | source=lib/widgets/slide_views/interactive_webview.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 996d33b theme: migrate remaining small …, a22f95b feat: complete celestial light …, InteractiveWebview] | lang=en
- "test_slide_parsing_test": "slide_parsing_test.dart" | kind=code-symbol | source=test/slide_parsing_test.dart:L1 | neighbors=[1fa1705 OK, 3b989f1 Bump version to 26.7.22+2026072…, 3d09abf fix: slide interaction and cont…, 7dbab59 Merge pull request #2 from ihja…, f10ef09 feat: metacognitive loop, four …, main()] | lang=en
- "widgets_calibration_card": "calibration_card.dart" | kind=code-symbol | source=lib/widgets/calibration_card.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, f10ef09 feat: metacognitive loop, four …, f23bb62 theme: migrate calibration/lear…] | lang=en
- "widgets_lazy_indexed_stack": "lazy_indexed_stack.dart" | kind=code-symbol | source=lib/widgets/lazy_indexed_stack.dart:L1 | neighbors=[67b95db OK, 75e16eb ok, a22f95b feat: complete celestial light …, didUpdateWidget(), initState(), LazyIndexedStack] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@0270948e4a3467970f0dababccd0d7a5416e20ce": "0270948 feat: move shared secrets to auth-gated Firestore (Phase 2)" | kind=Commit | source=git | neighbors=[main, 9864444 feat: onboarding walkthrough, a…, settings_screen.dart, ai_service.dart, b2_service.dart, 589f5de feat: deterministic contents-to…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@06c30be32d3d944d2af952f9ff35c4b8c53561eb": "06c30be theme: migrate lesson-complete + canvas views to semantic tokens" | kind=Commit | source=git | neighbors=[main, f77a46a ux: fix dead-ends and silent fa…, lesson_complete_screen.dart, canvas_art_view.dart, canvas_html_view.dart, be9dc1e ux: confetti burst and XP count…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@085e90da6edeae86da3d2723f5c7387c1f720f69": "085e90d quick fix" | kind=Commit | source=git | neighbors=[main, 9b43b6d chore: add Android and Windows …, home_screen.dart, summary_screen.dart, database_service.dart, 9ecc455 chore: add Android and Windows …] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@1eb22ce15a4b9c2a89ad540eca53f5f25cf26715": "1eb22ce theme: migrate generating_book_card, book_card, repair_alignment_dialog" | kind=Commit | source=git | neighbors=[main, 6fe7291 theme: migrate canvas_art_view …, book_card.dart, generating_book_card.dart, repair_alignment_dialog.dart, b6ffe85 theme: migrate lesson_node, syn…] | lang=fr
- "commit:repo:github.com/ihjas-ahammed/duofy@29343084eb91d6d8c5972e95d97701f5d7e27759": "2934308 theme: migrate metacognition_setup, pyq_complete, bookmarks screens" | kind=Commit | source=git | neighbors=[main, 69395fd theme: migrate section_selectio…, bookmarks_screen.dart, metacognition_setup_screen.dart, pyq_complete_screen.dart, d843901 theme: migrate ai_queue_screen] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@37cdd6b662b82ad31f8b3975591bc486681b847e": "37cdd6b Support interactive Python input() calls in PythonRunnerService and Pyt…" | kind=Commit | source=git | neighbors=[0774610 Update graphify index for CMake…, main, 081eccf Implement real-time Jupyter-sty…, python_ide_screen.dart, python_runner_service.dart, python_runner_test.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@4147f0be9553e3c5f8a20b603931f550a0258e44": "4147f0b Fix Android ProcessEnvironment reflection cast and enable live syntax h…" | kind=Commit | source=git | neighbors=[2835dd9 Rewrite CodeRunnerView natively…, main, 4344098 chore: add Android builds v26.7…, python_ide_screen.dart, code_runner_view.dart, code_highlighter.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@6a6426e12a88fbe36fe460fe954f029a335b4c3a": "6a6426e theme: migrate module_selector, section_selector, quiz_view" | kind=Commit | source=git | neighbors=[main, 1bb5af4 theme: migrate theory_view, module_selector.dart, section_selector.dart, quiz_view.dart, f6d94bf theme: migrate section_bottom_s…] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@92086cd51d5c0b2d533e695c12c3216ee8dbcc45": "92086cd theme: migrate duo_button, mini_progress_bar, compact_book_card" | kind=Commit | source=git | neighbors=[main, 3e9b205 theme: migrate descriptive/inte…, compact_book_card.dart, duo_button.dart, mini_progress_bar.dart, f77a46a ux: fix dead-ends and silent fa…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@d6812c1b0584694803498ada97dfe2ca7d3b0342": "d6812c1 feat: add Run now quick-run for scheduled AI tasks" | kind=Commit | source=git | neighbors=[9965175 feat: remove Pause AI feature; …, main, 3fb655e chore: update knowledge graph a…, ai_task.dart, ai_queue_screen.dart, generation_manager.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@e63dbacb9e2160061cec6cf865b691d64c159fa3": "e63dbac theme: migrate next_up_card, compact_book_list_item, community_book_card" | kind=Commit | source=git | neighbors=[main, 9c0e7f3 theme: migrate safe_pdf_viewer,…, community_book_card.dart, compact_book_list_item.dart, next_up_card.dart, f23bb62 theme: migrate calibration/lear…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@ea4994a2135deaf0d85a1d573b0c72d0684d869f": "ea4994a Support program & try_yourself slide generation; reposition walkthrough…" | kind=Commit | source=git | neighbors=[main, 9535e64 k, prompt_service.dart, walkthrough_course_test.dart, walkthrough_banner.dart, f916a64 chore: add Android builds v26.7…] | lang=pt

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-005.json

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
