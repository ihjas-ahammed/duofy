# Duofy Reusable Lesson Format: Cut Property and Generic Greedy MST Foundations

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Graph_Algorithms_and_Network_Flow / Kruskal_and_Prim_MST`  
**Lesson Format Type:** `cut_property_and_generic_greedy_mst_foundations`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the foundational graph cut theorems, exchange proofs, and cycle properties governing all greedy Minimum Spanning Tree algorithms (Arthur Cayley 1889; Thomas H. Cormen et al. CLRS Chapter 23; Jon Kleinberg & Éva Tardos): master **Cayley's Formula ($n^{n-2}$ spanning trees for complete graph $K_n$)**, formulate the definition of a **Cut $(S, V \setminus S)$** and a cut-crossing edge, prove the **Cut Property Theorem** (let $A$ be a subset of some MST; if $(S, V \setminus S)$ is a cut that respects $A$, and $(u, v)$ is a **light edge crossing the cut**, then $(u, v)$ is **safe for $A$**), contrast with the **Cycle Property Theorem** (the strictly heaviest edge in any simple cycle can NEVER belong to a unique MST), and trace the generic greedy MST loop.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cut Property, Light Edges, & Cycle Property Theorems Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Exchange Argument Proof of the Cut Property Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | MST Theorem / Term & Combinatorial Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Total Number of Spanning Trees in a Complete Graph with n Vertices (Cayley Formula) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Exact Elimination Condition Defined by the Cycle Property Theorem Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State The Cut Property & Cycle Property (CLRS Chapter 23):
   - **Definitions:**
     - A **Cut $(S, V \setminus S)$** is a partition of vertex set $V$.
     - An edge $(u, v)$ **crosses** the cut if $u \in S$ and $v \in V \setminus S$.
     - A cut **respects** set $A \subseteq E$ if no edge in $A$ crosses the cut.
     - An edge is **light** for a cut if its weight is minimum among all crossing edges.
   - **The Master Cut Property (Theorem 23.1):**
     $$\mathbf{\text{If a cut } (S, V \setminus S) \text{ respects } A \subseteq T_{\text{MST}}, \text{ and } (u, v) \text{ is a light crossing edge } \implies (u, v) \text{ is SAFE for } A!}$$
   - **The Cycle Property (Theorem 23.2):**
     - Let $C$ be any simple cycle in graph $G$.
     - If edge $e \in C$ has strictly greater weight than all other edges in $C$, **$e$ CANNOT belong to any unique MST**!
   - **Cayley's Tree Formula (1889):** Complete graph $K_n$ contains exactly $\mathbf{n^{n-2}}$ distinct spanning trees!
2. **Slide 2 (`ordering`):** Provide 5 steps of the formal exchange argument proof of the Cut Property: (1) let T be an existing MST containing subset A, and suppose light edge (u, v) crossing cut (S, V \ S) is not in T, (2) adding edge (u, v) to T creates a unique simple cycle C because T is a spanning tree, (3) because u in S and v in V \ S, cycle C must contain at least one other edge (x, y) that also crosses cut (S, V \ S), (4) construct a new tree T' = T - {(x, y)} + {(u, v)} by removing edge (x, y) and adding light edge (u, v), (5) since (u, v) is a light crossing edge, w(u, v) <= w(x, y), so w(T') <= w(T), proving that T' is also a valid MST containing edge (u, v)!
3. **Slide 3 (`matching`):** Pair 4 MST foundational concepts (Cut Property, Cycle Property, Respecting Cut, Cayley's Formula n^(n-2)) with their mathematical definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Cayley's formula proves a complete graph Kn contains n to the power of n-2 spanning trees. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the practical algorithmic application of the Cycle Property: How is the Cycle Property used to optimize greedy minimum spanning tree algorithms or simplify complex dense networks? (If an algorithm discovers a simple cycle in a graph, **it can safely identify and permanently delete the single edge with the strictly largest weight in that cycle without risking removing any edges from the graph's unique Minimum Spanning Tree**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cut_property_and_generic_greedy_mst_foundations",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Cut Property & Cycle Property (CLRS)**\n• **The Cut Property (Light-Edge Invariant):**\n$$\n\\mathbf{\\text{Lightest edge crossing cut } (S, V \\setminus S) \\implies \\text{SAFE to include in the MST!}}\n$$\n  - **Kruskal:** Grows cut between disjoint components.\n  - **Prim:** Grows cut between visited tree $T$ and unvisited $V \\setminus T$.\n• **The Cycle Property (Heavy-Edge Rejection):**\n$$\n\\mathbf{\\text{The strictly heaviest edge in any simple cycle } C \\implies \\mathbf{\\text{CANNOT belong to unique MST!}}}\n$$\n• **Cayley's Tree Formula (1889):** Complete graph $K_n$ contains exactly $\\mathbf{n^{n-2}}$ distinct spanning trees!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the Cut Property exchange proof demonstrating that light edge (u, v) is safe for the MST.",
      "orderItems": [
        "Assume an MST T contains edge set A, and suppose the light crossing edge (u, v) is not present in T",
        "Adding edge (u, v) into tree T forms a unique simple cycle C spanning across the cut boundary (S, V \\ S)",
        "Identify another edge (x, y) along cycle C that also crosses the cut boundary (S, V \\ S)",
        "Construct a new candidate spanning tree T' = T - {(x, y)} + {(u, v)} by swapping (x, y) for (u, v)",
        "Observe that w(u, v) <= w(x, y) guarantees w(T') <= w(T), proving that T' is also an optimal MST containing (u, v)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Minimum Spanning Tree foundation to its exact mathematical theorem.",
      "matchPairs": [
        { "left": "The Cut Property", "right": "Theorem proving that the minimum-weight edge crossing any cut is guaranteed to be in the MST" },
        { "left": "The Cycle Property", "right": "Theorem proving that the strictly maximum-weight edge in any cycle cannot be in a unique MST" },
        { "left": "Respecting Cut", "right": "A vertex partition (S, V \\ S) where no edge from the currently chosen set A crosses the cut" },
        { "left": "Cayley's Formula: n^(n-2)", "right": "Formula giving the total number of distinct spanning trees in a complete graph K_n" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "By Cayley's formula, the total number of unique spanning trees in a complete graph with n labeled vertices is n raised to the power of n minus ___ (n^(n-2)).",
      "blankAnswer": "2",
      "blankDistractors": ["1", "0", "n"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How can the Cycle Property be applied practically to simplify graphs during Minimum Spanning Tree construction?",
      "options": [
        { "text": "Whenever a simple cycle is detected in the graph, the single edge possessing the strictly maximum weight within that cycle can be permanently deleted from the graph, because the Cycle Property mathematically guarantees that the heaviest edge in a cycle will never be part of a unique Minimum Spanning Tree", "isCorrect": true, "explanation": "Correct! The Cycle Property is the dual of the Cut Property and provides a powerful edge-elimination rule (CLRS Theorem 23.2). Consider any simple cycle $C$ in a connected graph $G$. Suppose $e = (u, v)$ is the edge with the strictly largest weight in $C$. If an MST $T$ were to contain edge $e$, removing $e$ would break $T$ into two disconnected components, defining a cut $(S, V \\setminus S)$. But because $C$ was a cycle, there must exist at least one OTHER edge $e' \\in C$ that crosses this exact same cut! Since $e$ was strictly the heaviest edge in $C$, we have $w(e') < w(e)$. Swapping $e'$ into the tree produces a new spanning tree $T' = T - \\{e\\} + \\{e'\\}$ with total weight $w(T') = w(T) - w(e) + w(e') < w(T)$, which contradicts the assumption that $T$ was a minimum spanning tree. Therefore, edge $e$ can NEVER belong to any unique MST, and deleting it immediately from the graph is 100% safe." },
        { "text": "Cycles cannot be detected in graphs", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The Cycle Property requires adding 100 to all edge weights in the cycle", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The Cycle Property only applies to bipartite graphs", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
