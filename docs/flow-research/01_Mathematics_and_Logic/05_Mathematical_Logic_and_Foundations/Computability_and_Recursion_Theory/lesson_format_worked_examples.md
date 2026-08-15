# Duofy Reusable Lesson Format: Computability Theory - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Computability_and_Recursion_Theory`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to apply Rice's Theorem to prove undecidability, perform parameter reductions using $S_{m,n}$ theorem, and evaluate Turing reducibility $A \le_T B$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Rice's Theorem Reduction Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Many-One Reduction Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Oracle Tape Turing Degree Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Turing Jump Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | R.E. vs Recursive Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Applying Rice's Theorem to $A = \\{ e \\mid \\text{Dom}(\\phi_e) = \\emptyset \\}$**\nRice's Theorem states: Any set of TM indices $C$ such that:\n1. Non-trivial: $C \\neq \\emptyset$ and $C \\neq \\mathbb{N}$.\n2. Semantic property: $\\phi_e = \\phi_i \\implies (e \\in C \\iff i \\in C)$.\nis **UNDECIDABLE**."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Check semantic property: If $\\phi_e = \\phi_i$, then $\\text{Dom}(\\phi_e) = \\text{Dom}(\\phi_i) = \\emptyset$, so $e \\in A \\iff i \\in A$. (Property depends ONLY on function behavior).\n• **Step 2:** Check non-triviality: Function that loops on all inputs has empty domain (index in $A$). Function $f(x) = x$ has domain $\\mathbb{N}$ (index not in $A$). $A \\neq \\emptyset$ and $A \\neq \\mathbb{N}$.\n• **Step 3:** By Rice's Theorem, set $A = \\{ e \\mid \\text{Dom}(\\phi_e) = \\emptyset \\}$ is **undecidable**!"
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "In Turing degree hierarchy, if $0$ is the degree of computable sets and $0'$ is the degree of the Halting Problem, how many applications of the Turing Jump $(0')^{(n)}$ yield degree $0^{(3)}$?",
      "numericAnswer": 3.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "A language A is many-one reducible to B (A <=_m B) if there exists a total computable function f such that x in A if and only if f(x) in ___.",
      "blankAnswer": "B",
      "blankDistractors": ["A", "K", "0"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the relationship between a language $A$ being **Recursive** and being **Recursively Enumerable (R.E.)**?",
      "options": [
        { "text": "A is Recursive if and only if both A and its complement A^c are Recursively Enumerable", "isCorrect": true, "explanation": "Correct! Post's Theorem: A is decidable iff A and ~A are both r.e." },
        { "text": "All R.E. languages are Recursive", "isCorrect": false, "explanation": "Incorrect: The Halting Problem K is R.E. but NOT recursive." },
        { "text": "A is Recursive if A is finite", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "They are mutually exclusive", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
