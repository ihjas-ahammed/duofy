# DuoFY (Flutter Port)

A generic, Duolingo-style interactive learning platform that turns any book into an interactive lesson path using Gemini AI.

## Setup Instructions

### 1. New Dependencies Required
Make sure you have run the following commands to add all the dependencies:
```bash
flutter pub add firebase_database webview_flutter google_generative_ai file_picker flutter_markdown shared_preferences lucide_icons path_provider http
flutter pub add flutter_markdown_latex markdown
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
- `/lib/services`: AI and Database handling services
- `/lib/theme`: Colors and global styling matching the web platform

## Recent Updates & Design Process
- **AppBar Redesign**: Standardized `MainLayoutScreen` to prominently display the active Book Title in the center, relocating the global XP tracker to the top right.
- **Solid Selectors**: Fixed the Section Selector drawer in the dashboard. The drawer retains a glassmorphic blur, but individual section items now use solid `AppTheme.surface` backgrounds for better contrast and Duolingo-style compactness.
- **Practice Arena Modularization**: The Practice Screen now features a grid of distinct practice modes (MCQ, Proofs, Step-by-Step, Fill in the Blanks, Numericals). `PracticeSessionScreen` dynamically filters the question queue based on the selected mode.
- **Interactive Proofs**: Introduced `InteractiveProofView` to handle multi-step logical deductions. If a slide is of type `proof` or `step_by_step`, this view takes over the parent screen's bottom bar to manage sequential reveals and micro-interactions.
- **Windows Start Menu Style UI**: Revamped `HomeScreen` layout to resemble a compact app grid. Pinned items represent downloaded/created books, fitting seamlessly into a dense 3-column layout.
- **Dynamic API Keys & Model Fetching**: The `SettingsScreen` now utilizes an `ApiKeysManager` for individual list management rather than a comma-separated text string. Additionally, real-time HTTP polling queries `v1beta/models` to discover the latest AI offerings securely on-device.
- **Offline First Execution**: The database logic will strictly retrieve locally cached JSON payload mappings unless an explicit manual pull-to-refresh is initialized.
