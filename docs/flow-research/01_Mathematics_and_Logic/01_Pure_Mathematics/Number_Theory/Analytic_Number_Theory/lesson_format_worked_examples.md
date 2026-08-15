# Duofy Reusable Lesson Format: Analytic Number Theory - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Analytic_Number_Theory`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute Dirichlet Convolutions $(f * g)(n)$, evaluate Möbius Inversions, calculate special values of the Zeta function ($\zeta(2) = \pi^2 / 6$), and compute residues of Dirichlet series.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Dirichlet Convolution Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Convolution Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Möbius Function Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Special Value Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Zeta Pole Residue Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Dirichlet Convolution & Möbius Inversion**\nFor multiplicative arithmetic functions $f, g$, their **Dirichlet Convolution** is:\n$$\n(f * g)(n) = \\sum_{d \\mid n} f(d) g\\left(\\frac{n}{d}\\right)\n$$\nMöbius function $\\mu(n)$: $\\mu(1) = 1$, $\\mu(n) = (-1)^k$ if $n$ is square-free product of $k$ distinct primes, and $\\mu(n) = 0$ if $p^2 \\mid n$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Compute $(\\mu * \\mathbf{1})(12)$ where $\\mathbf{1}(n) = 1$ for all $n$.\n• **Step 2:** Divisors of 12 are $d \\in \\{1, 2, 3, 4, 6, 12\\}$.\n• **Step 3:** Evaluate $\\mu(d)$: $\\mu(1) = 1, \\mu(2) = -1, \\mu(3) = -1, \\mu(4) = 0, \\mu(6) = 1, \\mu(12) = 0$.\n• **Step 4:** Sum: $1 + (-1) + (-1) + 0 + 1 + 0 = 0$. (In general, $(\\mu * \\mathbf{1})(n) = \\epsilon(n) = [n=1]$)."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The value of the Möbius function mu(n) for an integer n divisible by a square of a prime (p^2 | n) is equal to ___.",
      "blankAnswer": "0",
      "blankDistractors": ["1", "-1", "p"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the Basel problem value $\\zeta(2) = \\sum_{n=1}^\\infty \\frac{1}{n^2}$ (in terms of $\\pi^2 / 6 \\approx 1.6449$).",
      "numericAnswer": 1.6449,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the residue of the Riemann Zeta function $\\zeta(s)$ at its simple pole $s = 1$?",
      "options": [
        { "text": "1", "isCorrect": true, "explanation": "Correct! lim_{s -> 1} (s - 1) ζ(s) = 1." },
        { "text": "0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "π", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "e", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
