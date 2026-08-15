# Duofy Reusable Lesson Format: Statistical Inference - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Statistical_Inference`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to derive Maximum Likelihood Estimators $\hat{\theta}_{\text{MLE}}$, compute Fisher Information $I(\theta)$, factorize joint PDFs via Neyman-Fisher, and evaluate conjugate Bayesian posteriors.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Log-Likelihood & MLE Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step MLE Derivative Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Score Function Derivative Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative MLE Estimator Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Conjugate Bayesian Update Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Maximum Likelihood Estimation for Exponential Distribution**\nGiven i.i.d. sample $X_1, \\dots, X_n \\sim \\text{Exp}(\\lambda)$ with $f(x; \\lambda) = \\lambda e^{-\\lambda x}$:\n$$\nL(\\lambda; \\mathbf{x}) = \\prod_{i=1}^n \\lambda e^{-\\lambda x_i} = \\lambda^n e^{-\\lambda \\sum x_i}\n$$\nLog-likelihood: $\\ln L(\\lambda) = n \\ln \\lambda - \\lambda \\sum_{i=1}^n x_i$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Derivative of log-likelihood: $\\frac{d \\ln L}{d\\lambda} = \\frac{n}{\\lambda} - \\sum_{i=1}^n x_i$.\n• **Step 2:** Set equal to zero: $\\frac{n}{\\lambda} - \\sum x_i = 0$.\n• **Step 3:** Solve for $\\lambda$: $\\hat{\\lambda}_{\\text{MLE}} = \\frac{n}{\\sum x_i} = \\frac{1}{\\bar{X}}$.\n• **Step 4:** Second derivative: $\\frac{d^2 \\ln L}{d\\lambda^2} = -\\frac{n}{\\lambda^2} < 0$, confirming maximum!"
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "To find the maximum likelihood estimator theta_hat, we take the derivative of the log-likelihood function and set it equal to ___.",
      "blankAnswer": "0",
      "blankDistractors": ["1", "n", "theta"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Given a sample of $n = 5$ observations with sample mean $\\bar{X} = 2.5$, calculate the Maximum Likelihood Estimate $\\hat{\\lambda}_{\\text{MLE}} = 1 / \\bar{X}$ for an exponential parameter.",
      "numericAnswer": 0.4,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "If binomial successes $k \\sim \\text{Binomial}(n, p)$ have a conjugate $\\text{Beta}(\\alpha, \\beta)$ prior on $p$, what is the updated posterior distribution $p(p \\mid k)$?",
      "options": [
        { "text": "Beta(α + k, β + n - k)", "isCorrect": true, "explanation": "Correct! Conjugate Beta-Binomial update simply adds successes k to α and failures (n-k) to β." },
        { "text": "Normal(k, n)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Gamma(α, β)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Beta(α, β)", "isCorrect": false, "explanation": "Incorrect: That is the un-updated prior." }
      ]
    }
  ]
}
```
