# Graph Report - .  (2026-08-10)

## Corpus Check
- Large corpus: 431 files · ~7,32,989 words. Semantic extraction will be expensive (many Claude tokens). Consider running on a subfolder, or use --no-semantic to run AST-only.

## Summary
- 2432 nodes · 3636 edges · 154 communities detected
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output
- Edge kinds: contains: 1982 · MODIFIES: 1106 · PARENT_OF: 210 · ON_BRANCH: 202 · calls: 125 · rationale_for: 6 · method: 5


## Input Scope
- Requested: auto
- Resolved: committed (source: default-auto)
- Included files: 431 · Candidates: 2600
- Excluded: 380 untracked · 46905 ignored · 1 sensitive · 2 missing committed
- Recommendation: Use --scope all or graphify.yaml inputs.corpus for a knowledge-base folder.

## Graph Freshness
- Built from Git commit: `63ce973`
- Compare this hash to `git rev-parse HEAD` before trusting freshness-sensitive graph output.
## God Nodes (most connected - your core abstractions)
1. `webview_value_new()` - 15 edges
2. `webview_value_equals()` - 15 edges
3. `webview_value_to_string()` - 15 edges
4. `Destroy()` - 7 edges
5. `Execute()` - 6 edges
6. `webview_ptr_array_index()` - 6 edges
7. `webview_value_lookup_index()` - 6 edges
8. `webview_value_set_take()` - 6 edges
9. `Create()` - 6 edges
10. `HandleMethodCall()` - 5 edges

## Surprising Connections (you probably didn't know these)
- `CreateAndShow()` --calls--> `Destroy()`  [EXTRACTED]
  packages/webview_cef/example/windows/runner/win32_window.cpp → windows/runner/win32_window.cpp
- `CreateAndShow()` --calls--> `GetWindowClass()`  [EXTRACTED]
  packages/webview_cef/example/windows/runner/win32_window.cpp → windows/runner/win32_window.cpp
- `CreateAndShow()` --calls--> `OnCreate()`  [EXTRACTED]
  packages/webview_cef/example/windows/runner/win32_window.cpp → windows/runner/win32_window.cpp
- `CreateAndShow()` --calls--> `Scale()`  [EXTRACTED]
  packages/webview_cef/example/windows/runner/win32_window.cpp → windows/runner/win32_window.cpp

## Communities

### Community 0 - "Community 0"
Cohesion: 0.03
Nodes (6): GenerationManager, GenerationTask, QpGenTask, the, UnitGenTask, when

### Community 1 - "Community 1"
Cohesion: 0.06
Nodes (54): main, 010c32d chore: add Android and Windows builds v26.6.30 [skip ci], 0184924 theme: migrate analytics_view, 0498e66 theme: migrate source_pdf_upload_screen, 07c4665 chore: add Android builds v26.7.15 [skip ci], 07c7464 theme: migrate lesson_path, 137f329 chore: add Android builds v26.7.22 [skip ci], 13b10df chore: add Android builds v27.0.0 [skip ci] (+46 more)

### Community 2 - "Community 2"
Cohesion: 0.04
Nodes (8): AiService, in, module, outlines, PyqExtractionResult, title, to, UnitManifestResult

### Community 3 - "Community 3"
Cohesion: 0.09
Nodes (49): webview_ptr_array_add(), webview_ptr_array_free(), webview_ptr_array_index(), webview_ptr_array_new_with_free_func(), webview_ptr_array_unref(), webview_value_append(), webview_value_append_take(), webview_value_destroy() (+41 more)

### Community 4 - "Community 4"
Cohesion: 0.04
Nodes (4): SafePdfViewer, SafePdfViewerController, _SafePdfViewerState, WebPdfTextSearchResult

### Community 6 - "Community 6"
Cohesion: 0.07
Nodes (21): 1393ac9 6th, 3a768f9 style: dart format the files touched by the theme migration, 9c0e7f3 theme: migrate safe_pdf_viewer, qp_card, canvas_html_view, smart_review_card, missing_files_banner, a5bf9c1 A, e63dbac theme: migrate next_up_card, compact_book_list_item, community_book_card, _ModuleRow, ModuleSelectorSheet, SectionSelector (+13 more)

### Community 7 - "Community 7"
Cohesion: 0.05
Nodes (10): BookDashboardScreen, _BookDashboardScreenState, _CustomFloatingActionButtonLocation, has, _IconHeaderButton, in, _MenuActionItem, now (+2 more)

### Community 8 - "Community 8"
Cohesion: 0.05
Nodes (9): DashedBorderPainter, LatexIdeScreen, _LatexIdeScreenState, LatexJsEngineManager, LatexJsScriptEditorDialog, _LatexJsScriptEditorDialogState, LatexPdfPreviewScreen, _LatexPdfPreviewScreenState (+1 more)

### Community 9 - "Community 9"
Cohesion: 0.05
Nodes (11): Directory, File, FileSystemEntity, FileSystemException, HttpException, IOException, Platform, Process (+3 more)

