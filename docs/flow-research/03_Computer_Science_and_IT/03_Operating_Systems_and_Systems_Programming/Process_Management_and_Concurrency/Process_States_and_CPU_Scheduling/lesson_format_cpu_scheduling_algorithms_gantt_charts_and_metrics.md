# Duofy Reusable Lesson Format: CPU Scheduling Algorithms (Gantt Charts and Metrics)

**Target Topic:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / Process_Management_and_Concurrency / Process_States_and_CPU_Scheduling`  
**Lesson Format Type:** `cpu_scheduling_algorithms_gantt_charts_and_metrics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the timeline construction, mathematical performance metrics, and preemption trade-offs across classical CPU scheduling algorithms (Abraham Silberschatz et al. *Operating System Concepts* Chapter 5; Remzi Arpaci-Dusseau OSTEP Chapter 7): master the mathematical definitions of **Turnaround Time ($\mathbf{T_{\text{turnaround}} = T_{\text{completion}} - T_{\text{arrival}}}$)**, **Waiting Time ($\mathbf{T_{\text{waiting}} = T_{\text{turnaround}} - T_{\text{burst}}}$)**, and **Response Time**, construct 1D timeline **Gantt Charts** across the 4 foundational schedulers (**First-Come First-Served [FCFS]**, **Shortest Job First [SJF - Provably Minimal Average Waiting Time]**, **Shortest Remaining Time First [SRTF - Preemptive SJF]**, and **Round Robin [RR with Time Quantum $q$]**), evaluate the **FCFS Convoy Effect**, and analyze the time quantum sizing dilemma ($q \to \infty \implies$ FCFS; $q \to 0 \implies$ excessive context switch degradation).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Scheduling Metrics, Algorithm Taxonomy, & Quantum Dilemma Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Construction of a Round Robin (q = 2) Gantt Chart Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | CPU Scheduler & Performance Trade-off / Phenomenon Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Phenomenon in FCFS Where Short Jobs Get Trapped Behind a Huge Long Job (Convoy) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Computation of Average Waiting Time for a Given Gantt Schedule Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State CPU Scheduling & Gantt Metrics (Silberschatz Chapter 5; OSTEP 7):
   - **Core Mathematical Metrics:**
     $$\mathbf{T_{\text{turnaround}} = T_{\text{completion}} - T_{\text{arrival}} \qquad \qquad T_{\text{waiting}} = T_{\text{turnaround}} - T_{\text{burst}}}$$
   - **The 4 Fundamental Schedulers:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Algorithm} & \textbf{Preemptive?} & \textbf{Optimization Goal} & \textbf{Primary Weakness} \\
     \hline
     \mathbf{\text{FCFS}} & \text{No} & \text{Simplicity} & \mathbf{\text{Convoy Effect (Long CPU job blocks all I/O)}} \\
     \mathbf{\text{SJF}} & \text{No} & \mathbf{\text{Minimal Avg Waiting Time}} & \text{Requires future knowledge of burst times} \\
     \mathbf{\text{SRTF}} & \mathbf{\text{Yes}} & \mathbf{\text{Minimal Avg Waiting Time}} & \text{Starvation of long processes} \\
     \mathbf{\text{Round Robin}} & \mathbf{\text{Yes}} & \mathbf{\text{Fast Response Time}} & \text{Sensitive to Time Quantum } q \text{ selection} \\
     \hline
     \end{array}$$
   - **The Time Quantum Dilemma ($q$):**
     - If $q \to \infty \implies$ RR degrades into FCFS!
     - If $q \to 0 \implies$ Context switch overhead destroys CPU throughput!
