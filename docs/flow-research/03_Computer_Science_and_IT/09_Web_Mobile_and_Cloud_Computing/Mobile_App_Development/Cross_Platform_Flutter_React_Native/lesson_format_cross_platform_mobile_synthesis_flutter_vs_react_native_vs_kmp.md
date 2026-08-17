# Duofy Reusable Lesson Format: Cross-Platform Strategy (Flutter vs React Native vs Kotlin Multiplatform)

**Target Topic:** `03_Computer_Science_and_IT / 09_Web_Mobile_and_Cloud_Computing / Mobile_App_Development / Cross_Platform_Flutter_React_Native`  
**Lesson Format Type:** `cross_platform_mobile_synthesis_flutter_vs_react_native_vs_kmp`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify high-level system design tradeoffs, team skill synergies, code sharing boundaries, and runtime performance benchmarks across cross-platform mobile paradigms (Google Flutter; Meta React Native; JetBrains Kotlin Multiplatform [KMP]): master the multi-dimensional comparison between **1. Flutter** (Unified Dart codebase, 100% shared UI via Impeller GPU canvas, best for highly custom bespoke UI and rapid multi-platform parity), **2. React Native (Fabric / JSI)** (Unified TypeScript codebase, 100% shared logic + native OEM view wrapping, best for teams leveraging web React skills and requiring instant access to deep native iOS/Android SDKs), and **3. Kotlin Multiplatform (KMP)** (Shared business logic, networking, and data layers in Kotlin, while maintaining 100% native declarative UI layers via Jetpack Compose for Android and SwiftUI for iOS, completely eliminating cross-platform UI abstraction risk), and interact with live Flutter Three-Trees inspector, React Native JSI method invoker, and Cross-Platform Strategy analyzer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cross-Platform Architecture Comparison Matrix (Flutter vs React Native vs KMP) Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Cross-Platform Technology / Architectural Trade-off & Best Use Case Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Kotlin Multiplatform (KMP) Adopts a Logic-Only Sharing Paradigm Over Cross-Platform UI Frameworks Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Technology Sharing Kotlin Business Logic While Using Pure Native SwiftUI and Jetpack Compose Is Kotlin ___ (Multiplatform / KMP) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Cross-Platform Mobile Studio: Flutter 3-Trees, RN JSI & KMP Matrix Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cross_platform_mobile_synthesis_flutter_vs_react_native_vs_kmp",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do Flutter, React Native, and Kotlin Multiplatform (KMP) compare across UI sharing, language, and performance?",
      "blankAnswer": "Cross-Platform Mobile Paradigms (Google, Meta, JetBrains): (1) FLUTTER (Google): Dart language. Renders everything to its own GPU Canvas (Impeller). Shares 100% of UI and logic. Delivers exact pixel-identical visual parity across Android, iOS, Web, and Desktop. Ideal for rich custom UIs and animated apps. (2) REACT NATIVE (Meta): TypeScript/React. Uses JSI and Fabric to map to real Native OEM Views (UIView / android.view.View). Shares logic and UI structure while looking natively at home on iOS/Android. Ideal for web teams moving to mobile. (3) KOTLIN MULTIPLATFORM (KMP, JetBrains): Kotlin language. Shares 100% of business logic, networking, database (SQLDelight), and repositories, while building PURE NATIVE UI in Jetpack Compose (Android) and SwiftUI (iOS). Zero UI abstraction compromises!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Mobile Cross-Platform Paradigm to its optimal Architectural Use Case.",
      "matchPairs": [
        { "left": "Flutter (Dart)", "right": "Bespoke custom brand UI, high-performance animations, and pixel-identical multi-platform apps" },
        { "left": "React Native (TypeScript)", "right": "Teams with strong React web expertise wanting shared logic with authentic native platform views" },
        { "left": "Kotlin Multiplatform (KMP)", "right": "Enterprises sharing complex domain/data logic while keeping 100% native SwiftUI and Compose UIs" },
        { "left": "Pure Native (Kotlin/Swift)", "right": "OS-intensive applications requiring immediate Day-1 platform API access and maximum device performance" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why have many large tech enterprises (such as Netflix, Cash App, and McDonald's) increasingly adopted Kotlin Multiplatform (KMP) for shared mobile code over cross-platform UI frameworks like Flutter and React Native?",
      "options": [
        { "text": "Cross-platform UI frameworks attempt to wrap or reinvent complex platform-specific UI behaviors (such as native navigation transitions, keyboard handling, system accessibility features, and iOS dynamic island widgets), which frequently introduces subtle uncanny-valley visual bugs or delayed support for new iOS/Android OS features; Kotlin Multiplatform (KMP) deliberately restricts code sharing to non-UI layers (business logic, offline SQLite caching, cryptography, network clients, and state machines), compiling directly to native JVM bytecode for Android and native Objective-C/C framework binaries for iOS, allowing mobile teams to craft 100% uncompromising native UIs using Jetpack Compose and SwiftUI with zero abstraction penalties", "isCorrect": true, "explanation": "Correct! This is JetBrains' and Touchlab's primary architectural value proposition for Kotlin Multiplatform (*KMP for Mobile Developers*; Cash App Engineering Blog). 1. **The UI Abstraction Uncanny Valley:** - Wrapping complex UI in a cross-platform layer (Flutter or React Native) is hard. When Apple releases a new iOS feature (e.g. Dynamic Island, Lock Screen Widgets, spatial audio), cross-platform frameworks often take months to provide stable wrappers. - Text selection handles, momentum scrolling curves, and VoiceOver accessibility can feel slightly *\"off\"* to discerning iOS users. 2. **The KMP Non-UI Sharing Strategy:** - $70-80\\%$ of mobile app code is **NOT UI**! It is networking (Ktor), offline databases (SQLDelight), data serialization (Kotlinx.serialization), business validation, and auth tokens. - KMP writes that logic **ONCE in Kotlin**. 3. **The Native UI Freedom:** - Android developers build the screen in **Jetpack Compose**. - iOS developers build the screen in **SwiftUI**. - Both screens consume the exact same shared Kotlin ViewModel and repository! - **Result:** $100\\%$ zero UI risk, maximum developer satisfaction, and native platform perfection!" },
        { "text": "Because Kotlin code cannot be compiled into machine instructions", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Flutter and React Native were banned by the European Union", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because KMP apps do not require an internet connection to download", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The cross-platform technology that shares Kotlin business logic while allowing pure native SwiftUI and Compose UI is Kotlin ___.",
      "blankAnswer": "Multiplatform",
      "blankDistractors": ["Native", "Android", "Coroutines"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Cross-Platform Studio: Flutter, RN & KMP",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Cross-Platform Mobile Studio</h3><p>Architecture: <b style=\"color:#38bdf8;\">Flutter Impeller, RN Fabric & KMP Logic</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnFlut\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Flutter 3-Tree Pipeline</button><button id=\"btnRn\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. React Native JSI Direct Call</button><button id=\"btnKmp\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. KMP Shared Business Engine</button></div><div id=\"cpLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to inspect Flutter rendering pipeline...</div><script>document.getElementById('btnFlut').onclick=()=>{document.getElementById('cpLog').innerHTML='<b>1. FLUTTER THREE-TREE PIPELINE:</b><br>• Widget Tree (Config) &rarr; Element (State & Context)<br>• RenderObject Tree &rarr; <b style=\"color:#38bdf8;\">Impeller GPU Canvas</b><br>• AOT precompiled shaders &rarr; <b style=\"color:#10b981;\">120 FPS buttery smooth!</b>';}; document.getElementById('btnRn').onclick=()=>{document.getElementById('cpLog').innerHTML='<b>2. REACT NATIVE NEW ARCHITECTURE:</b><br>• Hermes JS Engine &rarr; C++ JSI direct memory pointer<br>• Zero JSON Bridge stringification delay!<br>• Fabric C++ UI Manager &rarr; <b style=\"color:#10b981;\">Synchronous native view layout!</b>';}; document.getElementById('btnKmp').onclick=()=>{document.getElementById('cpLog').innerHTML='<b>3. KOTLIN MULTIPLATFORM (KMP):</b><br>• Shared Logic: Ktor HTTP + SQLDelight DB + Repository<br>• Native Android: 100% Jetpack Compose UI<br>• Native iOS: 100% SwiftUI UI<br>🏆 <b style=\"color:#10b981;\">All cross-platform mobile architectures verified!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
