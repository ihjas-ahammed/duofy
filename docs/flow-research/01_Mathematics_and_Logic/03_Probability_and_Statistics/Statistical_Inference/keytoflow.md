# Key to Flow: Statistical Inference

**Subject Area:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Statistical_Inference`

---

## 📌 Core Concept & Mental Model
Statistical Inference uses observed sample data to deduce the underlying parameters $\theta$ or probability distributions of a population, evaluating the uncertainty of estimates and hypotheses.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Point & Interval Estimation
* **Maximum Likelihood Estimation (MLE):** $\hat{\theta}_{\text{MLE}} = \arg\max_\theta L(\theta; x)$.
* **Cramér-Rao Lower Bound (CRLB):** Lower bound on variance of unbiased estimators $\text{Var}(\hat{\theta}) \ge \frac{1}{I(\theta)}$, where $I(\theta)$ is the **Fisher Information**.
* **Sufficient Statistics & Rao-Blackwell Theorem:** A statistic $T(X)$ is sufficient for $\theta$ if $P(X|T)$ does not depend on $\theta$ (Neyman-Fisher Factorization Theorem). Conditioning an estimator on a sufficient statistic reduces variance!

### 2. Hypothesis Testing & Neyman-Pearson Framework
* **Null ($H_0$) vs. Alternative ($H_1$) Hypotheses.**
* **Type I Error ($\alpha$, false positive) & Type II Error ($\beta$, false negative).**
* **Neyman-Pearson Lemma:** The Likelihood Ratio Test $\Lambda(x) = \frac{L(\theta_0; x)}{L(\theta_1; x)} \le k$ is the Most Powerful (MP) test for simple hypotheses.

### 3. Bayesian Inference Paradigm
* **Posterior Distribution:** $p(\theta | x) \propto p(x | \theta) \cdot p(\theta)$ (Posterior $\propto$ Likelihood $\times$ Prior).
* **Conjugate Priors & MCMC Sampling (Metropolis-Hastings, Gibbs Sampling).**

### 4. Top Recommended Resources
* **Gold Standard Text:** *Statistical Inference* by George Casella & Roger L. Berger.
* **Modern Bayesian Text:** *Doing Bayesian Data Analysis* by John K. Kruschke.
* **Theoretical Classic:** *Testing Statistical Hypotheses* by E.L. Lehmann & Joseph P. Romano.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you derive MLE estimators and check asymptotic normality $\hat{\theta} \sim \mathcal{N}\left(\theta, \frac{1}{I(\theta)}\right)$?
- [ ] Can you factorize a joint PDF to find a Minimal Sufficient Statistic using Neyman-Fisher?
- [ ] Can you construct Likelihood Ratio Tests (LRT) and compute $p$-values?
- [ ] Can you calculate posterior distributions using conjugate beta/gamma priors?
