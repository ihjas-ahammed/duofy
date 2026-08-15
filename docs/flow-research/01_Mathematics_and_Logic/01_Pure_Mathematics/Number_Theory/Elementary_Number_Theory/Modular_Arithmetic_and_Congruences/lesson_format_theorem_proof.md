# Duofy Reusable Lesson Format: Modular Arithmetic and Congruences - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Elementary_Number_Theory / Modular_Arithmetic_and_Congruences`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof of **Euler's Generalization of Fermat's Little Theorem** ($a^{\phi(m)} \equiv 1 \pmod m$) via reduced residue systems, and prove **Wilson's Theorem** ($(p-1)! \equiv -1 \pmod p$) by pairing inverses.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Euler's Totient Congruence Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Reduced Residue Permutation Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Cancellation of Coprime Product Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Wilson's Theorem Self-Inverse Pairing Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Modular Root Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Euler's Theorem: If $m$ is a positive integer and $\gcd(a, m) = 1$, then $a^{\phi(m)} \equiv 1 \pmod m$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof of Euler's Theorem: (1) let $R = \{r_1, r_2, \dots, r_{\phi(m)}\}$ be the reduced residue system modulo $m$, (2) since $\gcd(a, m) = 1$, multiply each element by $a$ to form set $aR = \{ar_1, ar_2, \dots, ar_{\phi(m)}\}$, (3) prove the elements of $aR$ are distinct modulo $m$ (if $ar_i \equiv ar_j \pmod m$, multiplying by $a^{-1}$ gives $r_i \equiv r_j$), so $aR \equiv R \pmod m$ is a permutation, (4) equate the products of both sets modulo $m$: $\prod_{i=1}^{\phi(m)} (ar_i) \equiv \prod_{i=1}^{\phi(m)} r_i \pmod m \implies a^{\phi(m)} \prod r_i \equiv \prod r_i \pmod m$, (5) since $\gcd(\prod r_i, m) = 1$, cancel the product $\prod r_i$ to conclude $a^{\phi(m)} \equiv 1 \pmod m$.
3. **Slide 3 (`quiz`):** Test why the cancellation of $\prod r_i$ from $a^{\phi(m)} \prod r_i \equiv \prod r_i \pmod m$ is mathematically valid (because each $r_i$ is coprime to $m$, so their product is coprime to $m$, admitting a multiplicative inverse).
4. **Slide 4 (`proof`):** Interactive derivation of Wilson's Theorem: In $(p-1)! = 1 \cdot 2 \cdot \dots \cdot (p-1)$, pairing each element $x$ with its distinct inverse $x^{-1} \ne x$ leaves only elements satisfying $x^2 \equiv 1 \pmod p$, namely $x \equiv 1$ and $x \equiv -1 \equiv p-1$, giving product $1 \cdot (-1) \equiv -1 \pmod p$.
5. **Slide 5 (`one_word`):** Plain-text recall of the element whose powers generate the entire group $(\mathbb{Z}/p\mathbb{Z})^\times$ (primitive root / primitive).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Euler's Totient Generalization of Fermat's Little Theorem**\nLet $m \\ge 1$ be an integer, and let $a \\in \\mathbb{Z}$ be coprime to $m$ ($\\gcd(a, m) = 1$).\nThen:\n$$\na^{\\phi(m)} \\equiv 1 \\pmod m\n$$\n*(When $m = p$ is prime, $\\phi(p) = p - 1$, recovering Fermat's Little Theorem $a^{p-1} \\equiv 1 \\pmod p$).*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps of Euler's Totient Theorem using reduced residue systems.",
      "orderItems": [
        "Let R = {r_1, r_2, ..., r_{phi(m)}} be the set of phi(m) positive integers less than m coprime to m",
        "Form the multiplied set aR = {a r_1, a r_2, ..., a r_{phi(m)}} modulo m",
        "Prove that all elements of aR are distinct modulo m (since a r_i = a r_j mod m implies r_i = r_j mod m), so aR is a permutation of R modulo m",
        "Equate the product of all elements in both sets: prod_{i=1}^{phi(m)} (a r_i) = prod_{i=1}^{phi(m)} r_i mod m, which simplifies to a^{phi(m)} prod r_i = prod r_i mod m",
        "Since each r_i is coprime to m, the product P = prod r_i is coprime to m; multiplying by P^{-1} yields a^{phi(m)} = 1 mod m"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is it mathematically valid to cancel the term P = prod_{i=1}^{phi(m)} r_i from the congruence a^{phi(m)} P = P mod m?",
      "options": [
        { "text": "Because every r_i is coprime to m, so their product P is also coprime to m (gcd(P, m) = 1), meaning P has a multiplicative inverse modulo m", "isCorrect": true, "explanation": "Correct! When gcd(P, m) = 1, P is invertible in Z/mZ, allowing cancellation." },
        { "text": "Because P = 0 mod m", "isCorrect": false, "explanation": "Incorrect: If P = 0, cancellation is invalid." },
        { "text": "Because m must be a prime number", "isCorrect": false, "explanation": "Incorrect: Euler's theorem holds for all composite integers m." },
        { "text": "Because a = 1", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Wilson's Theorem (p-1)! = -1 mod p",
      "interactiveSteps": [
        {
          "stepText": "In the product (p-1)! = 1 * 2 * 3 * ... * (p-1) mod p, pair each element x with its unique modular inverse x^{-1} mod p."
        },
        {
          "prompt": "Which elements in {1, 2, ..., p-1} are their own inverses (satisfy x^2 = 1 mod p)?",
          "options": [
            { "text": "Only x = 1 and x = p - 1 (since x^2 - 1 = (x-1)(x+1) = 0 mod p)", "isCorrect": true },
            { "text": "All elements", "isCorrect": false },
            { "text": "Only x = 0", "isCorrect": false },
            { "text": "No elements", "isCorrect": false }
          ]
        },
        {
          "stepText": "Every intermediate element pairs with a distinct inverse to multiply to 1, leaving only 1 * (p - 1) = -1 mod p."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "An integer g whose powers generate the entire multiplicative group (Z/pZ)^* of order p - 1 is called a ___ root.",
      "blankAnswer": "primitive"
    }
  ]
}
```
