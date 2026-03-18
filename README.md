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
- **Adaptive Psychological Progress Bar**: Replaced static loading spinners with a logarithmic progress bar (Zeno's paradox algorithm) that predicts processing time based on historical AI generation averages and file size, making long waits feel significantly shorter.
- **Robust Multiple Choice Engine**: Implemented cross-verification on `QuizOption` selections to prevent correct answers from being flagged as incorrect when the AI generates redundant or un-indexed JSON structures. Enforces exactly ONE correct option at the instantiation layer.
- **Unified Interactive Step UI**: Deprecated the clumsy `step_by_step` slide splitting. Big questions now inherently utilize the polished, progressive disclosure format of the `InteractiveProofView`.
- **Async Course Generation Pipeline**: PDF metadata extraction is now moved to a background process. Users instantly see a "Generating Course" placeholder on their dashboard while AI extracts table of contents and page numbers.
- **Enhanced JSON Prompts**: Resolved missing `pageNo` data by restructuring the Book Skeleton prompt output. Now `startPage` and `endPage` are explicitly requested per unit.