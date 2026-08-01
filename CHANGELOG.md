# Changelog

All notable changes to DuoFY are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com); versions follow the app's
`major.minor.patch` scheme from `pubspec.yaml`.

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
