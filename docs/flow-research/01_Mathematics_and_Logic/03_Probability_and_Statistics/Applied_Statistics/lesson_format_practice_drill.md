# Duofy Reusable Lesson Format: Applied Statistics - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Applied_Statistics`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for regression diagnostic metrics ($R^2$, VIF, AIC, BIC), ARIMA orders, PCA variance ratios, and interactive OLS linear regression visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | OLS Formula Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Applied Metric Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Multicollinearity VIF Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Regression Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive OLS Fitting Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the formula for matrix OLS estimator beta_hat?",
      "blankAnswer": "beta_hat = (X^T * X)^(-1) * X^T * y"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each regression diagnostic metric to its purpose.",
      "matchPairs": [
        { "left": "Variance Inflation Factor (VIF)", "right": "Detects multicollinearity among predictors (VIF > 5 or 10)" },
        { "left": "Breusch-Pagan Test", "right": "Tests for heteroscedasticity (non-constant error variance)" },
        { "left": "Durbin-Watson Statistic", "right": "Detects first-order autocorrelation in residuals" },
        { "left": "Akaike Information Criterion (AIC)", "right": "Model selection metric balancing fit and model complexity" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What does a high Variance Inflation Factor $\\text{VIF}_j = \\frac{1}{1 - R_j^2} > 10$ indicate for predictor $x_j$ in multiple regression?",
      "options": [
        { "text": "Severe Multicollinearity (x_j is strongly predicted by other independent variables)", "isCorrect": true, "explanation": "Correct! VIF > 10 indicates R_j² > 0.90, causing unstable coefficient estimates." },
        { "text": "Zero residual variance", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "High prediction accuracy", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Heteroscedasticity", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What term describes time series property where mean, variance, and autocovariance remain constant over time?",
      "blankAnswer": "stationarity"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive OLS Line Fitter",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>OLS Line Fitting</h3><p>Adjust line slope β₁ to minimize sum of squared residuals SSE:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Set β₁ = Sxy / Sxx</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Setting β₁ = Sxy/Sxx minimizes SSE = ∑ (y_i - y_hat_i)²!'); };</script></div>"
    }
  ]
}
```
