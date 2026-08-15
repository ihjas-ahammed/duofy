# Duofy Reusable Lesson Format: Differential Equations - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Differential_Equations_ODEs_and_PDEs`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Ordinary Differential Equations (ODEs), Matrix Exponents $e^{A t}$, and the Three Canonical Partial Differential Equations (PDEs): Elliptic, Parabolic, and Hyperbolic.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | PDE Classification & Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Three Canonicals Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | PDE Classification Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Matrix Exponential Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Propagation Speed Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: The Three Canonical Second-Order PDEs**\nFor second-order PDE $A u_{xx} + B u_{xy} + C u_{yy} + \\dots = 0$, classify via discriminant $\\Delta = B^2 - 4AC$:\n$$\n1.\\ \\text{Elliptic (}\\Delta < 0\\text{): Laplace } \\Delta u = 0 \\quad 2.\\ \\text{Parabolic (}\\Delta = 0\\text{): Heat } u_t = \\Delta u \\quad 3.\\ \\text{Hyperbolic (}\\Delta > 0\\text{): Wave } u_{tt} = c^2 \\Delta u\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Elliptic (Laplace Eq):** Models steady-state equilibrium; solutions are smooth harmonic functions satisfying Mean Value Property.\n• **Parabolic (Heat Eq):** Models thermal diffusion; infinite speed of propagation, smooths out sharp initial conditions over time.\n• **Hyperbolic (Wave Eq):** Models wave propagation; finite speed of propagation $c$, preserves sharp wave profile along characteristics $x \\pm c t$.\n• **Linear ODE System:** $\\dot{\\mathbf{x}} = A \\mathbf{x}$ has unique global solution $\\mathbf{x}(t) = e^{A t} \\mathbf{x}(0)$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each canonical PDE to its physical phenomenon and characteristic behavior.",
      "matchPairs": [
        { "left": "Heat Equation (u_t = u_xx)", "right": "Parabolic (Diffusion, Infinite speed of propagation)" },
        { "left": "Wave Equation (u_tt = c^2 u_xx)", "right": "Hyperbolic (Wave propagation, Finite speed c)" },
        { "left": "Laplace Equation (u_xx + u_yy = 0)", "right": "Elliptic (Steady-state equilibrium, Harmonic functions)" },
        { "left": "Linear System x' = A x", "right": "ODE System (Solution x(t) = e^(At) x_0)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The matrix exponential solution to linear ODE system dx/dt = A x is given by x(t) = ___ * x(0).",
      "blankAnswer": "e^(At)",
      "blankDistractors": ["A * t", "sin(At)", "det(A)"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is d'Alembert's formula for the solution of the 1D Wave Equation $u_{tt} = c^2 u_{xx}$ with initial displacement $u(x,0) = g(x)$ and velocity $u_t(x,0) = 0$?",
      "options": [
        { "text": "u(x, t) = (1/2) [g(x - c t) + g(x + c t)]", "isCorrect": true, "explanation": "Correct! Initial wave splits into two counter-propagating waves of half amplitude." },
        { "text": "u(x, t) = g(x) e^(-c t)", "isCorrect": false, "explanation": "Incorrect: That describes exponential decay." },
        { "text": "u(x, t) = g(x) cos(c t)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "u(x, t) = 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
