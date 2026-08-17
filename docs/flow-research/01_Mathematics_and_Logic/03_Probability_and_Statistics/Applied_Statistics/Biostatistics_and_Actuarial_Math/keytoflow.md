# Key to Flow: Biostatistics and Actuarial Mathematics (Applied Statistics)

**Subject Area:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Applied_Statistics / Biostatistics_and_Actuarial_Math`

---

## 📌 Core Concept & Mental Model
**Survival Analysis & Actuarial Mathematics** model time-to-event random variables $T \ge 0$ under incomplete observation (**Right Censoring** $C$ where observed data is $Y = \min(T, C), \delta = \mathbf{1}(T \le C)$):
* **The Fundamental Survival Trio:**
  1. **Survival Function:** $S(t) = P(T > t) = 1 - F(t)$.
  2. **Hazard Rate Function (Instantaneous Force of Mortality):**
     $$\lambda(t) = h(t) = \mu(t) = \lim_{\Delta t \to 0} \frac{P(t \le T < t+\Delta t \mid T \ge t)}{\Delta t} = -\frac{S'(t)}{S(t)} = -\frac{d}{dt}\ln S(t)$$
  3. **Cumulative Hazard Function:**
     $$H(t) = \int_0^t h(s) \, ds \implies S(t) = \exp(-H(t)) = \exp\left( -\int_0^t h(s) \, ds \right)$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Non-Parametric Estimation & Comparison
* **Kaplan-Meier Product-Limit Estimator (1958):**
  $$\hat{S}(t) = \prod_{t_i \le t} \left( 1 - \frac{d_i}{n_i} \right)$$
  where $d_i$ is the number of events and $n_i$ is the number of individuals at risk at event time $t_i$.
* **Greenwood's Formula:** $\widehat{\operatorname{Var}}(\hat{S}(t)) = \hat{S}(t)^2 \sum_{t_i \le t} \frac{d_i}{n_i(n_i - d_i)}$.
* **Log-Rank Test (Mantel-Haenszel):** Non-parametric score test comparing observed $O_j$ vs expected $E_j$ deaths across multiple treatment arms ($Q_{\text{log-rank}} \sim \chi^2_{k-1}$).

### 2. Semi-Parametric Regression: Cox Proportional Hazards Model
* **Cox Model (Sir David Cox, 1972):**
  $$h(t \mid \mathbf{x}) = h_0(t) \exp(\mathbf{\beta}^T \mathbf{x}) = h_0(t) \exp\left( \sum_{j=1}^p \beta_j x_j \right)$$
  *(Hazard Ratio $\text{HR} = \exp(\beta_j)$ is constant over time without specifying baseline $h_0(t)$!).*
* **Cox Partial Likelihood:**
  $$L_p(\mathbf{\beta}) = \prod_{i: \delta_i = 1} \frac{\exp(\mathbf{\beta}^T \mathbf{x}_i)}{\sum_{j \in \mathcal{R}(t_i)} \exp(\mathbf{\beta}^T \mathbf{x}_j)}$$

### 3. Actuarial Life Contingencies & Premium Valuation
* **Actuarial Notation:** ${}_t p_x = P(T_x > t) = \frac{S(x+t)}{S(x)}$ (surviving $t$ years from age $x$), ${}_t q_x = 1 - {}_t p_x$.
* **Life Annuity-Due Present Value:** $\ddot{a}_x = \sum_{k=0}^\infty v^k \, {}_k p_x$ (discount factor $v = \frac{1}{1+i}$).
* **Whole Life Insurance Single Premium:** $A_x = \sum_{k=0}^\infty v^{k+1} \, {}_k p_x q_{x+k}$.
* **Equivalence Principle (Annual Net Premium):** $P_x = \frac{A_x}{\ddot{a}_x}$.

### 4. Top Recommended Resources
* **The Biostatistics Standard:** *Survival Analysis: Techniques for Censored and Truncated Data* by John P. Klein & Melvin L. Moeschberger.
* **Applied Medical Modeling:** *Modelling Survival Data in Medical Research* by David Collett.
* **The Actuarial Bible:** *Actuarial Mathematics for Life Contingent Risks* by David C.M. Dickson, Mary R. Hardy, & Howard R. Waters.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you compute Kaplan-Meier survival curves by hand from risk tables with right censoring?
- [ ] Can you interpret Hazard Ratios $\text{HR} = e^\beta$ and verify proportional hazards via Schoenfeld residuals?
- [ ] Can you convert between hazard rate $h(t)$, cumulative hazard $H(t)$, and survival function $S(t)$?
- [ ] Can you calculate actuarial present values for life annuities and term insurance policies?
