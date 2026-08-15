# Duofy Reusable Lesson Format: Combinatorics & Counting - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Combinatorics_and_Counting`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Permutations, Combinations $\binom{n}{k}$, Inclusion-Exclusion Principle (PIE), Pigeonhole Principle (PHP), Catalan Numbers $C_n = \frac{1}{n+1} \binom{2n}{n}$, and Generating Functions $A(x) = \sum a_n x^n$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Combinatorial Counting Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Generating Functions & Catalan Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Combinatorial Counting Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Binomial Coefficient Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Pigeonhole Principle Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Binomial Coefficients & Inclusion-Exclusion**\n1. **Combinations $\\binom{n}{k}$:** Number of ways to choose $k$ items from $n$ items without regard to order:\n$$\n\\binom{n}{k} = \\frac{n!}{k!(n-k)!}\n$$\n2. **Principle of Inclusion-Exclusion (PIE):**\n$$\n|A \\cup B \\cup C| = |A| + |B| + |C| - (|A \\cap B| + |A \\cap C| + |B \\cap C|) + |A \\cap B \\cap C|\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Pigeonhole Principle:** If $n+1$ items are placed into $n$ containers, at least one container holds $\\ge 2$ items.\n• **Catalan Numbers ($C_n = \\frac{1}{n+1} \\binom{2n}{n}$):** Counts valid parentheses strings of length $2n$, full binary trees with $n+1$ leaves, and non-crossing chord partitions.\n• **Stars and Bars:** Number of ways to distribute $n$ identical items into $k$ distinct bins is $\\binom{n + k - 1}{k - 1}$.\n• **Generating Functions:** Encodes discrete sequence $a_n$ as coefficients of formal power series $A(x) = \\sum_{n=0}^\\infty a_n x^n$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each combinatorial concept to its standard formula.",
      "matchPairs": [
        { "left": "Binomial Coefficient", "right": "n! / (k! * (n - k)!)" },
        { "left": "Catalan Number C_n", "right": "(1 / (n + 1)) * (2n choose n)" },
        { "left": "Stars and Bars", "right": "(n + k - 1 choose k - 1)" },
        { "left": "Derangements D_n", "right": "n! * sum_{k=0}^n ((-1)^k / k!)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The number of ways to choose k items from a set of n items without regard to order is given by the ___ coefficient.",
      "blankAnswer": "binomial",
      "blankDistractors": ["catalan", "fibonacci", "stirling"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the 3rd Catalan number $C_3 = \\frac{1}{4} \\binom{6}{3}$ (counts valid expressions with 3 pairs of parentheses `((()))`, `()()()`, `(())()`, `()(())`, `(()())`)?",
      "options": [
        { "text": "5", "isCorrect": true, "explanation": "Correct! C₃ = (1/4) * (20) = 5 valid parenthesizations." },
        { "text": "3", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "14", "isCorrect": false, "explanation": "Incorrect: 14 is C₄." },
        { "text": "2", "isCorrect": false, "explanation": "Incorrect: 2 is C₂." }
      ]
    }
  ]
}
```
