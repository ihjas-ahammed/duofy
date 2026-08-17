# Duofy Reusable Lesson Format: Project Scheduling (CPM, PERT Networks, & Float)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Manufacturing_and_Industrial_Engineering / Production_Planning_and_Inventory_Control`  
**Lesson Format Type:** `cpm_pert_project_scheduling_critical_path_and_float`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify industrial project management, Activity-on-Node (AON) network scheduling, Critical Path Method (CPM), PERT probabilistic beta distributions, and total/free float determination (Morgan R. Walker & James E. Kelley 1957; US Navy Special Projects Office 1958; William J. Stevenson *Operations Management* Chapter 17; Hamdy A. Taha *Operations Research* Chapter 6): master the **Forward Pass (Early Start $ES$ & Early Finish $EF = ES + t$)** and **Backward Pass (Late Finish $LF$ & Late Start $LS = LF - t$)**; define **Total Float / Slack ($\mathbf{S}$)** and the **Critical Path Invariant**:
$$\mathbf{\text{Total Float } S = LS - ES = LF - EF \quad \Big| \quad \mathbf{\text{Critical Path: } S = 0}}$$
(proving why any delay in a critical path activity immediately causes a day-for-day delay in overall project completion); master **PERT 3-Point Estimates (Beta Distribution Expected Time & Variance)**:
$$\mathbf{t_e = \frac{a + 4m + b}{6} \quad \Big| \quad \mathbf{\sigma^2 = \left(\frac{b - a}{6}\right)^2 \implies \sigma_{\text{project}} = \sqrt{\sum_{\text{critical}} \sigma_i^2}}}$$
where $a$ is optimistic time, $m$ is most likely time, and $b$ is pessimistic time, and interact with live EOQ/EPQ optimizer, Safety stock ROP calculator, Line balancing designer, and PERT project network graph widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CPM Float ($S = LS - ES = 0$) & PERT Expected Duration ($t_e = \frac{a+4m+b}{6}$) Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Project Scheduling Term / PERT Variable & Technical Operational Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Critical Path Activities Have Exactly Zero Float and Dictate Overall Project Duration Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Longest Continuous Sequence of Dependent Activities Through a Project Network Is the ___ Path (Critical) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Production Planning & Operations Studio: EOQ, ROP, Line Balancing & CPM/PERT Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cpm_pert_project_scheduling_critical_path_and_float",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Critical Path in CPM, and how does PERT model activity time uncertainty?",
      "blankAnswer": "Project Scheduling (CPM & PERT): (1) CRITICAL PATH: The longest path of dependent activities from project start to finish. Activities on this path have ZERO SLACK/FLOAT (S = LS - ES = LF - EF = 0). Any delay on the critical path directly delays project completion! (2) FORWARD PASS: Early Start ES = max(EF of predecessors), Early Finish EF = ES + t. (3) BACKWARD PASS: Late Finish LF = min(LS of successors), Late Start LS = LF - t. (4) PERT 3-POINT ESTIMATION: Expected duration t_e = (a + 4m + b) / 6, Variance \u03c3^2 = ((b - a) / 6)^2 where a = optimistic, m = most likely, b = pessimistic times. Project variance \u03c3_proj^2 = sum of critical activity variances!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Project Scheduling Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Critical Path", "right": "Longest sequence of dependent activities having zero total float (S = 0), defining minimum project duration" },
        { "left": "Total Float / Slack", "right": "S = LS - ES = LF - EF, maximum duration an activity can be delayed without delaying project completion" },
        { "left": "PERT Expected Time (te)", "right": "te = (a + 4m + b) / 6, weighted average assigning 4x weight to the most likely duration m" },
        { "left": "Activity Variance (\u03c3^2)", "right": "\u03c3^2 = ((b - a) / 6)^2, quantifying the statistical dispersion and execution risk of an activity" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In project management network analysis (CPM/PERT), why do activities lying on the Critical Path possess exactly zero total float (Slack = 0), and why must project managers prioritize them above all other tasks?",
      "options": [
        { "text": "The critical path represents the single longest continuous chain of dependent tasks from start to end; because it defines the absolute minimum calendar duration required to finish the entire project, there is zero slack margin between an activity's earliest possible start (ES) and latest allowable start (LS); any delay in completing a critical path activity causes an immediate, day-for-day delay in the overall project delivery milestone, whereas non-critical tasks have positive float and can absorb minor delays without impacting the final deadline", "isCorrect": true, "explanation": "Correct! This is William Stevenson and Hamdy Taha's fundamental network analysis proof (*Operations Management* Chapter 17; *Operations Research: An Introduction* Chapter 6). 1. **Mathematical Definition of Float:** $$\\text{Total Float } S = LS - ES = LF - EF$$ 2. **The Longest Chain Invariant:** - The critical path is the bottleneck path that determines total project duration $T_{\\text{project}}$. - For every activity on this path, $ES = LS$ and $EF = LF \\implies \\mathbf{S = 0}$! 3. **Managerial Consequence:** - If a non-critical task with $S = 5\\text{ days}$ is delayed by $3\\text{ days}$, the project finish date is **completely unaffected**. - If a critical task ($S = 0$) is delayed by even $1\\text{ hour}$, the entire project delivery date slips by **exactly $1\\text{ hour}$**! 4. **Crashing Strategy:** To expedite a project, management must crash (allocate overtime/resources to) **critical path activities exclusively**; crashing non-critical tasks wastes budget without saving a single day!" },
        { "text": "Because critical path tasks cost the most money to execute", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because non-critical tasks are performed by robots", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because float is an illegal metric under ISO 9001 standards", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The longest continuous sequence of dependent tasks through a project network is the ___ path.",
      "blankAnswer": "critical",
      "blankDistractors": ["primary", "parallel", "slack"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Production Planning & Operations Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Production Planning & Operations Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">EOQ/EPQ, Safety Stock, Line Balancing & CPM/PERT</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnEoq\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. EOQ Batch (Q* = 500 units)</button><button id=\"btnLine\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Line Balancing (87.5% Eff)</button><button id=\"btnPert\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. CPM / PERT Critical Path</button></div><div id=\"omLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate EOQ batch sizing...</div><script>document.getElementById('btnEoq').onclick=()=>{document.getElementById('omLog').innerHTML='<b>1. ECONOMIC ORDER QUANTITY (EOQ):</b><br>• D=10k units/yr, S=$50, H=$4.00 &rarr; <b style=\"color:#10b981;\">Q* = 500 units!</b><br>• Ordering Cost ($1000) = Holding Cost ($1000)<br>• Reorder Point: ROP = 950 units @ 95% CSL (SS = 50 units)';}; document.getElementById('btnLine').onclick=()=>{document.getElementById('omLog').innerHTML='<b>2. ASSEMBLY LINE BALANCING:</b><br>• Available Ta = 28,800s, Demand D = 480 units &rarr; Cycle C = 60s<br>• Work content \\u2211ti = 210s &rarr; N_min = 4 stations<br>• <b style=\"color:#38bdf8;\">Line Efficiency: \\u03b7 = 210 / (4*60) = 87.5% (Balance Delay = 12.5%)!</b>';}; document.getElementById('btnPert').onclick=()=>{document.getElementById('omLog').innerHTML='<b>3. CPM / PERT PROJECT SCHEDULING:</b><br>• PERT Expected Time: te = (a + 4m + b) / 6<br>• Critical Path: Sequence with <b style=\"color:#10b981;\">Slack S = LS - ES = 0!</b><br>• Any delay on critical path delays project delivery!<br>🏆 <b style=\"color:#10b981;\">01_Mechanical_Engineering (ALL 18 LEAF DIRS) 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
