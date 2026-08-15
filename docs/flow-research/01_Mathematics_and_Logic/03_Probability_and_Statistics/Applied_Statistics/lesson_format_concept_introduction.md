# Duofy Reusable Lesson Format: Applied Statistics - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Applied_Statistics`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Ordinary Least Squares (OLS) $\hat{\boldsymbol{\beta}} = (X^T X)^{-1} X^T \mathbf{y}$, Gauss-Markov Theorem, Generalized Linear Models (GLMs), ARIMA Time Series, and Principal Component Analysis (PCA).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | OLS & Gauss-Markov Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Regression & Dimensionality Reduction Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Applied Modeling Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | OLS Formula Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Gauss-Markov BLUE Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Ordinary Least Squares & Gauss-Markov**\nFor linear model $\\mathbf{y} = X \\boldsymbol{\\beta} + \\boldsymbol{\\epsilon}$ with $E[\\boldsymbol{\\epsilon}] = \\mathbf{0}$ and $\\text{Var}(\\boldsymbol{\\epsilon}) = \\sigma^2 I$:\n$$\n\\hat{\\boldsymbol{\\beta}}_{\\text{OLS}} = (X^T X)^{-1} X^T \\mathbf{y}\n$$\n**Gauss-Markov Theorem:** Under homoscedasticity and uncorrelated errors, $\\hat{\\boldsymbol{\\beta}}_{\\text{OLS}}$ is the **Best Linear Unbiased Estimator (BLUE)**."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **R-Squared ($R^2$):** Proportion of total variance explained by model: $R^2 = 1 - \\frac{\\text{SSE}}{\\text{SST}}$.\n• **Generalized Linear Models (GLM):** Extends linear regression via link function $g(E[Y]) = X \\beta$ (e.g. Logit link for Logistic Regression).\n• **ARIMA(p, d, q):** Models stationary time series via $p$ autoregressive terms, $d$ differencing steps, and $q$ moving average terms.\n• **PCA Dimensionality Reduction:** Projects high-dimensional data onto orthogonal eigenvectors of sample covariance matrix $X^T X$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Statistical Modeling technique to its primary application.",
      "matchPairs": [
        { "left": "Logistic Regression", "right": "Binary classification outcomes (0 or 1)" },
        { "left": "Poisson Regression", "right": "Count data (non-negative integers)" },
        { "left": "ARIMA Time Series", "right": "Sequential temporal forecasting with autocorrelation" },
        { "left": "Principal Component Analysis (PCA)", "right": "Unsupervised dimensionality reduction and feature extraction" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "According to the Gauss-Markov theorem, OLS is the BLUE estimator, where BLUE stands for Best Linear ___ Estimator.",
      "blankAnswer": "unbiased",
      "blankDistractors": ["uniform", "universal", "unique"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What problem occurs in linear regression when predictor variables in matrix $X$ are highly correlated with each other (**Multicollinearity**)?",
      "options": [
        { "text": "Matrix X^T X becomes near-singular, inflating coefficient variances Var(beta_hat) and causing instability", "isCorrect": true, "explanation": "Correct! High VIF (Variance Inflation Factor) inflates standard errors of regression coefficients." },
        { "text": "R² becomes negative", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Sample size decreases", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Residuals become zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
