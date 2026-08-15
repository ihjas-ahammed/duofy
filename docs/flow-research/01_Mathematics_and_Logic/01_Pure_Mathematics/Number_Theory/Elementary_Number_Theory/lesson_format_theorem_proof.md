# Duofy Reusable Lesson Format: Elementary Number Theory - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Elementary_Number_Theory`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through landmark proofs in elementary number theory: Gauss's Law of Quadratic Reciprocity, Chinese Remainder Theorem, and Infinitude of Primes (Euclid's Proof).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Quadratic Reciprocity Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Proof Strategy & Gauss Lemma Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Coprime Moduli Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive CRT Solution Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Quadratic Symbol Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Gauss's Law of Quadratic Reciprocity**\nLet $p$ and $q$ be distinct odd prime numbers. The relationship between the solvability of $x^2 \\equiv p \\pmod q$ and $y^2 \\equiv q \\pmod p$ is:\n$$\n\\left(\\frac{p}{q}\\right) \\left(\\frac{q}{p}\\right) = (-1)^{\\frac{p-1}{2} \\frac{q-1}{2}}\n$$\nIf $p \\equiv 1 \\pmod 4$ or $q \\equiv 1 \\pmod 4$, then $\\left(\\frac{p}{q}\\right) = \\left(\\frac{q}{p}\\right)$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove the Chinese Remainder Theorem for two coprime moduli m_1, m_2.",
      "orderItems": [
        "Given system x ≡ a_1 (mod m_1) and x ≡ a_2 (mod m_2) with gcd(m_1, m_2) = 1.",
        "Apply Extended Euclidean Algorithm to find integers z_1, z_2 such that m_1 z_1 + m_2 z_2 = 1.",
        "Construct base elements e_1 = m_2 z_2 ≡ 1 (mod m_1) and e_2 = m_1 z_1 ≡ 1 (mod m_2).",
        "Form combined candidate solution x = a_1 e_1 + a_2 e_2.",
        "Verify x ≡ a_1 (mod m_1) and x ≡ a_2 (mod m_2), unique modulo M = m_1 m_2."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does Euclid's proof of the infinitude of primes consider $N = (p_1 p_2 \\dots p_k) + 1$?",
      "options": [
        { "text": "None of the primes p_1, ..., p_k can divide N because remainder is 1, so N must have a new prime factor", "isCorrect": true, "explanation": "Correct! N mod p_i = 1 for all i, forcing a prime factor outside {p_1, ..., p_k}." },
        { "text": "Because N is always prime", "isCorrect": false, "explanation": "Incorrect: N might be composite (e.g. 2*3*5*7*11*13 + 1 = 59 * 509)." },
        { "text": "Because N is even", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because N is zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Calculation: Evaluating $\\left(\\frac{3}{7}\\right)$ using Quadratic Reciprocity",
      "interactiveSteps": [
        { "stepText": "Both $p=3$ and $q=7$ are odd primes. Check congruences mod 4: $3 \\equiv 3 \\pmod 4$ and $7 \\equiv 3 \\pmod 4$." },
        {
          "prompt": "Since both primes are $\\equiv 3 \\pmod 4$, what is $(-1)^{\\frac{3-1}{2} \\frac{7-1}{2}}$?",
          "options": [
            { "text": "-1", "isCorrect": true },
            { "text": "+1", "isCorrect": false },
            { "text": "0", "isCorrect": false },
            { "text": "2", "isCorrect": false }
          ]
        },
        { "stepText": "Thus $\\left(\\frac{3}{7}\\right) = -\\left(\\frac{7}{3}\\right) = -\\left(\\frac{1}{3}\\right) = -(+1) = -1$. Conclude $x^2 \\equiv 3 \\pmod 7$ is unsolvable!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What name is given to the Legendre symbol ratio formula relating (p/q) and (q/p)?",
      "blankAnswer": "reciprocity"
    }
  ]
}
```
