# Duofy Reusable Lesson Format: Edmonds-Karp BFS Augmenting Paths

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Graph_Algorithms_and_Network_Flow / Ford_Fulkerson_and_Max_Flow_Min_Cut`  
**Lesson Format Type:** `edmonds_karp_bfs_augmenting_paths`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the shortest-augmenting-path selection, monotonic distance bounds, and polynomial-time complexity of the Edmonds-Karp algorithm (Jack Edmonds & Richard M. Karp 1972; Thomas H. Cormen et al. CLRS Chapter 26): contrast generic Ford-Fulkerson's pseudo-polynomial $O(E |f^*|)$ DFS vulnerability (where pathological integer or irrational graphs cause millions of 1-unit augmentations or infinite non-termination) with **Edmonds-Karp's Breadth-First Search (BFS)** strategy (always selecting the augmenting path with the **minimum number of edges** in $G_f$), prove the **Monotonic Shortest-Path Distance Theorem ($\mathbf{\delta_f(s, v) \text{ increases monotonically}}$)**, prove that each edge in $G_f$ can become critical at most $|V| / 2$ times (bounding total augmentations to $O(V \cdot E)$), and evaluate the resulting strictly polynomial **$O(V E^2)$ time complexity**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Edmonds-Karp BFS Rule, Monotonic Distance Theorem, & O(V E^2) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Edmonds-Karp BFS Path Finding and Augmentation Loop Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Flow Algorithm / Metric & Asymptotic Bound Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Graph Traversal Algorithm Used by Edmonds-Karp to Find Shortest Paths Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Critical Edge Bound Theorem Proving O(V E^2) Polynomial Runtime Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State The Edmonds-Karp Algorithm (Edmonds & Karp 1972; CLRS):
   - **The Core Rule:** An implementation of Ford-Fulkerson where the augmenting path $p$ is chosen via **Breadth-First Search (BFS)** as the shortest path from $s$ to $t$ in terms of edge count in $G_f$.
   - **Theorem 1: Monotonic Shortest-Path Distances:**
     - For all vertices $v \in V \setminus \{s, t\}$, the shortest-path distance $\delta_f(s, v)$ in the residual network $G_f$ **increases monotonically** with each flow augmentation:
       $$\mathbf{\delta_{f'}(s, v) \ge \delta_f(s, v)}$$
   - **Theorem 2: Bounding Critical Edges:**
     - An edge $(u, v)$ is *critical* on augmenting path $p$ if $c_f(p) = c_f(u, v)$ (it is a bottleneck that disappears from $G_f$).
     - Between consecutive times that edge $(u, v)$ becomes critical, $\delta(s, u)$ must increase by at least 2.
     - Maximum times $(u, v)$ can become critical: **$\le |V| / 2$**.
   - **Total Asymptotic Complexity:**
     $$\mathbf{\text{Total Augmentations} = O(V \cdot E) \quad \times \quad \text{BFS Cost per path} = O(E) \implies \mathbf{O(V E^2)\text{ Time}} \quad (\text{Strictly Polynomial!})}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of the Edmonds-Karp algorithm loop: (1) initialize all flow values to zero in the flow network G, (2) run a Breadth-First Search (BFS) starting from source s on residual graph G_f to find the shortest path p to sink t, (3) if BFS cannot reach sink t, terminate the algorithm and return the current total flow as maximum flow, (4) trace back along parent pointers from t to s to determine the minimum bottleneck capacity c_f(p), (5) augment flow along path p, updating residual capacities in G_f, and return to step 2 for the next BFS!
3. **Slide 3 (`matching`):** Pair 4 network flow algorithms/bounds (Edmonds-Karp O(V E^2), Generic Ford-Fulkerson O(E |f*|), Monotonic Distance Invariant, Critical Edge Limit |V|/2) with their descriptions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Edmonds-Karp uses Breadth-First Search (BFS) to find augmenting paths. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on how Edmonds-Karp overcomes the pathological failure case of generic Ford-Fulkerson: Consider a flow network with a central cross-edge of capacity 1 and two outer edges of capacity $1,000,000$. Generic Ford-Fulkerson using DFS could alternate back-and-forth 2,000,000 times, adding 1 unit of flow per step. How does Edmonds-Karp solve this in just 2 augmentations? (Because Edmonds-Karp uses **BFS to always select the path with the fewest edges**; after the first 2-edge or 3-edge paths saturate the large $1,000,000$-capacity outer edges, **the network saturates in just 2 BFS augmentations ($O(1)$ steps)**, completely bypassing the pathological ping-pong bottleneck).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "edmonds_karp_bfs_augmenting_paths",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Edmonds-Karp Algorithm (1972)**\n• **The Breadth-First Search (BFS) Strategy:**\n$$\n\\mathbf{\\text{Always choose augmenting path } p \\text{ with FEWEST edges using BFS!}}\n$$\n• **The Monotonic Distance Theorem (CLRS 26.7):**\n$$\n\\mathbf{\\delta_{f'}(s, v) \\ge \\delta_f(s, v) \\qquad (\\text{Shortest path distance never decreases!})}\n$$\n• **The Critical Edge Bound:**\n  - An edge $(u, v)$ disappears from $G_f$ when saturated (critical edge).\n  - Each edge can be critical **at most $|V| / 2$ times** $\\implies$ **Total Augmentations $\\le O(V \\cdot E)$**!\n• **Total Asymptotic Complexity:** $\\mathbf{O(V E^2)\\text{ Time}}$ (Strictly polynomial; immune to capacities!)"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential algorithmic steps of the Edmonds-Karp BFS max-flow solver.",
      "orderItems": [
        "Initialize all network edge flows f(u, v) = 0 and construct the initial residual graph G_f",
        "Execute Breadth-First Search (BFS) starting from source s to locate the shortest path p to sink t in G_f",
        "If BFS fails to reach sink t, terminate the loop and return current flow as the optimal Maximum Flow",
        "Traverse backwards from t to s along predecessor pointers to identify the bottleneck residual capacity c_f(p)",
        "Augment flow along path p by c_f(p), update forward and reverse residual capacities in G_f, and repeat BFS"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each network flow method to its exact asymptotic time complexity.",
      "matchPairs": [
        { "left": "Edmonds-Karp Algorithm", "right": "O(V * E^2) strictly polynomial time using BFS shortest augmenting paths" },
        { "left": "Generic Ford-Fulkerson (DFS)", "right": "O(E * |f*|) pseudo-polynomial time dependent on total maximum flow value" },
        { "left": "Critical Edge Bound (|V| / 2)", "right": "Maximum number of times any individual edge can become a bottleneck" },
        { "left": "Monotonic Distance Property", "right": "Guarantees that shortest residual distance from source s to any node v never decreases" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Edmonds-Karp algorithm eliminates the pseudo-polynomial weakness of Ford-Fulkerson by selecting paths via breadth-first ___ (BFS).",
      "blankAnswer": "search",
      "blankDistractors": ["sort", "reduction", "relaxation"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a pathological flow network where outer edges have capacity 1,000,000 and a central bridge edge has capacity 1, generic DFS-based Ford-Fulkerson can take 2,000,000 iterations. How does Edmonds-Karp resolve this network in only 2 iterations?",
      "options": [
        { "text": "Edmonds-Karp uses BFS to discover shortest paths in terms of edge count; the two direct 2-edge paths (s -> u -> t and s -> v -> t) have length 2, while any path using the central bridge has length 3; BFS greedily chooses the 2-edge paths first, pushing 1,000,000 units of flow in each of the 2 iterations and saturating the network immediately", "isCorrect": true, "explanation": "Correct! This classic example illustrates why BFS selection transforms Ford-Fulkerson into a strictly polynomial algorithm. In the famous pathological diamond graph: Edge $(s, u) = 1,000,000$, $(v, t) = 1,000,000$, $(s, v) = 1,000,000$, $(u, t) = 1,000,000$, and central cross-edge $(u, v) = 1$. If an arbitrary DFS algorithm repeatedly chooses the 3-edge zigzag path $s \\to u \\to v \\to t$, it pushes only 1 unit of flow (the bottleneck of the cross-edge), and then on the next step pushes 1 unit along $s \\to v \\to u \\to t$ using the backward edge, taking 2,000,000 iterations! However, Edmonds-Karp uses BFS, which measures path length by the NUMBER OF EDGES. The direct paths $s \\to u \\to t$ (length 2) and $s \\to v \\to t$ (length 2) are shorter than the 3-edge zigzag path $s \\to u \\to v \\to t$. BFS will ALWAYS select the length-2 paths first! In iteration 1, it pushes 1,000,000 units along $s \\to u \\to t$. In iteration 2, it pushes 1,000,000 units along $s \\to v \\to t$. The entire flow of 2,000,000 is completed in exactly 2 augmentations." },
        { "text": "Because Edmonds-Karp multiplies all capacities by 2,000,000 before running", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because BFS deletes all edges with capacity 1 from the graph", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Edmonds-Karp uses dynamic programming instead of graphs", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
