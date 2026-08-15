# Duofy Reusable Lesson Format: Numerical Analysis - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to execute Newton-Raphson iterations, perform LU matrix decomposition ($A = L U$), calculate condition numbers $\kappa(A)$, and evaluate Runge-Kutta steps.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Newton Iteration Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Numerical Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | LU Lower Triangular Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Root / Error Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Condition Number Matrix Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Newton-Raphson Root Finding Iteration**\nTo approximate root $f(x) = 0$, update iterate $x_{k+1}$ using gradient tangent line:\n$$\nx_{k+1} = x_k - \\frac{f(x_k)}{f'(x_k)}\n$$\nStop when $|x_{k+1} - x_k| < \\epsilon$ or $|f(x_k)| < \\epsilon$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Find $\\sqrt{5}$ by solving $f(x) = x^2 - 5 = 0$. $f'(x) = 2x$.\n• **Step 2:** Newton formula: $x_{k+1} = x_k - \\frac{x_k^2 - 5}{2 x_k} = \\frac{1}{2}\\left(x_k + \\frac{5}{x_k}\\right)$.\n• **Step 3:** Start with guess $x_0 = 2.0$.\n• **Step 4:** Iteration 1: $x_1 = \\frac{1}{2}(2.0 + 2.5) = 2.25$. Iteration 2: $x_2 = \\frac{1}{2}(2.25 + 5/2.25) = 2.2361$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In LU matrix decomposition A = L U, matrix L is a unit ___ triangular matrix with 1s on its main diagonal.",
      "blankAnswer": "lower",
      "blankDistractors": ["upper", "diagonal", "orthogonal"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the next Newton-Raphson iterate $x_1$ for $f(x) = x^2 - 2$ starting at $x_0 = 1.0$.",
      "numericAnswer": 1.5,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the condition number $\\kappa(A)$ under $L_2$ norm for an orthogonal matrix $Q$ ($Q^T Q = I$)?",
      "options": [
        { "text": "1 (perfectly conditioned matrix)", "isCorrect": true, "explanation": "Correct! ||Q||₂ = 1 and ||Q⁻¹||₂ = 1, so κ₂(Q) = 1." },
        { "text": "0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "infinity", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "2", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
