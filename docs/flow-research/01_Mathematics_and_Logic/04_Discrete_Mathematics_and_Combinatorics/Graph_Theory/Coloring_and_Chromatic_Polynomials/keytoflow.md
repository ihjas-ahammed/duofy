# Key to Flow: Graph Coloring & Chromatic Polynomials (Graph Theory)

**Subject Area:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Graph_Theory / Coloring_and_Chromatic_Polynomials`

---

## 📌 Core Concept & Mental Model
**Graph Coloring & Chromatic Invariants** formalize mutual exclusion and conflict scheduling:
* **The Chromatic Number $\chi(G)$:**
  The minimal number of colors needed to color vertices $V(G)$ such that adjacent vertices receive distinct colors:
  $$\omega(G) \le \chi(G) \le \Delta(G) + 1$$
  *(where $\omega(G)$ is the clique number and $\Delta(G)$ is the maximum vertex degree).*
* **Brooks' Theorem (R. Leonard Brooks, 1941):**
  For every connected simple graph $G$, $\chi(G) \le \Delta(G)$ **unless** $G$ is a complete graph $K_{\Delta+1}$ or an odd cycle $C_{2k+1}$ (where $\chi = \Delta + 1$).
* **The Chromatic Polynomial $P(G, k)$ (George Birkhoff, 1912):**
  A polynomial in $k$ counting the exact number of proper $k$-vertex-colorings:
  $$P(G, k) = k^{|V|} - |E| k^{|V|-1} + \dots + (-1)^{|V|-c(G)} a_0 k^{c(G)}$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Deletion-Contraction Recurrence (Fundamental Engine)
For any edge $e = (u, v) \in E(G)$:
$$P(G, k) = P(G \setminus e, k) - P(G / e, k)$$
* **$G \setminus e$ (Deletion):** Allows $u$ and $v$ to receive the same OR different colors.
* **$G / e$ (Contraction):** Identifies $u$ and $v$ into a single merged vertex (forces identical colors).
* **Canonical Polynomials:**
  - **Complete Graph $K_n$:** $P(K_n, k) = k(k-1)(k-2)\dots(k-n+1) = k_{(n)}$.
  - **Tree $T_n$ / Path $P_n$:** $P(T_n, k) = k(k-1)^{n-1}$.
  - **Cycle $C_n$:** $P(C_n, k) = (k-1)^n + (-1)^n (k-1)$.

### 2. Edge Coloring: Vizing's Theorem (1964)
* **Chromatic Index $\chi'(G)$:** Minimum colors to color edges such that incident edges share no color.
* **Vizing's Classification:** For any simple graph $G$, $\chi'(G) \in \{\Delta(G), \, \Delta(G) + 1\}$:
  - **Class 1:** $\chi'(G) = \Delta(G)$ (e.g. all bipartite graphs by König's Line Coloring Theorem).
  - **Class 2:** $\chi'(G) = \Delta(G) + 1$ (e.g. odd cycles $C_{2k+1}$, complete graphs $K_{2k+1}$).

### 3. Whitney's Broken Circuit Theorem & Four Color Theorem
* **Whitney's Broken Circuit Theorem (Hassler Whitney, 1932):** Coefficient of $k^r$ in $P(G, k)$ equals $(-1)^{n-r} \times (\text{number of } (n-r)\text{-edge subgraphs containing no broken circuits})$.
* **The Four Color Theorem (Appel & Haken 1976, Robertson et al. 1997):** Every planar graph is 4-colorable: $\chi(G) \le 4 \iff P(G, 4) > 0$.

### 4. Top Recommended Resources
* **The Definitive Graph Theory Treatise:** *Graph Theory* by Reinhard Diestel (Springer Graduate Texts in Mathematics).
* **Chromatic & Polynomial Theory:** *Graph Colouring and the Tutte Polynomial* by Chris Godsil & Gordon Royle.
* **Classic Problem Solving:** *Introduction to Graph Theory* by Douglas B. West (Pearson).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you compute chromatic polynomials using the deletion-contraction reduction tree?
- [ ] Can you apply Brooks' Theorem to bound $\chi(G)$ for non-complete graphs?
- [ ] Can you determine whether a graph is Class 1 or Class 2 under Vizing's Theorem?
- [ ] Can you evaluate $P(G, k)$ coefficients using vertex and edge counts?
