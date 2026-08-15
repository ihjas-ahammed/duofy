# Duofy Reusable Lesson Format: Graph Theory - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Graph_Theory`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Graphs $G = (V, E)$, Handshaking Lemma $\sum \text{deg}(v) = 2|E|$, Euler's Planar Formula $V - E + F = 2$, Chromatic Number $\chi(G)$, and Graph Laplacian $L = D - A$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Handshaking & Euler Planar Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Connectivity & Spectral Graph Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Graph Theory Term Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Handshaking Lemma Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Planar Face Characteristic Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Handshaking Lemma & Euler's Planar Formula**\n1. **Handshaking Lemma:** In any graph $G = (V, E)$:\n$$\n\\sum_{v \\in V} \\text{deg}(v) = 2 |E|\n$$\n2. **Euler's Formula for Planar Graphs:** Any connected planar graph satisfies:\n$$\nV - E + F = 2\n$$\nwhere $V$ is vertices, $E$ is edges, and $F$ is faces (including unbounded outer face)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Eulerian Path:** Visits every EDGE in $G$ exactly once $\\iff$ graph is connected and has at most 2 odd-degree vertices.\n• **Hamiltonian Cycle:** Visits every VERTEX in $G$ exactly once (NP-complete problem to detect).\n• **Chromatic Number $\\chi(G)$:** Minimum colors needed to color vertices so no adjacent vertices share a color (Four Color Theorem: Planar $\\implies \\chi(G) \\le 4$).\n• **Laplacian Matrix $L = D - A$:** Degree matrix $D$ minus Adjacency matrix $A$. Second eigenvalue $\\lambda_2(L)$ measures algebraic connectivity."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each graph property to its defining condition.",
      "matchPairs": [
        { "left": "Bipartite Graph", "right": "Contains NO odd-length cycles (Chromatically 2-colorable)" },
        { "left": "Eulerian Graph", "right": "Connected and EVERY vertex has even degree" },
        { "left": "Complete Graph K_n", "right": "Every pair of distinct vertices is connected by an edge" },
        { "left": "Tree", "right": "Connected acyclic graph with exactly V - 1 edges" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Handshaking Lemma states that the sum of degrees of all vertices in a graph is equal to ___ times the number of edges.",
      "blankAnswer": "2",
      "blankDistractors": ["1", "4", "V"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A connected planar graph has $V = 6$ vertices and $E = 9$ edges. How many faces $F$ does it divide the plane into?",
      "options": [
        { "text": "5 faces (using V - E + F = 2 -> 6 - 9 + F = 2 -> F = 5)", "isCorrect": true, "explanation": "Correct! Euler's formula: F = 2 - V + E = 2 - 6 + 9 = 5." },
        { "text": "3 faces", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "15 faces", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "4 faces", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
