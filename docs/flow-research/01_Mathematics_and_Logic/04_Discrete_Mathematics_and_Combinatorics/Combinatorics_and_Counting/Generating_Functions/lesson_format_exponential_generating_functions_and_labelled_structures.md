# Duofy Reusable Lesson Format: Exponential Generating Functions and Labelled Structures

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Combinatorics_and_Counting / Generating_Functions`  
**Lesson Format Type:** `exponential_generating_functions_and_labelled_structures`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through **Exponential Generating Functions (EGFs)** $\hat{A}(x) = \sum_{n=0}^\infty a_n \frac{x^n}{n!}$, understand why the $n!$ denominator naturally models **Labelled Combinatorial Structures**, master the **Exponential Formula (The Compositional Principle)** ($\hat{C}(x) = \exp(\hat{G}(x))$ building all structures from connected components), and derive the closed-form for **Derangements** ($!n = n! \sum \frac{(-1)^k}{k!} \approx \frac{n!}{e}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | EGF Definition & Labelled Convolution Product Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Derangements EGF Derivation Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Combinatorial Object & EGF Generating Series Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical Derangements !4 Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Compositional Principle Exp Formula for Connected Graphs Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of the Exponential Generating Function (EGF): For a sequence $\{a_n\}_{n=0}^\infty$, $\hat{A}(x) = \sum_{n=0}^\infty a_n \frac{x^n}{n!} = a_0 + a_1 x + a_2 \frac{x^2}{2!} + \dots$. Crucial operations: (1) Extraction: $n! [x^n] \hat{A}(x) = a_n$, (2) Product Rule (Binomial Convolution): $\hat{A}(x)\hat{B}(x) = \sum_{n=0}^\infty \left( \sum_{k=0}^n \binom{n}{k} a_k b_{n-k} \right) \frac{x^n}{n!}$, (3) The Exponential Formula (Compositional Theorem / Richard Stanley): If $\hat{G}(x)$ is the EGF for connected/atomic structures, then $\hat{F}(x) = \exp(\hat{G}(x))$ is the EGF for all structures formed by disjoint sets of connected components.
2. **Slide 2 (`concept_pieces`):** Deconstruct derangement EGF derivation: (1) every permutation of $n$ elements can be partitioned into $k$ fixed points (1-cycles) and $n-k$ elements with no fixed points (derangement $d_{n-k}$), (2) write identity: $n! = \sum_{k=0}^n \binom{n}{k} d_{n-k} \cdot 1$, (3) recognize this as the binomial convolution of sequence $d_n$ with constant sequence $1$, (4) express in EGFs: $\sum n! \frac{x^n}{n!} = \hat{D}(x) \cdot \left(\sum \frac{x^n}{n!}\right) \implies \frac{1}{1-x} = \hat{D}(x) e^x$, (5) isolate $\hat{D}(x) = \frac{e^{-x}}{1-x} = \left(\sum_{k=0}^\infty \frac{(-1)^k x^k}{k!}\right)\left(\sum_{m=0}^\infty x^m\right)$, extracting $d_n = !n = n! \sum_{k=0}^n \frac{(-1)^k}{k!}$.
3. **Slide 3 (`matching`):** Pair 4 labelled structures (All Permutations $n!$, Derangements $!n$, Set Partitions / Bell Numbers $B_n$, Cayley's Labelled Trees $n^{n-2}$) with their exact EGFs.
4. **Slide 4 (`numerical`):** Ask student: Using the derangement formula $!n = n! \sum_{k=0}^n \frac{(-1)^k}{k!}$, calculate the exact number of derangements of $n = 4$ elements: $!4 = 24 \times (1 - 1 + 1/2 - 1/6 + 1/24) = 24 \times (12/24 - 4/24 + 1/24) = 24 \times \frac{9}{24} = 9$ (numeric answer: 9).
5. **Slide 5 (`quiz`):** Quiz on the Exponential Formula $\hat{F}(x) = \exp(\hat{C}(x))$: If $\hat{C}(x)$ is the EGF for connected graphs, what does $\hat{F}(x) = \exp(\hat{C}(x))$ enumerate? (All general graphs, because any graph is uniquely a disjoint union of connected graph components, and the exponential function algebraically creates all possible partitions of vertex labels among the components).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "exponential_generating_functions_and_labelled_structures",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Exponential Generating Functions (EGFs)**\n• For a sequence $\\{a_n\\}_{n=0}^\\infty$ enumerating **labelled combinatorial structures**:\n$$\n\\hat{A}(x) = \\sum_{n=0}^\\infty a_n \\frac{x^n}{n!} = a_0 + a_1 x + a_2 \\frac{x^2}{2!} + \\dots\n$$\n• **The Binomial Convolution Product:**\n$$\n\\hat{A}(x) \\hat{B}(x) = \\sum_{n=0}^\\infty \\left( \\sum_{k=0}^n \\binom{n}{k} a_k b_{n-k} \\right) \\frac{x^n}{n!}\n$$\n(The $\\binom{n}{k}$ factor selects which $k$ labels of the $n$-element universe belong to structure $A$, while the remaining $n-k$ labels go to $B$!).\n• **The Exponential Formula (Herbert Wilf & Richard Stanley):**\n$$\n\\hat{F}(x) = \\exp(\\hat{G}(x))\n$$\nwhere $\\hat{G}(x)$ generates connected/atomic objects and $\\hat{F}(x)$ generates all composite objects."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Permutation Decomposition):** Every permutation of $n$ elements has $k$ fixed points and $n-k$ deranged elements: $n! = \\sum_{k=0}^n \\binom{n}{k} 1 \\cdot d_{n-k}$.\n• **Step 2 (Binomial Convolution):** Recognize LHS as EGF of all permutations $\\sum n! \\frac{x^n}{n!} = \\frac{1}{1-x}$.\n• **Step 3 (EGF Multiplication):** $\\frac{1}{1-x} = e^x \\hat{D}(x)$, where $e^x$ generates fixed points and $\\hat{D}(x)$ generates derangements.\n• **Step 4 (Isolate $\\hat{D}(x)$):** Multiply by $e^{-x}$ to obtain $\\hat{D}(x) = \\frac{e^{-x}}{1-x}$.\n• **Step 5 (Extract Coefficients):** Expand $\\hat{D}(x) = \\left(\\sum \\frac{(-1)^k x^k}{k!}\\right)(\\sum x^m)$ to extract $!n = n! \\sum_{k=0}^n \\frac{(-1)^k}{k!}$!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each labelled combinatorial structure to its closed-form EGF.",
      "matchPairs": [
        { "left": "All Permutations (n!)", "right": "1 / (1 - x)" },
        { "left": "Derangements (!n)", "right": "exp(-x) / (1 - x)" },
        { "left": "Bell Numbers B_n (Set Partitions)", "right": "exp(exp(x) - 1) (Dobinski's formula generator)" },
        { "left": "Permutations of Odd Cycles Only", "right": "sqrt((1 + x) / (1 - x))" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Using the derangement formula !n = n! * sum_{k=0}^n (-1)^k / k!, calculate the exact number of derangements !4 of a 4-element set.",
      "numericAnswer": 9,
      "numericTolerance": 0
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "According to the Exponential Formula F(x) = exp(G(x)), if G(x) is the Exponential Generating Function for CONNECTED graphs on labelled vertices, what does F(x) generate?",
      "options": [
        { "text": "ALL graphs (both connected and disconnected), because any graph is uniquely partitioned into a collection of connected components, and exp(G(x)) automatically sums over all possible label partitions", "isCorrect": true, "explanation": "Correct! The exponential operator exp(G(x)) = sum G(x)^k / k! takes all sets of k connected components and distributes the n labels among them without regard to component ordering." },
        { "text": "Only empty graphs", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Only bipartite graphs", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The derivative of G(x)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
