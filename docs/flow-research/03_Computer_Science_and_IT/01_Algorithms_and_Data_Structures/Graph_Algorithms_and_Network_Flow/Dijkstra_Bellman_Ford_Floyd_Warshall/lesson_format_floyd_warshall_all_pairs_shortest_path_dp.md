# Duofy Reusable Lesson Format: Floyd-Warshall All-Pairs Shortest Path DP

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Graph_Algorithms_and_Network_Flow / Dijkstra_Bellman_Ford_Floyd_Warshall`  
**Lesson Format Type:** `floyd_warshall_all_pairs_shortest_path_dp`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the dynamic programming formulation, intermediate vertex indexing, and triple-nested loop structure of the Floyd-Warshall All-Pairs Shortest Path (APSP) algorithm (Robert W. Floyd 1962; Stephen Warshall 1962; Bernard Roy 1959; Thomas H. Cormen et al. CLRS Chapter 25): master the definition of intermediate vertices $\{1, 2, \dots, k\}$, formulate the **Floyd-Warshall DP Recurrence ($\mathbf{d^{(k)}[i][j] = \min(d^{(k-1)}[i][j], \ d^{(k-1)}[i][k] + d^{(k-1)}[k][j])}$)**, prove why the **outer loop MUST iterate over intermediate vertex $k$ ($k = 1 \dots V$)**, analyze optimal space compression into a single $V \times V$ in-place matrix $D[i][j]$, detect negative-weight cycles by inspecting the main diagonal ($\mathbf{\exists i : D[i][i] < 0}$), and reconstruct shortest paths using the auxiliary predecessor matrix $\Pi[i][j]$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Floyd-Warshall DP Recurrence, Intermediate Vertex k, & Diagonal Negative Cycles Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Triple-Nested Loop Execution for Floyd-Warshall Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Floyd-Warshall Table Component / Variable & Algorithmic Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Loop Variable that MUST be Placed in the Outermost Loop of Floyd-Warshall Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Consequence of Placing Intermediate Vertex k in the Innermost Loop Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Floyd-Warshall APSP (Floyd 1962; Warshall 1962; CLRS):
   - **The All-Pairs Shortest Path (APSP) Problem:** Find shortest path distances between ALL pairs of vertices $i, j \in V$ in $O(V^3)$ time and $O(V^2)$ space.
   - **The Intermediate Vertex DP Formulation:**
     - Let intermediate vertices be restricted to subset $\{1, 2, \dots, k\}$.
     - **The Recurrence Relation:**
       $$\mathbf{d^{(k)}[i][j] = \min\Big( \underbrace{d^{(k-1)}[i][j]}_{\text{Path DOES NOT use vertex } k}, \quad \underbrace{d^{(k-1)}[i][k] + d^{(k-1)}[k][j]}_{\text{Path USES vertex } k \text{ as intermediate}} \Big)}$$
     - Base Case ($k=0$): $d^{(0)}[i][j] = w(i, j)$ if $(i, j) \in E$, $0$ if $i=j$, and $\infty$ otherwise.
   - **In-Place Space Optimization ($O(V^2)$ Matrix):**
     - Single 2D matrix $D[i][j]$ updated in-place: $D[i][j] = \min(D[i][j], D[i][k] + D[k][j])$.
   - **Negative Cycle Detection Theorem:**
     $$\mathbf{\exists i \in V \text{ such that } D[i][i] < 0 \iff \mathbf{\text{NEGATIVE-WEIGHT CYCLE DETECTED!}}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of executing the Floyd-Warshall algorithm: (1) initialize the V x V distance matrix D with edge weights w(i, j), setting diagonal entries D[i][i] = 0 and non-edges to infinity, (2) begin the outermost loop iterating intermediate vertex k from 1 to V, (3) begin the middle loop iterating source vertex i from 1 to V, (4) begin the innermost loop iterating destination vertex j from 1 to V, updating D[i][j] = min(D[i][j], D[i][k] + D[k][j]), (5) after all 3 loops terminate, check the diagonal D[i][i] for negative values, returning D as the complete all-pairs shortest path matrix!
3. **Slide 3 (`matching`):** Pair 4 Floyd-Warshall concepts (Intermediate Vertex k, D[i][k] + D[k][j], Negative Diagonal D[i][i] < 0, Transitive Closure Warshall) with their mathematical definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in Floyd-Warshall, the loop iterating over intermediate vertex k must be the outermost loop. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the disastrous bug that occurs if the intermediate loop `k` is placed as the innermost loop (`for i -> for j -> for k`): If a programmer places the loop over intermediate vertices `k` in the innermost position instead of the outermost position, why does the algorithm produce completely incorrect shortest path distances? (Because the DP recurrence requires that **paths using intermediate vertices $\{1 \dots k-1\}$ must be fully computed for ALL pairs $(i, j)$ before vertex $k$ can be introduced**; placing `k` in the innermost loop only tests 1-hop detours through single intermediate vertices, failing to find multi-hop shortest paths like $i \to k_1 \to k_2 \to j$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "floyd_warshall_all_pairs_shortest_path_dp",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Floyd-Warshall APSP Algorithm (1962)**\n• **The Intermediate Vertex DP Recurrence ($O(V^3)$ Time, $O(V^2)$ Space):**\n$$\n\\mathbf{d^{(k)}[i][j] = \\min\\Big( d^{(k-1)}[i][j], \\quad d^{(k-1)}[i][k] + d^{(k-1)}[k][j] \\Big)}\n$$\n  - $k$: Intermediate vertex set restricted to $\\{1, 2, \\dots, k\\}$.\n• **The Golden Loop Order Rule:** Loop over intermediate vertex **$k$ MUST BE OUTSIDE**:\n$$\n\\mathbf{\\text{for } k = 1 \\dots V: \\quad \\text{for } i = 1 \\dots V: \\quad \\text{for } j = 1 \\dots V: \\quad D[i][j] = \\min(D[i][j], D[i][k] + D[k][j])}\n$$\n• **Negative Cycle Detection:** $\\mathbf{\\exists i : D[i][i] < 0 \\implies \\text{Negative Cycle Exists!}}$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the in-place Floyd-Warshall All-Pairs Shortest Path algorithm.",
      "orderItems": [
        "Initialize the V x V distance matrix D with edge weights w(i, j), setting D[i][i] = 0 and non-edges to infinity",
        "Launch the outermost loop iterating intermediate vertex index k from 1 up to V",
        "Launch the middle loop iterating starting source vertex index i from 1 up to V",
        "Launch the innermost loop iterating target destination vertex index j from 1 up to V, updating D[i][j] = min(D[i][j], D[i][k] + D[k][j])",
        "Inspect all diagonal entries D[i][i]; if any D[i][i] < 0, report a negative cycle, otherwise return completed matrix D"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Floyd-Warshall algorithm component to its exact mathematical purpose.",
      "matchPairs": [
        { "left": "Intermediate Index k", "right": "Outermost DP stage variable allowing vertices {1...k} to serve as intermediate path waypoints" },
        { "left": "D[i][k] + D[k][j]", "right": "Total distance of routing a path from source i to target j through intermediate waypoint k" },
        { "left": "Diagonal Condition D[i][i] < 0", "right": "Proof that vertex i belongs to a negative-weight cycle allowing infinite distance reduction" },
        { "left": "Warshall's Transitive Closure", "right": "Boolean variation using logical OR/AND to determine reachability between all pairs of nodes" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the triple-nested loop of the Floyd-Warshall algorithm, the loop over intermediate vertex k must be placed in the ___ position.",
      "blankAnswer": "outermost",
      "blankDistractors": ["innermost", "middle", "second"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What happens if a programmer mistakenly writes the triple-nested loop of Floyd-Warshall with the intermediate vertex loop k on the inside ('for i -> for j -> for k')?",
      "options": [
        { "text": "The algorithm fails to find multi-hop shortest paths and produces incorrect distances; the DP state requires all sub-paths using intermediate nodes {1...k-1} to be fully solved for ALL pairs (i, j) before node k is introduced; placing k on the inside only checks single-hop detours (paths with at most 1 intermediate node), missing paths with 2 or more intermediate hops like i -> k1 -> k2 -> j", "isCorrect": true, "explanation": "Correct! This is one of the most famous implementation bugs in computer science. The Floyd-Warshall dynamic programming recurrence $d^{(k)}[i][j] = \\min(d^{(k-1)}[i][j], d^{(k-1)}[i][k] + d^{(k-1)}[k][j])$ is defined inductively over the allowed set of intermediate vertices $\\{1, 2, \\dots, k\\}$. When $k = 1$ in the outer loop, the algorithm finds all shortest paths using vertex 1. When $k = 2$, it uses the results from $k = 1$ to find paths that can pass through BOTH vertex 1 and vertex 2 (e.g. $i \\to 1 \\to 2 \\to j$). By the time $k = V$, it has considered all possible multi-hop paths of any length. However, if you place $k$ on the inside (`for i -> for j -> for k`), for a fixed pair $(i, j)$, the inner loop simply computes $\\min_k(D[i][j], D[i][k] + D[k][j])$ using the INITIAL direct edge weights. This only checks whether routing through a SINGLE intermediate node $k$ is better than the direct edge $(i, j)$. It can never combine multiple intermediate vertices together (such as a path with 3 or 4 intermediate hops), completely breaking the dynamic programming principle." },
        { "text": "The code will produce an infinite loop because k cannot be inside", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The algorithm runs in O(V^2) time instead of O(V^3)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The matrix will fill with random NaN numbers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
