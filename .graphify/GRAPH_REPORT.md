# Graph Report - .  (2026-09-13)

## Corpus Check
- Large corpus: 2750 files · ~48,85,847 words. Semantic extraction will be expensive (many Claude tokens). Consider running on a subfolder, or use --no-semantic to run AST-only.

## Summary
- 4957 nodes · 9069 edges · 199 communities detected
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output
- Edge kinds: contains: 3372 · calls: 2962 · MODIFIES: 1234 · method: 1038 · PARENT_OF: 232 · ON_BRANCH: 224 · rationale_for: 7


## Input Scope
- Requested: auto
- Resolved: committed (source: default-auto)
- Included files: 2750 · Candidates: 7140
- Excluded: 58 untracked · 48133 ignored · 7 sensitive · 2 missing committed
- Recommendation: Use --scope all or graphify.yaml inputs.corpus for a knowledge-base folder.

## Graph Freshness
- Built from Git commit: `b227898`
- Compare this hash to `git rev-parse HEAD` before trusting freshness-sensitive graph output.
## God Nodes (most connected - your core abstractions)
1. `a()` - 142 edges
2. `T()` - 103 edges
3. `i()` - 97 edges
4. `s()` - 89 edges
5. `Q()` - 85 edges
6. `o()` - 67 edges
7. `g()` - 60 edges
8. `push()` - 56 edges
9. `pl()` - 54 edges
10. `L()` - 50 edges

## Surprising Connections (you probably didn't know these)
- `CreateAndShow()` --calls--> `Destroy()`  [EXTRACTED]
  packages/webview_cef/example/windows/runner/win32_window.cpp → windows/runner/win32_window.cpp
- `CreateAndShow()` --calls--> `GetWindowClass()`  [EXTRACTED]
  packages/webview_cef/example/windows/runner/win32_window.cpp → windows/runner/win32_window.cpp
- `CreateAndShow()` --calls--> `OnCreate()`  [EXTRACTED]
  packages/webview_cef/example/windows/runner/win32_window.cpp → windows/runner/win32_window.cpp
- `CreateAndShow()` --calls--> `Scale()`  [EXTRACTED]
  packages/webview_cef/example/windows/runner/win32_window.cpp → windows/runner/win32_window.cpp
- `build()` --calls--> `js()`  [EXTRACTED]
  docs/apps/tools/ms1/build.py → docs/apps/tools/ms1/build.js

## Communities

### Community 167 - "Community 167"
Cohesion: 0.60
Nodes (4): ui_fonts_inline(), content(), build(), Latin subsets of the UI fonts as base64 woff2, cached in vendor/uifonts.css.

### Community 29 - "Community 29"
Cohesion: 0.06
Nodes (18): hsh(), escH(), wrapDoc(), ex(), W(), omr(), cards(), match() (+10 more)

### Community 47 - "Community 47"
Cohesion: 0.07
Nodes (7): MODULES, LXTeX, hl, ui_fonts_inline(), content(), build(), b227898 feat(release): v26.9.13 - Drop-down Tree Reader mobile full-text redesign, horizontal table/formula scroll, and web app design parity

### Community 44 - "Community 44"
Cohesion: 0.08
Nodes (16): hlInline(), hlLines(), openCode(), paintCode(), hydrateEx(), exampleBox(), state, CRC (+8 more)

### Community 139 - "Community 139"
Cohesion: 0.25
Nodes (8): hl(), shell(), omr(), cards(), match(), fill(), parsons(), predict()

### Community 162 - "Community 162"
Cohesion: 0.33
Nodes (6): previewHeadHTML(), makePreview(), expandProject(), compileProject(), previewBlock(), challenge()

### Community 140 - "Community 140"
Cohesion: 0.39
Nodes (8): codeArea(), ideLoad(), newProject(), openInIDE(), ideLoad0(), mountIDE(), debounce(), ideSave

### Community 122 - "Community 122"
Cohesion: 0.22
Nodes (10): initCodeWin(), loadLocal(), pull(), wireTree(), showView(), initNav(), initTheme(), initSync() (+2 more)

### Community 91 - "Community 91"
Cohesion: 0.21
Nodes (16): saveLocal(), persist(), toast(), render(), setLeaves(), toggleNode(), completeNode(), toggleBM() (+8 more)

### Community 15 - "Community 15"
Cohesion: 0.04
Nodes (32): sl(), cl(), hl(), au(), su(), ur(), hr(), mr() (+24 more)

### Community 31 - "Community 31"
Cohesion: 0.06
Nodes (9): r(), ru(), t(), q(), wi, ho, La, htmlBuilder() (+1 more)

### Community 73 - "Community 73"
Cohesion: 0.12
Nodes (4): n(), i(), o(), co

### Community 16 - "Community 16"
Cohesion: 0.11
Nodes (61): e(), al(), ll(), ul(), pl(), dl(), ml(), gl() (+53 more)

### Community 45 - "Community 45"
Cohesion: 0.21
Nodes (5): Rl(), ju(), io, Hs(), handler()

### Community 51 - "Community 51"
Cohesion: 0.13
Nodes (4): bu(), yu(), vu(), no

### Community 19 - "Community 19"
Cohesion: 0.05
Nodes (16): cr(), gr(), Sr(), qr(), zr(), Lr(), sn, zn (+8 more)

### Community 35 - "Community 35"
Cohesion: 0.08
Nodes (3): dr(), en(), tn

