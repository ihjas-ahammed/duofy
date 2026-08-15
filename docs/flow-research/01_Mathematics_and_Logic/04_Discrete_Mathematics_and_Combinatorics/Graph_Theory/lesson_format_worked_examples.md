# Duofy Reusable Lesson Format: Graph Theory - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Graph_Theory`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to construct Laplacian Matrices $L = D - A$, evaluate Minimum Spanning Tree edge weights using Kruskal's / Prim's algorithm, and determine Chromatic Numbers $\chi(G)$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Laplacian Matrix Construction Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Matrix Construction Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Degree Matrix Diagonal Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative MST Weight Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Bipartite Chromatic Number Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Graph Laplacian Matrix Construction $L = D - A$**\nFor graph $G$ with adjacency matrix $A$ and degree matrix $D = \\text{diag}(\\text{deg}(v_i))$:\n$$\nL_{ij} = \\begin{cases} \\text{deg}(v_i) & \\text{if } i = j \\\\ -1 & \\text{if } i \\neq j \\text{ and } (v_i, v_j) \\in E \\\\ 0 & \\text{otherwise} \\end{cases}\n$$\nRow sums of $L$ are always 0, so $\\lambda_1(L) = 0$ with eigenvector $\\mathbf{1}$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Consider path graph $P_3$ on vertices $\{1, 2, 3\}$ with edges $(1,2)$ and $(2,3)$.\n• **Step 2:** Degrees: $\\text{deg}(1) = 1, \\text{deg}(2) = 2, \\text{deg}(3) = 1$.\n• **Step 3:** Adjacency matrix $A = \\begin{pmatrix} 0 & 1 & 0 \\\\ 1 & 0 & 1 \\\\ 0 & 1 & 0 \\end{pmatrix}$.\n• **Step 4:** Laplacian $L = D - A = \\begin{pmatrix} 1 & -1 & 0 \\\\ -1 & 2 & -1 \\\\ 0 & -1 & 1 \\end{pmatrix}$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The Laplacian matrix L of a graph is defined as the degree matrix D minus the ___ matrix A.",
      "blankAnswer": "adjacency",
      "blankDistractors": ["incidence", "identity", "stiffness"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the total weight of a Minimum Spanning Tree (MST) for a graph with edge weights: (A,B)=2, (B,C)=3, (A,C)=5, (C,D)=1.",
      "numericAnswer": 6.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the chromatic number $\\chi(C_5)$ of an odd cycle graph $C_5$ (5-cycle)?",
      "options": [
        { "text": "3 (odd cycles require 3 colors)", "isCorrect": true, "explanation": "Correct! Even cycles require 2 colors; odd cycles require 3 colors." },
        { "text": "2", "isCorrect": false, "explanation": "Incorrect: 2 colors work only for even cycles (bipartite)." },
        { "text": "5", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "4", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
