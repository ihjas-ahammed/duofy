# DuoFY (Flutter Port)

A generic, Duolingo-style interactive learning platform that turns any book into an interactive lesson path using Gemini AI.

## Setup Instructions

### 1. Dependencies
Ensure you have the required packages:
```bash
flutter pub add firebase_core firebase_auth firebase_database webview_flutter google_generative_ai file_picker flutter_markdown shared_preferences lucide_icons path_provider http
flutter pub add flutter_markdown_latex markdown share_plus
flutter pub add syncfusion_flutter_pdf syncfusion_flutter_pdfviewer
flutter pub add flutter_local_notifications
flutter pub add pdfx pdf
```

### 2. Firebase Configuration
This app uses Firebase Realtime Database and Firebase Authentication.
1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Select your project.
3. Enable **Authentication** (Email/Password).
4. Navigate to **Realtime Database** and click **Create Database** (Start in Test Mode for development).
5. Run `flutterfire configure` to link your active Firebase project.

### 3. Google Generative AI (Gemini) API Key
We use the Gemini API to analyze uploaded PDFs and generate interactive JSON lessons.
1. Get a free API key from [Google AI Studio](https://aistudio.google.com/app/apikey).
2. Launch the app, click the **Settings** (gear) icon on the Home Screen.
3. Enter your Gemini API key and save it securely.

## Project Structure Overview
- `/lib/models`: Data structures (Book, Module, Lesson, Slide, QuestionPaper, SlideTemplate, etc.)
- `/lib/screens`: Auth, Home, Dashboard (Path), Exam, Lesson Player, Course Settings, PDF Generator, Practice
- `/lib/widgets`: Modular UI components (Custom Duolingo-style Buttons, Glass Panels, MathMarkdown, LessonAccordion)
- `/lib/widgets/slide_views`: Individual renderers for theory, quiz, blanks, numericals, JS canvas, and Interactive Proofs.
- `/lib/services`: AI, Database handling, True Async PDF Isolates, Notification routing, and Dynamic Prompting services.

## Recent Updates & Design Process
- **Onboarding Personalization Survey**: New users are presented with a quick survey defining their learning style, favorite genres, and interests to deeply contextualize AI generated stories.
- **Conditional Slide Generation Priorities**: `CourseSettingsScreen` now allows users to define custom slide types and set explicit logical conditions (e.g., "Only if math proof is required") guiding exactly *when* the AI should output specific interactive blocks.
- **Compact UI Views & Theory Batching**: Theory slides have been dynamically batched to display up to two cards seamlessly per screen. Fill-in-the-blank text fields have been minified to fit perfectly inline with markdown text.
- **Continuous Background Processing**: You can now endlessly queue up Exam Papers and Courses. The generation screens remain active and reset instantly while pushing the intense vector-splitting and AI processing tasks entirely to the background with progress notifications.
- **Restored Horizontal Selectors**: Replaced vertical accordion bloat with sleek, Duolingo-style horizontal scrollable Module and Section selectors inside the main path view.
- **3D Lesson Nodes**: Lesson path nodes now render with a real depth lip, radial highlight, top gloss sliver, and a soft ground shadow — the Duolingo "physical disc" look. Pressing sinks the cap into the lip for tactile feedback.
- **Story Mode Removed**: Theory slides are no longer paired or split by a `---` divider on the lesson screen, and the default slide template + AI generation prompts now explicitly forbid narrative/storytelling framings.
- **Auto-Expanding Inline Blanks**: The fill-in-the-blank widget no longer uses a fixed 100px slot that wrapped to a new line. A new `InlineBlankField` widget measures the typed text and grows from a 64px minimum up to 220px so the blank flows inline with the surrounding sentence.
- **Inline LaTeX Fix**: Replaced `LatexElementBuilder` (which wrapped every equation in a horizontal `SingleChildScrollView`, forcing it to its own line) with a new `InlineMathBuilder`. Inline `$x^2$` now sits inside its sentence; only true display `$$...$$` blocks remain scrollable horizontally.
- **Canvas Art → Reusable HTML5 Canvas**: Lesson/proof diagrams are no longer generated as raw SVG. The graphics model now returns ONLY a JavaScript `draw(ctx, W, H)` function, which is embedded in a single fixed HTML `<canvas>` host (`lib/widgets/canvas_html_view.dart`) that owns the canvas, handles devicePixelRatio scaling, and calls `draw()`. The same scaffold is reused for every diagram — only the draw function changes. `CanvasArtView` auto-detects legacy `<svg>` markup vs. a draw function (`isSvgCanvas`) so old books still render. The `canvasArt` prompt was rewritten with a strict contract + a worked example `draw` function.
- **Full-Screen Diagrams**: `CanvasArtView` gained a maximize button (top-left) that opens the diagram full-screen via `showCanvasFullScreen` — SVG art is pinch-zoomable in an `InteractiveViewer`, JS-canvas art re-renders crisply at the larger size.
- **Numerical Slides Re-added + One-Word Slides**: The `numerical` slide type (number entry, tolerance-checked) is back in the default lesson templates and the generation prompts. A new `one_word` type (`lib/widgets/slide_views/one_word_view.dart`) asks a question with a single free-text answer box, checked case-insensitively against `blankAnswer` (no options/distractors). Both are wired through the lesson player, Practice modes, and the Practice session runner.
- **Exams Tab Deferred**: The Exams / Question-Paper tab was removed from the bottom nav (now Path / Practice / Notes) while that feature is reworked. `ExamScreen` and the QP generation pipeline are left intact for re-introduction in a later stage.
- **Local-First Storage Confirmed**: Books are stored on-device (per-book JSON files) as the source of truth; the cloud database (Firestore) is used only for published/community works, with an optional Cloud Backup & Sync toggle in Settings (off by default, no network until enabled).
- **Batched Skeleton Generation (chapters → sections)**: The single-shot TOC skeleton call was splitting/merging poorly on the lite model (skipped chapters, combined sections). Generation is now two-staged: `PromptService.chapterList` enumerates every chapter in one focused call (plus course metadata), then `PromptService.sectionList` runs once per chapter — in parallel, bounded by the concurrency setting — detailing that chapter's sub-topics within its exact absolute page range. A chapter whose section call fails falls back to a single whole-chapter section so nothing is ever dropped. Assembly goes through `Book.fromJson` to reuse all the existing defensive parsing.
- **Real Progress Everywhere**: Replaced the time-based `PsychologicalProgressBar` (which faked a crawl toward 100%) with `RealProgressBar`, driven by actual work counts. Skeleton generation reports chapters-completed / total; PDF chunking reports chunk N / total; unit generation reports a single 0→100% across all text+diagram steps. Phases with no granular count (the single chapter-mapping call, the section-manifest call) show an honest indeterminate spinner instead of a fake percentage. Task models (`GenerationTask`, `UnitGenTask`) carry a nullable `progress` and the AI/PDF services emit a real fraction through their `onProgress` callbacks.
- **Sequential, In-Order Lesson + Diagram Generation**: Lessons are produced one at a time, in order. Each lesson's text streams to the UI the moment it lands (shown immediately), its diagram is then rendered and the lesson is streamed again, and only then does the next lesson begin — so the learner watches lesson → its diagram → next lesson appear in sequence (no more parallel workers stalling on diagrams, which made texts arrive in chunks). `_attachArtToLesson` holds the per-lesson art logic; the old two-phase `generateCanvasArtForUnit` pass was removed.
- **Resume / Continue Generation**: An interrupted unit's already-saved lessons (persisted with `isGenerated: false` via the streaming save chain) are now pre-seeded and shown straight away, and `generateUnitContent` fills only the gaps — missing lessons and missing diagrams — so "Resume Generation" continues from where it left off instead of regenerating everything.
- **Fast Lite-Model Fallback on Slow Plans**: The "Analyzing PDF & Planning Layout" call (lite model) used a 4-minute timeout wrapped in a 3-attempt transient retry, so one slow/stuck model could block a unit for minutes. It now uses a 120s timeout and, on timeout, jumps straight to the next model/key instead of retrying the same slow model (`_retryTransient` gained a `retryTimeouts` flag; timeouts bypass the retry, while a genuine 502/overload still gets one quick retry). The status line tells the user when it switches models.
- **Hero Canvas + Design-First Diagrams**: The inline `CanvasArtView` now fills the card edge-to-edge as a full-width 3:2 hero (was a thin 16:7 strip) with the full-screen/refresh buttons floating on top. It's sized by aspect ratio rather than a fixed screen fraction, so the box hugs the diagram's shape with no empty bands above/below. The `canvasArt` prompt was retuned to prioritise a strong *visual* representation — shapes, structure, arrows, colour — over words: it must not draw a title/heading/caption and uses at most a few short essential labels.
- **Example & Exercise Questions Prompts Update**: Updated the AI prompt templates (`sectionList`, `syllabusSectionList`, `unitManifest`, `plan`, `json`, `singleLessonJson`) to ensure example and exercise questions are never neglected. When exercises or problems appear, they are created as dedicated units/sections and planned as individual, one-by-one lessons/slides to guarantee comprehensive hands-on practice.
- **End-of-Chapter Problems Section Inferences**: The `sectionList` and `syllabusSectionList` prompts now instruct the AI to use page ranges between the last mapped section and the chapter's end page boundary to detect and include the end-of-chapter "Problems" or "Exercises" section automatically.
- **Experiments / Slide Testing Screen**: Added a new slide testing widget/screen under Settings -> Experiments. The `ExperimentsScreen` supports rendering live interactive previews for all 10 slide types (theory, concept_pieces, proof, fill_in_blank, one_word, numerical, quiz, step_by_step, descriptive, custom_html) using built-in presets or custom user-provided JSON.

## Process Notes
- For UI changes the target screen is 720×1520 @ ~271 dpi (Pixel-class portrait). The 3D lesson node, inline blank, and inline LaTeX widgets were sized against that frame and use clamped widths/heights to avoid render overflow on smaller cards.
- When introducing new visual components, extract them into their own files under `/lib/widgets` or `/lib/widgets/slide_views/` rather than inlining them into screens — the recent inline blank/math refactor follows that pattern.