### Community 10 - "Community 10"
Cohesion: 0.06
Nodes (19): 0c1e4c0 chore: add Android builds v26.8.6 [skip ci], 458dd1e chore: add Android builds v26.8.1 [skip ci], 7e90faf chore: add Android builds v26.8.1 [skip ci], 8a51c13 fix(python & formats): disable R8 JNI minification for SeriousPython crash fix, expand default lesson formats catalog to 12+, update version code, a15c42e feat(daily-goals): Add Gamified Daily Goals system with 20 templates, infinite procedural goals, floating toasts, stats screen, and dark theme default (v26.8.1), c5f6e32 new, df34d11 Fix latex, peace, e18a31c chore: add Android builds v26.7.22 [skip ci] (+11 more)

### Community 11 - "Community 11"
Cohesion: 0.06
Nodes (21): 0a59fe5 Merge pull request #4 from ihjas-ahammed/sirius, 7f9ff8e io, Book, copyWith, CourseFolder, InteractiveStep, Lesson, LessonFormat (+13 more)

### Community 12 - "Community 12"
Cohesion: 0.09
Nodes (11): 8554e22 feat: the web build compiles and runs (Phase 5), a22f95b feat: complete celestial light theme refactor, username auth (@flow.in), course planner format optimizations, and GitHub releases check for updates (v26.7.25), de5fd9a chore: add Android builds v26.7.25 [skip ci], FdAuthBackend, FdFirestoreBackend, DesktopWebView, FileSelectionList, ResponsiveCenter (+3 more)

### Community 13 - "Community 13"
Cohesion: 0.06
Nodes (4): LessonScreen, _LessonScreenState, nextModIdx, nextSecIdx

### Community 14 - "Community 14"
Cohesion: 0.07
Nodes (13): 2934308 theme: migrate metacognition_setup, pyq_complete, bookmarks screens, 69395fd theme: migrate section_selection, module_selection screens, d843901 theme: migrate ai_queue_screen, df7e28f theme: migrate pdf_browser, experiments, exam, module_summary_detail screens, BookmarksScreen, _BookmarksScreenState, ExamScreen, MetacognitionSetupScreen (+5 more)

### Community 15 - "Community 15"
Cohesion: 0.07
Nodes (4): ab7968d it ignored my command lets see whta this will be, HomeScreen, _HomeScreenState, SearchResultItem

### Community 16 - "Community 16"
Cohesion: 0.08
Nodes (13): 0774610 Update graphify index for CMake site packages fix, 081eccf Implement real-time Jupyter-style interactive input handling via socket IPC, 2835dd9 Rewrite CodeRunnerView natively in pure Dart using PythonRunnerService, 37cdd6b Support interactive Python input() calls in PythonRunnerService and PythonIdeScreen, 4147f0b Fix Android ProcessEnvironment reflection cast and enable live syntax highlighting in Python inputs, 4344098 chore: add Android builds v26.7.22 [skip ci], 5aeefed chore: add Android builds v26.7.22 [skip ci], 81cf620 Fix Python IDE title bar overflow and integrate live Python execution into ProgramView lesson slides (+5 more)

### Community 17 - "Community 17"
Cohesion: 0.08
Nodes (14): 4ea5161 Merge pull request #3 from ihjas-ahammed/sirius, 819cacb chore: add Android builds v26.7.10 [skip ci], 996d33b theme: migrate remaining small slide_views, f6d94bf theme: migrate section_bottom_sheet, ConceptPiecesView, _TimelineLinePainter, CustomHtmlView, _CustomHtmlViewState (+6 more)

### Community 18 - "Community 18"
Cohesion: 0.07
Nodes (3): _PyplotStub, PythonExecutionResult, PythonRunnerService

### Community 19 - "Community 19"
Cohesion: 0.10
Nodes (17): 12bf472 feat(release): overhaul PYQ tab screen, enhance LaTeX math rendering, update release notes & bump version code to 2026072502 (v26.7.25), 1322f3d ASZ, 3d09abf fix: slide interaction and content-quality issues, 573536b rebrand: new Sirius black-hole app icon, 7dbab59 Merge pull request #2 from ihjas-ahammed/sirius, 99745d3 theme: migrate GlassyNavBar and MathMarkdown to semantic tokens, d361f24 chore: add Android builds v26.7.10 [skip ci], e9979c0 rebrand: rename app display name to Sirius (+9 more)

### Community 20 - "Community 20"
Cohesion: 0.07
Nodes (8): B2PdfViewerScreen, CategoryTabs, ConfirmNameDialog, _ConfirmNameDialogState, DocumentStoreScreen, _DocumentStoreScreenState, PdfThumbnailWidget, _PdfThumbnailWidgetState

### Community 21 - "Community 21"
Cohesion: 0.07
Nodes (6): _DocumentStorePickerDialog, _DocumentStorePickerDialogState, _DownloadProgressDialog, _DownloadProgressDialogState, GenerateBookScreen, _GenerateBookScreenState

### Community 22 - "Community 22"
Cohesion: 0.07
Nodes (3): WebView, WebViewController, WebViewState

### Community 23 - "Community 23"
Cohesion: 0.08
Nodes (7): and, ModuleNotesJob, ModuleNotesService, notes, sequentially, textbook, Title

### Community 24 - "Community 24"
Cohesion: 0.08
Nodes (6): button, CourseEditStructureScreen, _CourseEditStructureScreenState, _DownloadProgressDialog, _DownloadProgressDialogState, in

