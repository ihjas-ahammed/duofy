# Duofy Reusable Lesson Format: Eigenvalues & Eigenvectors - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Linear_Algebra_and_Matrix_Theory / Eigenvalues_and_Eigenvectors`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Eigenvalues $\lambda$, Eigenvectors $\mathbf{v}$, Characteristic Polynomials $\det(A - \lambda I) = 0$, Eigenspaces $E_\lambda$, and Diagonalization $A = P D P^{-1}$ using invariant transformation axis mental models.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Eigenvalue Equation & Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Geometric Axis & Scaling Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Matrix Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Characteristic Polynomial Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Diagonalizability Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Eigenvalue & Eigenvector**\nLet $A$ be an $n \\times n$ matrix. A non-zero vector $\\mathbf{v} \\in \\mathbb{R}^n$ is an **eigenvector** of $A$ if there exists a scalar $\\lambda$ such that:\n$$\nA \\mathbf{v} = \\lambda \\mathbf{v}, \\quad \\mathbf{v} \\neq \\mathbf{0}\n$$\nThe scalar $\\lambda$ is called the **eigenvalue** corresponding to $\\mathbf{v}$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Geometric Intuition:** Eigenvectors define axes where the transformation $A$ simply stretches or shrinks space without rotating the vector direction.\n• **Characteristic Polynomial:** Eigenvalues are the roots of $\\det(A - \\lambda I) = 0$.\n• **Eigenspace $E_\\lambda$:** The nullspace $N(A - \\lambda I)$ containing all eigenvectors for a given eigenvalue $\\lambda$.\n• **Diagonalization ($A = P D P^{-1}$):** $D$ contains eigenvalues on its diagonal, and columns of $P$ are the corresponding linearly independent eigenvectors."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each matrix property to its eigenvalue shortcut.",
      "matchPairs": [
        { "left": "Sum of Eigenvalues", "right": "Trace of matrix A (sum of diagonal entries)" },
        { "left": "Product of Eigenvalues", "right": "Determinant det(A)" },
        { "left": "Eigenvalues of A^k", "right": "lambda^k" },
        { "left": "Eigenvalues of Real Symmetric Matrix", "right": "Always real numbers (orthogonally diagonalizable)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Eigenvalues of a matrix A are found by setting the determinant det(A - lambda * I) equal to ___.",
      "blankAnswer": "zero",
      "blankDistractors": ["one", "trace", "identity"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "If $\\det(A) = 0$, what does this guarantee about the eigenvalues of $A$?",
      "options": [
        { "text": "At least one eigenvalue λ is equal to 0", "isCorrect": true, "explanation": "Correct! Since product of eigenvalues equals det(A), det(A) = 0 implies at least one λ = 0." },
        { "text": "All eigenvalues are equal to 1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A is diagonalizable", "isCorrect": false, "explanation": "Incorrect: Singular matrices may or may not be diagonalizable." },
        { "text": "All eigenvalues are complex numbers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
