# Duofy Reusable Lesson Format: Geometric Brownian Motion and SDE Solutions

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory / Martingales_and_Stochastic_Calculus / Ito_Calculus`  
**Lesson Format Type:** `geometric_brownian_motion_and_sde_solutions`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to solve foundational Stochastic Differential Equations (SDEs): derive the closed-form log-normal solution of **Geometric Brownian Motion** ($dS_t = \mu S_t dt + \sigma S_t dW_t \implies S_t = S_0 \exp((\mu - \frac{1}{2}\sigma^2)t + \sigma W_t)$), solve the **Ornstein-Uhlenbeck (OU) Mean-Reverting Process** ($dX_t = \theta(\mu - X_t)dt + \sigma dW_t$) via integrating factors, and compute expectations and variances.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | GBM & OU SDE Formulations Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Integrating Factor OU SDE Solution Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | SDE Model & Quantitative Financial Application Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical Expected Stock Price Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | GBM Log-Normal Convexity Jensen Drift Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Geometric Brownian Motion SDE: $dS_t = \mu S_t dt + \sigma S_t dW_t$ with initial condition $S_0 > 0$. Closed-form solution: $S_t = S_0 \exp\left( \left(\mu - \frac{1}{2}\sigma^2\right)t + \sigma W_t \right)$. Expected value: $\mathbb{E}[S_t] = S_0 e^{\mu t}$, Variance: $\operatorname{Var}(S_t) = S_0^2 e^{2\mu t} (e^{\sigma^2 t} - 1)$. State the Ornstein-Uhlenbeck SDE: $dX_t = \theta(\mu - X_t)dt + \sigma dW_t$. Closed-form solution: $X_t = e^{-\theta t}X_0 + \mu(1 - e^{-\theta t}) + \sigma \int_0^t e^{-\theta(t-s)} dW_s$.
2. **Slide 2 (`concept_pieces`):** Deconstruct solving OU SDE using integrating factor $e^{\theta t}$: (1) rearrange: $dX_t + \theta X_t dt = \theta \mu dt + \sigma dW_t$, (2) apply Itô's product rule to $d(e^{\theta t} X_t)$: $d(e^{\theta t} X_t) = \theta e^{\theta t} X_t dt + e^{\theta t} dX_t + d(e^{\theta t}) dX_t = e^{\theta t}(dX_t + \theta X_t dt) + 0$, (3) substitute SDE: $d(e^{\theta t} X_t) = \theta \mu e^{\theta t} dt + \sigma e^{\theta t} dW_t$, (4) integrate from $0$ to $t$: $e^{\theta t} X_t - X_0 = \mu(e^{\theta t} - 1) + \sigma \int_0^t e^{\theta s} dW_s$, (5) multiply by $e^{-\theta t}$ to obtain exact analytical solution!
3. **Slide 3 (`matching`):** Pair 4 SDE models (Geometric Brownian Motion / Black-Scholes, Ornstein-Uhlenbeck / Vasicek, Cox-Ingersoll-Ross / CIR square root diffusion, Heston Stochastic Volatility) with their defining features.
4. **Slide 4 (`numerical`):** Ask student: For a stock following GBM with initial price $S_0 = 100$, expected return drift $\mu = 0.05 \text{ (5\%)}$, and volatility $\sigma = 0.20$, what is the expected stock price $\mathbb{E}[S_2] = 100 \times e^{0.05 \times 2} = 100 \times e^{0.10} = 100 \times 1.10517 = 110.52$ after $t = 2$ years rounded to two decimal places? (numeric answer: 110.52).
5. **Slide 5 (`quiz`):** Quiz on the difference between expected price and median price in GBM: Why is the median stock price $S_0 \exp((\mu - \frac{1}{2}\sigma^2)t)$ strictly lower than the mean stock price $\mathbb{E}[S_t] = S_0 \exp(\mu t)$? (Because the log-normal distribution is right-skewed; Jensen's inequality and the convexity of the exponential function $\mathbb{E}[e^{\sigma W_t}] = e^{\frac{1}{2}\sigma^2 t}$ mean that rare high price spikes pull the mean upward above the median).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "geometric_brownian_motion_and_sde_solutions",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Stochastic Differential Equations: GBM and Ornstein-Uhlenbeck**\n• **Geometric Brownian Motion (GBM):**\n$$\ndS_t = \\mu S_t \\, dt + \\sigma S_t \\, dW_t \\implies S_t = S_0 \\exp\\left( \\left(\\mu - \\frac{1}{2}\\sigma^2\\right)t + \\sigma W_t \\right)\n$$\n  - **Moments:** $\\mathbb{E}[S_t] = S_0 e^{\\mu t}, \\quad \\operatorname{Var}(S_t) = S_0^2 e^{2\\mu t} (e^{\\sigma^2 t} - 1)$.\n• **Ornstein-Uhlenbeck (OU) Mean-Reverting Process:**\n$$\ndX_t = \\theta(\\mu - X_t) \\, dt + \\sigma \\, dW_t\n$$\n  - **Analytical Solution:**\n$$\nX_t = X_0 e^{-\\theta t} + \\mu(1 - e^{-\\theta t}) + \\sigma \\int_0^t e^{-\\theta(t - s)} \\, dW_s\n$$\n  - **Long-Term Stationary Distribution:** $X_\\infty \\sim \\mathcal{N}\\left( \\mu, \\; \\frac{\\sigma^2}{2\\theta} \\right)$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Rearrange SDE):** Move linear drift term to LHS: $dX_t + \\theta X_t dt = \\theta \\mu dt + \\sigma dW_t$.\n• **Step 2 (Integrating Factor):** Multiply by $e^{\\theta t}$ and apply Itô's product rule:\n  $$d(e^{\\theta t} X_t) = \\theta e^{\\theta t} X_t dt + e^{\\theta t} dX_t = e^{\\theta t} (\\theta \\mu dt + \\sigma dW_t)$$\n• **Step 3 (Integrate Both Sides):**\n  $$e^{\\theta t} X_t - X_0 = \\theta \\mu \\int_0^t e^{\\theta s} ds + \\sigma \\int_0^t e^{\\theta s} dW_s$$\n• **Step 4 (Deterministic Integral):** $\\theta \\mu \\int_0^t e^{\\theta s} ds = \\mu (e^{\\theta t} - 1)$.\n• **Step 5 (Isolate $X_t$):** Multiply by $e^{-\\theta t}$ to obtain the exact solution $X_t = X_0 e^{-\\theta t} + \\mu(1 - e^{-\\theta t}) + \\sigma \\int_0^t e^{-\\theta(t-s)} dW_s$!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each standard SDE model to its quantitative financial application.",
      "matchPairs": [
        { "left": "Geometric Brownian Motion (GBM)", "right": "Stock price modeling in Black-Scholes-Merton (strictly positive asset prices)" },
        { "left": "Ornstein-Uhlenbeck Process (OU)", "right": "Vasicek interest rate model / commodities (mean-reverting to equilibrium mu)" },
        { "left": "Cox-Ingersoll-Ross Model (CIR)", "right": "Square-root diffusion dr = a(b-r)dt + sigma sqrt(r) dW (prevents negative rates)" },
        { "left": "Heston Model", "right": "Stochastic volatility model with mean-reverting variance process" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "For a stock following GBM with S_0 = $100.00, expected return mu = 0.05, and volatility sigma = 0.20, calculate the expected stock price E[S_2] = 100 * exp(0.05 * 2) after t = 2.0 years to two decimal places.",
      "numericAnswer": 110.52,
      "numericTolerance": 0.05
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In Geometric Brownian Motion S_t = S_0 exp((mu - 1/2 sigma^2)t + sigma W_t), why is the expected price E[S_t] = S_0 exp(mu t) while the typical median price is S_0 exp((mu - 1/2 sigma^2)t)?",
      "options": [
        { "text": "Because the log-normal distribution is RIGHT-SKEWED; the convexity of the exponential function E[exp(sigma W_t)] = exp(1/2 sigma^2 t) pulls the arithmetic mean above the geometric median", "isCorrect": true, "explanation": "Correct! By Jensen's inequality, E[e^X] > e^{E[X]}. The -1/2 sigma^2 drift in log-space is exactly canceled by the convex tail when calculating the expected value in dollar space." },
        { "text": "Because variance is negative", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Brownian motion is biased", "isCorrect": false, "explanation": "Incorrect: Brownian motion has zero mean." },
        { "text": "Because stock prices always decline", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
