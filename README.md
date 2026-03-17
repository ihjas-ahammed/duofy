# DuoFY (Flutter Port)

A generic, Duolingo-style interactive learning platform that turns any book into an interactive lesson path using Gemini AI.

## Setup Instructions

### 1. Dependencies
Ensure you have the required packages:
```bash
flutter pub add firebase_database webview_flutter google_generative_ai file_picker flutter_markdown shared_preferences lucide_icons path_provider http
flutter pub add flutter_markdown_latex markdown share_plus
flutter pub add syncfusion_flutter_pdf syncfusion_flutter_pdfviewer
```

### 2. Firebase Realtime Database Configuration
This app uses Firebase Realtime Database to store generated books and progress.
1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Select your project.
3. Navigate to **Realtime Database** and click **Create Database** (Start in Test Mode for development).
4. Run `flutterfire configure` to link your active Firebase project.

### 3. Google Generative AI (Gemini) API Key
We use the Gemini API to analyze uploaded PDFs and generate interactive JSON lessons.
1. Get a free API key from [Google AI Studio](https://aistudio.google.com/app/apikey).
2. Launch the app, click the **Settings** (gear) icon on the Home Screen.
3. Enter your Gemini API key and save it securely.

## Project Structure Overview
- `/lib/models`: Data structures (Book, Module, Lesson, Slide, InteractiveStep, etc.)
- `/lib/screens`: Home, Dashboard (Path), Lesson Player, Completion Screen, PDF Generator, Practice, PDF Browser, Advanced Prompts
- `/lib/widgets`: Modular UI components (Custom Duolingo-style Buttons, Glass Panels, MathMarkdown)
- `/lib/widgets/slide_views`: Individual renderers for theory, quiz, blanks, numericals, JS canvas, and Interactive Proofs.
- `/lib/services`: AI, Database handling, PDF splitting, and Dynamic Prompting services
- `/lib/theme`: Colors and global styling matching the web platform

## Recent Updates & Design Process
- **Dynamic Prompt Engine**: Added `PromptService` and an Advanced Settings screen allowing users to edit the exact instructions sent to the AI. Uses variables like `%unit_title%` and `%filename%`.
- **Improved PDF Browser**: The downloaded PDF chunk browser now intelligently maps raw directory IDs back to readable `Book Title` and `Unit Title`. When sharing, it copies the file to a clean, readable filename to improve the UX.
- **Deep Structure Generation**: Modified the skeleton AI prompts to fully utilize the Book -> Module (Chapter) -> Section (Subtopic) -> Unit (Deep Topic) hierarchy natively.
- **UI & Generation Fixes**: 
  - Eliminated "Empty Option" bugs in Quizzes by enforcing strict text presence in AI prompts and adding model-level fallbacks.
  - Stopped question titles from duplicating the question text.
  - Eliminated the `a (or b)` hallucination from `fill_in_blank` answers.
  - Explicitly integrated the `numerical` slide type into the AI generation loop for calculating physics/math outputs.
- **Bulletproof JSON Instantiation**: The `app_models.dart` `fromJson` constructors leverage defensive string extractors (`_str()`, `_bool()`).