2. **Slide 2 (`ordering`):** Provide 5 steps of Round Robin with q = 2 scheduling P1 (burst 5), P2 (burst 2), P3 (burst 3) all arriving at time 0: (1) allocate CPU to P1 from t=0 to t=2 (P1 remaining burst = 3); preempt P1 to tail of ready queue, (2) allocate CPU to P2 from t=2 to t=4 (P2 finishes completely; completion time = 4), (3) allocate CPU to P3 from t=4 to t=6 (P3 remaining burst = 1); preempt P3 to tail of queue, (4) allocate CPU to P1 from t=6 to t=8 (P1 remaining burst = 1); preempt P1 to tail, (5) allocate CPU to P3 from t=8 to t=9 (P3 finishes), then P1 runs from t=9 to t=10 (P1 finishes), completing the schedule!
3. **Slide 3 (`matching`):** Pair 4 scheduling algorithms (FCFS Convoy Effect, SJF Non-Preemptive Minimal, SRTF Preemptive Shortest, Round Robin Quantum) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the FCFS bottleneck is the convoy effect. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating average waiting time from a Gantt chart: Three processes $P_1$ (burst 24 ms), $P_2$ (burst 3 ms), and $P_3$ (burst 3 ms) arrive at time $t = 0$. Under Shortest Job First (SJF), what is the average waiting time across all three processes? (The SJF execution sequence is $P_2 \ (0 \to 3) \to P_3 \ (3 \to 6) \to P_1 \ (6 \to 30)$; Waiting times: $P_2 = 0\text{ ms}$, $P_3 = 3\text{ ms}$, $P_1 = 6\text{ ms}$; Average waiting time is $\frac{0 + 3 + 6}{3} = \frac{9}{3} = \mathbf{3\text{ milliseconds}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cpu_scheduling_algorithms_gantt_charts_and_metrics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: CPU Scheduling Algorithms & Metrics (Silberschatz 5)**\n• **Core Mathematical Metrics:**\n$$\n\\mathbf{T_{\\text{turnaround}} = T_{\\text{completion}} - T_{\\text{arrival}} \\qquad \\qquad T_{\\text{waiting}} = T_{\\text{turnaround}} - T_{\\text{burst}}}\n$$\n• **The 4 Fundamental Schedulers Master Taxonomy:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Scheduler} & \\textbf{Preemption Mode} & \\textbf{Key Trade-off / Phenomenon} \\\\\n\\hline\n\\mathbf{\\text{FCFS}} & \\text{Non-Preemptive} & \\mathbf{\\text{Convoy Effect (Short jobs trapped behind huge job)}} \\\\\n\\mathbf{\\text{SJF}} & \\text{Non-Preemptive} & \\mathbf{\\text{Mathematically Minimal Average Waiting Time}} \\\\\n\\mathbf{\\text{SRTF}} & \\mathbf{\\text{Preemptive}} & \\text{Preemptive SJF; minimal wait time, starvation risk} \\\\\n\\mathbf{\\text{Round Robin}} & \\mathbf{\\text{Preemptive}} & \\text{Fair response time; dictated by Time Quantum } q \\\\\n\\hline\n\\end{array}\n$$\n• **Quantum Dilemma ($q$):** $q \\to \\infty \\implies$ Degrades to FCFS; $q \\to 0 \\implies$ Context switch overhead ruins CPU throughput!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential Gantt Chart execution slices for Round Robin (quantum q = 2) on P1 (burst 5), P2 (burst 2), P3 (burst 3) all arriving at t=0.",
      "orderItems": [
        "P1 runs on CPU from t=0 to t=2 (remaining burst = 3); quantum expires and P1 is placed at queue tail",
        "P2 runs on CPU from t=2 to t=4 (remaining burst = 0); P2 completes execution at t=4",
        "P3 runs on CPU from t=4 to t=6 (remaining burst = 1); quantum expires and P3 is placed at queue tail",
        "P1 runs on CPU from t=6 to t=8 (remaining burst = 1); quantum expires and P1 is placed at queue tail",
        "P3 runs from t=8 to t=9 (P3 completes); P1 runs from t=9 to t=10 (P1 completes), finishing the schedule"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each CPU Scheduling concept to its exact systems definition.",
      "matchPairs": [
        { "left": "The Convoy Effect (FCFS)", "right": "Slowdown where multiple short, I/O-bound jobs wait behind a single massive CPU-bound process" },
        { "left": "Shortest Job First (SJF)", "right": "Provably optimal algorithm yielding minimal average waiting time by scheduling smallest burst first" },
        { "left": "Shortest Remaining Time First", "right": "Preemptive SJF that interrupts the running process whenever a newly arrived job has shorter burst" },
        { "left": "Round Robin Time Quantum (q)", "right": "Fixed time slice allocated per turn; large q behaves like FCFS while tiny q wastes CPU in context switches" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In First-Come First-Served scheduling, the severe performance bottleneck where short jobs get stuck behind a long job is the ___ effect.",
      "blankAnswer": "convoy",
      "blankDistractors": ["cascade", "starvation", "thrashing"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Three processes P1 (burst 24 ms), P2 (burst 3 ms), and P3 (burst 3 ms) all arrive at time t = 0. Under Shortest Job First (SJF) scheduling, what is the average waiting time across all three processes?",
      "options": [
        { "text": "3 milliseconds; SJF orders execution as P2 (0 to 3 ms), P3 (3 to 6 ms), and P1 (6 to 30 ms); Waiting time for P2 = 0 ms, P3 = 3 ms, P1 = 6 ms; Average Waiting Time = (0 + 3 + 6) / 3 = 9 / 3 = 3 ms", "isCorrect": true, "explanation": "Correct! This is a classic numerical problem illustrating the superiority of SJF over FCFS (Silberschatz Section 5.3.2). 1. All 3 processes arrive at $t = 0$: - $P_1$: Burst $= 24\\text{ ms}$. - $P_2$: Burst $= 3\\text{ ms}$. - $P_3$: Burst $= 3\\text{ ms}$. 2. **SJF Scheduling Order:** - SJF selects the shortest available job: $P_2$ (runs from $t=0$ to $t=3$). - Next shortest job: $P_3$ (runs from $t=3$ to $t=6$). - Final remaining job: $P_1$ (runs from $t=6$ to $t=30$). 3. **Calculate Waiting Times ($T_{\\text{wait}} = T_{\\text{start}} - T_{\\text{arrival}}$):** - Waiting time for $P_2 = 0 - 0 = 0\\text{ ms}$. - Waiting time for $P_3 = 3 - 0 = 3\\text{ ms}$. - Waiting time for $P_1 = 6 - 0 = 6\\text{ ms}$. 4. **Calculate Average Waiting Time:** - $\\text{Avg Waiting Time} = \\frac{0 + 3 + 6}{3} = \\frac{9}{3} = \\mathbf{3\\text{ ms}}$. (Compare this to FCFS: $P_1$ would run first, yielding waiting times of $P_1=0$, $P_2=24$, $P_3=27$, with an average waiting time of $\\frac{51}{3} = 17\\text{ ms}$! SJF reduces average wait time from $17\\text{ ms}$ to $3\\text{ ms}$)." },
        { "text": "17 milliseconds", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "10 milliseconds", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "0 milliseconds", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
