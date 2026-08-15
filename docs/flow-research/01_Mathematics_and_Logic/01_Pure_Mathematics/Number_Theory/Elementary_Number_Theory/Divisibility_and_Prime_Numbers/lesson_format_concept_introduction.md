# Duofy Reusable Lesson Format: Divisibility and Prime Numbers - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Elementary_Number_Theory / Divisibility_and_Prime_Numbers`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the Division Algorithm, the Euclidean Algorithm for $\gcd(a, b)$, Bézout's Identity ($ax + by = \gcd(a, b)$), the Fundamental Theorem of Arithmetic, and Euclid's Lemma ($p \mid ab \implies p \mid a \lor p \mid b$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Divisibility & Fundamental Theorem Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Primes as Atomic Building Blocks Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Arithmetic Function & Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Euclid's Lemma Divisibility Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Bézout Integer Linear Combination Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Division Algorithm ($a = bq + r, 0 \le r < b$), the definition of $\gcd(a, b)$, Bézout's identity ($ax + by = \gcd(a, b)$), and the Fundamental Theorem of Arithmetic (unique factorization into primes).
2. **Slide 2 (`concept_pieces`):** Deconstruct the Euclidean Algorithm, Euclid's Lemma ($p \mid ab \implies p \mid a$ or $p \mid b$), infinitude of primes via Euclid's proof, and Euler's Totient function $\phi(n)$.
3. **Slide 3 (`matching`):** Pair 4 arithmetic functions ($\tau(n)$, $\sigma(n)$, $\phi(n)$, $\gcd(a, b)$) with their formulas and descriptions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that if a prime $p$ divides a product $ab$, then $p$ must divide $a$ or $b$. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking: What is the smallest positive integer that can be expressed as a linear combination $24x + 36y$ for integers $x, y$? ($\gcd(24, 36) = 12$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Divisibility and Prime Numbers**\n• **The Division Algorithm:** For integers $a, b$ with $b > 0$, there exist unique integers $q, r$ such that:\n$$\na = bq + r, \\quad 0 \\le r < b\n$$\n• **Bézout's Identity:** For any non-zero integers $a$ and $b$, there exist integers $x, y \\in \\mathbb{Z}$ such that:\n$$\nax + by = \\gcd(a, b)\n$$\n• **Fundamental Theorem of Arithmetic:** Every integer $n \\ge 2$ can be factored **uniquely** (up to order) as a product of prime numbers: $n = p_1^{a_1} p_2^{a_2} \\cdots p_k^{a_k}$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Euclidean Algorithm:** Computes $\\gcd(a, b)$ in logarithmic steps by repeated remainder division: $\\gcd(a, b) = \\gcd(b, a \\pmod b)$.\n• **Euclid's Lemma:** If a prime $p$ divides $ab$, then $p \\mid a$ or $p \\mid b$ (the foundational pillar for unique factorization).\n• **Infinitude of Primes:** Given primes $p_1, \\dots, p_k$, the number $N = (p_1 \\cdots p_k) + 1$ has a prime factor outside the list.\n• **Euler's Totient $\\phi(n)$:** Counts integers $1 \\le k \\le n$ coprime to $n$: $\\phi(n) = n \\prod_{p \\mid n} (1 - 1/p)$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each number-theoretic function to its definition for n = prod p_i^{a_i}.",
      "matchPairs": [
        { "left": "Number of Divisors tau(n)", "right": "prod (a_i + 1)" },
        { "left": "Sum of Divisors sigma(n)", "right": "prod (p_i^{a_i + 1} - 1) / (p_i - 1)" },
        { "left": "Euler's Totient phi(n)", "right": "n * prod (1 - 1/p_i)" },
        { "left": "Greatest Common Divisor gcd(a, b)", "right": "prod p_i^{min(a_i, b_i)}" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "By Euclid's Lemma, if a prime p divides the product ab of two integers, then p must divide a or p must divide ___.",
      "blankAnswer": "b",
      "blankDistractors": ["ab", "zero", "one"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "By Bézout's Identity, what is the SMALLEST positive integer that can be written in the form 24x + 36y for integer values of x and y?",
      "options": [
        { "text": "12, because the set of all integer linear combinations is exactly the set of multiples of gcd(24, 36) = 12", "isCorrect": true, "explanation": "Correct! gcd(24, 36) = 12, so the smallest positive value is 12 (e.g. 24(-1) + 36(1) = 12)." },
        { "text": "1", "isCorrect": false, "explanation": "Incorrect: 1 is not divisible by gcd(24, 36) = 12." },
        { "text": "6", "isCorrect": false, "explanation": "Incorrect: 6 is a common divisor, but not the greatest common divisor." },
        { "text": "24", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
