# Changelog

All notable changes to DuoFY are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com); versions follow the app's
`major.minor.patch` scheme from `pubspec.yaml`.

## [26.9.1] — 2026-09-01

### Added & Improved
- **Multi-File LaTeX Studio & Workspace File Manager**: Added full multi-file project support (`main.tex`, `references.bib`, `.tex` inclusions, `.sty` macros), mobile-first Navigation Drawer workspace explorer, and VS Code-style top file tabs bar with close buttons.
- **Online & Offline Multi-File TeX Live Compilation**: Enabled online compilation of multi-file projects and BibTeX bibliographies via validated payload schemas to `latex.ytotech.com`, with comprehensive offline fallback citation and include inlining.
- **LaTeX Presets & Highlighting**: Added pre-configured templates for Academic Papers (BibTeX), Multi-Chapter Reports, and presentations, along with BibTeX syntax highlighting in `CodeHighlighter`.
- **Hot Reload Resiliency**: Added state reassembly hooks and eliminated build-phase controller mutations in LaTeX IDE.
- **Reel-like View & Navigation Improvements**: Added dedicated Reel-like View screen button and simplified "Module Notes" action labels.

## [26.8.31] — 2026-08-31

### Added & Improved
- **Instant App Update Checking**: Implemented HTTP cache-busting and no-cache headers for update manifests and GitHub release endpoints, completely bypassing CDN stale caching so newly published builds appear immediately upon checking. Added fallback to `latest.txt`.
- **Interactive Difficult Steps Review & Practice**: Overhauled post-lesson review into an interactive Difficult Step Analysis sheet displaying question breakdowns, solutions, and explanations with full LaTeX, plus a "Practice Missed Questions (N)" launcher.
- **Universal LaTeX Math Support**: Extended `MathMarkdown` rendering to all interactive slide titles, headers, chips, and formulas.
- **Mobile-Contained Canvas Art & Interactive Diagrams**: Added strict small mobile viewport containment bounds and touch rules to the AI diagram generator prompt and optimized WebView container styling.
- **Live Assistant Chat Stability**: Safely managed WebSocket subscriptions and mounted state to prevent null-check errors on disposal.
- **Complete Learning Interface & Slide Redesign**: Modernized all interactive lesson slide screens based on cognitive load research and design token specifications (`docs/new-theme/slide-p/`).
- **Floating Glassmorphism Capsule Toolbar (`SlideCapsuleToolbar`)**: Introduced a frosted glass header with a smooth animated liquid gradient progress indicator bar, animated flame streak counter, AI Bot avatar button with celestial orbital ring, and clean quick navigation/secondary menu actions.
- **Tactile Elevated Action Button (`SlideActionButton`)**: Added animated 3D press interactions, customizable icons, and crisp state transitions across all slide flows.
- **Diagnostic Feedback Bottom Sheet (`SlideFeedbackSheet`)**: Built an interactive feedback sheet featuring celebration badges, causal explanations, and an expandable Misconception Analysis card ("Why other options fail").
- **Overhauled Interactive Slide Screen Types**: Modernized Theory, Quiz / OMR, Concept Pieces, Descriptive / Deep Concept, Interactive Proof, Math Pairs, Code Runner, Program, Numerical, Ordering, Error Spotting, Fill in the Blank, and One Word slide views.
- **Revamped Lesson Mastered Screen**: Redesigned completion view with an animated accuracy gauge, XP celebration animations, streak multiplier badges, and difficulty reflection feedback chips.
- **Celestial Theme Semantic Tokens**: Extended `AppColors` with unified tokens (`cardBg`, `cardBorder`, `mathBoxBg`, `primaryBlue`, `accentGreen`, `sheetBg`, etc.) ensuring seamless light and dark mode presentation.

## [26.8.27] — 2026-08-27