### Community 25 - "Community 25"
Cohesion: 0.09
Nodes (6): 2d60cdb feat: add AI provider model test debugger, practice-first programming planner, section plan reset, and fix SeriousPython native JNI bundle packaging, 675d2a1 EXPRESS, 74cc3a6 chore: add Android and Windows builds v26.6.24 [skip ci], a055e9b PRE-RE, PromptService, title

### Community 26 - "Community 26"
Cohesion: 0.09
Nodes (7): DocumentStorePickerDialog, DocumentStorePickerDialogState, DownloadProgressDialog, DownloadProgressDialogState, in, SourcePdfUploadScreen, _SourcePdfUploadScreenState

### Community 27 - "Community 27"
Cohesion: 0.09
Nodes (10): f23bb62 theme: migrate calibration/learner_profile/file_selection/daily_goal/ real_progress_bar/coach_mark/unit_header/string_list_manager, CalibrationCard, CoachMark, CoachMarkController, _HolePainter, DailyGoalCard, _DailyGoalCardState, _ResumeIconButton (+2 more)

### Community 28 - "Community 28"
Cohesion: 0.17
Nodes (17): Create(), CreateAndShow(), Destroy(), EnableFullDpiSupportIfAvailable(), GetClientArea(), GetThisFromHandle(), GetWindowClass(), MessageHandler() (+9 more)

### Community 29 - "Community 29"
Cohesion: 0.09
Nodes (1): DatabaseService

### Community 30 - "Community 30"
Cohesion: 0.09
Nodes (4): CanvasDoubleTapDetector, _CanvasDoubleTapDetectorState, _CanvasFullScreenScreen, CanvasHtmlView

### Community 31 - "Community 31"
Cohesion: 0.09
Nodes (10): _ActiveGeneratingNodeWrapper, _ActiveGeneratingNodeWrapperState, _Element, LessonPath, _LessonPathState, _PathConnectorPainter, _PathPoint, _SectionManifestPanel (+2 more)

### Community 32 - "Community 32"
Cohesion: 0.10
Nodes (2): SimpleBrowserViewDelegate, SimpleWindowDelegate

### Community 33 - "Community 33"
Cohesion: 0.10
Nodes (6): _BookmarkMatch, final, _MenuActionItem, ModuleSelectionScreen, _ModuleSelectionScreenState, now

### Community 34 - "Community 34"
Cohesion: 0.10
Nodes (4): _BookmarkMatch, _MenuActionItem, SectionSelectionScreen, _SectionSelectionScreenState

### Community 35 - "Community 35"
Cohesion: 0.10
Nodes (3): CodeRunnerHtml, CodeRunnerView, _CodeRunnerViewState

### Community 36 - "Community 36"
Cohesion: 0.10
Nodes (3): ChatMessage, LessonAssistantChat, _LessonAssistantChatState

### Community 37 - "Community 37"
Cohesion: 0.11
Nodes (11): 0270948 feat: move shared secrets to auth-gated Firestore (Phase 2), 269329e chore: add Android builds v26.7.12 [skip ci], 2e3bece chore: add Android builds v26.7.12 [skip ci], 589f5de feat: deterministic contents-to-pages mapping (Phase 1), 5f9d253 chore: add Android builds v26.7.10 [skip ci], 8938325 feat: layout-based course progress bars and secured Firestore API keys, aaf383b fix: update free capacity limits (Gemma 1.5k, Gemini Flash 20, Gemini Flash Lite 500), b59e77b fix: auto resolve sync conflicts with latest version, clean up sync conflict dialog, and fix SVG detection to prevent blank screen error (+3 more)

### Community 38 - "Community 38"
Cohesion: 0.10
Nodes (2): MathEvaluatorService, _MathParser

### Community 39 - "Community 39"
Cohesion: 0.10
Nodes (6): CalibrationStats, difficulty, MetacogEvent, MetacognitionService, ReviewItem, should

### Community 40 - "Community 40"
Cohesion: 0.11
Nodes (9): 039f2fe theme: migrate generate_qp, pdf_folder, reference_pdf_viewer, qp_detail, book_route_loader screens, c216a16 theme: migrate home, auth, settings, practice_session, onboarding screens, AuthScreen, _AuthScreenState, BookRouteLoaderScreen, _BookRouteLoaderScreenState, GenerateQpScreen, _GenerateQpScreenState (+1 more)

### Community 41 - "Community 41"
Cohesion: 0.11
Nodes (8): 085e90d quick fix, 9981c72 z, 9b43b6d chore: add Android and Windows builds v26.6.25 [skip ci], 9ecc455 chore: add Android and Windows builds v26.6.25 [skip ci], lecture, SummaryScreen, _SummaryScreenState, YoutubeVideo

### Community 42 - "Community 42"
Cohesion: 0.11
Nodes (3): B2Credentials, B2Object, B2Service

### Community 43 - "Community 43"
Cohesion: 0.11
Nodes (3): in, PdfBookmarkNode, PdfService

### Community 44 - "Community 44"
Cohesion: 0.11
Nodes (1): ProgressService

### Community 45 - "Community 45"
Cohesion: 0.11
Nodes (6): 10204b5 theme: migrate one_word/numerical/matching/ordering views, NumericalView, _NumericalViewState, OneWordView, OrderingView, _OrderingViewState

