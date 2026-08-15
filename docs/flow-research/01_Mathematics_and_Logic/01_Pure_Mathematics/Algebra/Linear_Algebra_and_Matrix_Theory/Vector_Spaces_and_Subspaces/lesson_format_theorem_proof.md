# Duofy Reusable Lesson Format: Vector Spaces & Subspaces - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Linear_Algebra_and_Matrix_Theory / Vector_Spaces_and_Subspaces`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through foundational theorems in Linear Algebra, specifically the Rank-Nullity Theorem ($\text{rank}(A) + \text{nullity}(A) = n$) and the Orthogonal Complement Orthogonality Proofs ($N(A) = C(A^T)^\perp$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Rank-Nullity Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Proof Strategy & Pivot Column Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Free Variable & Pivot Column Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Derivation Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Nullity Dimension Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The Rank-Nullity Theorem**\nLet $T: V \\to W$ be a linear transformation from an $n$-dimensional vector space $V$ into $W$.\n$$\n\\text{dim}(\\text{Range}(T)) + \\text{dim}(\\text{Kernel}(T)) = \\text{dim}(V)\n$$\nFor an $m \\times n$ matrix $A$, $\\text{Rank}(A) + \\text{Nullity}(A) = n$ (number of columns)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove the Rank-Nullity Theorem.",
      "orderItems": [
        "Let {u_1, ..., u_k} be a basis for the Nullspace Kernel(T) of dimension k.",
        "Extend this linearly independent set to a basis {u_1, ..., u_k, v_1, ..., v_r} of V of dimension n = k + r.",
        "Apply transformation T to obtain set {T(v_1), ..., T(v_r)} in W.",
        "Prove that {T(v_1), ..., T(v_r)} is linearly independent and spans Range(T).",
        "Conclude dim(Range(T)) = r = n - k, so dim(Range) + dim(Kernel) = n."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In Row Reduced Echelon Form (RREF) of an $m \\times n$ matrix, what do free variables correspond to?",
      "options": [
        { "text": "Basis vectors of the Nullspace N(A)", "isCorrect": true, "explanation": "Correct! Each free variable corresponds to a parameter in the general solution to Ax = 0." },
        { "text": "Basis vectors of Column space C(A)", "isCorrect": false, "explanation": "Incorrect: Pivot columns correspond to Column space." },
        { "text": "Determinant of A", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Eigenvalues of A", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Calculation: Matrix Subspace Dimensions",
      "interactiveSteps": [
        { "stepText": "Let $A$ be a $4 \\times 7$ matrix with $\\text{Rank}(A) = 3$." },
        {
          "prompt": "According to the Rank-Nullity Theorem, what is the dimension of the nullspace $N(A)$?",
          "options": [
            { "text": "4", "isCorrect": true },
            { "text": "1", "isCorrect": false },
            { "text": "3", "isCorrect": false },
            { "text": "7", "isCorrect": false }
          ]
        },
        { "stepText": "Since $\\text{Nullity}(A) = n - \\text{Rank}(A) = 7 - 3 = 4$, there are 4 free variables." }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the term for the dimension of the nullspace N(A) of a matrix?",
      "blankAnswer": "nullity"
    }
  ]
}
```
