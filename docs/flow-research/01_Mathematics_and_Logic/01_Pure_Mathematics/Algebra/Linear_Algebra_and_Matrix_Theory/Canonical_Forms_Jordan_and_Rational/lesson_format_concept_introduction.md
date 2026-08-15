# Duofy Reusable Lesson Format: Canonical Forms - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Linear_Algebra_and_Matrix_Theory / Canonical_Forms_Jordan_and_Rational`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce non-diagonalizable matrix representations: Jordan Canonical Form (JCF), Jordan Blocks $J_k(\lambda)$, Rational Canonical Form (RCF), and Companion Matrices $C(p(x))$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Jordan Block & Form Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Block Structure & Multiplicity Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | JCF vs RCF Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Generalized Eigenvector Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Jordan Block Size Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Jordan Block $J_k(\\lambda)$**\nA Jordan block of size $k$ with eigenvalue $\\lambda$ is a $k \\times k$ upper triangular matrix with $\\lambda$ on the main diagonal and 1s on the superdiagonal:\n$$\nJ_k(\\lambda) = \\begin{pmatrix} \\lambda & 1 & 0 & \\dots & 0 \\\\ 0 & \\lambda & 1 & \\dots & 0 \\\\ \\vdots & \\vdots & \\ddots & \\ddots & \\vdots \\\\ 0 & 0 & 0 & \\dots & \\lambda \\end{pmatrix}\n$$\nJordan Canonical Form $J$ is a block diagonal matrix of Jordan blocks."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Number of Blocks:** Total number of Jordan blocks for $\\lambda$ equals geometric multiplicity $\\text{nullity}(A - \\lambda I)$.\n• **Largest Block Size:** Size of largest block for $\\lambda$ equals the exponent of $(x - \\lambda)$ in minimal polynomial $m(x)$.\n• **Sum of Block Sizes:** Total size of all blocks for $\\lambda$ equals algebraic multiplicity in characteristic polynomial $p(x)$.\n• **Rational Canonical Form:** Uses companion matrices of invariant factors; works over ANY field without requiring roots."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each canonical form term to its structural rule.",
      "matchPairs": [
        { "left": "Number of Jordan Blocks for λ", "right": "Geometric Multiplicity = nullity(A - λ I)" },
        { "left": "Size of Largest Jordan Block", "right": "Exponent of (x - λ) in Minimal Polynomial m(x)" },
        { "left": "Sum of all Block Sizes for λ", "right": "Algebraic Multiplicity in Characteristic Polynomial p(x)" },
        { "left": "Companion Matrix C(p(x))", "right": "Block with coefficients of p(x) in last column/row" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Vectors v in the kernel of (A - lambda * I)^k for k > 1 are called ___ eigenvectors.",
      "blankAnswer": "generalized",
      "blankDistractors": ["orthogonal", "singular", "invariant"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A $4 \\times 4$ matrix $A$ has characteristic polynomial $p(x) = (x - 2)^4$ and minimal polynomial $m(x) = (x - 2)^2$. If $\\text{nullity}(A - 2I) = 2$, what are the sizes of its Jordan blocks?",
      "options": [
        { "text": "Two blocks of size 2 × 2", "isCorrect": true, "explanation": "Correct! 2 blocks (nullity=2), max size 2 (exponent in m(x)=2), sum of sizes = 4." },
        { "text": "One block of size 4 × 4", "isCorrect": false, "explanation": "Incorrect: That would require nullity = 1 and m(x) = (x-2)⁴." },
        { "text": "Four blocks of size 1 × 1", "isCorrect": false, "explanation": "Incorrect: That would mean A is diagonalizable with m(x) = (x-2)." },
        { "text": "One block of 3 × 3 and one of 1 × 1", "isCorrect": false, "explanation": "Incorrect: Max block size would be 3." }
      ]
    }
  ]
}
```
