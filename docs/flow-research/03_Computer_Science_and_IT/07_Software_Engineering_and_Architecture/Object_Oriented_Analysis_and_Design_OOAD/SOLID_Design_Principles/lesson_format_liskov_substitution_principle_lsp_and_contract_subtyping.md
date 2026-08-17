# Duofy Reusable Lesson Format: Liskov Substitution Principle (LSP and Contract Subtyping)

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Object_Oriented_Analysis_and_Design_OOAD / SOLID_Design_Principles`  
**Lesson Format Type:** `liskov_substitution_principle_lsp_and_contract_subtyping`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through behavioral subtyping, design-by-contract rules, and inheritance hazards under the Liskov Substitution Principle (Barbara Liskov 1987 OOPSLA; Barbara Liskov & Jeannette Wing 1994, *A Behavioral Notion of Subtyping*, ACM TOPLAS; Robert C. Martin *Clean Architecture* Chapter 9): formalize the mathematical definition of strong behavioral subtyping ($\mathbf{\forall x: T, \ \Phi(x) \text{ is true} \implies \forall y: S, \ \Phi(y) \text{ is true where } S <: T}$), master the **3 Contractual Subtyping Invariants** (**1. Preconditions cannot be strengthened in a subtype [$Pre_T \implies Pre_S$]; 2. Postconditions cannot be weakened in a subtype [$Post_S \implies Post_T$]; 3. Supertype Invariants must be strictly preserved**), analyze why mathematical "IS-A" relationships frequently violate software modeling (**The Classic Square-Rectangle Paradox** where setting `setWidth` and `setHeight` independently breaks in a `Square` subclass), and evaluate why subtyping without behavioral compatibility forces fragile `if (obj instanceof Subclass)` type checking anti-patterns.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Liskov Formal Subtyping Definition, Pre/Post Condition Contract Matrix Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Mathematical Refactoring of the Classic Square-Rectangle LSP Violation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | LSP Contract Rule / Subtyping Behavior & Formal Mathematical Constraint Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Under LSP, a Subtype Must NOT Strengthen the Base Type's ___ Conditions (Pre / Preconditions) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Proof: Why 'Square Extends Rectangle' Violates Behavioral Subtyping Contracts Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State LSP (Liskov & Wing 1994; Martin 2017):
   - **The Liskov & Wing Subtyping Theorem:**
     $$\mathbf{\text{Let } \Phi(x) \text{ be a property provable about objects } x \text{ of type } T. \text{ Then } \Phi(y) \text{ should be true for objects } y \text{ of type } S \text{ where } S <: T.}$$
   - **The 3 Behavioral Contract Invariants:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Contract Component} & \textbf{LSP Rule} & \textbf{Mathematical Implication} \\
     \hline
     \mathbf{\text{Preconditions}} & \mathbf{\text{CANNOT be strengthened}} & Pre_T(x) \implies Pre_S(x) \ (\text{Subtype must accept all parent inputs}) \\
     \mathbf{\text{Postconditions}} & \mathbf{\text{CANNOT be weakened}} & Post_S(x) \implies Post_T(x) \ (\text{Subtype must guarantee all parent promises}) \\
     \mathbf{\text{Invariants}} & \mathbf{\text{MUST be preserved}} & Inv_S(x) \land Inv_T(x) \ (\text{Parent state invariants cannot be broken}) \\
     \hline
     \end{array}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of refactoring an LSP violation: (1) discover client code using `if (obj instanceof Square)` checks to handle subclass quirks, (2) recognize that Square mutates both width and height simultaneously, violating Rectangle's independent dimension contract, (3) eliminate `Square extends Rectangle` inheritance hierarchy, (4) declare a common interface `Shape` with a non-mutating `getArea()` method, (5) implement `Rectangle` and `Square` as independent sibling classes implementing `Shape`!
3. **Slide 3 (`matching`):** Pair 4 concepts (Precondition Rule, Postcondition Rule, History Constraint, Square-Rectangle Trap) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Preconditions cannot be strengthened. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the Square-Rectangle paradox: Why does modeling a geometric square as `class Square extends Rectangle` in object-oriented programming violate the Liskov Substitution Principle, even though mathematically a square is a rectangle? (A mathematical square is defined by immutable geometry, but in OOP, a `Rectangle` base class exposes mutable behavior (`setWidth(w)` and `setHeight(h)`) with the postcondition invariant that changing width leaves height unchanged ($h_{\text{after}} = h_{\text{before}}$); **a `Square` subclass overrides `setWidth` to update both width and height to keep sides equal, violating the base class postcondition; any client function expecting a `Rectangle` that sets `r.setWidth(5)` and `r.setHeight(10)` will fail an assertion expecting area 50 when the Square returns 100**, breaking behavioral substitutability).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "liskov_substitution_principle_lsp_and_contract_subtyping",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Liskov Substitution Principle — LSP (Liskov \\& Wing TOPLAS 1994)**\n• **Formal Behavioral Subtyping (Barbara Liskov OOPSLA 1987):**\n$$\n\\mathbf{\\forall x: T, \\ \\Phi(x) \\implies \\forall y: S, \\ \\Phi(y) \\qquad \\text{where } S \\text{ is a subtype of } T \\ (S <: T)}\n$$\n• **The 3 Design-by-Contract Invariants (Bertrand Meyer):**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Contract Dimension} & \\textbf{Subtype Rule} & \\textbf{Formal Behavior} \\\\\n\\hline\n\\mathbf{\\text{Preconditions}} & \\mathbf{\\text{CANNOT be strengthened}} & Pre_T \\implies Pre_S \\ (\\text{Subtype cannot require stricter input constraints}) \\\\\n\\mathbf{\\text{Postconditions}} & \\mathbf{\\text{CANNOT be weakened}} & Post_S \\implies Post_T \\ (\\text{Subtype must deliver equal or stronger guarantees}) \\\\\n\\mathbf{\\text{Invariants}} & \\mathbf{\\text{MUST be preserved}} & \\text{All class state invariants of supertype } T \\text{ remain true} \\\\\n\\hline\n\\end{array}\n$$\n• **The Substitutability Invariant:** Client code must run **correctly when passing ANY subtype without `instanceof` checks**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed to diagnose and resolve an LSP violation using interface abstraction.",
      "orderItems": [
        "Identify code where client functions perform 'if (shape instanceof Square)' checks to work around overridden behavior",
        "Analyze the base class contract to prove that Rectangle guarantees independent mutability of width and height",
        "Prove that Square's overridden setter violates Rectangle's postcondition by unexpectedly mutating both dimensions",
        "Break the inheritance relationship, removing 'Square extends Rectangle' to eliminate the false behavioral assumption",
        "Introduce a shared 'Shape' interface exposing immutable queries (e.g. getArea()) and implement Square and Rectangle as siblings"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Liskov Subtyping Rule to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Precondition Constraint (Pre_T => Pre_S)", "right": "A derived method must accept all parameter ranges that the base method accepts without throwing new validation errors" },
        { "left": "Postcondition Constraint (Post_S => Post_T)", "right": "A derived method must fulfill all return value guarantees and side-effect promises made by the base method" },
        { "left": "The Square-Rectangle Trap", "right": "Classic violation where real-world taxonomic 'IS-A' relationships contradict object-oriented mutable behavior" },
        { "left": "instanceof Type Smell", "right": "Conditional runtime type checking indicating that subclasses are not cleanly substitutable for base abstractions" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Under the Liskov Substitution Principle, a subclass must not strengthen the base class's ___ conditions.",
      "blankAnswer": "pre",
      "blankDistractors": ["post", "side", "exit"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does modeling a geometric square as 'class Square extends Rectangle' in object-oriented programming violate the Liskov Substitution Principle, even though in mathematics a square is genuinely a rectangle?",
      "options": [
        { "text": "In geometry, shapes are immutable concepts, but in object-oriented programming, a Rectangle class typically defines mutable behaviors (setWidth(w) and setHeight(h)) with the implicit contract that changing width preserves the current height (h_after == h_before); a Square subclass must keep width and height equal, so its overridden setWidth() mutates both dimensions, directly violating the Rectangle's contract postcondition; any client algorithm designed for Rectangle that sets width to 5 and height to 10 will fail when Square returns area 100 instead of 50, breaking behavioral substitutability", "isCorrect": true, "explanation": "Correct! This is Robert C. Martin and Barbara Liskov's most famous demonstration of the difference between mathematical subtyping and behavioral object-oriented subtyping (Martin *Clean Architecture* Chapter 9). 1. **The Client Expectation (The Contract):** - Consider a client function: ```java void testRectangle(Rectangle r) { r.setWidth(5); r.setHeight(10); assert(r.getArea() == 50); // MUST ALWAYS BE 50! } ``` 2. **What Happens When You Pass a Square:** - Square inherits from Rectangle. - Inside Square: `setWidth(w)` sets `width = w; height = w;`. - In `testRectangle(Square s)`: - `s.setWidth(5)` $\\implies$ width=5, height=5. - `s.setHeight(10)` $\\implies$ width=10, height=10! - `s.getArea()` returns **100**! - `assert(100 == 50)` $\\implies$ **CRASH! Assertion Failed!** 3. **The Core Law:** - *\"IS-A\" is about BEHAVIOR, not taxonomy.* - A Square does NOT behave like a mutable Rectangle because its dimensions cannot vary independently. - Subtypes must satisfy the **behavioral contracts** of their parents in all client contexts." },
        { "text": "Because Square contains fewer letters than Rectangle", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because subclasses in Java are prohibited from calculating area", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because geometric shapes cannot be compiled by C++ compilers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
