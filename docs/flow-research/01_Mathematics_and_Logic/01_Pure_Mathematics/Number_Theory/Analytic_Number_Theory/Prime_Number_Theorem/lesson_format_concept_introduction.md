# Duofy Reusable Lesson Format: Prime Number Theorem - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Analytic_Number_Theory / Prime_Number_Theorem`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the asymptotic statement of the Prime Number Theorem ($\pi(x) \sim \frac{x}{\ln x} \sim \operatorname{Li}(x)$), Chebyshev's weighted functions $\theta(x)$ and $\psi(x)$, the von Mangoldt function $\Lambda(n)$, and the non-vanishing of $\zeta(1+it) \ne 0$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Prime Number Theorem Formal Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Chebyshev Functions & Analytic Bridge Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Prime Counting Function & Asymptotic Behavior Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Zero-Free Boundary Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Prime Density Probability Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Prime Number Theorem: $\pi(x) \sim \frac{x}{\ln x}$, the logarithmic integral $\operatorname{Li}(x) = \int_2^x \frac{dt}{\ln t}$, and Chebyshev's equivalences $\theta(x) \sim x$ and $\psi(x) \sim x$.
2. **Slide 2 (`concept_pieces`):** Deconstruct von Mangoldt function $\Lambda(n)$, logarithmic weighting, the equivalence between PNT and $\zeta(1+it) \ne 0$, and the Riemann Hypothesis error term $\mathcal{O}(\sqrt{x} \ln x)$.
3. **Slide 3 (`matching`):** Pair 4 arithmetic functions ($\pi(x)$, $\theta(x)$, $\psi(x)$, $\operatorname{Li}(x)$) with their asymptotic growth rates and definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the Prime Number Theorem is mathematically equivalent to the non-vanishing of $\zeta(s)$ on the line where the real part of s is equal to one. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking: What is the approximate probability that a large integer $N \approx 10^6$ chosen uniformly at random is prime? ($1/\ln(10^6) \approx 1/(6 \ln 10) \approx 1/13.8 \approx 7.2\%$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: The Prime Number Theorem (PNT)**\n• Let $\\pi(x)$ denote the number of prime numbers less than or equal to $x$.\n• **The Prime Number Theorem** (Hadamard & de la Vallée Poussin, 1896) states:\n$$\n\\pi(x) \\sim \\frac{x}{\\ln x} \\iff \\lim_{x \\to \\infty} \\frac{\\pi(x)}{x / \\ln x} = 1\n$$\n• An even sharper asymptotic approximation is given by the **Logarithmic Integral**:\n$$\n\\operatorname{Li}(x) = \\int_2^x \\frac{dt}{\\ln t} = \\frac{x}{\\ln x} + \\frac{x}{(\\ln x)^2} + \\dots\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Von Mangoldt Function $\\Lambda(n)$:** $\\Lambda(n) = \\ln p$ if $n = p^k$, and $0$ otherwise. It generates $-\\frac{\\zeta'(s)}{\\zeta(s)} = \\sum_{n=1}^\\infty \\frac{\\Lambda(n)}{n^s}$.\n• **Chebyshev's Functions:** $\\theta(x) = \\sum_{p \\le x} \\ln p$ and $\\psi(x) = \\sum_{n \\le x} \\Lambda(n)$.\n• **Asymptotic Equivalence:** $\\pi(x) \\sim \\frac{x}{\\ln x} \\iff \\theta(x) \\sim x \\iff \\psi(x) \\sim x$.\n• **The Analytic Bridge:** PNT holds $\\iff$ the Riemann zeta function has no zeros on the boundary line $\\operatorname{Re}(s) = 1$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each prime-counting function to its mathematical definition.",
      "matchPairs": [
        { "left": "pi(x)", "right": "Count of primes p <= x (step function with jumps of +1 at primes)" },
        { "left": "theta(x)", "right": "First Chebyshev function sum_{p <= x} ln(p)" },
        { "left": "psi(x)", "right": "Second Chebyshev function sum_{n <= x} Lambda(n)" },
        { "left": "Li(x)", "right": "Logarithmic integral int_2^x (1 / ln t) dt" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Analytically, the Prime Number Theorem is equivalent to proving that the Riemann zeta function zeta(s) has no zeros on the line Re(s) = ___.",
      "blankAnswer": "one",
      "blankDistractors": ["zero", "half", "two"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "According to the Prime Number Theorem, what is the approximate probability that an integer randomly selected near N = 10^6 is prime?",
      "options": [
        { "text": "1 / ln(10^6) = 1 / (6 * ln 10) approx 1 / 13.8 (about 7.2%)", "isCorrect": true, "explanation": "Correct! The local density of prime numbers near integer N is approximately 1 / ln(N)." },
        { "text": "1 / 10^6", "isCorrect": false, "explanation": "Incorrect: Primes are much denser than 1/N." },
        { "text": "50%", "isCorrect": false, "explanation": "Incorrect: Primes thin out logarithmically." },
        { "text": "1 / sqrt(10^6) = 1/1000", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
