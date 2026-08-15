# Duofy Reusable Lesson Format: Elementary Number Theory - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Elementary_Number_Theory`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Modular Arithmetic, Fermat's Little Theorem $a^{p-1} \equiv 1 \pmod p$, Euler's Totient $\phi(n)$, Chinese Remainder Theorem, and Quadratic Residues $\left(\frac{a}{p}\right)$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fermat & Euler Theorem Definitions | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Clock Arithmetic & Mental Model Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Number Theory Theorem Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Totient Function Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Quadratic Residue Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Fermat's Little Theorem & Euler's Totient Theorem**\n1. **Fermat's Little Theorem:** If $p$ is prime and $p \\nmid a$, then:\n$$\na^{p-1} \\equiv 1 \\pmod p\n$$\n2. **Euler's Generalization:** For any positive integer $n$ with $\\gcd(a, n) = 1$:\n$$\na^{\\phi(n)} \\equiv 1 \\pmod n\n$$\nwhere $\\phi(n) = n \\prod_{p \\mid n} \\left(1 - \\frac{1}{p}\\right)$ counts integers coprime to $n$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Clock Arithmetic:** Congruence $a \\equiv b \\pmod n$ means $n \\mid (a - b)$ (same remainder upon division by $n$).\n• **Euclidean Algorithm:** Computes $\\gcd(a, b)$ in $O(\\log(\\min(a, b)))$ steps using repeated division $a = q b + r$.\n• **Chinese Remainder Theorem:** Simultaneous system $x \\equiv a_i \\pmod{m_i}$ with pairwise coprime moduli has a unique solution modulo $M = \\prod m_i$.\n• **Legendre Symbol:** $\\left(\\frac{a}{p}\\right) = +1$ if $x^2 \\equiv a \\pmod p$ has a solution, and $-1$ if non-residue."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Number Theory theorem to its formula.",
      "matchPairs": [
        { "left": "Fermat's Little Theorem", "right": "a^(p-1) ≡ 1 (mod p) for prime p" },
        { "left": "Euler's Totient Theorem", "right": "a^ϕ(n) ≡ 1 (mod n) for gcd(a, n) = 1" },
        { "left": "Bézout's Identity", "right": "gcd(a, b) = a x + b y for integers x, y" },
        { "left": "Wilson's Theorem", "right": "(p - 1)! ≡ -1 (mod p) for prime p" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "For a prime number p, Euler's totient function phi(p) is equal to ___.",
      "blankAnswer": "p - 1",
      "blankDistractors": ["p", "p + 1", "1"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the value of $\\phi(12)$ (number of positive integers $\\le 12$ coprime to 12)?",
      "options": [
        { "text": "4 (the coprime numbers are 1, 5, 7, 11)", "isCorrect": true, "explanation": "Correct! φ(12) = 12 * (1 - 1/2) * (1 - 1/3) = 12 * (1/2) * (2/3) = 4." },
        { "text": "6", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "11", "isCorrect": false, "explanation": "Incorrect: 12 is composite." },
        { "text": "2", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
