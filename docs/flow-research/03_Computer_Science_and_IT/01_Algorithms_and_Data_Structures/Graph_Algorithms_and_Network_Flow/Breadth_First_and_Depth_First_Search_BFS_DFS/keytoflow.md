# Key to Flow: Breadth-First and Depth-First Search BFS DFS (Traversals, SCCs, Bridges, & Topological Sorting)

**Subject Area:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Graph_Algorithms_and_Network_Flow / Breadth_First_and_Depth_First_Search_BFS_DFS`

---

## 📌 Core Concept & Mental Model
**FIFO Wavefront Expansion, LIFO Recursive Spanning Trees, Discovery/Finish Timestamps, and Low-Link Connectivity Metrics** govern fundamental graph traversals, structural edge classifications, and linear-time connectivity algorithms (Edsger W. Dijkstra 1959, Robert E. Tarjan 1972, John E. Hopcroft 1973, S. Rao Kosaraju 1978, CLRS Chapter 22):
* **1. Breadth-First Search (BFS - Wavefront Expansion):**
  - **Mechanism:** Explores graph $G = (V, E)$ level by level using a **FIFO Queue** in $O(V + E)$ time.
  - **Properties:**
    - Finds the **Shortest Path** (minimum number of edges) from source $s$ to all reachable vertices in unweighted graphs.
    - **Bipartite Testing (2-Coloring):** Colors nodes alternatively (0 and 1). A graph is bipartite if and only if no edge connects two vertices of the same color (i.e. contains no odd cycles).
* **2. Depth-First Search (DFS - Spanning Tree & Timestamps):**
  - **Mechanism:** Explores deep along branches before backtracking using a **LIFO Stack / Recursion** in $O(V + E)$ time.
  - **Timestamps ($d[u]$ and $f[u]$):**
    - $d[u]$: Discovery time when vertex $u$ is first visited (White $\to$ Gray).
    - $f[u]$: Finish time when all outgoing edges from $u$ are fully explored (Gray $\to$ Black).
    - **Parenthesis Theorem:** Subtrees form properly nested intervals $[d[u], f[u]]$.
  - **The 4 Directed DFS Edge Types:**
    1. **Tree Edges:** Edges $(u, v)$ discovering a White vertex.
    2. **Back Edges:** Edges $(u, v)$ pointing to an **ancestor (Gray)** $\iff$ **DIRECTED CYCLE DETECTED!**
    3. **Forward Edges:** Edges $(u, v)$ pointing to a descendant (Black).
    4. **Cross Edges:** Edges $(u, v)$ pointing across subtrees (Black).
* **3. Topological Sorting on DAGs ($O(V + E)$):**
  - **DFS Post-Order Reversal:** Sort vertices in descending order of finish times $f[u]$.
  - **Kahn's Algorithm (BFS In-Degree):** Enqueue all vertices with in-degree 0; remove edges and decrement neighbor in-degrees.
* **4. Strongly Connected Components (SCC in Directed Graphs):**
  - A maximal subgraph where every pair of vertices can reach each other.
  - **Kosaraju-Sharir (2-Pass DFS):** (1) Run DFS on $G$ pushing to finish stack. (2) Run DFS on transposed graph $G^T$ popping stack $\implies$ Peels off SCCs in $O(V + E)$!
  - **Tarjan's SCC (1-Pass DFS):** Uses discovery time `tin[u]` and **low-link** value `low[u] = min(tin[u], tin[v], low[w])` with a stack. Component roots have `low[u] == tin[u]`.
* **5. Bridges & Articulation Points (Hopcroft-Tarjan 1973):**
  - In undirected graphs:
    - **Bridge (Cut Edge):** Edge $(u, v)$ is a bridge $\iff \mathbf{\text{low}[v] > \text{tin}[u]}$ (no back edge to $u$ or above).
    - **Articulation Point (Cut Vertex):** Vertex $u$ is an articulation point if:
      1. $u$ is the DFS root and has **$\ge 2$ children** in the DFS tree.
      2. $u$ is a non-root and has a child $v$ with **$\mathbf{\text{low}[v] \ge \text{tin}[u]}$**.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Low-Link Mental Model & The Cycle Invariant
* Cycle Condition: Directed graph has cycle $\iff$ DFS encounters a **Back Edge** to a Gray vertex.
* Low-Link `low[u]`: The earliest discovery time reachable from $u$'s subtree via at most one back-edge.

### 2. Top Recommended Resources
* **The Algorithms Standard:** *Introduction to Algorithms* (CLRS), Chapter 22 (Elementary Graph Algorithms).
* **Graph Theory Authority:** *Algorithm Design* by Jon Kleinberg & Éva Tardos (Chapter 3).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you classify all 4 edge types in a directed DFS traversal?
- [ ] Can you implement Kahn's algorithm for topological sorting and cycle detection?
- [ ] Can you trace Kosaraju's 2-pass algorithm on a directed graph using $G^T$?
- [ ] Can you compute `tin` and `low` arrays to identify bridges in an undirected network?
