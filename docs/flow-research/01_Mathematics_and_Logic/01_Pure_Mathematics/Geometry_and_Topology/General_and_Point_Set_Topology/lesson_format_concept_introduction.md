# Duofy Reusable Lesson Format: Point-Set Topology - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / General_and_Point_Set_Topology`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Topological Spaces $(X, \mathcal{T})$, Open/Closed Sets, Topological Continuity (preimage of open sets is open), Compactness (finite subcovers), and Separation Axioms ($T_0 \dots T_4$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Topology & Continuity Axioms | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Open Cover & Neighborhood Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Separation Axioms $T_i$ Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Preimage Continuity Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Hausdorff Uniqueness Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Topological Space & Continuity**\nA **topology** $\\mathcal{T}$ on a set $X$ is a collection of subsets (called open sets) satisfying:\n1. $\\emptyset \\in \\mathcal{T}$ and $X \\in \\mathcal{T}$.\n2. Arbitrary unions of open sets are open.\n3. Finite intersections of open sets are open.\nA function $f: X \\to Y$ is **continuous** if $f^{-1}(U) \\in \\mathcal{T}_X$ for every open set $U \\in \\mathcal{T}_Y$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Compactness:** $X$ is compact if every open cover $\\mathcal{U} = \\{U_i\\}$ has a finite subcover $\\{U_1, \\dots, U_k\\}$.\n• **Connectedness:** $X$ cannot be split into two non-empty disjoint open sets $U \\cup V = X$.\n• **Hausdorff ($T_2$):** Any two distinct points $x \\neq y$ can be separated by disjoint open neighborhoods $U_x \\cap U_y = \\emptyset$.\n• **Uniqueness of Limits:** In Hausdorff spaces, convergent sequences/nets have UNIQUE limit points."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Separation Axiom to its topological definition.",
      "matchPairs": [
        { "left": "T1 Space", "right": "Every singleton {x} is a closed set" },
        { "left": "T2 Space (Hausdorff)", "right": "Distinct points separated by disjoint open sets" },
        { "left": "T3 Space (Regular)", "right": "Point and disjoint closed set separated by open sets" },
        { "left": "T4 Space (Normal)", "right": "Disjoint closed sets separated by disjoint open sets" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A function between topological spaces is continuous if and only if the ___ of every open set is open.",
      "blankAnswer": "preimage",
      "blankDistractors": ["image", "closure", "boundary"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Which topological property guarantees that any sequence in $X$ has at most ONE limit point?",
      "options": [
        { "text": "Hausdorff property (T₂)", "isCorrect": true, "explanation": "Correct! Disjoint neighborhoods around distinct points prevent multiple limits." },
        { "text": "Compactness", "isCorrect": false, "explanation": "Incorrect: Compactness guarantees existence of convergent subsequences, not limit uniqueness." },
        { "text": "Connectedness", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "T₀ property", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
