# Duofy Reusable Lesson Format: Edge Colorings and Vizing's Theorem

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Graph_Theory / Coloring_and_Chromatic_Polynomials`  
**Lesson Format Type:** `edge_colorings_and_vizings_theorem`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the **Chromatic Index $\chi'(G)$** (proper edge coloring), establish the lower bound $\chi'(G) \ge \Delta(G)$, master **Vizing's Theorem (Vadim G. Vizing, 1964)** classifying all simple graphs into **Class 1 ($\chi' = \Delta$)** vs **Class 2 ($\chi' = \Delta + 1$)**, prove **König's Line Coloring Theorem (1916)** showing all bipartite graphs are Class 1, and analyze edge-coloring fan algorithms.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Edge Coloring & Vizing's Dichotomy Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Vizing Fan Kempe Chain Algorithm Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Graph Family & Vizing Class Classification Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Class 2 Chromatic Index Value Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | König's Bipartite Graph Chromatic Index Theorem Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of a proper Edge $k$-Coloring: A mapping $c: E(G) \to \{1, 2, \dots, k\}$ such that any two edges sharing a common endpoint vertex receive distinct colors. The **Chromatic Index (Edge Chromatic Number) $\chi'(G)$** is the minimum $k$ required. Trivial lower bound: $\chi'(G) \ge \Delta(G)$ (since all edges incident to a maximum degree vertex must have different colors). State Vizing's Theorem (1964): For every simple graph $G$:
   $$\chi'(G) \in \{\Delta(G), \, \Delta(G) + 1\}$$
   - **Class 1 Graphs:** $\chi'(G) = \Delta(G)$
   - **Class 2 Graphs:** $\chi'(G) = \Delta(G) + 1$
   State König's Line Coloring Theorem (1916): Every bipartite graph is strictly **Class 1** ($\chi'(G) = \Delta(G)$).
2. **Slide 2 (`concept_pieces`):** Deconstruct Vizing's fan technique: (1) let edge $e = uv_1$ be uncolored with palette of $\Delta + 1$ colors, (2) construct a "fan" of neighbors $v_1, v_2, \dots, v_k$ of $u$ where each edge $uv_i$ is colored with a color missing at $v_{i-1}$, (3) find a color $\beta$ missing at the apex $u$ and color $\alpha$ missing at the end of the fan $v_k$, (4) rotate the edge colors along the fan to uncolor an edge where $\alpha$ is missing, (5) if both $\alpha$ and $\beta$ conflict, swap colors along an alternating $(\alpha, \beta)$-Kempe path starting at $u$ without disturbing the fan, completing the recoloring with $\Delta + 1$ colors!
3. **Slide 3 (`matching`):** Pair 4 graphs (Complete Graph $K_{2n}$ (even), Complete Graph $K_{2n+1}$ (odd), Odd Cycle $C_{2n+1}$, Bipartite Graph $K_{m,n}$) with their exact chromatic index and class ($\chi' = 2n-1$ Class 1, $\chi' = 2n+1$ Class 2, $\chi' = 3$ Class 2, $\chi' = \max(m, n)$ Class 1).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that under Vizing's theorem, any simple graph in Class 2 has chromatic index equal to Delta plus one. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the complexity of determining whether a graph is Class 1 or Class 2 (Ian Holyer, 1981): Is deciding whether a given cubic 3-regular graph is Class 1 or Class 2 computationally easy or hard? (It is NP-complete! Even though Vizing restricts the answer to only two possible numbers $\{3, 4\}$, distinguishing whether a graph belongs to Class 1 or Class 2 is an NP-complete problem).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "edge_colorings_and_vizings_theorem",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Edge Colorings and Vizing's Theorem**\n• **Chromatic Index $\\chi'(G)$:** Minimum colors to color edges such that no incident edges share a color.\n• **Trivial Lower Bound:** $\\chi'(G) \\ge \\Delta(G)$ (colors at max-degree vertex must be distinct).\n• **Vizing's Theorem (Vadim Vizing, 1964):** For **every** simple graph $G$:\n$$\n\\Delta(G) \\le \\chi'(G) \\le \\Delta(G) + 1\n$$\n  - **Class 1 Graphs:** $\\chi'(G) = \\Delta(G)$.\n  - **Class 2 Graphs:** $\\chi'(G) = \\Delta(G) + 1$.\n• **König's Line Coloring Theorem (Dénes König, 1916):** Every **bipartite graph** is strictly **Class 1** ($\\chi'(G) = \\Delta(G)$)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Fan Construction):** For uncolored edge $uv_1$, build a fan of incident edges $uv_1, uv_2, \\dots, uv_k$ around apex $u$.\n• **Step 2 (Missing Colors):** Identify a missing color at $u$ (color $\\beta$) and a missing color at fan tip $v_k$ (color $\\alpha$) from the $\\Delta + 1$ palette.\n• **Step 3 (Fan Rotation):** Shift colors cyclically along the fan: recolor $uv_{i-1}$ with the color of $uv_i$.\n• **Step 4 (Kempe Chain Swap):** If a cycle conflict arises, flip colors along the maximal alternating $(\\alpha, \\beta)$-path starting at $u$.\n• **Step 5 (Completion):** The Kempe swap resolves the obstruction, properly coloring the missing edge within $\\Delta + 1$ colors!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each graph to its Vizing classification and chromatic index chi'(G).",
      "matchPairs": [
        { "left": "Bipartite Graph (Delta = D)", "right": "Class 1: chi'(G) = D (by König's Line Coloring Theorem)" },
        { "left": "Complete Graph K_{2n} (Even)", "right": "Class 1: chi'(K_{2n}) = 2n - 1 (1-factorization exists)" },
        { "left": "Complete Graph K_{2n+1} (Odd)", "right": "Class 2: chi'(K_{2n+1}) = 2n + 1" },
        { "left": "Odd Cycle C_{2n+1}", "right": "Class 2: chi'(C_{2n+1}) = 3 (Delta = 2, max matching size is n)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "According to Vizing's theorem, any simple graph categorized as Class 2 has a chromatic index exactly equal to Delta ___ one.",
      "blankAnswer": "plus",
      "blankDistractors": ["minus", "times", "divided"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What did Ian Holyer prove in 1981 regarding the computational complexity of determining whether a general graph G belongs to Class 1 or Class 2 under Vizing's Theorem?",
      "options": [
        { "text": "It is NP-COMPLETE; even for 3-regular cubic graphs, determining whether chi'(G) = 3 or chi'(G) = 4 is an NP-complete problem", "isCorrect": true, "explanation": "Correct! Despite Vizing's theorem narrowing the answer to just two consecutive integers {Delta, Delta + 1}, Holyer proved that deciding between Class 1 and Class 2 is NP-complete." },
        { "text": "It can be solved in linear time O(|V| + |E|)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It is impossible for computers because Vizing's theorem is false", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "All planar graphs are in Class 1", "isCorrect": false, "explanation": "Incorrect: Some planar graphs are Class 2." }
      ]
    }
  ]
}
```
