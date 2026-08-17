# Key to Flow: Interior-Point Methods (Linear and Nonlinear Programming)

**Subject Area:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Linear_and_Nonlinear_Programming / Interior_Point_Methods`

---

## 📌 Core Concept & Mental Model
**Interior-Point Methods (IPMs / Karmarkar 1984, Nesterov & Nemirovski 1994, Boyd Ch. 11)** solve convex optimization problems with inequality constraints by traversing smoothly through the strictly feasible **interior** $\operatorname{int}(\mathcal{D})$ along the **Central Path**:
* **The Logarithmic Barrier Function:**
  $$\phi(\mathbf{x}) = -\sum_{i=1}^m \log(-f_i(\mathbf{x})), \quad \operatorname{dom}\phi = \{\mathbf{x} \mid f_i(\mathbf{x}) < 0\}$$
* **The Central Path $\mathbf{x}^*(t)$ ($t > 0$):**
  $$\mathbf{x}^*(t) = \operatorname{argmin} \left( t f_0(\mathbf{x}) + \phi(\mathbf{x}) \right) \quad \text{s.t.} \quad A\mathbf{x} = \mathbf{b}$$
* **Duality Gap along the Central Path:**
  $$f_0(\mathbf{x}^*(t)) - p^* \le \frac{m}{t}$$
  As the penalty multiplier $t \to \infty$, the central trajectory $\mathbf{x}^*(t)$ converges to an exact global minimizer $\mathbf{x}^*$.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Barrier Method (Path-Following)
1. **Centering Step:** Compute $\mathbf{x}^*(t)$ using Newton's method on $t f_0 + \phi$.
2. **Stopping Criterion:** Stop if $m/t < \epsilon_{\text{tol}}$.
3. **Multiplier Update:** Increase $t \leftarrow \mu t$ with scaling factor $\mu \in [10, 100]$.
* **Newton Decrement Stopping Criterion:** $\lambda(\mathbf{x})^2 = \nabla f_t(\mathbf{x})^T (\nabla^2 f_t(\mathbf{x}))^{-1} \nabla f_t(\mathbf{x}) \le 2\epsilon$.

### 2. Primal-Dual Interior-Point Methods
Primal-dual methods solve the **Perturbed KKT System** simultaneously for primal $(\mathbf{x})$, slack $(\mathbf{s})$, and dual $(\mathbf{\lambda}, \mathbf{\nu})$ variables without requiring exact centering at each step:
$$\begin{aligned}
\nabla f_0(\mathbf{x}) + D\mathbf{f}(\mathbf{x})^T \mathbf{\lambda} + A^T \mathbf{\nu} &= \mathbf{0} \quad (\text{Stationarity}) \\
-\lambda_i f_i(\mathbf{x}) &= \frac{1}{t} = \mu \quad (\text{Perturbed Complementary Slackness}) \\
A\mathbf{x} &= \mathbf{b}, \quad f_i(\mathbf{x}) \le 0, \quad \mathbf{\lambda} \ge \mathbf{0}
\end{aligned}$$
* **Surrogate Duality Gap:** $\hat{\eta}(\mathbf{x}, \mathbf{\lambda}) = -\mathbf{f}(\mathbf{x})^T \mathbf{\lambda} = \sum_{i=1}^m -\lambda_i f_i(\mathbf{x})$.

### 3. The Mehrotra Predictor-Corrector Algorithm (Sanjay Mehrotra, 1992)
* **The Industry Gold Standard** (powering Mosek, Gurobi, CPLEX, Ipopt):
  1. **Affine Scaling Predictor Step ($\Delta_{\text{aff}}$):** Solves Newton system with $\mu = 0$ to probe toward the boundary.
  2. **Centering Parameter Calculation:** $\sigma = \left( \frac{\hat{\eta}_{\text{aff}}}{\hat{\eta}} \right)^3$.
  3. **Centering-Corrector Step ($\Delta_{\text{cc}}$):** Adds the non-linear cross-term $\Delta x_i^{\text{aff}} \Delta s_i^{\text{aff}}$ and centering target $\sigma \mu \mathbf{1}$.
  4. **Combined Solve:** Both steps share the exact same Cholesky/KKT matrix factorization!

### 4. Top Recommended Resources
* **The Premier Framework:** *Convex Optimization* by Stephen Boyd & Lieven Vandenberghe (Chapter 11: Interior-Point Methods).
* **The Comprehensive Treatise:** *Primal-Dual Interior-Point Methods* by Stephen J. Wright (SIAM).
* **Conic Complexity Foundations:** *Interior-Point Polynomial Algorithms in Convex Programming* by Yurii Nesterov & Arkadi Nemirovski.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you compute the gradient and Hessian of the log barrier $\phi(x) = -\sum \log(b_i - a_i^T x)$?
- [ ] Can you prove that the duality gap at point $\mathbf{x}^*(t)$ is exactly $m/t$ by extracting dual multipliers $\lambda_i^*(t) = -1 / (t f_i(\mathbf{x}^*(t)))$?
- [ ] Can you formulate the perturbed KKT Newton system for a linear program?
- [ ] Can you calculate the Mehrotra centering parameter $\sigma = (\hat{\eta}_{\text{aff}} / \hat{\eta})^3$?
