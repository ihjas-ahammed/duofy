# Duofy Reusable Lesson Format: Android Lifecycle (Activity, ViewModel, and Jetpack Compose)

**Target Topic:** `03_Computer_Science_and_IT / 09_Web_Mobile_and_Cloud_Computing / Mobile_App_Development / Native_Android_Kotlin_iOS_Swift`  
**Lesson Format Type:** `android_activity_lifecycle_viewmodel_and_jetpack_compose`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through Android OS process management, configuration changes, declarative UI recomposition, and state preservation (Google Android Developer Architecture Guidelines; Dawn & David Griffiths *Head First Android Development*; Jetpack Compose Internals): master the **Android Activity Lifecycle State Machine** ($\mathbf{\texttt{onCreate()} \to \texttt{onStart()} \to \texttt{onResume()} \rightleftharpoons \texttt{onPause()} \to \texttt{onStop()} \to \texttt{onDestroy()}}$), analyze the catastrophic **Configuration Change Problem** (screen orientation rotation or dark-mode toggle destroying and recreating the entire Activity instance in memory), master the **Jetpack ViewModel Invariant** (the `ViewModel` instance is bound to the `ViewModelStoreOwner` and survives Activity destruction/recreation seamlessly without dropping state or restarting network requests), and master **Jetpack Compose Declarative UI** (`@Composable` functions, `remember { mutableStateOf() }`, State Hoisting, and Smart Recomposition).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Activity Lifecycle State Machine Diagram & ViewModel Scope Survival Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Chronological Lifecycle Execution During a Device Screen Rotation (Portrait $\to$ Landscape) Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Android Architecture Component / Lifecycle Callback & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Jetpack Architecture Component Designed to Retain UI State Across Activity Recreation Is the ___ (ViewModel) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Architectural Analysis: Why Storing Network Coroutines in an Activity Causes Memory Leaks on Rotation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Android Lifecycle (Google Developers 2022):
   - **Activity Lifecycle State Machine:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Lifecycle Callback} & \textbf{Activity Visibility State} & \textbf{Foreground / Interactive Status} \\
     \hline
     \mathbf{\texttt{onCreate()}} & \text{Created in memory; UI inflated} & \text{Not visible yet} \\
     \mathbf{\texttt{onStart()}} & \mathbf{\text{Visible to user}} & \text{Not in foreground yet} \\
     \mathbf{\texttt{onResume()}} & \mathbf{\text{Visible on screen}} & \mathbf{\text{Foreground active / Receiving touch inputs}} \\
     \mathbf{\texttt{onPause()}} & \text{Partially obscured (e.g. dialog)} & \text{Loses focus; pauses animations} \\
     \mathbf{\texttt{onStop()}} & \text{Completely hidden in background} & \text{Releases heavy resources} \\
     \mathbf{\texttt{onDestroy()}} & \mathbf{\text{Destroyed & removed from memory}} & \text{Final cleanup before GC} \\
     \hline
     \end{array}$$
   - **The ViewModel Invariant:**
     $$\mathbf{\text{Activity (Destroyed on Rotation)} \quad \longleftrightarrow \quad \mathbf{\text{ViewModel (PERSISTS across rotation in ViewModelStore!)}}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of screen rotation lifecycle: (1) user rotates phone from portrait to landscape while viewing active Activity, (2) OS triggers `onPause()` pausing animations, followed immediately by `onStop()`, (3) OS executes `onDestroy()` destroying the portrait Activity instance while ViewModel remains alive in memory, (4) OS initializes new landscape Activity instance calling `onCreate()` with updated layout configuration, (5) new Activity reconnects to existing `ViewModel` via `viewModels()` delegate and executes `onStart()` $\to$ `onResume()` displaying state seamlessly!
3. **Slide 3 (`matching`):** Pair 4 concepts (`onCreate()`, `onResume()`, Jetpack `ViewModel`, Jetpack Compose `remember`) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of ViewModel. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on memory leaks when holding Activity references in coroutines: Why does launching a background network coroutine tied directly to an `Activity` instance (or passing an `Activity` context into a long-lived repository) trigger a severe memory leak upon screen rotation? (When the user rotates the device, Android executes `onDestroy()` to tear down the old Activity instance and create a new one; **if a running background coroutine, static singleton, or repository holds a strong reference to the destroyed Activity (or its Context), the Java Virtual Machine / Android Runtime (ART) Garbage Collector cannot free the massive object tree (including its Window, View Hierarchy, and Bitmaps) from memory, causing an Activity Memory Leak that can accumulate megabytes of RAM and crash the app with OutOfMemoryError**; scoping coroutines to `viewModelScope` ensures proper lifecycle isolation).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "android_activity_lifecycle_viewmodel_and_jetpack_compose",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Android Lifecycle \\& ViewModel Scope Architecture (Google)**\n• **Activity Lifecycle State Machine:**\n$$\n\\mathbf{\\texttt{onCreate()}} \\to \\mathbf{\\texttt{onStart()}} \\to \\mathbf{\\texttt{onResume()}} \\rightleftharpoons \\mathbf{\\texttt{onPause()}} \\to \\mathbf{\\texttt{onStop()}} \\to \\mathbf{\\texttt{onDestroy()}}\n$$\n• **Configuration Change \\& ViewModel Invariant:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Component} & \\textbf{Behavior During Screen Rotation} & \\textbf{State Persistence} \\\\\n\\hline\n\\mathbf{\\text{Activity Instance}} & \\mathbf{\\text{DESTROYED and RECREATED from scratch}} & \\text{All instance variables lost!} \\\\\n\\mathbf{\\text{Jetpack ViewModel}} & \\mathbf{\\text{PERSISTS intact inside ViewModelStore}} & \\mathbf{\\text{Retains 100\\% of business state \\& coroutines!}} \\\\\n\\hline\n\\end{array}\n$$\n• **Jetpack Compose Declarative UI:** UI is rendered via $\\mathbf{\\texttt{@Composable}}$ functions that re-execute (**Recomposition**) automatically when observed $\\mathbf{\\texttt{StateFlow}}$ or $\\mathbf{\\texttt{mutableStateOf()}}$ values mutate!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential lifecycle events executed by Android when a user rotates the device screen from Portrait to Landscape.",
      "orderItems": [
        "User rotates device; Android OS initiates configuration change on the active Portrait Activity",
        "OS calls onPause() to halt animations, followed immediately by onStop() as visibility is relinquished",
        "OS calls onDestroy(), tearing down the Portrait Activity instance while the ViewModel remains cached in memory",
        "OS instantiates a brand-new Landscape Activity instance and invokes onCreate() passing configuration bundles",
        "New Activity reconnects to the existing ViewModel via by viewModels(), executes onStart() and onResume(), restoring UI instantly"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Android Architecture Component to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "onResume() Callback", "right": "Lifecycle point where Activity enters foreground, receives user touch input, and starts sensors" },
        { "left": "Jetpack ViewModel", "right": "Lifecycle-aware state container designed to survive configuration changes and manage coroutine scopes" },
        { "left": "remember { mutableStateOf() }", "right": "Compose primitive preserving local mutable state across declarative recomposition cycles" },
        { "left": "StateFlow.collectAsState()", "right": "Converts reactive Kotlin coroutine stream into native Compose state to trigger UI recomposition" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Android Jetpack architecture component designed to persist business state across Activity destruction and recreation is the ___.",
      "blankAnswer": "ViewModel",
      "blankDistractors": ["Activity", "Fragment", "Service"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does launching a long-running asynchronous network task holding a reference to an Activity context trigger a severe Android memory leak when the user rotates the device screen?",
      "options": [
        { "text": "When the screen is rotated, the Android OS invokes onDestroy() to destroy the old Activity instance and create a new one; if a running background coroutine or callback holds a strong reference to the destroyed Activity or its Context, the ART Garbage Collector is prevented from reclaiming the entire memory tree of the destroyed Activity (including its Window, View hierarchy, Bitmaps, and drawables); the leaked Activity remains pinned in heap memory permanently, accumulating megabytes of wasted RAM on every rotation until the operating system crashes the application with a java.lang.OutOfMemoryError", "isCorrect": true, "explanation": "Correct! This is one of the most famous and dangerous bugs in Android development (Google Android Architecture Guidelines; Square LeakCanary Architecture). 1. **The Anatomy of an Activity Leak:** - An `Activity` in Android is a massive object holding references to `PhoneWindow`, `DecorView`, the entire layout XML tree, and megabytes of image bitmaps. - If you launch a coroutine: `GlobalScope.launch { val data = api.fetch(); this@MainActivity.updateUI(data) }` - The coroutine closure captures `this@MainActivity` (strong reference). - If the user rotates the phone $5\\text{ times}$ during the network call: - 5 old `MainActivity` instances are destroyed by the OS. - BUT all 5 are held alive by the background threads! - Total leaked memory $= 5 \\times 40\\text{ MB} = \\mathbf{200\\text{ MB of dead RAM}}$! 2. **The ViewModel / `viewModelScope` Solution:** - `viewModelScope` is tied to the **ViewModel lifecycle**, not the Activity. - When the Activity is recreated, it simply binds to the same ViewModel. - When the screen is permanently closed (e.g. user presses Back), `viewModelScope` automatically **cancels all active coroutines**, guaranteeing zero leaks!" },
        { "text": "Because screen rotation physically damages the phone's battery", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Kotlin coroutines cannot execute on Android 12 or higher", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Activity instances are legally required to be deleted after 1 millisecond", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
