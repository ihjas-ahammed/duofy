# Key to Flow: Kruskal and Prim MST (Cut Property, Disjoint Sets, Fibonacci Heaps, & Borůvka)

**Subject Area:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Graph_Algorithms_and_Network_Flow / Kruskal_and_Prim_MST`

---

## 📌 Core Concept & Mental Model
**The Fundamental Cut Property, Disjoint-Set Union-Find (DSU) Amortized Near-Constant Cycle Checks, Fibonacci Heap Relaxations, and Parallel Component Contractions** govern Minimum Spanning Tree construction across weighted undirected networks (Otakar Borůvka 1926, Joseph B. Kruskal 1956, Robert C. Prim 1957, Robert E. Tarjan 1983, CLRS Chapter 23):
* **The Master Theoretical Invariants:**
  - Given connected weighted undirected graph $G = (V, E)$ with weight function $w: E \to \mathbb{R}$.
  - An MST $T$ spans all $V$ vertices using exactly **$|V| - 1$ edges** while minimizing total weight $w(T) = \sum_{e \in T} w(e)$.
  - **1. The Cut Property (Light-Edge Rule):** For ANY partition (cut) $(S, V \setminus S)$ of vertices, the **lightest edge crossing the cut boundary belongs to the MST**!
  - **2. The Cycle Property (Heavy-Edge Rule):** For ANY simple cycle $C$ in $G$, the **heaviest edge in $C$ cannot belong to any unique MST**!
* **The 3 Classic MST Paradigms:**
  - **1. Kruskal's Algorithm (Edge-Centric Greedy - 1956):**
    - Sort all $E$ edges in non-decreasing order of weight in $O(E\log E)$ time.
    - Greedily add edge $(u, v)$ if $u$ and $v$ belong to different connected components.
    - **Disjoint-Set Union (DSU) with Path Compression & Union by Rank:**
      - Merging and finding component roots runs in near-constant **$\mathbf{O(\alpha(V))}$ amortized time** (where $\alpha$ is the inverse Ackermann function, $\alpha(V) < 5$ for all practical inputs).
      - Total Complexity: $\mathbf{O(E\log E) = O(E\log V)}$ (optimal for sparse graphs).
  - **2. Prim-Jarník Algorithm (Vertex-Centric Cut Growing - 1930 / 1957):**
    - Grow a single connected tree $T$ from an arbitrary root vertex $r$.
    - Maintain a min-priority queue of cut-crossing edges connecting $T$ to $V \setminus T$.
    - **Complexity Architectures:**
      - **Adjacency Matrix:** $\mathbf{O(V^2)}$ (optimal for dense graphs where $E = \Theta(V^2)$).
      - **Binary Heap:** $\mathbf{O(E\log V)}$ (standard implementation).
      - **Fibonacci Heap (Fredman & Tarjan 1987):** $O(1)$ amortized `decrease-key` $\implies \mathbf{O(E + V\log V)}$.
  - **3. Borůvka's Parallel Component Contraction Algorithm (1926):**
    - In each phase, every connected component simultaneously selects its cheapest incident crossing edge.
    - Contracts edges, halving the number of components in each step.
    - Total Phases: $\le \lceil \log_2 V \rceil \implies \mathbf{O(E\log V)\text{ Time}}$ (highly parallelizable in distributed systems!).

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Cut Property Bridge
* Kruskal: Grows multiple disjoint forests; merges them via globally sorted edges.
* Prim: Grows one single contiguous tree; expands the active cut boundary.
* Borůvka: Grows all components simultaneously in parallel rounds.

### 2. Top Recommended Resources
* **The Algorithms Standard:** *Introduction to Algorithms* (CLRS), Chapter 23 (Minimum Spanning Trees).
* **Data Structures Classic:** *Data Structures and Network Algorithms* by Robert E. Tarjan (SIAM).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you prove the Cut Property using an exchange argument?
- [ ] Can you implement Kruskal's algorithm with DSU path compression and union by rank?
- [ ] Can you explain why Fibonacci heaps reduce Prim's runtime to $O(E + V\log V)$?
- [ ] Can you trace one round of Borůvka's parallel component contractions?
