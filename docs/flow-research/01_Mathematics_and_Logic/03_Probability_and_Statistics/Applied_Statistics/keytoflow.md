# Key to Flow: Applied Statistics

**Subject Area:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Applied_Statistics`

---

## 📌 Core Concept & Mental Model
Applied Statistics implements data modeling, regression, time series analysis, and multivariate techniques to uncover trends, make predictions, and drive empirical decision-making across medicine, finance, and industry.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Regression & Linear Models
* **Ordinary Least Squares (OLS):** $y = X \beta + \epsilon \implies \hat{\beta} = (X^T X)^{-1} X^T y$.
* **Gauss-Markov Theorem:** OLS is the Best Linear Unbiased Estimator (BLUE) under homoscedasticity and uncorrelated errors.
* **Generalized Linear Models (GLMs):** Logistic Regression for binary outcomes, Poisson Regression for count data.

### 2. Time Series Analysis (ARIMA / GARCH)
* **Stationarity:** Constant mean, variance, and autocovariance over time.
* **ARIMA$(p, d, q)$:** AutoRegressive ($p$), Integrated ($d$), Moving Average ($q$).
* **GARCH$(p, q)$:** Models time-varying volatility clustering in financial data.

### 3. Multivariate & Survival Analysis
* **Principal Component Analysis (PCA):** Eigendecomposition of covariance matrix $\Sigma = V \Lambda V^T$ to reduce dimensionality.
* **Cox Proportional Hazards Model:** Models time-to-event data in biostatistics $h(t|x) = h_0(t) \exp(x^T \beta)$.

### 4. Top Recommended Resources
* **Statistical Learning Standard:** *An Introduction to Statistical Learning (ISLR)* by James, Witten, Hastie, Tibshirani (Free PDF!).
* **Time Series Analysis:** *Time Series Analysis: Forecasting and Control* by Box, Jenkins, Reinsel, Ljung.
* **Applied Regression:** *Applied Linear Regression Models* by Kutner, Nachtsheim, Neter.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you interpret OLS regression coefficients, $R^2$, adjusted $R^2$, and $F$-test statistics?
- [ ] Can you check regression diagnostics (Multicollinearity via VIF, Heteroscedasticity via Breusch-Pagan, Normality of residuals)?
- [ ] Can you fit ARIMA models using ACF and PACF plots?
- [ ] Can you perform PCA and interpret Scree plots and Explained Variance Ratios?
