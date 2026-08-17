# Duofy Reusable Lesson Format: Generalized Likelihood Ratio Test and Wilks' Theorem

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Statistical_Inference / Hypothesis_Testing / Neyman_Pearson_Lemma`  
**Lesson Format Type:** `generalized_likelihood_ratio_and_wilks_theorem`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of the **Generalized Likelihood Ratio Test (GLRT)** for composite hypotheses ($H_0: \theta \in \Theta_0$ vs $H_1: \theta \notin \Theta_0$), evaluate the asymptotic test statistic $-2 \ln \Lambda$, apply **Wilks' Theorem (1938)** to establish the limiting Chi-Squared distribution $\chi^2_r$ with $r = \dim(\Theta) - \dim(\Theta_0)$, and interact with live p-value and rejection region simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | GLRT Statistic & Wilks' Theorem Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Statistical Hypothesis Test & Asymptotic Metric Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Degrees of Freedom Nested Parameter Dimension Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Asymptotic Distribution Family Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive GLRT Wilks' Chi-Square P-Value Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "generalized_likelihood_ratio_and_wilks_theorem",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Generalized Likelihood Ratio Test (GLRT) statistic Lambda(X) for composite hypotheses, and what does Wilks' Theorem (1938) state about its asymptotic distribution?",
      "blankAnswer": "The GLRT statistic is Lambda(X) = [sup_{theta in Theta_0} L(theta | X)] / [sup_{theta in Theta} L(theta | X)] in [0, 1]. Wilks' Theorem proves that under H_0 and standard regularity conditions, the deviance statistic -2 ln(Lambda(X)) converges in distribution to a Chi-Square random variable: -2 ln(Lambda(X)) -> chi^2_r as n -> infty, where degrees of freedom r = dim(Theta) - dim(Theta_0) is the number of constrained parameters."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each classical asymptotic hypothesis test to its mathematical formulation.",
      "matchPairs": [
        { "left": "Likelihood Ratio Test (LRT)", "right": "-2 ln(L(theta_0_hat) / L(theta_hat)) -> chi^2_r" },
        { "left": "Wald Test", "right": "(theta_hat - theta_0)^T [I(theta_hat)] (theta_hat - theta_0) -> chi^2_r" },
        { "left": "Rao Score (Lagrange Multiplier) Test", "right": "S(theta_0)^T [I(theta_0)]^{-1} S(theta_0) -> chi^2_r (requires MLE under H_0 only)" },
        { "left": "Degrees of Freedom r", "right": "dim(Theta) - dim(Theta_0) (number of independent equality restrictions)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "We test whether a multinomial distribution with k = 4 outcome categories has equal probabilities (H_0: p_1 = p_2 = p_3 = p_4 = 0.25) against the unrestricted alternative. By Wilks' Theorem, what are the degrees of freedom r of the asymptotic Chi-Square test statistic -2 ln(Lambda)?",
      "options": [
        { "text": "r = 3 (since full parameter space dimension is k - 1 = 3 and the null hypothesis has dimension 0, so r = 3 - 0 = 3)", "isCorrect": true, "explanation": "Correct! A multinomial with 4 categories has 3 free probabilities (since sum p_i = 1). The null fixes all 3 parameters, yielding r = 3 - 0 = 3 degrees of freedom." },
        { "text": "r = 4", "isCorrect": false, "explanation": "Incorrect: sum p_i = 1 reduces dimension to 3." },
        { "text": "r = 1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "r = 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What hyphenated name denotes the asymptotic distribution family chi-square obeyed by the deviance statistic -2 ln(Lambda) in Wilks' theorem?",
      "blankAnswer": "chi-square"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Wilks' GLRT Chi-Square P-Value Calculator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Wilks' GLRT Test: -2 ln(Λ)</h3><p>Deviance statistic: G² = 7.815 | df = 3</p><button id=\"glrtBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate Asymptotic P-Value</button><div id=\"glrtOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('glrtBtn').onclick=()=>{document.getElementById('glrtOut').innerText='P-Value = P(χ²₃ ≥ 7.815) = 0.0500. Null hypothesis rejected at α = 0.05 level!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
