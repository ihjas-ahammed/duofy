# Graph Report - .  (2026-09-13)

## Corpus Check
- Large corpus: 2619 files · ~32,74,596 words. Semantic extraction will be expensive (many Claude tokens). Consider running on a subfolder, or use --no-semantic to run AST-only.

## Summary
- 2692 nodes · 3984 edges · 165 communities detected
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output
- Edge kinds: contains: 2210 · MODIFIES: 1184 · PARENT_OF: 231 · ON_BRANCH: 223 · calls: 125 · rationale_for: 6 · method: 5


## Input Scope
- Requested: auto
- Resolved: committed (source: default-auto)
- Included files: 2619 · Candidates: 6927
- Excluded: 213 untracked · 48125 ignored · 7 sensitive · 2 missing committed
- Recommendation: Use --scope all or graphify.yaml inputs.corpus for a knowledge-base folder.

## Graph Freshness
- Built from Git commit: `bc59a6e`
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

### Community 171 - "Community 171"
Cohesion: 1.00
Nodes (1): DefaultFirebaseOptions

### Community 19 - "Community 19"
Cohesion: 0.09
Nodes (15): PopIntent, FlowApp, AuthGate, RealtimeProgressBar, MyApp, _MyAppState, 01d6dd3 Merge branch 'main' of https://github.com/ihjas-ahammed/duofy, 2b1de87 chore: add Android builds v26.7.25 [skip ci] (+7 more)

### Community 57 - "Community 57"
Cohesion: 0.14
Nodes (9): AiTask, AiQueueScreen, _AiQueueScreenState, in, tasks, 4337110 feat: remove AI 10-page chunk scan; auto-index failures go straight to manual picker, 9965175 feat: remove Pause AI feature; interrupted tasks auto-resume, d6812c1 feat: add Run now quick-run for scheduled AI tasks (+1 more)

### Community 12 - "Community 12"
Cohesion: 0.06
Nodes (21): SlideTemplate, LessonFormat, Book, QpQuestion, QpSection, QuestionPaper, QuickReviewItem, Module (+13 more)

### Community 25 - "Community 25"
Cohesion: 0.09
Nodes (10): DailyGoal, DailyGoalUpdateEvent, AppCrashRecoveryScreen, GlobalState, is, DailyGoalsPopup, 8a51c13 fix(python & formats): disable R8 JNI minification for SeriousPython crash fix, expand default lesson formats catalog to 12+, update version code, a15c42e feat(daily-goals): Add Gamified Daily Goals system with 20 templates, infinite procedural goals, floating toasts, stats screen, and dark theme default (v26.8.1) (+2 more)

### Community 154 - "Community 154"
Cohesion: 0.50
Nodes (3): PyqItem, PyqQuestionAnswer, PyqExamAttempt

### Community 13 - "Community 13"
Cohesion: 0.09
Nodes (11): FdAuthBackend, FdFirestoreBackend, DesktopWebView, FileSelectionList, ResponsiveMaxWidth, ResponsiveCenter, WebWebViewWidget, _WebWebViewWidgetState (+3 more)

### Community 10 - "Community 10"
Cohesion: 0.05
Nodes (11): Platform, FileSystemEntity, File, Directory, ProcessResult, Process, FileSystemException, IOException (+3 more)

### Community 50 - "Community 50"
Cohesion: 0.11
Nodes (5): AiProvidersScreen, _AiProvidersScreenState, TestAiChatMessage, TestAiDialog, _TestAiDialogState

### Community 41 - "Community 41"
Cohesion: 0.11
Nodes (9): AuthScreen, _AuthScreenState, BookRouteLoaderScreen, _BookRouteLoaderScreenState, GenerateQpScreen, _GenerateQpScreenState, QpDetailScreen, 039f2fe theme: migrate generate_qp, pdf_folder, reference_pdf_viewer, qp_detail, book_route_loader screens (+1 more)

### Community 8 - "Community 8"
Cohesion: 0.05
Nodes (10): BookDashboardScreen, _BookDashboardScreenState, _MenuActionItem, _IconHeaderButton, UnitPrerequisite, _CustomFloatingActionButtonLocation, the, has (+2 more)

### Community 44 - "Community 44"
Cohesion: 0.11
Nodes (11): BookmarksScreen, _BookmarksScreenState, ExamScreen, ModuleSummaryDetailScreen, List, PyqCompleteScreen, _StatCard, 2934308 theme: migrate metacognition_setup, pyq_complete, bookmarks screens (+3 more)

### Community 22 - "Community 22"
Cohesion: 0.08
Nodes (6): CourseEditStructureScreen, _CourseEditStructureScreenState, _DownloadProgressDialog, _DownloadProgressDialogState, in, button

### Community 27 - "Community 27"
Cohesion: 0.09
Nodes (12): CourseSettingsScreen, _CourseSettingsScreenState, FormatEditorScreen, _FormatEditorScreenState, 085e90d quick fix, 2dfddb1 z, 675d2a1 EXPRESS, 74cc3a6 chore: add Android and Windows builds v26.6.24 [skip ci] (+4 more)

### Community 137 - "Community 137"
Cohesion: 0.33
Nodes (2): DailyGoalsScreen, _DailyGoalsScreenState

