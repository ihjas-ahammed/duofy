# Duofy Reusable Lesson Format: Isoperimetric Problems and Dido's Theorem

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Optimal_Control_and_Calculus_of_Variations / Euler_Lagrange_Equations`  
**Lesson Format Type:** `isoperimetric_problems_and_dido_theorem`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to formulate and solve **Isoperimetric Problems** (Integral-constrained variational problems: $\min J[y] = \int L dx$ subject to $K[y] = \int G dx = C_0$), apply the **Augmented Variational Lagrangian** $L^* = L + \lambda G$, solve **Queen Dido's Maximum Area Problem** (circular arc), and prove the classical **Isoperimetric Inequality** ($4\pi A \le L^2$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Isoperimetric Problem & Variational Multipliers Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Dido Circle Derivation Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Variational Constraint Type & Multiplier Setup Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical Isoperimetric Maximum Area Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Isoperimetric Inequality Equality Geometry Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Isoperimetric Variational Problem: Maximize or minimize functional $J[y] = \int_{x_1}^{x_2} f(x, y, y') dx$ subject to the integral constraint $K[y] = \int_{x_1}^{x_2} g(x, y, y') dx = C_0$. State Euler's Multiplier Rule: Extremals satisfy the unconstrained Euler-Lagrange equation for the augmented Lagrangian $L^*(x, y, y') = f(x, y, y') + \lambda g(x, y, y')$: $\frac{d}{dx}\left(\frac{\partial L^*}{\partial y'}\right) - \frac{\partial L^*}{\partial y} = 0$, where constant $\lambda$ is chosen to satisfy the constraint $K[y] = C_0$.
2. **Slide 2 (`concept_pieces`):** Deconstruct Queen Dido's problem (maximizing area $A = \int y dx$ for fixed arc length $L = \int \sqrt{1 + y'^2} dx$ with $y(0) = y(a) = 0$): (1) set $L^* = y + \lambda \sqrt{1 + y'^2}$, (2) compute partials: $\frac{\partial L^*}{\partial y} = 1, \frac{\partial L^*}{\partial y'} = \frac{\lambda y'}{\sqrt{1 + y'^2}}$, (3) Euler-Lagrange: $\frac{d}{dx}\left(\frac{\lambda y'}{\sqrt{1 + y'^2}}\right) = 1$, (4) integrate with respect to $x$: $\frac{\lambda y'}{\sqrt{1 + y'^2}} = x - x_0$, (5) integrate again to obtain the exact circular arc equation $(x - x_0)^2 + (y - y_0)^2 = \lambda^2 = R^2$!
3. **Slide 3 (`matching`):** Pair 4 variational problems with constraints (Isoperimetric Integral Constraint, Holonomic Algebraic Constraint, Differential Equation Non-Holonomic Constraint, Fixed Boundary Constraint) with their appropriate multiplier representations.
4. **Slide 4 (`numerical`):** Ask student: For a fixed perimeter $L = 20.0 \text{ m}$, what is the maximum possible area $A_{\max} = \frac{L^2}{4\pi}$ that can be enclosed in a plane (using $\pi = 3.1416$)? $A = 400 / (4 \times 3.1416) = 400 / 12.5664 \approx 31.83$ (numeric answer: 31.83).
5. **Slide 5 (`quiz`):** Quiz on the classical Isoperimetric Inequality $4\pi A \le L^2$: When does equality hold strictly in the 2D plane? (Equality $4\pi A = L^2$ holds if and only if the enclosing planar curve is a perfect circle).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "isoperimetric_problems_and_dido_theorem",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Isoperimetric Problems and Variational Lagrange Multipliers**\n• **Isoperimetric Problem:** Optimize a functional $J[y]$ subject to an **integral constraint** $K[y] = C_0$:\n$$\n\\operatorname{ext} \\int_{x_1}^{x_2} f(x, y, y') \\, dx \\quad \\text{subject to} \\quad \\int_{x_1}^{x_2} g(x, y, y') \\, dx = C_0\n$$\n• **Euler's Multiplier Rule:** Construct the **augmented Lagrangian** $L^* = f + \\lambda g$ (where constant $\\lambda \\in \\mathbb{R}$ is the variational multiplier):\n$$\n\\frac{d}{dx}\\left( \\frac{\\partial L^*}{\\partial y'} \\right) - \\frac{\\partial L^*}{\\partial y} = 0\n$$\n• **The Isoperimetric Inequality in 2D:** For any simple closed curve of length $L$ enclosing area $A$:\n$$\n4 \\pi A \\le L^2 \\quad (\\text{Equality } 4\\pi A = L^2 \\iff \\text{the curve is a Circle})\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Queen Dido's Maximum Area Problem:** Maximize $A = \\int y \\, dx$ subject to fixed perimeter $L = \\int \\sqrt{1 + y'^2} \\, dx$.\n• **Step 1 (Augmented Lagrangian):** $L^* = y + \\lambda \\sqrt{1 + y'^2}$.\n• **Step 2 (Euler-Lagrange):** $\\frac{\\partial L^*}{\\partial y} = 1$ and $\\frac{\\partial L^*}{\\partial y'} = \\frac{\\lambda y'}{\\sqrt{1 + y'^2}}$, yielding:\n  $$\\frac{d}{dx}\\left( \\frac{\\lambda y'}{\\sqrt{1 + y'^2}} \\right) = 1$$\n• **Step 3 (First Integral):** $\\frac{\\lambda y'}{\\sqrt{1 + y'^2}} = x - x_0$.\n• **Step 4 (Second Integral):** Solving for $y'$ and integrating directly gives the **Circle**:\n  $$(x - x_0)^2 + (y - y_0)^2 = \\lambda^2 = R^2$$\n  (A circular arc encloses maximum area!)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each constrained variational problem to its multiplier formulation.",
      "matchPairs": [
        { "left": "Isoperimetric Constraint (int g(x, y, y') dx = C)", "right": "L* = f + lambda * g (constant scalar multiplier lambda in R)" },
        { "left": "Finite Holonomic Constraint (phi(x, y) = 0)", "right": "L* = f + lambda(x) * phi (spatially-varying multiplier function lambda(x))" },
        { "left": "Dynamic ODE Constraint (y' = f(x, y, u))", "right": "Pontryagin Hamiltonian H = L + p^T f (costate adjoint vector p(t))" },
        { "left": "Unconstrained Variational Problem", "right": "Standard Euler-Lagrange equation with lambda = 0" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "For a closed planar curve of fixed total perimeter L = 20.0 meters, calculate the maximum possible enclosed area A = L^2 / (4 pi) in square meters to two decimal places.",
      "numericAnswer": 31.83,
      "numericTolerance": 0.05
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In the classical Isoperimetric Inequality 4 pi A <= L^2 for planar geometric shapes, what shape strictly achieves the theoretical upper bound equality 4 pi A = L^2?",
      "options": [
        { "text": "A perfect CIRCLE (which maximizes area per unit perimeter by having uniform constant curvature kappa = 1/R everywhere)", "isCorrect": true, "explanation": "Correct! The circle has A = pi R^2 and L = 2 pi R, giving 4 pi (pi R^2) = 4 pi^2 R^2 = (2 pi R)^2 = L^2, strictly maximizing enclosed area." },
        { "text": "A square", "isCorrect": false, "explanation": "Incorrect: A square has 4 pi A = 4 pi (L/4)^2 = (pi/4) L^2 approx 0.785 L^2 < L^2." },
        { "text": "An equilateral triangle", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "An ellipse of high eccentricity", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
