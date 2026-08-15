# Duofy Reusable Lesson Format: Analytic Number Theory - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Analytic_Number_Theory`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the Riemann Zeta Function $\zeta(s)$, Euler Product Formula, Prime Counting Function $\pi(x) \sim \frac{x}{\ln x}$, Dirichlet $L$-Functions, and the Riemann Hypothesis ($\text{Re}(s) = 1/2$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Riemann Zeta & Euler Product Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Prime Distribution & Analysis Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Analytic Functions Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Critical Strip Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Prime Number Theorem Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Riemann Zeta Function & Euler Product**\nFor complex variable $s = \\sigma + i t$ with $\\text{Re}(s) > 1$, the **Riemann Zeta Function** is:\n$$\n\\zeta(s) = \\sum_{n=1}^\\infty \\frac{1}{n^s} = \\prod_{p \\text{ prime}} \\frac{1}{1 - p^{-s}}\n$$\nAnalytically continued to $\\mathbb{C} \\setminus \\{1\\}$ with a simple pole at $s = 1$ of residue $1$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Prime Number Theorem (PNT):** $\\pi(x) \\sim \\frac{x}{\\ln x}$ as $x \\to \\infty$. Equivalent to $\\zeta(1 + i t) \\neq 0$.\n• **Dirichlet Convolution:** $(f * g)(n) = \\sum_{d \\mid n} f(d) g(n/d)$. Translates to product of Dirichlet series $F(s) G(s)$.\n• **Möbius Function $\\mu(n)$:** $\\frac{1}{\\zeta(s)} = \\sum_{n=1}^\\infty \\frac{\\mu(n)}{n^s}$.\n• **Riemann Hypothesis:** All non-trivial zeros of $\\zeta(s)$ lie on the critical line $\\text{Re}(s) = 1/2$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Analytic Number Theory concept to its core property.",
      "matchPairs": [
        { "left": "Prime Number Theorem PNT", "right": "pi(x) ~ x / ln(x) as x -> infinity" },
        { "left": "Riemann Hypothesis RH", "right": "Non-trivial zeros of ζ(s) have Re(s) = 1/2" },
        { "left": "Dirichlet L-Function", "right": "Proves infinitude of primes in arithmetic progressions a + n d" },
        { "left": "Zeta Pole at s = 1", "right": "Simple pole with residue equal to 1" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Riemann Hypothesis asserts that all non-trivial zeros of the zeta function lie on the critical line Re(s) = ___.",
      "blankAnswer": "1/2",
      "blankDistractors": ["0", "1", "2"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the asymptotic ratio $\\frac{\\pi(x)}{x / \\ln x}$ as $x \\to \\infty$ according to the Prime Number Theorem?",
      "options": [
        { "text": "1", "isCorrect": true, "explanation": "Correct! Asymptotic equivalence means ratio approaches 1 as x -> ∞." },
        { "text": "0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "e", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "π", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