### Community 146 - "Community 146"
Cohesion: 0.40
Nodes (4): ProgrammingSlidesScreen, _ProgramCard, _ProgramCardState, _RunnerCard

### Community 16 - "Community 16"
Cohesion: 0.07
Nodes (8): DocumentStoreScreen, _DocumentStoreScreenState, B2PdfViewerScreen, PdfThumbnailWidget, _PdfThumbnailWidgetState, CategoryTabs, ConfirmNameDialog, _ConfirmNameDialogState

### Community 73 - "Community 73"
Cohesion: 0.15
Nodes (4): ExperimentsScreen, _ExperimentsScreenState, ExperimentPreviewScreen, _ExperimentPreviewScreenState

### Community 17 - "Community 17"
Cohesion: 0.07
Nodes (6): GenerateBookScreen, _GenerateBookScreenState, _DocumentStorePickerDialog, _DocumentStorePickerDialogState, _DownloadProgressDialog, _DownloadProgressDialogState

### Community 15 - "Community 15"
Cohesion: 0.07
Nodes (3): HomeScreen, _HomeScreenState, SearchResultItem

### Community 124 - "Community 124"
Cohesion: 0.29
Nodes (2): CodeIdeScreen, _CodeIdeScreenState

### Community 125 - "Community 125"
Cohesion: 0.29
Nodes (2): HtmlIdeScreen, _HtmlIdeScreenState

### Community 4 - "Community 4"
Cohesion: 0.04
Nodes (11): LatexIdeScreen, _LatexIdeScreenState, _LatexErrorAiExplainerSheet, _LatexErrorAiExplainerSheetState, LatexPdfPreviewScreen, _LatexPdfPreviewScreenState, PreprocessRule, LatexJsEngineManager (+3 more)

### Community 85 - "Community 85"
Cohesion: 0.18
Nodes (2): PythonNotebookScreen, _PythonNotebookScreenState

### Community 93 - "Community 93"
Cohesion: 0.20
Nodes (3): UniversalCodeRunnerScreen, _UniversalCodeRunnerScreenState, Main

### Community 24 - "Community 24"
Cohesion: 0.09
Nodes (14): LessonCompleteScreen, _LessonCompleteScreenState, _CircularGaugePainter, _SparklinePainter, _DottedLinePainter, difficulty, 06c30be theme: migrate lesson-complete + canvas views to semantic tokens, 88176b7 chore: add Android builds v26.7.15 [skip ci] (+6 more)

### Community 9 - "Community 9"
Cohesion: 0.05
Nodes (12): LessonScreen, _LessonScreenState, nextSecIdx, nextModIdx, 1e1860b chore: add Android builds v26.7.12 [skip ci], 25fb4a6 fix: reset FlashcardView state when slide changes, 39500a4 fix: correct deadline target count math in app_models, 4026742 chore: add Android builds v26.7.12 [skip ci] (+4 more)

### Community 74 - "Community 74"
Cohesion: 0.15
Nodes (3): MainLayoutScreen, _MainLayoutScreenState, currently

### Community 86 - "Community 86"
Cohesion: 0.18
Nodes (2): MetacognitionSetupScreen, _MetacognitionSetupScreenState

### Community 87 - "Community 87"
Cohesion: 0.18
Nodes (2): ModuleNotesViewerScreen, _ModuleNotesViewerScreenState

### Community 26 - "Community 26"
Cohesion: 0.08
Nodes (6): ModuleSelectionScreen, _ModuleSelectionScreenState, _MenuActionItem, _BookmarkMatch, now, final

### Community 56 - "Community 56"
Cohesion: 0.14
Nodes (9): _OnboardingPage, OnboardingScreen, _OnboardingScreenState, AppColors, AppTheme, QuizView, 1322f3d ASZ, 7dbab59 Merge pull request #2 from ihjas-ahammed/sirius (+1 more)

### Community 112 - "Community 112"
Cohesion: 0.25
Nodes (3): PdfFolderMeta, PdfBrowserScreen, _PdfBrowserScreenState

### Community 102 - "Community 102"
Cohesion: 0.22
Nodes (3): PdfFileMeta, PdfFolderScreen, _PdfFolderScreenState

### Community 51 - "Community 51"
Cohesion: 0.11
Nodes (3): PdfSplitPreviewScreen, _PdfSplitPreviewScreenState, in

### Community 52 - "Community 52"
Cohesion: 0.11
Nodes (9): _UnitRef, _SectionRef, _ModuleRef, _PracticeMode, PracticeScreen, _PracticeScreenState, _ModeCard, that (+1 more)

### Community 66 - "Community 66"
Cohesion: 0.14
Nodes (3): PracticeSessionScreen, _PracticeSessionScreenState, in

### Community 113 - "Community 113"
Cohesion: 0.25
Nodes (2): PyqExamScreen, _PyqExamScreenState

### Community 54 - "Community 54"
Cohesion: 0.12
Nodes (3): PyqPanelScreen, _PyqPanelScreenState, and

### Community 103 - "Community 103"
Cohesion: 0.22
Nodes (3): PyqScoreHistoryScreen, _PyqScoreHistoryScreenState, PyqExamDetailScreen

### Community 55 - "Community 55"
Cohesion: 0.12
Nodes (3): PyqTabScreen, _PyqTabScreenState, currently

