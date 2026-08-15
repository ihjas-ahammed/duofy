# Duofy Reusable Lesson Format: Analytic Number Theory - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Analytic_Number_Theory`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through foundational proofs in analytic number theory: Euler Product Formula Derivation, Non-vanishing of $\zeta(1 + i t)$, and Dirichlet's Theorem on Primes in Arithmetic Progressions.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Euler Product Formula Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Sieve of Eratosthenes Proof Strategy Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Non-Zero Region Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Dirichlet Convolution Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Analytic Continuity Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The Euler Product Formula**\nFor $\\text{Re}(s) > 1$, the Dirichlet series for $\\zeta(s)$ equals the product over all primes:\n$$\n\\zeta(s) = \\sum_{n=1}^\\infty \\frac{1}{n^s} = \\prod_{p \\text{ prime}} \\frac{1}{1 - p^{-s}}\n$$\nThis identity establishes that the fundamental theorem of arithmetic can be analyzed using complex functions."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove the Euler Product Formula via Sieve of Eratosthenes.",
      "orderItems": [
        "Write full Dirichlet series: ζ(s) = 1 + 1/2^s + 1/3^s + 1/4^s + ...",
        "Multiply by 1/2^s and subtract: (1 - 1/2^s) ζ(s) = 1 + 1/3^s + 1/5^s + ... (removes even multiples).",
        "Multiply by (1 - 1/3^s) and subtract to remove multiples of 3.",
        "Repeat sieve for all primes up to p_k: ∏_{p ≤ p_k} (1 - p^(-s)) ζ(s) = 1 + ∑_{n not div by primes} 1/n^s.",
        "Take limit as k -> ∞: product ∏_p (1 - p^(-s)) ζ(s) = 1, proving ζ(s) = ∏_p (1 - p^(-s))^(-1)."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the non-vanishing of $\\zeta(s)$ on the line $\\text{Re}(s) = 1$ ($\\zeta(1 + i t) \\neq 0$) crucial for proving the Prime Number Theorem?",
      "options": [
        { "text": "It guarantees that log ζ(s) has no singular pole or branch cut on Re(s)=1, allowing contour integration for PNT", "isCorrect": true, "explanation": "Correct! Hadamard and de la Vallée Poussin proved PNT by establishing 3 + 4 cos θ + cos 2θ ≥ 0 to show ζ(1+it) ≠ 0." },
        { "text": "Because it proves all primes are odd", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because it forces ζ(s) to be zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because it bounds π(x) by x²", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Dirichlet Character Orthogonality",
      "interactiveSteps": [
        { "stepText": "Let $\\chi$ be a Dirichlet character modulo $q$. The orthogonality relation states $\\sum_{a \\pmod q} \\chi(a) = 0$ if $\\chi \\neq \\chi_0$." },
        {
          "prompt": "What does this orthogonality allow us to isolate when summing over primes?",
          "options": [
            { "text": "Primes in a specific arithmetic progression a + n q", "isCorrect": true },
            { "text": "Even numbers only", "isCorrect": false },
            { "text": "Square-free numbers", "isCorrect": false },
            { "text": "Complex roots", "isCorrect": false }
          ]
        },
        { "stepText": "Evaluating $L(1, \\chi) \\neq 0$ for non-principal characters proves Dirichlet's Theorem: infinitely many primes in $a + n q$!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What arithmetic inversion formula states that if g(n) = sum_{d|n} f(d), then f(n) = sum_{d|n} mu(d) g(n/d)?",
      "blankAnswer": "mobius"
    }
  ]
}
```