### Community 34 - "Community 34"
Cohesion: 0.06
Nodes (8): fr(), rn(), bn(), kn, Ln(), Vn, gi, Ai

### Community 50 - "Community 50"
Cohesion: 0.14
Nodes (18): br(), viewbox(), zoom(), bi, _currentTransform(), _addRunner(), attr(), css() (+10 more)

### Community 86 - "Community 86"
Cohesion: 0.19
Nodes (3): kr, Jr(), a()

### Community 25 - "Community 25"
Cohesion: 0.04
Nodes (5): nn(), on, an(), qn, ks

### Community 60 - "Community 60"
Cohesion: 0.07
Nodes (6): un(), Yn, Xn, zi, unmask(), targets()

### Community 92 - "Community 92"
Cohesion: 0.18
Nodes (6): pn(), dn(), mn(), gn(), fn, Wn

### Community 53 - "Community 53"
Cohesion: 0.09
Nodes (7): ui(), ci(), hi(), pi(), mi(), ji, unclip()

### Community 106 - "Community 106"
Cohesion: 0.17
Nodes (4): ri, mergeWith(), Fi(), _clearTransformRunnersBefore()

### Community 116 - "Community 116"
Cohesion: 0.20
Nodes (2): ni, ii

### Community 67 - "Community 67"
Cohesion: 0.16
Nodes (1): di()

### Community 180 - "Community 180"
Cohesion: 0.40
Nodes (1): yi

### Community 192 - "Community 192"
Cohesion: 0.50
Nodes (1): vi

### Community 59 - "Community 59"
Cohesion: 0.11
Nodes (3): Li, animate(), _prepareRunner()

### Community 152 - "Community 152"
Cohesion: 0.29
Nodes (1): eo

### Community 179 - "Community 179"
Cohesion: 0.40
Nodes (1): ro

### Community 153 - "Community 153"
Cohesion: 0.29
Nodes (2): qo, ws()

### Community 163 - "Community 163"
Cohesion: 0.33
Nodes (1): Do

### Community 178 - "Community 178"
Cohesion: 0.40
Nodes (1): Lo

### Community 177 - "Community 177"
Cohesion: 0.40
Nodes (1): As

### Community 107 - "Community 107"
Cohesion: 0.28
Nodes (9): getVariable(), processTheElements(), _vertical(), offsetTop(), offsetBottom(), offsetBaseline(), heightAboveBaseline(), positionMarginpars() (+1 more)

### Community 3 - "Community 3"
Cohesion: 0.02
Nodes (53): Yn(), Un(), createFromRawTheme(), createFromParsedTheme(), ko(), debugName(), getEndWithResolvedBackReferences(), getWhileWithResolvedBackReferences() (+45 more)

### Community 46 - "Community 46"
Cohesion: 0.09
Nodes (32): constructor(), hasCaptures(), push(), getExtensionIfDefined(), lt(), No(), toKey(), add() (+24 more)

### Community 54 - "Community 54"
Cohesion: 0.08
Nodes (29): bo(), Qt(), xo(), yo(), Qn(), Co(), wo(), _o() (+21 more)

### Community 48 - "Community 48"
Cohesion: 0.09
Nodes (31): replaceCaptures(), getDefaults(), from(), ir(), getName(), getContentName(), dispose(), _disposeCaches() (+23 more)

### Community 42 - "Community 42"
Cohesion: 0.10
Nodes (33): er(), print(), getLanguageId(), getTokenType(), containsBalancedBrackets(), getFontStyle(), getForeground(), getBackground() (+25 more)

### Community 61 - "Community 61"
Cohesion: 0.11
Nodes (27): tr(), clone(), cloneArr(), acceptOverwrite(), insert(), _doInsertHere(), collectPatterns(), compile() (+19 more)

### Community 40 - "Community 40"
Cohesion: 0.09
Nodes (38): get(), grammarForScopeName(), loadGrammarWithEmbeddedLanguages(), loadGrammarWithConfiguration(), vr(), getGrammar(), loadLanguage(), loadLanguages() (+30 more)

### Community 110 - "Community 110"
Cohesion: 0.20
Nodes (12): match(), Wn(), getBasicScopeAttributes(), _scopeToLanguage(), _toStandardTokenType(), getMetadataForScope(), createRootAndLookUpScopeName(), mergeAttributes() (+4 more)

### Community 117 - "Community 117"
Cohesion: 0.24
Nodes (11): getSegments(), toString(), toBinaryStr(), getScopeNames(), _writeString(), gs(), Et(), Nt() (+3 more)

### Community 36 - "Community 36"
Cohesion: 0.08
Nodes (40): en(), _t(), ta(), fs(), bs(), ys(), oa(), ws() (+32 more)

### Community 141 - "Community 141"
Cohesion: 0.54
Nodes (7): panel(), ray(), dim(), hatch_bar(), finish(), michelson(), division()

### Community 101 - "Community 101"
Cohesion: 0.26
Nodes (12): fs, path, SRC, VEN, OUT, rd(), js(), uiFontsInline() (+4 more)

### Community 27 - "Community 27"
Cohesion: 0.09
Nodes (39): state, loadLocal(), saveLocal(), persist(), toast(), TREE, SEC, RAW (+31 more)

### Community 57 - "Community 57"
Cohesion: 0.07
Nodes (4): CFG, C, V, SUP

### Community 90 - "Community 90"
Cohesion: 0.14
Nodes (9): FIGS, MODELS, V3D, liveFigs, live3D, figBar(), setupFig(), setup3D() (+1 more)

