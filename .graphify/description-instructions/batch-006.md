# Node Description Batch 7 of 61

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

- "services_code_storage_service": "code_storage_service.dart" | kind=code-symbol | source=lib/services/code_storage_service.dart:L1 | neighbors=[329bdab ny, CodeStorageService, deleteProject(), IdeProject, NotebookCell, saveProject()] | lang=en
- "services_error_capture_service": "error_capture_service.dart" | kind=code-symbol | source=lib/services/error_capture_service.dart:L1 | neighbors=[859f766 new, CapturedError, clearAll(), dismissError(), ErrorCaptureService, reportError()] | lang=en
- "services_loading_progress_controller": "loading_progress_controller.dart" | kind=code-symbol | source=lib/services/loading_progress_controller.dart:L1 | neighbors=[859f766 new, LoadingProgressController, LoadingStep, startLoading(), stopLoading(), updateStep()] | lang=en
- "services_module_notes_html_builder": "module_notes_html_builder.dart" | kind=code-symbol | source=lib/services/module_notes_html_builder.dart:L1 | neighbors=[14e7263 feat: Quick Generate Module Not…, 5621c28 v26.8.8: Integrated SeriousPyth…, buildHtml(), _escapeHtml(), ModuleNotesHtmlBuilder, study] | lang=en
- "services_personalization_service": "personalization_service.dart" | kind=code-symbol | source=lib/services/personalization_service.dart:L1 | neighbors=[a22f95b feat: complete celestial light …, f10ef09 feat: metacognitive loop, four …, as, being, compileSystemPrompt(), PersonalizationService] | lang=en
- "slide_views_one_word_view": "one_word_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/one_word_view.dart:L1 | neighbors=[10204b5 theme: migrate one_word/numeric…, 12bf472 feat(release): overhaul PYQ tab…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, OneWordView] | lang=en
- "slide_views_step_by_step_view": "step_by_step_view.dart" | kind=code-symbol | source=lib/widgets/slide_views/step_by_step_view.dart:L1 | neighbors=[3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 996d33b theme: migrate remaining small …, a22f95b feat: complete celestial light …, StepByStepView, _StepByStepViewState] | lang=en
- "test_auto_index_pipeline_test": "auto_index_pipeline_test.dart" | kind=code-symbol | source=test/auto_index_pipeline_test.dart:L1 | neighbors=[1fa1705 OK, 4337110 feat: remove AI 10-page chunk s…, a316953 feat: add pure AutoIndexPipelin…, Harness, main(), noProgress()] | lang=en
- "test_mapping_verifier_test": "mapping_verifier_test.dart" | kind=code-symbol | source=test/mapping_verifier_test.dart:L1 | neighbors=[1fa1705 OK, ed71b03 io, _FakePdfService, main(), _NoAi, verifySectionMapping()] | lang=en
- "widgets_book_card": "book_card.dart" | kind=code-symbol | source=lib/widgets/book_card.dart:L1 | neighbors=[1393ac9 6th, 1eb22ce theme: migrate generating_book_…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, BookCard] | lang=en
- "widgets_community_book_card": "community_book_card.dart" | kind=code-symbol | source=lib/widgets/community_book_card.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, e63dbac theme: migrate next_up_card, co…, CommunityBookCard] | lang=en
- "widgets_generating_book_card": "generating_book_card.dart" | kind=code-symbol | source=lib/widgets/generating_book_card.dart:L1 | neighbors=[1393ac9 6th, 1eb22ce theme: migrate generating_book_…, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, a22f95b feat: complete celestial light …, GeneratingBookCard] | lang=en
- "widgets_ide_config_dialog": "ide_config_dialog.dart" | kind=code-symbol | source=lib/widgets/ide_config_dialog.dart:L1 | neighbors=[329bdab ny, IdeConfigDialog, _IdeConfigDialogState, initState(), show(), _update()] | lang=en
- "widgets_mini_progress_bar": "mini_progress_bar.dart" | kind=code-symbol | source=lib/widgets/mini_progress_bar.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 92086cd theme: migrate duo_button, mini…, a22f95b feat: complete celestial light …, MiniProgressBar] | lang=en
- "widgets_qp_card": "qp_card.dart" | kind=code-symbol | source=lib/widgets/qp_card.dart:L1 | neighbors=[1393ac9 6th, 3a768f9 style: dart format the files to…, 4ea5161 Merge pull request #3 from ihja…, 9c0e7f3 theme: migrate safe_pdf_viewer,…, a22f95b feat: complete celestial light …, QpCard] | lang=en
- "widgets_web_webview_helper": "web_webview_helper.dart" | kind=code-symbol | source=lib/widgets/web_webview_helper.dart:L1 | neighbors=[8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …, dispose(), initState(), WebWebViewWidget, _WebWebViewWidgetState] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@081eccfb3ba7db595bfcc2ad495de5f4477eb0ea": "081eccf Implement real-time Jupyter-style interactive input handling via socket…" | kind=Commit | source=git | neighbors=[main, 81cf620 Fix Python IDE title bar overfl…, python_ide_screen.dart, python_runner_service.dart, 37cdd6b Support interactive Python inpu…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@1dc8e69370fba824e94e1a88cc6dbf3f9f850c7f": "1dc8e69 fix(python & flashcard): fix Android Python output capture with JSON fi…" | kind=Commit | source=git | neighbors=[main, df113f4 chore: add Android builds v26.7…, lesson_screen.dart, python_runner_service.dart, 358ddb3 chore: add Android builds v26.7…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@25fb4a602b8bdd62e9e0d4cd8c4f7513495c0e49": "25fb4a6 fix: reset FlashcardView state when slide changes" | kind=Commit | source=git | neighbors=[main, 6b3299a chore: add Android builds v26.7…, lesson_screen.dart, flashcard_view.dart, d1b8076 chore: add Android builds v26.7…] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@65220a0676079a2e02d8117c0aff464cbb2dcaaa": "65220a0 fix: WebAssembly check and window.onerror diagnostics inside Python cod…" | kind=Commit | source=git | neighbors=[3f4d091 Merge branch 'main' of https://…, main, 4793d65 chore: add Android builds v26.7…, 4ac3990 new db, code_runner_view.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@69395fd68c68c515e2d827f848938b0795caa8ca": "69395fd theme: migrate section_selection, module_selection screens" | kind=Commit | source=git | neighbors=[2934308 theme: migrate metacognition_se…, main, df7e28f theme: migrate pdf_browser, exp…, module_selection_screen.dart, section_selection_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@742f017879da77a8c16b3cf6ee71f1b2035679cf": "742f017 feat: add offline TocMatcher heuristics for TOC/chapter detection" | kind=Commit | source=git | neighbors=[main, a316953 feat: add pure AutoIndexPipelin…, toc_matcher.dart, toc_matcher_test.dart, 916308a docs: add auto-indexing pipelin…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@81cf62066027ff17011a9b6e09d7944e3a43efa5": "81cf620 Fix Python IDE title bar overflow and integrate live Python execution i…" | kind=Commit | source=git | neighbors=[081eccf Implement real-time Jupyter-sty…, main, 2835dd9 Rewrite CodeRunnerView natively…, python_ide_screen.dart, program_view.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@99745d3b513b9ecbfc0e2a260749a6860026062a": "99745d3 theme: migrate GlassyNavBar and MathMarkdown to semantic tokens" | kind=Commit | source=git | neighbors=[main, 3d09abf fix: slide interaction and cont…, glassy_nav_bar.dart, math_markdown.dart, f2613a9 theme: celestial palette with l…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@a316953612c052d7b3485e76634253f65cd41db7": "a316953 feat: add pure AutoIndexPipeline stage-chain orchestration" | kind=Commit | source=git | neighbors=[742f017 feat: add offline TocMatcher he…, main, 808f4f6 feat: add AiService.optimizeInd…, auto_index_pipeline.dart, auto_index_pipeline_test.dart] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@b5b2ecb56b33db8fe0ac63a0a197f06bba4b14d9": "b5b2ecb fix: resolve incorrect deadline target calculations for un-generated le…" | kind=Commit | source=git | neighbors=[2508966 chore: add Android builds v26.7…, main, c04f5ba fix: resolve static analyzer in…, section_selection_screen.dart, deadline_service.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@ddd874efadb0ae18e899a000c184fe9718383b80": "ddd874e feat: toast all AI task failures via global scaffold messenger" | kind=Commit | source=git | neighbors=[4337110 feat: remove AI 10-page chunk s…, main, 9965175 feat: remove Pause AI feature; …, main.dart, generation_manager.dart] | lang=en
- "common_webview_plugin_handlemethodcall": "HandleMethodCall()" | kind=code-symbol | source=packages/webview_cef/common/webview_plugin.cc:L236 | neighbors=[webview_plugin.h, cursorAction(), initCallback(), startCEF(), stopCEF()] | lang=en
- "common_webview_value_webview_value_get_by_key": "webview_value_get_by_key()" | kind=code-symbol | source=packages/webview_cef/common/webview_value.cc:L752 | neighbors=[webview_value.h, webview_value_equals(), webview_value_get_map_value(), webview_value_lookup_index(), webview_value_get_by_string()] | lang=en
- "linux_webview_cef_keyevent": "webview_cef_keyevent.h" | kind=code-symbol | source=packages/webview_cef/linux/webview_cef_keyevent.h:L1 | neighbors=[GdkEventToWindowsKeyCode(), GetCefStateModifiers(), GetControlCharacter(), GetWindowsKeyCodeWithoutLocation(), KeyboardCodeFromXKeysym()] | lang=en
- "packup_pack_project": "pack_project()" | kind=code-symbol | source=packup.py:L188 | neighbors=[packup.py, is_likely_binary_file(), load_gitignore_patterns(), should_ignore(), Packs all relevant files into a single …] | lang=en
- "runner_main": "main.cpp" | kind=code-symbol | source=windows/runner/main.cpp:L1 | neighbors=[1fa1705 OK, 675d2a1 EXPRESS, eb38f80 Fix Linux quit handling, Linux …, main(), wWinMain()] | lang=en
- "runner_win32_window_createandshow": "CreateAndShow()" | kind=code-symbol | source=packages/webview_cef/example/windows/runner/win32_window.cpp:L105 | neighbors=[win32_window.h, Destroy(), GetWindowClass(), OnCreate(), Scale()] | lang=en
- "runner_win32_window_messagehandler": "MessageHandler()" | kind=code-symbol | source=windows/runner/win32_window.cpp:L176 | neighbors=[win32_window.h, Destroy(), GetClientArea(), UpdateTheme(), Win32Window::WndProc()] | lang=en
- "services_ide_settings_service": "ide_settings_service.dart" | kind=code-symbol | source=lib/services/ide_settings_service.dart:L1 | neighbors=[329bdab ny, IdeSettings, IdeSettingsService, loadSettings(), updateSettings()] | lang=en
- "utils_toast_utils": "toast_utils.dart" | kind=code-symbol | source=lib/utils/toast_utils.dart:L1 | neighbors=[1393ac9 6th, a055e9b PRE-RE, a22f95b feat: complete celestial light …, ea88f41 Farsan, showToast()] | lang=en
- "widgets_desktop_webview_stub": "desktop_webview_stub.dart" | kind=code-symbol | source=lib/widgets/desktop_webview_stub.dart:L1 | neighbors=[8554e22 feat: the web build compiles an…, a22f95b feat: complete celestial light …, DesktopWebView, desktopWebViewEnsureInitialized(), Function()] | lang=en
- "widgets_glassy_nav_bar": "glassy_nav_bar.dart" | kind=code-symbol | source=lib/widgets/glassy_nav_bar.dart:L1 | neighbors=[1393ac9 6th, 7dbab59 Merge pull request #2 from ihja…, 99745d3 theme: migrate GlassyNavBar and…, a22f95b feat: complete celestial light …, GlassyNavBar] | lang=en
- "widgets_walkthrough_banner": "walkthrough_banner.dart" | kind=code-symbol | source=lib/widgets/walkthrough_banner.dart:L1 | neighbors=[9d1d7bc NAA, a22f95b feat: complete celestial light …, ea4994a Support program & try_yourself …, _Card, WalkthroughBanner] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@0184924c054fbb57a045eff2cffa9dcf66e360e2": "0184924 theme: migrate analytics_view" | kind=Commit | source=git | neighbors=[main, 61c1ed4 theme: migrate quick_review_she…, analytics_view.dart, 1bb5af4 theme: migrate theory_view] | lang=en

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-006.json

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
