# Duofy Reusable Lesson Format: Canonical Forms - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Linear_Algebra_and_Matrix_Theory / Canonical_Forms_Jordan_and_Rational`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through existence proofs for Jordan Canonical Form and Rational Canonical Form via module decomposition over $F[x]$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | JCF Existence Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Proof Strategy & Jordan Chain Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Generalized Nullspace Sequence Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Jordan Chain Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Minimal Polynomial Exponent Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Existence of Jordan Canonical Form**\nLet $A \\in M_n(\\mathbb{C})$ have characteristic polynomial $p(x) = \\prod (x - \\lambda_i)^{a_i}$.\nThen there exists an invertible matrix $P \\in M_n(\\mathbb{C})$ such that:\n$$\nA = P J P^{-1}, \\quad J = \\text{diag}(J_{k_1}(\\lambda_1), J_{k_2}(\\lambda_2), \\dots, J_{k_m}(\\lambda_m))\n$$\nwhere $J$ is unique up to permutation of its constituent Jordan blocks."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to construct a Jordan basis using generalized eigenvectors.",
      "orderItems": [
        "Find eigenvalue λ and compute nullspaces N((A - λ I)^m) until nullspace stabilizes.",
        "Choose vector v_k in N((A - λ I)^k) but not in N((A - λ I)^(k-1)).",
        "Form Jordan chain: v_k, v_{k-1} = (A - λ I) v_k, ..., v_1 = (A - λ I)^(k-1) v_k.",
        "Verify that Jordan chain vectors are linearly independent.",
        "Assemble Jordan chain vectors as columns of P to obtain P^(-1) A P = J."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does the sequence of generalized nullspaces $N(A - \\lambda I) \\subset N((A - \\lambda I)^2) \\subset \\dots$ eventually stabilize?",
      "options": [
        { "text": "The vector space V is finite-dimensional (n), so strict containment cannot continue past dimension n", "isCorrect": true, "explanation": "Correct! Dimensions must be <= n, so the chain of nullspaces must stabilize." },
        { "text": "Because A is symmetric", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because det(A) = 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because λ is prime", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Jordan Chain Action $(A - \\lambda I) v_j$",
      "interactiveSteps": [
        { "stepText": "Let $v_2$ be a generalized eigenvector of order 2: $(A - \\lambda I)^2 v_2 = 0$ but $(A - \\lambda I) v_2 = v_1 \\neq 0$." },
        {
          "prompt": "What is $A v_2$ in terms of $v_1$ and $v_2$?",
          "options": [
            { "text": "A v₂ = λ v₂ + v₁", "isCorrect": true },
            { "text": "A v₂ = λ v₁", "isCorrect": false },
            { "text": "A v₂ = v₂", "isCorrect": false },
            { "text": "A v₂ = 0", "isCorrect": false }
          ]
        },
        { "stepText": "Since $A v_2 = \\lambda v_2 + v_1$ and $A v_1 = \\lambda v_1$, the matrix of $A$ on basis $\{v_1, v_2\}$ is a $2 \\times 2$ Jordan block!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the term for a chain of vectors v_k, (A - λ I)v_k, ..., (A - λ I)^(k-1)v_k used to construct Jordan bases?",
      "blankAnswer": "chain"
    }
  ]
}
```
