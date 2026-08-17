# Duofy Reusable Lesson Format: Line Balancing (Cycle Time, Workstations, & Efficiency)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Manufacturing_and_Industrial_Engineering / Production_Planning_and_Inventory_Control`  
**Lesson Format Type:** `assembly_line_balancing_cycle_time_and_workstation_efficiency`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through manufacturing assembly line design, precedence diagram networks, workstation task allocation, line cycle time determination, and balance efficiency optimization (Mikell P. Groover *Automation, Production Systems, and Computer-Integrated Manufacturing* Chapter 15; William J. Stevenson *Operations Management* Chapter 6): master the **Line Cycle Time Formulation ($\mathbf{C}$)** (maximum time allowable at each workstation to meet output demand):
$$\mathbf{C = \frac{\text{Available Operating Production Time } T_a}{\text{Target Production Demand Rate } D} \ [\text{seconds/unit}]}$$
derive the **Theoretical Minimum Number of Workstations ($\mathbf{N_{\text{min}}}$)**:
$$\mathbf{N_{\text{min}} = \left\lceil \frac{\sum t_i}{C} \right\rceil}$$
where $\sum t_i$ is total work content time across all elemental tasks; evaluate **Assembly Line Balance Efficiency ($\mathbf{\eta}$)** and **Balance Delay / Idle Time ($\mathbf{BD}$)**:
$$\mathbf{\text{Line Efficiency } \eta = \frac{\sum t_i}{N_{\text{actual}} \cdot C} \times 100\% \quad \Big| \quad \text{Balance Delay } BD = 100\% - \eta = \frac{N_{\text{actual}} \cdot C - \sum t_i}{N_{\text{actual}} \cdot C} \times 100\%}$$
and apply heuristic assignment rules (Largest Candidate Rule, Kilbridge & Wester, Ranked Positional Weight RPW) to pack tasks into stations without violating precedence constraints.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Line Cycle Time ($C = \frac{T_a}{D}$), Minimum Stations ($N_{\text{min}} = \lceil \frac{\sum t_i}{C} \rceil$) & Balance Efficiency Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Balance an Assembly Line Network Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Line Balancing Metric / Heuristic Rule & Technical Operational Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Maximum Time Allowed at Each Workstation on an Assembly Line to Meet Required Output Demand Is the ___ Time (Cycle / Takt) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Industrial Engineering Problem: Calculating Minimum Stations and Line Efficiency for an Automotive Subassembly Line Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Line Balancing (Groover 2019; Stevenson 2021):
   - **Line Balancing Formulations:**
     $$\mathbf{C = \frac{T_{\text{avail}}}{D} \quad \Big| \quad N_{\text{min}} = \left\lceil \frac{\sum t_i}{C} \right\rceil \quad \Big| \quad \mathbf{\eta = \frac{\sum t_i}{N_{\text{actual}} \cdot C} \times 100\%} \quad \Big| \quad BD = 100\% - \eta}$$
   - **Line Balancing Constraints Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Constraint Type} & \textbf{Mathematical Formulation} & \textbf{Physical Meaning} \\
     \hline
     \mathbf{\text{Cycle Time Limit}} & \mathbf{\sum_{j \in \text{Station } k} t_j \le C} & \text{Station work time cannot exceed cycle time} \\
     \mathbf{\text{Precedence Network}} & \text{Task } A \to \text{Task } B & \text{Preceding tasks must be completed first} \\
     \mathbf{\text{Theoretical Minimum}} & N_{\text{min}} = \lceil \sum t_i / C \rceil & \text{Absolute lowest possible station count} \\
     \hline
     \end{array}$$
   - **The Bottleneck Invariant:** The actual line output rate is governed by the **station with the largest total processing time ($T_{\text{max}} = \text{Bottleneck Station}$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of line balancing: (1) draw the precedence diagram connecting all elemental tasks, (2) determine available production operating time $T_a$ and required output demand $D$ to compute cycle time $C = T_a / D$, (3) calculate theoretical minimum number of workstations $N_{\text{min}} = \lceil \sum t_i / C \rceil$, (4) assign tasks to workstations sequentially using Ranked Positional Weight (RPW) or Largest Candidate Rule without exceeding $C$, (5) calculate line efficiency $\eta = \frac{\sum t_i}{N \cdot C} \times 100\%$ and balance delay $BD = 100\% - \eta$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Cycle Time $C$, Line Balance Efficiency $\eta$, Balance Delay $BD$, Ranked Positional Weight RPW) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Cycle (or Takt). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating line efficiency: An assembly line operates for $T_a = 8.0\text{ hours/day} = 28,800\text{ seconds}$ to produce $D = 480\text{ units/day}$. The total work content is $\sum t_i = 210\text{ seconds}$. After balancing, the line is successfully configured with $N = 4\text{ workstations}$. What is the cycle time $C$, the theoretical minimum number of stations $N_{\text{min}}$, and the line balance efficiency $\eta$? ($C = \frac{T_a}{D} = \frac{28,800\text{ s}}{480} = \mathbf{60.0\text{ seconds}}$; $N_{\text{min}} = \lceil \frac{210}{60} \rceil = \lceil 3.5 \rceil = \mathbf{4\text{ stations}}$; Line Efficiency $\eta = \frac{\sum t_i}{N \cdot C} = \frac{210\text{ s}}{4 \times 60\text{ s}} = \frac{210}{240} = \mathbf{0.875 = 87.5\%}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "assembly_line_balancing_cycle_time_and_workstation_efficiency",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Assembly Line Balancing \\& Production Synchronization (Mikell P. Groover)**\n• **Cycle Time Formulation (Takt Time):**\n$$\n\\mathbf{C = \\frac{T_{\\text{operating}}}{D_{\\text{demand}}} \\ [\\text{seconds/unit}]}\n$$\n• **Theoretical Minimum Workstation Count:**\n$$\n\\mathbf{N_{\\text{min}} = \\left\\lceil \\frac{\\sum t_i}{C} \\right\\rceil \\quad (\\sum t_i = \\text{Total Work Content Time})}\n$$\n• **Assembly Line Efficiency \\& Balance Delay Formulation:**\n$$\n\\mathbf{\\text{Line Efficiency } \\eta = \\frac{\\sum t_i}{N_{\\text{actual}} \\cdot C} \\times 100\\% \\quad \\Big| \\quad \\text{Balance Delay } BD = 100\\% - \\eta}\n$$\n• **The Bottleneck Invariant:** The maximum line output capacity is strictly governed by the **station with the longest task duration ($T_{\\text{station}} = \\max(\\sum t_j)$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to balance an industrial assembly line using precedence constraints and task times.",
      "orderItems": [
        "Construct the task precedence diagram displaying prerequisite relationships across all elemental operations",
        "Compute the required line cycle time: C = Available Operating Time / Target Production Output Demand",
        "Calculate the theoretical minimum number of workstations: N_min = ceil(sum(task_times) / C)",
        "Assign tasks to workstations sequentially using Ranked Positional Weight heuristic without violating precedence or exceeding C",
        "Compute the resulting assembly line efficiency eta = sum(task_times) / (N_actual * C) and balance delay"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Line Balancing Term to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Line Cycle Time (C)", "right": "C = T_avail / D, the maximum allowable time interval between successive finished product completions" },
        { "left": "Balance Efficiency (\u03b7)", "right": "\u03b7 = sum(ti) / (N * C), percentage of total workstation time spent performing productive assembly tasks" },
        { "left": "Balance Delay (BD)", "right": "BD = 100% - \u03b7, percentage of unutilized idle time across the assembly line due to task assignment imbalances" },
        { "left": "Ranked Positional Weight", "right": "Heuristic prioritizing tasks based on the sum of their own duration plus all downstream follower task times" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The maximum time allowed at each workstation on an assembly line to meet output demand is the ___ time.",
      "blankAnswer": "cycle",
      "blankDistractors": ["lead", "setup", "slack"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An assembly line operates for Ta = 8.0 hours/day (28,800 s) to satisfy demand D = 480 units/day. Total work content is sum(ti) = 210 seconds. After balancing, the line uses N = 4 workstations. What is the cycle time C, theoretical minimum stations N_min, and line efficiency \u03b7?",
      "options": [
        { "text": "C = 60.0 s, N_min = 4 stations, and \u03b7 = 87.5% (C = 28,800/480 = 60s, N_min = ceil(210/60) = 4, and \u03b7 = 210 / (4 * 60) = 0.875)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using assembly line balancing theory (Mikell Groover *Automation, Production Systems, and CIM* Chapter 15). 1. **Calculate Cycle Time ($C$):** $$C = \\frac{T_{\\text{available}}}{D} = \\frac{28,800\\text{ seconds}}{480\\text{ units}} = \\mathbf{60.0\\text{ seconds/unit}}$$ 2. **Calculate Theoretical Minimum Stations ($N_{\\text{min}}$):** $$N_{\\text{min}} = \\left\\lceil \\frac{\\sum t_i}{C} \\right\\rceil = \\left\\lceil \\frac{210\\text{ s}}{60\\text{ s}} \\right\\rceil = \\lceil 3.5 \\rceil = \\mathbf{4\\text{ stations}}$$ 3. **Calculate Line Balance Efficiency ($\\eta$):** $$\\eta = \\frac{\\sum t_i}{N_{\\text{actual}} \\cdot C} \\times 100\\% = \\frac{210\\text{ s}}{4 \\times 60\\text{ s}} \\times 100\\% = \\frac{210}{240} \\times 100\\% = \\mathbf{87.5\\%}$$ 4. **Calculate Balance Delay ($BD$):** $$BD = 100\\% - 87.5\\% = \\mathbf{12.5\\%\\text{ (Idle time across line)}}$$ Flawless assembly line balancing solution!" },
        { "text": "C = 60.0 s, N_min = 3 stations, and \u03b7 = 100%", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "C = 30.0 s, N_min = 7 stations, and \u03b7 = 75.0%", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "C = 120.0 s, N_min = 2 stations, and \u03b7 = 50.0%", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
