# Duofy Reusable Lesson Format: Multilevel Feedback Queues (MLFQ) and Priority Boost

**Target Topic:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / Process_Management_and_Concurrency / Process_States_and_CPU_Scheduling`  
**Lesson Format Type:** `multilevel_feedback_queues_mlfq_and_priority_boost`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the adaptive history feedback, dynamic priority demotion, gaming prevention, and starvation mitigation mechanics of the Multilevel Feedback Queue (MLFQ) scheduler (Fernando J. Corbató 1962, *An Experimental Time-Sharing System*, MIT CTSS; Abraham Silberschatz et al. *Operating System Concepts* Chapter 5.3.6; Remzi Arpaci-Dusseau OSTEP Chapter 8): master the **5 Core Rules of MLFQ** (**Rule 1: If Priority(A) > Priority(B), Run A**, **Rule 2: If Priority(A) == Priority(B), Run A & B in RR**, **Rule 3: New Jobs Enter at Top Queue (Queue 0)**, **Rule 4: Once a Job Uses Its Time Allotment at a Priority Level, Demote by 1**, and **Rule 5: Periodic Priority Boost [Reset all jobs to Queue 0 after interval $S$]**), evaluate how MLFQ optimizes turnaround time for interactive I/O jobs without prior knowledge of burst lengths, analyze **Gaming the Scheduler Protection** (cumulative time tracking per level), and explain why the Periodic Priority Boost solves both **CPU Starvation** and **Behavioral Phase Shifts**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | MLFQ Philosophy, The 5 Canonical Rules, & Periodic Boost Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Priority Demotion and Starvation Boost Trajectory Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | MLFQ Rule / Mechanism & Algorithmic Problem Solved Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Anti-Starvation Mechanism That Periodically Moves All Jobs to the Top Queue (Priority Boost) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | How Better Accounting (Rule 4) Prevents Malicious Processes from Gaming the Scheduler Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Multilevel Feedback Queues (Corbató 1962; OSTEP Chapter 8):
   - **The MLFQ Design Philosophy:**
     - Mimics Shortest Job First (SJF) **WITHOUT knowing future burst times**!
     - Uses historical execution behavior to dynamically adjust priorities.
   - **The 5 Master MLFQ Rules:**
     1. **Rule 1:** If $\text{Priority}(A) > \text{Priority}(B) \implies$ Run $A$.
     2. **Rule 2:** If $\text{Priority}(A) == \text{Priority}(B) \implies$ Run $A$ and $B$ in Round Robin using that queue's time slice.
     3. **Rule 3:** When a new job arrives, it is placed at the **topmost priority (Queue 0)**.
     4. **Rule 4 (Anti-Gaming Accounting):** Once a job uses up its time allotment at a given level (regardless of how many times it relinquishes the CPU for I/O), its priority is **reduced by 1 level** (demoted).
     5. **Rule 5 (Periodic Priority Boost):** After some time period $S$, move **ALL jobs in the system to the topmost queue**!
2. **Slide 2 (`ordering`):** Provide 5 steps of a CPU-bound job moving through a 3-level MLFQ (Q0: 10ms, Q1: 20ms, Q2: 40ms): (1) new job arrives and enters topmost priority queue Q0, (2) job runs on CPU for full 10ms time allotment of Q0 without blocking for I/O, (3) scheduler demotes job to intermediate queue Q1 with a 20ms time allotment, (4) job runs on CPU for full 20ms allotment of Q1 and is demoted to lowest queue Q2, (5) job executes in Q2 using 40ms Round Robin slices until the global period S expires, triggering a Priority Boost that elevates it back to Q0!
3. **Slide 3 (`matching`):** Pair 4 MLFQ mechanisms (Rule 3 Top Queue Entry, Rule 4 Cumulative Time Accounting, Rule 5 Priority Boost, Exponential Time Slices Q0<Q1<Q2) with the problems they solve.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that periodic priority boost prevents starvation. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on anti-gaming protection: In early naive MLFQ implementations, a malicious process could retain maximum priority forever by executing for $99\%$ of its time quantum and then issuing a dummy I/O operation to yield the CPU just before the quantum expired. How does modern MLFQ Rule 4 prevent this exploit? (By tracking **cumulative CPU execution time spent at a given priority level** across all dispatches; once the process accumulates a total CPU execution time equal to the time allotment of that level, it is **demoted to the lower queue regardless of how many times it yielded for I/O**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "multilevel_feedback_queues_mlfq_and_priority_boost",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Multilevel Feedback Queues (MLFQ) (Corbató 1962)**\n• **Core Goal:** Approximates SJF/SRTF **without knowing future burst times**!\n• **The 5 Canonical MLFQ Rules (OSTEP Chapter 8):**\n  - **Rule 1:** If $\\text{Priority}(A) > \\text{Priority}(B) \\implies$ Run $A$.\n  - **Rule 2:** If $\\text{Priority}(A) == \\text{Priority}(B) \\implies$ Run $A, B$ in Round Robin.\n  - **Rule 3:** When a job arrives, it enters the **topmost priority (Queue 0)**.\n  - **Rule 4 (Anti-Gaming):** Once a job uses its time allotment at a level (cumulative), demote it by 1 level.\n  - **Rule 5 (Priority Boost):** Every $S$ seconds, move **ALL jobs to Queue 0**!\n• **Twofold Benefit of Boost:** (1) Prevents **CPU Starvation** of long jobs; (2) Adapts when a CPU-bound job transitions to become interactive!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential priority transitions of a long CPU-intensive process through a 3-level MLFQ scheduler.",
      "orderItems": [
        "Process is admitted to the system as a brand new job and placed into highest priority Queue 0",
        "Process consumes its complete 10ms time slice in Queue 0 without performing I/O",
        "Scheduler demotes the process down to intermediate Queue 1 (time allotment = 20ms)",
        "Process consumes its complete 20ms allotment in Queue 1 and is demoted to background Queue 2",
        "Process executes in Queue 2 until global timer S fires, triggering a Priority Boost that elevates it back to Queue 0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each MLFQ Rule / Architectural component to the exact design problem it solves.",
      "matchPairs": [
        { "left": "Rule 3: Top-Queue Entry", "right": "Optimizes interactive response time by optimistically assuming any new job is a short interactive task" },
        { "left": "Rule 4: Cumulative Time Allotment", "right": "Prevents gaming the scheduler by tracking total CPU time at each level across multiple I/O yields" },
        { "left": "Rule 5: Periodic Priority Boost", "right": "Eliminates starvation of CPU-bound jobs and gracefully adapts to processes changing their behavior" },
        { "left": "Variable Slices (Q0:10ms, Q1:20ms, Q2:40ms)", "right": "Provides snappy response for interactive UI at top queues while minimizing context switches for long jobs" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The MLFQ mechanism that periodically elevates all processes back to the highest priority queue to prevent starvation is called a priority ___.",
      "blankAnswer": "boost",
      "blankDistractors": ["drop", "switch", "slice"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In early naive implementations of MLFQ, a malicious program could monopolize 99% of CPU time at top priority by running for 99% of its time quantum and yielding the CPU with a dummy I/O operation right before expiration. How does modern MLFQ Rule 4 eliminate this vulnerability?",
      "options": [
        { "text": "By maintaining cumulative accounting of all CPU time consumed by a process at a given priority level; once the process accumulates total CPU execution time equal to the time allotment of that level across any number of separate dispatches, it is demoted to the next lower priority queue, completely neutralizing intentional I/O yields", "isCorrect": true, "explanation": "Correct! This is one of the classic security and fairness optimizations in scheduler design (OSTEP Chapter 8). 1. In early MLFQ schedulers, Rule 4 was formulated naively: 'If a process yields the CPU before its quantum expires, keep it at the same priority level.' 2. A malicious process could exploit this: If the top queue has a 10ms quantum, the process runs a heavy calculation for 9.9ms, and then issues a dummy I/O call (e.g. reading from a pipe). Because it yielded before 10ms expired, the scheduler leaves it in the top queue! When the I/O completes a microsecond later, it runs again for 9.9ms. The process effectively steals 99% of all CPU capacity while starving all other tasks. 3. Modern MLFQ fixes this by replacing 'single-burst quantum' with 'cumulative time allotment': The scheduler tracks `time_used_at_level`. If a process runs for 2ms, yields for I/O, runs for 3ms, yields, and runs for 5ms, its cumulative time is $2 + 3 + 5 = 10\\text{ ms}$. Because it used up its full 10ms allotment, it is demoted to Queue 1 regardless of how many times it yielded! This completely shuts down the gaming exploit." },
        { "text": "By terminating any program that calls I/O functions", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "By encrypting the CPU time registers with RSA keys", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "By running all processes on separate isolated hardware servers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
