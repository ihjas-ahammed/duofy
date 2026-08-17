# Duofy Reusable Lesson Format: JavaScript Event Loop (Call Stack, Microtasks, and Macrotasks)

**Target Topic:** `03_Computer_Science_and_IT / 09_Web_Mobile_and_Cloud_Computing / Web_Technologies / HTML5_CSS3_JavaScript_ES6`  
**Lesson Format Type:** `javascript_event_loop_call_stack_microtasks_and_macrotasks`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the single-threaded asynchronous runtime concurrency model, V8 engine internals, and queue scheduling priorities in modern JavaScript (David Flanagan *JavaScript: The Definitive Guide* 7th ed. Chapter 13; Jake Archibald 2018 *In The Loop*; HTML Living Standard Event Loop Specification): master the four core components: **1. The Call Stack** (synchronous LIFO frame execution), **2. Web APIs / Node APIs** (offloading asynchronous timers, network fetches, and I/O to background OS threads), **3. The Microtask Queue** (`Promise.then()`, `queueMicrotask()`, `MutationObserver`, `process.nextTick()`), and **4. The Macrotask / Task Queue** (`setTimeout()`, `setInterval()`, `setImmediate()`, I/O, DOM events); master the **Event Loop Priority Invariant**:
$$\mathbf{\text{Call Stack Empties} \longrightarrow \mathbf{\text{DRAIN ALL Microtasks to Completion}} \longrightarrow \mathbf{\text{Render UI Frame}} \longrightarrow \mathbf{\text{Execute EXACTLY 1 Macrotask}}}$$
and accurately trace complex asynchronous console output sequences.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | JavaScript Event Loop Concurrency Model Diagram (Stack $\to$ Microtasks $\to$ Macrotasks) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Chronological Output Order of an Asynchronous JavaScript Code Snippet Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Event Loop Queue Construct / Async API & Exact Scheduling Priority Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the JavaScript Event Loop, Callbacks from Promise.then() Are Scheduled into the ___ Queue (Microtask) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Runtime Mechanics: Why an Infinite Microtask Loop Freezes the Browser While setTimeout Does Not Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State JS Event Loop (Flanagan 2020; Archibald 2018):
   - **The Asynchronous Queue Priority Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Queue Name} & \textbf{APIs / Operations} & \textbf{Drain Policy per Tick} & \textbf{Execution Priority} \\
     \hline
     \mathbf{\text{Call Stack}} & \text{Synchronous JS function frames} & \text{Runs until empty (LIFO)} & \mathbf{\text{Immediate (Highest)}} \\
     \mathbf{\text{Microtask Queue}} & \mathbf{\texttt{Promise.then, queueMicrotask, MutationObserver}} & \mathbf{\text{Drains 100\% TO COMPLETION!}} & \mathbf{\text{High (Before next macrotask)}} \\
     \mathbf{\text{Render Frame}} & \texttt{requestAnimationFrame, Layout, Paint} & \text{Periodic 60/120Hz sync} & \text{Between microtask & macrotask} \\
     \mathbf{\text{Macrotask Queue}} & \mathbf{\texttt{setTimeout, setInterval, I/O, DOM events}} & \mathbf{\text{Executes EXACTLY ONE task!}} & \mathbf{\text{Low (After all microtasks drain)}} \\
     \hline
     \end{array}$$
   - **The Event Loop Tick Invariant:** The event loop will **NEVER pick up a macrotask** if there is even a single pending microtask in the microtask queue!