### Community 46 - "Community 46"
Cohesion: 0.11
Nodes (6): FdAuthBackend, _FdCollection, _FdDoc, FdFirestoreBackend, _FdUser, _FileTokenStore

### Community 47 - "Community 47"
Cohesion: 0.11
Nodes (5): AiProvidersScreen, _AiProvidersScreenState, TestAiChatMessage, TestAiDialog, _TestAiDialogState

### Community 48 - "Community 48"
Cohesion: 0.11
Nodes (3): in, PdfSplitPreviewScreen, _PdfSplitPreviewScreenState

### Community 49 - "Community 49"
Cohesion: 0.11
Nodes (9): in, _ModeCard, _ModuleRef, _PracticeMode, PracticeScreen, _PracticeScreenState, _SectionRef, that (+1 more)

### Community 50 - "Community 50"
Cohesion: 0.11
Nodes (7): _BlankBuilder, _BlankSyntax, _InlineBlankField, _InlineBlankFieldState, _MathBuilder, MathMarkdown, _PermissiveLatexInlineSyntax

### Community 51 - "Community 51"
Cohesion: 0.12
Nodes (3): and, PyqPanelScreen, _PyqPanelScreenState

### Community 52 - "Community 52"
Cohesion: 0.12
Nodes (3): currently, PyqTabScreen, _PyqTabScreenState

### Community 53 - "Community 53"
Cohesion: 0.13
Nodes (8): 329bdab ny, 348ad55 fx g, 7be050f Merge branch 'main' of https://github.com/ihjas-ahammed/duofy, 7cb1aa6 RMY, d68d72b XZ, da201f8 chore: add Android builds v26.7.25 [skip ci], MatchingView, _MatchingViewState

### Community 54 - "Community 54"
Cohesion: 0.14
Nodes (9): 4337110 feat: remove AI 10-page chunk scan; auto-index failures go straight to manual picker, 9965175 feat: remove Pause AI feature; interrupted tasks auto-resume, d6812c1 feat: add Run now quick-run for scheduled AI tasks, ddd874e feat: toast all AI task failures via global scaffold messenger, AiTask, AiQueueScreen, _AiQueueScreenState, in (+1 more)

### Community 55 - "Community 55"
Cohesion: 0.17
Nodes (7): cursorAction(), HandleMethodCall(), initCallback(), startCEF(), stopCEF(), uninitCallback(), WebviewPlugin()

### Community 56 - "Community 56"
Cohesion: 0.13
Nodes (9): _EmptyReviewPanel, _LoadingPanel, _LoadingPanelState, MatchingLessonResult, QuickReviewSheet, _QuickReviewSheetState, _ReviewItemCard, _StatementDetailSheet (+1 more)

### Community 57 - "Community 57"
Cohesion: 0.15
Nodes (12): 01d6dd3 Merge branch 'main' of https://github.com/ihjas-ahammed/duofy, 2b1de87 chore: add Android builds v26.7.25 [skip ci], 2ca4f58 chore: add Android builds v26.7.26 [skip ci], 67c2b34 chore: add Android builds v26.7.26 [skip ci], 845dfcb feat: fast offline-speed initial loading, real-time progress bar & background cloud sync (v26.7.28), 859f766 new, 9864444 feat: onboarding walkthrough, advanced mode, next-up hero, daily goal (Phase 3), bccabe4 pyq_meta all set (+4 more)

### Community 58 - "Community 58"
Cohesion: 0.14
Nodes (6): 14e7263 feat: Quick Generate Module Notes with MathJax TeX rendering, mobile responsiveness, and A4 PDF export (v26.8.7+2126080701), 5621c28 v26.8.8: Integrated SeriousPython multi-arch runtime, interactive notebook input, SVG plot renderer, and high-density study notes generator, 63ce973 Update app.zip and app.zip.hash for multi-arch x86_64 emulator support, e0cfdd0 chore: add Android builds v26.8.7 [skip ci], ModuleNotesHtmlBuilder, study

### Community 59 - "Community 59"
Cohesion: 0.13
Nodes (9): 1eb22ce theme: migrate generating_book_card, book_card, repair_alignment_dialog, 6fe7291 theme: migrate canvas_art_view placeholder card, b6ffe85 theme: migrate lesson_node, sync_conflict_dialog, BookCard, GeneratingBookCard, LessonNodeWidget, _LessonNodeWidgetState, NextNodePop (+1 more)

### Community 60 - "Community 60"
Cohesion: 0.13
Nodes (5): 2dfddb1 z, ed71b03 io, currently, MainLayoutScreen, _MainLayoutScreenState

### Community 61 - "Community 61"
Cohesion: 0.13
Nodes (4): CourseSettingsScreen, _CourseSettingsScreenState, FormatEditorScreen, _FormatEditorScreenState

### Community 62 - "Community 62"
Cohesion: 0.13
Nodes (1): UsageLimitService

### Community 63 - "Community 63"
Cohesion: 0.13
Nodes (2): InteractiveProofView, _InteractiveProofViewState

