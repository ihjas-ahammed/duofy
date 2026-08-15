# Duofy Reusable Lesson Format: Analytic Continuation - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis / Analytic_Continuation`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the concept of Analytic Continuation of holomorphic functions, the Identity Principle for uniqueness, function elements $(f, D)$, and the transition from single disks of convergence to global domains.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Analytic Continuation & Identity Principle | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Power Series Chain Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Extension Technique Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Identity Principle Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Uniqueness & Natural Boundary Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of analytic continuation: given $(f_1, D_1)$ and $(f_2, D_2)$ with $D_1 \cap D_2 \ne \emptyset$, $f_2$ is a continuation of $f_1$ if $f_2(z) = f_1(z)$ on $D_1 \cap D_2$.
2. **Slide 2 (`concept_pieces`):** Deconstruct overlapping disks, identity theorem rigidity, monodromy branch changes, and natural boundaries.
3. **Slide 3 (`matching`):** Pair 4 continuation concepts (Weierstrassian continuation, Schwarz reflection, Monodromy theorem, Natural boundary) with their exact descriptions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the Identity Principle guarantees uniqueness of continuation on connected domains. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking about the geometric series $\sum z^n$ analytic continuation to $\frac{1}{1-z}$ across the unit circle $|z|=1$.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Analytic Continuation**\nLet $f_1$ be holomorphic on domain $D_1$. A function $f_2$ holomorphic on domain $D_2$ is an **analytic continuation** of $f_1$ to $D_2$ if $D_1 \\cap D_2 \\ne \\emptyset$ and:\n$$\nf_2(z) = f_1(z) \\quad \\text{for all } z \\in D_1 \\cap D_2\n$$\nBy the **Identity Principle**, if $D_1 \\cup D_2$ is connected, this extension is uniquely determined."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Local to Global:** Holomorphic functions are rigid; knowing Taylor coefficients at a single point determines the function everywhere it can be continued.\n• **Chain of Disks:** Continuation along a path $\\gamma$ is performed by a chain of overlapping disks with expanding power series.\n• **Branch Ambiguity:** Continuing around a singularity can produce different values (e.g. $\\ln z$ picks up $+2\\pi i$ per loop around 0).\n• **Natural Boundary:** A curve beyond which no power series can be continued (every point on the boundary is a singularity)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each analytic continuation concept to its mathematical description.",
      "matchPairs": [
        { "left": "Schwarz Reflection Principle", "right": "Extends real-valued holomorphic functions across the real axis" },
        { "left": "Monodromy Theorem", "right": "Guarantees path-independence of continuation in simply connected domains" },
        { "left": "Identity Theorem", "right": "Ensures analytic continuations are strictly unique on connected domains" },
        { "left": "Natural Boundary", "right": "A boundary impenetrable to analytic continuation" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Identity Principle guarantees that if an analytic continuation exists on a connected domain, it is strictly ___.",
      "blankAnswer": "unique",
      "blankDistractors": ["infinite", "periodic", "zero"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "The power series f(z) = sum_{n=0}^infty z^n converges only on the open disk |z| < 1. What is its analytic continuation to C \\ {1}?",
      "options": [
        { "text": "f(z) = 1 / (1 - z), a rational function with a simple pole at z = 1", "isCorrect": true, "explanation": "Correct! The rational function 1/(1-z) is holomorphic on all of C \\ {1} and equals the power series on |z| < 1." },
        { "text": "f(z) = e^z", "isCorrect": false, "explanation": "Incorrect: e^z does not equal sum z^n on the unit disk." },
        { "text": "f(z) = ln(1 - z)", "isCorrect": false, "explanation": "Incorrect: -ln(1-z) is the continuation of sum z^n/n." },
        { "text": "No analytic continuation exists", "isCorrect": false, "explanation": "Incorrect: The function continues everywhere except at the isolated pole z = 1." }
      ]
    }
  ]
}
```
