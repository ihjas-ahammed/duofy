# Duofy Reusable Lesson Format: Vector Spaces & Subspaces - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Linear_Algebra_and_Matrix_Theory / Vector_Spaces_and_Subspaces`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute Row Reduced Echelon Form (RREF), extract basis vectors for Column Space $C(A)$ and Nullspace $N(A)$, and verify linear independence step-by-step.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | RREF & Basis Algorithm Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step RREF Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Pivot Column Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Nullity / Rank Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Matrix Rank Edge-Case Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Finding Basis for Nullspace $N(A)$**\nTo find a basis for $N(A)$, solve $A \\mathbf{x} = \\mathbf{0}$ by row-reducing $A$ to RREF:\n$$\n\\text{RREF}(A) = \\begin{pmatrix} 1 & 0 & c_1 \\\\ 0 & 1 & c_2 \\end{pmatrix}\n$$\nPivot columns correspond to basic variables; non-pivot columns correspond to free variables."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Consider $A = \\begin{pmatrix} 1 & 2 & 3 \\\\ 2 & 4 & 6 \\end{pmatrix}$. Row reduce $R_2 \\leftarrow R_2 - 2R_1$.\n• **Step 2:** $\\text{RREF}(A) = \\begin{pmatrix} 1 & 2 & 3 \\\\ 0 & 0 & 0 \\end{pmatrix}$. Pivot is column 1 ($x_1$).\n• **Step 3:** Free variables are $x_2, x_3$. Equation: $x_1 + 2x_2 + 3x_3 = 0 \\implies x_1 = -2x_2 - 3x_3$.\n• **Step 4:** Vector form $\\mathbf{x} = x_2 \\begin{pmatrix} -2 \\\\ 1 \\\\ 0 \\end{pmatrix} + x_3 \\begin{pmatrix} -3 \\\\ 0 \\\\ 1 \\end{pmatrix}$. Nullity = 2."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "To form a basis for Column Space C(A), select the original columns of A that correspond to ___ columns in RREF(A).",
      "blankAnswer": "pivot",
      "blankDistractors": ["free", "zero", "last"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the rank of matrix $A = \\begin{pmatrix} 1 & 2 & 0 \\\\ 0 & 1 & 3 \\\\ 0 & 0 & 0 \\end{pmatrix}$.",
      "numericAnswer": 2.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "If $A$ is a $3 \\times 3$ matrix with $\\text{Rank}(A) = 3$, what is its nullspace $N(A)$?",
      "options": [
        { "text": "The zero vector space {0}", "isCorrect": true, "explanation": "Correct! Full rank implies Nullity = 3 - 3 = 0, so N(A) = {0}." },
        { "text": "R^3", "isCorrect": false, "explanation": "Incorrect: That would mean Nullity = 3." },
        { "text": "A line through origin", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A plane through origin", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