### Community 64 - "Community 64"
Cohesion: 0.15
Nodes (12): 061977c chore: add Android builds v26.7.15 [skip ci], 317ac5d Merge branch 'main' of https://github.com/ihjas-ahammed/duofy, 3b989f1 Bump version to 26.7.22+2026072201, fix concept split view, and expand cloud storage sync, 3f4d091 Merge branch 'main' of https://github.com/ihjas-ahammed/duofy, 4793d65 chore: add Android builds v26.7.15 [skip ci], 4ac3990 new db, 4ead8b6 z, 65220a0 fix: WebAssembly check and window.onerror diagnostics inside Python code runner (+4 more)

### Community 65 - "Community 65"
Cohesion: 0.14
Nodes (2): 1fa1705 OK, Harness

### Community 66 - "Community 66"
Cohesion: 0.14
Nodes (3): in, PracticeSessionScreen, _PracticeSessionScreenState

### Community 67 - "Community 67"
Cohesion: 0.14
Nodes (2): PyqAnalysisJob, PyqExamService

### Community 68 - "Community 68"
Cohesion: 0.14
Nodes (2): UpdateInfo, UpdateService

### Community 69 - "Community 69"
Cohesion: 0.18
Nodes (6): 00fdc1a chore: add Android builds v26.7.12 [skip ci], 11cc12c feat: cumulative sequential deadline targets, dynamic page-scaled lesson estimator, glassmorphic targets button, manual lesson complete transitions, 2508966 chore: add Android builds v26.7.12 [skip ci], b5b2ecb fix: resolve incorrect deadline target calculations for un-generated lessons by using standard averages (12 lessons per empty section, 4 per empty unit), c04f5ba fix: resolve static analyzer invalid_assignment error by casting dynamic receiver lessons length to int, DeadlineService

### Community 70 - "Community 70"
Cohesion: 0.21
Nodes (6): encode_flvalue_to_wvalue(), encode_wavlue_to_flvalue(), method_call_cb(), webview_cef_plugin_handle_method_call(), webview_cef_plugin_register_with_registrar(), WebviewTextureRenderer

### Community 71 - "Community 71"
Cohesion: 0.15
Nodes (4): ExperimentPreviewScreen, _ExperimentPreviewScreenState, ExperimentsScreen, _ExperimentsScreenState

### Community 72 - "Community 72"
Cohesion: 0.15
Nodes (3): in, ReferencePdfViewerScreen, _ReferencePdfViewerScreenState

### Community 73 - "Community 73"
Cohesion: 0.15
Nodes (1): WebviewManager

### Community 74 - "Community 74"
Cohesion: 0.17
Nodes (12): 0eaaf59 chore: add Android builds v26.7.15 [skip ci], 1e1860b chore: add Android builds v26.7.12 [skip ci], 25fb4a6 fix: reset FlashcardView state when slide changes, 39500a4 fix: correct deadline target count math in app_models, 4026742 chore: add Android builds v26.7.12 [skip ci], 5d06f7a feat: implement Auto-Next lesson flow and AI-CROSS check QA verification, 6b3299a chore: add Android builds v26.7.12 [skip ci], bed7aca chore: add Android builds v26.7.15 [skip ci] (+4 more)

### Community 75 - "Community 75"
Cohesion: 0.17
Nodes (6): 18142cc chore: add Android builds v26.7.15 [skip ci], 4c8673e OKKK, PlatformWebView, PlatformWebViewBootstrap, PlatformWebViewController, _PlatformWebViewState

### Community 76 - "Community 76"
Cohesion: 0.18
Nodes (6): 3e9b205 theme: migrate descriptive/interactive_proof/fill_in_blank/pyq_one_word views, 92086cd theme: migrate duo_button, mini_progress_bar, compact_book_card, f77a46a ux: fix dead-ends and silent failures across lessons and home, _BlankOption, FillInBlankView, _FillInBlankViewState

### Community 77 - "Community 77"
Cohesion: 0.17
Nodes (8): _CfCollection, _CfDoc, _CfFirestore, FbCollectionRef, FbDocRef, FbDocSnapshot, FbFirestore, FbQuerySnapshot

### Community 78 - "Community 78"
Cohesion: 0.17
Nodes (4): CanvasArtView, _CanvasArtViewState, _CanvasPlaceholder, _CanvasPlaceholderState

### Community 79 - "Community 79"
Cohesion: 0.17
Nodes (3): CodeEditingController, CodeHighlighter, CodeTheme

### Community 80 - "Community 80"
Cohesion: 0.18
Nodes (4): 06c076e chore: add Android builds v26.7.10 [skip ci], 3cff7f6 REALLY!, MappingReport, MappingVerifier

### Community 81 - "Community 81"
Cohesion: 0.27
Nodes (6): CallCppFunction(), ConvertCefV8ValueToJSValue(), EvaluateCallback(), Execute(), GetNextReqID(), StartRequest()

### Community 82 - "Community 82"
Cohesion: 0.18
Nodes (5): _FaAuth, _FaUser, FbAuth, FbAuthException, FbUser

### Community 83 - "Community 83"
Cohesion: 0.18
Nodes (2): PythonNotebookScreen, _PythonNotebookScreenState

### Community 84 - "Community 84"
Cohesion: 0.18
Nodes (2): DesktopWebView, _DesktopWebViewState

