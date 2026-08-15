# Duofy Reusable Lesson Format: Field & Galois Theory - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Abstract_Algebra_Groups_Rings_Fields / Field_Theory_and_Galois_Theory`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute extension degrees $[K:F]$, determine minimal polynomials $m_{a, F}(x)$, construct splitting fields, and find elements of $\text{Gal}(K/F)$ step-by-step.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Extension & Degree Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Worked Computation | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Minimal Polynomial Condition Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Degree / Group Size Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Splitting Field Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Minimal Polynomial & Degree**\nThe degree of a simple algebraic extension $F(a)/F$ equals the degree of the minimal polynomial $m_{a, F}(x)$:\n$$\n[F(a) : F] = \\deg(m_{a, F}(x))\n$$\nwhere $m_{a, F}(x)$ is the unique monic irreducible polynomial in $F[x]$ with $m_{a, F}(a) = 0$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Consider $a = \\sqrt[3]{2}$ over $\\mathbb{Q}$. $a^3 = 2 \\implies a^3 - 2 = 0$.\n• **Step 2:** Polynomial $f(x) = x^3 - 2$ is monic and has $a$ as a root.\n• **Step 3:** By Eisenstein's Criterion ($p=2$), $x^3 - 2$ is irreducible over $\\mathbb{Q}$.\n• **Step 4:** Thus $m_{a, \\mathbb{Q}}(x) = x^3 - 2$, so degree $[\\mathbb{Q}(\\sqrt[3]{2}) : \\mathbb{Q}] = 3$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The minimal polynomial of an algebraic element a over field F must be monic and ___.",
      "blankAnswer": "irreducible",
      "blankDistractors": ["reducible", "quadratic", "zero"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "What is the degree of the splitting field of $x^3 - 2$ over $\\mathbb{Q}$?",
      "numericAnswer": 6.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the Galois group $\\text{Gal}(K/\\mathbb{Q})$ for the splitting field $K$ of $x^3 - 2$ over $\\mathbb{Q}$?",
      "options": [
        { "text": "Symmetric group S₃ of order 6", "isCorrect": true, "explanation": "Correct! The splitting field is Q(∛2, ω) of degree 6, isomorphic to S₃." },
        { "text": "Cyclic group Z₃ of order 3", "isCorrect": false, "explanation": "Incorrect: Q(∛2) is not a normal extension over Q." },
        { "text": "Klein 4-group", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Z₆", "isCorrect": false, "explanation": "Incorrect: S₃ is non-abelian." }
      ]
    }
  ]
}
```
