# Duofy Reusable Lesson Format: Euler's Polyhedral Formula and Planar Bounds

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Graph_Theory / Tree_and_Planar_Graphs`  
**Lesson Format Type:** `euler_polyhedral_formula_and_planar_bounds`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to analyze **Planar Graph Topology**: prove **Euler's Polyhedral Formula (1758)** ($V - E + F = 2$) by induction on edge count, derive the maximum edge bounds $E \le 3V - 6$ (general simple planar) and $E \le 2V - 4$ (bipartite / triangle-free planar), prove the non-planarity of $K_5$ and $K_{3,3}$, and evaluate the 5 regular Platonic solids.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Euler's Formula & Edge Bound Inequalities Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Handshaking Dual 2E >= 3F Bound Proof Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Planar Property & Non-Planarity Proof Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Maximum Planar Edges for 10-Vertex Graph Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | K_5 Non-Planarity Proof via Euler's Inequality Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Euler's Polyhedral Formula (Leonhard Euler, 1758): For any connected plane graph drawn in $\mathbb{R}^2$ with $V$ vertices, $E$ edges, and $F$ faces (including the unbounded outer face):
   $$V - E + F = 2$$
   For a planar graph with $c(G)$ connected components: $V - E + F = 1 + c(G)$. State Planar Edge Bounds:
   - For simple planar graphs with $V \ge 3$: $2E \ge 3F \implies E \le 3V - 6$ (Maximal planar graphs have $E = 3V - 6$ and $F = 2V - 4$).
   - For simple triangle-free planar graphs (e.g. bipartite): $2E \ge 4F \implies E \le 2V - 4$.
2. **Slide 2 (`concept_pieces`):** Deconstruct proof of $E \le 3V - 6$: (1) each face boundary is formed by a closed walk of length $\ge 3$ in a simple graph with $V \ge 3$, (2) summing boundary lengths over all $F$ faces counts each edge at most twice: $2E = \sum_{f} \operatorname{deg}(f) \ge 3F$, (3) rearrange to isolate faces: $F \le \frac{2}{3}E$, (4) substitute into Euler's formula: $2 = V - E + F \le V - E + \frac{2}{3}E = V - \frac{1}{3}E$, (5) multiply by $3$ and rearrange: $6 \le 3V - E \implies E \le 3V - 6$!
3. **Slide 3 (`matching`):** Pair 4 graph objects ($K_5$, $K_{3,3}$, Platonic Dodecahedron, Maximal Planar Graph) with their Euler topological characteristics.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the maximum number of edges in a simple planar graph with $V = 10$ vertices is $3(10) - 6 = 24$. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on proving non-planarity of $K_5$: Why is the complete graph $K_5$ ($V = 5, E = \binom{5}{2} = 10$) mathematically impossible to draw in the plane without intersecting edges? (Because if $K_5$ were planar, it would violate Euler's bound $E \le 3V - 6$: $10 \le 3(5) - 6 = 15 - 6 = 9$, which is a contradiction ($10 \le 9$ is false!)).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "euler_polyhedral_formula_and_planar_bounds",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Euler's Polyhedral Formula and Planar Bounds**\n• **Euler's Formula (Leonhard Euler, 1758):** For every connected planar graph embedded in $\\mathbb{R}^2$:\n$$\nV - E + F = 2\n$$\n(where $V = |V(G)|$, $E = |E(G)|$, and $F = |\\text{Faces}|$ including the outer region).\n• **Simple Planar Edge Bounds ($V \\ge 3$):**\n  - **General Planar Graphs:** Since every face has $\\ge 3$ boundary edges ($2E \\ge 3F$):\n$$\nE \\le 3V - 6, \\qquad F \\le 2V - 4\n$$\n  - **Triangle-Free / Bipartite Planar Graphs ($2E \\ge 4F$):**\n$$\nE \\le 2V - 4\n$$\n• **Maximal Planar Graphs (Triangulations):** $E = 3V - 6$ (every face is a triangle)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Face-Edge Handshaking):** Each face in a simple graph with $V \\ge 3$ is bounded by at least 3 edges: $\\operatorname{deg}(f) \\ge 3$.\n• **Step 2 (Double Counting):** Each edge bounds at most 2 faces $\\implies 2E = \\sum_{f} \\operatorname{deg}(f) \\ge 3F$.\n• **Step 3 (Bound Faces):** $F \\le \\frac{2}{3}E$.\n• **Step 4 (Substitute in Euler):**\n  $$2 = V - E + F \\le V - E + \\frac{2}{3}E = V - \\frac{1}{3}E$$\n• **Step 5 (Isolate $E$):** Multiply by 3 to obtain $6 \\le 3V - E \\implies E \\le 3V - 6$!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each graph to its Euler topological status.",
      "matchPairs": [
        { "left": "Complete Graph K_5", "right": "Non-planar: E = 10 exceeds max planar bound 3(5) - 6 = 9" },
        { "left": "Utility Graph K_{3, 3}", "right": "Non-planar: E = 9 exceeds triangle-free bound 2(6) - 4 = 8" },
        { "left": "Platonic Icosahedron", "right": "Maximal planar triangulation: V = 12, E = 30 = 3(12) - 6, F = 20" },
        { "left": "Outerplanar Graph", "right": "Can be embedded such that all vertices lie on the boundary of the outer face (E <= 2V - 3)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "By Euler's inequality E <= 3V - 6, the maximum number of edges in any simple planar graph with V = 10 vertices is ___.",
      "blankAnswer": "24",
      "blankDistractors": ["30", "18", "26"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How does Euler's formula prove that the complete bipartite utility graph K_{3,3} (V = 6, E = 9) cannot be drawn in the plane without crossing edges?",
      "options": [
        { "text": "K_{3,3} is BIPARTITE and thus contains no odd cycles (no triangles); every face must have at least 4 boundary edges (2E >= 4F), enforcing E <= 2V - 4 = 2(6) - 4 = 8, which contradicts E = 9", "isCorrect": true, "explanation": "Correct! Because K_{3,3} is bipartite, its shortest cycle is a 4-cycle (girth 4). The triangle-free planar bound gives E <= 2(6) - 4 = 8, making E = 9 strictly impossible." },
        { "text": "Because 6 is an even number", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because 3 + 3 = 6", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because K_{3,3} contains K_5 as a subgraph", "isCorrect": false, "explanation": "Incorrect: K_5 has 5 vertices; K_{3,3} has 6." }
      ]
    }
  ]
}
```
