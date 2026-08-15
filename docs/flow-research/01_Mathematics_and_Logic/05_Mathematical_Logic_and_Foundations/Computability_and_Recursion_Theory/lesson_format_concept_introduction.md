# Duofy Reusable Lesson Format: Computability Theory - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Computability_and_Recursion_Theory`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Turing Machines, the Halting Problem $K = \{e \mid \phi_e(e) \downarrow\}$, Rice's Theorem, $S_{m,n}$ Theorem, and Turing Degrees $0'$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Turing Machine & Halting Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Rice's Theorem & Reducibility Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Computability Concept Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Church-Turing Thesis Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Rice's Theorem Scope Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: The Halting Problem & Turing Machines**\nLet $\\phi_e(x)$ be the output of the $e$-th Turing Machine on input $x$.\n**The Halting Set $K$:**\n$$\nK = \\{ e \\in \\mathbb{N} \\mid \\phi_e(e) \\downarrow \\}\n$$\n$K$ is recursively enumerable (r.e.), but **undecidable** (not recursive). No algorithm can determine if an arbitrary program halts!"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Church-Turing Thesis:** Every algorithmically computable function can be computed by a Turing Machine.\n• **Rice's Theorem:** ANY non-trivial semantic property of partial recursive functions (e.g. 'Does program $P$ output 0?') is undecidable.\n• **$S_{m,n}$ Theorem:** Enables parameter embedding in program indices: $\\phi_{S_{m,n}(e, \\mathbf{x})}(\\mathbf{y}) = \\phi_e(\\mathbf{x}, \\mathbf{y})$.\n• **Turing Degrees ($A \\le_T B$):** $A$ is computable using an oracle for $B$. Degree $0'$ represents the Halting Problem."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Computability term to its defining property.",
      "matchPairs": [
        { "left": "Recursive Set (Decidable)", "right": "Set whose characteristic function chi_A(x) is computable by a TM that always halts" },
        { "left": "Recursively Enumerable (r.e.)", "right": "Set that is the domain of a partial recursive function (TM halts on x in A)" },
        { "left": "Rice's Theorem", "right": "States that every non-trivial semantic property of programs is undecidable" },
        { "left": "Turing Jump A'", "right": "Halting set relativized to oracle A" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Church-Turing thesis asserts that any intuitively computable algorithm can be executed on a formal ___ machine.",
      "blankAnswer": "turing",
      "blankDistractors": ["finite", "markov", "pascal"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "According to Rice's Theorem, which of the following program properties is **DECIDABLE**?",
      "options": [
        { "text": "Whether a program's source code contains more than 10 lines of text (Syntactic property!)", "isCorrect": true, "explanation": "Correct! Rice's theorem applies ONLY to non-trivial SEMANTIC properties of the computed function, not syntax." },
        { "text": "Whether a program halts on input 0", "isCorrect": false, "explanation": "Incorrect: Semantic property (undecidable by Rice)." },
        { "text": "Whether two programs compute the same function", "isCorrect": false, "explanation": "Incorrect: Semantic property (undecidable)." },
        { "text": "Whether a program ever outputs 42", "isCorrect": false, "explanation": "Incorrect: Semantic property (undecidable)." }
      ]
    }
  ]
}
```
