# Duofy Reusable Lesson Format: Angular Architecture (Dependency Injection and RxJS Observables)

**Target Topic:** `03_Computer_Science_and_IT / 09_Web_Mobile_and_Cloud_Computing / Web_Technologies / Frontend_Frameworks_React_Vue_Angular`  
**Lesson Format Type:** `angular_dependency_injection_services_and_rxjs_observables`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through enterprise frontend architecture, hierarchical dependency injection, and asynchronous reactive streams in Angular (Miško Hevery Angular Architecture; Aristeidis Bampakos *Angular Projects*; RxJS ReactiveX Core Specification): master the **Hierarchical Dependency Injection (DI) Engine** (root application injector vs component-level scoped injectors, `@Injectable({ providedIn: 'root' })` tree-shakable singletons vs multi-instance component providers), master **RxJS Observables & Asynchronous Stream Pipelines** (push-based reactive streams, pipeable operators: `map`, `filter`, `switchMap` for automatic cancellation of stale HTTP requests, `debounceTime`, and `catchError`), master the **`async` Pipe** (declaratively subscribing and automatically unsubscribing to prevent memory leaks), and contrast Angular's full-featured platform approach with library-based frameworks.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Angular Hierarchical DI Tree Diagram & RxJS Observable Stream Pipeline Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Resolution and Lifecycle of an Injected Service Across an Angular Component Hierarchy Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Angular / RxJS Construct (`providedIn: 'root'`, `switchMap`, `async` pipe, `Subject`) Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Angular RxJS, the Pipeable Operator That Cancels Prior In-Flight HTTP Requests Upon New Input Is ___ (switchMap) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Enterprise Architecture Analysis: Why RxJS 'switchMap' Prevents Race Conditions in Search Typeahead Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Angular Architecture (Hevery 2016; Bampakos 2021):
   - **Hierarchical Injector Tree:**
     $$\mathbf{\text{Root Injector (Singleton } \texttt{providedIn: 'root'}\text{)}} \longrightarrow \mathbf{\text{Module Injector}} \longrightarrow \mathbf{\text{Element / Component Injector}}$$
     - *Resolution Rule:* If a component requests `MyService`, Angular checks its local injector first; if not found, bubbles up to parent components up to the Root Injector!
   - **RxJS Observable Stream Formulation:**
     $$\mathbf{\text{SearchInput\$}} \xrightarrow{\texttt{debounceTime(300)}} \xrightarrow{\texttt{distinctUntilChanged()}} \xrightarrow{\mathbf{\texttt{switchMap(query => http.get(url))}}} \mathbf{\text{Results\$}}$$
   - **`async` Pipe Invariant:** Subscribes automatically and calls `.unsubscribe()` upon component destruction (`ngOnDestroy`), eliminating memory leaks!
