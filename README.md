# DuoFY (Flutter Port)

A generic, Duolingo-style interactive learning platform that turns any book into an interactive lesson path using Gemini AI.

## Setup Instructions

### 1. Firebase Realtime Database Configuration
This app uses Firebase Realtime Database to store generated books and progress.
1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Select your project (`duofy-mobile`).
3. Navigate to **Realtime Database** and click **Create Database**.
4. Start in **Test Mode** (for development) or set up strict security rules.
5. In your Flutter project, ensure you have run `flutterfire configure` to link your active Firebase project so that `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are properly updated.

### 2. Google Generative AI (Gemini) API Key
We use the Gemini API to analyze uploaded PDFs and generate interactive JSON lessons.
1. Get a free API key from [Google AI Studio](https://aistudio.google.com/app/apikey).
2. For safety, the API key is **not** hardcoded. 
3. When you launch the app, click the **Settings** (gear) icon on the Home Screen.
4. Enter your Gemini API key and save it securely on your device.

### 3. Turning Books into Interactive Lessons
1. On the Home Screen, tap the **"+"** Floating Action Button.
2. Select a PDF from your device.
3. The app will securely send the document to Gemini using your local API key to extract the content and convert it into a structured "DuoFY" interactive module path.
4. The generated book will automatically be saved to your Firebase Realtime Database and appear on your Home Screen.

## Project Structure Overview
- `/lib/models`: Data structures (Book, Module, Lesson, Slide, etc.)
- `/lib/screens`: Home, Dashboard (Path), Lesson Player, PDF Generator, Settings
- `/lib/widgets`: Modular UI components (Custom Duolingo-style Buttons, Glass Panels, WebViews)
- `/lib/services`: AI and Database handling services
- `/lib/theme`: Colors and global styling matching the web platform