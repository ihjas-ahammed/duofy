# Duofy Reusable Lesson Format: Numerical Analysis - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Condition Numbers $\kappa(A) = \|A\| \|A^{-1}\|$, Numerical Stability, Newton-Raphson Root Finding ($x_{k+1} = x_k - \frac{f(x_k)}{f'(x_k)}$), and Lax Equivalence Theorem.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Condition Number & Stability Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Convergence & Root Finding Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Numerical Method Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Newton Iteration Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Ill-Conditioned Matrix Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Condition Number & Lax Equivalence**\n1. **Condition Number $\\kappa(A)$:** For a linear system $A \\mathbf{x} = \\mathbf{b}$:\n$$\n\\kappa(A) = \\|A\\| \\|A^{-1}\\| \\ge 1, \\quad \\frac{\\|\\delta \\mathbf{x}\\|}{\\|\\mathbf{x}\\|} \\le \\kappa(A) \\frac{\\|\\delta \\mathbf{b}\\|}{\\|\\mathbf{b}\\|}\n$$\n2. **Lax Equivalence Theorem:** For a well-posed linear initial value PDE problem, a consistent finite difference scheme is **convergent** if and only if it is **stable**."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Newton-Raphson Method:** Quadratically convergent root-finding algorithm: $x_{k+1} = x_k - \\frac{f(x_k)}{f'(x_k)}$.\n• **Conditioning vs Stability:** Conditioning is a property of the *problem*; stability is a property of the *algorithm*.\n• **Stiffness:** Differential equations where explicit integrators require impractically small step sizes $\\Delta t$ for stability, requiring implicit methods (e.g. Backward Euler).\n• **Order of Accuracy:** Truncation error $E(h) = O(h^p)$ where $p$ is the convergence order."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each numerical algorithm to its convergence rate or purpose.",
      "matchPairs": [
        { "left": "Newton-Raphson Method", "right": "Quadratic convergence order p = 2" },
        { "left": "Bisection Method", "right": "Linear convergence order p = 1 (guaranteed convergence)" },
        { "left": "Runge-Kutta 4th Order (RK4)", "right": "Fourth-order accurate ODE solver O(h^4)" },
        { "left": "Conjugate Gradient Method", "right": "Iterative solver for symmetric positive-definite linear systems" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Newton-Raphson root finding exhibits ___ convergence speed near a simple root.",
      "blankAnswer": "quadratic",
      "blankDistractors": ["linear", "exponential", "cubic"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What occurs when solving a linear system $A \\mathbf{x} = \\mathbf{b}$ with a very large condition number $\\kappa(A) = 10^8$ using floating-point arithmetic?",
      "options": [
        { "text": "Small round-off errors in b can be magnified by up to 10^8 in the solution x (ill-conditioned system)", "isCorrect": true, "explanation": "Correct! Large condition numbers indicate extreme sensitivity to perturbations." },
        { "text": "The algorithm executes in 0 steps", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The solution is exact", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Determinant det(A) = 1", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
