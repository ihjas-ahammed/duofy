# Duofy Reusable Lesson Format: Statistical Inference - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Statistical_Inference`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Maximum Likelihood Estimation (MLE), Fisher Information $I(\theta)$, Cramér-Rao Lower Bound (CRLB), Neyman-Pearson Lemma, and Bayesian Posteriors.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | MLE & Fisher Information Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Estimator Efficiency & Testing Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Inference Concept Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Fisher Information Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Neyman-Pearson Most Powerful Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Maximum Likelihood & Cramér-Rao Lower Bound**\n1. **MLE Estimator:** $\\hat{\\theta}_{\\text{MLE}} = \\arg\\max_\\theta \\ln L(\\theta; \\mathbf{x})$.\n2. **Fisher Information:** $I(\\theta) = -E \\left[ \\frac{\\partial^2 \\ln f(X; \\theta)}{\\partial \\theta^2} \\right]$.\n3. **Cramér-Rao Lower Bound (CRLB):** For any unbiased estimator $\\hat{\\theta}$ of $\\theta$:\n$$\n\\text{Var}(\\hat{\\theta}) \\ge \\frac{1}{n I(\\theta)}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Sufficient Statistic:** A statistic $T(X)$ captures ALL information in sample $X$ about parameter $\\theta$.\n• **Neyman-Fisher Factorization:** Joint PDF factors as $f(x; \\theta) = g(T(x), \\theta) h(x) \\iff T(x)$ is sufficient.\n• **Neyman-Pearson Lemma:** Likelihood ratio test $\\Lambda(x) = \\frac{L(\\theta_0; x)}{L(\\theta_1; x)} \\le k$ is the Most Powerful test for simple hypotheses.\n• **Bayesian Posterior:** $p(\\theta \\mid x) \\propto p(x \\mid \\theta) p(\\theta)$ (Posterior $\\propto$ Likelihood $\\times$ Prior)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Statistical Inference term to its defining property.",
      "matchPairs": [
        { "left": "Unbiased Estimator", "right": "E[theta_hat] = theta (zero bias)" },
        { "left": "Efficient Estimator", "right": "Unbiased estimator whose variance achieves the Cramér-Rao bound" },
        { "left": "Type I Error (α)", "right": "Rejecting null hypothesis H0 when H0 is actually true (false positive)" },
        { "left": "Type II Error (β)", "right": "Failing to reject H0 when H1 is actually true (false negative)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The variance of an unbiased estimator theta_hat cannot be smaller than one divided by n times the Fisher ___.",
      "blankAnswer": "information",
      "blankDistractors": ["likelihood", "variance", "sample"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What does the Neyman-Pearson Lemma guarantee about the Likelihood Ratio Test $\\Lambda(x) = \\frac{L(\\theta_0; x)}{L(\\theta_1; x)} \\le k$ for simple hypothesis testing?",
      "options": [
        { "text": "It is the Most Powerful (MP) test at significance level α (maximizes power 1 - β)", "isCorrect": true, "explanation": "Correct! Neyman-Pearson proves likelihood ratio tests achieve maximum power for simple hypotheses." },
        { "text": "It eliminates Type I error completely (α = 0)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It requires no data sample", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It is a Bayesian prior", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
