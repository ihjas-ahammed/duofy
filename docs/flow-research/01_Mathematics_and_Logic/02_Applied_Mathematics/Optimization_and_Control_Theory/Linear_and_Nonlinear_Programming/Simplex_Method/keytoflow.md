# Key to Flow: The Simplex Method (Linear Programming)

**Subject Area:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Linear_and_Nonlinear_Programming / Simplex_Method`

---

## 📌 Core Concept & Mental Model
The **Simplex Algorithm (George Dantzig, 1947)** solves standard-form Linear Programs (LPs) by traversing along the 1-dimensional edges of a convex polyhedron from one **Basic Feasible Solution (BFS / Vertex)** to an adjacent, strictly improving BFS until reaching a global optimum:
* **Standard Form Linear Program:**
  $$\min_{\mathbf{x}} \mathbf{c}^T \mathbf{x} \quad \text{subject to} \quad A \mathbf{x} = \mathbf{b}, \quad \mathbf{x} \ge \mathbf{0} \quad (A \in \mathbb{R}^{m \times n}, \, m \le n, \, \operatorname{rank}(A) = m)$$
* **Fundamental Theorem of Linear Programming:** If an LP has an optimal solution, at least one optimal solution occurs at an extreme point (vertex / BFS) of the feasible polyhedron $P = \{\mathbf{x} \ge \mathbf{0} \mid A\mathbf{x} = \mathbf{b}\}$.
* **Algebraic Partition:** Split $A = [B \mid N]$ where $B$ is an $m \times m$ invertible **basis matrix** and $N$ is the non-basic submatrix.
  $$\mathbf{x}_B = B^{-1} \mathbf{b} \ge \mathbf{0}, \qquad \mathbf{x}_N = \mathbf{0}$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Reduced Costs & Pivot Rules
* **Reduced Cost Vector $\mathbf{\bar{c}}_N$:**
  $$\mathbf{\bar{c}}_N^T = \mathbf{c}_N^T - \mathbf{c}_B^T B^{-1} N$$
  * **Optimality Criterion:** If $\mathbf{\bar{c}}_N \ge \mathbf{0}$, the current BFS is optimal!
  * **Entering Variable (Pivot Column $j$):** Choose non-basic index $j$ with negative reduced cost $\bar{c}_j < 0$.
  * **Minimum Ratio Test (Exiting Variable $i$):** Find step size $\theta^* = \min_{i \in B, \, d_i > 0} \frac{(x_B)_i}{d_i}$ where $\mathbf{d} = B^{-1} \mathbf{A}_j$.

### 2. Degeneracy, Cycling, and Bland's Rule
* **Degenerate BFS:** A basic variable equals zero ($(x_B)_i = 0$), allowing step length $\theta^* = 0$ and creating the risk of infinite **cycling**.
* **Bland's Anti-Cycling Rule (Robert Bland, 1977):** Always choose the entering variable with the **smallest index** $j = \min\{k \mid \bar{c}_k < 0\}$, and break ties in the minimum ratio test by picking the exiting variable with the **smallest index**.
  *(Mathematically guarantees finite termination without cycling!).*

### 3. The Revised Simplex Method vs Tableau
* **Tableau Simplex:** Performs row operations on an $(m+1) \times (n+1)$ table.
* **Revised Simplex:** Maintains only the basis factorization $B^{-1}$ (or LU factors of $B$), computing $\mathbf{p}^T = \mathbf{c}_B^T B^{-1}$, pricing non-basic columns on the fly, and solving $B \mathbf{d} = \mathbf{A}_j$.

### 4. Phase-I and Phase-II Initialization
* **Two-Phase Simplex:** Phase-I introduces artificial variables $\min \sum a_i$ s.t. $A\mathbf{x} + \mathbf{a} = \mathbf{b}$ to find an initial BFS. Phase-II optimizes the true objective $\mathbf{c}^T \mathbf{x}$.

### 5. Top Recommended Resources
* **The Premier LP Textbook:** *Introduction to Linear Optimization* by Dimitris Bertsimas & John N. Tsitsiklis (Chapters 2 & 3).
* **The Classical Reference:** *Linear Programming and Network Flows* by Mokhtar S. Bazaraa, John J. Jarvis, & Hanif D. Sherali.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you convert general inequality constraints $\sum a_{ij} x_j \le b_i$ into standard form using slack and surplus variables?
- [ ] Can you perform a complete Simplex tableau pivot by hand on a $2 \times 3$ problem?
- [ ] Can you compute the reduced costs $\mathbf{\bar{c}}_N$ using the dual multiplier $\mathbf{y}^T = \mathbf{c}_B^T B^{-1}$?
- [ ] Can you execute Bland's rule on a degenerate tableau to avoid cycling?