2. **Slide 2 (`ordering`):** Provide 5 steps of DI service resolution: (1) component constructor declares dependency `constructor(private authService: AuthService) {}`, (2) component instantiates; Angular's injector inspects component's `providers: []` metadata array, (3) finding no local provider, the injector traverses up the DOM hierarchy to parent component injectors, (4) injector reaches the Root Module Injector where `AuthService` is registered as a singleton, (5) injector returns the existing shared singleton instance of `AuthService` and injects it into component constructor!
3. **Slide 3 (`matching`):** Pair 4 concepts (`providedIn: 'root'`, `switchMap`, `async` Pipe, `BehaviorSubject`) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of `switchMap`. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on switchMap preventing typeahead race conditions: In an Angular real-time search typeahead, why is using RxJS `switchMap` mandatory rather than `mergeMap` or `concatMap` to prevent asynchronous race condition bugs? (When a user rapidly types search queries (e.g. typing "ang" then "angular"), multiple HTTP requests are dispatched in rapid succession; because network latency fluctuates, the older HTTP request for "ang" might respond *after* the newer request for "angular"; **`mergeMap` processes all responses concurrently, allowing the stale "ang" response to overwrite the newer "angular" results; `switchMap` automatically cancels and unsubscribes from any previous in-flight HTTP observable the moment a new search query is emitted, guaranteeing that only the response matching the user's latest keystroke updates the UI**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "angular_dependency_injection_services_and_rxjs_observables",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Angular Hierarchical DI \\& RxJS Reactive Streams (Miško Hevery)**\n• **Hierarchical Dependency Injection (DI) Tree:**\n$$\n\\mathbf{\\text{NullInjector}} \\longleftarrow \\mathbf{\\text{Root Injector (Singleton)}} \\longleftarrow \\mathbf{\\text{Module Injector}} \\longleftarrow \\mathbf{\\text{Component Injector}}\n$$\n• **Injector Resolution Invariant:** An element searches its local injector first; if missing, bubbles upward through parent nodes until reaching the Root Injector!\n• **RxJS Typeahead Stream Pipeline:**\n$$\n\\mathbf{\\text{Keystroke\\$}} \\xrightarrow{\\texttt{debounceTime(300ms)}} \\xrightarrow{\\texttt{distinctUntilChanged()}} \\xrightarrow{\\mathbf{\\texttt{switchMap(q => http.get(q))}}} \\mathbf{\\text{Results\\$}}\n$$\n• **The Async Pipe Invariant:** Subscribes automatically in template and calls $\\mathbf{\\texttt{unsubscribe()}}$ upon component destruction, guaranteeing **zero memory leaks**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed by Angular's Dependency Injection system to resolve a service declared in a component constructor.",
      "orderItems": [
        "Component constructor declares a required dependency: constructor(private auth: AuthService) {}",
        "Angular ComponentFactory inspects TypeScript reflection metadata to identify the AuthService token",
        "The ElementInjector checks the component's local providers array for a locally-scoped instance",
        "Failing to find a local provider, the injector walks up the parent component injector hierarchy to the Root Injector",
        "The Root Injector retrieves the existing singleton instance of AuthService and injects it into the component constructor"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Angular Architecture Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "providedIn: 'root'", "right": "Registers a service at application root, enabling tree-shakable singleton injection" },
        { "left": "switchMap Operator", "right": "Projects emissions to observables, automatically cancelling previous in-flight requests" },
        { "left": "async Pipe", "right": "Template pipe subscribing to an Observable and automatically unsubscribing on component destruction" },
        { "left": "BehaviorSubject", "right": "Specialized Subject storing the latest emitted value, immediately dispatching it to new subscribers" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Angular RxJS, the pipeable operator that cancels previous in-flight HTTP requests when a new value arrives is ___.",
      "blankAnswer": "switchMap",
      "blankDistractors": ["mergeMap", "concatMap", "forkJoin"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In an Angular real-time search typeahead component, why is using the RxJS 'switchMap' operator strictly required over 'mergeMap' to prevent catastrophic race condition bugs?",
      "options": [
        { "text": "When a user types rapidly (e.g. typing 'ca' followed by 'cat'), multiple HTTP requests are dispatched over the network in rapid succession; due to unpredictable network latency, the earlier slow response for 'ca' may arrive AFTER the fast response for 'cat'; mergeMap handles all responses concurrently and would allow the stale 'ca' response to overwrite the screen with outdated results; switchMap automatically cancels and unsubscribes from any previous in-flight HTTP request the instant a new keystroke is emitted, guaranteeing that only the response corresponding to the user's latest query updates the UI", "isCorrect": true, "explanation": "Correct! This is the canonical RxJS asynchronous race condition problem (Aristeidis Bampakos *Angular Projects*; Ben Lesh RxJS Core Architecture). 1. **The mergeMap Race Condition Disaster:** - User types: `\"ca\"` $\\to$ HTTP Request 1 dispatched ($300\\text{ ms}$ delay). - User types: `\"cat\"` $\\to$ HTTP Request 2 dispatched ($50\\text{ ms}$ delay). - Timeline of events: - $T=50\\text{ ms}$: Request 2 returns `[\"Cat\", \"Caterpillar\"]` $\\implies$ UI displays cat results! - $T=300\\text{ ms}$: Request 1 FINALLY returns `[\"Car\", \"California\"]` $\\implies$ **OVERWRITES THE SCREEN WITH STALE RESULTS!** - The search input says `\"cat\"`, but the results show `\"Car\"`! 2. **The switchMap Cancellation Miracle:** - User types `\"ca\"` $\\to$ Request 1 starts. - User types `\"cat\"` $\\to$ `switchMap` immediately calls `.unsubscribe()` and aborts the XMLHttpRequest for Request 1! - Request 1 is cancelled and discarded. - **Result:** Only Request 2 ever executes and displays! Flawless race-free reactive stream consistency!" },
        { "text": "Because mergeMap cannot be compiled by TypeScript", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because switchMap encrypts HTTP requests using SSL certificates", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Angular components are prohibited from making HTTP requests", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