2. **Slide 2 (`ordering`):** Provide 5 steps of executing: `console.log('1'); setTimeout(()=>console.log('2'), 0); Promise.resolve().then(()=>console.log('3')); console.log('4')`: (1) executes sync `console.log('1')` on Call Stack $\implies$ prints '1', (2) encounters `setTimeout(..., 0)`, registers timer in Web API and queues macrotask callback, (3) encounters `Promise.resolve().then(...)`, queues microtask callback into Microtask Queue, (4) executes sync `console.log('4')` on Call Stack $\implies$ prints '4', (5) Call Stack empties $\implies$ drains Microtask Queue first (prints '3') $\implies$ picks Macrotask (prints '2'), producing final sequence: 1 $\to$ 4 $\to$ 3 $\to$ 2!
3. **Slide 3 (`matching`):** Pair 4 concepts (Call Stack, Microtask Queue, Macrotask Queue, Web APIs) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Promise.then is queued into Microtask queue. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on infinite microtasks freezing the UI: Why does a recursive microtask loop (`function loop() { Promise.resolve().then(loop); } loop();`) completely freeze the browser tab and prevent UI rendering/clicking, whereas a recursive `setTimeout` loop (`function loop() { setTimeout(loop, 0); } loop();`) allows the UI to remain responsive? (The Event Loop specification mandates that **all pending microtasks must drain completely to zero before the browser can yield to the rendering engine or process user input events; a recursive microtask loop continuously generates new microtasks before the queue ever reaches zero, starving the browser of render opportunities and freezing the tab indefinitely; in contrast, `setTimeout` schedules into the macrotask queue, where the Event Loop executes only ONE macrotask per tick before yielding control to render frames and handle user clicks**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "javascript_event_loop_call_stack_microtasks_and_macrotasks",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The JavaScript Event Loop Concurrency Model (David Flanagan)**\n• **Queue Priority \\& Scheduling Mechanics:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Queue Component} & \\textbf{Asynchronous Sources} & \\textbf{Drain Behavior per Cycle} & \\textbf{Scheduling Priority} \\\\\n\\hline\n\\mathbf{\\text{Call Stack}} & \\text{Synchronous JS function frames} & \\text{Executes to completion (LIFO)} & \\mathbf{\\text{Priority 1 (Immediate)}} \\\\\n\\mathbf{\\text{Microtask Queue}} & \\mathbf{\\texttt{Promise.then, queueMicrotask}} & \\mathbf{\\text{Drains 100\\% TO COMPLETION!}} & \\mathbf{\\text{Priority 2 (High)}} \\\\\n\\mathbf{\\text{Animation Frame}} & \\texttt{requestAnimationFrame, Layout/Paint} & \\text{Executes prior to screen repaint} & \\text{Priority 3 (Per frame)} \\\\\n\\mathbf{\\text{Macrotask Queue}} & \\mathbf{\\texttt{setTimeout, setInterval, I/O}} & \\mathbf{\\text{Executes EXACTLY ONE macrotask}} & \\mathbf{\\text{Priority 4 (Low)}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Event Loop Orchestration Law:**\n$$\n\\mathbf{\\text{Sync Stack}} \\longrightarrow \\mathbf{\\text{Drain ALL Microtasks}} \\longrightarrow \\mathbf{\\text{Render Frame}} \\longrightarrow \\mathbf{\\text{Execute 1 Macrotask}}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential execution steps and console outputs for: console.log('1'); setTimeout(()=>console.log('2'), 0); Promise.resolve().then(()=>console.log('3')); console.log('4');",
      "orderItems": [
        "Synchronous console.log('1') executes immediately on Call Stack -> Output: 1",
        "setTimeout(..., 0) is passed to Web APIs, and its callback is pushed into the Macrotask Queue",
        "Promise.resolve().then(...) immediately pushes its callback into the high-priority Microtask Queue",
        "Synchronous console.log('4') executes on Call Stack -> Output: 4 (Call Stack is now completely empty)",
        "Event loop drains Microtask Queue (Output: 3), then picks next Macrotask from timer (Output: 2), yielding final sequence: 1, 4, 3, 2"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each JavaScript Runtime Component to its exact Scheduling Role.",
      "matchPairs": [
        { "left": "Call Stack", "right": "Synchronous single-threaded LIFO execution stack executing active function frames" },
        { "left": "Microtask Queue", "right": "High-priority queue containing Promise callbacks that must drain completely before next task" },
        { "left": "Macrotask Queue", "right": "Task queue containing setTimeout/setInterval callbacks processed one at a time per tick" },
        { "left": "Web APIs Environment", "right": "Browser background threads handling timers, network fetches, and DOM event listeners" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the JavaScript event loop, resolved Promise.then() callbacks are placed into the ___ queue.",
      "blankAnswer": "microtask",
      "blankDistractors": ["macrotask", "callstack", "thread"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does an infinite recursive microtask loop (function loop() { Promise.resolve().then(loop); } loop();) completely freeze the browser tab and prevent user clicks, whereas an infinite setTimeout loop does not?",
      "options": [
        { "text": "The HTML Event Loop specification strictly dictates that the Microtask Queue must be drained completely to zero before the browser is allowed to execute rendering frames, process UI clicks, or pick the next macrotask; a recursive microtask continually enqueues a new microtask before the current microtask queue empties, starving the event loop from ever yielding control to the browser renderer and freezing the UI thread indefinitely; in contrast, setTimeout schedules into the Macrotask Queue, where the Event Loop executes only ONE macrotask per tick before yielding control to render frames and handle user clicks", "isCorrect": true, "explanation": "Correct! This is Jake Archibald and David Flanagan's classic demonstration of event loop task prioritization (*In The Loop* 2018; *JavaScript: The Definitive Guide* Chapter 13). 1. **The Microtask Starvation Rule:** - The Event Loop algorithm: `while (microtaskQueue.isNotEmpty()) { execute(microtaskQueue.pop()); }` - If every microtask calls `queueMicrotask(loop)`: - The microtask queue NEVER empties! - The browser cannot reach the `render()` step. - The browser cannot process mouse clicks or keyboard input. - **Result:** The browser tab freezes completely and shows the *\"Page Unresponsive\"* dialog! 2. **The Macrotask Cooperative Multitasking Rule:** - The Event Loop algorithm for macrotasks: `execute(macrotaskQueue.popOne());` $\\to$ `drainMicrotasks();` $\\to$ `renderScreen();` - Even if you call `setTimeout(loop, 0)` indefinitely: - The browser runs **ONE timer callback**, then yields to check microtasks, then renders the screen at $60\\text{ FPS}$, then handles user clicks! - **Result:** The browser tab remains $100\\%$ smooth and interactive!" },
        { "text": "Because Promises require 100% of CPU memory to store data", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because setTimeout is executed on a dedicated GPU thread", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because modern browsers do not support Promises", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