### Community 96 - "Community 96"
Cohesion: 0.19
Nodes (13): sup(), tenTo(), SCALE_SETS, draw(), CLS, BARS, ASHBY, bondE() (+5 more)

### Community 173 - "Community 173"
Cohesion: 0.50
Nodes (2): rvPanel(), draw()

### Community 104 - "Community 104"
Cohesion: 0.21
Nodes (7): WIDGETS, shellW(), widgetOMR(), widgetCards(), PAIRC, widgetMatch(), widgetFill()

### Community 37 - "Community 37"
Cohesion: 0.07
Nodes (23): remove(), SystemExternal, x(), w(), k(), generate(), increment(), getRule() (+15 more)

### Community 79 - "Community 79"
Cohesion: 0.12
Nodes (1): r()

### Community 14 - "Community 14"
Cohesion: 0.05
Nodes (2): e(), T()

### Community 7 - "Community 7"
Cohesion: 0.05
Nodes (16): p(), h(), u(), d(), f(), L(), m(), y() (+8 more)

### Community 20 - "Community 20"
Cohesion: 0.06
Nodes (2): Q(), pauseValue()

### Community 13 - "Community 13"
Cohesion: 0.05
Nodes (6): s(), makeUnprocessed(), makeEmptyNode(), makeBranchNode(), getFactory(), parseList()

### Community 10 - "Community 10"
Cohesion: 0.04
Nodes (5): i(), getSeparator(), merge(), setRule(), getReference()

### Community 9 - "Community 9"
Cohesion: 0.05
Nodes (4): g(), getOptions(), start(), end()

### Community 5 - "Community 5"
Cohesion: 0.04
Nodes (3): a(), annotate(), visit()

### Community 28 - "Community 28"
Cohesion: 0.05
Nodes (3): o(), match(), compare()

### Community 115 - "Community 115"
Cohesion: 0.31
Nodes (11): esc(), shuffle(), hydrateExample(), hydrateWidget(), renderFill(), renderOMR(), renderCards(), renderMatch() (+3 more)

### Community 94 - "Community 94"
Cohesion: 0.13
Nodes (2): STATIONS, MODULES

### Community 39 - "Community 39"
Cohesion: 0.09
Nodes (31): mj(), readPalette(), setupFig(), loop(), debounce(), loadLocal(), saveLocal(), persist() (+23 more)

### Community 78 - "Community 78"
Cohesion: 0.11
Nodes (2): STATIONS, MODULES

### Community 23 - "Community 23"
Cohesion: 0.07
Nodes (38): mj(), readPalette(), clipHalf(), boxCorners(), boxEdges(), planeBox(), wsCell(), cellScaffold() (+30 more)

### Community 207 - "Community 207"
Cohesion: 1.00
Nodes (1): DefaultFirebaseOptions

### Community 41 - "Community 41"
Cohesion: 0.05
Nodes (11): PopIntent, FlowApp, CourseSettingsScreen, _CourseSettingsScreenState, FormatEditorScreen, _FormatEditorScreenState, GlobalErrorCaptureLayer, _GlobalErrorCaptureLayerState (+3 more)

### Community 87 - "Community 87"
Cohesion: 0.14
Nodes (9): AiTask, AiQueueScreen, _AiQueueScreenState, in, tasks, 4337110 feat: remove AI 10-page chunk scan; auto-index failures go straight to manual picker, 9965175 feat: remove Pause AI feature; interrupted tasks auto-resume, d6812c1 feat: add Run now quick-run for scheduled AI tasks (+1 more)

### Community 12 - "Community 12"
Cohesion: 0.03
Nodes (33): SlideTemplate, LessonFormat, Book, QpQuestion, QpSection, QuestionPaper, QuickReviewItem, Module (+25 more)

### Community 2 - "Community 2"
Cohesion: 0.03
Nodes (116): DailyGoal, DailyGoalUpdateEvent, AppCrashRecoveryScreen, RealtimeProgressBar, 0184924 theme: migrate analytics_view, 01d6dd3 Merge branch 'main' of https://github.com/ihjas-ahammed/duofy, 0498e66 theme: migrate source_pdf_upload_screen, 05a15cd chore: add Android builds v26.7.15 [skip ci] (+108 more)

### Community 183 - "Community 183"
Cohesion: 0.50
Nodes (3): PyqItem, PyqQuestionAnswer, PyqExamAttempt

### Community 120 - "Community 120"
Cohesion: 0.20
Nodes (9): TreeNote, TreeRung, TreeLadder, TreeCheck, TreeTopic, TreeSection, TreeModule, TreeCourse (+1 more)

### Community 0 - "Community 0"
Cohesion: 0.02
Nodes (83): AuthScreen, _AuthScreenState, BookRouteLoaderScreen, _BookRouteLoaderScreenState, BookmarksScreen, _BookmarksScreenState, ExamScreen, GenerateQpScreen (+75 more)

### Community 38 - "Community 38"
Cohesion: 0.05
Nodes (11): Platform, FileSystemEntity, File, Directory, ProcessResult, Process, FileSystemException, IOException (+3 more)

### Community 82 - "Community 82"
Cohesion: 0.11
Nodes (5): AiProvidersScreen, _AiProvidersScreenState, TestAiChatMessage, TestAiDialog, _TestAiDialogState