### Community 14 - "Community 14"
Cohesion: 0.08
Nodes (13): NotebookCell, PythonIdeScreen, _PythonIdeScreenState, 0774610 Update graphify index for CMake site packages fix, 081eccf Implement real-time Jupyter-style interactive input handling via socket IPC, 2835dd9 Rewrite CodeRunnerView natively in pure Dart using PythonRunnerService, 37cdd6b Support interactive Python input() calls in PythonRunnerService and PythonIdeScreen, 4147f0b Fix Android ProcessEnvironment reflection cast and enable live syntax highlighting in Python inputs (+5 more)

### Community 167 - "Community 167"
Cohesion: 0.67
Nodes (2): ReelViewScreen, are

### Community 75 - "Community 75"
Cohesion: 0.15
Nodes (3): ReferencePdfViewerScreen, _ReferencePdfViewerScreenState, in

### Community 23 - "Community 23"
Cohesion: 0.08
Nodes (4): SectionSelectionScreen, _SectionSelectionScreenState, _MenuActionItem, _BookmarkMatch

### Community 38 - "Community 38"
Cohesion: 0.12
Nodes (11): SettingsScreen, _SettingsScreenState, 06c076e chore: add Android builds v26.7.10 [skip ci], 269329e chore: add Android builds v26.7.12 [skip ci], 2e3bece chore: add Android builds v26.7.12 [skip ci], 3cff7f6 REALLY!, 5f9d253 chore: add Android builds v26.7.10 [skip ci], 8938325 feat: layout-based course progress bars and secured Firestore API keys (+3 more)

### Community 28 - "Community 28"
Cohesion: 0.09
Nodes (7): SourcePdfUploadScreen, _SourcePdfUploadScreenState, DocumentStorePickerDialog, DocumentStorePickerDialogState, DownloadProgressDialog, DownloadProgressDialogState, in

### Community 63 - "Community 63"
Cohesion: 0.13
Nodes (4): YoutubeVideo, SummaryScreen, _SummaryScreenState, lecture

### Community 114 - "Community 114"
Cohesion: 0.25
Nodes (2): ActiveRequestInfo, AiEstimator

### Community 3 - "Community 3"
Cohesion: 0.04
Nodes (8): AiService, UnitManifestResult, PyqExtractionResult, module, to, in, outlines, title

### Community 115 - "Community 115"
Cohesion: 0.25
Nodes (2): AutoIndexResult, AutoIndexPipeline

### Community 149 - "Community 149"
Cohesion: 0.40
Nodes (1): AutoIndexService

### Community 45 - "Community 45"
Cohesion: 0.11
Nodes (3): B2Object, B2Credentials, B2Service

### Community 104 - "Community 104"
Cohesion: 0.22
Nodes (2): Bookmark, BookmarkService

### Community 138 - "Community 138"
Cohesion: 0.33
Nodes (3): NotebookCell, IdeProject, CodeStorageService

### Community 116 - "Community 116"
Cohesion: 0.25
Nodes (1): DailyGoalsService

### Community 31 - "Community 31"
Cohesion: 0.09
Nodes (1): DatabaseService

### Community 69 - "Community 69"
Cohesion: 0.18
Nodes (6): DeadlineService, 00fdc1a chore: add Android builds v26.7.12 [skip ci], 11cc12c feat: cumulative sequential deadline targets, dynamic page-scaled lesson estimator, glassmorphic targets button, manual lesson complete transitions, 2508966 chore: add Android builds v26.7.12 [skip ci], b5b2ecb fix: resolve incorrect deadline target calculations for un-generated lessons by using standard averages (12 lessons per empty section, 4 per empty unit), c04f5ba fix: resolve static analyzer invalid_assignment error by casting dynamic receiver lessons length to int

### Community 117 - "Community 117"
Cohesion: 0.25
Nodes (2): CapturedError, ErrorCaptureService

### Community 84 - "Community 84"
Cohesion: 0.18
Nodes (5): FbAuthException, FbUser, _FaUser, FbAuth, _FaAuth

### Community 123 - "Community 123"
Cohesion: 0.29
Nodes (5): FbCore, 994c7de chore: add Android and Windows builds v26.6.5 [skip ci], c476ed9 555555555555555555555555555upp, da7e93c Merge branch 'main' of https://github.com/ihjas-ahammed/duofy, b807fe5 sd

### Community 79 - "Community 79"
Cohesion: 0.17
Nodes (8): FbDocSnapshot, FbQuerySnapshot, FbDocRef, FbCollectionRef, FbFirestore, _CfFirestore, _CfCollection, _CfDoc

### Community 49 - "Community 49"
Cohesion: 0.11
Nodes (6): _FileTokenStore, _FdUser, FdAuthBackend, FdFirestoreBackend, _FdCollection, _FdDoc

### Community 1 - "Community 1"
Cohesion: 0.03
Nodes (6): GenerationTask, UnitGenTask, QpGenTask, GenerationManager, when, the

### Community 127 - "Community 127"
Cohesion: 0.29
Nodes (1): GuestService

### Community 128 - "Community 128"
Cohesion: 0.29
Nodes (1): HomeWidgetService

