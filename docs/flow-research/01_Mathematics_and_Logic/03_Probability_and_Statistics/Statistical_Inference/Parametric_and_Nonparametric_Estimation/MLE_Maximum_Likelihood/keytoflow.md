# Key to Flow: Maximum Likelihood Estimation (Parametric Estimation)

**Subject Area:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Statistical_Inference / Parametric_and_Nonparametric_Estimation / MLE_Maximum_Likelihood`

---

## 📌 Core Concept & Mental Model
**Maximum Likelihood Estimation (Sir Ronald Fisher, 1922)** selects the parameter vector $\hat{\mathbf{\theta}}_{\text{MLE}}$ that maximizes the joint probability density (or mass) of the observed data sample $\mathbf{x} = (x_1, \dots, x_n)$:
* **The Likelihood and Log-Likelihood Functions:**
  $$L(\mathbf{\theta} \mid \mathbf{x}) = \prod_{i=1}^n f(x_i \mid \mathbf{\theta}), \qquad \ell(\mathbf{\theta}) = \ln L(\mathbf{\theta} \mid \mathbf{x}) = \sum_{i=1}^n \ln f(x_i \mid \mathbf{\theta})$$
* **The Score Function (Gradient Vector):**
  $$S(\mathbf{\theta}) = \nabla_{\mathbf{\theta}} \ell(\mathbf{\theta}), \qquad \mathbb{E}_{\mathbf{\theta}}[S(\mathbf{\theta})] = \mathbf{0}$$
* **Fisher Information Matrix $I_n(\mathbf{\theta})$:**
  $$I_n(\mathbf{\theta}) = \mathbb{E}\left[ S(\mathbf{\theta}) S(\mathbf{\theta})^T \right] = -\mathbb{E}\left[ \nabla^2 \ell(\mathbf{\theta}) \right] = n I_1(\mathbf{\theta})$$
  *(Measures the expected curvature/sharpness of the log-likelihood surface around $\mathbf{\theta}$).*

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Cramér-Rao Lower Bound (CRLB) & Efficiency
* **CRLB Theorem (Harald Cramér & C.R. Rao, 1945):** For any unbiased estimator $\hat{\theta}$ of scalar $\theta$ ($\mathbb{E}[\hat{\theta}] = \theta$):
  $$\operatorname{Var}(\hat{\theta}) \ge \frac{1}{n I_1(\theta)} = \frac{1}{I_n(\theta)}$$
* **UMVUE (Uniformly Minimum Variance Unbiased Estimator):** An unbiased estimator that achieves the CRLB is strictly **Efficient**.

### 2. Large-Sample Asymptotic Properties of MLE
Under standard Cramér-type regularity conditions (interior parameter, differentiable density, support independent of $\theta$):
1. **Consistency:** $\hat{\mathbf{\theta}}_n \xrightarrow{p} \mathbf{\theta}_0$ as $n \to \infty$.
2. **Asymptotic Normality & Efficiency:**
   $$\sqrt{n}(\hat{\mathbf{\theta}}_n - \mathbf{\theta}_0) \xrightarrow{d} \mathcal{N}\left(\mathbf{0}, I_1(\mathbf{\theta}_0)^{-1}\right)$$
   *(The MLE asymptotically achieves the Cramér-Rao Lower Bound!).*
3. **Functional Invariance (Zehm's Principle):** If $\hat{\theta}$ is the MLE of $\theta$, then for any function $g$, $\widehat{g(\theta)} = g(\hat{\theta})$.

### 3. Numerical Optimization & Latent Variables
* **Fisher Scoring:** $\mathbf{\theta}^{(t+1)} = \mathbf{\theta}^{(t)} + [I_n(\mathbf{\theta}^{(t)})]^{-1} S_n(\mathbf{\theta}^{(t)})$ (replaces empirical Hessian with expected Fisher Information).
* **The EM Algorithm (Dempster, Laird, & Rubin, 1977):**
  * **E-Step:** Compute $Q(\mathbf{\theta} \mid \mathbf{\theta}^{(t)}) = \mathbb{E}_{\mathbf{Z} \mid \mathbf{X}, \mathbf{\theta}^{(t)}} [\log L_c(\mathbf{\theta} \mid \mathbf{X}, \mathbf{Z})]$.
  * **M-Step:** Update $\mathbf{\theta}^{(t+1)} = \operatorname{argmax}_{\mathbf{\theta}} Q(\mathbf{\theta} \mid \mathbf{\theta}^{(t)})$.

### 4. Top Recommended Resources
* **The Premier Classical Text:** *Statistical Inference* by George Casella & Roger L. Berger (Chapter 7: Point Estimation).
* **Asymptotic Foundations:** *Asymptotic Statistics* by A.W. van der Vaart (Cambridge Series in Statistical and Probabilistic Mathematics).
* **Theory of Estimation:** *Theory of Point Estimation* by E.L. Lehmann & George Casella.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you derive the analytical MLE for Normal $(\mu, \sigma^2)$, Exponential $(\lambda)$, and Poisson $(\lambda)$ distributions?
- [ ] Can you compute the Fisher Information $I(\theta)$ using both first-derivative squared and negative expected second-derivative definitions?
- [ ] Can you construct asymptotic $95\%$ Wald confidence intervals $\hat{\theta} \pm 1.96 / \sqrt{I_n(\hat{\theta})}$?
- [ ] Can you execute 2 iterations of the EM algorithm for a 2-component Gaussian Mixture Model?
