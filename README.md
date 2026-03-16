# DuoFY (Flutter Port)

A generic, Duolingo-style interactive learning platform that turns any book into an interactive lesson path using Gemini AI.

## Setup Instructions

### 1. Dependencies
Ensure you have the required packages:
```bash
flutter pub add firebase_database webview_flutter google_generative_ai file_picker flutter_markdown shared_preferences lucide_icons path_provider http
flutter pub add flutter_markdown_latex markdown
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
- `/lib/screens`: Home, Dashboard (Path), Lesson Player, Completion Screen, PDF Generator, Practice
- `/lib/widgets`: Modular UI components (Custom Duolingo-style Buttons, Glass Panels, MathMarkdown)
- `/lib/widgets/slide_views`: Individual renderers for theory, quiz, blanks, numericals, JS canvas, and Interactive Proofs.
- `/lib/services`: AI, Database handling, and PDF splitting services
- `/lib/theme`: Colors and global styling matching the web platform

## Recent Updates & Design Process
- **AI Generation Flow**: We simplified the course creation flow. The user no longer needs to manually input the course title; the AI intelligently derives it from the PDF content and file name.
- **Improved Settings & Model Fetching**: Instead of manually typing models, the Settings screen now fetches available Gemini models natively using your API key. Users can easily select fallback models from a bottom sheet.
- **Enhanced AI Logging**: Added extensive `print` logs in `ai_service.dart` to help developers debug metadata parsing and trace the raw JSON outputs returned by Gemini.
- **Two-Stage Background Generation**: When generating a new course, the app pulls the metadata first. Once confirmed by the user, the actual physical PDF splitting and saving happens asynchronously in the background. The user can return to the Home Screen and see a live "Generating" card.
- **Small Screen Optimizations**: All text fields, layouts, and paths (like `LessonPath` and `PdfSplitPreviewScreen`) have been refactored using `Flexible`, `Expanded`, and max-lines bounds to prevent layout overflows on smaller devices (e.g. 720x1520 at 271dpi).
- **Closure Variable Bug Fix**: Fixed a critical bug where `unitIdx` was inaccurately tracked inside the `LessonPath` loop due to Dart's closure variable capture mechanics. This resolves the `RangeError (index)` thrown when attempting to generate units on existing courses.
- **Enhanced Modularity**: Refactored the unit card UI out of `LessonPath` into a dedicated `UnitHeader` widget (`lib/widgets/unit_header.dart`), keeping code clean, maintainable, and focused on drawing the path itself.
