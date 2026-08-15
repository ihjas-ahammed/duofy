# Duofy Reusable Lesson Format: Canonical Forms - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Linear_Algebra_and_Matrix_Theory / Canonical_Forms_Jordan_and_Rational`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to determine Jordan Canonical Forms from polynomial data, construct Companion Matrices $C(p(x))$, and compute Jordan chains for non-diagonalizable matrices.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Companion Matrix & JCF Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Block Determination Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Companion Matrix Entry Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Jordan Block Count Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Rational vs Jordan Form Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Companion Matrix $C(p(x))$**\nFor a monic polynomial $p(x) = x^n + a_{n-1}x^{n-1} + \\dots + a_1 x + a_0$, its **Companion Matrix** is:\n$$\nC(p(x)) = \\begin{pmatrix} 0 & 0 & \\dots & 0 & -a_0 \\\\ 1 & 0 & \\dots & 0 & -a_1 \\\\ 0 & 1 & \\dots & 0 & -a_2 \\\\ \\vdots & \\vdots & \\ddots & \\vdots & \\vdots \\\\ 0 & 0 & \\dots & 1 & -a_{n-1} \\end{pmatrix}\n$$\nIts characteristic and minimal polynomials both equal $p(x)$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Given $A \\in M_5(\\mathbb{C})$ with $p(x) = (x - 3)^5$ and $m(x) = (x - 3)^3$.\n• **Step 2:** Largest Jordan block has size 3: $J_3(3)$.\n• **Step 3:** Remaining size $5 - 3 = 2$ must be partitioned into blocks of size $\\le 3$.\n• **Step 4:** If $\\text{nullity}(A - 3I) = 2$, there are 2 total blocks: $J_3(3) \\oplus J_2(3)$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In the companion matrix C(p(x)) of a polynomial p(x), the negated coefficients -a_i appear in the last ___.",
      "blankAnswer": "column",
      "blankDistractors": ["row", "diagonal", "subdiagonal"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "If a matrix $A$ has $\\text{nullity}(A - 4I) = 3$, how many Jordan blocks corresponding to eigenvalue $\\lambda = 4$ exist in its Jordan form?",
      "numericAnswer": 3.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is Rational Canonical Form preferred over Jordan Canonical Form when working over the field of rational numbers $\\mathbb{Q}$?",
      "options": [
        { "text": "RCF does not require finding roots or splitting polynomials over C", "isCorrect": true, "explanation": "Correct! RCF entries stay strictly inside field F (like Q) without algebraic extensions." },
        { "text": "RCF matrices are always diagonal", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "RCF has no companion matrices", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Q is a finite field", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
