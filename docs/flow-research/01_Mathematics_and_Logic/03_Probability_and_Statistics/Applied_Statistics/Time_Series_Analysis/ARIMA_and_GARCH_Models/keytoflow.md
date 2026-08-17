# Key to Flow: ARIMA & GARCH Time Series Models (Applied Statistics)

**Subject Area:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Applied_Statistics / Time_Series_Analysis / ARIMA_and_GARCH_Models`

---

## 📌 Core Concept & Mental Model
**Time Series Analysis** decomposes sequential observations $\{X_t\}$ into a conditional **Mean Equation (ARIMA)** and a conditional **Variance / Volatility Equation (GARCH)**:
* **The $\operatorname{ARIMA}(p, d, q)$ Model (George Box & Gwilym Jenkins, 1970):**
  $$\phi(B) (1 - B)^d X_t = \theta(B) \epsilon_t, \qquad \epsilon_t \overset{\text{i.i.d.}}{\sim} \operatorname{WN}(0, \sigma^2)$$
  where $B$ is the backshift lag operator ($B^k X_t = X_{t-k}$), $\phi(B) = 1 - \sum_{i=1}^p \phi_i B^i$ (Autoregressive polynomial), and $\theta(B) = 1 + \sum_{j=1}^q \theta_j B^j$ (Moving Average polynomial).
* **The $\operatorname{GARCH}(p, q)$ Volatility Model (Robert Engle 1982, Tim Bollerslev 1986):**
  $$\epsilon_t = \sigma_t z_t, \quad z_t \overset{\text{i.i.d.}}{\sim} \mathcal{N}(0, 1), \qquad \sigma_t^2 = \omega + \sum_{i=1}^q \alpha_i \epsilon_{t-i}^2 + \sum_{j=1}^p \beta_j \sigma_{t-j}^2$$
  *(Captures **Volatility Clustering**: large shocks $\epsilon_{t-i}^2$ and persistent variance $\sigma_{t-j}^2$ breed high future volatility!).*

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The 4-Stage Box-Jenkins Modeling Cycle
1. **Stationarity & Transformation:** Test for unit roots using the **Augmented Dickey-Fuller (ADF) test**. Apply differencing $(1-B)^d$ until the series is weakly stationary.
2. **Identification (ACF & PACF Patterns):**
   - **$\operatorname{AR}(p)$:** ACF decays exponentially / sinusoids; PACF **cuts off sharply** after lag $p$.
   - **$\operatorname{MA}(q)$:** ACF **cuts off sharply** after lag $q$; PACF decays exponentially.
   - **$\operatorname{ARMA}(p, q)$:** Both ACF and PACF decay smoothly without sharp cutoffs.
3. **Estimation:** Maximum Likelihood / Conditional Sum of Squares optimization.
4. **Diagnostic Checking:** Ljung-Box Q-test on standardized residuals $\hat{\epsilon}_t$ (tests for white noise). If squared residuals $\hat{\epsilon}_t^2$ show serial autocorrelation (ARCH effect), proceed to GARCH modeling!

### 2. GARCH Stationarity & Fat Tails
* **Stationarity Condition for $\operatorname{GARCH}(1, 1)$:**
  $$\omega > 0, \quad \alpha_1 \ge 0, \quad \beta_1 \ge 0, \qquad \alpha_1 + \beta_1 < 1$$
* **Unconditional Long-Run Variance:** $\sigma^2 = \frac{\omega}{1 - \alpha_1 - \beta_1}$.
* **Leptokurtosis (Fat Tails):** Unconditional kurtosis $\kappa = 3 + \frac{6\alpha_1^2}{1 - \beta_1^2 - 2\alpha_1\beta_1 - 3\alpha_1^2} > 3$ generates heavy tails even when innovations $z_t$ are Gaussian.

### 3. Top Recommended Resources
* **The Gold Standard Treatise:** *Time Series Analysis: Forecasting and Control* by George E.P. Box, Gwilym M. Jenkins, Gregory C. Reinsel, & Greta M. Ljung.
* **Financial Econometrics Focus:** *Analysis of Financial Time Series* by Ruey S. Tsay (Wiley).
* **Applied Modern Guide:** *Time Series Analysis and Its Applications: With R Examples* by Robert H. Shumway & David S. Stoffer.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you determine AR and MA orders from ACF and PACF correlograms?
- [ ] Can you check invertibility and causality by finding the roots of $\phi(z) = 0$ and $\theta(z) = 0$?
- [ ] Can you compute the long-run unconditional variance $\sigma^2 = \omega / (1 - \alpha - \beta)$ for GARCH(1, 1)?
- [ ] Can you conduct a Ljung-Box test on residuals to verify model adequacy?
