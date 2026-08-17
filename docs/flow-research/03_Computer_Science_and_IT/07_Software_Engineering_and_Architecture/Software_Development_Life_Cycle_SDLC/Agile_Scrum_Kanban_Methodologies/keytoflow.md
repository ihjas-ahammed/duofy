# Key to Flow: Agile Methodologies (Manifesto Mindset, Scrum Framework, & Kanban Lean Flow)

**Subject Area:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Software_Development_Life_Cycle_SDLC / Agile_Scrum_Kanban_Methodologies`

---

## 📌 Core Concept & Mental Model
**Empirical Process Control (Transparency, Inspection, & Adaptation), The 4 Agile Manifesto Values & 12 Principles, The 3-5-3 Scrum Prescriptive Framework (3 Roles, 5 Ceremonies, 3 Artifacts + Definition of Done DoD), Lean Pull-Based Flow Control (Kanban with Explicit WIP Limits & Cumulative Flow Diagrams CFD), Queueing Theory Dynamics (Little's Law: $\text{Lead Time} = \frac{\text{WIP}}{\text{Throughput}}$), and Relative Effort Estimation (Fibonacci Story Points & Burndown Velocity)** govern modern adaptive software engineering (Kent Beck et al. 2001 *Agile Manifesto*; Ken Schwaber & Jeff Sutherland *The Scrum Guide*; David J. Anderson *Kanban*; Henrik Kniberg *Scrum and XP from the Trenches*; Ian Sommerville *Software Engineering* Chapter 3):
* **1. The Agile Manifesto (Snowbird, Utah 2001 - 4 Values & 12 Principles):**
  - **1. Individuals and interactions** over processes and tools.
  - **2. Working software** over comprehensive documentation.
  - **3. Customer collaboration** over contract negotiation.
  - **4. Responding to change** over following a plan.
  - *Core Insight:* While there is value in the items on the right, we value the items on the left more!
* **2. The Scrum Framework (The 3-5-3 Structure):**
  - **3 Roles (Self-Organizing & Cross-Functional):**
    - **Product Owner (PO):** Maximizes product value; owns and orders the **Product Backlog**.
    - **Scrum Master (SM):** Servant leader; coaches agility, removes blockers/impediments, facilitates ceremonies.
    - **Developers (Scrum Team):** Engineers who create the usable **Increment** each Sprint (no sub-hierarchies).
  - **5 Events / Ceremonies (Timeboxed):**
    - **Sprint:** 1-4 week container event producing a "Done" increment.
    - **Sprint Planning:** Decides *Why* (Sprint Goal), *What* (selected Backlog Items), and *How* (task breakdown).
    - **Daily Scrum (Standup):** 15-minute daily sync (Yesterday, Today, Impediments) to inspect progress toward Sprint Goal.
    - **Sprint Review:** Stakeholder demo inspecting working increment and adapting Product Backlog.
    - **Sprint Retrospective:** Inspects team dynamics, tools, and processes; commits to continuous improvements.
  - **3 Artifacts & Commitments:**
    - Product Backlog $\to$ Product Goal.
    - Sprint Backlog $\to$ Sprint Goal.
    - Potentially Shippable Increment $\to$ **Definition of Done (DoD)**.
* **3. The Kanban Methodology (Lean Pull-System):**
  - Continuous flow (no fixed iterations); 6 Core Practices (Visualize workflow, **Limit Work in Progress WIP**, Manage flow, Make policies explicit, Feedback loops, Collaborative improvement).
  - **Little's Law Invariant:**
    $$\mathbf{\text{Lead Time} = \frac{\text{Work in Progress (WIP)}}{\text{Throughput (Delivery Rate)}}}$$
    - Slashing WIP directly **slashes Lead Time and eliminates context-switching latency**!
  - **Cumulative Flow Diagram (CFD):** Visualizes WIP as vertical distance between Arrival and Departure curves; horizontal distance is Lead Time. A widening band indicates an upstream bottleneck!
* **4. Agile Estimation & Velocity Tracking:**
  - **Relative Sizing (Story Points):** Uses Fibonacci sequence ($1, 2, 3, 5, 8, 13, 21$) via **Planning Poker** to estimate complexity, uncertainty, and effort rather than absolute calendar hours.
  - **Sprint Burndown Chart:** Tracks remaining Story Points day-by-day against an ideal linear trajectory; detects scope creep and capacity bottlenecks.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Agile Paradigm Comparison
* Fixed Scope & Variable Time $\to$ Waterfall / Plan-Driven.
* Fixed Timebox & Variable Scope $\to$ Scrum (Sprints, Roles, Product Goal, DoD).
* Continuous Flow & Fixed WIP Limits $\to$ Kanban (Pull system, Little's Law, CFD).
* Estimation $\to$ Story Points (Fibonacci) $\to$ Velocity $\to$ Burndown Tracking.

### 2. Top Recommended Resources
* **The Official Sources:** *The Agile Manifesto* (agilemanifesto.org 2001); *The Scrum Guide* (Ken Schwaber & Jeff Sutherland, scrumguides.org).
* **The Lean Classic:** *Kanban: Successful Evolutionary Change for Your Technology Business* (David J. Anderson, 2010).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you recite the 4 values of the Agile Manifesto and explain the philosophy behind them?
- [ ] Can you detail the 3 roles, 5 events, and 3 artifacts of the Scrum framework?
- [ ] Can you apply Little's Law ($\text{Lead Time} = \text{WIP} / \text{Throughput}$) to optimize a software delivery pipeline?
- [ ] Can you interpret a Cumulative Flow Diagram (CFD) and identify bottlenecks?
