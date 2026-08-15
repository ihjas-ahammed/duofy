# Duofy Reusable Lesson Format: Module Theory - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Abstract_Algebra_Groups_Rings_Fields / Module_Theory`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute Smith Normal Forms of matrices over PIDs, extract invariant factors $a_1 \mid a_2 \mid \dots \mid a_k$, and determine module decompositions for finitely generated abelian groups and linear operators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Smith Normal Form Algorithm Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Matrix Row/Column Reduction | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Invariant Factor Divisibility Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Free Rank / Torsion Computation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Decomposition Verification Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Smith Normal Form over a PID**\nAny matrix $A \\in M_{m \\times n}(R)$ over a PID $R$ can be reduced via invertible row and column operations to a diagonal matrix:\n$$\nS = \\begin{pmatrix} d_1 & 0 & 0 \\\\ 0 & d_2 & 0 \\\\ 0 & 0 & \\ddots \\end{pmatrix}\n$$\nwhere $d_1 \\mid d_2 \\mid \\dots \\mid d_k$ are the invariant factors."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Given matrix $A = \\begin{pmatrix} 2 & 4 \\\\ 4 & 6 \\end{pmatrix}$ over $\\mathbb{Z}$.\n• **Step 2:** Row op $R_2 \\leftarrow R_2 - 2R_1 \\implies \\begin{pmatrix} 2 & 4 \\\\ 0 & -2 \\end{pmatrix}$.\n• **Step 3:** Col op $C_2 \\leftarrow C_2 - 2C_1 \\implies \\begin{pmatrix} 2 & 0 \\\\ 0 & -2 \\end{pmatrix}$.\n• **Step 4:** Normalize units $\\implies S = \\begin{pmatrix} 2 & 0 \\\\ 0 & 2 \\end{pmatrix}$. Invariant factors: $d_1 = 2, d_2 = 2$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In Smith Normal Form, diagonal entries d_i must satisfy the divisibility condition d_1 divides ___.",
      "blankAnswer": "d_2",
      "blankDistractors": ["d_0", "det(A)", "rank"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Consider the abelian group $M = \\mathbb{Z} / 4\\mathbb{Z} \\oplus \\mathbb{Z} / 12\\mathbb{Z} \\oplus \\mathbb{Z}$. What is its free rank $r$?",
      "numericAnswer": 1.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the canonical invariant factor form for the abelian group $\\mathbb{Z}_2 \\oplus \\mathbb{Z}_6$?",
      "options": [
        { "text": "Z_2 ⊕ Z_6 (since 2 divides 6)", "isCorrect": true, "explanation": "Correct! 2 | 6 satisfies invariant factor divisibility." },
        { "text": "Z_3 ⊕ Z_4", "isCorrect": false, "explanation": "Incorrect: 3 does not divide 4." },
        { "text": "Z_12", "isCorrect": false, "explanation": "Incorrect: Z_2 ⊕ Z_6 is not cyclic." },
        { "text": "Z_4 ⊕ Z_3", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
