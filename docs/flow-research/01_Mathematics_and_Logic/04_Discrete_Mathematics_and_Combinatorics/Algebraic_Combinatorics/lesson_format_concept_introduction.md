# Duofy Reusable Lesson Format: Algebraic Combinatorics - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Algebraic_Combinatorics`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Young Tableaux, Ferrers Diagrams, Hook Length Formula $f^\lambda = \frac{n!}{\prod h(i,j)}$, RSK Correspondence, Schur Functions $s_\lambda(x)$, and Matroid Theory.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Young Tableaux & Hook Formula Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | RSK Algorithm & Matroid Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Algebraic Combinatorics Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Hook Length Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | RSK Permutation Bijection Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Young Tableaux & Hook Length Formula**\nFor an integer partition $\\lambda \\vdash n$, a **Standard Young Tableau (SYT)** fills a Ferrers diagram with $1, \\dots, n$ strictly increasing along rows and columns.\n**Hook Length Formula (Frame-Robinson-Thrall):**\n$$\nf^\\lambda = \\frac{n!}{\\prod_{(i,j) \\in \\lambda} h(i, j)}\n$$\nwhere hook length $h(i,j)$ is the number of cells directly right and below cell $(i,j)$ plus the cell itself."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **RSK Correspondence:** Bijection between permutations $\\sigma \\in S_n$ and pairs of SYT $(P, Q)$ of identical shape $\\lambda \\vdash n$.\n• **Schur Functions $s_\\lambda(x)$:** Basis for symmetric functions ring $\\Lambda$, representing irreducible characters of symmetric group $S_n$.\n• **Matroids:** Structural abstraction of linear independence $M = (E, \\mathcal{I})$. Independent sets $\\mathcal{I}$ satisfy hereditary property and exchange axiom.\n• **Graphic Matroid:** Edges of graph $G$; independent sets are forests (acyclic subgraphs)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Algebraic Combinatorics term to its defining object.",
      "matchPairs": [
        { "left": "Ferrers Diagram", "right": "Visual grid of boxes representing integer partition λ" },
        { "left": "Hook Length h(i,j)", "right": "Number of cells to the right and below cell (i,j) plus 1" },
        { "left": "RSK Algorithm", "right": "Bijection σ <-> (P, Q) mapping permutations to pairs of tableaux" },
        { "left": "Graphic Matroid", "right": "Matroid whose independent sets correspond to forests in a graph" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Hook Length Formula computes the exact number f^lambda of standard Young ___ of shape lambda.",
      "blankAnswer": "tableaux",
      "blankDistractors": ["matrices", "graphs", "permutations"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What identity relates the sum of squares $(f^\\lambda)^2$ of standard Young tableaux counts over all partitions $\\lambda \\vdash n$?",
      "options": [
        { "text": "sum_{λ ⊢ n} (f^λ)^2 = n! (the order of symmetric group S_n)", "isCorrect": true, "explanation": "Correct! RSK bijection proves sum_λ (f^λ)² = n!." },
        { "text": "sum_{λ ⊢ n} (f^λ)^2 = 2^n", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "sum_{λ ⊢ n} (f^λ)^2 = n", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "sum_{λ ⊢ n} (f^λ)^2 = C_n", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
