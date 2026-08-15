# Duofy Reusable Lesson Format: Eigenvalues & Eigenvectors - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Linear_Algebra_and_Matrix_Theory / Eigenvalues_and_Eigenvectors`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute characteristic equations $\det(A - \lambda I) = 0$, calculate eigenvalues $\lambda_i$, find eigenspaces $N(A - \lambda I)$, and construct $P$ and $D$ for matrix diagonalization.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Characteristic Equation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Worked Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Eigenspace Nullspace Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Eigenvalue / Trace Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Non-Diagonalizable Matrix Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Characteristic Polynomial for $2 \\times 2$ Matrix**\nFor $A = \\begin{pmatrix} a & b \\\\ c & d \\end{pmatrix}$, the characteristic equation simplifies to:\n$$\n\\lambda^2 - \\text{Trace}(A) \\lambda + \\det(A) = 0\n$$\nwhere $\\text{Trace}(A) = a + d$ and $\\det(A) = ad - bc$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Consider $A = \\begin{pmatrix} 4 & 1 \\\\ 2 & 3 \\end{pmatrix}$. $\\text{Trace}(A) = 7, \\det(A) = 12 - 2 = 10$.\n• **Step 2:** Characteristic equation: $\\lambda^2 - 7\\lambda + 10 = 0$.\n• **Step 3:** Factor: $(\\lambda - 5)(\\lambda - 2) = 0 \\implies \\lambda_1 = 5, \\lambda_2 = 2$.\n• **Step 4:** Eigenspace for $\\lambda = 5$: $(A - 5I)\\mathbf{v} = \\mathbf{0} \\implies \\begin{pmatrix} -1 & 1 \\\\ 2 & -2 \\end{pmatrix}\\mathbf{v} = \\mathbf{0} \\implies \\mathbf{v}_1 = \\begin{pmatrix} 1 \\\\ 1 \\end{pmatrix}$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "To find eigenvectors for eigenvalue lambda, we solve for the nullspace of matrix A minus lambda times ___.",
      "blankAnswer": "identity",
      "blankDistractors": ["trace", "transpose", "inverse"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "What is the trace of matrix $A = \\begin{pmatrix} 3 & 7 \\\\ 1 & 8 \\end{pmatrix}$?",
      "numericAnswer": 11.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the shear matrix $S = \\begin{pmatrix} 1 & 1 \\\\ 0 & 1 \\end{pmatrix}$ NOT diagonalizable?",
      "options": [
        { "text": "It has repeated eigenvalue λ = 1 but only 1 linearly independent eigenvector (deficient eigenspace)", "isCorrect": true, "explanation": "Correct! Geometric multiplicity (dim E₁) = 1 < 2 algebraic multiplicity." },
        { "text": "Because det(S) = 0", "isCorrect": false, "explanation": "Incorrect: det(S) = 1." },
        { "text": "Because trace is zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because it has negative eigenvalues", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
