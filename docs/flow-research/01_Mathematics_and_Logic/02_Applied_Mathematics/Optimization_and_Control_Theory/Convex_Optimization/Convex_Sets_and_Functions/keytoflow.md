# Key to Flow: Convex Sets and Functions (Convex Optimization)

**Subject Area:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Convex_Optimization / Convex_Sets_and_Functions`

---

## 📌 Core Concept & Mental Model
**Convex Optimization (Boyd & Vandenberghe)** rests on the mathematical foundation that any local minimum of a convex function over a convex set is a **global minimum**:
* **Convex Set $C \subseteq \mathbb{R}^n$:**
  $$\forall x, y \in C, \quad \theta x + (1 - \theta) y \in C \quad \forall \theta \in [0, 1]$$
* **Fundamental Proper Cones:**
  * Non-negative orthant $\mathbb{R}^n_+$ (Linear Programming).
  * Second-Order Cone (SOC / Lorentz cone) $\mathcal{Q}^{n+1} = \{(x, t) \in \mathbb{R}^{n+1} \mid \|x\|_2 \le t\}$ (SOCP).
  * Positive Semidefinite Cone $\mathbb{S}^n_+ = \{X \in \mathbb{S}^n \mid z^T X z \ge 0 \, \forall z\}$ (SDP).
* **Hyperplane Separation Theorem:** If $C$ and $D$ are disjoint non-empty convex sets, there exists $a \ne 0, b$ such that $a^T x \le b$ for all $x \in C$ and $a^T y \ge b$ for all $y \in D$.
* **Convex Function $f: \operatorname{dom} f \to \mathbb{R}$:**
  $$f(\theta x + (1-\theta)y) \le \theta f(x) + (1-\theta)f(y) \iff \operatorname{epi} f = \{(x, t) \mid f(x) \le t\} \text{ is a convex set}$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Convexity Criteria & Differential Characterizations
* **First-Order Condition ($f$ differentiable):**
  $$f(y) \ge f(x) + \nabla f(x)^T (y - x) \quad \forall x, y \in \operatorname{dom} f$$
  (The tangent hyperplane provides a global underestimator everywhere!).
* **Second-Order Condition ($f$ twice differentiable):**
  $$\nabla^2 f(x) \succeq 0 \quad (\text{Hessian is positive semidefinite everywhere on convex domain})$$

### 2. Subgradients & Non-Smooth Analysis
* **Subgradient $g \in \partial f(x)$:**
  $$f(y) \ge f(x) + g^T (y - x) \quad \forall y \in \operatorname{dom} f$$
* **Fermat's Subgradient Optimality Condition:**
  $$x^* \text{ minimizes } f(x) \iff 0 \in \partial f(x^*)$$
  (Generalizes $\nabla f(x^*) = 0$ to non-differentiable convex functions like $\ell_1$ norm $\|x\|_1$).

### 3. Convexity-Preserving Calculus & Fenchel Conjugacy
* **Operations Preserving Convexity:** Non-negative weighted sums, pointwise supremum $f(x) = \sup_{\alpha} f_\alpha(x)$, affine composition $f(A x + b)$, and perspective transform $g(x, t) = t f(x / t)$ ($t > 0$).
* **Fenchel Conjugate (Legendre-Fenchel Transform):**
  $$f^*(y) = \sup_{x \in \operatorname{dom} f} \left( y^T x - f(x) \right)$$
  (Conjugate $f^*$ is ALWAYS convex, even if $f$ is non-convex!).
* **Fenchel-Young Inequality:** $f(x) + f^*(y) \ge x^T y$.

### 4. Top Recommended Resources
* **The Global Standard:** *Convex Optimization* by Stephen Boyd & Lieven Vandenberghe (Chapters 2 & 3, Stanford EE364A).
* **Non-Smooth & Theoretical Foundations:** *Convex Analysis* by R. Tyrrell Rockafellar.
* **Modern Computational Framework:** *First-Order Methods in Optimization* by Amir Beck (MOS-SIAM Series).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you prove a set is convex using definition or representation as the intersection of halfspaces?
- [ ] Can you verify convexity of $f(x) = \log(\sum_{i=1}^n e^{x_i})$ (log-sum-exp) via its Hessian?
- [ ] Can you calculate the subdifferential $\partial \|x\|_1$ and $\partial \|x\|_2$?
- [ ] Can you derive the Fenchel conjugate $f^*(y)$ for $f(x) = \frac{1}{2} x^T P x$, $f(x) = -\log x$, and $f(x) = \|x\|_p$?
