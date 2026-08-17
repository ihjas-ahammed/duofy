# Duofy Reusable Lesson Format: Test Doubles Taxonomy (Dummy, Stub, Spy, Mock, and Fake)

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Software_Testing_and_Quality_Assurance / Unit_Testing_JUnit_PyTest`  
**Lesson Format Type:** `test_doubles_taxonomy_dummy_stub_spy_mock_and_fake`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the 5-fold taxonomy of test doubles, state vs behavior verification, and dependency isolation under the xUnit framework (Gerard Meszaros 2007, *xUnit Test Patterns: Refactoring Test Code*, Addison-Wesley; Martin Fowler *Mocks Aren't Stubs*; Vladimir Khorikov *Unit Testing* Chapter 5): master the definitive distinctions across **Gerard Meszaros' 5 Test Doubles** (**1. Dummy:** objects passed around solely to satisfy parameter lists that are never invoked; **2. Stub:** provides canned answers to queries made by the SUT, used for **State Verification**; **3. Spy:** a stub that records telemetry on how it was invoked e.g. call counts and arguments; **4. Mock:** pre-programmed with strict expectations to verify interactions, used for **Behavioral Verification** e.g. `verify(service, times(1)).charge()`; **5. Fake:** a working, lightweight implementation taking shortcuts unsuitable for production e.g. an in-memory `HashMap` database), and evaluate why over-mocking internal implementation details creates brittle tests that break during refactoring.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gerard Meszaros 5-Fold Test Double Taxonomy Matrix (Dummy, Stub, Spy, Mock, Fake) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Configuration & Execution of a Unit Test Using a Mock vs a Stub Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Test Double Category / Verification Mode & Exact Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | A Working In-Memory Implementation Taking Shortcuts Unsuitable for Production Is a ___ (Fake) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Mocking Internal Implementation Details Causes Brittle Tests Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Test Doubles (Meszaros 2007; Fowler *Mocks Aren't Stubs*):
   - **The 5 Test Doubles Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Test Double} & \textbf{Internal Logic?} & \textbf{Verification Target} & \textbf{Primary Use Case} \\
     \hline
     \mathbf{\text{Dummy}} & \text{None (empty / null)} & \text{None} & \text{Satisfying compiler parameter lists} \\
     \mathbf{\text{Stub}} & \mathbf{\text{Canned hardcoded values}} & \mathbf{\text{State Verification}} & \text{Providing mock inputs to SUT} \\
     \mathbf{\text{Spy}} & \text{Canned values + recording} & \text{State / Telemetry} & \text{Counting invocations / args} \\
     \mathbf{\text{Mock}} & \mathbf{\text{Pre-programmed expectations}} & \mathbf{\text{Behavior Verification}} & \mathbf{\text{Asserting method call interactions}} \\
     \mathbf{\text{Fake}} & \mathbf{\text{Real working logic (Shortcut)}} & \text{State Verification} & \mathbf{\text{In-memory repository / Fast cache}} \\
     \hline
     \end{array}$$
   - **State vs Behavior Verification:**
     - State: `assertEquals(50.0, order.getTotal())`.
     - Behavior: `verify(emailService, times(1)).sendEmail(any())`.
2. **Slide 2 (`ordering`):** Provide 5 steps of using a Mock: (1) instantiate Mock object using mocking framework (e.g. Mockito.mock(PaymentGateway.class)), (2) configure stubbing: when(gateway.charge(any())).thenReturn(true), (3) pass mock into constructor of System Under Test (SUT), (4) invoke target business method orderProcessor.process(order), (5) verify interaction expectations: verify(gateway, times(1)).charge(100.0) and assert order status is PAID!
3. **Slide 3 (`matching`):** Pair 4 test doubles (Dummy, Stub, Mock, Fake) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Fake. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on over-mocking causing brittle tests: Why does extensively verifying internal private method calls and helper interactions using Mocks (Behavior Verification) lead to brittle unit tests, and why is State Verification generally preferred for business logic? (Mocks test *HOW* a class accomplishes a task rather than *WHAT* result it produces; **when a developer refactors the internal implementation of a class (e.g. optimizing a database query or combining two internal helpers) without changing external behavior or output, mock expectations fail immediately, producing false-positive test failures; state verification tests observable outputs, allowing free refactoring without breaking tests**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "test_doubles_taxonomy_dummy_stub_spy_mock_and_fake",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Gerard Meszaros' Test Double Taxonomy (Meszaros *xUnit Patterns* 2007)**\n• **The 5-Fold Test Double Taxonomy:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Test Double} & \\textbf{Internal Implementation} & \\textbf{Verification Strategy} & \\textbf{Practical Example} \\\\\n\\hline\n\\mathbf{\\text{Dummy}} & \\text{None (Empty strings / nulls)} & \\text{None (Unused)} & \\text{Passing unused } \\texttt{null} \\text{ user token} \\\\\n\\mathbf{\\text{Stub}} & \\mathbf{\\text{Canned hardcoded responses}} & \\mathbf{\\text{State Verification}} & \\texttt{when(repo.get(1)).thenReturn(user)} \\\\\n\\mathbf{\\text{Spy}} & \\text{Canned logic + Call Recording} & \\text{State / Telemetry} & \\text{Verifies } \\texttt{spy.getEmailCount() == 1} \\\\\n\\mathbf{\\text{Mock}} & \\mathbf{\\text{Pre-programmed expectations}} & \\mathbf{\\text{Behavior Verification}} & \\mathbf{\\texttt{verify(gateway, times(1)).charge()}} \\\\\n\\mathbf{\\text{Fake}} & \\mathbf{\\text{Real working shortcut logic}} & \\mathbf{\\text{State Verification}} & \\mathbf{\\texttt{InMemoryHashMapDatabase}} \\\\\n\\hline\n\\end{array}\n$$\n• **The State vs Behavior Invariant:**\n  - **State Verification (Stubs/Fakes):** Verifies the **final outcome / return value**.\n  - **Behavior Verification (Mocks):** Verifies the **exact sequence of calls made**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed when conducting a unit test using a Mock for behavioral verification.",
      "orderItems": [
        "Instantiate a Mock object representing an external dependency using a framework (e.g. Mockito.mock(PaymentGateway.class))",
        "Define stubbing rules for the mock (e.g. when(gateway.charge(anyDouble())).thenReturn(true))",
        "Inject the mock into the System Under Test (SUT) via constructor dependency injection",
        "Execute the target business operation (e.g. orderProcessor.checkout(order))",
        "Execute behavioral verification (e.g. verify(gateway, times(1)).charge(100.0)) and assert final order state is PAID"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Test Double to its exact Technical Definition.",
      "matchPairs": [
        { "left": "Dummy Object", "right": "Passed solely to satisfy parameter lists; its methods are never invoked during the test" },
        { "left": "Test Stub", "right": "Returns canned, hardcoded responses to SUT queries without validating how calls occurred" },
        { "left": "Test Mock", "right": "Configured with strict expectations to verify that specific interaction protocols occurred" },
        { "left": "Test Fake", "right": "Working lightweight implementation (e.g. in-memory hash table) unsuitable for production" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A working in-memory implementation taking shortcuts unsuitable for production is a ___.",
      "blankAnswer": "fake",
      "blankDistractors": ["mock", "stub", "dummy"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does over-relying on Mocks to verify internal class interactions and intermediate method calls create brittle unit tests that impede codebase refactoring?",
      "options": [
        { "text": "Mocks verify the internal implementation details of HOW a class accomplishes a task rather than WHAT observable outcome or state it produces; when a developer performs a valid internal refactoring (such as combining two helper queries or restructuring internal loops) without changing external behavior or outputs, the mock's strict call expectations fail, generating false-positive test breakages that make developers afraid to refactor legacy code; State Verification using Stubs or Fakes tests only public observable outputs, allowing internal code to be freely refactored without breaking tests", "isCorrect": true, "explanation": "Correct! This is Martin Fowler and Vladimir Khorikov's central argument regarding unit test maintainability (Martin Fowler *Mocks Aren't Stubs*; Vladimir Khorikov *Unit Testing: Principles, Practices, and Patterns* Chapter 5). 1. **The Over-Mocking Trap:** - You have an `OrderService.checkout()` method. - Inside, it calls `repo.findUser()`, `repo.updateUser()`, `calc.getTax()`, and `calc.getDiscount()`. - If you mock everything with Mockito: ```java verify(repo, times(1)).findUser(1); verify(repo, times(1)).updateUser(any()); verify(calc, times(1)).getTax(any()); ``` 2. **What Happens During Refactoring:** - An engineer decides to optimize the query by combining `findUser` and `updateUser` into a single atomic call `repo.findAndUpdate()`. - The system works $100\\%$ correctly and faster! - BUT THE UNIT TEST FAILS because `findUser()` was not called! 3. **The Lesson:** - Tests tied to implementation details are **brittle** and resist refactoring. - Test the **public contract and observable state** (State Verification). Use Mocks only at architectural system boundaries (like external third-party payment gateways or email services)." },
        { "text": "Because Mocks can only be used in C++ and not Java", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Mocking frameworks delete source code files when tests fail", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Mocks increase compilation time by 10 hours", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
