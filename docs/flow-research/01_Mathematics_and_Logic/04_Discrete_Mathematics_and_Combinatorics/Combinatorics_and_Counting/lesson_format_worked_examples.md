# Duofy Reusable Lesson Format: Combinatorics & Counting - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Combinatorics_and_Counting`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute Binomial coefficients $\binom{n}{k}$, evaluate derangements $D_n$, extract generating function coefficients $[x^n] A(x)$, and solve Stars and Bars distribution problems.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Stars and Bars Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Stars and Bars Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Binomial Identity Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Derangement Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Generating Function Coefficient Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Stars and Bars Bins Problem**\nNumber of non-negative integer solutions to $x_1 + x_2 + \\dots + x_k = n$ (distributing $n$ identical items into $k$ distinct bins) is:\n$$\nN = \\binom{n + k - 1}{k - 1} = \\binom{n + k - 1}{n}\n$$\nIf all $x_i \\ge 1$ (positive integer solutions), $N = \\binom{n - 1}{k - 1}$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Distribute $n = 7$ identical candies to $k = 3$ children.\n• **Step 2:** Formula: $\\binom{n + k - 1}{k - 1} = \\binom{7 + 3 - 1}{3 - 1} = \\binom{9}{2}$.\n• **Step 3:** Calculate binomial coefficient: $\\frac{9 \\times 8}{2 \\times 1} = 36$.\n• **Step 4:** There are 36 distinct ways to distribute the candies."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "Pascal's identity states that (n choose k) equals (n-1 choose k-1) plus (n-1 choose ___).",
      "blankAnswer": "k",
      "blankDistractors": ["k+1", "n", "0"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the number of derangements $D_4 = 4! \\left(1 - 1 + \\frac{1}{2!} - \\frac{1}{3!} + \\frac{1}{4!}\\right)$ of 4 items.",
      "numericAnswer": 9.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the coefficient $[x^5]$ in the generating function $A(x) = \\frac{1}{1 - 2x} = \\sum_{n=0}^\\infty 2^n x^n$?",
      "options": [
        { "text": "32 (since 2^5 = 32)", "isCorrect": true, "explanation": "Correct! Coefficient [x⁵] in 1/(1-2x) is 2⁵ = 32." },
        { "text": "16", "isCorrect": false, "explanation": "Incorrect: 2⁴ = 16." },
        { "text": "5", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "64", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
