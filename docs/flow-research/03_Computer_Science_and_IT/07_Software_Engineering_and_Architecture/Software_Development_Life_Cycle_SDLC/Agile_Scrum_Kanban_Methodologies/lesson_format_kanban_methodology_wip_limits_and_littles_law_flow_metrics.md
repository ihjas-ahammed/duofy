# Duofy Reusable Lesson Format: Kanban Methodology (WIP Limits and Little's Law Flow Metrics)

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Software_Development_Life_Cycle_SDLC / Agile_Scrum_Kanban_Methodologies`  
**Lesson Format Type:** `kanban_methodology_wip_limits_and_littles_law_flow_metrics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through Lean pull systems, bottleneck elimination, and queueing theory dynamics in the Kanban methodology (David J. Anderson 2010, *Kanban: Successful Evolutionary Change for Your Technology Business*; Taiichi Ohno Toyota Production System; John D. C. Little 1961): master the **6 Core Practices of Kanban** (1. Visualize workflow, **2. Limit Work in Progress [WIP]**, 3. Manage flow, 4. Make policies explicit, 5. Feedback loops, 6. Evolutionary improvement), mathematically derive and apply **Little's Law ($\mathbf{\text{Lead Time} = \frac{\text{WIP}}{\text{Throughput}}}$)** proving that slashing Work in Progress directly reduces delivery latency without sacrificing throughput, analyze the **Cumulative Flow Diagram (CFD)** (interpreting horizontal band distance as **Lead Time**, vertical band height as **WIP**, and curve slope as **Delivery Throughput**), and contrast **Cycle Time** (time from work start to completion) vs **Lead Time** (time from customer request to delivery).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Kanban Board Diagram with Explicit WIP Limits, Little's Law $\text{Lead Time} = \frac{\text{WIP}}{\text{Throughput}}$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Evolution of a Work Item Traversing a Kanban Pull System Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Kanban Flow Metric / Lean Construct & Mathematical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Fundamental Queueing Law Relating Lead Time to WIP and Throughput Is ___ Law (Little's / Little) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Proof: How Limiting WIP Slashing Lead Time Eliminates Context-Switching Waste Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Kanban & Little's Law (Anderson 2010; Little 1961):
   - **The Core Equation of Flow (Little's Law):**
     $$\mathbf{\text{Average Lead Time} = \frac{\text{Average Work in Progress (WIP)}}{\text{Average Throughput (Departure Rate)}}}$$
   - **Kanban Board with Explicit WIP Limits:**
     $$\begin{array}{|c|c|c|c|}
     \hline
     \textbf{Backlog} & \textbf{In Dev (WIP: 3)} & \textbf{Code Review (WIP: 2)} & \textbf{Done} \\
     \hline
     \text{Item A, B, C, D} & \text{[Card 1]} \ \text{[Card 2]} & \text{[Card 3]} & \text{[Card 0]} \\
     \hline
     \end{array}$$
   - **The Pull Principle:** A developer cannot start a new card if the column WIP limit is reached $\implies$ They must swarm to help unblock downstream columns!
2. **Slide 2 (`ordering`):** Provide 5 steps of a Kanban pull workflow: (1) customer submits work item into prioritized Backlog queue, (2) downstream developer pulls item into 'In Progress' column when WIP capacity becomes available, (3) developer completes coding and moves card to 'Review' column within strict WIP limits, (4) team reviews and tests item; if a column hits its WIP cap, developers stop starting new work and swarm to clear the bottleneck, (5) item is deployed to production and exits the system, recording Cycle Time and Lead Time!
3. **Slide 3 (`matching`):** Pair 4 concepts (WIP Limits, Little's Law, Cumulative Flow Diagram CFD, Cycle Time vs Lead Time) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Little's Law. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on how limiting WIP improves engineering performance: A software team currently has 30 concurrent user stories in progress across 5 developers, experiencing an average lead time of 60 days. According to Little's Law and Lean engineering principles, what happens when the team enforces strict WIP limits capping total in-progress work to 6 stories? (By Little's Law ($\text{Lead Time} = \frac{\text{WIP}}{\text{Throughput}}$), **reducing WIP by $80\%$ (from 30 to 6 items) directly reduces Average Lead Time from 60 days down to 12 days at constant throughput; furthermore, slashing WIP eliminates catastrophic multi-tasking and context-switching overhead**, allowing developers to focus on finishing single tasks before starting new ones, which typically boosts throughput and code quality even further).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "kanban_methodology_wip_limits_and_littles_law_flow_metrics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Kanban Lean Flow \\& Little's Law (Anderson 2010; Little 1961)**\n• **The Fundamental Equation of Flow (Queueing Theory):**\n$$\n\\mathbf{\\text{Average Lead Time} = \\frac{\\text{Average Work in Progress (WIP)}}{\\text{Average Throughput (Items / Day)}}}\n$$\n• **Kanban Pull System Architecture:**\n$$\n\\begin{array}{|c|c|c|c|}\n\\hline\n\\textbf{Input Queue} & \\mathbf{\\text{Development [WIP: 3]}} & \\mathbf{\\text{Code Review [WIP: 2]}} & \\textbf{Delivered} \\\\\n\\hline\n\\text{Feature #4} & \\text{[Card 1]} \\ \\text{[Card 2]} & \\text{[Card 3]} & \\text{Done Increment} \\\\\n\\text{Feature #5} & \\mathbf{\\text{(1 slot available!)}} & \\mathbf{\\text{(1 slot available!)}} & \\text{(Continuous)} \\\\\n\\hline\n\\end{array}\n$$\n• **The Swarming Invariant:** When a column reaches its WIP limit, developers **CANNOT pull new work; they must swarm to help clear the downstream bottleneck**!\n• **The CFD Invariant:** Vertical distance on a Cumulative Flow Diagram = **WIP**; Horizontal distance = **Lead Time**."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed when a work item flows through a Lean Kanban pull system.",
      "orderItems": [
        "A business request arrives into the prioritized Backlog buffer, marking the start of Lead Time tracking",
        "A developer pulls the top card into the 'Development' column only when current column WIP falls below its explicit limit",
        "Development concludes and the item is pulled into 'Code Review' without exceeding the review column's WIP ceiling",
        "If a downstream stage encounters a bottleneck and reaches its WIP cap, upstream engineers swarm to unblock the column",
        "The verified feature is deployed directly to production, marking the conclusion of Cycle Time and Lead Time measurement"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Kanban Flow Metric to its exact Technical Definition.",
      "matchPairs": [
        { "left": "Work in Progress (WIP) Limits", "right": "Explicit numerical caps on active items per workflow stage to prevent multitasking and hidden queues" },
        { "left": "Little's Law (Lead Time = WIP / Throughput)", "right": "Mathematical proof that reducing active work in progress directly shortens customer turnaround time" },
        { "left": "Cumulative Flow Diagram (CFD)", "right": "Area chart plotting cumulative items across workflow stages to visualize WIP bands and bottlenecks" },
        { "left": "Cycle Time vs Lead Time", "right": "Cycle Time measures active work duration; Lead Time measures total elapsed time from initial request" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The mathematical law stating that Lead Time equals Work in Progress divided by Throughput is ___ Law.",
      "blankAnswer": "Little",
      "blankDistractors": ["Moore", "Amdahl", "Brooks"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A software engineering team has 30 concurrent user stories in progress across 5 developers, resulting in an average Lead Time of 60 days. According to Little's Law and Lean engineering principles, what occurs when the team enforces strict WIP limits capping total concurrent work to 6 stories?",
      "options": [
        { "text": "According to Little's Law (Lead Time = WIP / Throughput), reducing WIP by 80% (from 30 to 6 items) directly collapses Average Lead Time from 60 days down to 12 days at constant throughput; furthermore, capping WIP eliminates the massive cognitive waste of multitasking and context-switching (where developers juggle 6 tasks simultaneously), allowing developers to focus on finishing work before starting new work, which in practice accelerates throughput and slashes defect rates even further", "isCorrect": true, "explanation": "Correct! This is David J. Anderson and Mary Poppendieck's core thesis on Lean Software Engineering (David J. Anderson 2010 *Kanban*; Poppendieck *Lean Software Development*). 1. **The Math of Little's Law:** - Baseline: $\\text{WIP} = 30\\text{ items}$, $\\text{Lead Time} = 60\\text{ days}$. - Throughput $\\lambda = \\frac{\\text{WIP}}{\\text{Lead Time}} = \\frac{30}{60} = \\mathbf{0.5\\text{ items/day}}$. - When WIP is capped at $6\\text{ items}$: - New $\\text{Lead Time} = \\frac{\\text{WIP}}{\\text{Throughput}} = \\frac{6}{0.5} = \\mathbf{12\\text{ days}}$! - Turnaround time for customers drops from **2 months to less than 2 weeks**! 2. **The Human Psychology of Context Switching (Gerald Weinberg's Rule):** - Juggling 1 task: $100\\%$ productive time. - Juggling 2 tasks: $40\\%$ lost to context switching ($20\\%$ per task). - Juggling 5 tasks: **$75\\%$ of developer time is wasted on context switching**! 3. **The Kanban Motto:** *\"Stop starting, start finishing!\"* When you limit WIP, you force collaboration and turn blocked work into shipped features." },
        { "text": "Because capping WIP forces developers to work 80 hours per week", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Little's Law only applies to physical manufacturing plants", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because limiting WIP automatically doubles the salary of the developers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
