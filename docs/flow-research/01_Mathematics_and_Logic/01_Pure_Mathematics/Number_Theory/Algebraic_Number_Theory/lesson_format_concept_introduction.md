# Duofy Reusable Lesson Format: Algebraic Number Theory - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Algebraic_Number_Theory`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Number Fields $K/\mathbb{Q}$, Rings of Integers $\mathcal{O}_K$, Dedekind Domains, Ideal Factorization, Class Groups $C_K$, and Dirichlet's Unit Theorem.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Ring of Integers & Dedekind Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Prime Ideal Factorization Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Algebraic Invariant Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Class Number Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Prime Splitting Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Ring of Integers & Dedekind Domain**\nFor a finite number field extension $K/\\mathbb{Q}$, the **Ring of Integers** $\\mathcal{O}_K$ is the set of elements in $K$ that are roots of monic polynomials in $\\mathbb{Z}[x]$.\n$$\n\\mathcal{O}_K = \\{ \\alpha \\in K \\mid f(\\alpha) = 0 \\text{ for some monic } f \\in \\mathbb{Z}[x] \\}\n$$\n$\\mathcal{O}_K$ is a **Dedekind Domain**: every non-zero ideal factors uniquely into prime ideals."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Ideal Factorization:** While element factorization can fail (e.g. $6 = 2 \\cdot 3 = (1+\\sqrt{-5})(1-\\sqrt{-5})$ in $\\mathbb{Z}[\\sqrt{-5}]$), ideal factorization $\\mathfrak{a} = \\mathfrak{p}_1^{e_1} \\dots \\mathfrak{p}_g^{e_g}$ is ALWAYS unique!\n• **Ideal Class Group $C_K$:** Group of fractional ideals modulo principal ideals. Size $h_K = |C_K|$ is the **Class Number** ($h_K = 1 \\iff \\mathcal{O}_K$ is a PID).\n• **Prime Splitting:** $p \\mathcal{O}_K = \\mathfrak{p}_1^{e_1} \\dots \\mathfrak{p}_g^{e_g}$. Degree relation: $\\sum e_i f_i = [K : \\mathbb{Q}]$.\n• **Dirichlet Unit Theorem:** $\\mathcal{O}_K^\\times \\cong \\mu(K) \\times \\mathbb{Z}^{r_1 + r_2 - 1}$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each prime behavior in a quadratic ring to its ideal decomposition.",
      "matchPairs": [
        { "left": "Split Prime", "right": "p O_K = p_1 * p_2 (two distinct prime ideals of norm p)" },
        { "left": "Inert Prime", "right": "p O_K is itself a prime ideal of norm p^2" },
        { "left": "Ramified Prime", "right": "p O_K = p_1^2 (squared prime ideal, p divides discriminant d_K)" },
        { "left": "Class Number h_K = 1", "right": "O_K is a Principal Ideal Domain (PID / UFD)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A number ring O_K is a Unique Factorization Domain if and only if its ideal class number h_K is equal to ___.",
      "blankAnswer": "1",
      "blankDistractors": ["0", "2", "infinity"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In Gaussian Integers $\\mathbb{Z}[i]$, how does the rational prime $p = 5$ split?",
      "options": [
        { "text": "5 splits into two prime ideals: 5 = (2 + i)(2 - i)", "isCorrect": true, "explanation": "Correct! 5 ≡ 1 mod 4 splits in Z[i] because 5 = 2² + 1²." },
        { "text": "5 remains inert", "isCorrect": false, "explanation": "Incorrect: Primes p ≡ 3 mod 4 remain inert." },
        { "text": "5 ramifies as (1+i)²", "isCorrect": false, "explanation": "Incorrect: 2 ramifies as (1+i)²." },
        { "text": "5 does not factor", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
