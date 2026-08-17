# Duofy Reusable Lesson Format: Weak Stationarity, Unit Roots, and ARIMA Modeling

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Applied_Statistics / Time_Series_Analysis/ARIMA_and_GARCH_Models`  
**Lesson Format Type:** `stationarity_unit_roots_and_arima_modeling`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce **Weak (Covariance) Stationarity** ($\mathbb{E}[X_t] = \mu, \operatorname{Cov}(X_t, X_{t+h}) = \gamma(h)$), detect **Unit Roots** via the **Augmented Dickey-Fuller (ADF) Test**, apply the differencing operator $\nabla^d = (1-B)^d$ to eliminate polynomial trends, formulate the general $\operatorname{ARIMA}(p, d, q)$ model, and check causality and invertibility root conditions.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Covariance Stationarity & ARIMA(p,d,q) Mathematical Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | AR(1) Causality Characteristic Root Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Time Series Operator & Stationarity Condition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Differencing Operator Power for Linear Trends Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Random Walk Non-Stationarity Spurious Regression Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of Weak (Covariance / Second-Order) Stationarity: A time series $\{X_t\}$ is weakly stationary if: (1) Mean is constant: $\mathbb{E}[X_t] = \mu$ for all $t$, (2) Second moment is finite: $\mathbb{E}[X_t^2] < \infty$, (3) Autocovariance depends only on lag $h$: $\operatorname{Cov}(X_t, X_{t+h}) = \gamma(h)$. State the $\operatorname{ARIMA}(p, d, q)$ formulation: $\phi(B) (1 - B)^d X_t = \theta(B) \epsilon_t$ with white noise $\epsilon_t \sim \operatorname{WN}(0, \sigma^2)$, where $B$ is the Backshift Operator ($B^k X_t = X_{t-k}$). State Causality and Invertibility: Roots of $\phi(z) = 0$ and $\theta(z) = 0$ must strictly lie OUTSIDE the complex unit circle ($|z| > 1$).
2. **Slide 2 (`ordering`):** Provide 5 steps deriving stationarity for $\operatorname{AR}(1)$ process $X_t = \phi X_{t-1} + \epsilon_t$: (1) back-substitute recursively: $X_t = \phi(\phi X_{t-2} + \epsilon_{t-1}) + \epsilon_t = \phi^2 X_{t-2} + \phi \epsilon_{t-1} + \epsilon_t$, (2) express as infinite geometric sum: $X_t = \sum_{k=0}^\infty \phi^k \epsilon_{t-k}$, (3) compute variance: $\operatorname{Var}(X_t) = \sum_{k=0}^\infty \phi^{2k} \operatorname{Var}(\epsilon_{t-k}) = \sigma^2 \sum_{k=0}^\infty (\phi^2)^k$, (4) evaluate infinite series convergence: $\sum (\phi^2)^k = \frac{1}{1 - \phi^2}$, which converges if and only if $|\phi| < 1$, (5) conclude $\operatorname{Var}(X_t) = \frac{\sigma^2}{1 - \phi^2}$, proving the root of $1 - \phi z = 0 \implies z = 1/\phi$ lies outside unit circle $|z| > 1 \iff |\phi| < 1$.
3. **Slide 3 (`matching`):** Pair 4 time series operators (Backshift Operator $B$, First Difference $(1-B)X_t$, AR Polynomial $\phi(B)$, MA Polynomial $\theta(B)$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that to eliminate a linear deterministic or stochastic drift trend, first-order differencing $d = 1$ is applied. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the danger of regressing non-stationary random walks (Spurious Regression / Clive Granger 1974): What happens when running OLS regression between two completely independent random walks $Y_t = Y_{t-1} + \epsilon_t$ and $X_t = X_{t-1} + \eta_t$? (Spurious regression: The $t$-statistics and $R^2$ will appear statistically significant even though no true relationship exists, because non-stationary trends create artificial correlations; series must be differenced to stationarity first).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "stationarity_unit_roots_and_arima_modeling",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Weak Stationarity and the $\\operatorname{ARIMA}(p, d, q)$ Model**\n• **Weak (Covariance) Stationarity:** A stochastic process $\\{X_t\\}$ satisfies:\n  1. Constant Mean: $\\mathbb{E}[X_t] = \\mu \\quad \\forall t$.\n  2. Shift-Invariant Autocovariance: $\\operatorname{Cov}(X_t, X_{t+h}) = \\gamma(h) \\quad \\forall t, h$.\n• **The General $\\operatorname{ARIMA}(p, d, q)$ Formulation (Box-Jenkins 1970):**\n$$\n\\phi(B) (1 - B)^d X_t = \\theta(B) \\epsilon_t, \\qquad \\epsilon_t \\sim \\operatorname{WN}(0, \\sigma^2)\n$$\nwhere $B$ is the **Backshift Operator** ($B^k X_t = X_{t-k}$):\n$$\n\\phi(B) = 1 - \\sum_{i=1}^p \\phi_i B^i, \\qquad \\theta(B) = 1 + \\sum_{j=1}^q \\theta_j B^j\n$$\n• **Causality & Invertibility Condition:** All roots of polynomials $\\phi(z) = 0$ and $\\theta(z) = 0$ must lie **strictly outside the complex unit circle** ($|z| > 1$)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps establishing that an AR(1) process is stationary if and only if |phi| < 1.",
      "orderItems": [
        "Write the AR(1) equation: X_t = phi * X_{t-1} + eps_t with white noise eps_t ~ WN(0, sigma^2)",
        "Iteratively back-substitute past lags: X_t = eps_t + phi * eps_{t-1} + phi^2 * eps_{t-2} + ...",
        "Express as an infinite moving average linear filter: X_t = sum_{k=0}^infty phi^k * eps_{t-k}",
        "Calculate the variance of the infinite sum: Var(X_t) = sigma^2 * sum_{k=0}^infty (phi^2)^k",
        "Apply geometric series convergence: sum (phi^2)^k = 1 / (1 - phi^2), which is finite if and only if |phi| < 1"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each time series mathematical operator to its definition.",
      "matchPairs": [
        { "left": "Backshift Operator B", "right": "B X_t = X_{t-1} (shifts observation back by 1 time step)" },
        { "left": "First Difference Operator nabla = (1 - B)", "right": "nabla X_t = X_t - X_{t-1} (removes linear trends to induce stationarity)" },
        { "left": "Augmented Dickey-Fuller (ADF) Test", "right": "Tests H_0: unit root exists (non-stationary) vs H_1: stationary" },
        { "left": "Causality Condition", "right": "All roots of AR polynomial phi(z) = 0 lie outside the unit circle (|z| > 1)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "To eliminate a linear stochastic or deterministic trend in an ARIMA(p, d, q) model, the differencing order d is standardly set to ___.",
      "blankAnswer": "one",
      "blankDistractors": ["zero", "two", "three"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the econometric danger of 'Spurious Regression' (Granger & Newbold, 1974) when analyzing non-stationary unit-root time series?",
      "options": [
        { "text": "Regressing two completely independent random walks produces artificially high R^2 values and misleadingly significant t-statistics, falsely suggesting a strong causal link due to shared non-stationary drift", "isCorrect": true, "explanation": "Correct! Non-stationary time series violate OLS assumptions. Running regressions without differencing to stationarity produces invalid p-values and false positive correlations." },
        { "text": "The regression slope is always exactly zero", "isCorrect": false, "explanation": "Incorrect: The slope variance explodes." },
        { "text": "The computer runs out of memory", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The data becomes deterministic", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
