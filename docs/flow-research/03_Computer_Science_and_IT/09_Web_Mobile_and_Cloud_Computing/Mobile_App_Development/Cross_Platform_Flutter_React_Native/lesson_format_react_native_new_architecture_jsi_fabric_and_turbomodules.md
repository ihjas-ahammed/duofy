# Duofy Reusable Lesson Format: React Native Architecture (JSI, Fabric, and TurboModules)

**Target Topic:** `03_Computer_Science_and_IT / 09_Web_Mobile_and_Cloud_Computing / Mobile_App_Development / Cross_Platform_Flutter_React_Native`  
**Lesson Format Type:** `react_native_new_architecture_jsi_fabric_and_turbomodules`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the structural evolution, bridge elimination, and high-performance C++ integration across React Native's New Architecture (Meta React Native Architecture Team; Lorenzo Sciandra *React Native New Architecture Guide*): rigorously analyze why the **Legacy React Native Architecture (The Asynchronous JSON String Bridge)** caused severe animation stutter and layout jank on high-frequency gestures and fast scrolling lists (due to asynchronous serialization bottlenecks, thread hops between JS thread and Shadow/UI threads, and eager initialization of all native modules at startup), and master the **4 Pillars of The New Architecture**: **1. JSI (JavaScript Interface)** (a C++ abstraction allowing the JavaScript runtime to hold direct C++ memory references to native Java/Obj-C objects, enabling synchronous zero-copy method calls without JSON serialization), **2. Fabric (The New Concurrent UI Renderer)** (C++ layout manager with thread-safe immutable shadow nodes supporting React 18 Concurrent Features), **3. TurboModules** (lazy-loaded native modules initialized only when explicitly called), and **4. Hermes** (Meta's lightweight bytecode-precompiled JavaScript engine).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Legacy JSON Bridge vs New Architecture (JSI, Fabric, TurboModules) Comparison Matrix Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Synchronous Invocation of a Native C++ Module via JSI Without JSON Serialization Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | React Native Architecture Component / Engine & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The C++ Abstraction Layer That Allows JavaScript to Call Native Methods Directly via Shared Memory Is ___ (JSI) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Microarchitectural Analysis: Why the Legacy JSON Bridge Caused Severe Frame Drops on Fast List Scrolling Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State React Native New Architecture (Meta 2022):
   - **The Architectural Evolution Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Architectural Pillar} & \textbf{Legacy React Native (Pre-2022)} & \textbf{The New Architecture (2022+)} \\
     \hline
     \mathbf{\text{Communication Engine}} & \mathbf{\text{Asynchronous Serialized JSON String Bridge}} & \mathbf{\text{C++ JavaScript Interface (JSI) Direct Memory Pointers}} \\
     \mathbf{\text{Call Execution}} & \text{Async only (Batched, unpredictable latency)} & \mathbf{\text{Synchronous AND Asynchronous (Direct C++ invocation)}} \\
     \mathbf{\text{UI Rendering Manager}} & \text{Legacy UI Manager (Async Shadow Tree)} & \mathbf{\text{Fabric (Concurrent C++ thread-safe immutable tree)}} \\
     \mathbf{\text{Native Module Loading}} & \text{Eager loading at app boot (Slow startup)} & \mathbf{\text{TurboModules (Lazy-loaded on demand)}} \\
     \mathbf{\text{JavaScript Engine}} & \text{JavaScriptCore (JSC runtime parsing)} & \mathbf{\text{Hermes (AOT Precompiled Bytecode)}} \\
     \hline
     \end{array}$$
   - **The JSI Invariant:** JavaScript can hold direct C++ object pointers (`jsi::Object`, `jsi::HostObject`), completely **eliminating JSON stringification and deserialization**!
