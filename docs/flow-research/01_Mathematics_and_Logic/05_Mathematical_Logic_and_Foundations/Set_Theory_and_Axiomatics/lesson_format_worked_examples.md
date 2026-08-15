# Duofy Reusable Lesson Format: Set Theory & Axiomatics - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Set_Theory_and_Axiomatics`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to execute Ordinal Arithmetic ($\omega + 1 \neq 1 + \omega$, $\omega \cdot 2 \neq 2 \cdot \omega$), evaluate Cardinal Arithmetic $2^{\aleph_0}$, and apply transfinite induction.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Ordinal Addition & Non-Commutativity Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Ordinal Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Ordinal Successor Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Ordinal Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Cardinal Arithmetic Power Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Non-Commutativity of Ordinal Addition**\nOrdinal addition $\\alpha + \\beta$ is defined by placing well-ordered set $\\beta$ after $\\alpha$.\n$$\n1 + \\omega = \\omega, \\quad \\text{but} \\quad \\omega + 1 > \\omega\n$$\nAdding 1 BEFORE infinite sequence $\\omega = \\{0, 1, 2, \\dots\\}$ leaves order type unchanged ($\n1 + \\omega = \\omega$)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Consider $1 + \\omega$. Set 1 is $\\{a\\}$, set $\\omega$ is $\\{0, 1, 2, \\dots\\}$.\n• **Step 2:** Order $1 + \\omega$: $a < 0 < 1 < 2 < \\dots$. This sequence has no maximum element and order type $\\omega$.\n• **Step 3:** Consider $\\omega + 1$. Order: $0 < 1 < 2 < \\dots < a$.\n• **Step 4:** Sequence $\\omega + 1$ HAS a maximum element $a$, so its order type is strictly greater than $\\omega$.\n• **Step 5:** Thus $1 + \\omega = \\omega \\neq \\omega + 1$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In von Neumann ordinal construction, the successor S(alpha) of ordinal alpha is defined as alpha union ___.",
      "blankAnswer": "{alpha}",
      "blankDistractors": ["1", "omega", "emptyset"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "In infinite cardinal arithmetic under AC, calculate $\\aleph_0 + \\aleph_0 = \\max(\\aleph_0, \\aleph_0)$ (in terms of multiplier times $\\aleph_0 = 1.0$).",
      "numericAnswer": 1.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Under Axiom of Choice, what is $\\aleph_0 \\cdot \\aleph_0$?",
      "options": [
        { "text": "aleph_0 (since N × N is countable via Cantor pairing)", "isCorrect": true, "explanation": "Correct! Infinite cardinal multiplication satisfies κ · κ = κ under AC." },
        { "text": "2^(aleph_0)", "isCorrect": false, "explanation": "Incorrect: That is the continuum c." },
        { "text": "aleph_1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
