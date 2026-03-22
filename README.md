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
- `/lib/models`: Data structures (Book, Module, Lesson, Slide, InteractiveStep, etc.)
- `/lib/screens`: Auth, Home, Dashboard (Path), Lesson Player, Completion Screen, PDF Generator, Practice, PDF Browser, Advanced Prompts
- `/lib/widgets`: Modular UI components (Custom Duolingo-style Buttons, Glass Panels, MathMarkdown)
- `/lib/widgets/slide_views`: Individual renderers for theory, quiz, blanks, numericals, JS canvas, and Interactive Proofs.
- `/lib/services`: AI, Database handling, True Async PDF Isolates, Notification routing, and Dynamic Prompting services.
- `/lib/theme`: Colors and global styling matching the web platform

## Recent Updates & Design Process
- **Background Notification System**: The app now integrates a seamless Notification Service that pushes progress updates and alerts even if the user minimizes or backs out of the generation screen. Tapping the "Action Required" notification routes users perfectly back to the exact required sub-view (like Page Splitting review).
- **True Async Isolate Compute**: Relocated the heavy physical `Syncfusion PDF` chunking process into a secondary Isolate using `compute()`. The UI thread remains perfectly free, maintaining 120hz frame rates for the Zeno's psychological progress bar without micro-stutters during heavy local file I/O operations.
- **Navigation Fix**: Solved the navigation double-pop issue after completing lessons so the user accurately lands right back on their lesson path.
- **Multi-User & Authentication**: Implemented Firebase Authentication to allow distinct user accounts. User profiles display dynamically in settings.
- **Global Data & App Store Home**: Transformed the home screen into an Apple App Store layout. Personal library uses compact horizontal scrolls, and users can now publish courses to the "Community Picks" global database.
- **Data Namespacing**: Completely separated local SharedPreferences and Firebase RTDB paths using Firebase UID.
- **Interactive Canvas Art**: Added a dedicated slide type that visualizes topics via interactive 2D HTML/JS Canvas rendered seamlessly below theory explanations.
- **Adaptive Psychological Progress Bar**: Replaced static loading spinners with a logarithmic progress bar (Zeno's paradox algorithm) that predicts processing time based on historical AI generation averages and file size.