### Community 8 - "Community 8"
Cohesion: 0.03
Nodes (25): AuthGate, MainLayoutScreen, _MainLayoutScreenState, currently, SettingsScreen, _SettingsScreenState, GlobalState, is (+17 more)

### Community 17 - "Community 17"
Cohesion: 0.03
Nodes (18): BookDashboardScreen, _BookDashboardScreenState, _MenuActionItem, _IconHeaderButton, UnitPrerequisite, _CustomFloatingActionButtonLocation, the, has (+10 more)

### Community 62 - "Community 62"
Cohesion: 0.08
Nodes (6): CourseEditStructureScreen, _CourseEditStructureScreenState, _DownloadProgressDialog, _DownloadProgressDialogState, in, button

### Community 157 - "Community 157"
Cohesion: 0.33
Nodes (2): DailyGoalsScreen, _DailyGoalsScreenState

### Community 18 - "Community 18"
Cohesion: 0.04
Nodes (20): ProgrammingSlidesScreen, _ProgramCard, _ProgramCardState, _RunnerCard, YoutubeVideo, SummaryScreen, _SummaryScreenState, lecture (+12 more)

### Community 30 - "Community 30"
Cohesion: 0.04
Nodes (14): DocumentStoreScreen, _DocumentStoreScreenState, B2PdfViewerScreen, PdfThumbnailWidget, _PdfThumbnailWidgetState, CategoryTabs, ConfirmNameDialog, _ConfirmNameDialogState (+6 more)

### Community 43 - "Community 43"
Cohesion: 0.06
Nodes (9): ExperimentsScreen, _ExperimentsScreenState, ExperimentPreviewScreen, _ExperimentPreviewScreenState, AnalyticsView, _AnalyticsViewState, OrderingView, _OrderingViewState (+1 more)

### Community 55 - "Community 55"
Cohesion: 0.07
Nodes (6): GenerateBookScreen, _GenerateBookScreenState, _DocumentStorePickerDialog, _DocumentStorePickerDialogState, _DownloadProgressDialog, _DownloadProgressDialogState

### Community 52 - "Community 52"
Cohesion: 0.07
Nodes (3): HomeScreen, _HomeScreenState, SearchResultItem

### Community 146 - "Community 146"
Cohesion: 0.29
Nodes (2): CodeIdeScreen, _CodeIdeScreenState

### Community 126 - "Community 126"
Cohesion: 0.22
Nodes (4): HtmlIdeScreen, _HtmlIdeScreenState, 0c1e4c0 chore: add Android builds v26.8.6 [skip ci], df34d11 Fix latex, peace

### Community 22 - "Community 22"
Cohesion: 0.04
Nodes (11): LatexIdeScreen, _LatexIdeScreenState, _LatexErrorAiExplainerSheet, _LatexErrorAiExplainerSheetState, LatexPdfPreviewScreen, _LatexPdfPreviewScreenState, PreprocessRule, LatexJsEngineManager (+3 more)

### Community 113 - "Community 113"
Cohesion: 0.18
Nodes (2): PythonNotebookScreen, _PythonNotebookScreenState

### Community 119 - "Community 119"
Cohesion: 0.20
Nodes (3): UniversalCodeRunnerScreen, _UniversalCodeRunnerScreenState, Main

### Community 49 - "Community 49"
Cohesion: 0.07
Nodes (12): LessonCompleteScreen, _LessonCompleteScreenState, _CircularGaugePainter, _SparklinePainter, _DottedLinePainter, difficulty, CanvasArtView, _CanvasArtViewState (+4 more)

### Community 26 - "Community 26"
Cohesion: 0.04
Nodes (15): LessonScreen, _LessonScreenState, nextSecIdx, nextModIdx, DuoButton, _DuoButtonState, DuoIconButton, _DuoIconButtonState (+7 more)

### Community 114 - "Community 114"
Cohesion: 0.18
Nodes (2): MetacognitionSetupScreen, _MetacognitionSetupScreenState

### Community 80 - "Community 80"
Cohesion: 0.11
Nodes (4): ModuleNotesViewerScreen, _ModuleNotesViewerScreenState, 14e7263 feat: Quick Generate Module Notes with MathJax TeX rendering, mobile responsiveness, and A4 PDF export (v26.8.7+2126080701), e0cfdd0 chore: add Android builds v26.8.7 [skip ci]

### Community 6 - "Community 6"
Cohesion: 0.02
Nodes (37): ModuleSelectionScreen, _ModuleSelectionScreenState, _MenuActionItem, _BookmarkMatch, now, final, SectionSelectionScreen, _SectionSelectionScreenState (+29 more)

### Community 4 - "Community 4"
Cohesion: 0.02
Nodes (45): _OnboardingPage, OnboardingScreen, _OnboardingScreenState, AppColors, AppTheme, ConceptPiecesView, _ConceptPiecesViewState, _ParsedConceptPiece (+37 more)

### Community 83 - "Community 83"
Cohesion: 0.11
Nodes (3): PdfSplitPreviewScreen, _PdfSplitPreviewScreenState, in

### Community 74 - "Community 74"
Cohesion: 0.11
Nodes (10): _UnitRef, _SectionRef, _ModuleRef, _PracticeMode, PracticeScreen, _PracticeScreenState, _PyqModeCard, _ModeCard (+2 more)

### Community 133 - "Community 133"
Cohesion: 0.25
Nodes (2): PyqExamScreen, _PyqExamScreenState

### Community 85 - "Community 85"
Cohesion: 0.12
Nodes (3): PyqPanelScreen, _PyqPanelScreenState, and