### Community 91 - "Community 91"
Cohesion: 0.22
Nodes (7): IdeSettings, IdeSettingsService, 12bf472 feat(release): overhaul PYQ tab screen, enhance LaTeX math rendering, update release notes & bump version code to 2026072502 (v26.7.25), 329bdab ny, 348ad55 fx g, 7be050f Merge branch 'main' of https://github.com/ihjas-ahammed/duofy, da201f8 chore: add Android builds v26.7.25 [skip ci]

### Community 48 - "Community 48"
Cohesion: 0.11
Nodes (4): LatexJsonRepairer, GlobalErrorCaptureLayer, _GlobalErrorCaptureLayerState, e52e844 feat(release): v26.8.27 - LaTeX IDE POST compiler & AI debug, 10 lesson formats cap, prompt optimization, and UI theme research

### Community 129 - "Community 129"
Cohesion: 0.29
Nodes (1): LearningSync

### Community 139 - "Community 139"
Cohesion: 0.33
Nodes (2): LoadingStep, LoadingProgressController

### Community 105 - "Community 105"
Cohesion: 0.22
Nodes (2): MappingReport, MappingVerifier

### Community 39 - "Community 39"
Cohesion: 0.10
Nodes (2): MathEvaluatorService, _MathParser

### Community 40 - "Community 40"
Cohesion: 0.10
Nodes (6): MetacogEvent, ReviewItem, CalibrationStats, MetacognitionService, difficulty, should

### Community 42 - "Community 42"
Cohesion: 0.11
Nodes (11): ModuleNotesHtmlBuilder, study, 0c1e4c0 chore: add Android builds v26.8.6 [skip ci], 14e7263 feat: Quick Generate Module Notes with MathJax TeX rendering, mobile responsiveness, and A4 PDF export (v26.8.7+2126080701), 458dd1e chore: add Android builds v26.8.1 [skip ci], 5621c28 v26.8.8: Integrated SeriousPython multi-arch runtime, interactive notebook input, SVG plot renderer, and high-density study notes generator, 7e90faf chore: add Android builds v26.8.1 [skip ci], c5f6e32 new (+3 more)

### Community 18 - "Community 18"
Cohesion: 0.07
Nodes (8): ModuleNotesJob, ModuleNotesService, notes, and, sequentially, textbook, as, Title

### Community 150 - "Community 150"
Cohesion: 0.40
Nodes (2): NextUp, NextUpService

### Community 95 - "Community 95"
Cohesion: 0.20
Nodes (1): NotificationService

### Community 106 - "Community 106"
Cohesion: 0.22
Nodes (2): ResolvedRanges, PageMapping

### Community 46 - "Community 46"
Cohesion: 0.11
Nodes (3): PdfService, PdfBookmarkNode, in

### Community 111 - "Community 111"
Cohesion: 0.25
Nodes (4): PersonalizationService, being, as, f10ef09 feat: metacognitive loop, four new exercise types, learner profile v2, prompt overhaul (Phase 4)

### Community 47 - "Community 47"
Cohesion: 0.11
Nodes (1): ProgressService

### Community 35 - "Community 35"
Cohesion: 0.10
Nodes (4): PromptService, title, 2d60cdb feat: add AI provider model test debugger, practice-first programming planner, section plan reset, and fix SeriousPython native JNI bundle packaging, ed71b03 io

### Community 67 - "Community 67"
Cohesion: 0.14
Nodes (2): PyqExamService, PyqAnalysisJob

### Community 0 - "Community 0"
Cohesion: 0.01
Nodes (23): PythonExecutionResult, PythonRunnerService, _NumpyArray, _NumpyRandomStub, _NumpyLinalgStub, _NumpyModuleStub, _PyplotStub, _Series (+15 more)

### Community 140 - "Community 140"
Cohesion: 0.33
Nodes (3): DayStreakData, StreakInfo, StreakService

### Community 118 - "Community 118"
Cohesion: 0.25
Nodes (3): TocMatcher, index, overview

### Community 68 - "Community 68"
Cohesion: 0.14
Nodes (2): UpdateInfo, UpdateService

### Community 43 - "Community 43"
Cohesion: 0.11
Nodes (5): UsageLimitService, 0eaaf59 chore: add Android builds v26.7.15 [skip ci], bed7aca chore: add Android builds v26.7.15 [skip ci], c71d757 orgainze apis, c83829c deadine v2

### Community 130 - "Community 130"
Cohesion: 0.29
Nodes (1): WalkthroughService

### Community 119 - "Community 119"
Cohesion: 0.25
Nodes (2): LatexUtils, _TextPart

### Community 131 - "Community 131"
Cohesion: 0.29
Nodes (1): SectionColors

### Community 11 - "Community 11"
Cohesion: 0.07
Nodes (19): CommunityBookCard, CompactBookCard, in, CompactBookListItem, in, GlassyNavBar, MiniProgressBar, MissingFilesBanner (+11 more)

### Community 98 - "Community 98"
Cohesion: 0.20
Nodes (2): AnalyticsView, _AnalyticsViewState

### Community 62 - "Community 62"
Cohesion: 0.13
Nodes (9): BookCard, GeneratingBookCard, NextNodePop, _NextNodePopState, LessonNodeWidget, _LessonNodeWidgetState, 1eb22ce theme: migrate generating_book_card, book_card, repair_alignment_dialog, 6fe7291 theme: migrate canvas_art_view placeholder card (+1 more)

