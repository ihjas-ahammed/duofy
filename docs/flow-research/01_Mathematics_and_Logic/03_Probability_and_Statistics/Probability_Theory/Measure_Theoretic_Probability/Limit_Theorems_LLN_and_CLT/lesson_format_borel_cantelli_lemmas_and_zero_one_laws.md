# Duofy Reusable Lesson Format: Borel-Cantelli Lemmas and Zero-One Laws

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory / Measure_Theoretic_Probability/Limit_Theorems_LLN_and_CLT`  
**Lesson Format Type:** `borel_cantelli_lemmas_and_zero_one_laws`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to analyze asymptotic "infinitely often" ($i.o.$) events $\limsup A_n = \bigcap_{n=1}^\infty \bigcup_{k=n}^\infty A_k$, apply the **First Borel-Cantelli Lemma (BC1)** ($\sum P(A_n) < \infty \implies P(A_n \text{ i.o.}) = 0$), apply the **Second Borel-Cantelli Lemma (BC2)** (independent events with $\sum P(A_n) = \infty \implies P(A_n \text{ i.o.}) = 1$), and evaluate **Kolmogorov's Zero-One Law** for tail $\sigma$-algebras.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Borel-Cantelli Lemmas & Limsup Definition Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step BC1 Union Bound Proof Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Zero-One Theorem & Event Independence Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Second Borel-Cantelli Independent Events Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Infinite Monkey Theorem Probability 1 Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of $\limsup A_n = \{A_n \text{ i.o.}\} = \bigcap_{n=1}^\infty \bigcup_{k=n}^\infty A_k$ (the event that infinitely many $A_n$ occur). State the First Borel-Cantelli Lemma (BC1): If $\sum_{n=1}^\infty P(A_n) < \infty$, then $P(\limsup A_n) = 0$ (holds with NO independence assumptions). State the Second Borel-Cantelli Lemma (BC2): If $\{A_n\}_{n=1}^\infty$ are **mutually independent** and $\sum_{n=1}^\infty P(A_n) = \infty$, then $P(\limsup A_n) = 1$. State Kolmogorov's 0-1 Law: For independent sequence $\{X_n\}$, any tail event $E \in \mathcal{T} = \bigcap_{n=1}^\infty \sigma(X_n, X_{n+1}, \dots)$ has probability $P(E) \in \{0, 1\}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct BC1 proof: (1) let $B_n = \bigcup_{k=n}^\infty A_k$, (2) observe that $B_n \downarrow \limsup A_n$ is a decreasing sequence, (3) by continuity of measure, $P(\limsup A_n) = \lim_{n \to \infty} P(B_n)$, (4) apply Boole's inequality (union bound): $P(B_n) = P\left(\bigcup_{k=n}^\infty A_k\right) \le \sum_{k=n}^\infty P(A_k)$, (5) since the infinite series converges ($\sum_{k=1}^\infty P(A_k) < \infty$), the tail sum $\sum_{k=n}^\infty P(A_k) \to 0$ as $n \to \infty$, forcing $P(\limsup A_n) = 0$!
3. **Slide 3 (`matching`):** Pair 4 probabilistic asymptotic theorems (First Borel-Cantelli, Second Borel-Cantelli, Kolmogorov's 0-1 Law, Hewitt-Savage 0-1 Law) with their mathematical conditions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the Second Borel-Cantelli Lemma crucially requires the sequence of events to be mutually independent. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the Infinite Monkey Theorem: If an immortal monkey types randomly on a keyboard of 50 keys, what does the Second Borel-Cantelli Lemma prove about the probability of eventually typing the complete works of Shakespeare? (Since the probability $p > 0$ of typing Shakespeare in any fixed block of $L$ keystrokes is strictly positive, the series of independent block probabilities $\sum_{n=1}^\infty p = \infty$ diverges to infinity, proving the works will be typed infinitely often with probability EXACTLY 1).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "borel_cantelli_lemmas_and_zero_one_laws",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Borel-Cantelli Lemmas and Zero-One Laws**\n• **Infinitely Often Event ($A_n \\text{ i.o.}$):**\n$$\n\\limsup_{n \\to \\infty} A_n = \\bigcap_{n=1}^\\infty \\bigcup_{k=n}^\\infty A_k = \\{\\omega \\in \\Omega \\mid \\omega \\in A_n \\text{ for infinitely many } n\\}\n$$\n• **First Borel-Cantelli Lemma (BC1):**\n$$\n\\sum_{n=1}^\\infty P(A_n) < \\infty \\implies P(A_n \\text{ i.o.}) = 0 \\quad (\\text{Holds unconditionally!})\n$$\n• **Second Borel-Cantelli Lemma (BC2):** If events $\\{A_n\\}$ are **mutually independent**:\n$$\n\\sum_{n=1}^\\infty P(A_n) = \\infty \\implies P(A_n \\text{ i.o.}) = 1\n$$\n• **Kolmogorov's 0-1 Law:** For independent $\\{X_n\\}$, every tail event $E \\in \\mathcal{T}$ has $P(E) \\in \\{0, 1\\}$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Define Tail Unions):** Let $B_n = \\bigcup_{k=n}^\\infty A_k$.\n• **Step 2 (Monotone Convergence):** As $n \\to \\infty$, the sequence of sets shrinks monotonically: $B_n \\downarrow \\limsup A_n$.\n• **Step 3 (Continuity of Measure):** $P(\\limsup A_n) = \\lim_{n \\to \\infty} P(B_n)$.\n• **Step 4 (Apply Union Bound):** $P(B_n) = P\\left( \\bigcup_{k=n}^\\infty A_k \\right) \\le \\sum_{k=n}^\\infty P(A_k)$.\n• **Step 5 (Vanishing Tail Sum):** Because the total series $\\sum_{k=1}^\\infty P(A_k) < \\infty$ converges, the remaining tail sum $\\sum_{k=n}^\\infty P(A_k) \\to 0$, forcing $P(\\limsup A_n) = 0$!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each asymptotic 0-1 theorem to its hypothesis requirements.",
      "matchPairs": [
        { "left": "First Borel-Cantelli Lemma", "right": "Finite sum sum P(A_n) < infty (requires NO independence)" },
        { "left": "Second Borel-Cantelli Lemma", "right": "Infinite sum sum P(A_n) = infty WITH mutual independence" },
        { "left": "Kolmogorov's 0-1 Law", "right": "Independent sequence X_n (tail sigma-algebra contains only prob 0 and 1 events)" },
        { "left": "Hewitt-Savage 0-1 Law", "right": "Exchangeable / i.i.d. sequences (symmetric events have probability 0 or 1)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Unlike the first lemma, the Second Borel-Cantelli Lemma crucially requires the sequence of events A_n to be mutually ___.",
      "blankAnswer": "independent",
      "blankDistractors": ["disjoint", "monotonic", "continuous"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "By the Second Borel-Cantelli Lemma, what is the probability that an immortal monkey typing uniformly at random on a keyboard will eventually produce the complete text of Hamlet?",
      "options": [
        { "text": "Probability EXACTLY 1 (since each independent chunk of length L has small positive probability p > 0, the sum of probabilities sum_{k=1}^infty p = infty diverges, guaranteeing infinite occurrences a.s.)", "isCorrect": true, "explanation": "Correct! Because each non-overlapping text block is independent with probability p > 0, the infinite sum sum p = infty forces P(Hamlet appears infinitely often) = 1 by BC2." },
        { "text": "Probability 0 because p is too small", "isCorrect": false, "explanation": "Incorrect: BC2 guarantees occurrence when the sum diverges." },
        { "text": "Probability 1/2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Cannot be determined", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
