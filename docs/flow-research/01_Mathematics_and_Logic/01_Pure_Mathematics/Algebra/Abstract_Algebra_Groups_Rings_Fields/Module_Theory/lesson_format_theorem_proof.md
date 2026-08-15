# Duofy Reusable Lesson Format: Module Theory - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Abstract_Algebra_Groups_Rings_Fields / Module_Theory`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the crown jewel of module theory: The Structure Theorem for Finitely Generated Modules over a Principal Ideal Domain (PID).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Structure Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Proof Strategy & Matrix Reduction Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Invariant Factor / Elementary Divisor Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Step-by-Step Direct Sum Proof | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Fundamental Group Decomposition Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Structure Theorem for Finitely Generated Modules over a PID**\nLet $R$ be a Principal Ideal Domain and let $M$ be a finitely generated $R$-module.\nThen $M$ is isomorphic to a direct sum of a free module and torsion submodules:\n$$\nM \\cong R^r \\oplus R/\\langle a_1 \\rangle \\oplus R/\\langle a_2 \\rangle \\oplus \\dots \\oplus R/\\langle a_k \\rangle\n$$\nwhere $r \\ge 0$ is the rank and $a_1 \\mid a_2 \\mid \\dots \\mid a_k$ are invariant factors."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove the Structure Theorem for Modules over a PID.",
      "orderItems": [
        "Present M as a quotient of a free module R^n / K.",
        "Construct presentation matrix A with entries in PID R.",
        "Apply row and column operations to reduce A to diagonal Smith Normal Form.",
        "Read off free rank r and invariant factors a_i from diagonal entries.",
        "Decompose M into direct sum R^r ⊕ ⊕ R/<a_i>."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "When $R = \\mathbb{Z}$, what fundamental algebraic theorem is directly obtained as a special case of the Structure Theorem for Modules over a PID?",
      "options": [
        { "text": "Fundamental Theorem of Finitely Generated Abelian Groups", "isCorrect": true, "explanation": "Correct! Abelian groups are Z-modules, so Z^r ⊕ ⊕ Z/n_i Z gives the complete classification." },
        { "text": "Sylow Theorems", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "First Isomorphism Theorem for Groups", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Cayley's Theorem", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Special Case: $R = F[x]$ Matrix Canonical Form",
      "interactiveSteps": [
        { "stepText": "Let $V$ be a finite-dimensional vector space over $F$ and $T: V \\to V$ a linear operator. $V$ becomes an $F[x]$-module via $x \\cdot v = T(v)$." },
        {
          "prompt": "Applying the Structure Theorem for $F[x]$-modules yields which matrix canonical form?",
          "options": [
            { "text": "Rational Canonical Form", "isCorrect": true },
            { "text": "LU Decomposition", "isCorrect": false },
            { "text": "Gram-Schmidt Form", "isCorrect": false },
            { "text": "Cholesky Factorization", "isCorrect": false }
          ]
        },
        { "stepText": "Factoring invariant factors into prime powers yields the Jordan Canonical Form when $F$ is algebraically closed." }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "In the decomposition M ≅ R^r ⊕ Tor(M), what name is given to integer r?",
      "blankAnswer": "rank"
    }
  ]
}
```
