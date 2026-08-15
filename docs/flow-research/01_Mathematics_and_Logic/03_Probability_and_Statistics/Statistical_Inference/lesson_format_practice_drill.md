# Duofy Reusable Lesson Format: Statistical Inference - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Statistical_Inference`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for statistical estimator properties, error classifications (Type I vs Type II), p-value interpretations, and interactive likelihood curve visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cramér-Rao Bound Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Estimator Property Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | P-Value Interpretation Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Likelihood Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Likelihood Curve Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the formula for the Cramér-Rao Lower Bound on variance of an unbiased estimator?",
      "blankAnswer": "Var(theta_hat) >= 1 / (n * I(theta)) (where I(theta) is Fisher Information)"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each statistical test concept to its exact definition.",
      "matchPairs": [
        { "left": "Significance Level (α)", "right": "Maximum probability of Type I Error (false positive)" },
        { "left": "Power of a Test (1 - β)", "right": "Probability of correctly rejecting a false null hypothesis H0" },
        { "left": "P-Value", "right": "Probability of observing a test statistic as extreme as sample data under H0" },
        { "left": "Likelihood Ratio Test", "right": "Compares max likelihood under H0 vs max likelihood overall" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What does a $p$-value of $0.02$ indicate in a hypothesis test at significance level $\\alpha = 0.05$?",
      "options": [
        { "text": "Reject H0 (since p = 0.02 < α = 0.05, the observed data is statistically significant)", "isCorrect": true, "explanation": "Correct! When p-value ≤ α, we reject the null hypothesis H0." },
        { "text": "Fail to reject H0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Probability that H0 is true is 2%", "isCorrect": false, "explanation": "Incorrect: P-values are NOT posterior probabilities of H0!" },
        { "text": "Type II error occurred", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What property describes a statistic T(X) if the conditional distribution P(X | T) is independent of parameter theta?",
      "blankAnswer": "sufficient"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Log-Likelihood Peak Finder",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Log-Likelihood Curve L(θ)</h3><p>Adjust parameter θ to find peak (MLE):</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Set θ = x_bar (Peak)</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Maximum Likelihood Estimate θ_MLE occurs at peak where d ln L / dθ = 0!'); };</script></div>"
    }
  ]
}
```
