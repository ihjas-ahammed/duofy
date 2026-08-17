# Duofy Reusable Lesson Format: Test Coverage Metrics (Branch Coverage and Mutation Testing)

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Software_Testing_and_Quality_Assurance / Unit_Testing_JUnit_PyTest`  
**Lesson Format Type:** `test_coverage_metrics_branch_coverage_and_mutation_testing`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify test quality evaluation, structural coverage metrics, and fault-injection verification via Mutation Testing (Vladimir Khorikov *Unit Testing* Chapter 1 & 4; Richard DeMillo et al. 1978 Mutation Analysis; Henry Jia & Mark Harman 2011 Mutation Testing Survey): master the mathematical limits of **Line / Statement Coverage vs Branch / Decision Coverage** (proving that 100% Line Coverage fails to test hidden boolean branches, ternary operators, and edge cases), master **Mutation Testing (PIT / Mutmut)** where the mutation engine injects intentional syntactic faults (**Mutants** e.g. replacing `>` with `<`, `+` with `-`, mutating boolean conditions, or deleting void method calls) into production bytecode, evaluate the **Mutation Score ($\mathbf{\text{Score} = \frac{\text{Killed Mutants}}{\text{Total Mutants}} \times 100\%}$)**, prove why surviving mutants expose "Assertion-Free" hollow test suites that achieve 100% line coverage without actually verifying correctness, and interact with live TDD Red-Green-Refactor sandbox, Mock vs Stub visualizer, and Mutation Testing Mutant Killer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Line vs Branch Coverage Limits, Mutation Score $\frac{\text{Killed}}{\text{Total}} \times 100\%$ Formula Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Coverage Metric / Mutation Testing Concept & Technical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why 100% Line Coverage Gives a Dangerous False Sense of Security in Quality Assurance Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | In Mutation Testing, a Test Suite Is Deemed Effective if It Successfully ___ Artificial Mutants (Kills / Eliminates) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Unit Testing Studio: TDD Micro-Loop, Mock Verification & Mutation Killer Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "test_coverage_metrics_branch_coverage_and_mutation_testing",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "Why is 100% Line Coverage insufficient, and how does Mutation Testing evaluate test effectiveness?",
      "blankAnswer": "Test Coverage & Mutation Testing (Khorikov 2020; DeMillo 1978): (1) LINE COVERAGE FLAW: Measures only which lines of code were executed during a test run. A test suite can achieve 100% line coverage with ZERO assertions simply by executing methods! (2) BRANCH COVERAGE: Measures whether all possible outcomes (true/false) of every decision point were tested. (3) MUTATION TESTING (PIT / Mutmut): The ultimate test of test quality. Injects intentional syntactic bugs ('Mutants') into production code (e.g. changes 'x > 0' to 'x >= 0', replaces '+' with '-', deletes function calls). (4) KILLED VS SURVIVED MUTANTS: If a unit test fails after a bug is injected, the mutant is KILLED (Test is effective!). If all tests still pass despite the bug, the mutant SURVIVED (Test suite has blind spots!). Mutation Score = Killed Mutants / Total Mutants * 100%."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Testing Quality Metric to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Statement / Line Coverage", "right": "Measures percentage of source code lines traversed at least once during test execution" },
        { "left": "Branch / Decision Coverage", "right": "Verifies that both true and false paths of every conditional expression were evaluated" },
        { "left": "Killed Mutant", "right": "Injected code bug detected by an automated test suite causing at least one test to fail" },
        { "left": "Survived Mutant", "right": "Injected code bug that went completely undetected because test assertions were missing or weak" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does mandating a strict 100% Line Coverage metric often create a dangerous false sense of security in enterprise software development?",
      "options": [
        { "text": "Line coverage only verifies that a line of code was executed by the CPU; it does NOT verify whether the test actually asserted the correctness of the result; developers can easily achieve 100% line coverage by executing functions without writing any assert statements ('Assertion-Free Testing'); furthermore, line coverage fails to verify implicit edge cases, missing null checks, and complex boolean branch combinations that cause real production outages", "isCorrect": true, "explanation": "Correct! This is Vladimir Khorikov and Martin Fowler's primary critique of vanity code coverage metrics (Vladimir Khorikov *Unit Testing: Principles, Practices, and Patterns* Chapter 1). 1. **The 'Hollow Test' (Zero Assertions):** - Consider this test: ```java @Test void testProcessOrder() { OrderProcessor p = new OrderProcessor(); p.process(new Order()); // Executes 100% of lines! // Zero assert statements! } ``` - Jacoco or Coverage.py reports: **100% Line Coverage!** - Management thinks the code is bug-free. In reality, the test asserts NOTHING and will pass even if the order calculation produces negative millions! 2. **The Mutation Testing Revelation:** - Run PIT (Mutation Testing) on that codebase: - PIT mutates `total = price * 1.10` to `total = 0.0`. - The test STILL PASSES! - PIT reports: **0% Mutation Score (All mutants survived!)**. - The test suite is exposed as useless. 3. **The Lesson:** Good testing is about **assertion density and behavioral verification**, not raw line counts." },
        { "text": "Because 100% line coverage makes computer code run 10 times slower in production", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because line coverage tools only work on Python 2 scripts", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because line coverage deletes all comments from source code files", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Mutation Testing, an injected artificial bug that is successfully detected and failed by a unit test is said to be ___.",
      "blankAnswer": "killed",
      "blankDistractors": ["compiled", "survived", "escaped"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Unit Testing Studio: TDD Loop & Mutation Killer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Unit Testing & Mutation Studio</h3><p>Production Code: <b style=\"color:#38bdf8;\">DiscountCalculator.apply(price, isVip)</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnTdd\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. TDD Red-Green Cycle</button><button id=\"btnCov\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Evaluate Line Coverage</button><button id=\"btnMut\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Run Mutation Testing (PIT)</button></div><div id=\"unitLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to execute TDD cycle...</div><script>document.getElementById('btnTdd').onclick=()=>{document.getElementById('unitLog').innerHTML='<b>1. TDD RED-GREEN-REFACTOR:</b><br>• [RED] testVipDiscount() failed with AssertionError<br>• [GREEN] Implemented price * 0.80 &rarr; Test Passed!<br>• [REFACTOR] Cleaned helper methods; all tests 100% green!';}; document.getElementById('btnCov').onclick=()=>{document.getElementById('unitLog').innerHTML='<b>2. CODE COVERAGE ANALYSIS:</b><br>• Line Coverage: <b style=\"color:#10b981;\">100% (12/12 lines traversed)</b><br>• Branch Coverage: <b style=\"color:#f59e0b;\">75% (Missing isVip=false edge case!)</b>';}; document.getElementById('btnMut').onclick=()=>{document.getElementById('unitLog').innerHTML='<b>3. MUTATION TESTING (PIT):</b><br>• Injected Mutant 1: Replaced (price * 0.8) with (price * 1.0) &rarr; <b style=\"color:#10b981;\">KILLED!</b><br>• Injected Mutant 2: Changed (price > 100) to (price >= 100) &rarr; <b style=\"color:#ef4444;\">SURVIVED!</b><br>• Added boundary test for price=100 &rarr; <b style=\"color:#10b981;\">Mutant 2 KILLED!</b><br>🏆 <b style=\"color:#10b981;\">Mutation Score: 100% (High-Assurance Test Suite!)</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
