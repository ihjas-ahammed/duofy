# Duofy Reusable Lesson Format: Model Theory - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Model_Theory`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to execute Quantifier Elimination for Dense Linear Orders (DLO), verify elementary equivalence $\mathcal{M} \\equiv \\mathcal{N}$, and apply Vaught's Categoricity Test.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Quantifier Elimination Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step QE Elimination Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Elementary Substructure Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Model Cardinality Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Categoricity Complete Theory Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Quantifier Elimination for Formula $\\exists x (y < x \\land x < z)$ in DLO**\nDense Linear Orders without Endpoints (DLO) axioms:\n1. Strict total order: $\\neg(x < x)$, $x < y \\land y < z \\implies x < z$, $x < y \\lor x = y \\lor y < x$.\n2. Density: $\\forall x \\forall z (x < z \\implies \\exists x (x < x \\land x < z))$.\n3. No endpoints: $\\forall x \\exists y (y < x)$, $\\forall x \\exists z (x < z)$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Consider formula $\\phi(y, z) = \\exists x (y < x \\land x < z)$.\n• **Step 2:** By DLO Density axiom, between any two elements $y < z$, there ALWAYS exists an element $x$.\n• **Step 3:** Thus $\\exists x (y < x \\land x < z)$ is logically equivalent modulo DLO to the quantifier-free formula $y < z$.\n• **Step 4:** Quantifier $\\exists x$ has been eliminated!"
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "Two first-order structures M and N are elementarily equivalent (M ≡ N) if they satisfy exactly the same first-order ___.",
      "blankAnswer": "sentences",
      "blankDistractors": ["terms", "constants", "cardinalities"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "By Cantor's Theorem, up to isomorphism, how many distinct countable models exist for the theory of Dense Linear Orders without Endpoints (DLO)?",
      "numericAnswer": 1.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the theory of Random Graphs (Rado Graph) $\\aleph_0$-categorical?",
      "options": [
        { "text": "Any two countable random graphs satisfying the Extension Property are isomorphic (Rado Graph)", "isCorrect": true, "explanation": "Correct! Back-and-forth construction shows the Rado Graph is the unique countable random graph." },
        { "text": "Because random graphs have no edges", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because random graphs are finite", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because chromatic number is 1", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