### Community 122 - "Community 122"
Cohesion: 0.29
Nodes (3): SectionBottomSheet, _SectionBottomSheetState, _SectionCard

### Community 29 - "Community 29"
Cohesion: 0.09
Nodes (10): CalibrationCard, CoachMark, CoachMarkController, _HolePainter, DailyGoalCard, _DailyGoalCardState, UnitHeader, _ResumeIconButton (+2 more)

### Community 80 - "Community 80"
Cohesion: 0.17
Nodes (4): CanvasArtView, _CanvasArtViewState, _CanvasPlaceholder, _CanvasPlaceholderState

### Community 33 - "Community 33"
Cohesion: 0.09
Nodes (4): CanvasHtmlView, _CanvasFullScreenScreen, CanvasDoubleTapDetector, _CanvasDoubleTapDetectorState

### Community 64 - "Community 64"
Cohesion: 0.13
Nodes (3): CodeHighlighter, CodeTheme, CodeEditingController

### Community 132 - "Community 132"
Cohesion: 0.29
Nodes (3): ComboBadge, _ComboBadgeState, _ComboStyle

### Community 161 - "Community 161"
Cohesion: 0.50
Nodes (2): DailyGoalsCompleteCard, _DailyGoalsCompleteCardState

### Community 90 - "Community 90"
Cohesion: 0.18
Nodes (2): DesktopWebView, _DesktopWebViewState

### Community 141 - "Community 141"
Cohesion: 0.33
Nodes (4): DuoButton, _DuoButtonState, DuoIconButton, _DuoIconButtonState

### Community 99 - "Community 99"
Cohesion: 0.20
Nodes (4): FloatingDailyGoalToast, _FloatingDailyGoalToastState, FloatingDailyGoalListener, _FloatingDailyGoalListenerState

### Community 142 - "Community 142"
Cohesion: 0.33
Nodes (2): IdeConfigDialog, _IdeConfigDialogState

### Community 70 - "Community 70"
Cohesion: 0.17
Nodes (10): LazyIndexedStack, _LazyIndexedStackState, 05a15cd chore: add Android builds v26.7.15 [skip ci], 07c4665 chore: add Android builds v26.7.15 [skip ci], 274559d Merge branch 'main' of https://github.com/ihjas-ahammed/duofy, 4ea21ab fix: loadPyodide loading timing, bottom check button animations, slide transition lags, and resume card loading screen, 67b95db OK, 75e16eb ok (+2 more)

### Community 120 - "Community 120"
Cohesion: 0.25
Nodes (2): LearnerProfileCard, _LearnerProfileCardState

### Community 143 - "Community 143"
Cohesion: 0.33
Nodes (2): LessonAccordion, _LessonAccordionState

### Community 37 - "Community 37"
Cohesion: 0.10
Nodes (3): ChatMessage, LessonAssistantChat, _LessonAssistantChatState

### Community 34 - "Community 34"
Cohesion: 0.09
Nodes (10): LessonPath, _LessonPathState, _PathPoint, _Element, _PathConnectorPainter, _SectionManifestPanel, _SectionManifestPanelState, _UnitFormatConfirmPanel (+2 more)

### Community 53 - "Community 53"
Cohesion: 0.11
Nodes (7): MathMarkdown, _PermissiveLatexInlineSyntax, _MathBuilder, _BlankSyntax, _BlankBuilder, _InlineBlankField, _InlineBlankFieldState

### Community 78 - "Community 78"
Cohesion: 0.17
Nodes (6): PlatformWebViewController, PlatformWebView, _PlatformWebViewState, PlatformWebViewBootstrap, 18142cc chore: add Android builds v26.7.15 [skip ci], 4c8673e OKKK

### Community 60 - "Community 60"
Cohesion: 0.13
Nodes (9): QuickReviewSheet, _QuickReviewSheetState, MatchingLessonResult, _EmptyReviewPanel, _LoadingPanel, _LoadingPanelState, _ReviewItemCard, _StatementDetailSheet (+1 more)

### Community 133 - "Community 133"
Cohesion: 0.29
Nodes (2): RealProgressBar, _RealProgressBarState

### Community 6 - "Community 6"
Cohesion: 0.04
Nodes (4): WebPdfTextSearchResult, SafePdfViewerController, SafePdfViewer, _SafePdfViewerState

### Community 71 - "Community 71"
Cohesion: 0.18
Nodes (8): ModuleSelectorSheet, _ModuleRow, SectionSelector, TheoryView, 1bb5af4 theme: migrate theory_view, 4ea5161 Merge pull request #3 from ihjas-ahammed/sirius, 6a6426e theme: migrate module_selector, section_selector, quiz_view, 819cacb chore: add Android builds v26.7.10 [skip ci]

### Community 32 - "Community 32"
Cohesion: 0.09
Nodes (3): CodeRunnerView, _CodeRunnerViewState, CodeRunnerHtml

### Community 88 - "Community 88"
Cohesion: 0.18
Nodes (5): ConceptPiecesView, _ConceptPiecesViewState, _ParsedConceptPiece, _ConceptSchematicPainter, _TimelineLinePainter

### Community 21 - "Community 21"
Cohesion: 0.08
Nodes (10): CustomHtmlView, _CustomHtmlViewState, ErrorSpottingView, _ErrorSpottingViewState, FlashcardView, _FlashcardViewState, StepByStepView, _StepByStepViewState (+2 more)

