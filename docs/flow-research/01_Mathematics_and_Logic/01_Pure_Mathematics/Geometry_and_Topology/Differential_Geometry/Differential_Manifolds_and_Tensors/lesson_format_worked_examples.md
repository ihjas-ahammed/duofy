# Duofy Reusable Lesson Format: Differential Manifolds and Tensors - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Differential_Geometry / Differential_Manifolds_and_Tensors`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute exterior derivatives $d\omega$ for differential forms in $\mathbb{R}^3$, evaluate pullbacks $\Phi^*(\omega)$ under non-linear coordinate transformations (polar/spherical charts), and calculate line/surface integrals via the Generalized Stokes' Theorem.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | 1-Form Differential Exterior Derivative Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Wedge Product Calculation Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Anti-Symmetric Wedge Permutation Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Boundary Line Integral Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Lie Bracket Vector Field Commutator Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the problem: Compute $d\omega$ for the 1-form $\omega = (x^2 y)\,dx + (x z)\,dy + (y^2 z)\,dz$ on $\mathbb{R}^3$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) $d((x^2 y)dx) = (2xy dx + x^2 dy) \wedge dx = -x^2 dx \wedge dy$, (2) $d((xz)dy) = (z dx + x dz) \wedge dy = z dx \wedge dy - x dy \wedge dz$, (3) $d((y^2 z)dz) = (2yz dy + y^2 dz) \wedge dz = 2yz dy \wedge dz$, (4) sum together: $d\omega = (z - x^2) dx \wedge dy + (2yz - x) dy \wedge dz$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that swapping two 1-forms in a wedge product introduces a minus sign due to anti-symmetry ($dy \wedge dx = -dx \wedge dy$). Plain text only.
4. **Slide 4 (`numerical`):** Ask student to evaluate the line integral $\oint_{\partial D} (x dy - y dx)$ around unit circle $D = \{x^2 + y^2 \le 1\}$ using Stokes' theorem: $\int_D d(x dy - y dx) = \int_D 2 dx dy = 2 \pi (1)^2 \approx 6.28318$ (answer 6.28).
5. **Slide 5 (`quiz`):** Quiz computing the Lie bracket $[X, Y]$ for $X = x \frac{\partial}{\partial y}$ and $Y = y \frac{\partial}{\partial x}$: $[X, Y] = x \frac{\partial}{\partial x} - y \frac{\partial}{\partial y}$.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Computing the Exterior Derivative $d\\omega$ in $\\mathbb{R}^3$**\nLet $\\omega = (x^2 y)\\,dx + (x z)\\,dy + (y^2 z)\\,dz$ be a 1-form on $\\mathbb{R}^3$.\nThe exterior derivative is computed by taking total differentials and wedging with the basis differentials:\n$$\nd\\omega = d(x^2 y) \\wedge dx + d(x z) \\wedge dy + d(y^2 z) \\wedge dz\n$$\nRecall the anti-symmetry relation: $dx^i \\wedge dx^j = -dx^j \\wedge dx^i$, and $dx^i \\wedge dx^i = 0$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (First Term):** $d(x^2 y \\, dx) = (2xy\\,dx + x^2\\,dy) \\wedge dx = 0 - x^2\\,dx \\wedge dy$.\n• **Step 2 (Second Term):** $d(xz\\,dy) = (z\\,dx + x\\,dz) \\wedge dy = z\\,dx \\wedge dy - x\\,dy \\wedge dz$.\n• **Step 3 (Third Term):** $d(y^2 z\\,dz) = (2yz\\,dy + y^2\\,dz) \\wedge dz = 2yz\\,dy \\wedge dz + 0$.\n• **Step 4 (Collect Terms):**\n  $$d\\omega = (z - x^2)\\,dx \\wedge dy + (2yz - x)\\,dy \\wedge dz + 0\\,dz \\wedge dx$$"
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "Interchanging the order of two differential 1-forms in a wedge product alters the result by a factor of ___ one.",
      "blankAnswer": "minus",
      "blankDistractors": ["plus", "zero", "two"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Using Stokes' Theorem, compute the line integral oint_{d D} (x dy - y dx) around the unit circle d D = S^1 bounding disk D of radius 1 (to two decimal places).",
      "numericAnswer": 6.28,
      "numericTolerance": 0.02
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "For the vector fields X = x d/dy and Y = y d/dx in R^2, what is their Lie bracket [X, Y]?",
      "options": [
        { "text": "[X, Y] = x d/dx - y d/dy", "isCorrect": true, "explanation": "Correct! [X, Y](f) = x d/dy(y df/dx) - y d/dx(x df/dy) = x(df/dx + y d^2f/dydx) - y(df/dy + x d^2f/dxdy) = x df/dx - y df/dy." },
        { "text": "[X, Y] = 0", "isCorrect": false, "explanation": "Incorrect: The flows do not commute." },
        { "text": "[X, Y] = x d/dy + y d/dx", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "[X, Y] = xy (d^2 / dx dy)", "isCorrect": false, "explanation": "Incorrect: The Lie bracket of two first-order derivations is always a first-order derivation." }
      ]
    }
  ]
}
```
