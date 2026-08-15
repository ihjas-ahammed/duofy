# Duofy Reusable Lesson Format: Elliptic, Parabolic, and Hyperbolic PDEs - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Differential_Equations_ODEs_and_PDEs / Elliptic_Parabolic_Hyperbolic_PDEs`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to classify second-order linear PDEs with variable coefficients, find characteristic curves by integrating $\frac{dy}{dx} = \frac{B \pm \sqrt{B^2-4AC}}{2A}$, and reduce hyperbolic equations to their canonical form.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Characteristic Curve ODE Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Characteristic Line Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Discriminant Value Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Wave Speed Evaluation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Canonical Transformation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the characteristic ODE for $A u_{xx} + B u_{xy} + C u_{yy} = 0$: $\frac{dy}{dx} = \frac{B \pm \sqrt{B^2 - 4AC}}{2A}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps of reducing $u_{xx} - 4 u_{yy} = 0$ to canonical form ($A=1, B=0, C=-4 \implies \Delta = 16 > 0$, characteristic ODE $\frac{dy}{dx} = \pm 2 \implies y \mp 2x = \text{const}$, coordinates $\xi = y - 2x, \eta = y + 2x$, canonical form $u_{\xi\eta} = 0$).
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the discriminant $B^2 - 4AC$ determines the number of real characteristic families. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the propagation wave speed $c$ from $u_{tt} - 9 u_{xx} = 0$ ($c = \sqrt{9} = 3.0$).
5. **Slide 5 (`quiz`):** Quiz asking for the classification of the PDE $x u_{xx} + u_{yy} = 0$ across the coordinate axes.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Finding Characteristics and Canonical Forms**\nFor $A u_{xx} + B u_{xy} + C u_{yy} = 0$, the characteristic slopes satisfy:\n$$\n\\frac{dy}{dx} = \\frac{B \\pm \\sqrt{B^2 - 4AC}}{2A}\n$$\nIntegrating $\\frac{dy}{dx}$ yields the characteristic curves $\\xi(x, y) = c_1$ and $\\eta(x, y) = c_2$. Under the transformation $(x, y) \\mapsto (\\xi, \\eta)$, the hyperbolic PDE transforms into:\n$$\nu_{\\xi\\eta} = 0\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Identify Coefficients):** For $u_{xx} - 4 u_{yy} = 0$, $A = 1, B = 0, C = -4$.\n• **Step 2 (Compute Discriminant):** $\\Delta = B^2 - 4AC = 0 - 4(1)(-4) = 16 > 0$ (Hyperbolic everywhere).\n• **Step 3 (Solve Characteristic ODE):** $\\frac{dy}{dx} = \\frac{0 \\pm \\sqrt{16}}{2(1)} = \\pm 2 \\implies y = 2x + c_1$ and $y = -2x + c_2$.\n• **Step 4 (Set Coordinates):** $\\xi = y - 2x$ and $\\eta = y + 2x$. The general solution is $u(x, y) = f(y - 2x) + g(y + 2x)$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The number of distinct families of real characteristic curves of a linear second-order PDE is determined by the algebraic sign of the ___ B^2 - 4AC.",
      "blankAnswer": "discriminant",
      "blankDistractors": ["determinant", "trace", "jacobian"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "What is the propagation wave speed c for the wave equation u_{tt} - 9 u_{xx} = 0?",
      "numericAnswer": 3.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "For the PDE x u_{xx} + u_{yy} = 0, in which region of the xy-plane is the equation elliptic?",
      "options": [
        { "text": "The right half-plane x > 0 (where B^2 - 4AC = -4x < 0)", "isCorrect": true, "explanation": "Correct! When x > 0, -4x < 0, so the equation is elliptic." },
        { "text": "The left half-plane x < 0", "isCorrect": false, "explanation": "Incorrect: When x < 0, -4x > 0, so the equation is hyperbolic." },
        { "text": "Everywhere in the xy-plane", "isCorrect": false, "explanation": "Incorrect: The type changes across the y-axis x = 0." },
        { "text": "Only at the origin (0, 0)", "isCorrect": false, "explanation": "Incorrect: It is parabolic on the entire line x = 0." }
      ]
    }
  ]
}
```
