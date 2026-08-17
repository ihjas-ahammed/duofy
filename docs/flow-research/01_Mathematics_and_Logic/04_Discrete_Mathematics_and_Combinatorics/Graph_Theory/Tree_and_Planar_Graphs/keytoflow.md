# Key to Flow: Tree and Planar Graphs (Graph Theory)

**Subject Area:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Graph_Theory / Tree_and_Planar_Graphs`

---

## 📌 Core Concept & Mental Model
**Trees and Planar Graphs** represent the two most fundamental topological graph classes in discrete mathematics:
* **Trees (Minimal Connectivity & Acyclicity):**
  A simple graph $T$ on $n$ vertices with $n-1$ edges having no cycles. Every edge is a bridge, and every pair of vertices is connected by a unique simple path.
  - **Cayley's Tree Formula (1889):** The number of labelled trees on $n$ vertices is exactly $n^{n-2}$ (bijectively encoded by length-$(n-2)$ **Prüfer Sequences**).
* **Planar Graphs (2D Embeddability):**
  A graph $G$ that can be drawn in the Euclidean plane $\mathbb{R}^2$ such that no two edges cross:
  - **Euler's Polyhedral Formula (1758):** For any connected plane graph with $V$ vertices, $E$ edges, and $F$ faces:
    $$V - E + F = 2$$
  - **Planar Edge Bound:** For simple planar graphs with $V \ge 3$: $E \le 3V - 6$ (and $E \le 2V - 4$ for triangle-free planar graphs).

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Cayley's Theorem & Spanning Tree Enumeration
* **Prüfer Sequence Encoding:** Successively delete the smallest-labelled leaf and record its unique neighbor, producing sequence $(s_1, \dots, s_{n-2}) \in \{1, \dots, n\}^{n-2}$.
* **Kirchhoff's Matrix Tree Theorem (1847):** The number of spanning trees $\tau(G)$ of any graph $G$ equals any cofactor of its Laplacian matrix $\mathbf{L} = \mathbf{D} - \mathbf{A}$:
  $$\tau(G) = \det(\mathbf{L}_{ii}) = \frac{1}{n} \prod_{i=2}^n \mu_i \quad (\text{where } \mu_i \text{ are non-zero Laplacian eigenvalues})$$

### 2. Forbidden Minor Characterizations (Planarity Tests)
* **Kuratowski's Theorem (Kazimierz Kuratowski, 1930):**
  A finite graph $G$ is planar if and only if it does NOT contain a **subdivision** of $K_5$ (complete graph on 5 vertices) or $K_{3,3}$ (complete bipartite utility graph).
* **Wagner's Theorem (Klaus Wagner, 1937):**
  A finite graph $G$ is planar if and only if neither $K_5$ nor $K_{3,3}$ is a **graph minor** of $G$ (obtained via edge deletions and contractions).

### 3. Top Recommended Resources
* **The Master Graph Theory Text:** *Graph Theory* by Reinhard Diestel (Chapters on Trees, Planarity, and Minors).
* **Topological Graph Theory Standard:** *Graphs on Surfaces* by Bojan Mohar & Carsten Thomassen.
* **Introductory Excellence:** *Pearls in Graph Theory: A Comprehensive Approach* by Nora Hartsfield & Gerhard Ringel.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you convert back and forth between a labelled tree and its Prüfer sequence in $O(n)$ time?
- [ ] Can you calculate the number of spanning trees using Kirchhoff's Laplacian cofactor matrix?
- [ ] Can you use Euler's inequality $E \le 3V - 6$ to prove non-planarity of $K_5$ and $K_{3,3}$?
- [ ] Can you identify $K_5$ and $K_{3,3}$ subdivisions in the Petersen graph?
