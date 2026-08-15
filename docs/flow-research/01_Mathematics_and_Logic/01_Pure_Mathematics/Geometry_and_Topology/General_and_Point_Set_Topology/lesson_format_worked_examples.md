# Duofy Reusable Lesson Format: Point-Set Topology - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / General_and_Point_Set_Topology`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to verify topology axioms $\mathcal{T}$, construct Product and Quotient Topologies, find interiors/closures/boundaries, and test separation conditions.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Topology Verification Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Axiom Check Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Boundary / Interior Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Finite Topology Count Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Product Topology Basis Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Boundary, Interior, and Closure**\nFor a subset $A \\subseteq X$ in a topological space $(X, \\mathcal{T})$:\n$$\n\\text{Int}(A) = \\bigcup \\{ U \\in \\mathcal{T} \\mid U \\subseteq A \\}, \\quad \\bar{A} = \\bigcap \\{ F \\text{ closed} \\mid A \\subseteq F \\}\n$$\nBoundary $\\partial A = \\bar{A} \\setminus \\text{Int}(A)$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Consider $A = (0, 1] \\subset \\mathbb{R}$ under standard topology.\n• **Step 2:** Largest open set contained in $A$ is $(0, 1) \\implies \\text{Int}(A) = (0, 1)$.\n• **Step 3:** Smallest closed set containing $A$ is $[0, 1] \\implies \\bar{A} = [0, 1]$.\n• **Step 4:** Boundary $\\partial A = \\bar{A} \\setminus \\text{Int}(A) = [0, 1] \\setminus (0, 1) = \\{0, 1\\}$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The boundary of a subset A equals its closure minus its ___.",
      "blankAnswer": "interior",
      "blankDistractors": ["exterior", "complement", "union"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "How many distinct topologies can be defined on a 2-element set $X = \\{a, b\\}$?",
      "numericAnswer": 4.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the product topology on $X = \\prod_{i \\in I} X_i$ defined using basis sets $\\prod U_i$ where $U_i \\neq X_i$ for only FINITELY many coordinates $i$?",
      "options": [
        { "text": "This definition makes projection maps π_i continuous AND ensures Tychonoff's Theorem holds for infinite products", "isCorrect": true, "explanation": "Correct! Box topology (allowing infinitely many restricted coordinates) fails Tychonoff!" },
        { "text": "Because infinite products are impossible", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because all X_i must be finite", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because finite intersections fail", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
