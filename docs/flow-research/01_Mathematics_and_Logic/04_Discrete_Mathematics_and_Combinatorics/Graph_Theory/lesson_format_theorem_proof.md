# Duofy Reusable Lesson Format: Graph Theory - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Graph_Theory`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through landmark proofs in graph theory: Euler's Planar Formula Derivation via Induction, Kuratowski's Planarity Theorem, and Dirac's Theorem for Hamiltonian Cycles.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Euler's Formula Proof Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Planar Induction Proof Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Kuratowski Forbidden Minors Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Handshaking Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Planar Characteristic Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Proof of Euler's Formula ($V - E + F = 2$)**\nWe prove $V - E + F = 2$ by induction on the number of edges $E$ for any connected planar graph $G$.\n*Base Case:* $E = 0 \\implies V = 1, F = 1 \\implies 1 - 0 + 1 = 2$.\n*Inductive Step:* Remove an edge from a cycle (reducing $E$ and $F$ by 1) or contract a leaf edge (reducing $V$ and $E$ by 1)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove Euler's Planar Formula by induction on edges E.",
      "orderItems": [
        "Base Case: If G is a tree with V vertices and no cycles (F = 1), then E = V - 1. Check: V - (V - 1) + 1 = 2.",
        "Inductive Hypothesis: Assume V' - E' + F' = 2 holds for all connected planar graphs with E' < E edges.",
        "If G contains a cycle, select an edge e belonging to the cycle.",
        "Delete edge e to obtain connected planar graph G' with E' = E - 1 edges and F' = F - 1 faces.",
        "Apply IH to G': V - (E - 1) + (F - 1) = 2, which simplifies directly to V - E + F = 2."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What does **Kuratowski's Theorem** state regarding graph planarity?",
      "options": [
        { "text": "A finite graph is planar if and only if it does NOT contain a subgraph homeomorphically equivalent to K_5 or K_{3,3}", "isCorrect": true, "explanation": "Correct! K_5 (complete graph on 5 vertices) and K_{3,3} (complete bipartite graph on 3+3) are the forbidden planar obstructions." },
        { "text": "All graphs with V > 5 are non-planar", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Planar graphs have chromatic number 2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Every graph is planar", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Planar Edge Bound $E \\le 3V - 6$",
      "interactiveSteps": [
        { "stepText": "In a simple planar graph with $V \\ge 3$, every face is bounded by at least 3 edges: $2 E = \\sum \\text{deg}(F_i) \\ge 3F$." },
        {
          "prompt": "Substitute $F \\le \\frac{2}{3} E$ into Euler's formula $V - E + F = 2$. What bound on $E$ results?",
          "options": [
            { "text": "E ≤ 3V - 6", "isCorrect": true },
            { "text": "E ≤ V - 1", "isCorrect": false },
            { "text": "E = V^2", "isCorrect": false },
            { "text": "E ≤ 2V", "isCorrect": false }
          ]
        },
        { "stepText": "For $K_5$, $V=5, E=10 > 3(5)-6 = 9$. Thus $K_5$ is non-planar!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What forbidden minor graph K_5 represents the complete graph on how many vertices?",
      "blankAnswer": "5"
    }
  ]
}
```
