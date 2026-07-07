# DuoFY

Turn any PDF into a Duolingo-style course. Upload a textbook, handout, or
syllabus — Gemini maps its chapters, splits the pages, and generates an
interactive lesson path you learn one bite-sized slide at a time.

**Platforms:** Android · Windows · Linux · Web (learning/browsing; PDF course
creation is desktop/mobile for now) · iOS/macOS untested but wired.

## Features

- **PDF → course pipeline** — deterministic contents→pages mapping (the AI
  only *reads* printed TOC numbers; all page arithmetic happens in code),
  automatic mapping verification with one-tap shift repair, native PDF
  splitting per section, resumable background generation with real progress.
- **14 interactive slide types** — theory, concept pieces, quiz,
  fill-in-the-blank, one-word, numerical, interactive proofs/step-by-step,
  matching pairs, ordering, error-spotting, flashcards, AI-graded descriptive
  answers, and fully custom HTML interactions — with LaTeX everywhere and
  AI-drawn canvas diagrams.
- **A real metacognitive loop** — rate your confidence before answers are
  revealed, see calibration analytics (accuracy when sure vs guessing),
  reflect after each lesson, and let **Smart Review** resurface your tricky
  items on a 1/3/7-day spaced schedule. Reflections tune future lesson
  difficulty per module.
- **Personal by design** — onboarding walkthrough, "Continue learning" hero
  with a daily XP goal ring, optional daily reminder, structured teaching
  preferences (examples-first, language level, tone) and an optional
  writing-style profile injected into every generation.
- **Calm by default, powerful when asked** — the Advanced mode toggle hides
  per-node regeneration/scheduling menus, model fallback ladders,
  concurrency and automation until you want them.
- **Local-first with optional cloud** — books live on-device as JSON;
  Firebase handles auth, backup/sync and the published community library.
  Shared API credentials are fetched at runtime from an auth-gated Firestore
  document, never compiled into the app.

## Setup

### 1. Flutter

Flutter 3.44.x (see `.github/workflows/build.yml` for the CI-pinned
version). Then:

```bash
flutter pub get
```

### 2. Firebase

The app uses Firebase Auth, Cloud Firestore, and (optionally) Hosting.

1. Create/select a project in the [Firebase console](https://console.firebase.google.com/).
2. Enable **Authentication → Email/Password** and **Cloud Firestore**.
3. Run `flutterfire configure` to regenerate `lib/firebase_options.dart` for
   your project (this repo is configured for `duofy-database`).
4. Deploy the security rules: `firebase deploy --only firestore:rules`.
5. (Shared credentials) Create the document `secrets/apikeys` — field shapes
   and the threat model are documented in [`docs/SECURITY.md`](docs/SECURITY.md).

On Linux/Windows desktop the app talks to Firebase through
[firedart](https://pub.dev/packages/firedart) (pure Dart); everywhere else it
uses the native FlutterFire SDKs. The switch is automatic.

### 3. Gemini API key

Get a free key from [Google AI Studio](https://aistudio.google.com/app/apikey)
and add it in **Settings → API Keys** (multiple keys rotate on rate limits).
Signed-in users fall back to the shared keys from `secrets/apikeys` when they
haven't added their own.

## Running & building

```bash
flutter run -d linux        # or android / windows / chrome
flutter analyze && flutter test
flutter build web --release # output in build/web (firebase.json serves it)
```

CI (GitHub Actions) runs analyze + tests, builds the web bundle (and deploys
to Firebase Hosting when the `FIREBASE_SERVICE_ACCOUNT` secret is set), and
publishes Windows/Android artifacts into `builds/` on pushes to `main`.

## Project structure

- `lib/models/` — data model (`Book → Module → Section → Unit → Lesson →
  Slide`) with defensive JSON parsing and format templates.
- `lib/services/` — the engine room: `page_mapping` (deterministic printed→
  absolute page math) + `mapping_verifier`, `prompt_service` (all AI prompts,
  composed from shared rule blocks), `ai_service` (Gemini with model/key
  fallback ladders), `generation_manager` (resumable background task queue),
  `pdf_service` (splitting/extraction), `metacognition_service` (confidence,
  calibration, spaced review), `personalization_service`,
  `secrets_service`, `database_service` (local-first storage + cloud sync),
  `fb/` (Firebase facades with a conditional firedart backend).
- `lib/platform/` — conditional-import shims (`io_shim`, `isolate_shim`,
  `file_image_shim`) that keep one codebase compiling on IO platforms *and*
  the web.
- `lib/screens/` & `lib/widgets/` — UI; new visual components get their own
  widget files (see `widgets/slide_views/` for the per-type renderers and
  `screens/onboarding/` for the walkthrough).
- `test/` — pure-Dart unit tests for page mapping, mapping verification, the
  review scheduler, slide parsing, and the auto-index pipeline.

## Development notes

- After changing code, run `graphify update .` to keep the knowledge graph in
  `graphify-out/` current (used for codebase navigation/queries).
- UI targets a 720×1520 portrait frame first; `ResponsiveCenter` provides the
  desktop width tiers. Extract new visual components into their own files
  under `lib/widgets/`.
- Release history lives in [`CHANGELOG.md`](CHANGELOG.md).
