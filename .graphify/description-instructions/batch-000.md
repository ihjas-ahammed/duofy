# Node Description Batch 1 of 61

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

- "branch:repo:github.com/ihjas-ahammed/duofy#main": "main" | kind=Branch | source=git | neighbors=[00fdc1a chore: add Android builds v26.7…, 010c32d chore: add Android and Windows …, 0184924 theme: migrate analytics_view, 01d6dd3 Merge branch 'main' of https://…, 0270948 feat: move shared secrets to au…, 039f2fe theme: migrate generate_qp, pdf…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@a22f95bafa746a0b88c687eef64f1ff425d1eb54": "a22f95b feat: complete celestial light theme refactor, username auth (@flow.in)…" | kind=Commit | source=git | neighbors=[137f329 chore: add Android builds v26.7…, section_bottom_sheet.dart, main, de5fd9a chore: add Android builds v26.7…, programming_slides_screen.dart, fb_auth.dart] | lang=en
- "services_generation_manager": "generation_manager.dart" | kind=code-symbol | source=lib/services/generation_manager.dart:L1 | neighbors=[0a59fe5 Merge pull request #4 from ihja…, 12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 329bdab ny, 3cff7f6 REALLY!, 4337110 feat: remove AI 10-page chunk s…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@1393ac9b56a739a3e24c4bc31b9a79a589669728": "1393ac9 6th" | kind=Commit | source=git | neighbors=[section_bottom_sheet.dart, main, 274559d Merge branch 'main' of https://…, main.dart, onboarding_screen.dart, ai_providers_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@4ea5161cae86d8b42256522a8e61eea0890c4f5c": "4ea5161 Merge pull request #3 from ihjas-ahammed/sirius" | kind=Commit | source=git | neighbors=[section_bottom_sheet.dart, main, 819cacb chore: add Android builds v26.7…, ai_queue_screen.dart, auth_screen.dart, book_dashboard_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@3a768f9c81f961fc78dda298b99eb4c94308cbd9": "3a768f9 style: dart format the files touched by the theme migration" | kind=Commit | source=git | neighbors=[section_bottom_sheet.dart, main, a5bf9c1 A, ai_queue_screen.dart, auth_screen.dart, book_dashboard_screen.dart] | lang=en
- "services_ai_service": "ai_service.dart" | kind=code-symbol | source=lib/services/ai_service.dart:L1 | neighbors=[0270948 feat: move shared secrets to au…, 0a59fe5 Merge pull request #4 from ihja…, 12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 2dfddb1 z, 329bdab ny] | lang=en
- "screens_book_dashboard_screen": "book_dashboard_screen.dart" | kind=code-symbol | source=lib/screens/book_dashboard_screen.dart:L1 | neighbors=[0a59fe5 Merge pull request #4 from ihja…, 12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 2d60cdb feat: add AI provider model tes…, 2dfddb1 z, 3a768f9 style: dart format the files to…] | lang=en
- "screens_home_screen": "home_screen.dart" | kind=code-symbol | source=lib/screens/home_screen.dart:L1 | neighbors=[085e90d quick fix, 12bf472 feat(release): overhaul PYQ tab…, 1322f3d ASZ, 1393ac9 6th, 1fa1705 OK, 2dfddb1 z] | lang=en
- "screens_lesson_screen": "lesson_screen.dart" | kind=code-symbol | source=lib/screens/lesson_screen.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 1dc8e69 fix(python & flashcard): fix An…, 1fa1705 OK, 25fb4a6 fix: reset FlashcardView state …, 3a768f9 style: dart format the files to…] | lang=en
- "common_webview_handler": "webview_handler.h" | kind=code-symbol | source=packages/webview_cef/common/webview_handler.h:L1 | neighbors=[changeSize(), CloseAllBrowsers(), closeBrowser(), createBrowser(), cursorClick(), cursorMove()] | lang=en
- "widgets_safe_pdf_viewer": "safe_pdf_viewer.dart" | kind=code-symbol | source=lib/widgets/safe_pdf_viewer.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 8554e22 feat: the web build compiles an…, 9c0e7f3 theme: migrate safe_pdf_viewer,…, a22f95b feat: complete celestial light …] | lang=en
- "common_webview_value": "webview_value.h" | kind=code-symbol | source=packages/webview_cef/common/webview_value.h:L1 | neighbors=[webview_ptr_array_add(), webview_ptr_array_free(), webview_ptr_array_index(), webview_ptr_array_new_with_free_func(), webview_ptr_array_unref(), webview_value_append()] | lang=en
- "models_app_models": "app_models.dart" | kind=code-symbol | source=lib/models/app_models.dart:L1 | neighbors=[0a59fe5 Merge pull request #4 from ihja…, 11cc12c feat: cumulative sequential dea…, 12bf472 feat(release): overhaul PYQ tab…, 2d60cdb feat: add AI provider model tes…, 2dfddb1 z, 329bdab ny] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@8554e22a6a257ae69565c79a4cb136ae2e1a09b4": "8554e22 feat: the web build compiles and runs (Phase 5)" | kind=Commit | source=git | neighbors=[main, 46cb1a9 chore: release engineering for …, fb_auth.dart, fb_core.dart, fb_firestore.dart, fd_backend.dart] | lang=en
- "screens_generate_book_screen": "generate_book_screen.dart" | kind=code-symbol | source=lib/screens/generate_book_screen.dart:L1 | neighbors=[0a59fe5 Merge pull request #4 from ihja…, 1393ac9 6th, 329bdab ny, 3a768f9 style: dart format the files to…, 482623d feat: remove manual indexing-me…, 4c8673e OKKK] | lang=en
- "ide_latex_ide_screen": "latex_ide_screen.dart" | kind=code-symbol | source=lib/screens/ide/latex_ide_screen.dart:L1 | neighbors=[329bdab ny, 5621c28 v26.8.8: Integrated SeriousPyth…, df34d11 Fix latex, peace, dispose(), _generateOfflinePdf(), initState()] | lang=en
- "platform_io_stub": "io_stub.dart" | kind=code-symbol | source=lib/platform/io_stub.dart:L1 | neighbors=[8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …, add(), close(), connect(), copy()] | lang=en
- "screens_document_store_screen": "document_store_screen.dart" | kind=code-symbol | source=lib/screens/document_store_screen.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4c8673e OKKK, 4ea5161 Merge pull request #3 from ihja…, 8554e22 feat: the web build compiles an…, 859f766 new] | lang=en
- "services_database_service": "database_service.dart" | kind=code-symbol | source=lib/services/database_service.dart:L1 | neighbors=[085e90d quick fix, 12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 1fa1705 OK, 3b989f1 Bump version to 26.7.22+2026072…, 4ac3990 new db] | lang=en
- "services_prompt_service": "prompt_service.dart" | kind=code-symbol | source=lib/services/prompt_service.dart:L1 | neighbors=[0a59fe5 Merge pull request #4 from ihja…, 12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 2d60cdb feat: add AI provider model tes…, 329bdab ny, 3cff7f6 REALLY!] | lang=en
- "screens_settings_screen": "settings_screen.dart" | kind=code-symbol | source=lib/screens/settings_screen.dart:L1 | neighbors=[0270948 feat: move shared secrets to au…, 1322f3d ASZ, 1393ac9 6th, 1fa1705 OK, 3a768f9 style: dart format the files to…, 3b989f1 Bump version to 26.7.22+2026072…] | lang=en
- "services_python_runner_service": "python_runner_service.dart" | kind=code-symbol | source=lib/services/python_runner_service.dart:L1 | neighbors=[081eccf Implement real-time Jupyter-sty…, 1dc8e69 fix(python & flashcard): fix An…, 37cdd6b Support interactive Python inpu…, 5621c28 v26.8.8: Integrated SeriousPyth…, 8a51c13 fix(python & formats): disable …, a22f95b feat: complete celestial light …] | lang=en
- "screens_section_selection_screen": "section_selection_screen.dart" | kind=code-symbol | source=lib/screens/section_selection_screen.dart:L1 | neighbors=[11cc12c feat: cumulative sequential dea…, 12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 14e7263 feat: Quick Generate Module Not…, 2dfddb1 z, 3a768f9 style: dart format the files to…] | lang=en
- "screens_source_pdf_upload_screen": "source_pdf_upload_screen.dart" | kind=code-symbol | source=lib/screens/source_pdf_upload_screen.dart:L1 | neighbors=[0498e66 theme: migrate source_pdf_uploa…, 0a59fe5 Merge pull request #4 from ihja…, 12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 3a768f9 style: dart format the files to…, 4c8673e OKKK] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@12bf472265996abacff450b8e43b63f108e657e4": "12bf472 feat(release): overhaul PYQ tab screen, enhance LaTeX math rendering, u…" | kind=Commit | source=git | neighbors=[main, 348ad55 fx g, app_models.dart, auth_screen.dart, book_dashboard_screen.dart, course_settings_screen.dart] | lang=en
- "screens_module_selection_screen": "module_selection_screen.dart" | kind=code-symbol | source=lib/screens/module_selection_screen.dart:L1 | neighbors=[11cc12c feat: cumulative sequential dea…, 12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 14e7263 feat: Quick Generate Module Not…, 2dfddb1 z, 3a768f9 style: dart format the files to…] | lang=en
- "widgets_lesson_path": "lesson_path.dart" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L1 | neighbors=[07c7464 theme: migrate lesson_path, 11cc12c feat: cumulative sequential dea…, 12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 3a768f9 style: dart format the files to…, 3cff7f6 REALLY!] | lang=en
- "widgets_canvas_html_view": "canvas_html_view.dart" | kind=code-symbol | source=lib/widgets/canvas_html_view.dart:L1 | neighbors=[06c30be theme: migrate lesson-complete …, 11cc12c feat: cumulative sequential dea…, 1393ac9 6th, 3a768f9 style: dart format the files to…, 3cff7f6 REALLY!, 3d09abf fix: slide interaction and cont…] | lang=en
- "lib_main": "main.dart" | kind=code-symbol | source=packages/webview_cef/example/lib/main.dart:L1 | neighbors=[1393ac9 6th, 1fa1705 OK, 3cff7f6 REALLY!, 5621c28 v26.8.8: Integrated SeriousPyth…, 675d2a1 EXPRESS, 7dbab59 Merge pull request #2 from ihja…] | lang=en
- "screens_course_edit_structure_screen": "course_edit_structure_screen.dart" | kind=code-symbol | source=lib/screens/course_edit_structure_screen.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 3cff7f6 REALLY!, 4ea5161 Merge pull request #3 from ihja…, 8554e22 feat: the web build compiles an…, a08a7bd FIX #1] | lang=en
- "slide_views_code_runner_view": "code_runner_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/code_runner_view.dart:L1 | neighbors=[2835dd9 Rewrite CodeRunnerView natively…, 4147f0b Fix Android ProcessEnvironment …, 4ea21ab fix: loadPyodide loading timing…, 5621c28 v26.8.8: Integrated SeriousPyth…, 65220a0 fix: WebAssembly check and wind…, 67b95db OK] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@675d2a1cebc8f254b17df6656e5060540aaad25d": "675d2a1 EXPRESS" | kind=Commit | source=git | neighbors=[section_bottom_sheet.dart, main, 9ecc455 chore: add Android and Windows …, main.dart, app_models.dart, main.cpp] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@7dbab59cc6f29f6a8e78ba80e9f9c21755165e9e": "7dbab59 Merge pull request #2 from ihjas-ahammed/sirius" | kind=Commit | source=git | neighbors=[1322f3d ASZ, main, f2b17bb chore: add Android builds v26.7…, main.dart, app_models.dart, onboarding_screen.dart] | lang=en
- "services_module_notes_service": "module_notes_service.dart" | kind=code-symbol | source=lib/services/module_notes_service.dart:L1 | neighbors=[14e7263 feat: Quick Generate Module Not…, 5621c28 v26.8.8: Integrated SeriousPyth…, addListener(), and, _buildNativePdfFromNotes(), _cleanLatexForNativePdf()] | lang=en
- "widgets_lesson_assistant_chat": "lesson_assistant_chat.dart" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 8554e22 feat: the web build compiles an…, 8a51c13 fix(python & formats): disable …, 9280539 theme: migrate lesson_assistant…] | lang=en
- "screens_pdf_split_preview_screen": "pdf_split_preview_screen.dart" | kind=code-symbol | source=lib/screens/pdf_split_preview_screen.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 3cff7f6 REALLY!, 4ea5161 Merge pull request #3 from ihja…, 6ed78cc theme: migrate pdf_split_previe…, 8554e22 feat: the web build compiles an…] | lang=en
- "screens_practice_screen": "practice_screen.dart" | kind=code-symbol | source=lib/screens/practice_screen.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 3a768f9 style: dart format the files to…, 4ac3990 new db, 4ea5161 Merge pull request #3 from ihja…, 675d2a1 EXPRESS] | lang=en
- "src_webview": "webview.dart" | kind=code-symbol | source=packages/webview_cef/lib/src/webview.dart:L1 | neighbors=[_assertJavascriptChannelNamesAreUnique(), _cursorClickDown(), _cursorClickUp(), _cursorDragging(), _cursorMove(), dispose()] | lang=en
- "widgets_math_markdown": "math_markdown.dart" | kind=code-symbol | source=lib/widgets/math_markdown.dart:L1 | neighbors=[12bf472 feat(release): overhaul PYQ tab…, 1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 7dbab59 Merge pull request #2 from ihja…, 99745d3 theme: migrate GlassyNavBar and…] | lang=en

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-000.json

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