### Community 128 - "Community 128"
Cohesion: 0.22
Nodes (3): PyqScoreHistoryScreen, _PyqScoreHistoryScreenState, PyqExamDetailScreen

### Community 64 - "Community 64"
Cohesion: 0.09
Nodes (10): PyqTabScreen, _PyqTabScreenState, currently, 18142cc chore: add Android builds v26.7.15 [skip ci], 3f4d091 Merge branch 'main' of https://github.com/ihjas-ahammed/duofy, 4c8673e OKKK, 7a4966f chore: add Android builds v26.7.15 [skip ci], ab7968d it ignored my command lets see whta this will be (+2 more)

### Community 102 - "Community 102"
Cohesion: 0.15
Nodes (3): NotebookCell, PythonIdeScreen, _PythonIdeScreenState

### Community 199 - "Community 199"
Cohesion: 0.67
Nodes (2): ReelViewScreen, are

### Community 103 - "Community 103"
Cohesion: 0.15
Nodes (3): ReferencePdfViewerScreen, _ReferencePdfViewerScreenState, in

### Community 175 - "Community 175"
Cohesion: 0.40
Nodes (2): HtmlAppViewerScreen, _HtmlAppViewerScreenState

### Community 142 - "Community 142"
Cohesion: 0.25
Nodes (4): TreeReaderScreen, _TreeReaderScreenState, _buildTickBox, tag

### Community 134 - "Community 134"
Cohesion: 0.25
Nodes (2): ActiveRequestInfo, AiEstimator

### Community 21 - "Community 21"
Cohesion: 0.04
Nodes (8): AiService, UnitManifestResult, PyqExtractionResult, module, to, in, outlines, title

### Community 135 - "Community 135"
Cohesion: 0.25
Nodes (2): AutoIndexResult, AutoIndexPipeline

### Community 75 - "Community 75"
Cohesion: 0.11
Nodes (3): B2Object, B2Credentials, B2Service

### Community 129 - "Community 129"
Cohesion: 0.22
Nodes (2): Bookmark, BookmarkService

### Community 158 - "Community 158"
Cohesion: 0.33
Nodes (3): NotebookCell, IdeProject, CodeStorageService

### Community 136 - "Community 136"
Cohesion: 0.25
Nodes (1): DailyGoalsService

### Community 137 - "Community 137"
Cohesion: 0.25
Nodes (2): CapturedError, ErrorCaptureService

### Community 112 - "Community 112"
Cohesion: 0.18
Nodes (5): FbAuthException, FbUser, _FaUser, FbAuth, _FaAuth

### Community 109 - "Community 109"
Cohesion: 0.17
Nodes (8): FbDocSnapshot, FbQuerySnapshot, FbDocRef, FbCollectionRef, FbFirestore, _CfFirestore, _CfCollection, _CfDoc

### Community 81 - "Community 81"
Cohesion: 0.11
Nodes (6): _FileTokenStore, _FdUser, FdAuthBackend, FdFirestoreBackend, _FdCollection, _FdDoc

### Community 166 - "Community 166"
Cohesion: 0.40
Nodes (2): FdAuthBackend, FdFirestoreBackend

### Community 11 - "Community 11"
Cohesion: 0.03
Nodes (6): GenerationTask, UnitGenTask, QpGenTask, GenerationManager, when, the

### Community 148 - "Community 148"
Cohesion: 0.29
Nodes (1): GuestService

### Community 149 - "Community 149"
Cohesion: 0.29
Nodes (1): HomeWidgetService

### Community 170 - "Community 170"
Cohesion: 0.40
Nodes (2): IdeSettings, IdeSettingsService

### Community 171 - "Community 171"
Cohesion: 0.40
Nodes (1): LatexJsonRepairer

### Community 159 - "Community 159"
Cohesion: 0.33
Nodes (2): LoadingStep, LoadingProgressController

### Community 130 - "Community 130"
Cohesion: 0.22
Nodes (2): MappingReport, MappingVerifier

### Community 71 - "Community 71"
Cohesion: 0.10
Nodes (2): MathEvaluatorService, _MathParser

### Community 72 - "Community 72"
Cohesion: 0.10
Nodes (6): MetacogEvent, ReviewItem, CalibrationStats, MetacognitionService, difficulty, should

### Community 160 - "Community 160"
Cohesion: 0.33
Nodes (2): ModuleNotesHtmlBuilder, study

### Community 56 - "Community 56"
Cohesion: 0.07
Nodes (8): ModuleNotesJob, ModuleNotesService, notes, and, sequentially, textbook, as, Title

### Community 131 - "Community 131"
Cohesion: 0.22
Nodes (2): ResolvedRanges, PageMapping

### Community 76 - "Community 76"
Cohesion: 0.11
Nodes (3): PdfService, PdfBookmarkNode, in

### Community 172 - "Community 172"
Cohesion: 0.40
Nodes (3): PersonalizationService, being, as

### Community 77 - "Community 77"
Cohesion: 0.11
Nodes (1): ProgressService

### Community 98 - "Community 98"
Cohesion: 0.14
Nodes (2): PyqExamService, PyqAnalysisJob

### Community 1 - "Community 1"
Cohesion: 0.01
Nodes (23): PythonExecutionResult, PythonRunnerService, _NumpyArray, _NumpyRandomStub, _NumpyLinalgStub, _NumpyModuleStub, _PyplotStub, _Series (+15 more)

