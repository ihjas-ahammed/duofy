# Duofy Reusable Lesson Format: Optimization & Control Theory - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to solve KKT constrained optimization systems, execute Gradient Descent steps $x_{k+1} = x_k - \alpha \nabla f(x_k)$, and evaluate Controllability Matrix ranks.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | KKT System Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step KKT Solving Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Lagrange Multiplier Sign Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Optimal Point Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Gradient Step Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**KKT Optimization Problem**\nMinimize $f(x, y) = x^2 + y^2$ subject to inequality constraint $g(x, y) = 1 - x - y \\le 0$.\nLagrangian function: $\\mathcal{L}(x, y, \\lambda) = x^2 + y^2 + \\lambda (1 - x - y)$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Stationarity: $\\frac{\\partial \\mathcal{L}}{\\partial x} = 2x - \\lambda = 0 \\implies x = \\lambda/2$. $\\frac{\\partial \\mathcal{L}}{\\partial y} = 2y - \\lambda = 0 \\implies y = \\lambda/2$.\n• **Step 2:** Complementary slackness: $\\lambda(1 - x - y) = 0$.\n• **Step 3:** Test active constraint $\\lambda > 0 \\implies 1 - x - y = 0 \\implies 1 - \\lambda/2 - \\lambda/2 = 0 \\implies \\lambda = 1$.\n• **Step 4:** Optimal point $(x^*, y^*) = (1/2, 1/2)$. Check dual feasibility $\\lambda = 1 > 0$ OK! Optimal value $f^* = 1/2$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "For a minimization problem with inequality constraint g_i(x) <= 0, the Lagrange multiplier lambda_i must be non-___.",
      "blankAnswer": "negative",
      "blankDistractors": ["positive", "zero", "linear"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Compute $x_1$ after 1 step of Gradient Descent on $f(x) = x^2 - 4x + 4$ starting at $x_0 = 0.0$ with step size $\\alpha = 0.1$.",
      "numericAnswer": 0.4,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Consider LTI system with $A = \\begin{pmatrix} 1 & 0 \\\\ 0 & 2 \\end{pmatrix}$ and $B = \\begin{pmatrix} 0 \\\\ 1 \\end{pmatrix}$. Is this system controllable?",
      "options": [
        { "text": "No! Rank of Controllability matrix [B AB] = 1 < 2 (state x₁ is un-controllable)", "isCorrect": true, "explanation": "Correct! [B AB] = [[0, 0], [1, 2]] has rank 1 < 2." },
        { "text": "Yes, full rank 2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Yes, always", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "No, because A is diagonal", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
