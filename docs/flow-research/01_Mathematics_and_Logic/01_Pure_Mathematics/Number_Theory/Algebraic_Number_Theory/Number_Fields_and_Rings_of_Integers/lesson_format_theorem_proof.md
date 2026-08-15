# Duofy Reusable Lesson Format: Number Fields and Rings of Integers - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Algebraic_Number_Theory / Number_Fields_and_Rings_of_Integers`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof of the **Dedekind-Kummer Theorem** for factoring rational primes $(p)$ into prime ideals in $\mathcal{O}_K$ via polynomial factorization modulo $p$, and prove the **Finiteness of the Ideal Class Group via Minkowski's Lattice Convex Body Theorem**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Dedekind-Kummer Prime Ideal Factorization Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Modulo-p Ring Isomorphism Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Index Coprimality Hypothesis Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Minkowski Convex Body Lattice Point Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Quadratic Ring Classification Modulo Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Dedekind-Kummer Theorem: Let $K = \mathbb{Q}(\theta)$ with $\theta \in \mathcal{O}_K$ minimal polynomial $f(x) \in \mathbb{Z}[x]$. If $p \nmid [\mathcal{O}_K : \mathbb{Z}[\theta]]$ and $f(x) \equiv \bar{g}_1(x)^{e_1} \dots \bar{g}_k(x)^{e_k} \pmod p$, then $(p) = \mathfrak{p}_1^{e_1} \dots \mathfrak{p}_k^{e_k}$ where $\mathfrak{p}_i = (p, g_i(\theta))$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof: (1) let index $p \nmid [\mathcal{O}_K : \mathbb{Z}[\theta]]$, so $\mathcal{O}_K/p\mathcal{O}_K \cong \mathbb{Z}[\theta]/p\mathbb{Z}[\theta]$, (2) express the quotient ring as $\mathbb{Z}[x] / (p, f(x)) \cong \mathbb{F}_p[x] / (\bar{f}(x))$, (3) factor $\bar{f}(x) = \prod \bar{g}_i(x)^{e_i}$ into irreducible polynomials over $\mathbb{F}_p$, (4) by the Chinese Remainder Theorem, $\mathbb{F}_p[x] / (\bar{f}(x)) \cong \prod \mathbb{F}_p[x] / (\bar{g}_i(x)^{e_i})$, (5) identify the prime ideals containing $(p)$ as the maximal ideals $\mathfrak{p}_i = (p, g_i(\theta))$ with ramification indices $e_i$.
3. **Slide 3 (`quiz`):** Test why the index condition $p \nmid [\mathcal{O}_K : \mathbb{Z}[\theta]]$ is necessary for the isomorphism $\mathcal{O}_K/p\mathcal{O}_K \cong \mathbb{Z}[\theta]/p\mathbb{Z}[\theta]$.
4. **Slide 4 (`proof`):** Interactive derivation of Minkowski's Theorem: Any centrally symmetric convex body $S \subset \mathbb{R}^n$ with $\operatorname{Vol}(S) > 2^n \operatorname{covol}(\Lambda)$ contains a non-zero lattice point of $\Lambda$.
5. **Slide 5 (`one_word`):** Plain-text recall of the integer modulo used to classify quadratic field integer rings ($d \equiv 1 \pmod 4 \implies$ four).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Dedekind-Kummer Prime Factorization Theorem**\nLet $K = \\mathbb{Q}(\\theta)$ with $\\theta \\in \\mathcal{O}_K$ having minimal polynomial $f(x) \\in \\mathbb{Z}[x]$.\nLet $p$ be a rational prime not dividing the index $[\\mathcal{O}_K : \\mathbb{Z}[\\theta]]$.\nIf $f(x)$ factors modulo $p$ into distinct monic irreducible polynomials as:\n$$\nf(x) \\equiv g_1(x)^{e_1} g_2(x)^{e_2} \\cdots g_k(x)^{e_k} \\pmod p\n$$\nThen the principal ideal $(p) = p\\mathcal{O}_K$ factors into prime ideals as:\n$$\np\\mathcal{O}_K = \\mathfrak{p}_1^{e_1} \\mathfrak{p}_2^{e_2} \\cdots \\mathfrak{p}_k^{e_k}, \\quad \\text{where } \\mathfrak{p}_i = (p, \\, g_i(\\theta))\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps of the Dedekind-Kummer Theorem via quotient rings.",
      "orderItems": [
        "Use the index condition p does not divide [O_K : Z[theta]] to establish the isomorphism O_K / p O_K = Z[theta] / p Z[theta]",
        "Map Z[theta] / p Z[theta] to the polynomial quotient ring F_p[x] / (f_bar(x))",
        "Factor f_bar(x) = prod_{i=1}^k g_bar_i(x)^{e_i} into irreducibles in the polynomial ring F_p[x]",
        "Apply the Chinese Remainder Theorem: F_p[x] / (f_bar(x)) = prod_{i=1}^k F_p[x] / (g_bar_i(x)^{e_i})",
        "Pull back the maximal ideals of each factor to deduce that the prime ideals lying over p are precisely p_i = (p, g_i(theta)) with powers e_i"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the index condition p does not divide [O_K : Z[theta]] essential in the Dedekind-Kummer theorem?",
      "options": [
        { "text": "If p divides the index, Z[theta] is not p-maximal in O_K, so the ring isomorphism O_K / p O_K = Z[theta] / p Z[theta] fails", "isCorrect": true, "explanation": "Correct! When p divides the index, p-torsion creates discrepancies between Z[theta] and the full integer ring O_K." },
        { "text": "Because p must be negative", "isCorrect": false, "explanation": "Incorrect: Primes are positive." },
        { "text": "Because f(x) has no roots", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Dedekind domains cannot have index > 1", "isCorrect": false, "explanation": "Incorrect: [O_K : Z[theta]] can be any positive integer." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Minkowski's Convex Body Theorem",
      "interactiveSteps": [
        {
          "stepText": "Let Lambda be a full-rank lattice in R^n with fundamental domain volume det(Lambda). Let S be a convex, centrally symmetric body (x in S => -x in S)."
        },
        {
          "prompt": "According to Minkowski's Theorem, if Vol(S) > 2^n det(Lambda), what must S contain?",
          "options": [
            { "text": "At least one non-zero lattice point v in Lambda \\ {0}", "isCorrect": true },
            { "text": "No lattice points", "isCorrect": false },
            { "text": "Only the origin 0", "isCorrect": false },
            { "text": "Infinitely many prime numbers", "isCorrect": false }
          ]
        },
        {
          "stepText": "Applying this to the canonical embedding of O_K yields an element in every ideal class bounded by M_K, proving finiteness of the class group."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "In quadratic fields Q(sqrt(d)), O_K contains half-integers (1 + sqrt(d))/2 if and only if d is congruent to 1 modulo ___.",
      "blankAnswer": "four"
    }
  ]
}
```
