# DuoFY (Flutter Port)

A generic, Duolingo-style interactive learning platform that turns any book into an interactive lesson path using Gemini AI.

## Setup Instructions

### 1. New Dependencies Required
Make sure you have run the following commands to add all the dependencies:
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
- **Two-Stage Background Generation**: When generating a new course, the app now pulls the metadata first. Once confirmed by the user, the actual physical PDF splitting and saving happens asynchronously in the background. The user can return to the Home Screen and see a live "Generating" card.
- **App Store Inspired Home Screen**: The UI features large, beautiful, high-contrast cards showcasing the progress of your generated books. Users can easily delete courses using the integrated delete actions on the cards.
- **Multiple Models & Keys Fallback**: Users can supply up to 5 models and 5 API keys in settings. If the primary model or key is rate-limited or fails context parsing, it seamlessly cycles to the next one, ensuring 99% reliability.
- **Robust MathJax & JSON Escaping**: Generation prompts have been strictly enforced to double-escape LaTeX strings (like `\\frac`), and aggressive sanitization runs on the Dart side to ensure UI rendering doesn't crash from literal string mismatches.
- **True Physical PDF Splitting**: Uses Syncfusion's `drawPdfTemplate` inside a fresh `PdfDocument` to guarantee the generated chunk drops all bloated, unreferenced metadata from the original document, keeping file sizes ultra-small.
