# Duofy Reusable Lesson Format: Inner Product Spaces - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Linear_Algebra_and_Matrix_Theory / Inner_Product_Spaces`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Inner Products $\langle \mathbf{u}, \mathbf{v} \rangle$, Norms $\|\mathbf{v}\| = \sqrt{\langle \mathbf{v}, \mathbf{v} \rangle}$, Angles, Orthogonality ($\langle \mathbf{u}, \mathbf{v} \rangle = 0$), and Orthogonal Projections.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Inner Product Definition & Axioms | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Geometry & Norm Mental Model Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Inner Product Axiom Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Key Orthogonality Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Cauchy-Schwarz Discrimination Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Inner Product Space**\nAn inner product on a vector space $V$ over $\\mathbb{R}$ is a function $\\langle \\cdot, \\cdot \\rangle : V \\times V \\to \\mathbb{R}$ satisfying:\n1. **Positivity & Definiteness:** $\\langle \\mathbf{v}, \\mathbf{v} \\rangle \\ge 0$ and $\\langle \\mathbf{v}, \\mathbf{v} \\rangle = 0 \\iff \\mathbf{v} = \\mathbf{0}$.\n2. **Linearity in First Slot:** $\\langle a\\mathbf{u} + b\\mathbf{v}, \\mathbf{w} \\rangle = a\\langle \\mathbf{u}, \\mathbf{w} \\rangle + b\\langle \\mathbf{v}, \\mathbf{w} \\rangle$.\n3. **Symmetry:** $\\langle \\mathbf{u}, \\mathbf{v} \\rangle = \\langle \\mathbf{v}, \\mathbf{u} \\rangle$.\nInduced norm: $\|\\mathbf{v}\| = \\sqrt{\\langle \\mathbf{v}, \\mathbf{v} \\rangle}$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Generalizing Dot Products:** Inner products extend vector geometry (length, angle) to function spaces $L^2[a,b]$.\n• **Orthogonality:** Two vectors $\\mathbf{u}, \\mathbf{v}$ are orthogonal if $\\langle \\mathbf{u}, \\mathbf{v} \\rangle = 0$.\n• **Cauchy-Schwarz Inequality:** $|\\langle \\mathbf{u}, \\mathbf{v} \\rangle| \\le \\|\\mathbf{u}\\| \\|\\mathbf{v}\\|$ for all $\\mathbf{u}, \\mathbf{v} \\in V$.\n• **Orthonormal Basis:** A basis $\\{\\mathbf{e}_1, \\dots, \\mathbf{e}_n\\}$ where $\\langle \\mathbf{e}_i, \\mathbf{e}_j \\rangle = \\delta_{ij}$ (Kronecker delta)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each geometric concept to its inner product formula.",
      "matchPairs": [
        { "left": "Vector Norm ||v||", "right": "sqrt(<v, v>)" },
        { "left": "Orthogonality", "right": "<u, v> = 0" },
        { "left": "Cosine of Angle θ", "right": "<u, v> / (||u|| * ||v||)" },
        { "left": "L2 Function Inner Product", "right": "Integral from a to b of f(x)*g(x) dx" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Two vectors u and v are said to be ___ if their inner product <u, v> is equal to zero.",
      "blankAnswer": "orthogonal",
      "blankDistractors": ["parallel", "linearly dependent", "unit"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "When does equality $|\\langle \\mathbf{u}, \\mathbf{v} \\rangle| = \\|\\mathbf{u}\\| \\|\\mathbf{v}\\|$ hold in the Cauchy-Schwarz Inequality?",
      "options": [
        { "text": "If and only if u and v are linearly dependent (one is a scalar multiple of the other)", "isCorrect": true, "explanation": "Correct! Equality holds strictly when u = c v for scalar c." },
        { "text": "If and only if u and v are orthogonal", "isCorrect": false, "explanation": "Incorrect: If orthogonal, <u, v> = 0." },
        { "text": "For all vectors u and v", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "If and only if ||u|| = 1", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