### Community 161 - "Community 161"
Cohesion: 0.33
Nodes (3): DayStreakData, StreakInfo, StreakService

### Community 138 - "Community 138"
Cohesion: 0.25
Nodes (3): TocMatcher, index, overview

### Community 63 - "Community 63"
Cohesion: 0.08
Nodes (4): TreeReaderService, toggle, are, done

### Community 99 - "Community 99"
Cohesion: 0.14
Nodes (2): UpdateInfo, UpdateService

### Community 95 - "Community 95"
Cohesion: 0.13
Nodes (1): UsageLimitService

### Community 150 - "Community 150"
Cohesion: 0.29
Nodes (1): WalkthroughService

### Community 143 - "Community 143"
Cohesion: 0.25
Nodes (2): LatexUtils, _TextPart

### Community 151 - "Community 151"
Cohesion: 0.29
Nodes (1): SectionColors

### Community 97 - "Community 97"
Cohesion: 0.13
Nodes (3): CodeHighlighter, CodeTheme, CodeEditingController

### Community 154 - "Community 154"
Cohesion: 0.29
Nodes (3): ComboBadge, _ComboBadgeState, _ComboStyle

### Community 193 - "Community 193"
Cohesion: 0.50
Nodes (2): DailyGoalsCompleteCard, _DailyGoalsCompleteCardState

### Community 203 - "Community 203"
Cohesion: 0.67
Nodes (1): DailyGoalsPopup

### Community 118 - "Community 118"
Cohesion: 0.18
Nodes (2): DesktopWebView, _DesktopWebViewState

### Community 123 - "Community 123"
Cohesion: 0.20
Nodes (4): FloatingDailyGoalToast, _FloatingDailyGoalToastState, FloatingDailyGoalListener, _FloatingDailyGoalListenerState

### Community 164 - "Community 164"
Cohesion: 0.33
Nodes (2): IdeConfigDialog, _IdeConfigDialogState

### Community 108 - "Community 108"
Cohesion: 0.15
Nodes (8): CrystalInfo, Interactive3dUnitCell, _Interactive3dUnitCellState, _Atom3D, _UnitCell3dPainter, Interactive3dMillerPlanes, _Interactive3dMillerPlanesState, _MillerPlanes3dPainter

### Community 70 - "Community 70"
Cohesion: 0.10
Nodes (3): ChatMessage, LessonAssistantChat, _LessonAssistantChatState

### Community 68 - "Community 68"
Cohesion: 0.09
Nodes (10): LessonPath, _LessonPathState, _PathPoint, _Element, _PathConnectorPainter, _SectionManifestPanel, _SectionManifestPanelState, _UnitFormatConfirmPanel (+2 more)

### Community 84 - "Community 84"
Cohesion: 0.11
Nodes (7): MathMarkdown, _PermissiveLatexInlineSyntax, _MathBuilder, _BlankSyntax, _BlankBuilder, _InlineBlankField, _InlineBlankFieldState

### Community 124 - "Community 124"
Cohesion: 0.20
Nodes (4): PlatformWebViewController, PlatformWebView, _PlatformWebViewState, PlatformWebViewBootstrap

### Community 93 - "Community 93"
Cohesion: 0.13
Nodes (9): QuickReviewSheet, _QuickReviewSheetState, MatchingLessonResult, _EmptyReviewPanel, _LoadingPanel, _LoadingPanelState, _ReviewItemCard, _StatementDetailSheet (+1 more)

### Community 204 - "Community 204"
Cohesion: 0.67
Nodes (2): ResponsiveMaxWidth, ResponsiveCenter

### Community 32 - "Community 32"
Cohesion: 0.04
Nodes (4): WebPdfTextSearchResult, SafePdfViewerController, SafePdfViewer, _SafePdfViewerState

### Community 66 - "Community 66"
Cohesion: 0.09
Nodes (3): CodeRunnerView, _CodeRunnerViewState, CodeRunnerHtml

### Community 89 - "Community 89"
Cohesion: 0.13
Nodes (2): InteractiveProofView, _InteractiveProofViewState

### Community 121 - "Community 121"
Cohesion: 0.20
Nodes (4): ProgramView, _ProgramViewState, _CodePanel, _CodePanelState

### Community 185 - "Community 185"
Cohesion: 0.50
Nodes (2): SlideActionButton, _SlideActionButtonState

### Community 132 - "Community 132"
Cohesion: 0.22
Nodes (4): SlideCapsuleToolbar, _SlideCapsuleToolbarState, _LiquidWavePainter, _BotAvatarPainter

### Community 200 - "Community 200"
Cohesion: 0.67
Nodes (2): SlideFeedbackSheet, _SlideFeedbackSheetState

### Community 145 - "Community 145"
Cohesion: 0.25
Nodes (3): UpdateDialog, _UpdateDialogState, _DownloadProgress

### Community 181 - "Community 181"
Cohesion: 0.40
Nodes (2): WebWebViewWidget, _WebWebViewWidgetState

### Community 208 - "Community 208"
Cohesion: 1.00
Nodes (1): LucideIcons

### Community 69 - "Community 69"
Cohesion: 0.10
Nodes (2): SimpleWindowDelegate, SimpleBrowserViewDelegate

### Community 165 - "Community 165"
Cohesion: 0.50
Nodes (2): Visit(), getVisitedCookies()

### Community 155 - "Community 155"
Cohesion: 0.33
Nodes (6): to_string(), OnProcessMessageReceived(), OnTakeFocus(), setJavaScriptChannels(), GetCallbackId(), executeJavaScript()