### Community 107 - "Community 107"
Cohesion: 0.22
Nodes (2): DescriptiveView, _DescriptiveViewState

### Community 108 - "Community 108"
Cohesion: 0.22
Nodes (3): _BlankOption, FillInBlankView, _FillInBlankViewState

### Community 59 - "Community 59"
Cohesion: 0.13
Nodes (2): InteractiveProofView, _InteractiveProofViewState

### Community 89 - "Community 89"
Cohesion: 0.18
Nodes (2): MatchingView, _MatchingViewState

### Community 96 - "Community 96"
Cohesion: 0.20
Nodes (2): NumericalView, _NumericalViewState

### Community 61 - "Community 61"
Cohesion: 0.13
Nodes (6): OneWordView, _OneWordViewState, OrderingView, _OrderingViewState, 10204b5 theme: migrate one_word/numerical/matching/ordering views, 3e9b205 theme: migrate descriptive/interactive_proof/fill_in_blank/pyq_one_word views

### Community 97 - "Community 97"
Cohesion: 0.20
Nodes (4): ProgramView, _ProgramViewState, _CodePanel, _CodePanelState

### Community 65 - "Community 65"
Cohesion: 0.14
Nodes (4): PyqOneWordView, _PyqOneWordViewState, 0c91cb2 chore: add Android builds v26.8.31 [skip ci], a292b18 feat: instant update check cache-busting, universal LaTeX across slides, and review practice modal

### Community 110 - "Community 110"
Cohesion: 0.25
Nodes (5): SlideActionButton, _SlideActionButtonState, SlideFeedbackSheet, _SlideFeedbackSheetState, 1c58056 feat(release): v26.8.31 - Complete lesson slide UI redesign, glass capsule toolbar, tactile action buttons, diagnostic feedback sheet, and theme tokens

### Community 109 - "Community 109"
Cohesion: 0.22
Nodes (4): SlideCapsuleToolbar, _SlideCapsuleToolbarState, _LiquidWavePainter, _BotAvatarPainter

### Community 134 - "Community 134"
Cohesion: 0.29
Nodes (2): StringListManager, StringListManagerState

### Community 121 - "Community 121"
Cohesion: 0.25
Nodes (3): UpdateDialog, _UpdateDialogState, _DownloadProgress

### Community 82 - "Community 82"
Cohesion: 0.20
Nodes (8): WalkthroughBanner, _Card, 7a4966f chore: add Android builds v26.7.15 [skip ci], 9535e64 k, 9d1d7bc NAA, ab7968d it ignored my command lets see whta this will be, ea4994a Support program & try_yourself slide generation; reposition walkthrough banner; fully populate walkthrough course assets, ec6f1f9 feat: unify restore PDF picker with course creation picker and redirect missing banner to restore screen

### Community 92 - "Community 92"
Cohesion: 0.20
Nodes (1): 1fa1705 OK

### Community 172 - "Community 172"
Cohesion: 1.00
Nodes (1): LucideIcons

### Community 36 - "Community 36"
Cohesion: 0.10
Nodes (2): SimpleWindowDelegate, SimpleBrowserViewDelegate

### Community 145 - "Community 145"
Cohesion: 0.50
Nodes (2): Visit(), getVisitedCookies()

### Community 135 - "Community 135"
Cohesion: 0.33
Nodes (6): to_string(), OnProcessMessageReceived(), OnTakeFocus(), setJavaScriptChannels(), GetCallbackId(), executeJavaScript()

### Community 164 - "Community 164"
Cohesion: 0.67
Nodes (3): GetDataURI(), OnLoadError(), IsChromeRuntimeEnabled()

### Community 170 - "Community 170"
Cohesion: 1.00
Nodes (2): OnBeforePopup(), loadUrl()

### Community 83 - "Community 83"
Cohesion: 0.27
Nodes (6): ConvertCefV8ValueToJSValue(), Execute(), StartRequest(), EvaluateCallback(), GetNextReqID(), CallCppFunction()

### Community 58 - "Community 58"
Cohesion: 0.17
Nodes (7): WebviewPlugin(), initCallback(), uninitCallback(), HandleMethodCall(), cursorAction(), startCEF(), stopCEF()

### Community 5 - "Community 5"
Cohesion: 0.09
Nodes (49): webview_ptr_array_new_with_free_func(), webview_ptr_array_free(), webview_ptr_array_unref(), webview_ptr_array_add(), webview_ptr_array_index(), webview_value_new(), webview_value_lookup_index(), webview_value_destroy() (+41 more)

### Community 155 - "Community 155"
Cohesion: 0.67
Nodes (2): GetCommandLineArguments(), Utf8FromUtf16()

### Community 30 - "Community 30"
Cohesion: 0.17
Nodes (17): Scale(), EnableFullDpiSupportIfAvailable(), WindowClassRegistrar, GetWindowClass(), UnregisterWindowClass(), Win32Window(), CreateAndShow(), Win32Window::WndProc() (+9 more)

### Community 20 - "Community 20"
Cohesion: 0.07
Nodes (3): WebViewController, WebView, WebViewState

### Community 168 - "Community 168"
Cohesion: 0.67
Nodes (1): WebviewEventsListener

