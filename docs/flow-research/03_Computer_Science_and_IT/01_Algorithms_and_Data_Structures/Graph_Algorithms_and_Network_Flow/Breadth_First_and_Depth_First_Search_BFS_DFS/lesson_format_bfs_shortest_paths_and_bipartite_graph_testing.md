# Duofy Reusable Lesson Format: BFS Shortest Paths and Bipartite Graph Testing

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Graph_Algorithms_and_Network_Flow / Breadth_First_and_Depth_First_Search_BFS_DFS`  
**Lesson Format Type:** `bfs_shortest_paths_and_bipartite_graph_testing`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the level-order wavefront traversal, unweighted shortest-path guarantees, and 2-coloring bipartite verification of Breadth-First Search (Edward F. Moore 1959; C.Y. Lee; Thomas H. Cormen et al. CLRS Chapter 22): master the **FIFO Queue Traversal Mechanism** executing in $O(V + E)$ time, prove the **Shortest Path Property ($\mathbf{d[v] = d[u] + 1}$)** establishing that BFS discovers every vertex at its minimal geodesic distance in unweighted graphs, formulate the **Bipartite Graph 2-Coloring Algorithm** (coloring vertices in alternating parity sets $\{0, 1\}$), prove the **Odd Cycle Characterization Theorem** (a graph is bipartite if and only if it contains NO odd-length cycles), and trace vertex state transitions (White = undiscovered, Gray = enqueued/frontier, Black = dequeued/expanded).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | BFS Queue Mechanics, Shortest Path Property, & 2-Coloring Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step BFS 2-Coloring Execution and Odd-Cycle Detection Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Graph Traversal State / Metric & Algorithmic Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Core Data Structure Enabling Level-Order Breadth-First Traversal Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Reason BFS Naturally Computes Shortest Paths in Unweighted Graphs Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Breadth-First Search & Bipartite Testing (Moore 1959; CLRS):
   - **The BFS Wavefront Invariant:**
     - Uses a **FIFO Queue $Q$** to discover vertices in monotonically non-decreasing order of distance from source $s$:
       $$\mathbf{d[v] = \begin{cases} 0 & v = s \\ d[u] + 1 & \text{for edge } (u, v) \in E \text{ with } v \text{ White} \end{cases}}$$
     - **Complexity:** $\mathbf{O(V + E)\text{ Time}}$ (every vertex enqueued once, every edge examined once) and $O(V)$ space.
   - **Bipartite Graph Verification (2-Coloring):**
     - A graph is Bipartite $\iff$ Vertices can be partitioned into $V_1, V_2$ such that all edges go between $V_1$ and $V_2$.
     - **The Odd Cycle Theorem (Kőnig 1936):** A graph is bipartite **IF AND ONLY IF it contains NO odd cycles**!
     - **BFS 2-Coloring Rule:** Assign $\text{color}(s) = 0$. For each explored neighbor $v$ of $u$:
       - If $v$ is uncolored: $\text{color}(v) = 1 - \text{color}(u)$, enqueue $v$.
       - If $v$ is already colored and **$\text{color}(v) == \text{color}(u)$**: **Graph contains an odd cycle $\implies$ NOT BIPARTITE!**
2. **Slide 2 (`ordering`):** Provide 5 steps of the BFS 2-coloring bipartite testing algorithm: (1) initialize all vertices with color = -1 (uncolored) and distance d = infinity, (2) select an unvisited starting vertex s, set color[s] = 0, distance d[s] = 0, and push s into a FIFO queue, (3) pop the front vertex u from the queue, (4) iterate through all adjacent neighbors v of u; if v is uncolored, set color[v] = 1 - color[u], d[v] = d[u] + 1, and enqueue v, (5) if neighbor v is already colored and color[v] equals color[u], terminate and output False (Odd Cycle Detected!); otherwise continue until queue is empty and output True!
3. **Slide 3 (`matching`):** Pair 4 BFS concepts (FIFO Queue, Shortest Path Tree, color[v] == color[u] conflict, O(V + E) Runtime) with their algorithmic functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Breadth-First Search relies on a FIFO queue data structure. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why BFS is guaranteed to find shortest paths in unweighted graphs: Why does Breadth-First Search mathematically guarantee finding the shortest path (minimum edge count) from source $s$ to all reachable vertices in an unweighted graph? (Because the FIFO queue maintains the **monotonic distance invariant ($d[v_1] \le d[v_2] \le \dots \le d[v_k]$ with at most 2 consecutive distance values $d$ and $d+1$ in the queue at any time)**; vertices at distance $k$ are strictly dequeued and fully expanded **before ANY vertex at distance $k+1$ is ever dequeued**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bfs_shortest_paths_and_bipartite_graph_testing",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Breadth-First Search & Bipartite Testing (1959)**\n• **The FIFO Queue Monotonicity Invariant:**\n$$\n\\mathbf{d[v] = d[u] + 1 \\qquad (\\text{Queue contains at most two distance levels: } d \\text{ and } d+1)}\n$$\n  - Explores graph in strict concentric ripples $\\implies$ **Guarantees Shortest Path in unweighted graphs**!\n  - **Complexity:** $\\mathbf{O(V + E)\\text{ Time}}$ and $\\mathbf{O(V)\\text{ Space}}$.\n• **Bipartite Graph 2-Coloring (Kőnig 1936):**\n  - Graph is Bipartite $\\iff$ **Contains NO odd-length cycles**!\n  - **The 2-Coloring Invariant:** For each edge $(u, v)$:\n$$\n\\mathbf{\\text{color}(v) = 1 - \\text{color}(u) \\ ; \\quad \\text{If } \\text{color}(v) == \\text{color}(u) \\implies \\text{ODD CYCLE (NOT BIPARTITE)!}}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the BFS 2-coloring bipartite graph verification algorithm.",
      "orderItems": [
        "Initialize all vertices with color = -1 (uncolored) and distance d = infinity",
        "Select an unvisited source vertex s, set color[s] = 0, distance d[s] = 0, and push s into a FIFO queue",
        "Dequeue the front vertex u from the queue and inspect all its adjacent incident neighbors v",
        "If neighbor v is uncolored, assign color[v] = 1 - color[u], set d[v] = d[u] + 1, and push v into the queue",
        "If neighbor v is already colored and color[v] == color[u], terminate with False (odd cycle); otherwise return True"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each BFS graph concept to its exact mathematical role.",
      "matchPairs": [
        { "left": "FIFO Queue", "right": "Ensures vertices are processed strictly in ascending order of their shortest path distance from source" },
        { "left": "color[v] == color[u] Conflict", "right": "Detects the presence of an odd-length cycle, proving the graph cannot be partitioned into two independent sets" },
        { "left": "Shortest Path Tree (d[v])", "right": "Subgraph of BFS tree edges representing minimum-edge distance from source s to all reachable nodes" },
        { "left": "O(V + E) Linear Time", "right": "Optimal time complexity achieved by visiting each vertex once and traversing each edge at most twice" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Breadth-First Search processes vertices in level-order concentric waves using a first-in first-out ___ data structure.",
      "blankAnswer": "queue",
      "blankDistractors": ["stack", "heap", "matrix"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What structural invariant of the FIFO queue mathematically guarantees that BFS always finds the shortest path (minimum edge count) from source s to all reachable nodes in an unweighted graph?",
      "options": [
        { "text": "The FIFO queue maintains distance monotonicity at all times: all vertices currently in the queue have distances of either d or d + 1, guaranteeing that every single vertex at distance d is completely dequeued and explored before any vertex at distance d + 1 is ever expanded", "isCorrect": true, "explanation": "Correct! This is the formal Queue Distance Invariant proved in CLRS Lemma 22.3. Suppose the queue contains vertices $\\langle v_1, v_2, \\dots, v_r \\rangle$. BFS guarantees two fundamental properties: 1. $d[v_r] \\le d[v_1] + 1$ (the distance difference between the newest enqueued vertex and the oldest dequeued vertex is at most 1). 2. $d[v_i] \\le d[v_{i+1}]$ (distances in the queue are strictly monotonically non-decreasing). Because of this FIFO ordering, BFS explores the graph in strict concentric 'wavefronts' of radius $d = 0, 1, 2, \\dots, k$. When a vertex $v$ is first discovered from an active node $u$, $u$ is guaranteed to be at the minimum possible distance from $s$. Thus, $d[v] = d[u] + 1$ represents the absolute shortest unweighted path from $s$ to $v$. Any alternate path discovered later must pass through a node with distance $\\ge d[u]$, making it at least as long." },
        { "text": "Because BFS checks all paths in factorial O(V!) time", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because unweighted graphs always have only 1 valid path between any two nodes", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the queue sorts all vertices using quicksort before every dequeue", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
