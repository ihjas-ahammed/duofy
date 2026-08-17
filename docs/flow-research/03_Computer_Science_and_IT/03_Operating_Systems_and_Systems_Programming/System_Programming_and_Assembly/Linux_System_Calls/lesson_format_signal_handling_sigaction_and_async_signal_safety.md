# Duofy Reusable Lesson Format: Signal Handling (sigaction and Async-Signal Safety)

**Target Topic:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / System_Programming_and_Assembly / Linux_System_Calls`  
**Lesson Format Type:** `signal_handling_sigaction_and_async_signal_safety`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify asynchronous software interrupts, reliable POSIX signal masks, reentrancy vulnerabilities, and event multiplexing across POSIX Signals and `sigaction` (Michael Kerrisk *The Linux Programming Interface* Chapters 20, 21, 22, & 63; Bryant & O'Hallaron CS:APP Chapter 8.5): configure reliable signal handlers with **`int sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)`** utilizing `sa_mask` (to atomically block signals during handler execution) and `sa_flags` (`SA_RESTART`, `SA_SIGINFO`), master the critical concept of **Async-Signal Safety and Reentrancy** (why calling non-reentrant functions like `printf()`, `malloc()`, or `free()` inside a signal handler causes **deadlocks and heap corruption** because they acquire internal locks or modify global pointer structures), write safe handlers using `volatile sig_atomic_t` flags and the `write()` system call, compare **`select` / `poll` ($O(N)$ linear scans)** against **`epoll` ($O(1)$ kernel event-ready list)**, and interact with live POSIX signal and reentrancy simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | POSIX sigaction Struct Layout, Async-Signal Safety Invariants, & Reentrancy Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Signal Concept / Syscall Flag & Exact Kernel Behavior Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Calling printf() or malloc() Inside a Signal Handler Causes Deadlock Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The C Type Qualifier Used with sig_atomic_t to Prevent Compiler Cache Optimization Across Interrupts (volatile) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive POSIX Signal Delivery & Async-Signal Safety Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "signal_handling_sigaction_and_async_signal_safety",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is sigaction(), what is Async-Signal Safety, and why is printf() strictly forbidden in signal handlers?",
      "blankAnswer": "POSIX Signal Handling & Async-Signal Safety (TLPI Chapters 20-22; CS:APP Chapter 8.5): (1) RELIABLE SIGNALS VIA sigaction(): struct sigaction { void (*sa_handler)(int); sigset_t sa_mask; int sa_flags; }; sa_mask defines signals blocked during handler execution. SA_RESTART automatically restarts interrupted system calls (like read/write). (2) ASYNC-SIGNAL SAFETY: A signal handler can interrupt execution at ANY arbitrary instruction (even inside an active function). A function is Async-Signal-Safe ONLY if it is completely reentrant or cannot be interrupted in an inconsistent state. (3) THE PRINTF/MALLOC DEADLOCK DISASTER: Functions like printf(), malloc(), and free() acquire internal locks and modify shared global state. If a signal arrives while main thread holds the malloc lock, and the signal handler ALSO calls malloc(), the handler deadlocks trying to acquire the lock held by the interrupted main thread! (4) SAFE HANDLER RULES: (a) Use only async-signal-safe syscalls (write(), _exit()). (b) Set a flag of type 'volatile sig_atomic_t flag = 1;' and handle logic in main loop!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each POSIX Signal / I/O Multiplexing concept to its exact architectural property.",
      "matchPairs": [
        { "left": "sigaction() System Call", "right": "Installs reliable signal handlers with custom blocking masks and execution flags" },
        { "left": "SA_RESTART Flag", "right": "Instructs the kernel to automatically resume slow system calls interrupted by a signal" },
        { "left": "volatile sig_atomic_t", "right": "Integer type guaranteed to be read/written in a single atomic instruction without compiler caching" },
        { "left": "epoll (vs select/poll)", "right": "Scalable O(1) kernel I/O multiplexer that notifies applications only of active, ready descriptors" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does calling non-reentrant standard library functions like printf() or malloc() inside an asynchronous signal handler frequently cause catastrophic deadlocks or heap corruption?",
      "options": [
        { "text": "A signal handler executes asynchronously and can interrupt the main program at any arbitrary instruction; functions like malloc() and printf() internally acquire mutex locks to protect global heap arenas and I/O buffers; if a signal interrupts the main thread while it is inside malloc() holding the internal heap lock, and the signal handler subsequently invokes malloc(), the handler attempts to acquire the same lock, deadlocking permanently with itself", "isCorrect": true, "explanation": "Correct! This is the fundamental definition and danger of Async-Signal Safety (TLPI Section 21.1; CS:APP Section 8.5.5). 1. Consider what `malloc()` does: - To be thread-safe, `malloc()` acquires an internal mutex lock before modifying free-list pointers. 2. Suppose the main program calls `malloc(1024)`. The main thread acquires the internal malloc mutex lock. 3. While the main thread is in the middle of unlinking a chunk from the free list, a `SIGINT` or `SIGALRM` signal arrives! 4. The CPU immediately suspends the main thread and jumps to the registered signal handler. 5. If the signal handler ALSO calls `malloc()` or `printf()`: - The handler tries to acquire the malloc mutex lock. - But the lock is ALREADY HELD by the interrupted main thread on the same CPU core! - The handler blocks waiting for the lock to be released. - BUT the main thread can NEVER run to release the lock because the signal handler is currently occupying the execution thread! 6. The process is permanently DEADLOCKED with itself! 7. This is why POSIX specifies an explicit whitelist of 'Async-Signal-Safe' functions (e.g. `write()`, `_exit()`, `sigprocmask()`). All standard I/O and dynamic allocation functions are strictly non-reentrant." },
        { "text": "Because printf() converts signals into ASCII strings that crash the compiler", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Linux signals disable the computer's graphics card", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because signal handlers run exclusively on 16-bit registers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The C keyword paired with sig_atomic_t to prevent the compiler from caching signal flags in CPU registers is ___.",
      "blankAnswer": "volatile",
      "blankDistractors": ["static", "const", "extern"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive POSIX Signal Delivery & Reentrancy Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>POSIX Signal & Reentrancy Engine</h3><p>Main Thread State: <span id=\"mainState\" style=\"color:#38bdf8; font-weight:bold;\">IDLE</span></p><div style=\"display:flex; gap:6px;\"><button id=\"lockBtn\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Main Thread calls malloc() (Holds Lock)</button><button id=\"badSig\" style=\"padding:6px 10px; background:#ef4444; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Send SIGINT (Unsafe Handler: printf/malloc)</button><button id=\"goodSig\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">3. Send SIGINT (Safe Handler: write)</button></div><div id=\"sigLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:320px; font-family:monospace; color:#fbbf24;\">Click step 1 then step 2 to observe deadlock...</div><script>let holding=false; document.getElementById('lockBtn').onclick=()=>{holding=true; document.getElementById('mainState').innerText='Inside malloc() [MUTEX LOCKED]'; document.getElementById('sigLog').innerText='Main thread acquired internal malloc lock. Modifying heap arena...';}; document.getElementById('badSig').onclick=()=>{if(holding){document.getElementById('sigLog').innerText='💥 DEADLOCK!\nSignal interrupted main thread.\nHandler called printf/malloc -> Tried to acquire malloc lock.\nLock already held by main thread -> Permanent deadlock!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');} else{document.getElementById('sigLog').innerText='Handler ran (lucky timing, lock was free).';}};</script><script>document.getElementById('goodSig').onclick=()=>{document.getElementById('sigLog').innerText='✅ SAFE EXECUTION:\nHandler used write() syscall & set volatile sig_atomic_t flag.\nZero mutex locks acquired -> Returned safely without deadlocks!';};</script></div>"
    }
  ]
}
```
