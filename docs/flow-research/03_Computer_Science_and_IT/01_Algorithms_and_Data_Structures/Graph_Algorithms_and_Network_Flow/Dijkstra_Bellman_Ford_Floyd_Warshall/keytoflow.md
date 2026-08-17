# Key to Flow: Dijkstra, Bellman-Ford, Floyd-Warshall, and Johnson (Shortest Paths & Negative Cycles)

**Subject Area:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Graph_Algorithms_and_Network_Flow / Dijkstra_Bellman_Ford_Floyd_Warshall`

---

## 📌 Core Concept & Mental Model
**Edge Relaxation Invariants, Greedy Priority Queues, Dynamic Programming Multi-Pass Convergence, and Potential-Based Reweighting** govern single-source and all-pairs shortest path computation across directed/undirected networks (Edsger W. Dijkstra 1959, Richard Bellman 1958, Lester Ford 1956, Robert Floyd 1962, Donald B. Johnson 1977, CLRS Chapters 24 & 25):
* **The Master Relaxation Operation:**
  $$\mathbf{\text{RELAX}(u, v, w): \quad \text{if } d[u] + w(u, v) < d[v] \implies d[v] = d[u] + w(u, v), \ \pi[v] = u}$$
* **The Shortest Path Algorithm Taxonomy:**
  $$\begin{array}{|l|l|l|l|l|}
  \hline
  \textbf{Algorithm} & \textbf{Scope} & \textbf{Negative Edges?} & \textbf{Time Complexity} & \textbf{Primary Mechanism} \\
  \hline
  \mathbf{\text{Dijkstra}} & \text{Single-Source} & \mathbf{\text{NO } (w \ge 0)} & \mathbf{O((V + E)\log V)} & \text{Greedy Min-Priority Queue} \\
  \mathbf{\text{Bellman-Ford}} & \text{Single-Source} & \mathbf{\text{YES} \ (\text{Detects Cycles})} & \mathbf{O(V \cdot E)} & V-1 \text{ passes of edge relaxation} \\
  \mathbf{\text{Floyd-Warshall}} & \text{All-Pairs (APSP)} & \text{YES (No neg cycles)} & \mathbf{O(V^3)} & \text{DP on intermediate vertex } k \\
  \mathbf{\text{Johnson's}} & \text{All-Pairs (APSP)} & \text{YES} & \mathbf{O(V^2 \log V + VE)} & \text{Potential reweighting } + V \times \text{Dijkstra} \\
  \hline
  \end{array}$$
* **1. Dijkstra's Algorithm (Greedy Frontier Expansion):**
  - Assumes $w(u, v) \ge 0$. Once a node $u$ is extracted from the min-heap, its shortest distance $d[u]$ is finalized.
  - **Failure on Negative Weights:** Negative edges violate monotonicity, causing finalized nodes to need updating.
* **2. Bellman-Ford (Convergence & Negative Cycle Detection):**
  - A simple shortest path in a graph with $V$ vertices contains at most **$V-1$ edges**.
  - **Pass $1 \dots V-1$:** Relax all $E$ edges in arbitrary order $\implies$ All simple shortest paths converge!
  - **Pass $V$ (Cycle Detection):** If ANY edge can still be relaxed on the $V$-th pass:
    $$\mathbf{\exists (u, v) \in E \text{ s.t. } d[u] + w(u, v) < d[v] \implies \text{NEGATIVE-WEIGHT CYCLE DETECTED!}}$$
* **3. Floyd-Warshall (Dynamic Programming on Intermediate Nodes):**
  - Let $d^{(k)}[i][j]$ = shortest path from $i$ to $j$ with intermediate vertices in $\{1, 2, \dots, k\}$.
  - **Recurrence:** $\mathbf{d^{(k)}[i][j] = \min(d^{(k-1)}[i][j], \ d^{(k-1)}[i][k] + d^{(k-1)}[k][j])}$.
  - Negative cycle exists $\iff \exists i: d[i][i] < 0$ along main diagonal!
* **4. Johnson's Algorithm (Sparse APSP via Reweighting):**
  - Adds auxiliary super-source $s$ connected to all vertices with weight 0; runs Bellman-Ford to get potentials $h(v) = d[s, v]$.
  - **Reweighted Edge Cost:** $\mathbf{\hat{w}(u, v) = w(u, v) + h(u) - h(v) \ge 0}$ (by triangle inequality!).
  - Runs Dijkstra $V$ times on non-negative graph $\hat{G}$, subtracting $h(u) - h(v)$ to recover true distances!

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Decision Tree for Shortest Paths
* Non-negative single-source $\to$ Dijkstra ($O(E\log V)$).
* Negative edge single-source $\to$ Bellman-Ford ($O(VE)$).
* Dense All-Pairs $\to$ Floyd-Warshall ($O(V^3)$).
* Sparse All-Pairs $\to$ Johnson's ($O(V^2\log V + VE)$).

### 2. Top Recommended Resources
* **The Algorithms Standard:** *Introduction to Algorithms* (CLRS), Chapters 24 (Single-Source Shortest Paths) & 25 (All-Pairs Shortest Paths).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you implement Dijkstra's algorithm using a min-heap in $O((V+E)\log V)$?
- [ ] Can you explain why Bellman-Ford requires exactly $V-1$ relaxation passes?
- [ ] Can you set up the triple-nested loop for Floyd-Warshall and identify the intermediate vertex $k$?
- [ ] Can you prove that Johnson's potential reweighting $\hat{w}(u, v) = w(u, v) + h(u) - h(v)$ is always non-negative?
