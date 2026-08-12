# Key to Flow: Graph Theory

**Subject Area:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Graph_Theory`

---

## 📌 Core Concept & Mental Model
Graph Theory models pairwise relations between objects using Vertices $V$ and Edges $E$. Graphs $G = (V, E)$ represent networks in computer science, chemistry, transportation, and social science.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Structural & Topological Invariants
* **Handshaking Lemma:** $\sum_{v \in V} \text{deg}(v) = 2 |E|$.
* **Euler's Planar Formula:** For any connected planar graph, $V - E + F = 2$.
* **Eulerian vs. Hamiltonian Paths:**
  * **Eulerian (Visits every edge once):** Connected and every vertex has even degree!
  * **Hamiltonian (Visits every vertex once):** NP-complete problem; Dirac's theorem ($\text{deg}(v) \ge n/2 \implies$ Hamiltonian).
* **Graph Coloring & Chromatic Number $\chi(G)$:** Four Color Theorem (Every planar graph is 4-colorable!).

### 2. Spectral & Algebraic Graph Theory
* **Adjacency Matrix $A$ & Laplacian Matrix $L = D - A$.**
* **Algebraic Connectivity:** Second smallest eigenvalue $\lambda_2(L)$ (Fiedler value) measures network robustness and graph partitioning.

### 3. Top Recommended Resources
* **The Gold Standard Graduate Text:** *Graph Theory* by Reinhard Diestel (Free online preview).
* **Introductory & Algorithmic:** *Introduction to Graph Theory* by Douglas B. West.
* **Spectral Graph Theory:** *Spectral Graph Theory* by Fan Chung.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you prove if a given graph is Bipartite ($\iff$ no odd cycles)?
- [ ] Can you apply Kruskal's and Prim's algorithms to find Minimum Spanning Trees (MST)?
- [ ] Can you prove Planarity using Kuratowski's Theorem ($K_5$ and $K_{3,3}$ minors)?
- [ ] Can you calculate the Laplacian matrix $L$ and compute Betti numbers / connected components?
