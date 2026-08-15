# Duofy Reusable Lesson Format: Modular Arithmetic and Congruences - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Elementary_Number_Theory / Modular_Arithmetic_and_Congruences`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Modular Congruences, Modular Inverses, Fermat's Little Theorem ($a^{p-1} \equiv 1 \pmod p$), Euler's Totient Theorem ($a^{\phi(m)} \equiv 1 \pmod m$), the Chinese Remainder Theorem, and Quadratic Residues.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Congruence Modulo $m$ & Inverses Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Cyclic Residue Rings & Power Reduction Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Number-Theoretic Theorem & Equation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Coprime Multiplicative Inverses Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Fermat's Little Theorem Modular Exponent Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of congruence $a \equiv b \pmod m$, modular inverse existence condition ($\gcd(a, m) = 1$), Fermat's Little Theorem ($a^{p-1} \equiv 1 \pmod p$), and the Chinese Remainder Theorem for coprime moduli.
2. **Slide 2 (`concept_pieces`):** Deconstruct Euler's Totient Theorem $a^{\phi(m)} \equiv 1 \pmod m$, Wilson's Theorem $(p-1)! \equiv -1 \pmod p$, Quadratic Residues via Legendre symbol $\left(\frac{a}{p}\right) = \pm 1$, and Gauss's Quadratic Reciprocity Law.
3. **Slide 3 (`matching`):** Pair 4 classical theorems (Fermat's Little Theorem, Euler's Theorem, Wilson's Theorem, Chinese Remainder Theorem) with their core formulas.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that an integer $a$ has a modular inverse modulo $m$ if and only if $a$ and $m$ are coprime. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking: What is the remainder when $3^{100}$ is divided by the prime $p = 7$? ($100 \equiv 4 \pmod 6 \implies 3^4 = 81 \equiv 4 \pmod 7$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Modular Congruences and Theorems**\n• Two integers $a, b$ are **congruent modulo $m$** ($a \\equiv b \\pmod m$) if $m \\mid (a - b)$.\n• **Modular Inverse:** $ax \\equiv 1 \\pmod m$ has a unique solution modulo $m \\iff \\gcd(a, m) = 1$.\n• **Fermat's Little Theorem (FLT):** If $p$ is prime and $p \\nmid a$, then:\n$$\na^{p-1} \\equiv 1 \\pmod p\n$$\n• **Chinese Remainder Theorem (CRT):** If $\\gcd(m_1, m_2) = 1$, the system $x \\equiv a_1 \\pmod{m_1}$ and $x \\equiv a_2 \\pmod{m_2}$ has a unique solution modulo $m_1 m_2$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Euler's Theorem:** Generalizes FLT: $a^{\\phi(m)} \\equiv 1 \\pmod m$ for any coprime pair $\\gcd(a, m) = 1$.\n• **Wilson's Theorem:** $p$ is prime $\\iff (p-1)! \\equiv -1 \\pmod p$.\n• **Quadratic Residues:** $a$ is a quadratic residue modulo $p$ if $x^2 \\equiv a \\pmod p$ has a solution, encoded by Legendre symbol $\\left(\\frac{a}{p}\\right) = a^{(p-1)/2} \\pmod p$.\n• **Gauss's Quadratic Reciprocity:** Connects solvability: $\\left(\\frac{p}{q}\\right)\\left(\\frac{q}{p}\\right) = (-1)^{\\frac{p-1}{2}\\frac{q-1}{2}}$ for odd primes."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each number theory theorem to its defining congruence equation.",
      "matchPairs": [
        { "left": "Fermat's Little Theorem", "right": "a^{p-1} = 1 mod p for prime p" },
        { "left": "Euler's Totient Theorem", "right": "a^{phi(m)} = 1 mod m for gcd(a, m) = 1" },
        { "left": "Wilson's Theorem", "right": "(p-1)! = -1 mod p for prime p" },
        { "left": "Quadratic Reciprocity", "right": "(p/q)(q/p) = (-1)^{(p-1)/2 * (q-1)/2}" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "An integer a has a unique multiplicative inverse modulo m if and only if a and m are strictly ___.",
      "blankAnswer": "coprime",
      "blankDistractors": ["prime", "congruent", "even"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Using Fermat's Little Theorem, what is the remainder when 3^{100} is divided by 7?",
      "options": [
        { "text": "4, because 3^6 = 1 mod 7, and 100 = 6 * 16 + 4, so 3^{100} = (3^6)^{16} * 3^4 = 1 * 81 = 4 mod 7", "isCorrect": true, "explanation": "Correct! Since p = 7, phi(7) = 6. 100 mod 6 = 4, and 3^4 = 81 = 4 mod 7." },
        { "text": "1", "isCorrect": false, "explanation": "Incorrect: 100 is not a multiple of 6." },
        { "text": "3", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "6", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
