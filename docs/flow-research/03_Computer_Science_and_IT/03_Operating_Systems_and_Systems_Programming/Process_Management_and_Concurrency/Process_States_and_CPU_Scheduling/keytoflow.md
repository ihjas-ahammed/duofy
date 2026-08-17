# Key to Flow: Process States and CPU Scheduling (State Transitions, Gantt Metrics, MLFQ, & Linux CFS)

**Subject Area:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / Process_Management_and_Concurrency / Process_States_and_CPU_Scheduling`

---

## 📌 Core Concept & Mental Model
**Finite State Process Lifecycles, Hardware PCB Context Registers, Preemptive/Non-Preemptive Gantt Scheduling Metrics, Adaptive MLFQ History Feedback, and Red-Black Tree Virtual Runtime ($vruntime$) Fair Queuing** govern OS process dispatching and CPU multiplexing (Fernando J. Corbató 1962 CTSS MLFQ; Ingo Molnar 2007 Linux CFS; Silberschatz et al. Chapters 3 & 5; Remzi Arpaci-Dusseau OSTEP Chapters 4–8):
* **1. The 5-State / 7-State Process Lifecycle:**
  $$\mathbf{\text{New} \longrightarrow \text{Ready} \underset{\text{Preempt / Yield}}{\overset{\text{Dispatch}}{\rightleftharpoons}} \text{Running} \overset{\text{I/O Wait}}{\longrightarrow} \text{Waiting (Blocked)} \overset{\text{I/O Done}}{\longrightarrow} \text{Ready} \longrightarrow \text{Terminated}}$$
  - **Process Control Block (PCB):** Stores PID, program counter (PC), CPU registers, memory limits (CR3/page tables), and open file descriptor table.
  - **Context Switch:** Hardware state save of outgoing PCB + restore of incoming PCB (direct cache and TLB penalty).
* **2. Classical CPU Scheduling Algorithms & Gantt Metrics:**
  - **Core Performance Metrics:**
    $$\mathbf{\text{Turnaround Time} = T_{\text{completion}} - T_{\text{arrival}} \qquad \text{Waiting Time} = \text{Turnaround Time} - \text{Burst Time}}$$
  - **Algorithms Master Table:**
    $$\begin{array}{|l|l|l|l|l|}
    \hline
    \textbf{Algorithm} & \textbf{Type} & \textbf{Metric Minimized} & \textbf{Weakness / Risk} & \textbf{Key Feature} \\
    \hline
    \mathbf{\text{FCFS}} & \text{Non-preemptive} & \text{Implementation cost} & \mathbf{\text{Convoy Effect}} & \text{FIFO Queue} \\
    \mathbf{\text{SJF}} & \text{Non-preemptive} & \mathbf{\text{Minimal Avg Wait Time}} & \text{Requires future oracle} & \tau_{n+1} = \alpha t_n + (1-\alpha)\tau_n \\
    \mathbf{\text{SRTF}} & \text{Preemptive} & \mathbf{\text{Minimal Avg Wait Time}} & \text{Starvation of long jobs} & \text{Preemptive SJF} \\
    \mathbf{\text{Round Robin}} & \text{Preemptive} & \text{Response Time} & \text{High Context Switches if } q \to 0 & \text{Time Quantum } q \\
    \mathbf{\text{Priority}} & \text{Pre/Non-pre} & \text{External importance} & \mathbf{\text{Starvation}} & \text{Mitigated by Aging} \\
    \hline
    \end{array}$$
* **3. Multilevel Feedback Queue (MLFQ - Corbató 1962):**
  - Learns job behavior without prior knowledge of burst times!
  - **The 5 Canonical MLFQ Rules:**
    1. If $\text{Priority}(A) > \text{Priority}(B) \implies$ Run $A$.
    2. If $\text{Priority}(A) == \text{Priority}(B) \implies$ Run $A$ and $B$ in Round Robin using Queue's time slice.
    3. New jobs enter at top priority (Queue 0).
    4. Once a job uses up its time allotment at a given priority level, its priority is **reduced by 1 level** (demoted).
    5. **Periodic Priority Boost:** After some time period $S$, move **ALL jobs to the topmost queue** (prevents Starvation and adapts to changing job behavior!).
* **4. Linux Completely Fair Scheduler (CFS - Ingo Molnar 2007):**
  - Replaces discrete multi-level queues with a self-balancing **Red-Black Tree** indexed by **$vruntime$ (Virtual Runtime)**.
  - $vruntime$ measures physical CPU execution time normalized by thread `nice` priority weight:
    $$\mathbf{vruntime \mathrel{+}= \Delta \text{exec\_time} \times \frac{\text{Weight}_{\text{NICE\_0}}}{\text{Weight}_i}}$$
  - **Scheduler Action:** Always picks the leftmost node in the Red-Black Tree (task with smallest $vruntime$) in **$O(\log N)$ or $O(1)$ cached time**!

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Gantt Chart Trace Method
* Always draw a horizontal timeline ($0 \to T$). Plot arrivals, bursts, and context switches explicitly to compute $\sum \text{WaitTime} / N$.

### 2. Top Recommended Resources
* **The OS Standard:** *Operating System Concepts* (Silberschatz), Chapters 3 & 5.
* **Scheduling Masterclass:** *Operating Systems: Three Easy Pieces* (OSTEP), Chapters 4–8.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you trace all 5 states and transitions in the process lifecycle?
- [ ] Can you draw Gantt charts and compute average turnaround and waiting times for FCFS, SJF, SRTF, and Round Robin?
- [ ] Can you state the 5 rules of MLFQ and explain why the Periodic Priority Boost is required?
- [ ] Can you explain how $vruntime$ and the Red-Black Tree achieve proportional fairness in Linux CFS?
