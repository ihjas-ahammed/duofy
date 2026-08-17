# Duofy Reusable Lesson Format: Agile Manifesto (Values, Principles, and Empirical Process Control)

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Software_Development_Life_Cycle_SDLC / Agile_Scrum_Kanban_Methodologies`  
**Lesson Format Type:** `agile_manifesto_values_principles_and_empirical_process_control`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the philosophical foundations, empirical process control theory, and cultural shifts of the Agile Manifesto (Kent Beck, Martin Fowler, Robert C. Martin, Ken Schwaber, Jeff Sutherland et al. 2001, *Manifesto for Agile Software Development*, Snowbird Utah; Ian Sommerville Chapter 3.1): contrast **Defined Process Control** (industrial assembly-line assumption that every step is repeatable and predictable) with **Empirical Process Control** (knowledge-work reality based on the 3 pillars: **Transparency, Inspection, and Adaptation** in complex, volatile environments), master the **4 Core Values of the Agile Manifesto** (**1. Individuals & interactions over processes & tools; 2. Working software over comprehensive documentation; 3. Customer collaboration over contract negotiation; 4. Responding to change over following a plan**), analyze the **12 Agile Principles** (welcoming changing requirements even late in development, sustainable development pace, simplicity as maximizing the amount of work not done), and evaluate how shifting from plan-driven contracts to iterative value delivery minimizes market risk.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The 4 Agile Manifesto Values Table, 3 Pillars of Empiricism Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Evolution of an Agile Empirical Feedback Loop (Transparent Work $\to$ Inspect $\to$ Adapt) Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Agile Manifesto Core Value / Principle & Traditional Process Anti-Pattern Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Three Foundational Pillars of Empirical Process Control Are Transparency, Inspection, and ___ (Adaptation) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Philosophical Analysis of Why Responding to Change Beats Following a Rigid Plan Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Agile Manifesto (Beck et al. 2001; Sommerville Ch 3.1):
   - **The 4 Core Values Matrix:**
     $$\begin{array}{|l|c|l|}
     \hline
     \textbf{Agile Priority (Valued More)} & \textbf{vs} & \textbf{Traditional Priority (Valued Less)} \\
     \hline
     \mathbf{\text{1. Individuals and interactions}} & \text{over} & \text{Processes and tools} \\
     \mathbf{\text{2. Working software}} & \text{over} & \text{Comprehensive documentation} \\
     \mathbf{\text{3. Customer collaboration}} & \text{over} & \text{Contract negotiation} \\
     \mathbf{\text{4. Responding to change}} & \text{over} & \text{Following a plan} \\
     \hline
     \end{array}$$
   - **The 3 Pillars of Empiricism (Ken Schwaber):**
     1. **Transparency:** Significant aspects of the process must be visible to those responsible for the outcome.
     2. **Inspection:** Frequent inspection of artifacts and progress toward goals to detect variances.
     3. **Adaptation:** Adjusting processes and backlog as soon as deviation occurs.
2. **Slide 2 (`ordering`):** Provide 5 steps of empirical feedback: (1) establish radical transparency by visualizing all backlog items and technical debt, (2) deliver a functional increment of working software to end-users, (3) inspect actual user behavior and real-world metrics during sprint review, (4) identify discrepancies between expected and actual user value, (5) adapt the product backlog, architecture, and team workflows in the next iteration!
3. **Slide 3 (`matching`):** Pair 4 values (Individuals over Tools, Working Software over Documentation, Customer Collaboration over Contracts, Responding to Change over Plans) with their real-world meanings.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that 3rd pillar of empiricism is Adaptation. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why welcoming changing requirements creates competitive advantage: Why does the 2nd principle of the Agile Manifesto declare that Agile processes 'welcome changing requirements, even late in development' to harness change for the customer's competitive advantage? (Traditional plan-driven processes treat changes as costly errors to be suppressed with Change Control Boards because they assume perfect foresight in Phase 1; **in real-world commercial software, market demands, competitor features, and user needs evolve rapidly; embracing late changes allows the product to pivot toward newly discovered high-value opportunities rather than rigidly shipping obsolete software that strictly adhered to an outdated 12-month-old plan**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "agile_manifesto_values_principles_and_empirical_process_control",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Agile Manifesto \\& Empirical Process Control (Beck et al. 2001)**\n• **The 4 Core Manifesto Values (Snowbird Utah):**\n$$\n\\begin{array}{|l|c|l|}\n\\hline\n\\textbf{Primary Agile Focus (Valued MORE)} & \\textbf{Relative Weight} & \\textbf{Secondary Factor (Valued LESS)} \\\\\n\\hline\n\\mathbf{\\text{1. Individuals \\& interactions}} & \\mathbf{\\text{OVER}} & \\text{Processes and tools} \\\\\n\\mathbf{\\text{2. Working software}} & \\mathbf{\\text{OVER}} & \\text{Comprehensive documentation} \\\\\n\\mathbf{\\text{3. Customer collaboration}} & \\mathbf{\\text{OVER}} & \\text{Contract negotiation} \\\\\n\\mathbf{\\text{4. Responding to change}} & \\mathbf{\\text{OVER}} & \\text{Following a plan} \\\\\n\\hline\n\\end{array}\n$$\n• **The 3 Pillars of Empiricism (Ken Schwaber):**\n  - **Transparency:** Clear visibility into reality without masking blockers.\n  - **Inspection:** Continuous evaluation of working increments against goals.\n  - **Adaptation:** Rapid course-correction the instant a variance is discovered!\n• **The Core Mindset Invariant:** Software is **complex knowledge work, not an industrial factory assembly line**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed across an Empirical Process Control feedback loop in Agile software engineering.",
      "orderItems": [
        "Establish radical Transparency by making all work items, technical debt, and team impediments openly visible",
        "Develop and deliver a functional Increment of working software within a short, fixed timebox",
        "Inspect real-world customer usage, performance telemetry, and stakeholder feedback on the working increment",
        "Analyze variances between projected assumptions and observed reality to identify required changes",
        "Execute Adaptation by reprioritizing the Product Backlog and tuning team engineering practices for the next iteration"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Agile Manifesto Value to its exact Real-World Meaning.",
      "matchPairs": [
        { "left": "Individuals & Interactions over Processes", "right": "Direct human conversation and team chemistry resolve problems faster than rigid toolchains" },
        { "left": "Working Software over Documentation", "right": "Executable functional code is the only true objective measure of engineering progress" },
        { "left": "Customer Collaboration over Contracts", "right": "Partnering continuously with users to solve their problems rather than enforcing rigid legal terms" },
        { "left": "Responding to Change over Plans", "right": "Pivoting architecture and roadmap to exploit newly discovered market opportunities" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The three foundational pillars of Empirical Process Control in Agile are Transparency, Inspection, and ___.",
      "blankAnswer": "adaptation",
      "blankDistractors": ["automation", "documentation", "negotiation"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the Agile Manifesto explicitly state that Agile teams 'welcome changing requirements, even late in development' to harness change for the customer's competitive advantage?",
      "options": [
        { "text": "Plan-driven models treat changes as costly anomalies to be suppressed through change control boards because they assume initial requirements are perfect; in real-world knowledge work, customer needs, competitor features, and business environments evolve unpredictably during development; welcoming late changes allows the engineering team to pivot immediately toward newly discovered high-value user needs rather than wasting budget delivering obsolete features defined in an outdated 12-month-old plan", "isCorrect": true, "explanation": "Correct! This is Kent Beck and Martin Fowler's fundamental insight behind Agile economics (Beck et al. 2001 *Manifesto for Agile Software Development*; Ian Sommerville *Software Engineering* Section 3.1). 1. **The Plan-Driven Fallacy:** - In Waterfall, if a competitor launches a revolutionary new feature in Month 9 of your 12-month project, the project manager says: *\"Sorry, our SRS is locked. We will finish our planned features first, even though they are now obsolete.\"* - You spend $\\$1\\text{M}$ delivering a product that nobody wants anymore. 2. **The Agile Competitive Edge:** - Agile accepts that **learning happens DURING the act of building software**. - When a new requirement emerges in Sprint 15: The Product Owner immediately inserts it at the top of the Product Backlog. - In Sprint 16 (2 weeks later), the team ships that feature to production! - The customer gains an immediate market advantage while competitors are still stuck in approval meetings. 3. **The Philosophy:** It is far better to change course and build the *right* product than to execute a flawless plan that builds the *wrong* product." },
        { "text": "Because changing requirements allows developers to stop writing unit tests", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Agile projects are strictly forbidden from having business goals", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because welcoming changes makes software compile 10 times faster", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
