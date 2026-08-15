# Duofy Reusable Lesson Format: Existence and Uniqueness Theorems - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Differential_Equations_ODEs_and_PDEs / Existence_and_Uniqueness_Theorems`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the fundamental theorems of ODE theory: **Peano's Existence Theorem** (requiring only continuity) and the **Picard-Lindelöf Theorem** (requiring Lipschitz continuity for uniqueness), framing ODEs as integral equations and fixed-point problems.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Picard-Lindelöf Theorem Formal Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Lipschitz vs Continuity Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Theorem & Condition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Fixed Point Operator Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Non-Lipschitz Branching Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Picard-Lindelöf Theorem: If $f(t, y)$ is continuous on rectangle $R$ and satisfies the Lipschitz condition $|f(t, y_1) - f(t, y_2)| \le L |y_1 - y_2|$, then the IVP $y' = f(t, y), y(t_0) = y_0$ has a unique continuous solution on $[t_0 - \delta, t_0 + \delta]$.
2. **Slide 2 (`concept_pieces`):** Deconstruct integral transformation $(Ty)(t) = y_0 + \int_{t_0}^t f(s, y(s))ds$, Lipschitz slope bounding, Peano's existence without uniqueness, and Banach contraction mapping.
3. **Slide 3 (`matching`):** Pair 4 theorems/conditions (Picard-Lindelöf, Peano, Grönwall, Banach fixed point) with their exact mathematical role.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the Picard operator is a contraction on a complete metric space of continuous functions. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking why the IVP $y' = y^{1/3}, y(0) = 0$ has non-unique solutions.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: The Picard-Lindelöf Theorem**\nLet $f(t, y)$ be continuous on a closed rectangle $R = [t_0-a, t_0+a] \\times [y_0-b, y_0+b]$.\nIf $f$ satisfies the **Lipschitz condition** in $y$:\n$$\n|f(t, y_1) - f(t, y_2)| \\le L |y_1 - y_2| \\quad \\text{for all } (t, y_1), (t, y_2) \\in R\n$$\nthen the Initial Value Problem $y' = f(t, y), y(t_0) = y_0$ has a **unique continuous solution** on $[t_0-\\delta, t_0+\\delta]$ for $\\delta = \\min(a, b/M)$ where $M = \\max_R |f|$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Integral Equivalence:** $y'(t) = f(t, y(t)) \\iff y(t) = y_0 + \\int_{t_0}^t f(s, y(s))\\,ds$ (fixed point $y = Ty$).\n• **Peano vs. Picard:** Peano requires only continuity of $f$ (existence guaranteed, but uniqueness may fail). Picard adds Lipschitz continuity to guarantee uniqueness.\n• **Contraction Mapping:** On a sufficiently small interval $[t_0-\\delta, t_0+\\delta]$, the operator $T$ is a contraction on Banach space $C([t_0-\\delta, t_0+\\delta])$.\n• **Continuous Dependence:** Grönwall's inequality ensures solutions depend continuously on initial conditions $y_0$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each ODE theorem to its core mathematical guarantee.",
      "matchPairs": [
        { "left": "Picard-Lindelöf Theorem", "right": "Guarantees existence AND uniqueness under Lipschitz continuity" },
        { "left": "Peano Existence Theorem", "right": "Guarantees existence (uniqueness may fail) under continuity" },
        { "left": "Grönwall's Inequality", "right": "Bounds solution growth and proves uniqueness / stability" },
        { "left": "Banach Fixed-Point Theorem", "right": "Proves convergence of Picard iterations to the unique solution" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Picard integral operator T is proven to be a ___ mapping on the Banach space of continuous functions for small time intervals.",
      "blankAnswer": "contraction",
      "blankDistractors": ["linear", "unbounded", "singular"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the initial value problem y' = y^{1/3}, y(0) = 0 admit multiple distinct solutions for t >= 0?",
      "options": [
        { "text": "f(y) = y^{1/3} is continuous but fails the Lipschitz condition near y = 0 because df/dy = (1/3)y^{-2/3} -> infinity as y -> 0", "isCorrect": true, "explanation": "Correct! Because the derivative blows up at 0, f is not Lipschitz continuous near the initial state, allowing solutions to branch (e.g. y = 0 and y = (2t/3)^{3/2})." },
        { "text": "Because f(y) is discontinuous at y = 0", "isCorrect": false, "explanation": "Incorrect: y^{1/3} is continuous everywhere." },
        { "text": "Because the initial condition y(0) is negative", "isCorrect": false, "explanation": "Incorrect: y(0) = 0." },
        { "text": "Because y' must be constant", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
