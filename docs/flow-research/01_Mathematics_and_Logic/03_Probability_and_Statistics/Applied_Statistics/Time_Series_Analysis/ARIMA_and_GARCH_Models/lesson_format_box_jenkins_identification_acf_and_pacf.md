# Duofy Reusable Lesson Format: Box-Jenkins Model Identification: ACF and PACF

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Applied_Statistics / Time_Series_Analysis/ARIMA_and_GARCH_Models`  
**Lesson Format Type:** `box_jenkins_identification_acf_and_pacf`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the **Box-Jenkins Identification Phase**: calculate the **Autocorrelation Function (ACF)** $\rho(h) = \gamma(h)/\gamma(0)$ and **Partial Autocorrelation Function (PACF)** $\alpha(h)$, recognize the signature diagnostic patterns ($\operatorname{AR}(p)$ cuts off in PACF at lag $p$; $\operatorname{MA}(q)$ cuts off in ACF at lag $q$), and select optimal model orders via AIC and BIC information criteria.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | ACF, PACF, and Box-Jenkins Identification Rules Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step AR vs MA Model Identification Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Time Series Model & ACF/PACF Signature Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical MA(1) Autocorrelation at Lag 1 Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | PACF Definition Controlling for Intermediate Lags Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definitions of ACF and PACF: (1) Autocorrelation Function (ACF): $\rho(h) = \frac{\operatorname{Cov}(X_t, X_{t+h})}{\operatorname{Var}(X_t)} = \frac{\gamma(h)}{\gamma(0)}$. (2) Partial Autocorrelation Function (PACF): $\alpha(h) = \operatorname{Corr}(X_t, X_{t-h} \mid X_{t-1}, \dots, X_{t-h+1})$ (correlation after controlling for intermediate lags). State Box-Jenkins Identification Table:
   - $\operatorname{AR}(p)$: ACF decays exponentially/sinusoids; PACF **cuts off to zero after lag $p$**.
   - $\operatorname{MA}(q)$: ACF **cuts off to zero after lag $q$**; PACF decays exponentially.
   - $\operatorname{ARMA}(p, q)$: Both ACF and PACF decay smoothly with tails.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 identification steps: (1) plot sample ACF and PACF correlograms with $95\%$ Bartlett confidence bands $\pm 1.96/\sqrt{N}$, (2) check if ACF decays very slowly (indicating non-stationarity requiring differencing $d=1$), (3) examine PACF for sharp truncation: if PACF drops to inside bands after lag $p$, identify as $\operatorname{AR}(p)$, (4) examine ACF for sharp truncation: if ACF drops inside bands after lag $q$, identify as $\operatorname{MA}(q)$, (5) if both show tails, fit candidate $\operatorname{ARMA}(p, q)$ models and compare $\text{AIC} = -2\ln L + 2k$ and $\text{BIC} = -2\ln L + k\ln N$.
3. **Slide 3 (`matching`):** Pair 4 time series models ($\operatorname{AR}(1)$, $\operatorname{MA}(1)$, $\operatorname{AR}(2)$, White Noise) with their ACF/PACF visual signatures.
4. **Slide 4 (`numerical`):** Ask student: For a Moving Average process $\operatorname{MA}(1)$: $X_t = \epsilon_t + \theta \epsilon_{t-1}$ with parameter $\theta = 0.50$, calculate the theoretical autocorrelation at lag 1: $\rho(1) = \frac{\theta}{1 + \theta^2} = \frac{0.50}{1 + 0.25} = \frac{0.50}{1.25} = 0.40$ (numeric answer: 0.40).
5. **Slide 5 (`quiz`):** Quiz on the core conceptual difference between ACF and PACF: What does the Partial Autocorrelation Function (PACF) at lag $h$ measure that the standard Autocorrelation Function (ACF) does NOT? (PACF measures the direct correlation between $X_t$ and $X_{t-h}$ after stripping out the linear confounding effects of all intermediate intervening lags $X_{t-1}, \dots, X_{t-h+1}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "box_jenkins_identification_acf_and_pacf",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Box-Jenkins Model Identification: ACF and PACF**\n• **Autocorrelation Function (ACF):** $\\rho(h) = \\frac{\\operatorname{Cov}(X_t, X_{t-h})}{\\operatorname{Var}(X_t)}$.\n• **Partial Autocorrelation Function (PACF):** $\\alpha(h) = \\operatorname{Corr}(X_t, X_{t-h} \\mid X_{t-1}, \\dots, X_{t-h+1})$ (strips out intervening lag effects).\n• **Box-Jenkins Canonical Identification Signatures:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Model} & \\textbf{ACF Pattern} & \\textbf{PACF Pattern} \\\\\n\\hline\n\\operatorname{AR}(p) & \\text{Decays (Exponential / Sinusoid)} & \\textbf{Cuts off sharply after lag } p \\\\\n\\operatorname{MA}(q) & \\textbf{Cuts off sharply after lag } q & \\text{Decays (Exponential / Sinusoid)} \\\\\n\\operatorname{ARMA}(p, q) & \\text{Decays smoothly} & \\text{Decays smoothly} \\\\\n\\hline\n\\end{array}\n$$\n• **Bartlett's 95% Confidence Bounds:** $\\pm \\frac{1.96}{\\sqrt{N}}$ (bars outside are statistically significant)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Check Stationarity):** If sample ACF decays linearly and very slowly, data has a unit root $\\implies$ difference $d=1$.\n• **Step 2 (Inspect PACF for AR Order):** Look for a sharp cutoff in PACF. If lags $1, \\dots, p$ are significant and lag $p+1$ drops into zero-bands $\\implies$ select $\\operatorname{AR}(p)$.\n• **Step 3 (Inspect ACF for MA Order):** Look for a sharp cutoff in ACF. If lags $1, \\dots, q$ are significant and lag $q+1$ drops into zero-bands $\\implies$ select $\\operatorname{MA}(q)$.\n• **Step 4 (Model Comparison):** When both decay, compare candidate $\\operatorname{ARMA}(p, q)$ models using $\\text{AIC} = -2\\ln L + 2(p+q)$ and $\\text{BIC} = -2\\ln L + (p+q)\\ln N$ (smaller is better!)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each time series process to its ACF and PACF diagnostic behavior.",
      "matchPairs": [
        { "left": "Pure AR(1) Process", "right": "ACF decays as rho(h) = phi^h; PACF has a single spike at lag 1 then strictly cuts off" },
        { "left": "Pure MA(1) Process", "right": "ACF has a single spike at lag 1 then strictly cuts off; PACF decays exponentially" },
        { "left": "Pure AR(2) Process", "right": "PACF has significant spikes at lags 1 and 2, then cuts off to zero" },
        { "left": "Pure White Noise", "right": "All ACF and PACF spikes at lags h >= 1 lie entirely within the 95% confidence bands" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "For a Moving Average process MA(1): X_t = eps_t + 0.50 * eps_{t-1}, calculate the theoretical autocorrelation rho(1) = theta / (1 + theta^2) to two decimal places.",
      "numericAnswer": 0.40,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the key conceptual difference between the Autocorrelation Function (ACF) and the Partial Autocorrelation Function (PACF) at lag h?",
      "options": [
        { "text": "PACF measures the DIRECT linear correlation between X_t and X_{t-h} after eliminating the confounding transmission effects of all intermediate intervening variables (X_{t-1}, ..., X_{t-h+1})", "isCorrect": true, "explanation": "Correct! While ACF includes indirect effects passed through intermediate lags, PACF controls for all intervening lags, making it the ideal diagnostic tool for detecting direct autoregressive dependencies." },
        { "text": "PACF is always positive", "isCorrect": false, "explanation": "Incorrect: PACF can be negative." },
        { "text": "ACF is only defined for moving averages", "isCorrect": false, "explanation": "Incorrect: ACF applies to all stationary processes." },
        { "text": "PACF only works on non-stationary data", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
