# Duofy Reusable Lesson Format: Vertex Colorings and Brooks' Theorem

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Graph_Theory / Coloring_and_Chromatic_Polynomials`  
**Lesson Format Type:** `vertex_colorings_and_brooks_theorem`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the **Chromatic Number $\chi(G)$**, establish the standard bounds $\omega(G) \le \chi(G) \le \Delta(G) + 1$, analyze the **Greedy Coloring Algorithm**, evaluate **Brooks' Theorem (1941)** ($\chi(G) \le \Delta(G)$ for all connected graphs except cliques $K_{\Delta+1}$ and odd cycles $C_{2k+1}$), and explore Mycielski's construction for triangle-free graphs with arbitrarily high chromatic numbers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Chromatic Number & Brooks' Theorem Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Greedy Degree-Bound Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Graph Family & Exact Chromatic Number Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Maximum Degree Bound Coefficient in Brooks' Theorem Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mycielski Graph Construction Triangle-Free High Chi Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of a proper Vertex $k$-Coloring: A mapping $c: V(G) \to \{1, 2, \dots, k\}$ such that $uv \in E(G) \implies c(u) \ne c(v)$. The **Chromatic Number $\chi(G)$** is the minimum $k$ for which a proper coloring exists. State the Greedy Coloring Theorem: For any vertex ordering $v_1, \dots, v_n$, greedy coloring uses at most $\Delta(G) + 1$ colors, so $\chi(G) \le \Delta(G) + 1$. State Brooks' Theorem (R. Leonard Brooks, 1941): For every connected simple graph $G$:
   $$\chi(G) \le \Delta(G)$$
   **EXCEPT** if:
   1. $G$ is a **Complete Graph $K_{\Delta+1}$** (where $\chi = \Delta + 1$).
   2. $G$ is an **Odd Cycle $C_{2k+1}$** (where $\Delta = 2$ and $\chi = 3$).
2. **Slide 2 (`ordering`):** Provide 5 steps proving $\chi(G) \le \Delta(G) + 1$ via greedy coloring: (1) let $v_1, v_2, \dots, v_n$ be any fixed permutation ordering of the vertices $V(G)$, (2) sequentially assign to vertex $v_i$ the smallest positive integer color not used by any already-colored neighbor in $\{v_1, \dots, v_{i-1}\}$, (3) at step $i$, vertex $v_i$ has at most $\deg(v_i)$ neighbors in total, (4) since $\deg(v_i) \le \Delta(G)$, at most $\Delta(G)$ colors are blocked from being assigned to $v_i$, (5) within the palette $\{1, 2, \dots, \Delta(G) + 1\}$, there is guaranteed to be at least one available color for $v_i$, proving $\chi(G) \le \Delta(G) + 1$.
3. **Slide 3 (`matching`):** Pair 4 graph families (Complete Graph $K_n$, Even Cycle $C_{2k}$, Odd Cycle $C_{2k+1}$, Bipartite Graph $K_{m,n}$) with their exact chromatic numbers ($n$, $2$, $3$, $2$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that for any graph that is neither complete nor an odd cycle, Brooks' Theorem bounds $\chi(G)$ by the maximum degree $\Delta(G)$. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the Mycielski Construction (Jan Mycielski, 1955): Can the chromatic number $\chi(G)$ be arbitrarily large even if the clique number $\omega(G) = 2$ (meaning the graph contains ZERO triangles $K_3$)? (Yes! The Mycielskian transformation $\mu(G)$ creates a graph with $\chi(\mu(G)) = \chi(G) + 1$ without creating any new triangles, proving that large chromatic numbers are caused by global topological obstruction rather than local cliques).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "vertex_colorings_and_brooks_theorem",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Vertex Colorings and Brooks' Theorem**\n• **Chromatic Number $\\chi(G)$:** Minimum number of colors required to color vertices such that no adjacent vertices share a color.\n• **The Fundamental Sandwich Bound:**\n$$\n\\omega(G) \\le \\chi(G) \\le \\Delta(G) + 1\n$$\n(where $\\omega(G)$ = clique number, $\\Delta(G)$ = maximum vertex degree).\n• **Brooks' Theorem (R. Leonard Brooks, 1941):** For any connected simple graph $G$:\n$$\n\\chi(G) \\le \\Delta(G)\n$$\n**UNLESS** $G$ is:\n  1. A **Complete Graph $K_{\\Delta + 1}$** ($\\chi = \\Delta + 1$).\n  2. An **Odd Cycle $C_{2k+1}$** ($\\Delta = 2, \\; \\chi = 3$)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps establishing that greedy coloring uses at most Delta(G) + 1 colors.",
      "orderItems": [
        "Fix an arbitrary linear ordering of vertices v_1, v_2, ..., v_n in graph G",
        "Sequentially assign to vertex v_i the smallest available color in {1, 2, ...} not used by already-colored neighbors",
        "Observe that at step i, vertex v_i has at most deg(v_i) total neighbors in the entire graph",
        "Apply the maximum degree bound deg(v_i) <= Delta(G), meaning at most Delta(G) colors are forbidden at step i",
        "Select the first available color in the palette {1, 2, ..., Delta(G) + 1}, concluding chi(G) <= Delta(G) + 1"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each graph family to its exact chromatic number chi(G).",
      "matchPairs": [
        { "left": "Complete Graph K_n", "right": "chi(K_n) = n (every vertex connected to all others)" },
        { "left": "Bipartite Graph K_{m, n} (with edges)", "right": "chi(G) = 2 (2-colorable by definition)" },
        { "left": "Odd Cycle C_{2k+1}", "right": "chi(C_{2k+1}) = 3 (requires 3rd color to break odd parity loop)" },
        { "left": "Even Cycle C_{2k}", "right": "chi(C_{2k}) = 2 (bipartite)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "For any connected graph that is neither a complete graph nor an odd cycle, Brooks' Theorem proves chi(G) is at most the ___ degree Delta(G).",
      "blankAnswer": "maximum",
      "blankDistractors": ["minimum", "average", "total"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What does Mycielski's graph construction (1955) prove about the relationship between clique number omega(G) and chromatic number chi(G)?",
      "options": [
        { "text": "Graphs can have ARBITRARILY HIGH chromatic numbers chi(G) while remaining completely TRIANGLE-FREE (clique number omega(G) = 2)", "isCorrect": true, "explanation": "Correct! Jan Mycielski proved that chi(G) is not bounded by clique size; the Mycielskian operation iteratively increments chi without introducing any 3-cycles/triangles." },
        { "text": "Triangle-free graphs are always 2-colorable", "isCorrect": false, "explanation": "Incorrect: C_5 is triangle-free but requires 3 colors." },
        { "text": "All graphs with chi(G) > 3 must contain K_4", "isCorrect": false, "explanation": "Incorrect: The Grötzsch graph has chi=4 and no triangles." },
        { "text": "Chromatic number equals clique number for all graphs", "isCorrect": false, "explanation": "Incorrect: Only true for perfect graphs." }
      ]
    }
  ]
}
```
