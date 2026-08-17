# Duofy Reusable Lesson Format: Scrum Framework (3 Roles, 5 Events, and 3 Artifacts)

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Software_Development_Life_Cycle_SDLC / Agile_Scrum_Kanban_Methodologies`  
**Lesson Format Type:** `scrum_framework_3_roles_5_events_and_3_artifacts`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the prescriptive roles, timeboxed feedback events, and transparent commitments of the Scrum framework (Ken Schwaber & Jeff Sutherland, *The 2020 Scrum Guide*; Henrik Kniberg *Scrum and XP from the Trenches*; Sommerville Chapter 3.2): master the **3 Scrum Roles** (**Product Owner** [value maximizer, owns single ordered Product Backlog], **Scrum Master** [servant leader, removes blockers/impediments, coaches empirical agility], **Developers** [cross-functional, self-organizing creators of the Increment]), master the **5 Timeboxed Events** (**1. The Sprint** [1-4 week container event], **2. Sprint Planning** [Why, What, How], **3. Daily Scrum** [15-minute daily sync for Developers], **4. Sprint Review** [working increment demo with stakeholders], **5. Sprint Retrospective** [inspect & adapt team process]), master the **3 Artifacts & Commitments** (**Product Backlog $\to$ Product Goal, Sprint Backlog $\to$ Sprint Goal, Increment $\to$ Definition of Done [DoD]**), and prove why violating the Definition of Done creates catastrophic technical debt.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Scrum 3-5-3 Taxonomy (3 Roles, 5 Events, 3 Artifacts + DoD Commitments) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Chronological Execution of Ceremonies in a Single Sprint Lifecycle Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Scrum Role / Event / Artifact & Specific Governance Responsibility Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Formal Quality Standard That an Increment Must Meet to Be Shippable Is the Definition of ___ (Done) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Architectural and Governance Analysis: Why Scrum Prohibits Project Managers and Sub-Teams Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Scrum Framework (Schwaber & Sutherland *Scrum Guide*):
   - **The 3-5-3 Architectural Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{3 Roles} & \textbf{5 Timeboxed Events} & \textbf{3 Artifacts (Commitment)} \\
     \hline
     \mathbf{\text{1. Product Owner (PO)}} & \mathbf{\text{1. Sprint (1-4 wk container)}} & \mathbf{\text{1. Product Backlog (Product Goal)}} \\
     \mathbf{\text{2. Scrum Master (SM)}} & \mathbf{\text{2. Sprint Planning}} & \mathbf{\text{2. Sprint Backlog (Sprint Goal)}} \\
     \mathbf{\text{3. Developers}} & \mathbf{\text{3. Daily Scrum (15 min)}} & \mathbf{\text{3. Increment (Definition of Done DoD)}} \\
     & \mathbf{\text{4. Sprint Review}} & \\
     & \mathbf{\text{5. Sprint Retrospective}} & \\
     \hline
     \end{array}$$
   - **The Definition of Done (DoD) Invariant:** An increment cannot be released or demonstrated if it violates the DoD (e.g. unit tests, code review, performance benchmarks, documentation)!
2. **Slide 2 (`ordering`):** Provide 5 steps of a Sprint: (1) execute Sprint Planning to define Sprint Goal and select user stories, (2) Developers collaborate daily, holding 15-minute Daily Scrum to inspect progress toward Sprint Goal, (3) develop and verify increment ensuring all work adheres to Definition of Done, (4) hold Sprint Review with stakeholders to demonstrate working software increment and adapt Product Backlog, (5) hold Sprint Retrospective to inspect team collaboration, tools, and processes and commit to actionable improvements!
3. **Slide 3 (`matching`):** Pair 4 concepts (Product Owner, Scrum Master, Sprint Review, Definition of Done) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Definition of Done. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why Scrum eliminates hierarchical sub-teams: Why does the Scrum Guide explicitly state there are 'no sub-teams or hierarchies' within a Scrum Team and replace traditional Project Managers with the tripartite structure of Product Owner, Scrum Master, and Developers? (Traditional project management concentrates command-and-control authority in a single manager who dictates task assignments, creating handoff bottlenecks, finger-pointing between separate dev/QA sub-teams, and shielding developers from direct business accountability; **Scrum establishes a flat, cross-functional team where accountability is shared: the Product Owner decides WHAT gets built based on business value, the Developers self-organize to decide HOW to build it with complete engineering autonomy, and the Scrum Master acts as a servant leader removing blockers**, maximizing velocity and psychological safety).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "scrum_framework_3_roles_5_events_and_3_artifacts",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Scrum Framework — The 3-5-3 Architecture (Schwaber \\& Sutherland 2020)**\n• **The 3 Roles, 5 Events, and 3 Artifacts Matrix:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{3 Roles (Accountabilities)} & \\textbf{5 Timeboxed Events} & \\textbf{3 Artifacts \\& Commitments} \\\\\n\\hline\n\\mathbf{\\text{Product Owner (PO)}} & \\mathbf{\\text{The Sprint (1-4 wks)}} & \\mathbf{\\text{Product Backlog (Commitment: Product Goal)}} \\\\\n\\mathbf{\\text{Scrum Master (SM)}} & \\mathbf{\\text{Sprint Planning}} & \\mathbf{\\text{Sprint Backlog (Commitment: Sprint Goal)}} \\\\\n\\mathbf{\\text{Developers}} & \\mathbf{\\text{Daily Scrum (15 min)}} & \\mathbf{\\text{Increment (Commitment: Definition of Done)}} \\\\\n& \\mathbf{\\text{Sprint Review (Demo)}} & \\\\\n& \\mathbf{\\text{Sprint Retrospective}} & \\\\\n\\hline\n\\end{array}\n$$\n• **The Definition of Done (DoD) Invariant:** An increment is **NOT shippable** until it meets all explicit quality criteria (e.g. 100% test pass, peer review, zero critical bugs)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential ceremonies and activities executed within a single standard Scrum Sprint cycle.",
      "orderItems": [
        "Conduct Sprint Planning to establish the Sprint Goal, select backlog items, and decompose them into actionable tasks",
        "Developers execute daily development tasks, holding a 15-minute Daily Scrum to inspect progress toward the Sprint Goal",
        "Build, test, and integrate features continuously to produce a usable, tested Increment satisfying the Definition of Done",
        "Host the Sprint Review with key business stakeholders to demonstrate the live Increment and adapt the Product Backlog",
        "Convene the internal Sprint Retrospective to inspect team dynamics, processes, and tools, committing to specific improvements"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Scrum Framework Element to its exact Accountability.",
      "matchPairs": [
        { "left": "Product Owner (PO)", "right": "Maximizes business value of the product and maintains the single ordered Product Backlog" },
        { "left": "Scrum Master (SM)", "right": "Servant leader facilitating Scrum ceremonies and systematically removing team impediments" },
        { "left": "Sprint Review", "right": "Collaborative stakeholder event inspecting the working Increment to adapt future release scope" },
        { "left": "Definition of Done (DoD)", "right": "Formal checklist of quality standards that an Increment must satisfy to be declared complete" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The formal quality standard that every Increment must satisfy before being declared complete is the Definition of ___.",
      "blankAnswer": "Done",
      "blankDistractors": ["Ready", "Scope", "Sprint"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the Scrum Guide explicitly mandate that a Scrum Team has 'no sub-teams or hierarchies' and replace traditional Project Managers with the tripartite structure of Product Owner, Scrum Master, and Developers?",
      "options": [
        { "text": "Traditional project management concentrates command-and-control authority in a single manager who dictates task assignments, creating handoff bottlenecks, finger-pointing between segregated dev and QA silos, and shielding developers from business value; Scrum establishes a cross-functional, self-organizing team where accountability is decoupled: the Product Owner decides WHAT to build based on business return, the Developers autonomously decide HOW to build it with technical ownership, and the Scrum Master acts as a servant leader removing organizational roadblocks", "isCorrect": true, "explanation": "Correct! This is Ken Schwaber and Jeff Sutherland's core organizational design principle in *The Scrum Guide* (2020 edition). 1. **The Flaw of Traditional Silos:** - In old IT organizations, you had a Project Manager assigning tasks, a separate 'Dev Team', and a separate 'QA Team'. - When a bug was found: Devs blamed QA for bad test plans; QA blamed Devs for bad code; PM blamed both for missed deadlines! - The handoffs between silos caused $70\\%$ of project time to be spent waiting. 2. **The Scrum Tripartite Model:** - **Product Owner:** Owns the *Vision* and *Value* (decides *WHAT* to build and *WHEN*). - **Developers:** Cross-functional group containing programmers, testers, designers, and DevOps engineers (owns *HOW* to build it and *QUALITY*). - **Scrum Master:** Owns the *Process* and *Psychological Safety* (ensures agility and removes blockers). 3. **The Power of Self-Organization:** - When the team is empowered to self-organize without micro-management, commitment and velocity soar because the people doing the work make the technical decisions!" },
        { "text": "Because Scrum Teams are legally required to have exactly 100 members", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Scrum eliminates the need for software testing", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Project Managers are prohibited from using computers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
