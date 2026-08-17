# Duofy Reusable Lesson Format: Scree Plots and Proportion of Variance Explained

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Applied_Statistics / Multivariate_Statistical_Analysis / PCA_and_Factor_Analysis`  
**Lesson Format Type:** `scree_plots_and_variance_explained`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through component selection heuristics: compute the **Proportion of Variance Explained (PVE)** ($\text{PVE}_k = \lambda_k / \sum \lambda_i$), construct cumulative variance curves, interpret **Cattell's Scree Plot** (Raymond Cattell, 1966) by identifying the "elbow" transition, apply the **Kaiser-Guttman Rule** ($\lambda_k > 1.0$), and evaluate Horn's Parallel Analysis.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Variance Explained & Scree Plot Criteria Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Scree Plot Elbow Identification Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Component Retention Rule & Statistical Heuristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical Cumulative Proportion of Variance Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Kaiser-Guttman Correlation Matrix Eigenvalue Threshold Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the formula for the Proportion of Variance Explained (PVE) by the $k$-th principal component: $\text{PVE}_k = \frac{\lambda_k}{\sum_{j=1}^p \lambda_j}$. Cumulative PVE for top $K$ components: $\text{Cumulative PVE}_K = \frac{\sum_{k=1}^K \lambda_k}{\sum_{j=1}^p \lambda_j}$. Define Cattell's Scree Plot (1966): A line plot of ordered eigenvalues $\lambda_k$ versus component number $k$. The "scree" represents the flat rubble of noise eigenvalues after the steep "cliff" of signal eigenvalues. State the Kaiser-Guttman Rule: Retain all components with $\lambda_k > 1.0$ when PCA is performed on the correlation matrix (since each original standardized variable has variance 1.0).
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 component selection steps: (1) calculate eigenvalues $\lambda_1 \ge \lambda_2 \ge \dots \ge \lambda_p$, (2) plot $\lambda_k$ against $k$ on a scree plot, (3) locate the point of maximum inflection (the "elbow") where the sharp downward slope abruptly levels off into a linear baseline, (4) retain all components strictly BEFORE the elbow, (5) verify that cumulative variance exceeds standard targets (e.g. 70% to 90%).
3. **Slide 3 (`matching`):** Pair 4 retention methods (Kaiser-Guttman Criterion, Cattell's Scree Test, Horn's Parallel Analysis, Cumulative Variance Threshold) with their operational rules.
4. **Slide 4 (`numerical`):** Ask student: In a 5-variable dataset ($p = 5$), the eigenvalues of the correlation matrix are $\lambda_1 = 2.50, \lambda_2 = 1.25, \lambda_3 = 0.60, \lambda_4 = 0.40, \lambda_5 = 0.25$ (total trace $\sum \lambda = 5.00$). What is the cumulative proportion of variance explained by the first TWO components as a percentage (to one decimal place)? $\frac{2.50 + 1.25}{5.00} = \frac{3.75}{5.00} = 0.75 = 75.0\%$ (numeric answer: 75.0).
5. **Slide 5 (`quiz`):** Quiz on the rationale for Kaiser's $\lambda > 1$ rule: Why does the Kaiser criterion set the retention threshold at $\lambda > 1.0$ for correlation matrices? (Because each original standardized variable has unit variance $\operatorname{Var}(X_i) = 1.0$; a principal component with eigenvalue $\lambda < 1.0$ explains LESS variance than a single original variable, offering no data compression advantage).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "scree_plots_and_variance_explained",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Variance Explained and Dimensionality Retention Rules**\n• **Proportion of Variance Explained (PVE):** For ordered eigenvalues $\\lambda_1 \\ge \\dots \\ge \\lambda_p$:\n$$\n\\text{PVE}_k = \\frac{\\lambda_k}{\\sum_{j=1}^p \\lambda_j}, \\qquad \\text{Cumulative PVE}_K = \\frac{\\sum_{k=1}^K \\lambda_k}{\\sum_{j=1}^p \\lambda_j}\n$$\n• **Cattell's Scree Plot (Raymond Cattell, 1966):**\n  - Plots $\\lambda_k$ versus component index $k$.\n  - **The Elbow Rule:** Retain components above the **inflection point (elbow)** where the steep cliff flattens into residual noise rubble ('scree').\n• **Kaiser-Guttman Rule:** For standardized correlation matrices, retain components with **$\\lambda_k > 1.0$** (explaining more variance than a single original variable)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Compute Eigenvalues):** Obtain sorted eigenvalues $\\lambda_1 \\ge \\lambda_2 \\ge \\dots \\ge \\lambda_p$ from covariance/correlation matrix.\n• **Step 2 (Plot Scree Line):** Plot eigenvalues on the y-axis against component index $k$ on the x-axis.\n• **Step 3 (Locate Inflection):** Identify the 'elbow' where the slope changes dramatically from steep decay to a gentle, flat line.\n• **Step 4 (Retain Major Signal):** Keep the $K$ components that precede the elbow.\n• **Step 5 (Check Threshold):** Verify that the retained $K$ components explain a satisfactory cumulative variance (e.g. $> 70-80\\%$)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each component retention method to its rule.",
      "matchPairs": [
        { "left": "Kaiser-Guttman Rule", "right": "Retain all components with eigenvalue lambda_k > 1.0 on correlation matrix" },
        { "left": "Cattell's Scree Test", "right": "Visual inspection finding the elbow inflection before residual rubble flattening" },
        { "left": "Horn's Parallel Analysis", "right": "Compares empirical eigenvalues against 95th percentile of eigenvalues from random noise matrices" },
        { "left": "Cumulative Variance Criterion", "right": "Retain minimum number of components needed to reach fixed percentage (e.g. 80%)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "For a 5-variable correlation matrix with eigenvalues lambda = [2.50, 1.25, 0.60, 0.40, 0.25], calculate the cumulative percentage of variance explained by the first two components (write as percentage 75.0).",
      "numericAnswer": 75.0,
      "numericTolerance": 0.5
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the logical justification for the Kaiser-Guttman rule retaining only components with lambda > 1.0 for correlation matrices?",
      "options": [
        { "text": "Each standardized original variable has a variance of exactly 1.0; a principal component with lambda < 1.0 contains LESS information than a single raw variable, failing to provide meaningful dimension reduction", "isCorrect": true, "explanation": "Correct! Since total variance equals p (trace of correlation matrix), average eigenvalue is exactly 1.0. Retaining components with lambda > 1.0 ensures we keep only those that outperform individual raw features." },
        { "text": "Eigenvalues smaller than 1.0 are negative", "isCorrect": false, "explanation": "Incorrect: Eigenvalues of covariance matrices are non-negative." },
        { "text": "Because 1.0 is the maximum possible eigenvalue", "isCorrect": false, "explanation": "Incorrect: lambda_1 can be up to p." },
        { "text": "Because variance cannot exceed 1", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
