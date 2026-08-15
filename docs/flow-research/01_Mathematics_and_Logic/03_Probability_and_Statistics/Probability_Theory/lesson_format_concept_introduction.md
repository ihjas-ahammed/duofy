# Duofy Reusable Lesson Format: Probability Theory - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Probability Spaces $(\Omega, \mathcal{F}, P)$, Random Variables $X$, Expectation $E[X] = \int X dP$, Central Limit Theorem, and Characteristic Functions $\phi_X(t) = E[e^{i t X}]$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Probability Space & CLT Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Expectation & Limit Theorem Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Distribution Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Standard Normal Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Law of Large Numbers Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Probability Space & Central Limit Theorem**\nA **Probability Space** $(\\Omega, \\mathcal{F}, P)$ consists of sample space $\\Omega$, $\\sigma$-algebra $\\mathcal{F}$, and measure $P$ with $P(\\Omega) = 1$.\n**Central Limit Theorem (CLT):** For i.i.d. $X_i$ with mean $\\mu$ and variance $\\sigma^2$:\n$$\nZ_n = \\frac{\\sum_{i=1}^n X_i - n\\mu}{\\sigma \\sqrt{n}} \\xrightarrow{d} \\mathcal{N}(0, 1) \\quad \\text{as } n \\to \\infty\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Random Variable:** Measurable function $X: \\Omega \\to \\mathbb{R}$ mapping outcomes to real numbers.\n• **Characteristic Function:** $\\phi_X(t) = E[e^{i t X}] = \\int e^{i t x} dF_X(x)$. Uniquely determines distribution!\n• **Law of Large Numbers:** Sample average $\\bar{X}_n \\to \\mu$ in probability (Weak LLN) and almost surely (Strong LLN).\n• **Itô's Lemma:** Fundamental rule of stochastic calculus: $d f(t, B_t) = \\frac{\\partial f}{\\partial t} dt + \\frac{\\partial f}{\\partial B} dB_t + \\frac{1}{2} \\frac{\\partial^2 f}{\\partial B^2} dt$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each probability distribution to its characteristic function φ(t).",
      "matchPairs": [
        { "left": "Standard Normal N(0, 1)", "right": "exp(- t^2 / 2)" },
        { "left": "Poisson(λ)", "right": "exp(λ (e^(it) - 1))" },
        { "left": "Bernoulli(p)", "right": "1 - p + p e^(it)" },
        { "left": "Exponential(λ)", "right": "λ / (λ - i t)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Central Limit Theorem states that the normalized sum of i.i.d. random variables converges in distribution to a standard ___ distribution.",
      "blankAnswer": "normal",
      "blankDistractors": ["uniform", "poisson", "exponential"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the key difference between the Weak Law of Large Numbers (WLLN) and the Strong Law of Large Numbers (SLLN)?",
      "options": [
        { "text": "WLLN asserts convergence in probability; SLLN asserts almost sure (a.s.) convergence", "isCorrect": true, "explanation": "Correct! Almost sure convergence implies convergence in probability, making SLLN stronger." },
        { "text": "WLLN applies only to normal distributions", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "SLLN does not require finite mean", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "They are mathematically identical", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
