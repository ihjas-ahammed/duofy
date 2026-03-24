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
- `/lib/models`: Data structures (Book, Module, Lesson, Slide, QuestionPaper, etc.)
- `/lib/screens`: Auth, Home, Dashboard (Path), Exam, Lesson Player, Completion Screen, PDF Generator, Practice
- `/lib/widgets`: Modular UI components (Custom Duolingo-style Buttons, Glass Panels, MathMarkdown)
- `/lib/widgets/slide_views`: Individual renderers for theory, quiz, blanks, numericals, JS canvas, and Interactive Proofs.
- `/lib/services`: AI, Database handling, True Async PDF Isolates, Notification routing, and Dynamic Prompting services.
- `/lib/theme`: Colors and global styling matching the web platform

## Recent Updates & Design Process
- **Consolidated Exam Interface**: Merged Module Exams and Past Papers into a single, unified "Exams" tab. Users can access generated module-specific checks and manually uploaded external past papers dynamically from the same view.
- **Continuous File Uploads**: Users can now continuously select and append multiple files (PDFs/Images) seamlessly when creating a new course or uploading a new exam paper without losing previously selected ones.
- **Custom Prompts Injection**: Added the ability for users to pass custom directives to the AI (e.g. "Focus deeply on equations" or "Explain this for a 10 year old") when analyzing new files.
- **Native Vector PDF Splitting**: Replaced heavy JPEG rasterization with pure native vector page extraction (`PdfDocumentTemplate`).
- **Image Upload Integration**: Upgraded the upload workflows to accept multiple Images dynamically alongside PDFs.
- **Adaptive Psychological Progress Bar**: Logarithmic progress bar predicting processing time based on historical AI generation averages.
- **Cross-Device File Syncing & Restoring Missing Files**: Local PDF storage chunks are natively tied to devices to save bandwidth. If you switch devices and your synced course is missing the raw local PDF source files, a smart banner will prompt you to quickly re-upload the original document to automatically re-split and restore functionality without losing progress.