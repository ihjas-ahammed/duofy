# Duofy Reusable Lesson Format: Proof Theory - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Proof_Theory`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute Gödel numbers $\ulcorner \phi \urcorner$ via prime power encoding $2^{a_1} 3^{a_2} 5^{a_3} \dots$, construct Gentzen Sequent derivations, and verify Curry-Howard lambda term type assignments.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gödel Numbering Encoding Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Encoding Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Sequent Rule Symbol Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Gödel Number Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Curry-Howard Lambda Term Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Gödel Numbering via Prime Exponents**\nAssign unique symbol codes: `0` $\\to 1$, `S` $\\to 3$, `=` $\\to 5$, `(` $\\to 7$, `)` $\\to 9$.\nA sequence of symbols $s_1 s_2 \\dots s_k$ has Gödel number:\n$$\n\\ulcorner s_1 s_2 \\dots s_k \\urcorner = 2^{\\text{code}(s_1)} \\cdot 3^{\\text{code}(s_2)} \\cdot 5^{\\text{code}(s_3)} \\dots p_k^{\\text{code}(s_k)}\n$$\nUnique prime factorization guarantees total decoding!"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Encode short expression `0 = 0`.\n• **Step 2:** Symbol codes: `0` $\\to 1$, `=` $\\to 5$, `0` $\\to 1$.\n• **Step 3:** Prime power expansion: $2^{\\text{code}(0)} \\times 3^{\\text{code}(=)} \\times 5^{\\text{code}(0)}$.\n• **Step 4:** Calculate: $2^1 \\times 3^5 \\times 5^1 = 2 \\times 243 \\times 5 = 2430$.\n• **Step 5:** $\\ulcorner 0 = 0 \\urcorner = 2430$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "Under the Curry-Howard isomorphism, lambda abstraction λx. M corresponds to the proof rule for implication ___.",
      "blankAnswer": "introduction",
      "blankDistractors": ["elimination", "negation", "cut"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the Gödel number $\\ulcorner 0 = 0 \\urcorner = 2^1 \\times 3^5 \\times 5^1$ for symbol sequence codes (1, 5, 1).",
      "numericAnswer": 2430.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In Simply Typed Lambda Calculus, what type is assigned to identity term $\\lambda x: A. x$ under Curry-Howard?",
      "options": [
        { "text": "A -> A (corresponds to proof of self-implication A -> A)", "isCorrect": true, "explanation": "Correct! Identity function λx:A.x has type A -> A." },
        { "text": "A -> B", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A ∧ A", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Void", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
