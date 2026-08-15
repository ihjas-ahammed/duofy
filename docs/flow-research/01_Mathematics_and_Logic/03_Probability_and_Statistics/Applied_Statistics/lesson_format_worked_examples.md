# Duofy Reusable Lesson Format: Applied Statistics - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Applied_Statistics`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute simple linear OLS slopes $\hat{\beta}_1 = \frac{\sum (x_i - \bar{x})(y_i - \bar{y})}{\sum (x_i - \bar{x})^2}$, calculate $R^2 = 1 - \text{SSE}/\text{SST}$, and evaluate PCA explained variance ratios $\frac{\lambda_k}{\sum \lambda_i}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | OLS Slope & Intercept Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step OLS Slope Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Variance Decomposition Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative R-Squared Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Logistic Odds Ratio Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Simple Linear Regression Formulas**\nFor model $y_i = \\beta_0 + \\beta_1 x_i + \\epsilon_i$, OLS estimates are:\n$$\n\\hat{\\beta}_1 = \\frac{S_{xy}}{S_{xx}} = \\frac{\\sum (x_i - \\bar{x})(y_i - \\bar{y})}{\\sum (x_i - \\bar{x})^2}, \\quad \\hat{\\beta}_0 = \\bar{y} - \\hat{\\beta}_1 \\bar{x}\n$$\nCo-variance sum $S_{xy}$ and variance sum $S_{xx}$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Given 3 data points: $(1, 2), (2, 3), (3, 7)$.\n• **Step 2:** $\\bar{x} = 2, \\bar{y} = 4$.\n• **Step 3:** $S_{xx} = (1-2)^2 + (2-2)^2 + (3-2)^2 = 1 + 0 + 1 = 2$.\n• **Step 4:** $S_{xy} = (1-2)(2-4) + (2-2)(3-4) + (3-2)(7-4) = 2 + 0 + 3 = 5$.\n• **Step 5:** $\\hat{\\beta}_1 = 5 / 2 = 2.5$. Intercept $\\hat{\\beta}_0 = 4 - (2.5)(2) = -1$. Model: $\\hat{y} = -1 + 2.5 x$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In ANOVA variance decomposition, Total Sum of Squares (SST) equals Regression Sum of Squares (SSR) plus Error Sum of Squares ___.",
      "blankAnswer": "SSE",
      "blankDistractors": ["SXX", "SXY", "VIF"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate $R^2 = 1 - \\frac{\\text{SSE}}{\\text{SST}}$ if Total Sum of Squares $\\text{SST} = 100$ and Residual Sum of Squares $\\text{SSE} = 20$.",
      "numericAnswer": 0.8,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In Logistic Regression $\\ln\\left(\\frac{p}{1-p}\\right) = \\beta_0 + \\beta_1 x$, what is the interpretation of coefficient $e^{\\beta_1}$?",
      "options": [
        { "text": "The multiplicative change in Odds Ratio for a 1-unit increase in x", "isCorrect": true, "explanation": "Correct! exp(β₁) represents the odds ratio multiplier for a unit increase in x." },
        { "text": "The change in probability p", "isCorrect": false, "explanation": "Incorrect: Change in probability is non-linear." },
        { "text": "The variance of residuals", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The correlation coefficient", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
