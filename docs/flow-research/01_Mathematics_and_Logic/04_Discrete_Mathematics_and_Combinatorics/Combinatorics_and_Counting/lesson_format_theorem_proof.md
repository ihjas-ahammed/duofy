# Duofy Reusable Lesson Format: Combinatorics & Counting - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Combinatorics_and_Counting`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through foundational combinatorial proofs: Principle of Inclusion-Exclusion (PIE) Derivation, Catalan Recurrence Relation $C_{n+1} = \\sum_{i=0}^n C_i C_{n-i}$, and Ramsey's Theorem $R(3,3) = 6$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Ramsey's Theorem R(3,3) Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Ramsey Pigeonhole Proof Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Derangement Formula Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Catalan Recurrence Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Ramsey Number Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Ramsey's Theorem $R(3, 3) = 6$**\nIn any group of 6 people, there exist either 3 mutual acquaintances (monochromatic triangle) or 3 mutual strangers.\n$$\nR(r, s) \\le R(r-1, s) + R(r, s-1)\n$$\nRamsey Theory proves that complete disorder is mathematically impossible!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove Ramsey's Theorem R(3, 3) = 6.",
      "orderItems": [
        "Consider a complete graph K_6 with 6 vertices, whose edges are colored RED or BLUE.",
        "Pick a single vertex v. Vertex v has 5 incident edges connected to 5 remaining vertices.",
        "By Pigeonhole Principle (5 edges, 2 colors), at least 3 edges incident to v share the same color (say RED).",
        "Let the 3 connected vertices be {a, b, c}. If any edge between {a, b, c} is RED, it forms a RED triangle with v.",
        "If no edge between {a, b, c} is RED, then all 3 edges between {a, b, c} must be BLUE, forming a BLUE triangle."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the asymptotic ratio of derangements $D_n$ to total permutations $n!$ as $n \\to \\infty$?",
      "options": [
        { "text": "1 / e ≈ 0.3679", "isCorrect": true, "explanation": "Correct! D_n / n! = sum_{k=0}^n (-1)^k / k! -> e^(-1) = 1/e." },
        { "text": "1 / 2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "1 / π", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Catalan OGF Functional Equation $x C(x)^2 - C(x) + 1 = 0$",
      "interactiveSteps": [
        { "stepText": "From recurrence $C_{n+1} = \\sum_{i=0}^n C_i C_{n-i}$, multiply by $x^{n+1}$ and sum over $n \\ge 0$." },
        {
          "prompt": "This converts the convolution sum into quadratic equation $x C(x)^2 - C(x) + 1 = 0$. Solving for $C(x)$ yields?",
          "options": [
            { "text": "C(x) = (1 - sqrt(1 - 4x)) / (2x)", "isCorrect": true },
            { "text": "C(x) = 1 / (1 - x)", "isCorrect": false },
            { "text": "C(x) = e^x", "isCorrect": false },
            { "text": "C(x) = sqrt(x)", "isCorrect": false }
          ]
        },
        { "stepText": "Expanding $(1 - 4x)^{1/2}$ via generalized Binomial Theorem yields exact formula $C_n = \\frac{1}{n+1} \\binom{2n}{n}$!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What principle states that placing n+1 items into n containers forces at least one container to hold two or more items?",
      "blankAnswer": "pigeonhole"
    }
  ]
}
```
