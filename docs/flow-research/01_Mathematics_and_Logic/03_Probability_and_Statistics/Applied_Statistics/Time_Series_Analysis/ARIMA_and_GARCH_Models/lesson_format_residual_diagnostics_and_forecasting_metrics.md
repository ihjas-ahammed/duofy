# Duofy Reusable Lesson Format: Time Series Residual Diagnostics and Forecasting Metrics

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Applied_Statistics / Time_Series_Analysis/ARIMA_and_GARCH_Models`  
**Lesson Format Type:** `residual_diagnostics_and_forecasting_metrics`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Diagnostic Checking & Forecast Evaluation**: execute the **Ljung-Box Portmanteau Test** ($Q = N(N+2)\sum \frac{\hat{\rho}_k^2}{N-k} \sim \chi^2_{m-p-q}$) on residuals to test for remaining serial correlation, compute forecast evaluation metrics (**RMSE, MAE, MAPE**), construct rolling forecast confidence intervals, and interact with live ARIMA/GARCH forecast simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Ljung-Box Test & Residual Diagnostics Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Forecast Evaluation Metric & Mathematical Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Ljung-Box Residual White Noise P-Value Criterion Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Portmanteau Test Author Surname Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive ARIMA Mean & GARCH Volatility Forecaster Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "residual_diagnostics_and_forecasting_metrics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Ljung-Box Q-Test, and how is it used in the Box-Jenkins diagnostic checking phase to validate an ARIMA model?",
      "blankAnswer": "The Ljung-Box Portmanteau Test tests the null hypothesis H_0 that the model residuals are independent white noise (no remaining autocorrelation): Q = N(N+2) sum_{k=1}^m [r_k^2 / (N-k)] where r_k is the sample autocorrelation of residuals at lag k. Under H_0, Q follows a Chi-Square distribution with m - p - q degrees of freedom. A p-value > 0.05 fails to reject H_0, confirming the ARIMA(p, d, q) model has successfully captured all linear dependencies!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each time series forecast evaluation metric to its formula.",
      "matchPairs": [
        { "left": "Root Mean Squared Error (RMSE)", "right": "sqrt( (1/h) sum_{t=1}^h (Y_{T+t} - Y_hat_{T+t})^2 ) (penalizes large errors heavily)" },
        { "left": "Mean Absolute Error (MAE)", "right": "(1/h) sum_{t=1}^h |Y_{T+t} - Y_hat_{T+t}| (robust to isolated outlier shocks)" },
        { "left": "Mean Absolute Percentage Error (MAPE)", "right": "(100/h) sum_{t=1}^h |(Y_{T+t} - Y_hat_{T+t}) / Y_{T+t}| (scale-free percentage error)" },
        { "left": "Diebold-Mariano Test", "right": "Statistical hypothesis test comparing the predictive accuracy of two competing forecasting models" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "After fitting an ARIMA(1, 1, 1) model, a Ljung-Box test on the residuals at lag m = 10 yields a test statistic p-value of p = 0.001. How should the modeler interpret this result?",
      "options": [
        { "text": "REJECT H_0: The residuals still contain significant serial autocorrelation (they are NOT pure white noise); the ARIMA model is inadequate and additional AR/MA lags or GARCH volatility modeling are required", "isCorrect": true, "explanation": "Correct! A small p-value (p < 0.05) proves that the residuals are not white noise, indicating the model has left predictable patterns unextracted in the error terms." },
        { "text": "Accept the model as optimal and begin forecasting immediately", "isCorrect": false, "explanation": "Incorrect: Low p-value indicates residual inadequacy." },
        { "text": "The model has achieved 100% forecasting accuracy", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The data contains zero noise", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the statistician who, together with George Box, developed the standard portmanteau Q-test for time series residuals (Ljung)?",
      "blankAnswer": "ljung"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive ARIMA + GARCH Forecaster",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>ARIMA(1,1,0) + GARCH(1,1) Forecaster</h3><p>Current Price: $150.00 | Residuals Ljung-Box p-value: 0.42 (White Noise)</p><button id=\"fcBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Generate 5-Step Forecast Cone</button><div id=\"fcOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('fcBtn').onclick=()=>{document.getElementById('fcOut').innerText='5-Step Forecast: Mean Path = [$151.20, $152.10, $152.80, $153.30, $153.70]. Dynamic GARCH 95% Confidence Bounds: [$144.10, $163.30] reflecting persistent market volatility!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
