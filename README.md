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