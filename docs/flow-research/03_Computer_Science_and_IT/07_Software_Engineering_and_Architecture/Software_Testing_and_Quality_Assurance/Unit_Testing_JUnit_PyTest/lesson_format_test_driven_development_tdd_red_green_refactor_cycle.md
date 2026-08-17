# Duofy Reusable Lesson Format: Test-Driven Development (TDD Red-Green-Refactor Cycle)

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Software_Testing_and_Quality_Assurance / Unit_Testing_JUnit_PyTest`  
**Lesson Format Type:** `test_driven_development_tdd_red_green_refactor_cycle`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the interface design discipline, psychological micro-feedback loops, and structural hygiene of Test-Driven Development (Kent Beck 2002, *Test-Driven Development: By Example*, Addison-Wesley; Robert C. Martin *Clean Code* Chapter 9; Vladimir Khorikov 2020): master the **Red-Green-Refactor Cycle** (**1. Red:** Write a tiny failing test specifying desired behavior and asserting expected output before production code exists; **2. Green:** Write the simplest, minimal production code necessary to pass the test, including hardcoding constants if needed; **3. Refactor:** Eliminate duplication, clean up code smells, and improve internal architecture while strictly preserving passing tests), master the **AAA (Arrange-Act-Assert) Structural Pattern**, and enforce the **FIRST Principles** (**F**ast [runs in milliseconds in memory], **I**solated/Independent, **R**epeatable, **S**elf-validating, **T**horough).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | TDD Red-Green-Refactor Flow Diagram, AAA Pattern & FIRST Principles Reference Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Chronological Execution of a Single TDD Feature Increment Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | TDD Phase / Testing Principle & Core Engineering Purpose Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Step in TDD Where You Clean Up Code Without Altering Behavior While Tests Stay Green Is ___ (Refactor) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Architectural Analysis: Why Writing the Test FIRST Results in Superior Decoupled Software Design Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State TDD (Beck 2002; Khorikov 2020):
   - **The 3-Phase TDD Rhythm:**
     $$\mathbf{\text{1. RED: Write Failing Test}} \longrightarrow \mathbf{\text{2. GREEN: Minimal Pass Code}} \longrightarrow \mathbf{\text{3. REFACTOR: Clean Architecture (Stay Green!)}}$$
   - **The AAA Test Hygiene Standard:**
     - **Arrange:** Instantiate SUT (System Under Test) and mock inputs.
     - **Act:** Execute the single target method `sut.calculate(args)`.
     - **Assert:** Verify expected return value or postcondition `assertEquals(expected, actual)`.
   - **The FIRST Invariant:** Fast, Isolated, Repeatable, Self-validating, Thorough.
2. **Slide 2 (`ordering`):** Provide 5 steps of TDD: (1) write a tiny unit test for a new requirement and execute test suite, (2) observe test fail with a clear assertion or compilation error (RED phase), (3) write the minimal production code necessary to make the test pass (GREEN phase), (4) run entire test suite to verify 100% green status, (5) refactor production code to remove duplication and extract clean abstractions while ensuring all tests remain green!
3. **Slide 3 (`matching`):** Pair 4 concepts (RED Phase, GREEN Phase, REFACTOR Phase, Arrange-Act-Assert AAA) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Refactor step. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why TDD improves software architecture: Why is Test-Driven Development fundamentally considered a *software design discipline* rather than merely a quality-assurance testing technique? (Writing tests before code forces developers to adopt the perspective of an external client consuming the API; **if a class is tightly coupled to concrete databases or complex globals, writing a unit test for it is painful and difficult; by forcing the test to be written first, TDD acts as a design pressure that compels developers to design small, modular classes with clean interfaces and dependency injection**, naturally producing high-cohesion, low-coupling architectures).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "test_driven_development_tdd_red_green_refactor_cycle",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Test-Driven Development — TDD (Kent Beck 2002)**\n• **The Red-Green-Refactor Micro-Cycle:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{TDD Phase} & \\textbf{Primary Engineering Action} & \\textbf{Success Criteria} \\\\\n\\hline\n\\mathbf{\\text{1. RED}} & \\text{Write a small unit test for a new behavioral slice} & \\mathbf{\\text{Test FAILS for the exact expected reason}} \\\\\n\\mathbf{\\text{2. GREEN}} & \\text{Write the minimal code needed to pass the test} & \\mathbf{\\text{Test PASSES (No premature optimization!)}} \\\\\n\\mathbf{\\text{3. REFACTOR}} & \\mathbf{\\text{Clean code, eliminate duplication, improve design}} & \\mathbf{\\text{All tests REMAIN 100% GREEN!}} \\\\\n\\hline\n\\end{array}\n$$\n• **The AAA (Arrange-Act-Assert) Structural Pattern:**\n  - **Arrange:** Setup test inputs, dependencies, and expected outputs.\n  - **Act:** Invoke the single method under test.\n  - **Assert:** Validate postconditions: $\\mathbf{\\texttt{assertEquals(expected, actual)}} estimation$.\n• **The FIRST Invariant:** **F**ast (ms), **I**solated, **R**epeatable, **S**elf-validating, **T**horough!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed during a single complete iteration of the TDD Red-Green-Refactor cycle.",
      "orderItems": [
        "Write a concise unit test specifying a single new behavioral requirement using the Arrange-Act-Assert structure",
        "Run the test suite and verify that the new test fails with an explicit assertion error (RED phase)",
        "Write the simplest, minimal production code necessary to satisfy the test and make it pass (GREEN phase)",
        "Re-run the automated test suite to confirm that all tests pass cleanly without regressions",
        "Refactor production code to remove duplication and refine design patterns while ensuring tests stay green (REFACTOR phase)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each TDD / Unit Testing Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "RED Phase", "right": "Writing a failing test first to establish a clear specification of expected behavior" },
        { "left": "GREEN Phase", "right": "Writing the quickest minimal code to satisfy the test without premature over-engineering" },
        { "left": "REFACTOR Phase", "right": "Improving internal code quality and removing duplication while keeping the test suite green" },
        { "left": "Arrange-Act-Assert (AAA)", "right": "Standard 3-part layout organizing test state setup, method invocation, and assertion checks" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The step in the TDD cycle where you clean up code structure without changing behavior while keeping tests passing is ___.",
      "blankAnswer": "refactor",
      "blankDistractors": ["compile", "debug", "deploy"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is Test-Driven Development (TDD) fundamentally recognized by software architects as a *software design discipline* rather than merely a quality-assurance testing activity?",
      "options": [
        { "text": "Writing the unit test before any production code exists forces the software engineer to design the class from the perspective of an external caller, prioritizing API ergonomics, clear parameter types, and observable return values; furthermore, if a proposed design is tightly coupled to concrete databases or global states, writing an isolated unit test for it is immediately awkward and painful; TDD applies immediate negative feedback that compels developers to break dependencies and use interfaces and dependency injection, naturally producing clean, decoupled architectures", "isCorrect": true, "explanation": "Correct! This is Kent Beck and Martin Fowler's central thesis on TDD (Kent Beck *Test-Driven Development: By Example*; Robert C. Martin *Clean Code* Chapter 9). 1. **The Test-Last Tragedy:** - If you write $500\\text{ lines of code}$ first, you will inevitably write code that instantiates concrete SQL databases, reads global static variables, and has huge 100-line private functions. - When you try to write tests afterwards: You realize you CANNOT test it without a live database! You give up and say: *\"This code is untestable.\"* 2. **How TDD Drives Clean Design:** - In TDD, you write: `Calculator calc = new Calculator();` before `Calculator.java` even exists! - You immediately ask: *\"What should this constructor take? What should this method return?\"* - If `Calculator` needs a logger, you are forced to pass `ILogger` into the constructor (Dependency Injection!) because you want to pass a `MockLogger` in the test. 3. **The Result:** TDD prevents tight coupling from ever being written in the first place, acting as an automated architectural guide that enforces SOLID principles naturally!" },
        { "text": "Because TDD allows developers to write code without using an IDE", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because TDD generates automated GUI mockups for marketing teams", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because writing tests first makes compilers compile 10 times faster", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
