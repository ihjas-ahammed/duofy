# Duofy Reusable Lesson Format: Algebraic Geometry - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Algebraic_Geometry`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute Gröbner bases using Buchberger's Algorithm, determine radical ideals $\sqrt{I}$, evaluate projective curve intersections, and check singularity smoothness using Jacobian criteria.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Buchberger / Gröbner Basis Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step S-Polynomial Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Leading Term Reduction Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Intersection Count Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Singular Point Jacobian Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**S-Polynomial and Buchberger's Criterion**\nFor polynomials $f, g \\in k[x_1, \\dots, x_n]$ under monomial order $>$, the **S-polynomial** is:\n$$\nS(f, g) = \\frac{m}{\\text{LT}(f)} f - \\frac{m}{\\text{LT}(g)} g, \\quad m = \\text{LCM}(\\text{LM}(f), \\text{LM}(g))\n$$\nA set $G = \\{g_1, \\dots, g_t\\}$ is a Gröbner basis iff $S(g_i, g_j) \\to_G 0$ for all $i \\neq j$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Let $f_1 = x^2 y - 1, f_2 = x y^2 - x$ under lexicographic order $x > y$.\n• **Step 3:** $\\text{LT}(f_1) = x^2 y, \\text{LT}(f_2) = x y^2$. LCM $m = x^2 y^2$.\n• **Step 3:** $S(f_1, f_2) = y (x^2 y - 1) - x (x y^2 - x) = -y + x^2 = x^2 - y$.\n• **Step 4:** Reduce $x^2 - y$ by $f_1, f_2$. Remainder $x^2 - y \\neq 0$, so add $f_3 = x^2 - y$ to basis!"
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In Buchberger's algorithm, a set of polynomials forms a Gröbner basis if and only if all S-polynomials reduce to ___ modulo G.",
      "blankAnswer": "zero",
      "blankDistractors": ["one", "monomials", "degree"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "According to Bézout's Theorem, how many intersection points (with multiplicity) do two generic plane curves of degree $d_1 = 3$ and $d_2 = 4$ have in $\\mathbb{P}^2_{\\mathbb{C}}$?",
      "numericAnswer": 12.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Using the Jacobian Criterion, when is a point $p = (x_0, y_0)$ a **singular point** of a plane curve $f(x, y) = 0$?",
      "options": [
        { "text": "When f(p) = 0, ∂f/∂x(p) = 0, and ∂f/∂y(p) = 0 simultaneously", "isCorrect": true, "explanation": "Correct! A point is singular if all partial derivatives vanish at p." },
        { "text": "When ∂f/∂x(p) = 1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "When f(p) > 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "When degree of f is 1", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