### Community 85 - "Community 85"
Cohesion: 0.20
Nodes (3): Main, UniversalCodeRunnerScreen, _UniversalCodeRunnerScreenState

### Community 87 - "Community 87"
Cohesion: 0.20
Nodes (4): _CodePanel, _CodePanelState, ProgramView, _ProgramViewState

### Community 88 - "Community 88"
Cohesion: 0.20
Nodes (2): AnalyticsView, _AnalyticsViewState

### Community 89 - "Community 89"
Cohesion: 0.20
Nodes (4): FloatingDailyGoalListener, _FloatingDailyGoalListenerState, FloatingDailyGoalToast, _FloatingDailyGoalToastState

### Community 90 - "Community 90"
Cohesion: 0.29
Nodes (5): encode_flvalue_to_wvalue(), encode_wvalue_to_flvalue(), HandleMethodCall(), RegisterWithRegistrar(), WebviewTextureRenderer

### Community 91 - "Community 91"
Cohesion: 0.25
Nodes (6): 06c30be theme: migrate lesson-complete + canvas views to semantic tokens, be9dc1e ux: confetti burst and XP count-up on lesson complete, e02893d ux: answer feedback and interaction polish in lessons, difficulty, LessonCompleteScreen, _LessonCompleteScreenState

### Community 92 - "Community 92"
Cohesion: 0.31
Nodes (8): is_likely_binary_file(), load_gitignore_patterns(), pack_project(), Checks if a file is likely binary based on its extension or content., Packs all relevant files into a single text file., Loads patterns from .gitignore file in the root directory., Checks if a given path (relative to project root) should be ignored.     Uses .g, should_ignore()

### Community 93 - "Community 93"
Cohesion: 0.22
Nodes (3): PdfFileMeta, PdfFolderScreen, _PdfFolderScreenState

### Community 94 - "Community 94"
Cohesion: 0.22
Nodes (3): PyqExamDetailScreen, PyqScoreHistoryScreen, _PyqScoreHistoryScreenState

### Community 95 - "Community 95"
Cohesion: 0.22
Nodes (2): Bookmark, BookmarkService

### Community 96 - "Community 96"
Cohesion: 0.22
Nodes (2): GlobalState, is

### Community 97 - "Community 97"
Cohesion: 0.22
Nodes (1): NotificationService

### Community 98 - "Community 98"
Cohesion: 0.22
Nodes (2): PageMapping, ResolvedRanges

### Community 99 - "Community 99"
Cohesion: 0.22
Nodes (2): DescriptiveView, _DescriptiveViewState

### Community 100 - "Community 100"
Cohesion: 0.29
Nodes (5): 05a15cd chore: add Android builds v26.7.15 [skip ci], 67b95db OK, 75e16eb ok, LazyIndexedStack, _LazyIndexedStackState

### Community 101 - "Community 101"
Cohesion: 0.29
Nodes (5): 9535e64 k, 9d1d7bc NAA, ea4994a Support program & try_yourself slide generation; reposition walkthrough banner; fully populate walkthrough course assets, _Card, WalkthroughBanner

### Community 102 - "Community 102"
Cohesion: 0.25
Nodes (4): f10ef09 feat: metacognitive loop, four new exercise types, learner profile v2, prompt overhaul (Phase 4), as, being, PersonalizationService

### Community 103 - "Community 103"
Cohesion: 0.25
Nodes (2): ModuleNotesViewerScreen, _ModuleNotesViewerScreenState

### Community 104 - "Community 104"
Cohesion: 0.25
Nodes (3): PdfBrowserScreen, _PdfBrowserScreenState, PdfFolderMeta

### Community 105 - "Community 105"
Cohesion: 0.25
Nodes (2): PyqExamScreen, _PyqExamScreenState

### Community 106 - "Community 106"
Cohesion: 0.25
Nodes (2): ActiveRequestInfo, AiEstimator

### Community 107 - "Community 107"
Cohesion: 0.25
Nodes (2): AutoIndexPipeline, AutoIndexResult

### Community 108 - "Community 108"
Cohesion: 0.25
Nodes (1): DailyGoalsService

### Community 109 - "Community 109"
Cohesion: 0.25
Nodes (3): index, overview, TocMatcher

### Community 110 - "Community 110"
Cohesion: 0.25
Nodes (2): PyqOneWordView, _PyqOneWordViewState

### Community 111 - "Community 111"
Cohesion: 0.25
Nodes (2): LatexUtils, _TextPart

### Community 112 - "Community 112"
Cohesion: 0.25
Nodes (2): LearnerProfileCard, _LearnerProfileCardState

### Community 113 - "Community 113"
Cohesion: 0.25
Nodes (3): _DownloadProgress, UpdateDialog, _UpdateDialogState

### Community 114 - "Community 114"
Cohesion: 0.29
Nodes (3): SectionBottomSheet, _SectionBottomSheetState, _SectionCard

### Community 115 - "Community 115"
Cohesion: 0.29
Nodes (5): 994c7de chore: add Android and Windows builds v26.6.5 [skip ci], b807fe5 sd, c476ed9 555555555555555555555555555upp, da7e93c Merge branch 'main' of https://github.com/ihjas-ahammed/duofy, FbCore

### Community 116 - "Community 116"
Cohesion: 0.29
Nodes (2): CodeIdeScreen, _CodeIdeScreenState

