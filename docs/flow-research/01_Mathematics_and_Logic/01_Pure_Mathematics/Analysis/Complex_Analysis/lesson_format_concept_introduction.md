# Duofy Reusable Lesson Format: Complex Analysis - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Holomorphic functions $f(z) = u(x,y) + i v(x,y)$, Cauchy-Riemann equations, Conformal mappings, and Singularity classifications (Removable, Pole of order $k$, Essential).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Holomorphic Function & C-R Equations | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Angle-Preserving Conformal Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Singularity Classification Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | C-R Partial Derivative Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Essential Singularity Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Holomorphic Function & Cauchy-Riemann Equations**\nA function $f(z) = u(x,y) + i v(x,y)$ is **holomorphic** on a domain $\\Omega \\subseteq \\mathbb{C}$ if $u$ and $v$ have continuous partial derivatives satisfying:\n$$\n\\frac{\\partial u}{\\partial x} = \\frac{\\partial v}{\\partial y} \\quad \\text{and} \\quad \\frac{\\partial u}{\\partial y} = -\\frac{\\partial v}{\\partial x}\n$$\nHolomorphic functions are automatically $C^\\infty$ and analytic."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Conformal Geometry:** Complex differentiation $f'(z_0) \\neq 0$ acts as local rotation + uniform scaling, preserving angles between curves.\n• **Harmonic Components:** Both $u(x,y)$ and $v(x,y)$ satisfy Laplace's equation $\\nabla^2 u = 0$ and $\\nabla^2 v = 0$.\n• **Analyticity:** Every holomorphic function equals its Laurent series $f(z) = \\sum_{n=-\\infty}^\\infty a_n (z - z_0)^n$.\n• **Residue:** Coefficient $a_{-1}$ of $\\frac{1}{z - z_0}$ in the Laurent expansion."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each singularity type to its Laurent series expansion characteristic.",
      "matchPairs": [
        { "left": "Removable Singularity", "right": "No negative powers of (z - z0) in Laurent series" },
        { "left": "Pole of Order k", "right": "Finitely many negative powers up to 1 / (z - z0)^k" },
        { "left": "Essential Singularity", "right": "Infinitely many negative powers of (z - z0)" },
        { "left": "Residue Res(f, z0)", "right": "Coefficient a_(-1) of 1 / (z - z0)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "By the Cauchy-Riemann equations, the partial derivative du/dx must equal ___.",
      "blankAnswer": "dv/dy",
      "blankDistractors": ["-dv/dy", "du/dy", "dv/dx"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What does Casorati-Weierstrass Theorem state about the behavior of $f(z)$ near an essential singularity $z_0$?",
      "options": [
        { "text": "The image of any small neighborhood around z0 is dense in the complex plane C", "isCorrect": true, "explanation": "Correct! f(z) comes arbitrarily close to every complex value near an essential singularity." },
        { "text": "f(z) approaches infinity", "isCorrect": false, "explanation": "Incorrect: That characterizes a pole." },
        { "text": "f(z) is bounded", "isCorrect": false, "explanation": "Incorrect: That characterizes a removable singularity." },
        { "text": "f(z) = 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