### Community 196 - "Community 196"
Cohesion: 0.67
Nodes (3): GetDataURI(), OnLoadError(), IsChromeRuntimeEnabled()

### Community 206 - "Community 206"
Cohesion: 1.00
Nodes (2): OnBeforePopup(), loadUrl()

### Community 111 - "Community 111"
Cohesion: 0.27
Nodes (6): ConvertCefV8ValueToJSValue(), Execute(), StartRequest(), EvaluateCallback(), GetNextReqID(), CallCppFunction()

### Community 88 - "Community 88"
Cohesion: 0.17
Nodes (7): WebviewPlugin(), initCallback(), uninitCallback(), HandleMethodCall(), cursorAction(), startCEF(), stopCEF()

### Community 24 - "Community 24"
Cohesion: 0.09
Nodes (49): webview_ptr_array_new_with_free_func(), webview_ptr_array_free(), webview_ptr_array_unref(), webview_ptr_array_add(), webview_ptr_array_index(), webview_value_new(), webview_value_lookup_index(), webview_value_destroy() (+41 more)

### Community 184 - "Community 184"
Cohesion: 0.67
Nodes (2): GetCommandLineArguments(), Utf8FromUtf16()

### Community 65 - "Community 65"
Cohesion: 0.17
Nodes (17): Scale(), EnableFullDpiSupportIfAvailable(), WindowClassRegistrar, GetWindowClass(), UnregisterWindowClass(), Win32Window(), CreateAndShow(), Win32Window::WndProc() (+9 more)

### Community 58 - "Community 58"
Cohesion: 0.07
Nodes (3): WebViewController, WebView, WebViewState

### Community 201 - "Community 201"
Cohesion: 0.67
Nodes (1): WebviewEventsListener

### Community 186 - "Community 186"
Cohesion: 0.50
Nodes (2): UserScript, InjectUserScripts

### Community 187 - "Community 187"
Cohesion: 0.50
Nodes (2): JavascriptMessage, JavascriptChannel

### Community 105 - "Community 105"
Cohesion: 0.15
Nodes (1): WebviewManager

### Community 188 - "Community 188"
Cohesion: 0.50
Nodes (1): WebviewTooltip

### Community 198 - "Community 198"
Cohesion: 0.67
Nodes (1): MethodChannelWebviewCef

### Community 182 - "Community 182"
Cohesion: 0.50
Nodes (2): WebviewCefPlatform, that

### Community 156 - "Community 156"
Cohesion: 0.40
Nodes (2): KeyboardCodeFromXKeysym(), GdkEventToWindowsKeyCode()

### Community 100 - "Community 100"
Cohesion: 0.21
Nodes (6): WebviewTextureRenderer, encode_wavlue_to_flvalue(), encode_flvalue_to_wvalue(), webview_cef_plugin_handle_method_call(), method_call_cb(), webview_cef_plugin_register_with_registrar()

### Community 191 - "Community 191"
Cohesion: 0.50
Nodes (1): MockWebviewCefPlatform

### Community 194 - "Community 194"
Cohesion: 1.00
Nodes (3): IsKeyDown(), GetCefKeyboardModifiers(), getCefKeyEvent()

### Community 125 - "Community 125"
Cohesion: 0.29
Nodes (5): WebviewTextureRenderer, encode_wvalue_to_flvalue(), encode_flvalue_to_wvalue(), RegisterWithRegistrar(), HandleMethodCall()

### Community 127 - "Community 127"
Cohesion: 0.31
Nodes (8): load_gitignore_patterns(), should_ignore(), is_likely_binary_file(), pack_project(), Loads patterns from .gitignore file in the root directory., Checks if a given path (relative to project root) should be ignored.     Uses .g, Checks if a file is likely binary based on its extension or content., Packs all relevant files into a single text file.

### Community 189 - "Community 189"
Cohesion: 0.50
Nodes (1): Harness

### Community 174 - "Community 174"
Cohesion: 0.40
Nodes (2): _FakePdfService, _NoAi

### Community 176 - "Community 176"
Cohesion: 0.50
Nodes (4): parse_snapshot(), update_project_from_snapshot(), Parses the snapshot content and yields (filename, file_content) tuples., Reads the snapshot file and updates the project files accordingly.

