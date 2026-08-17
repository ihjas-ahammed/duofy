# Duofy Reusable Lesson Format: Single Responsibility & Open/Closed Principles (SRP and OCP)

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Object_Oriented_Analysis_and_Design_OOAD / SOLID_Design_Principles`  
**Lesson Format Type:** `single_responsibility_and_open_closed_principles_srp_ocp`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through cohesion boundaries, stakeholder actor mapping, and polymorphic extensibility in the first two SOLID principles (Robert C. Martin *Clean Architecture* Chapters 7 & 8; Bertrand Meyer 1988 *Object-Oriented Software Construction*): master the **Single Responsibility Principle (SRP)** (defining a "reason to change" as a **single actor/stakeholder** e.g. CFO, COO, or CTO, and eliminating God Classes combining payroll business rules, database persistence, and UI rendering), master the **Open/Closed Principle (OCP)** (structuring components so they are **Open for Extension** by adding new classes, but **Closed for Modification** preventing edits to battle-tested source files), analyze how abstract interfaces and strategy patterns eliminate fragile `switch (type)` statement cascades, and trace step-by-step refactoring workflows that decouple business entities from external infrastructure.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | SRP Actor Isolation Diagram, OCP Strategy Interface Extension Flow Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Refactoring of a Fragile Monolithic Class into SRP and OCP Architecture Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | SOLID Design Construct / Code Smell & Architectural Resolution Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Principle Stating That Software Entities Should Be Open for Extension but Closed for Modification Is ___ (OCP) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Architectural Analysis of How Violating SRP Creates Cross-Departmental Coupling Disasters Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State SRP & OCP (Martin 2017; Meyer 1988):
   - **SRP Actor Formulation:**
     $$\mathbf{\text{SRP Rule: } \text{\"A class should have one, and only one, reason to change (one actor/stakeholder).\"}}$$
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Violating God Class} & \textbf{Stakeholder Actor} & \textbf{SRP Refactored Class} \\
     \hline
     \texttt{Employee.calculatePay()} & \mathbf{\text{CFO (Finance / Payroll)}} & \mathbf{\texttt{PayrollCalculator}} \\
     \texttt{Employee.reportHours()} & \mathbf{\text{COO (Operations / Timesheet)}} & \mathbf{\texttt{HourReporter}} \\
     \texttt{Employee.save()} & \mathbf{\text{CTO (Database / Architecture)}} & \mathbf{\texttt{EmployeeRepository}} \\
     \hline
     \end{array}$$
   - **OCP Polymorphic Extension Formulation:**
     $$\mathbf{\text{OCP Rule: } \text{\"Open for extension, Closed for modification.\"}}$$
     - Instead of editing `if (type == BITCOIN) ...` in existing classes, create `PaymentProcessor` interface and add `BitcoinPaymentProcessor implements PaymentProcessor` without touching existing code!
2. **Slide 2 (`ordering`):** Provide 5 steps of refactoring to SRP and OCP: (1) identify God class accumulating responsibilities for multiple business stakeholders, (2) extract separate domain classes for each distinct actor (e.g. calculation, reporting, persistence), (3) identify conditional switch/case statements switching on type identifiers, (4) declare an abstract interface defining the shared polymorphic method signature, (5) implement concrete strategy classes and inject them into client code via polymorphism!
3. **Slide 3 (`matching`):** Pair 4 concepts (Single Responsibility SRP, Open/Closed OCP, God Class Anti-Pattern, Strategy Pattern) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of OCP. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why SRP violations cause cross-departmental bugs: In Robert C. Martin's classic payroll example, why does putting `calculatePay()` (used by Finance) and `reportHours()` (used by HR/Operations) in the same `Employee` class create a severe cross-departmental failure mode? (Both methods rely on a shared private helper function `regularHours()`; **when Finance requests a policy change modifying how overtime is calculated, a developer changes `regularHours()` to satisfy the CFO; because the class is shared, this change silently alters the output of `reportHours()` without HR or Operations knowing**, causing invalid time reports and payroll accounting corruption across the enterprise).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "single_responsibility_and_open_closed_principles_srp_ocp",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: SOLID Foundations — SRP \\& OCP (Martin 2017; Meyer 1988)**\n• **Single Responsibility Principle (SRP) — The Actor Invariant:**\n$$\n\\mathbf{\\text{\"A module should be responsible to one, and only one, actor (stakeholder group).\"}}\n$$\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Coupled Method (Anti-Pattern)} & \\textbf{Stakeholder Actor} & \\textbf{Decoupled SRP Responsibility} \\\\\n\\hline\n\\texttt{Employee.calculatePay()} & \\mathbf{\\text{CFO (Finance)}} & \\mathbf{\\texttt{PayCalculator (Payroll Business Logic)}} \\\\\n\\texttt{Employee.reportHours()} & \\mathbf{\\text{COO (Operations)}} & \\mathbf{\\texttt{HourReporter (Timesheet Formatting)}} \\\\\n\\texttt{Employee.save()} & \\mathbf{\\text{CTO (DBA)}} & \\mathbf{\\texttt{EmployeeRepository (Database Persistence)}} \\\\\n\\hline\n\\end{array}\n$$\n• **Open/Closed Principle (OCP) — Polymorphic Extensibility:**\n$$\n\\mathbf{\\text{\"Open for EXTENSION (via new classes), Closed for MODIFICATION (source files).\"}}\n$$\n• **The Extensibility Invariant:** Add new features by **adding new classes implementing interfaces, NEVER by editing existing tested `switch` statements**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed to refactor a monolithic God Class into clean SRP and OCP architecture.",
      "orderItems": [
        "Audit the monolithic class to identify disparate business actors (e.g. Finance, Operations, Persistence)",
        "Extract separate focused classes for each distinct stakeholder actor, encapsulating private shared helpers",
        "Locate fragile conditional switch/case blocks that check type codes to determine runtime behavior",
        "Define an abstract strategy Interface or base abstraction establishing the common polymorphic contract",
        "Create dedicated concrete classes implementing the interface and inject them into client code with zero client modification"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each SOLID Construct to its exact Technical Definition.",
      "matchPairs": [
        { "left": "Single Responsibility (SRP)", "right": "Ensures a class has only one reason to change by aligning its scope with a single business actor" },
        { "left": "Open/Closed Principle (OCP)", "right": "Enables adding new system behaviors via polymorphism without altering existing tested source code" },
        { "left": "God Class Anti-Pattern", "right": "Monolithic class accumulating business logic, database persistence, and UI rendering" },
        { "left": "Strategy Design Pattern", "right": "Encapsulates interchangeable algorithms behind a common interface to satisfy OCP compliance" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The principle stating that software entities should be open for extension but closed for modification is the ___ principle.",
      "blankAnswer": "OCP",
      "blankDistractors": ["SRP", "LSP", "ISP"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In Robert C. Martin's classic payroll example, why does colocating calculatePay() (used by Finance) and reportHours() (used by HR/Operations) in the same Employee class cause dangerous cross-departmental software defects?",
      "options": [
        { "text": "Both methods internally share a common private helper method (e.g. regularHours()); when Finance requests an urgent change to overtime calculation rules, an engineer modifies the shared helper method to satisfy the CFO; because the class conflates multiple actor responsibilities, this change silently and unintentionally corrupts the hours calculation inside reportHours() for HR, causing catastrophic data corruption across unrelated enterprise departments", "isCorrect": true, "explanation": "Correct! This is Robert C. Martin's classic demonstration of why SRP is fundamentally about *actors and people*, not just function size (Robert C. Martin *Clean Architecture* Chapter 7). 1. **The Shared Helper Trap:** - `Employee` class has `calculatePay()` and `reportHours()`. - To avoid repeating code, developer writes a private method `regularHours() = workedHours - overtime`. - CFO says: *\"We are changing overtime rules for payroll to exclude lunch breaks!\"* - Developer modifies `regularHours()` to subtract lunch. - `calculatePay()` works perfectly! Tests pass. Release deployed. 2. **The Disaster:** - HR uses `reportHours()` to generate legal OSHA compliance reports. - `reportHours()` was silently using the modified `regularHours()`! - The company now produces legally invalid employee audit reports without anyone knowing for months. 3. **The Solution (SRP):** - Separate classes: `PayrollCalculator` (owned by CFO actor) and `HourReporter` (owned by COO/HR actor). - If they need shared calculations, make the dependency explicit with duplicate domain concepts, ensuring that changes requested by Finance can NEVER break Operations!" },
        { "text": "Because Java Virtual Machines can only execute 1 method per class", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Finance and HR departments are forbidden from using the same database", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because calculatePay() cannot process decimal numbers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
