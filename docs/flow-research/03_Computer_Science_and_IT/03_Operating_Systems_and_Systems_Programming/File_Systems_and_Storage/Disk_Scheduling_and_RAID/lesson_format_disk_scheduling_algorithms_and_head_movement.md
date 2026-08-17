# Duofy Reusable Lesson Format: Disk Scheduling Algorithms and Head Movement

**Target Topic:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / File_Systems_and_Storage / Disk_Scheduling_and_RAID`  
**Lesson Format Type:** `disk_scheduling_algorithms_and_head_movement`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mechanical seek latency profiles, track request queues, and total head movement calculations of hard disk drive (HDD) scheduling algorithms (Peter J. Denning 1967, *Effects of Scheduling on Overload in Certain Computing Systems*; Abraham Silberschatz et al. *Operating System Concepts* Chapter 10; Remzi Arpaci-Dusseau OSTEP Chapter 37): evaluate the **3 Components of Disk I/O Latency ($T_{\text{seek}} + T_{\text{rot}} + T_{\text{trans}}$)**, formulate the **6 Canonical Disk Schedulers** (**FCFS**, **SSTF [Shortest Seek Time First - Starvation Risk]**, **SCAN [Elevator Algorithm]**, **C-SCAN [Circular SCAN - Uniform Waiting Time]**, **LOOK**, and **C-LOOK**), calculate **Total Head Movement ($\mathbf{\sum |\text{track}_{i+1} - \text{track}_i|}$)** across a 1D cylinder queue, and contrast the edge-reversal behavior of SCAN/C-SCAN against the request-bounded behavior of LOOK/C-LOOK.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Disk Latency Profile, 6 Scheduling Algorithms, & Head Movement Formulas Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step C-SCAN Track Servicing and Reset Trajectory Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Disk Scheduling Algorithm & Operational Trajectory Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Single-Word Name for the Schedulers That Turn Around at the Last Pending Request Rather than the Disk Edge (LOOK) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Reason C-SCAN Provides Greater Fairness and Uniform Wait Time Than SCAN Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Disk Scheduling & Head Movement (Denning 1967; Silberschatz Chapter 10; OSTEP 37):
   - **Total Disk Access Latency:**
     $$\mathbf{T_{\text{access}} = T_{\text{seek}} \ (\approx 3\text{--}10\text{ ms}) + T_{\text{rotational}} \ (\approx 2\text{--}4\text{ ms}) + T_{\text{transfer}} \ (< 0.1\text{ ms})}$$
     - Seek time (moving the physical actuator arm to the target cylinder) is the primary bottleneck!
   - **Total Head Movement Formula:**
     $$\mathbf{\text{Total Cylinders Traversed} = \sum_{i=1}^{n-1} |\text{Track}_{i+1} - \text{Track}_i|}$$
   - **The 6 Schedulers Comparison:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Scheduler} & \textbf{Selection Rule} & \textbf{Edge Behavior} & \textbf{Key Trade-off} \\
     \hline
     \mathbf{\text{FCFS}} & \text{First-Come First-Served} & \text{No directional order} & \text{High head movement} \\
     \mathbf{\text{SSTF}} & \text{Closest track next} & \text{Locally greedy} & \mathbf{\text{Starvation of distant tracks}} \\
     \mathbf{\text{SCAN (Elevator)}} & \text{Directional sweep} & \mathbf{\text{Travels to disk end (0 / Max)}} & \text{Long wait for newly passed tracks} \\
     \mathbf{\text{C-SCAN}} & \text{Unidirectional sweep} & \mathbf{\text{Jumps to 0 without servicing}} & \mathbf{\text{Uniform wait time across all tracks}} \\
     \mathbf{\text{LOOK}} & \text{Directional sweep} & \mathbf{\text{Reverses at last request}} & \text{Eliminates empty travel to 0/Max} \\
     \mathbf{\text{C-LOOK}} & \text{Unidirectional sweep} & \mathbf{\text{Resets at lowest request}} & \text{Uniform wait time + zero edge waste} \\
     \hline
     \end{array}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of C-SCAN servicing track queue [98, 183, 37, 122, 14, 124, 65, 67] starting at track 53 moving towards high tracks (max 199): (1) service tracks greater than 53 in ascending order (65, 67, 98, 122, 124, 183), (2) travel to the extreme upper disk boundary at track 199, (3) execute a direct return jump from track 199 to the extreme lower disk boundary at track 0 without servicing requests, (4) reverse direction to ascending order and service lowest track 14, (5) continue ascending to service final remaining track 37, completing the circular sweep!
3. **Slide 3 (`matching`):** Pair 4 disk schedulers (SSTF Greedy, SCAN Elevator, C-SCAN Circular, LOOK Request-Bounded) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that LOOK and C-LOOK reverse at the last pending request. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why C-SCAN provides more uniform waiting times than standard bidirectional SCAN: Why does C-SCAN (Circular SCAN) provide a significantly more uniform wait-time distribution across all disk cylinders compared to standard bidirectional SCAN? (Because in standard SCAN, when the arm reaches a disk boundary and immediately reverses, **the tracks near that boundary receive rapid double-servicing, while the tracks at the opposite end of the disk wait the maximum round-trip time**; C-SCAN **treats cylinders as a circular list by sweeping in only ONE direction and jumping back to start**, ensuring that all cylinders experience an identical, uniform average wait time).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "disk_scheduling_algorithms_and_head_movement",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Disk Scheduling & Latency Minimization (1967)**\n• **Total Disk Latency Formulation:**\n$$\n\\mathbf{T_{\\text{access}} = T_{\\text{seek}} \\ (\\approx 3\\text{--}9\\text{ ms}) + T_{\\text{rot}} \\ (\\approx 2\\text{--}4\\text{ ms}) + T_{\\text{trans}} \\qquad (T_{\\text{seek}} \\text{ dominates!})}\n$$\n• **Total Head Movement Metric:** $\\mathbf{\\text{THM} = \\sum_{i=1}^{n-1} |\\text{Track}_{i+1} - \\text{Track}_i|}$\n• **The 6 Schedulers Taxonomy (Silberschatz Chapter 10):**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Algorithm} & \\textbf{Movement Pattern} & \\textbf{Starvation / Fairness Risk} \\\\\n\\hline\n\\mathbf{\\text{FCFS}} & \\text{FIFO Arrival Queue} & \\text{Fair, but wild excessive arm swings} \\\\\n\\mathbf{\\text{SSTF}} & \\text{Closest Track Next} & \\mathbf{\\text{High throughput, but STARVATION risk!}} \\\\\n\\mathbf{\\text{SCAN (Elevator)}} & \\text{Sweeps to 0/Max} & \\text{Unfair: edges wait 2x longer than center} \\\\\n\\mathbf{\\text{C-SCAN}} & \\text{One-way sweep + Jump to 0} & \\mathbf{\\text{Uniform, fair waiting times across all tracks}} \\\\\n\\mathbf{\\text{LOOK / C-LOOK}} & \\text{Turns at last request} & \\text{Eliminates wasteful empty travel to 0/Max!} \\\\\n\\hline\n\\end{array}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential track traversal steps of C-SCAN on queue [98, 183, 37, 122, 14, 124, 65, 67] starting at track 53 moving rightward (disk 0-199).",
      "orderItems": [
        "Service pending requests with cylinder numbers greater than 53 in ascending order (65, 67, 98, 122, 124, 183)",
        "Travel to the physical maximum boundary at cylinder 199",
        "Perform a direct rapid reset sweep from cylinder 199 all the way back to cylinder 0 without servicing requests",
        "Begin ascending sweep from cylinder 0 to service the lowest pending request at cylinder 14",
        "Advance upward to service the final pending request at cylinder 37, completing the circular scheduling cycle"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Disk Scheduling algorithm to its exact head movement behavior.",
      "matchPairs": [
        { "left": "SSTF (Shortest Seek Time First)", "right": "Greedily selects request with minimal track distance from current head; risks starving far cylinders" },
        { "left": "SCAN (Elevator Algorithm)", "right": "Sweeps continuously toward one physical boundary (0 or Max) before reversing direction" },
        { "left": "C-SCAN (Circular SCAN)", "right": "Services requests in strictly one direction, immediately returning to track 0 to ensure uniform wait times" },
        { "left": "LOOK / C-LOOK Optimization", "right": "Reverses or resets at the outermost pending request, eliminating unnecessary travel to 0 or Max" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The disk scheduling optimization that stops at the last pending request instead of traveling all the way to the disk edge is called ___.",
      "blankAnswer": "LOOK",
      "blankDistractors": ["SCAN", "SSTF", "FCFS"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does C-SCAN (Circular SCAN) provide a significantly more uniform and fair wait-time distribution across all disk cylinders compared to standard bidirectional SCAN?",
      "options": [
        { "text": "In bidirectional SCAN, when the arm reaches an edge and immediately reverses, the tracks near that edge receive rapid double-servicing while the tracks at the far opposite end wait the full round-trip time; C-SCAN sweeps in only ONE direction and quickly jumps back to the start without servicing, ensuring that newly arrived requests across all tracks experience an identical, uniform average wait time", "isCorrect": true, "explanation": "Correct! This is the primary pedagogical rationale for Circular SCAN (Silberschatz Section 10.4). Consider standard bidirectional SCAN: 1. As the disk arm sweeps from track 0 to track 199, it services requests along the way. 2. When it hits track 199, it immediately reverses and sweeps back from 199 to 0. 3. Notice what happens to the tracks near track 199: they were just serviced moments ago on the upward pass, and are immediately serviced again on the downward pass (receiving very low wait times). 4. Meanwhile, the tracks near track 0 have the highest density of new requests that accumulated since the arm left track 0, and must wait for the arm to travel all the way back across the entire disk! This causes severe wait-time asymmetry (unfairness). 5. C-SCAN solves this by treating the cylinders as a circular list. It only services requests on the upward pass ($0 \\to 199$). When it hits the end, it immediately returns to track 0 without servicing requests. As a result, the head always moves through the tracks in the exact order of their accumulated queue age, ensuring that cylinders at both ends and in the middle all experience an identical, uniform average waiting time." },
        { "text": "Because C-SCAN increases the rotational speed of the hard drive spindle", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because C-SCAN eliminates all seek time completely", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because C-SCAN stores all disk data in RAM memory buffers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