## Knowledge Gaps
- **623 isolated node(s):** `Latin subsets of the UI fonts as base64 woff2, cached in vendor/uifonts.css.`, `STATIONS`, `MODULES`, `LXTeX`, `hl` (+618 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `Community 116`** (2 nodes): `ni`, `ii`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 67`** (1 nodes): `di()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 180`** (1 nodes): `yi`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 192`** (1 nodes): `vi`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 152`** (1 nodes): `eo`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 179`** (1 nodes): `ro`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 153`** (2 nodes): `qo`, `ws()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 163`** (1 nodes): `Do`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 178`** (1 nodes): `Lo`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 177`** (1 nodes): `As`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 173`** (2 nodes): `rvPanel()`, `draw()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 79`** (1 nodes): `r()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 14`** (2 nodes): `e()`, `T()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 20`** (2 nodes): `Q()`, `pauseValue()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 94`** (2 nodes): `STATIONS`, `MODULES`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 78`** (2 nodes): `STATIONS`, `MODULES`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 207`** (1 nodes): `DefaultFirebaseOptions`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 157`** (2 nodes): `DailyGoalsScreen`, `_DailyGoalsScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 146`** (2 nodes): `CodeIdeScreen`, `_CodeIdeScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 113`** (2 nodes): `PythonNotebookScreen`, `_PythonNotebookScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 114`** (2 nodes): `MetacognitionSetupScreen`, `_MetacognitionSetupScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 133`** (2 nodes): `PyqExamScreen`, `_PyqExamScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 199`** (2 nodes): `ReelViewScreen`, `are`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 175`** (2 nodes): `HtmlAppViewerScreen`, `_HtmlAppViewerScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 134`** (2 nodes): `ActiveRequestInfo`, `AiEstimator`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 135`** (2 nodes): `AutoIndexResult`, `AutoIndexPipeline`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 129`** (2 nodes): `Bookmark`, `BookmarkService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 136`** (1 nodes): `DailyGoalsService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 137`** (2 nodes): `CapturedError`, `ErrorCaptureService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 166`** (2 nodes): `FdAuthBackend`, `FdFirestoreBackend`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 148`** (1 nodes): `GuestService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 149`** (1 nodes): `HomeWidgetService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 170`** (2 nodes): `IdeSettings`, `IdeSettingsService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 171`** (1 nodes): `LatexJsonRepairer`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 159`** (2 nodes): `LoadingStep`, `LoadingProgressController`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 130`** (2 nodes): `MappingReport`, `MappingVerifier`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 71`** (2 nodes): `MathEvaluatorService`, `_MathParser`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 160`** (2 nodes): `ModuleNotesHtmlBuilder`, `study`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 131`** (2 nodes): `ResolvedRanges`, `PageMapping`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 77`** (1 nodes): `ProgressService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 98`** (2 nodes): `PyqExamService`, `PyqAnalysisJob`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 99`** (2 nodes): `UpdateInfo`, `UpdateService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 95`** (1 nodes): `UsageLimitService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 150`** (1 nodes): `WalkthroughService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 143`** (2 nodes): `LatexUtils`, `_TextPart`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 151`** (1 nodes): `SectionColors`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 193`** (2 nodes): `DailyGoalsCompleteCard`, `_DailyGoalsCompleteCardState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 203`** (1 nodes): `DailyGoalsPopup`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 118`** (2 nodes): `DesktopWebView`, `_DesktopWebViewState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 164`** (2 nodes): `IdeConfigDialog`, `_IdeConfigDialogState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 204`** (2 nodes): `ResponsiveMaxWidth`, `ResponsiveCenter`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 89`** (2 nodes): `InteractiveProofView`, `_InteractiveProofViewState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 185`** (2 nodes): `SlideActionButton`, `_SlideActionButtonState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 200`** (2 nodes): `SlideFeedbackSheet`, `_SlideFeedbackSheetState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 181`** (2 nodes): `WebWebViewWidget`, `_WebWebViewWidgetState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 208`** (1 nodes): `LucideIcons`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 69`** (2 nodes): `SimpleWindowDelegate`, `SimpleBrowserViewDelegate`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 165`** (2 nodes): `Visit()`, `getVisitedCookies()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 206`** (2 nodes): `OnBeforePopup()`, `loadUrl()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 184`** (2 nodes): `GetCommandLineArguments()`, `Utf8FromUtf16()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 201`** (1 nodes): `WebviewEventsListener`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 186`** (2 nodes): `UserScript`, `InjectUserScripts`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 187`** (2 nodes): `JavascriptMessage`, `JavascriptChannel`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 105`** (1 nodes): `WebviewManager`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 188`** (1 nodes): `WebviewTooltip`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 198`** (1 nodes): `MethodChannelWebviewCef`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 182`** (2 nodes): `WebviewCefPlatform`, `that`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 156`** (2 nodes): `KeyboardCodeFromXKeysym()`, `GdkEventToWindowsKeyCode()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 191`** (1 nodes): `MockWebviewCefPlatform`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 189`** (1 nodes): `Harness`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 174`** (2 nodes): `_FakePdfService`, `_NoAi`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `a()` connect `Community 5` to `Community 37`, `Community 13`, `Community 9`, `Community 7`, `Community 144`, `Community 10`, `Community 14`, `Community 20`, `Community 79`, `Community 28`?**
  _High betweenness centrality (0.038) - this node is a cross-community bridge._
- **Why does `T()` connect `Community 14` to `Community 37`, `Community 5`, `Community 7`, `Community 20`, `Community 13`, `Community 10`, `Community 28`, `Community 79`, `Community 9`, `Community 144`?**
  _High betweenness centrality (0.026) - this node is a cross-community bridge._
- **Why does `i()` connect `Community 10` to `Community 37`, `Community 5`, `Community 7`, `Community 14`, `Community 9`, `Community 28`, `Community 79`, `Community 20`, `Community 13`?**
  _High betweenness centrality (0.026) - this node is a cross-community bridge._
- **What connects `Latin subsets of the UI fonts as base64 woff2, cached in vendor/uifonts.css.`, `STATIONS`, `MODULES` to the rest of the system?**
  _623 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 29` be split into smaller, more focused modules?**
  _Cohesion score 0.057971014492753624 - nodes in this community are weakly interconnected._
- **Should `Community 47` be split into smaller, more focused modules?**
  _Cohesion score 0.06881720430107527 - nodes in this community are weakly interconnected._
- **Should `Community 44` be split into smaller, more focused modules?**
  _Cohesion score 0.07661290322580645 - nodes in this community are weakly interconnected._