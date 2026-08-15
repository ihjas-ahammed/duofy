# Duofy Reusable Lesson Format: Vector Spaces & Subspaces - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Linear_Algebra_and_Matrix_Theory / Vector_Spaces_and_Subspaces`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Vector Spaces $V$, Subspaces $W \subseteq V$, Linear Independence, Span, Basis, and Dimension using Strang's 4 Fundamental Subspaces geometric mental model.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Subspace & Axiomatic Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Geometric Intuition & Span Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Fundamental Subspaces Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Subspace Condition Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Subspace Verification Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Vector Subspace ($W \\subseteq V$)**\nA non-empty subset $W$ of a vector space $V$ over field $F$ is a **subspace** if $W$ is closed under vector addition and scalar multiplication:\n$$\n1.\\ \\mathbf{0} \\in W \\quad 2.\\ \\mathbf{u} + \\mathbf{v} \\in W \\quad 3.\\ c \\mathbf{u} \\in W \\quad (\\forall \\mathbf{u}, \\mathbf{v} \\in W, c \\in F)\n$$\nEquivalently, $c_1 \\mathbf{u} + c_2 \\mathbf{v} \\in W$ for all scalars $c_1, c_2 \\in F$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Span:** The set of all possible linear combinations $c_1 \\mathbf{v}_1 + \\dots + c_k \\mathbf{v}_k$.\n• **Linear Independence:** No vector in the set can be written as a linear combination of the others.\n• **Basis:** A linearly independent set of vectors that spans the entire space $V$.\n• **Dimension:** The unique number of vectors in any basis of $V$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each fundamental matrix subspace to its definition.",
      "matchPairs": [
        { "left": "Column Space C(A)", "right": "Span of the columns of A in R^m" },
        { "left": "Nullspace N(A)", "right": "Set of all vectors x such that A * x = 0 in R^n" },
        { "left": "Row Space C(A^T)", "right": "Span of the rows of A in R^n" },
        { "left": "Left Nullspace N(A^T)", "right": "Set of all vectors y such that A^T * y = 0 in R^m" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A minimal spanning set of vectors that is linearly independent is called a ___.",
      "blankAnswer": "basis",
      "blankDistractors": ["span", "matrix", "kernel"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Which of the following subsets of $\\mathbb{R}^2$ is a valid vector subspace?",
      "options": [
        { "text": "The line y = 3x passing through the origin (0,0)", "isCorrect": true, "explanation": "Correct! Contains (0,0) and is closed under addition and scalar multiplication." },
        { "text": "The line y = 3x + 1", "isCorrect": false, "explanation": "Incorrect: Does not contain the origin (0,0)." },
        { "text": "The first quadrant x ≥ 0, y ≥ 0", "isCorrect": false, "explanation": "Incorrect: Not closed under negative scalar multiplication." },
        { "text": "The unit circle x² + y² = 1", "isCorrect": false, "explanation": "Incorrect: Not closed under addition or scalar multiplication." }
      ]
    }
  ]
}
```