### Added & Improved
- **Online LaTeX Compiler via HTTP POST**: Replaced URL-length-restricted GET requests with JSON POST payloads to `https://latex.ytotech.com/builds/sync`, enabling compilation of arbitrarily large, multi-page LaTeX documents.
- **Explain Error with AI (LaTeX IDE)**: Integrated automated AI diagnosis and 1-tap correction directly in the LaTeX Studio error dialog.
- **Fixed LaTeX Syntax Highlighting**: Disabled quote-based string parsing for LaTeX/TeX files in `CodeHighlighter`.
- **Lesson Formats Optimization & 10-Cap**: Streamlined default and generated lesson formats to the top 10 pedagogical formats with non-programming subject filtering.
- **Interactive Programming Course Selector**: Added toggle card and programming language selector in Course Generator window.

## [26.8.12] — 2026-08-12

### Added & Improved
- **Multi-Arch Python Data Science Engine**: Integrated SeriousPython runtime supporting `arm64-v8a`, `armeabi-v7a`, and `x86_64` (emulator) architectures with pre-packaged data science libraries (`numpy`, `matplotlib`, `seaborn`, `scikit-learn`, `pandas`, `scipy`).
- **Interactive Notebook & SVG Rendering**: Live `input()` dialog prompts during Python execution and vector SVG rendering for Matplotlib plots.
- **Automatic Asset Hash Sync**: Automated hash verification for `app.zip.hash` to purge stale site-packages caches on app updates.
- **High-Density Study Notes Generator**: AI prompt and rendering engine for cheat-sheet study notes with native PDF export and MathJax TeX rendering.

## [26.8.8] — 2026-08-10

### Added & Improved
- **Python Data Science Engine**: Integrated SeriousPython multi-architecture runtime (`arm64-v8a`, `armeabi-v7a`, `x86_64`) pre-packaged with `numpy`, `matplotlib`, `seaborn`, `scikit-learn`, `pandas`, and `scipy`.
- **Interactive Python Notebook**: Live `input()` dialog prompts during Python execution and vector SVG rendering for Matplotlib plots.
- **Automatic Asset Hash Sync**: Automated hash verification for `app.zip.hash` to purge stale site-packages caches on app updates.
- **Concise Study Notes Generator**: Updated AI prompt and rendering engine for high-density cheat-sheet study notes with native PDF fallback support.

## [26.8.1] — 2026-08-01

### Added & Improved
- **Gamified Daily Goals System**: 20 pre-defined goal templates (lessons, XP, accuracy, units, modules, practice) + infinite procedural goal generation algorithm.
- **Floating Progress Bar Toasts**: Real-time animated floating toasts notifying progress updates during lessons and practice activities.
- **Stats Integration & Daily Goals Screen**: Integrated Daily Goals into Analytics view and built full screen with animated objective progress, reward claiming (+XP), and chest streak progression.
- **Conditional Launch Popup**: Daily launch popup presenting objectives when progress improvements exist.
- **Dark Theme Default**: Dark theme set as default mode across the app for optimal visual stability.

## [26.7.28] — 2026-07-28

### Added & Improved
- **Fast Local Loading & Background Sync**: Optimized initial loading path to load local cache and user session instantly (~0ms, same speed as offline). All cloud synchronization (remote courses, global library, folders, learning progress) now executes asynchronously in the background (`unawaited`).
- **Real-Time Loading Status**: Integrated `RealtimeProgressBar` into initial loading screens and added real-time status process descriptions ("Reading local courses...", "Loading cached community courses & folders...", "Calculating lesson progress...", "Syncing cloud updates in background...").
- **Organized Screenshots**: Organized root screenshot image files into `docs/screenshots/`.

## [26.7.25] — 2026-07-25

### Added & Improved
- **PYQ Tab Overhaul**: Subject/module filters, difficulty badges, and interactive LaTeX solution views.
- **LaTeX Math Rendering**: Comprehensive LaTeX parsing and formatting across all slide views and math components.
- **AI Service Resilience**: Multi-model fallback, prompt optimizations, and structured response error handling in `GenerationManager`.
- **Metacognitive Calibration**: Confidence ratings and calibration tracking integrated into lesson and practice flows.
- **Theme & Auth**: Refactored celestial light theme, username auth (@flow.in), and GitHub release auto-update checking.

## [27.0.0] — 2026-07-07 · "Pro" release

