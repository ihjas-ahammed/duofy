# Duofy Reusable Lesson Format: Linux Completely Fair Scheduler (CFS) and Virtual Runtime (vruntime)

**Target Topic:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / Process_Management_and_Concurrency / Process_States_and_CPU_Scheduling`  
**Lesson Format Type:** `linux_completely_fair_scheduler_cfs_and_vruntime`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify weighted proportional-share scheduling, self-balancing Red-Black Tree queues, and virtual runtime ($vruntime$) accounting across the Linux Completely Fair Scheduler (CFS) (Ingo Molnar 2007 Linux 2.6.23; Robert Love *Linux Kernel Development* Chapter 4; Remzi Arpaci-Dusseau OSTEP Chapter 9): formulate the **Virtual Runtime Formula ($\mathbf{vruntime \mathrel{+}= \Delta \text{exec\_time} \times \frac{\text{Weight}_{\text{NICE\_0}}}{\text{Weight}_i}}$)**, understand how Unix `nice` values ($-20 \dots +19$) map to geometric $\approx 1.25\times$ priority weights, evaluate the **Red-Black Tree Runqueue Structure** (storing runnable threads sorted by $vruntime$), prove why selecting the next task is the leftmost node in $O(\log N)$ or cached $O(1)$ time, analyze **Latency Target ($\text{sched\_latency}$)** and **Minimum Granularity ($\text{min\_granularity}$)** to prevent thrashing, and interact with live Linux CFS Red-Black Tree scheduling simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Virtual Runtime Accounting, Nice Weighting, & Red-Black Tree Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Linux CFS Scheduler Component & Architectural Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why High-Priority Tasks Have Smaller vruntime Increments Under CFS Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Core Metric Used by the Linux CFS Scheduler to Track a Thread's CPU Share (vruntime) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Linux Completely Fair Scheduler (CFS) Red-Black Tree Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "linux_completely_fair_scheduler_cfs_and_vruntime",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How does the Linux Completely Fair Scheduler (CFS) use virtual runtime (vruntime) and a Red-Black Tree to schedule processes?",
      "blankAnswer": "Linux CFS & Virtual Runtime (Ingo Molnar 2007; Linux Kernel Dev Ch 4; OSTEP Ch 9): (1) THE VRUNTIME SCORECARD: vruntime (Virtual Runtime) measures the amount of CPU time a thread has received, scaled by its priority: vruntime += Delta_exec_time * (Weight_NICE_0 / Weight_i)! (High-priority processes have large weights -> Their vruntime grows very slowly -> They get to run much more frequently)! (2) RED-BLACK TREE RUNQUEUE: All runnable tasks are stored in a self-balancing Red-Black Tree sorted strictly by vruntime. (3) SCHEDULER SELECTION: CFS always picks the LEFTMOST NODE in the tree (the task with the smallest vruntime that has received the least CPU time). Complexity: O(log N) insert/delete, O(1) cached leftmost lookup! (4) LATENCY TARGET: CFS divides a target time window (sched_latency, e.g. 6ms) proportionally among all running threads based on their weights, enforcing a minimum granularity (min_granularity, e.g. 0.75ms) to prevent excessive context switching!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Linux Completely Fair Scheduler (CFS) concept to its exact functional role.",
      "matchPairs": [
        { "left": "vruntime (Virtual Runtime)", "right": "Per-task monotonic counter tracking normalized CPU consumption scaled by nice priority weight" },
        { "left": "Red-Black Tree Runqueue", "right": "Self-balancing binary search tree storing runnable tasks ordered by ascending vruntime values" },
        { "left": "Leftmost Node Pointer (rb_leftmost)", "right": "Cached pointer providing instant O(1) access to the task that has received the least CPU time" },
        { "left": "sched_min_granularity", "right": "Minimum time floor allocated to a running process to prevent context switch thrashing" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In the Linux Completely Fair Scheduler (CFS), why does a high-priority process (with a low nice value like -5) receive significantly more CPU time than a low-priority process (with a high nice value like +10)?",
      "options": [
        { "text": "Because CFS scales the increase in vruntime inversely by the process's priority weight (vruntime += Delta_time * (Weight_0 / Weight_p)); high-priority tasks have large weight multipliers, so their vruntime accumulates much more slowly than low-priority tasks; because CFS always chooses the process with the smallest vruntime (the leftmost node in the Red-Black tree), the high-priority task repeatedly remains on the left and is chosen more frequently", "isCorrect": true, "explanation": "Correct! This is the core mathematical elegance of Ingo Molnar's Completely Fair Scheduler (Robert Love *Linux Kernel Development* Chapter 4; OSTEP Chapter 9). 1. CFS model: Imagine an ideal multi-tasking CPU where $N$ processes run simultaneously, each receiving $\\frac{1}{N}$-th of the CPU. 2. On real hardware, the CPU can only run one process at a time. To simulate ideal fairness, CFS tracks `vruntime` (virtual runtime). 3. When process $i$ runs for physical time $\\Delta t$, its `vruntime` increases by: $\\Delta \\text{vruntime} = \\Delta t \\times \\frac{\\text{Weight}_{\\text{NICE\\_0}}}{\\text{Weight}_i}$. 4. High-priority processes (nice $< 0$) have large weights (e.g. `nice -5` has weight 3121 vs baseline 1024 for `nice 0`). When it runs for 10ms, its `vruntime` increases by only $10 \\times \\frac{1024}{3121} = 3.28\\text{ ms}$! 5. Low-priority processes (nice $> 0$) have small weights (e.g. `nice 10` has weight 110). When it runs for 10ms, its `vruntime` surges by $10 \\times \\frac{1024}{110} = 93.09\\text{ ms}$! 6. Because CFS always schedules the process with the lowest `vruntime` (leftmost in the Red-Black Tree), the high-priority process stays near the left edge and receives proportional CPU time automatically." },
        { "text": "Because high-priority processes disable the hardware timer interrupt", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because CFS executes high-priority processes on separate secret CPU cores", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because low-priority processes are deleted from the Red-Black tree after 10ms", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Linux CFS scheduler, the monotonic counter tracking a thread's weighted execution time is called ___.",
      "blankAnswer": "vruntime",
      "blankDistractors": ["utime", "stime", "cputime"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Linux CFS Red-Black Tree Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Linux CFS (Completely Fair Scheduler)</h3><p>RB-Tree: <span id=\"rbTree\" style=\"color:#38bdf8; font-family:monospace;\">[P1 (vrt: 10ms), P2 (vrt: 14ms), P3 (vrt: 22ms)]</span></p><button id=\"tickBtn\" style=\"padding:6px 14px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">Run Leftmost Task (P1) for 4ms</button><div id=\"cfsLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:320px; font-family:monospace; color:#fbbf24;\">Scheduler ready. P1 is leftmost (vruntime = 10ms)...</div><script>let v1=10, v2=14, v3=22; document.getElementById('tickBtn').onclick=()=>{v1+=6; document.getElementById('rbTree').innerText='[P2 (vrt: 14ms), P1 (vrt: 16ms), P3 (vrt: 22ms)]'; document.getElementById('cfsLog').innerText='CFS EXECUTION TRACE:\n1. Picked leftmost: P1 (vrt: 10ms).\n2. P1 ran for 4ms (nice 0 -> vrt += 6ms = 16ms).\n3. Re-inserted P1 into RB-Tree at new position.\n4. NEW LEFTMOST: P2 (vrt: 14ms) scheduled next!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
