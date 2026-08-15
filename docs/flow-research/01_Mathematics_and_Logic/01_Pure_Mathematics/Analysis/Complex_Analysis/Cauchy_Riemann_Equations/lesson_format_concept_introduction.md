# Duofy Reusable Lesson Format: Cauchy-Riemann Equations - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis / Cauchy_Riemann_Equations`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the Cauchy-Riemann Equations ($u_x = v_y, u_y = -v_x$) as the necessary and sufficient condition for complex differentiability, connecting the algebraic equations to conformal mapping and Wirtinger derivatives $\frac{\partial f}{\partial \bar{z}} = 0$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cauchy-Riemann Equations Formal Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Conformal Jacobian Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Derivative Formulation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Partial Derivative Condition Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Complex Differentiability Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Cauchy-Riemann equations for $f(z) = u(x, y) + i v(x, y)$: $u_x = v_y$ and $u_y = -v_x$, and the derivative formula $f'(z) = u_x + i v_x$.
2. **Slide 2 (`concept_pieces`):** Deconstruct direction independence, conformal scaling/rotation Jacobian, Laplace harmonic equation $\Delta u = 0$, and Wirtinger $\partial f / \partial \bar{z} = 0$.
3. **Slide 3 (`matching`):** Pair 4 equations (Cartesian C-R, Polar C-R, Wirtinger condition, Jacobian determinant) with their mathematical expressions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that $u_y = -v_x$. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking why $f(z) = \bar{z}$ fails to be complex differentiable anywhere.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: The Cauchy-Riemann Equations**\nLet $f(z) = u(x, y) + i v(x, y)$ be defined on an open domain in $\\mathbb{C}$.\n$f$ is **complex differentiable** (holomorphic) at $z = x + iy$ if and only if $u$ and $v$ have continuous first partial derivatives and satisfy:\n$$\n\\frac{\\partial u}{\\partial x} = \\frac{\\partial v}{\\partial y} \\quad \\text{and} \\quad \\frac{\\partial u}{\\partial y} = -\\frac{\\partial v}{\\partial x}\n$$\nThe complex derivative is given by $f'(z) = u_x + i v_x = v_y - i u_y$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Direction Independence:** Limits approaching $z_0$ along the real axis ($\\Delta x \\to 0$) and imaginary axis ($i \\Delta y \\to 0$) must agree, directly yielding $u_x + iv_x = -i u_y + v_y$.\n• **Conformal Map (Amplitwist):** The Jacobian matrix $J = \\begin{pmatrix} u_x & -v_x \\\\ v_x & u_x \\end{pmatrix}$ represents a uniform scaling by $|f'(z)|$ and rotation by $\\arg(f'(z))$.\n• **Harmonic Functions:** Differentiating again shows $u_{xx} + u_{yy} = 0$ (Laplace's equation $\\nabla^2 u = 0$).\n• **Wirtinger Form:** Complex differentiability is compactly expressed as $\\frac{\\partial f}{\\partial \\bar{z}} = 0$ ($f$ does not depend on $\\bar{z}$)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each complex analysis formula to its definition.",
      "matchPairs": [
        { "left": "u_x = v_y and u_y = -v_x", "right": "Cartesian Cauchy-Riemann Equations" },
        { "left": "u_r = (1/r) v_theta and v_r = -(1/r) u_theta", "right": "Polar Cauchy-Riemann Equations" },
        { "left": "df / d(z_bar) = 0", "right": "Wirtinger Holomorphicity Condition" },
        { "left": "det(J_f) = (u_x)^2 + (v_x)^2", "right": "Jacobian Determinant |f'(z)|^2" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "According to the Cauchy-Riemann equations, the partial derivative u_y must equal the negative of ___.",
      "blankAnswer": "v_x",
      "blankDistractors": ["v_y", "u_x", "u_y"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the complex conjugation function f(z) = z_bar = x - i y NOT complex differentiable anywhere in C?",
      "options": [
        { "text": "u_x = 1 and v_y = -1, violating u_x = v_y (df/dz_bar = 1 != 0)", "isCorrect": true, "explanation": "Correct! Since u_x = 1 != -1 = v_y, the Cauchy-Riemann equations fail everywhere." },
        { "text": "Because z_bar is not continuous", "isCorrect": false, "explanation": "Incorrect: z_bar is continuous everywhere on C." },
        { "text": "Because z_bar has a pole at 0", "isCorrect": false, "explanation": "Incorrect: z_bar has no singularities." },
        { "text": "Because z_bar is real-valued", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
