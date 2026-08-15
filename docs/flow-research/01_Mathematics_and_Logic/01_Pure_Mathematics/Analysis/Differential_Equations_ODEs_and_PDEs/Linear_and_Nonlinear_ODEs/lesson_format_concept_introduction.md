# Duofy Reusable Lesson Format: Linear and Nonlinear ODEs - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Differential_Equations_ODEs_and_PDEs / Linear_and_Nonlinear_ODEs`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Phase Plane Analysis for planar autonomous systems $\dot{x} = f(x, y), \dot{y} = g(x, y)$, Jacobian linearization at equilibrium points $(x^*, y^*)$, and the Trace-Determinant classification of fixed points.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Autonomous System & Jacobian Linearization | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Trace-Determinant Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Fixed Point & Eigenvalue Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Saddle Point Condition Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Equilibrium Stability Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the general 2D autonomous ODE system and its Jacobian linearization $J = \begin{pmatrix} f_x & f_y \\ g_x & g_y \end{pmatrix}$ with characteristic equation $\lambda^2 - \tau \lambda + \Delta = 0$ ($\tau = \text{Tr}(J), \Delta = \det(J)$).
2. **Slide 2 (`concept_pieces`):** Deconstruct Saddle ($\Delta < 0$), Stable Node/Spiral ($\Delta > 0, \tau < 0$), Unstable Node/Spiral ($\Delta > 0, \tau > 0$), and Center ($\tau = 0, \Delta > 0$).
3. **Slide 3 (`matching`):** Pair 4 fixed point types (Saddle, Stable Spiral, Unstable Node, Center) with their $(\tau, \Delta)$ conditions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that a negative determinant $\Delta < 0$ always produces a saddle point. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking to classify the fixed point of $\dot{x} = -x + y, \dot{y} = -2x - 3y$ at $(0, 0)$.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Linearization of Autonomous Systems**\nFor a 2D autonomous system $\\dot{x} = f(x, y), \\dot{y} = g(x, y)$ with equilibrium point $(x^*, y^*)$ where $f(x^*, y^*) = g(x^*, y^*) = 0$:\nThe **Jacobian matrix** is:\n$$\nJ = \\begin{pmatrix} f_x(x^*, y^*) & f_y(x^*, y^*) \\\\ g_x(x^*, y^*) & g_y(x^*, y^*) \\end{pmatrix}\n$$\nThe eigenvalues satisfy $\\lambda^2 - \\tau \\lambda + \\Delta = 0$, where $\\tau = \\text{Tr}(J)$ and $\\Delta = \\det(J)$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Saddle Point ($\\Delta < 0$):** Real eigenvalues of opposite signs ($\\lambda_1 < 0 < \\lambda_2$). Always unstable.\n• **Stable Node / Focus ($\\Delta > 0, \\tau < 0$):** Real negative or complex conjugate with negative real part $\\text{Re}(\\lambda) < 0$. Trajectories converge to fixed point.\n• **Unstable Node / Focus ($\\Delta > 0, \\tau > 0$):** Eigenvalues with positive real parts. Trajectories diverge outward.\n• **Center ($\\tau = 0, \\Delta > 0$):** Pure imaginary eigenvalues $\\lambda = \\pm i \\omega$. Closed concentric orbits (neutral stability)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each fixed point classification to its trace-determinant signature.",
      "matchPairs": [
        { "left": "Saddle Point", "right": "det(J) < 0 (real eigenvalues of opposite sign)" },
        { "left": "Stable Spiral / Focus", "right": "det(J) > 0, Tr(J) < 0, and (Tr J)^2 - 4 det(J) < 0" },
        { "left": "Center", "right": "Tr(J) = 0 and det(J) > 0 (pure imaginary eigenvalues)" },
        { "left": "Unstable Node", "right": "det(J) > 0, Tr(J) > 0, and (Tr J)^2 - 4 det(J) > 0" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a 2D planar system, an equilibrium point whose Jacobian has a strictly negative determinant is always a ___ point.",
      "blankAnswer": "saddle",
      "blankDistractors": ["center", "spiral", "node"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Classify the equilibrium point at (0, 0) for the system: dx/dt = -x + y, dy/dt = -2x - 3y.",
      "options": [
        { "text": "Stable Node / Focus (Tr(J) = -4 < 0, det(J) = 5 > 0)", "isCorrect": true, "explanation": "Correct! J = [[-1, 1], [-2, -3]], Tr(J) = -4, det(J) = (-1)(-3) - (1)(-2) = 5 > 0. Since Tr < 0 and det > 0, the origin is asymptotically stable." },
        { "text": "Saddle Point", "isCorrect": false, "explanation": "Incorrect: det(J) = 5 > 0, so it cannot be a saddle." },
        { "text": "Unstable Spiral", "isCorrect": false, "explanation": "Incorrect: Tr(J) = -4 < 0, so solutions converge rather than diverge." },
        { "text": "Center", "isCorrect": false, "explanation": "Incorrect: Tr(J) = -4 != 0." }
      ]
    }
  ]
}
```
