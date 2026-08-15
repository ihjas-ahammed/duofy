# Duofy Reusable Lesson Format: Differential Equations - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Differential_Equations_ODEs_and_PDEs`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute matrix exponentials $e^{A t} = P e^{D t} P^{-1}$, solve first-order quasilinear PDEs using Method of Characteristics, and evaluate d'Alembert wave solutions.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Characteristic Curve Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Characteristic Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Characteristic ODE Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Wave Speed / Value Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Matrix Exponential Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Method of Characteristics for First-Order PDE**\nTo solve $a(x, y) u_x + b(x, y) u_y = c(x, y, u)$, parameterize characteristic curves $(x(s), y(s), z(s))$ via Lagrange-Charpit ODEs:\n$$\n\\frac{dx}{ds} = a(x, y), \\quad \\frac{dy}{ds} = b(x, y), \\quad \\frac{dz}{ds} = c(x, y, z)\n$$\nwhere $z(s) = u(x(s), y(s))$ along the characteristic curve."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Solve $u_x + 2 u_y = 0$ with $u(x, 0) = x^2$.\n• **Step 2:** Characteristic ODEs: $\\frac{dx}{dt} = 1, \\frac{dy}{dt} = 2, \\frac{du}{dt} = 0$.\n• **Step 3:** Integrate: $x = t + x_0, y = 2t$. Eliminate parameter $t = y/2 \\implies x_0 = x - y/2$.\n• **Step 4:** Since $\\frac{du}{dt} = 0$, $u$ is constant along characteristic: $u(x,y) = u(x_0, 0) = x_0^2 = (x - y/2)^2$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "Along characteristic curves of a first-order homogenous PDE a u_x + b u_y = 0, the solution u is ___.",
      "blankAnswer": "constant",
      "blankDistractors": ["zero", "exponential", "unbounded"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate $u(2, 1)$ for the wave solution $u(x,t) = \\frac{1}{2}[(x - 3t)^2 + (x + 3t)^2]$.",
      "numericAnswer": 13.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "If $A = \\begin{pmatrix} 2 & 0 \\\\ 0 & 5 \\end{pmatrix}$, what is the matrix exponential $e^{A t}$?",
      "options": [
        { "text": "diag(e^(2t), e^(5t))", "isCorrect": true, "explanation": "Correct! For a diagonal matrix, e^(At) exponentiates diagonal entries directly." },
        { "text": "diag(2t, 5t)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "diag(e^2, e^5)", "isCorrect": false, "explanation": "Incorrect: Missing time parameter t." },
        { "text": "A * t", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
