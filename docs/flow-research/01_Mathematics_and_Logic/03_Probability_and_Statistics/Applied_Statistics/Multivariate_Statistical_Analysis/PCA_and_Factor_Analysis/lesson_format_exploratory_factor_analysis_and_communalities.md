# Duofy Reusable Lesson Format: Exploratory Factor Analysis and Communalities

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Applied_Statistics / Multivariate_Statistical_Analysis / PCA_and_Factor_Analysis`  
**Lesson Format Type:** `exploratory_factor_analysis_and_communalities`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to formulate the generative **Exploratory Factor Analysis (EFA)** model ($\mathbf{x} - \mathbf{\mu} = \mathbf{\Lambda} \mathbf{f} + \mathbf{\epsilon}$), decompose total variance into **Communality** $h_i^2 = \sum_{j=1}^m \lambda_{ij}^2$ (shared common variance) and **Specific/Unique Variance** $\psi_i = \sigma_{ii} - h_i^2$, and rigorously contrast Factor Analysis (latent construct modeling) against PCA (data compression).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | EFA Generative Model & Communality Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Factor Model Covariance Decomposition Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | PCA vs Factor Analysis Fundamental Dichotomy Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Communality Proportion of Common Variance Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | High vs Low Communality Variable Assessment Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Orthogonal Factor Model (Charles Spearman 1904, Louis Thurstone 1947): Let $\mathbf{x} \in \mathbb{R}^p$ be observed standardized variables ($E[\mathbf{x}] = \mathbf{0}, \operatorname{Var}(X_i) = 1$). The model assumes $m \ll p$ unobserved latent common factors $\mathbf{f} = (F_1, \dots, F_m)^T$ and specific error terms $\mathbf{\epsilon}$:
   $$\mathbf{x} = \mathbf{\Lambda} \mathbf{f} + \mathbf{\epsilon}, \qquad \mathbb{E}[\mathbf{f}] = \mathbf{0}, \quad \operatorname{Cov}(\mathbf{f}) = \mathbf{I}_m, \quad \operatorname{Cov}(\mathbf{\epsilon}) = \mathbf{\Psi} = \operatorname{diag}(\psi_1, \dots, \psi_p)$$
   State Covariance Decomposition: $\mathbf{\Sigma} = \mathbf{\Lambda} \mathbf{\Lambda}^T + \mathbf{\Psi}$. For standardized variables:
   $$\operatorname{Var}(X_i) = 1 = \underbrace{\sum_{j=1}^m \lambda_{ij}^2}_{h_i^2 \text{ (Communality)}} + \underbrace{\psi_i}_{\text{Specific Variance}}$$
2. **Slide 2 (`concept_pieces`):** Deconstruct the variance derivation: (1) write variable expression: $X_i = \lambda_{i1} F_1 + \dots + \lambda_{im} F_m + \epsilon_i$, (2) take variance: $\operatorname{Var}(X_i) = \sum_{j=1}^m \lambda_{ij}^2 \operatorname{Var}(F_j) + \operatorname{Var}(\epsilon_i) + \text{covariances}$, (3) since factors are standardized ($\operatorname{Var}(F_j) = 1$) and uncorrelated ($\operatorname{Cov}(F_j, F_k) = 0$), cross-terms vanish, (4) since factors are independent of errors ($\operatorname{Cov}(F_j, \epsilon_i) = 0$), $\operatorname{Var}(X_i) = \sum_{j=1}^m \lambda_{ij}^2 + \psi_i = h_i^2 + \psi_i$, (5) conclude: communality $h_i^2 \in [0, 1]$ represents the proportion of variance explained by the common latent factors!
3. **Slide 3 (`matching`):** Pair 4 factor analysis objects (Factor Loading $\lambda_{ij}$, Communality $h_i^2$, Specific Variance $\psi_i$, Latent Common Factor $F_j$) with their statistical definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that communality $h_i^2$ measures the proportion of a variable's variance accounted for by the shared common factors. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on evaluating variables with low communality: In an exploratory factor analysis, variable $X_4$ exhibits communality $h_4^2 = 0.12$ (meaning specific error variance $\psi_4 = 0.88$). What is the correct interpretation and recommendation? (Variable $X_4$ shares very little common variance with the other variables in the dataset; it is largely dominated by idiosyncratic noise/error and should generally be removed from the factor model).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "exploratory_factor_analysis_and_communalities",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Exploratory Factor Analysis (EFA) and Communalities**\n• **The Orthogonal Factor Model:** Explains observed correlations among $p$ standardized variables $\\mathbf{x}$ using $m \\ll p$ **latent common factors** $\\mathbf{f}$:\n$$\n\\mathbf{x} = \\mathbf{\\Lambda} \\mathbf{f} + \\mathbf{\\epsilon}, \\qquad \\operatorname{Cov}(\\mathbf{f}) = \\mathbf{I}_m, \\quad \\operatorname{Cov}(\\mathbf{\\epsilon}) = \\mathbf{\\Psi} = \\operatorname{diag}(\\psi_1, \\dots, \\psi_p)\n$$\nwhere $\\mathbf{\\Lambda} = [\\lambda_{ij}]$ is the $(p \\times m)$ **Factor Loading Matrix**.\n• **Covariance Decomposition Theorem:**\n$$\n\\mathbf{\\Sigma} = \\mathbf{\\Lambda} \\mathbf{\\Lambda}^T + \\mathbf{\\Psi}\n$$\n• **Variance Partitioning:** For each standardized variable $X_i$ ($\\operatorname{Var}(X_i) = 1$):\n$$\n1 = \\underbrace{\\sum_{j=1}^m \\lambda_{ij}^2}_{h_i^2 \\text{ (Communality)}} + \\underbrace{\\psi_i}_{\\text{Specific Variance}}\n$$\n($h_i^2$ = proportion of variable $i$'s variance explained by the common factors)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Variable Linear Model):** $X_i = \\lambda_{i1} F_1 + \\lambda_{i2} F_2 + \\dots + \\lambda_{im} F_m + \\epsilon_i$.\n• **Step 2 (Apply Variance Operator):**\n  $$\\operatorname{Var}(X_i) = \\sum_{j=1}^m \\lambda_{ij}^2 \\operatorname{Var}(F_j) + 2 \\sum_{j < k} \\lambda_{ij} \\lambda_{ik} \\operatorname{Cov}(F_j, F_k) + \\operatorname{Var}(\\epsilon_i)$$\n• **Step 3 (Factor Orthogonality):** Since $\\operatorname{Var}(F_j) = 1$ and $\\operatorname{Cov}(F_j, F_k) = 0$, all cross-terms vanish.\n• **Step 4 (Independence of Errors):** Since $\\operatorname{Cov}(F_j, \\epsilon_i) = 0$, the variance collapses to:\n  $$\\operatorname{Var}(X_i) = \\sum_{j=1}^m \\lambda_{ij}^2 + \\psi_i = h_i^2 + \\psi_i$$\n• **Step 5 (Interpretation):** High communality ($h_i^2 \\to 1$) indicates the variable is strongly governed by common latent constructs!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Factor Analysis concept to its mathematical role.",
      "matchPairs": [
        { "left": "Factor Loading lambda_{ij}", "right": "Correlation between observed variable X_i and unobserved latent factor F_j" },
        { "left": "Communality h_i^2 = sum lambda_{ij}^2", "right": "Fraction of variable X_i variance accounted for by the shared common factors" },
        { "left": "Specific Variance psi_i", "right": "Unique / idiosyncratic variance not explained by any common factor (includes noise)" },
        { "left": "Common Factor F_j", "right": "Unobserved theoretical construct (e.g. intelligence, risk tolerance)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Exploratory Factor Analysis, the proportion of a variable's total variance explained by all shared common factors combined is called its ___.",
      "blankAnswer": "communality",
      "blankDistractors": ["eigenvalue", "trace", "determinant"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In an EFA study on consumer preferences, survey item X_7 yields factor loadings lambda_{7,1} = 0.20 and lambda_{7,2} = 0.10, resulting in communality h_7^2 = 0.20^2 + 0.10^2 = 0.05 (specific variance psi_7 = 0.95). How should the statistician interpret this item?",
      "options": [
        { "text": "Item X_7 has very LOW communality (95% of its variance is unique noise); it does not load meaningfully on the extracted latent constructs and should be considered for removal", "isCorrect": true, "explanation": "Correct! Communality h^2 = 0.05 means only 5% of the item's variance is shared with the common factors. Items with h^2 < 0.20-0.30 fail to capture the common dimensions." },
        { "text": "Item X_7 is the most important variable in the entire model", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Item X_7 proves that the factors are correlated", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The factor model explains 95% of item X_7", "isCorrect": false, "explanation": "Incorrect: 95% is unexplained unique variance." }
      ]
    }
  ]
}
```
