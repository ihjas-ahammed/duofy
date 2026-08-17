# Duofy Reusable Lesson Format: Kruskal's Algorithm (Union by Rank and Path Compression)

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Graph_Algorithms_and_Network_Flow / Kruskal_and_Prim_MST`  
**Lesson Format Type:** `kruskals_algorithm_with_union_by_rank_and_path_compression`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the edge-sorting greedy mechanics, disjoint-set data structures, and near-linear complexity of Kruskal's MST algorithm (Joseph B. Kruskal 1956; Robert E. Tarjan 1975; Thomas H. Cormen et al. CLRS Chapter 21 & 23): master **Disjoint-Set Union (DSU / Union-Find)** with **Make-Set**, **Find-Set**, and **Union**, analyze the two critical DSU optimizations (**1. Union by Rank / Size [attaching shorter trees under taller roots to bound depth to $O(\log V)$]** and **2. Path Compression [pointing all traversed nodes directly to the root in `find()` to flatten trees]**), prove that combined Union by Rank + Path Compression achieves the famous **$O(m \cdot \alpha(n))$ bound** (where $\alpha$ is the extremely slow-growing inverse Ackermann function $\alpha(V) < 5$), and evaluate Kruskal's overall **$O(E\log E) = O(E\log V)$ time complexity**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Kruskal's Edge Greedy Loop, DSU Invariants, & Inverse Ackermann Alpha Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Kruskal's Edge Sorting and DSU Cycle Validation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | DSU Optimization / Operation & Mathematical Performance Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Mathematical Function Symbolized as alpha(V) Bounding DSU Runtime Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Mechanism of Cycle Prevention Using DSU in Kruskal's Algorithm Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Kruskal's Algorithm & DSU (Kruskal 1956; Tarjan 1975; CLRS):
   - **Kruskal's Edge-Centric Greedy Strategy:**
     1. Sort all $E$ edges in non-decreasing order of weight: $w(e_1) \le w(e_2) \le \dots \le w(e_m)$ in $O(E\log E)$.
     2. Initialize a DSU with $|V|$ disjoint single-vertex sets (`Make-Set(v)`).
     3. Iterate through sorted edges: if $\mathbf{\text{Find-Set}(u) \ne \text{Find-Set}(v)}$ (endpoints belong to different trees), add edge $(u, v)$ to MST and call $\mathbf{\text{Union}(u, v)}$!
   - **The 2 DSU Optimizations (Tarjan 1975):**
     1. **Union by Rank:** Attach root of tree with smaller rank to root with larger rank.
     2. **Path Compression:** In `Find-Set(x)`, set `parent[x] = Find-Set(parent[x])`, pointing every visited node directly to root.
   - **The Inverse Ackermann Bound ($O(m \cdot \alpha(n))$):**
     - Combining both optimizations makes any sequence of $m$ operations run in **$O(m \cdot \alpha(n))$**, where $\alpha(n) \le 4$ for all $n \le 10^{80}$ (the number of atoms in the observable universe!).
   - **Total Complexity:** $\mathbf{O(E\log E) = O(E\log V)\text{ Time}}$ (sorting dominates) and $O(V)$ space.
2. **Slide 2 (`ordering`):** Provide 5 steps of executing Kruskal's algorithm: (1) sort all edges of graph G in non-decreasing order of their weights in O(E log E) time, (2) initialize a Disjoint-Set Union structure creating a single-element set for every vertex v in V, (3) iterate through each edge (u, v) in the sorted edge list from lightest to heaviest, (4) evaluate Find-Set(u) and Find-Set(v); if they return different set roots, add edge (u, v) to the MST and merge their components using Union(u, v), (5) stop when exactly |V| - 1 edges have been added to the MST, returning the optimal minimum spanning tree!
3. **Slide 3 (`matching`):** Pair 4 DSU concepts (Union by Rank, Path Compression, Find-Set(u) == Find-Set(v), Inverse Ackermann alpha(n)) with their operational roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the amortized complexity of DSU operations is bounded by the inverse Ackermann function. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on how DSU guarantees that Kruskal's algorithm never creates a cycle: Why is testing `Find-Set(u) != Find-Set(v)` mathematically necessary and sufficient to prevent Kruskal's algorithm from ever creating a cycle in the growing forest? (Because `Find-Set(u) == Find-Set(v)` means **vertices $u$ and $v$ already belong to the same connected component (there already exists a path between them in the forest)**; adding edge $(u, v)$ would introduce a second path between $u$ and $v$, **which by definition closes a simple cycle**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "kruskals_algorithm_with_union_by_rank_and_path_compression",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Kruskal's MST & Disjoint-Set Union (1956)**\n• **Kruskal's Greedy Loop:** Sort edges by weight $\\implies$ Greedily add $(u, v)$ if $\\mathbf{\\text{Find}(u) \\ne \\text{Find}(v)}$!\n• **The 2 DSU Optimizations (Tarjan 1975):**\n  1. **Union by Rank:** Attach smaller tree under larger root (bounds height to $O(\\log V)$).\n  2. **Path Compression:** Point all nodes directly to root during `find()` (flattens tree)!\n• **The Inverse Ackermann Function ($\\alpha(n)$):**\n$$\n\\mathbf{\\text{Amortized Cost per DSU op} = O(\\alpha(V)) \\approx O(1) \\qquad (\\alpha(10^{80}) \\le 4!)}\n$$\n• **Total Asymptotic Runtime:** $\\mathbf{O(E\\log E) = O(E\\log V)}$ (Dominated by initial edge sorting)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of Kruskal's Minimum Spanning Tree algorithm using Disjoint-Set Union.",
      "orderItems": [
        "Sort all |E| edges in ascending order of weight w in O(E log E) time",
        "Initialize the DSU structure creating an isolated single-element set for every vertex v in V",
        "Iterate sequentially through the sorted edge list from lowest weight to highest weight",
        "Query Find-Set(u) and Find-Set(v); if they return different root identifiers, add edge (u, v) to the MST",
        "Invoke Union(u, v) to merge the two disjoint components, stopping when exactly |V| - 1 edges are selected"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Disjoint-Set Union (DSU) feature to its exact mathematical purpose.",
      "matchPairs": [
        { "left": "Union by Rank", "right": "Attaches shorter component trees under taller roots to prevent tree degenerating into linear chains" },
        { "left": "Path Compression", "right": "Re-links all visited nodes directly to the root during find queries, flattening the tree structure" },
        { "left": "Find-Set(u) == Find-Set(v)", "right": "Indicates both endpoints already share a path in the forest, signaling that adding edge would form a cycle" },
        { "left": "Inverse Ackermann alpha(n)", "right": "Extremely slow-growing mathematical function bounding DSU operations to near-constant amortized time" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The amortized near-constant time complexity of DSU operations is bounded by the inverse ___ function alpha(V).",
      "blankAnswer": "Ackermann",
      "blankDistractors": ["Fibonacci", "Euler", "Laplace"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the condition 'Find-Set(u) != Find-Set(v)' mathematically necessary and sufficient to prevent Kruskal's algorithm from ever creating a cycle?",
      "options": [
        { "text": "If Find-Set(u) == Find-Set(v), vertices u and v belong to the same connected component, meaning an undirected path already connects u and v in the current forest; adding edge (u, v) would introduce a second alternate path between them, which by definition forms a simple cycle in the graph", "isCorrect": true, "explanation": "Correct! In graph theory, a cycle exists if and only if there are two distinct simple paths between any pair of vertices $u$ and $v$. In Kruskal's algorithm, the forest initially consists of $|V|$ isolated vertices. As edges are added, vertices merge into connected components. The operation `Find-Set(u)` returns the unique representative root of the connected component containing $u$. If `Find-Set(u) == Find-Set(v)`, $u$ and $v$ are already in the exact same connected component—which means there is ALREADY an existing path of previously added edges connecting $u$ to $v$. If you were to add edge $(u, v)$, that new edge plus the existing path would form a closed simple cycle. By checking `Find-Set(u) != Find-Set(v)` before adding any edge, Kruskal guarantees that every added edge connects two previously disconnected components, preserving the acyclic tree invariant at every single step." },
        { "text": "Because DSU algorithms automatically delete cycles from computer memory", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because sorting edges by weight destroys all cycles in the graph", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because spanning trees can contain cycles if edge weights are small", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