### Community 117 - "Community 117"
Cohesion: 0.29
Nodes (2): HtmlIdeScreen, _HtmlIdeScreenState

### Community 119 - "Community 119"
Cohesion: 0.29
Nodes (1): GuestService

### Community 120 - "Community 120"
Cohesion: 0.29
Nodes (1): LearningSync

### Community 121 - "Community 121"
Cohesion: 0.29
Nodes (1): WalkthroughService

### Community 122 - "Community 122"
Cohesion: 0.29
Nodes (1): SectionColors

### Community 123 - "Community 123"
Cohesion: 0.29
Nodes (3): ComboBadge, _ComboBadgeState, _ComboStyle

### Community 124 - "Community 124"
Cohesion: 0.29
Nodes (2): RealProgressBar, _RealProgressBarState

### Community 125 - "Community 125"
Cohesion: 0.29
Nodes (2): StringListManager, StringListManagerState

### Community 126 - "Community 126"
Cohesion: 0.33
Nodes (6): executeJavaScript(), GetCallbackId(), OnProcessMessageReceived(), OnTakeFocus(), setJavaScriptChannels(), to_string()

### Community 127 - "Community 127"
Cohesion: 0.40
Nodes (2): GdkEventToWindowsKeyCode(), KeyboardCodeFromXKeysym()

### Community 128 - "Community 128"
Cohesion: 0.33
Nodes (2): DailyGoalsScreen, _DailyGoalsScreenState

### Community 129 - "Community 129"
Cohesion: 0.33
Nodes (3): CodeStorageService, IdeProject, NotebookCell

### Community 130 - "Community 130"
Cohesion: 0.33
Nodes (2): CapturedError, ErrorCaptureService

### Community 131 - "Community 131"
Cohesion: 0.33
Nodes (2): LoadingProgressController, LoadingStep

### Community 132 - "Community 132"
Cohesion: 0.33
Nodes (4): DuoButton, _DuoButtonState, DuoIconButton, _DuoIconButtonState

### Community 133 - "Community 133"
Cohesion: 0.33
Nodes (2): IdeConfigDialog, _IdeConfigDialogState

### Community 134 - "Community 134"
Cohesion: 0.33
Nodes (2): LessonAccordion, _LessonAccordionState

### Community 135 - "Community 135"
Cohesion: 0.50
Nodes (2): getVisitedCookies(), Visit()

### Community 136 - "Community 136"
Cohesion: 0.40
Nodes (4): _ProgramCard, _ProgramCardState, ProgrammingSlidesScreen, _RunnerCard

### Community 139 - "Community 139"
Cohesion: 0.40
Nodes (1): AutoIndexService

### Community 140 - "Community 140"
Cohesion: 0.40
Nodes (2): IdeSettings, IdeSettingsService

### Community 141 - "Community 141"
Cohesion: 0.40
Nodes (2): NextUp, NextUpService

### Community 142 - "Community 142"
Cohesion: 0.40
Nodes (2): _FakePdfService, _NoAi

### Community 143 - "Community 143"
Cohesion: 0.50
Nodes (4): parse_snapshot(), Parses the snapshot content and yields (filename, file_content) tuples., Reads the snapshot file and updates the project files accordingly., update_project_from_snapshot()

### Community 144 - "Community 144"
Cohesion: 0.50
Nodes (2): that, WebviewCefPlatform

### Community 145 - "Community 145"
Cohesion: 0.50
Nodes (3): PyqExamAttempt, PyqItem, PyqQuestionAnswer

### Community 146 - "Community 146"
Cohesion: 0.67
Nodes (2): GetCommandLineArguments(), Utf8FromUtf16()

### Community 147 - "Community 147"
Cohesion: 0.50
Nodes (2): InjectUserScripts, UserScript

### Community 148 - "Community 148"
Cohesion: 0.50
Nodes (2): JavascriptChannel, JavascriptMessage

### Community 149 - "Community 149"
Cohesion: 0.50
Nodes (1): WebviewTooltip

### Community 150 - "Community 150"
Cohesion: 0.50
Nodes (1): MockWebviewCefPlatform

### Community 151 - "Community 151"
Cohesion: 0.50
Nodes (2): DailyGoalsCompleteCard, _DailyGoalsCompleteCardState

### Community 152 - "Community 152"
Cohesion: 1.00
Nodes (3): GetCefKeyboardModifiers(), getCefKeyEvent(), IsKeyDown()

### Community 154 - "Community 154"
Cohesion: 0.67
Nodes (3): GetDataURI(), IsChromeRuntimeEnabled(), OnLoadError()

### Community 156 - "Community 156"
Cohesion: 0.67
Nodes (1): MethodChannelWebviewCef

### Community 157 - "Community 157"
Cohesion: 0.67
Nodes (1): WebviewEventsListener

### Community 159 - "Community 159"
Cohesion: 1.00
Nodes (2): loadUrl(), OnBeforePopup()

### Community 160 - "Community 160"
Cohesion: 1.00
Nodes (1): DefaultFirebaseOptions

### Community 161 - "Community 161"
Cohesion: 1.00
Nodes (1): LucideIcons

