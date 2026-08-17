# Duofy Reusable Lesson Format: Kolmogorov Probability Spaces and Sigma-Algebras

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory / Measure_Theoretic_Probability/Probability_Spaces_and_Random_Variables`  
**Lesson Format Type:** `kolmogorov_probability_spaces_and_sigma_algebras`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the axiomatic foundation of probability: **Kolmogorov Probability Spaces** $(\Omega, \mathcal{F}, P)$, verify the 3 axioms of a **$\sigma$-Algebra** ($\Omega \in \mathcal{F}$, complementation, countable unions), evaluate **Countable Additivity** ($P(\bigcup A_i) = \sum P(A_i)$ for disjoint sets), and prove the Continuity of Probability from below ($P(\lim A_n) = \lim P(A_n)$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Kolmogorov Triple & Sigma-Algebra Formal Axioms Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Continuity of Measure from Below Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Sigma-Algebra Closure Operation Rules Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Countable Additivity vs Finite Additivity Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Measure Theory Probability Space Middle Element Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the 3 components of a Kolmogorov Probability Space $(\Omega, \mathcal{F}, P)$: (1) Sample space $\Omega \ne \emptyset$, (2) $\sigma$-Algebra $\mathcal{F} \subseteq 2^\Omega$ satisfying: (a) $\Omega \in \mathcal{F}$, (b) Complementation: $A \in \mathcal{F} \implies A^c \in \mathcal{F}$, (c) Countable Unions: $A_1, A_2, \dots \in \mathcal{F} \implies \bigcup_{i=1}^\infty A_i \in \mathcal{F}$. (3) Probability Measure $P: \mathcal{F} \to [0, 1]$ satisfying: (a) Non-negativity $P(A) \ge 0$, (b) Total mass $P(\Omega) = 1$, (c) Countable Additivity: For pairwise disjoint sequence $\{A_i\}_{i=1}^\infty$ ($A_i \cap A_j = \emptyset$), $P\left(\bigcup_{i=1}^\infty A_i\right) = \sum_{i=1}^\infty P(A_i)$.
2. **Slide 2 (`ordering`):** Provide 5 steps proving the Continuity of Measure for increasing sequence $A_1 \subseteq A_2 \subseteq A_3 \subseteq \dots \uparrow A = \bigcup A_n$: (1) construct disjointized sequence $E_1 = A_1$ and $E_k = A_k \setminus A_{k-1}$ for $k \ge 2$, (2) note that $\{E_k\}_{k=1}^\infty$ are pairwise disjoint and $\bigcup_{k=1}^\infty E_k = \bigcup_{n=1}^\infty A_n = A$, (3) express $P(A) = P\left(\bigcup_{k=1}^\infty E_k\right) = \sum_{k=1}^\infty P(E_k)$ by Countable Additivity, (4) express infinite series as limit of partial sums: $\lim_{n \to \infty} \sum_{k=1}^n P(E_k)$, (5) telescope partial sum: $\sum_{k=1}^n P(E_k) = P(E_1) + \sum_{k=2}^n [P(A_k) - P(A_{k-1})] = P(A_n)$, concluding $P(A) = \lim_{n \to \infty} P(A_n)$.
3. **Slide 3 (`quiz`):** Test closure properties of a $\sigma$-algebra: Why is a $\sigma$-algebra automatically closed under COUNTABLE INTERSECTIONS ($\bigcap_{i=1}^\infty A_i \in \mathcal{F}$)? (By De Morgan's Laws: $\bigcap_{i=1}^\infty A_i = \left(\bigcup_{i=1}^\infty A_i^c\right)^c$; since each $A_i^c \in \mathcal{F}$, their countable union is in $\mathcal{F}$, and the outer complement is in $\mathcal{F}$).
4. **Slide 4 (`proof`):** Interactive derivation showing that finite additivity $P(A \cup B) = P(A) + P(B)$ is a trivial special case of countable additivity by setting $A_3 = A_4 = \dots = \emptyset$ with $P(\emptyset) = 0$.
5. **Slide 5 (`one_word`):** Plain-text recall of the mathematical term for the collection of measurable subsets $\mathcal{F}$ in the triple $(\Omega, \mathcal{F}, P)$ (sigma-algebra / sigma_algebra).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "kolmogorov_probability_spaces_and_sigma_algebras",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Kolmogorov Probability Space $(\\Omega, \\mathcal{F}, P)$ (1933)**\n• **1. Sample Space $\\Omega$:** Non-empty set of all possible outcomes.\n• **2. $\\sigma$-Algebra $\\mathcal{F}$:** Collection of measurable events satisfying:\n  - $\\Omega \\in \\mathcal{F}$.\n  - **Closed under Complementation:** $A \\in \\mathcal{F} \\implies A^c \\in \\mathcal{F}$.\n  - **Closed under Countable Unions:** $A_1, A_2, \\dots \\in \\mathcal{F} \\implies \\bigcup_{i=1}^\\infty A_i \\in \\mathcal{F}$.\n• **3. Probability Measure $P$:** Function $P: \\mathcal{F} \\to [0, 1]$ satisfying:\n  - $P(\\Omega) = 1, \\quad P(\\emptyset) = 0$.\n  - **Countable Additivity ($\\sigma$-Additivity):** For pairwise disjoint events $A_i \\cap A_j = \\emptyset$:\n$$\nP\\left( \\bigcup_{i=1}^\\infty A_i \\right) = \\sum_{i=1}^\\infty P(A_i)\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps establishing Continuity of Probability for increasing sets: A_n uparrow A => P(A_n) -> P(A).",
      "orderItems": [
        "Construct disjoint ring segments E_1 = A_1 and E_k = A_k \\setminus A_{k-1} for k >= 2",
        "Verify that sets {E_k} are pairwise disjoint and satisfy union_{k=1}^infty E_k = union_{n=1}^infty A_n = A",
        "Apply the Countable Additivity axiom to the union of disjoint sets: P(A) = sum_{k=1}^infty P(E_k)",
        "Write the infinite sum as the limit of finite partial sums: lim_{n -> infty} sum_{k=1}^n P(E_k)",
        "Telescope the sum sum_{k=1}^n P(E_k) = P(A_n), concluding that P(A) = lim_{n -> infty} P(A_n)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is every sigma-algebra F automatically closed under COUNTABLE INTERSECTIONS (if A_1, A_2, ... in F, then bigcap_{i=1}^infty A_i in F)?",
      "options": [
        { "text": "By De Morgan's Law: bigcap A_i = (bigcup A_i^c)^c; since F is closed under complementation and countable unions, the intersection is guaranteed to lie in F", "isCorrect": true, "explanation": "Correct! Complement of each set A_i^c is in F, their countable union is in F, and the outer complement is in F, proving closure under countable intersections." },
        { "text": "Because all sets in F are disjoint", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because intersections are always empty", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because F contains all subsets of Omega", "isCorrect": false, "explanation": "Incorrect: F is generally a proper subset of the power set." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Finite Additivity as a Special Case of Countable Additivity",
      "interactiveSteps": [
        {
          "stepText": "Let A and B be disjoint events in F (A cap B = emptyset). We want to show P(A cup B) = P(A) + P(B)."
        },
        {
          "prompt": "How is the countable sequence {A_i}_{i=1}^infty constructed to apply countable additivity?",
          "options": [
            { "text": "Set A_1 = A, A_2 = B, and A_k = emptyset for all k >= 3", "isCorrect": true },
            { "text": "Set A_k = Omega for all k >= 3", "isCorrect": false },
            { "text": "Set A_k = A cap B", "isCorrect": false },
            { "text": "Set A_k = [0, 1]", "isCorrect": false }
          ]
        },
        {
          "stepText": "Since P(emptyset) = 0, countable additivity gives P(A cup B cup emptyset cup ...) = P(A) + P(B) + 0 + 0 + ... = P(A) + P(B)!"
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "In the Kolmogorov triple (Omega, F, P), what hyphenated term denotes the collection of measurable subsets F?",
      "blankAnswer": "sigma-algebra"
    }
  ]
}
```