### Community 156 - "Community 156"
Cohesion: 0.50
Nodes (2): UserScript, InjectUserScripts

### Community 157 - "Community 157"
Cohesion: 0.50
Nodes (2): JavascriptMessage, JavascriptChannel

### Community 76 - "Community 76"
Cohesion: 0.15
Nodes (1): WebviewManager

### Community 158 - "Community 158"
Cohesion: 0.50
Nodes (1): WebviewTooltip

### Community 166 - "Community 166"
Cohesion: 0.67
Nodes (1): MethodChannelWebviewCef

### Community 153 - "Community 153"
Cohesion: 0.50
Nodes (2): WebviewCefPlatform, that

### Community 136 - "Community 136"
Cohesion: 0.40
Nodes (2): KeyboardCodeFromXKeysym(), GdkEventToWindowsKeyCode()

### Community 72 - "Community 72"
Cohesion: 0.21
Nodes (6): WebviewTextureRenderer, encode_wavlue_to_flvalue(), encode_flvalue_to_wvalue(), webview_cef_plugin_handle_method_call(), method_call_cb(), webview_cef_plugin_register_with_registrar()

### Community 160 - "Community 160"
Cohesion: 0.50
Nodes (1): MockWebviewCefPlatform

### Community 162 - "Community 162"
Cohesion: 1.00
Nodes (3): IsKeyDown(), GetCefKeyboardModifiers(), getCefKeyEvent()

### Community 100 - "Community 100"
Cohesion: 0.29
Nodes (5): WebviewTextureRenderer, encode_wvalue_to_flvalue(), encode_flvalue_to_wvalue(), RegisterWithRegistrar(), HandleMethodCall()

### Community 101 - "Community 101"
Cohesion: 0.31
Nodes (8): load_gitignore_patterns(), should_ignore(), is_likely_binary_file(), pack_project(), Loads patterns from .gitignore file in the root directory., Checks if a given path (relative to project root) should be ignored.     Uses .g, Checks if a file is likely binary based on its extension or content., Packs all relevant files into a single text file.

### Community 159 - "Community 159"
Cohesion: 0.50
Nodes (1): Harness

### Community 151 - "Community 151"
Cohesion: 0.40
Nodes (2): _FakePdfService, _NoAi

### Community 77 - "Community 77"
Cohesion: 0.18
Nodes (10): 061977c chore: add Android builds v26.7.15 [skip ci], 317ac5d Merge branch 'main' of https://github.com/ihjas-ahammed/duofy, 3b989f1 Bump version to 26.7.22+2026072201, fix concept split view, and expand cloud storage sync, 3f4d091 Merge branch 'main' of https://github.com/ihjas-ahammed/duofy, 4793d65 chore: add Android builds v26.7.15 [skip ci], 4ac3990 new db, 4ead8b6 z, 65220a0 fix: WebAssembly check and window.onerror diagnostics inside Python code runner (+2 more)

### Community 144 - "Community 144"
Cohesion: 0.40
Nodes (2): 3d09abf fix: slide interaction and content-quality issues, 99745d3 theme: migrate GlassyNavBar and MathMarkdown to semantic tokens

### Community 81 - "Community 81"
Cohesion: 0.18
Nodes (9): 7e13079 docs: add AI queue cleanup design spec, ab5d5ed docs: add AI queue cleanup implementation plan, 20f459c feat: rewrite AutoIndexService as staged cheap-first pipeline, 482623d feat: remove manual indexing-method selector; auto-detect is the only path, 742f017 feat: add offline TocMatcher heuristics for TOC/chapter detection, 808f4f6 feat: add AiService.optimizeIndexResult lite-model cleanup pass, 8cff8c9 feat: route auto-index failures to manual picker instead of dead-ending, a316953 feat: add pure AutoIndexPipeline stage-chain orchestration (+1 more)

### Community 152 - "Community 152"
Cohesion: 0.50
Nodes (4): parse_snapshot(), update_project_from_snapshot(), Parses the snapshot content and yields (filename, file_content) tuples., Reads the snapshot file and updates the project files accordingly.

### Community 2 - "Community 2"
Cohesion: 0.06
Nodes (61): 0184924 theme: migrate analytics_view, 0270948 feat: move shared secrets to auth-gated Firestore (Phase 2), 0498e66 theme: migrate source_pdf_upload_screen, 07c7464 theme: migrate lesson_path, 0b36b76 feat(release): v26.9.1 - Multi-file LaTeX Studio, Navigation Drawer workspace explorer, BibTeX parser, TeX Live compiler payload fix, and reel-like view, 137f329 chore: add Android builds v26.7.22 [skip ci], 13b10df chore: add Android builds v27.0.0 [skip ci], 1a59536 chore: add Android builds v26.8.27 [skip ci] (+53 more)