## Knowledge Gaps
- **506 isolated node(s):** `DefaultFirebaseOptions`, `PopIntent`, `FlowApp`, `AiTask`, `SlideTemplate` (+501 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `Community 29`** (1 nodes): `DatabaseService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 32`** (2 nodes): `SimpleBrowserViewDelegate`, `SimpleWindowDelegate`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 38`** (2 nodes): `MathEvaluatorService`, `_MathParser`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 44`** (1 nodes): `ProgressService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 62`** (1 nodes): `UsageLimitService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 63`** (2 nodes): `InteractiveProofView`, `_InteractiveProofViewState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 65`** (2 nodes): `1fa1705 OK`, `Harness`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 67`** (2 nodes): `PyqAnalysisJob`, `PyqExamService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 68`** (2 nodes): `UpdateInfo`, `UpdateService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 73`** (1 nodes): `WebviewManager`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 83`** (2 nodes): `PythonNotebookScreen`, `_PythonNotebookScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 84`** (2 nodes): `DesktopWebView`, `_DesktopWebViewState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 88`** (2 nodes): `AnalyticsView`, `_AnalyticsViewState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 95`** (2 nodes): `Bookmark`, `BookmarkService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 96`** (2 nodes): `GlobalState`, `is`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 97`** (1 nodes): `NotificationService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 98`** (2 nodes): `PageMapping`, `ResolvedRanges`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 99`** (2 nodes): `DescriptiveView`, `_DescriptiveViewState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 103`** (2 nodes): `ModuleNotesViewerScreen`, `_ModuleNotesViewerScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 105`** (2 nodes): `PyqExamScreen`, `_PyqExamScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 106`** (2 nodes): `ActiveRequestInfo`, `AiEstimator`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 107`** (2 nodes): `AutoIndexPipeline`, `AutoIndexResult`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 108`** (1 nodes): `DailyGoalsService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 110`** (2 nodes): `PyqOneWordView`, `_PyqOneWordViewState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 111`** (2 nodes): `LatexUtils`, `_TextPart`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 112`** (2 nodes): `LearnerProfileCard`, `_LearnerProfileCardState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 116`** (2 nodes): `CodeIdeScreen`, `_CodeIdeScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 117`** (2 nodes): `HtmlIdeScreen`, `_HtmlIdeScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 119`** (1 nodes): `GuestService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 120`** (1 nodes): `LearningSync`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 121`** (1 nodes): `WalkthroughService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 122`** (1 nodes): `SectionColors`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 124`** (2 nodes): `RealProgressBar`, `_RealProgressBarState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 125`** (2 nodes): `StringListManager`, `StringListManagerState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 127`** (2 nodes): `GdkEventToWindowsKeyCode()`, `KeyboardCodeFromXKeysym()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 128`** (2 nodes): `DailyGoalsScreen`, `_DailyGoalsScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 130`** (2 nodes): `CapturedError`, `ErrorCaptureService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 131`** (2 nodes): `LoadingProgressController`, `LoadingStep`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 133`** (2 nodes): `IdeConfigDialog`, `_IdeConfigDialogState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 134`** (2 nodes): `LessonAccordion`, `_LessonAccordionState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 135`** (2 nodes): `getVisitedCookies()`, `Visit()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 139`** (1 nodes): `AutoIndexService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 140`** (2 nodes): `IdeSettings`, `IdeSettingsService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 141`** (2 nodes): `NextUp`, `NextUpService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 142`** (2 nodes): `_FakePdfService`, `_NoAi`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 144`** (2 nodes): `that`, `WebviewCefPlatform`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 146`** (2 nodes): `GetCommandLineArguments()`, `Utf8FromUtf16()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 147`** (2 nodes): `InjectUserScripts`, `UserScript`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 148`** (2 nodes): `JavascriptChannel`, `JavascriptMessage`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 149`** (1 nodes): `WebviewTooltip`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 150`** (1 nodes): `MockWebviewCefPlatform`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 151`** (2 nodes): `DailyGoalsCompleteCard`, `_DailyGoalsCompleteCardState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 156`** (1 nodes): `MethodChannelWebviewCef`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 157`** (1 nodes): `WebviewEventsListener`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 159`** (2 nodes): `loadUrl()`, `OnBeforePopup()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 160`** (1 nodes): `DefaultFirebaseOptions`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 161`** (1 nodes): `LucideIcons`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What connects `DefaultFirebaseOptions`, `PopIntent`, `FlowApp` to the rest of the system?**
  _506 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.02531645569620253 - nodes in this community are weakly interconnected._
- **Should `Community 1` be split into smaller, more focused modules?**
  _Cohesion score 0.06428571428571428 - nodes in this community are weakly interconnected._
- **Should `Community 2` be split into smaller, more focused modules?**
  _Cohesion score 0.03773584905660377 - nodes in this community are weakly interconnected._
- **Should `Community 3` be split into smaller, more focused modules?**
  _Cohesion score 0.09411764705882353 - nodes in this community are weakly interconnected._
- **Should `Community 4` be split into smaller, more focused modules?**
  _Cohesion score 0.044444444444444446 - nodes in this community are weakly interconnected._
- **Should `Community 5` be split into smaller, more focused modules?**
  _Cohesion score 0.045454545454545456 - nodes in this community are weakly interconnected._