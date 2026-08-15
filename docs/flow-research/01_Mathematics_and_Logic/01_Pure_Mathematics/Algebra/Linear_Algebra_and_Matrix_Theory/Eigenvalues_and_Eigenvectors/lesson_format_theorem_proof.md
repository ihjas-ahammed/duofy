# Duofy Reusable Lesson Format: Eigenvalues & Eigenvectors - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Linear_Algebra_and_Matrix_Theory / Eigenvalues_and_Eigenvectors`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through foundational proofs in Spectral Theory, specifically the Spectral Theorem for Real Symmetric Matrices ($A = Q \Lambda Q^T$) and the Cayley-Hamilton Theorem ($p(A) = 0$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Spectral Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Proof Strategy & Orthogonality Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Real Eigenvalues Proof Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Matrix Power Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Cayley-Hamilton Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The Spectral Theorem for Real Symmetric Matrices**\nLet $A \\in \\mathbb{R}^{n \\times n}$ be a real symmetric matrix ($A = A^T$).\n1. All eigenvalues of $A$ are **real numbers**.\n2. Eigenvectors corresponding to distinct eigenvalues are **orthogonal**.\n3. $A$ can be orthogonally diagonalized:\n$$\nA = Q \\Lambda Q^T, \\quad Q^T Q = I\n$$\nwhere $Q$ is an orthogonal matrix of eigenvectors and $\\Lambda$ is a diagonal matrix of eigenvalues."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove that eigenvectors of a symmetric matrix A for distinct eigenvalues λ₁ ≠ λ₂ are orthogonal.",
      "orderItems": [
        "Let A v₁ = λ₁ v₁ and A v₂ = λ₂ v₂ with λ₁ ≠ λ₂.",
        "Consider inner product (A v₁) · v₂ = (λ₁ v₁) · v₂ = λ₁ (v₁ · v₂).",
        "Use symmetric property A = A^T to rewrite (A v₁) · v₂ = v₁ · (A v₂) = v₁ · (λ₂ v₂) = λ₂ (v₁ · v₂).",
        "Subtract equations: (λ₁ - λ₂) (v₁ · v₂) = 0.",
        "Since λ₁ ≠ λ₂, conclude v₁ · v₂ = 0, proving orthogonality."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What does the Cayley-Hamilton Theorem state for any square matrix $A$ with characteristic polynomial $p(\\lambda) = \\det(A - \\lambda I)$?",
      "options": [
        { "text": "Every square matrix satisfies its own characteristic equation p(A) = 0", "isCorrect": true, "explanation": "Correct! Replacing λ with matrix A yields zero matrix 0." },
        { "text": "All matrices are diagonalizable", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "det(A) is always positive", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A^T = A for all square matrices", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Derivation: Matrix Power via Diagonalization",
      "interactiveSteps": [
        { "stepText": "Suppose $A = P D P^{-1}$. We wish to compute $A^k$ efficiently." },
        {
          "prompt": "What is $(P D P^{-1})^2$?",
          "options": [
            { "text": "P D² P⁻¹", "isCorrect": true },
            { "text": "P² D² P⁻²", "isCorrect": false },
            { "text": "P D P⁻¹ D", "isCorrect": false },
            { "text": "D²", "isCorrect": false }
          ]
        },
        { "stepText": "By induction, $A^k = P D^k P^{-1}$, requiring only $O(n)$ scalar powers of diagonal entries in $D$!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What name is given to a square matrix Q satisfying Q^T * Q = I?",
      "blankAnswer": "orthogonal"
    }
  ]
}
```