2. **Slide 2 (`ordering`):** Provide 5 steps of JSI execution: (1) JS code executes `NativeStorage.getSecureKey("auth_token")`, (2) JavaScript engine (Hermes) accesses C++ `HostObject` exposed via JSI, (3) JSI directly invokes native C++ function pointer in memory without serializing arguments to JSON string, (4) native C++ code invokes iOS Keychain / Android KeyStore synchronously on the same thread, (5) JSI converts return string into `jsi::String` and returns value instantly to JavaScript caller with zero IPC bridge delay!
3. **Slide 3 (`matching`):** Pair 4 concepts (JSI, Fabric Renderer, TurboModules, Hermes Engine) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of JSI. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why the legacy bridge caused scroll stutter: In legacy React Native, why did fast-scrolling lists (e.g. `FlatList` with 1,000 items) frequently show blank white spaces and suffer from severe frame drops? (On every scroll event, the native UI thread had to serialize scroll coordinates into a JSON string, send it across the asynchronous JSON Bridge to the JS thread, wake up the JS event loop to calculate which items to render, serialize the new virtual elements back into JSON, send it across the bridge to the Shadow thread for Yoga layout calculation, and finally send it to the UI thread; **on fast finger flings, this multi-hop asynchronous serialization queue backed up, causing the UI thread to outrun the JS thread and render blank white boxes before new list cells arrived; Fabric's C++ renderer computes layout synchronously on the UI thread via JSI, eliminating blank spaces completely**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "react_native_new_architecture_jsi_fabric_and_turbomodules",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: React Native New Architecture \\& Bridge Elimination (Meta)**\n• **Legacy vs New Architecture Comparison Matrix:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Core Component} & \\textbf{Legacy Architecture (The Bridge)} & \\textbf{The New Architecture (JSI \\& Fabric)} \\\\\n\\hline\n\\mathbf{\\text{JS-to-Native Protocol}} & \\mathbf{\\text{Asynchronous Serialized JSON Bridge}} & \\mathbf{\\text{JavaScript Interface (JSI) Direct C++ Memory Pointers}} \\\\\n\\mathbf{\\text{Execution Mode}} & \\text{Strictly asynchronous (High latency)} & \\mathbf{\\text{Synchronous \\& Asynchronous (Zero-copy direct calls)}} \\\\\n\\mathbf{\\text{UI Reconciler}} & \\text{Legacy UI Manager (Async Shadow Tree)} & \\mathbf{\\text{Fabric (Concurrent, thread-safe C++ UI renderer)}} \\\\\n\\mathbf{\\text{Module Bootstrapping}} & \\text{Eagerly initializes all modules at startup} & \\mathbf{\\text{TurboModules (Lazy-loaded on first explicit call)}} \\\\\n\\mathbf{\\text{JS Runtime}} & \\text{JSC (Parses source code text at runtime)} & \\mathbf{\\text{Hermes (AOT Bytecode engine with instant TTI)}} \\\\\n\\hline\n\\end{array}\n$$\n• **The JSI Invariant:**\n$$\n\\mathbf{\\text{JavaScript}} \\xrightleftharpoons[\\text{Zero JSON Serialization!}]{\\mathbf{\\texttt{jsi::HostObject}}} \\mathbf{\\text{Native C++ Layer}} \\longleftrightarrow \\mathbf{\\text{iOS (Obj-C/Swift) / Android (Java/Kotlin)}}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed when a React Native component invokes a native device API synchronously using JSI.",
      "orderItems": [
        "JavaScript code executes a call on a TurboModule: NativeBiometrics.authenticate()",
        "The Hermes JavaScript engine reads the JSI HostObject reference bound in JavaScript global memory",
        "JSI dispatches the method call directly to the registered C++ function pointer without serializing to JSON",
        "The C++ bridge invokes the underlying iOS FaceID / Android BiometricPrompt platform APIs",
        "The native result is packaged into a jsi::Value and returned synchronously to JavaScript with zero bridge queue latency"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each React Native New Architecture Component to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "JavaScript Interface (JSI)", "right": "C++ unified API enabling JavaScript to hold direct memory pointers to native objects" },
        { "left": "Fabric UI Renderer", "right": "Concurrent C++ rendering engine capable of executing synchronous UI layout updates on any thread" },
        { "left": "TurboModules", "right": "Lazy-loading infrastructure initializing native platform capabilities only when explicitly called" },
        { "left": "Hermes Engine", "right": "Lightweight JavaScript engine executing precompiled bytecode optimized for fast mobile startup (TTI)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The C++ abstraction layer that enables direct, zero-copy method calls between JavaScript and native code is ___.",
      "blankAnswer": "JSI",
      "blankDistractors": ["JSON", "DOM", "JSC"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In legacy React Native applications, why did fast-scrolling lists (like FlatList) frequently suffer from blank white spaces and stuttering, and how does Fabric solve this?",
      "options": [
        { "text": "In the legacy architecture, every scroll event was serialized to JSON, sent over an asynchronous bridge to the JS thread, evaluated to compute visible items, serialized back to JSON, sent to the Shadow thread for Yoga layout calculation, and finally queued onto the native UI thread; on fast scrolling flings, this asynchronous multi-thread serialization queue backed up, causing the native UI thread to outrun the JS thread and render blank white boxes before new cell layouts arrived; Fabric manages the UI tree directly in C++ via JSI, allowing layout and measurement to execute synchronously on the native UI thread without serialization bottlenecks, completely eliminating blank spaces", "isCorrect": true, "explanation": "Correct! This is Meta's primary motivation for designing Fabric and JSI (*React Native Architecture Guide*). 1. **The Multi-Thread JSON Bottleneck:** - Legacy RN used 3 isolated threads: **JS Thread**, **Shadow Thread (Yoga Layout)**, and **Native UI Thread**. - Everything had to travel across the Bridge via `JSON.stringify()` and `JSON.parse()`. - When a user aggressively flicked a list: - The Native UI Thread scrolled the screen at $60\\text{ FPS}$. - The JS Thread was stuck parsing huge JSON packets. - The UI thread ran out of rendered cells $\\implies$ **Showed blank white screen!** 2. **How Fabric Solves It (Synchronous C++ Layout):** - Fabric moves the Shadow Tree and layout calculations into shared C++ memory accessed via **JSI**. - When a scroll event occurs: The Native UI thread can invoke layout calculations **synchronously in C++** without waiting for the JS event loop! - Cells are measured and rendered instantly during the exact same frame! - Blank white boxes and scroll stutter are $100\\%$ eliminated!" },
        { "text": "Because the legacy bridge could only transmit 10 words per hour", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because FlatList is prohibited from holding more than 5 items", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because smartphones do not have enough memory to render text lists", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
