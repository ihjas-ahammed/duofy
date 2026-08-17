# Key to Flow: Neyman-Pearson Lemma & Optimal Hypothesis Testing (Statistical Inference)

**Subject Area:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Statistical_Inference / Hypothesis_Testing / Neyman_Pearson_Lemma`

---

## 📌 Core Concept & Mental Model
The **Neyman-Pearson Fundamental Lemma (Jerzy Neyman & Egon Pearson, 1933)** solves the constrained optimization problem of hypothesis testing: maximize the statistical **Power** ($1 - \beta$) subject to a strict cap on the **Type I Error Rate** ($\alpha$):
* **Simple vs Simple Hypothesis Testing:**
  $$H_0: \theta = \theta_0 \quad \text{versus} \quad H_1: \theta = \theta_1$$
* **The Likelihood Ratio Test (LRT) Statistic:**
  $$\Lambda(\mathbf{x}) = \frac{L(\theta_1 \mid \mathbf{x})}{L(\theta_0 \mid \mathbf{x})} = \frac{f(\mathbf{x} \mid \theta_1)}{f(\mathbf{x} \mid \theta_0)}$$
* **The Most Powerful (MP) Test of Size $\alpha$:**
  $$\phi(\mathbf{x}) = \begin{cases} 1 & \text{if } \Lambda(\mathbf{x}) > k \\ \gamma & \text{if } \Lambda(\mathbf{x}) = k \\ 0 & \text{if } \Lambda(\mathbf{x}) < k \end{cases}$$
  where threshold $k$ and randomization probability $\gamma \in [0, 1]$ are chosen so that $\mathbb{E}_{\theta_0}[\phi(\mathbf{X})] = P(\text{Reject } H_0 \mid H_0) = \alpha$.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Karlin-Rubin Theorem for Uniformly Most Powerful (UMP) Tests
* **Monotone Likelihood Ratio (MLR) Property:** A 1D family of densities $f(x \mid \theta)$ has MLR in statistic $T(x)$ if for any $\theta_1 < \theta_2$, the ratio $f(x \mid \theta_2) / f(x \mid \theta_1)$ is a non-decreasing function of $T(x)$.
* **Karlin-Rubin Theorem (Samuel Karlin & Herman Rubin, 1956):** If the distribution has MLR in $T(X)$, then the test that rejects $H_0: \theta \le \theta_0$ in favor of $H_1: \theta > \theta_0$ when $T(X) > c$ is **Uniformly Most Powerful (UMP)** of size $\alpha$ for *all* $\theta > \theta_0$.
* **1-Parameter Exponential Families:** Densities $f(x \mid \theta) = h(x) \exp(\eta(\theta) T(x) - A(\theta))$ strictly possess the MLR property when $\eta(\theta)$ is strictly increasing.

### 2. Generalized Likelihood Ratio Test (GLRT) & Wilks' Theorem
* **Composite Testing:** $H_0: \theta \in \Theta_0$ vs $H_1: \theta \in \Theta_1$.
* **GLRT Statistic:** $\Lambda(\mathbf{x}) = \frac{\sup_{\theta \in \Theta_0} L(\theta \mid \mathbf{x})}{\sup_{\theta \in \Theta} L(\theta \mid \mathbf{x})} \in [0, 1]$.
* **Wilks' Theorem (Samuel S. Wilks, 1938):** Under regular asymptotic conditions, $-2 \ln \Lambda(\mathbf{X}) \xrightarrow{d} \chi^2_r$ where degrees of freedom $r = \dim(\Theta) - \dim(\Theta_0)$.

### 3. Top Recommended Resources
* **The Master Reference:** *Testing Statistical Hypotheses* by E.L. Lehmann & Joseph P. Romano (Springer Texts in Statistics).
* **Clear Pedagogical Foundation:** *Statistical Inference* by George Casella & Roger L. Berger (Chapter 8: Hypothesis Testing).
* **Mathematical Precision:** *Theory of Point Estimation & Hypothesis Testing* by Jun Shao.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you set up the Likelihood Ratio $\Lambda(x)$ for Normal, Bernoulli, and Poisson random variables?
- [ ] Can you calculate threshold $k$ and randomization $\gamma$ for discrete distributions (Binomial/Poisson) to achieve exact size $\alpha$?
- [ ] Can you verify the Monotone Likelihood Ratio property by computing $\frac{d}{dT}\left(\frac{f(x \mid \theta_2)}{f(x \mid \theta_1)}\right) \ge 0$?
- [ ] Can you apply Wilks' Theorem to conduct an asymptotic GLRT of size $\alpha = 0.05$?