### Fixed — contents→pages mapping (the big one)
- Page arithmetic no longer happens inside the AI model. Skeleton prompts now
  ask for **printed TOC numbers verbatim**; all conversion (offset from the
  chapter-1 anchor, end derivation, ordering, clamping, gap-filling) is done
  deterministically in code (`lib/services/page_mapping.dart`, unit-tested).
  This removes the double-applied/skipped offsets, the "chapter 1 = printed
  page 1" assumption, and the `start+9`/`start+20` end-page guesses.
- New deterministic mapping verifier: samples sections across the whole book,
  never counts blank pages as matches, detects a uniform page shift and
  auto-corrects it (with AI verification only as a backstop).
- The PDF splitter validates ranges, gap-fills sections left unbounded
  between mapped neighbours, and **no longer silently copies the entire
  source PDF in** when chunking fails — failures are recorded on the section
  and surfaced with a repair path.
- Split-review screen now validates ranges (inversions/overlaps/gaps) and has
  a "shift all pages ±N" tool; a new **Repair Page Alignment** flow in course
  settings re-checks any existing book and re-splits with lessons preserved.

### Added — first-run experience
- 4-page onboarding walkthrough (skippable) with sign-in / guest choice;
  existing users skip it automatically.
- Guided empty-library state and a one-time 3-tip tour of the course
  dashboard.
- "Continue learning" hero card (one tap into the next uncompleted lesson)
  with a daily XP goal ring; configurable daily goal and a scheduled daily
  study reminder.

### Changed — less overwhelm
- New **Advanced mode** toggle (off for new users): per-node
  regenerate/schedule/reset/dependency actions and the model-ladder,
  concurrency, automation, experiments and live-chat settings are hidden
  until enabled.
- Settings reorganized into Learning / Personalization / Storage / API Keys,
  with everything power-user behind the Advanced toggle.
- The forced first-launch writing-style survey is gone; it lives on as an
  optional Settings → Personalization card.

### Added — a real metacognitive loop
- Optional one-tap confidence rating (Guessing / Unsure / Sure) before
  checking answers.
- Calibration analytics: accuracy when confident vs unsure vs guessing, with
  a coaching insight.
- One-tap post-lesson reflection (Too easy / Just right / Confusing) that
  feeds a per-module difficulty signal into future generation.
- **Smart Review**: wrong or guessed answers enter a spaced review queue
  (1 → 3 → 7 days) surfaced on Home and Practice.

### Added — new exercise types
- `matching` (pair the chips), `ordering` (drag steps into sequence),
  `error_spotting` (find the flawed step) and `flashcard` (recall-flip with
  honest self-grading that feeds Smart Review) — wired through generation
  prompts, the lesson player, and the Experiments tester.

### Changed — prompts & personalization
- Per-type schema rules unified into one auto-numbered block (removing
  years of copy-paste drift, including two different rules both numbered
  "9."), plus a pedagogy block: objectives first, ≥⅓ retrieval practice,
  worked-example → faded practice, interleaving, ≤120-word theory slides.
- New structured teaching preferences (examples-first/theory-first, language
  level, tone) merged with the writing-style profile, Bloom level and the
  reflection difficulty signal into every generation call.

### Added — web support
- `flutter build web --release` now works. Web v1 covers browsing community
  courses, playing lessons (all slide types incl. custom HTML), Smart
  Review, analytics, auth and cloud sync. PDF course creation remains on
  desktop/mobile for now.
- CI gained analyze+test gates, a web build job, and optional Firebase
  Hosting deploys.

### Security
- Shared Gemini keys and Backblaze credentials are no longer hardcoded: they
  live in the auth-gated Firestore doc `secrets/apikeys`, fetched at runtime
  and cached in memory only. Firestore security rules are now in the repo
  (`firestore.rules`). **Rotate the old Backblaze key** — it remains in git
  history (see `docs/SECURITY.md`).

## [26.x] — historical development log

Earlier releases were tracked as a running log in the README; the highlights
(onboarding survey, conditional slide generation, background processing,
3D lesson nodes, canvas diagrams, resume generation, batched skeletons,
module quick review, experiments screen, and more) are preserved in the git
history of `README.md`.