## Knowledge Gaps
- **552 isolated node(s):** `DefaultFirebaseOptions`, `PopIntent`, `FlowApp`, `AiTask`, `SlideTemplate` (+547 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `Community 171`** (1 nodes): `DefaultFirebaseOptions`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 137`** (2 nodes): `DailyGoalsScreen`, `_DailyGoalsScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 124`** (2 nodes): `CodeIdeScreen`, `_CodeIdeScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 125`** (2 nodes): `HtmlIdeScreen`, `_HtmlIdeScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 85`** (2 nodes): `PythonNotebookScreen`, `_PythonNotebookScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 86`** (2 nodes): `MetacognitionSetupScreen`, `_MetacognitionSetupScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 87`** (2 nodes): `ModuleNotesViewerScreen`, `_ModuleNotesViewerScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 113`** (2 nodes): `PyqExamScreen`, `_PyqExamScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 167`** (2 nodes): `ReelViewScreen`, `are`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 114`** (2 nodes): `ActiveRequestInfo`, `AiEstimator`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 115`** (2 nodes): `AutoIndexResult`, `AutoIndexPipeline`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 149`** (1 nodes): `AutoIndexService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 104`** (2 nodes): `Bookmark`, `BookmarkService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 116`** (1 nodes): `DailyGoalsService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 31`** (1 nodes): `DatabaseService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 117`** (2 nodes): `CapturedError`, `ErrorCaptureService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 127`** (1 nodes): `GuestService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 128`** (1 nodes): `HomeWidgetService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 129`** (1 nodes): `LearningSync`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 139`** (2 nodes): `LoadingStep`, `LoadingProgressController`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 105`** (2 nodes): `MappingReport`, `MappingVerifier`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 39`** (2 nodes): `MathEvaluatorService`, `_MathParser`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 150`** (2 nodes): `NextUp`, `NextUpService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 95`** (1 nodes): `NotificationService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 106`** (2 nodes): `ResolvedRanges`, `PageMapping`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 47`** (1 nodes): `ProgressService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 67`** (2 nodes): `PyqExamService`, `PyqAnalysisJob`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 68`** (2 nodes): `UpdateInfo`, `UpdateService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 130`** (1 nodes): `WalkthroughService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 119`** (2 nodes): `LatexUtils`, `_TextPart`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 131`** (1 nodes): `SectionColors`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 98`** (2 nodes): `AnalyticsView`, `_AnalyticsViewState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 161`** (2 nodes): `DailyGoalsCompleteCard`, `_DailyGoalsCompleteCardState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 90`** (2 nodes): `DesktopWebView`, `_DesktopWebViewState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 142`** (2 nodes): `IdeConfigDialog`, `_IdeConfigDialogState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 120`** (2 nodes): `LearnerProfileCard`, `_LearnerProfileCardState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 143`** (2 nodes): `LessonAccordion`, `_LessonAccordionState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 133`** (2 nodes): `RealProgressBar`, `_RealProgressBarState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 107`** (2 nodes): `DescriptiveView`, `_DescriptiveViewState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 59`** (2 nodes): `InteractiveProofView`, `_InteractiveProofViewState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 89`** (2 nodes): `MatchingView`, `_MatchingViewState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 96`** (2 nodes): `NumericalView`, `_NumericalViewState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 134`** (2 nodes): `StringListManager`, `StringListManagerState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 92`** (1 nodes): `1fa1705 OK`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 172`** (1 nodes): `LucideIcons`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 36`** (2 nodes): `SimpleWindowDelegate`, `SimpleBrowserViewDelegate`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 145`** (2 nodes): `Visit()`, `getVisitedCookies()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 170`** (2 nodes): `OnBeforePopup()`, `loadUrl()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 155`** (2 nodes): `GetCommandLineArguments()`, `Utf8FromUtf16()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 168`** (1 nodes): `WebviewEventsListener`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 156`** (2 nodes): `UserScript`, `InjectUserScripts`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 157`** (2 nodes): `JavascriptMessage`, `JavascriptChannel`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 76`** (1 nodes): `WebviewManager`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 158`** (1 nodes): `WebviewTooltip`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 166`** (1 nodes): `MethodChannelWebviewCef`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 153`** (2 nodes): `WebviewCefPlatform`, `that`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 136`** (2 nodes): `KeyboardCodeFromXKeysym()`, `GdkEventToWindowsKeyCode()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 160`** (1 nodes): `MockWebviewCefPlatform`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 159`** (1 nodes): `Harness`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 151`** (2 nodes): `_FakePdfService`, `_NoAi`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 144`** (2 nodes): `3d09abf fix: slide interaction and content-quality issues`, `99745d3 theme: migrate GlassyNavBar and MathMarkdown to semantic tokens`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What connects `DefaultFirebaseOptions`, `PopIntent`, `FlowApp` to the rest of the system?**
  _552 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 19` be split into smaller, more focused modules?**
  _Cohesion score 0.08547008547008547 - nodes in this community are weakly interconnected._
- **Should `Community 57` be split into smaller, more focused modules?**
  _Cohesion score 0.14166666666666666 - nodes in this community are weakly interconnected._
- **Should `Community 12` be split into smaller, more focused modules?**
  _Cohesion score 0.06451612903225806 - nodes in this community are weakly interconnected._
- **Should `Community 25` be split into smaller, more focused modules?**
  _Cohesion score 0.08695652173913043 - nodes in this community are weakly interconnected._
- **Should `Community 13` be split into smaller, more focused modules?**
  _Cohesion score 0.08669354838709678 - nodes in this community are weakly interconnected._
- **Should `Community 10` be split into smaller, more focused modules?**
  _Cohesion score 0.05128205128205128 - nodes in this community are weakly interconnected._