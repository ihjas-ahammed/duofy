# Duofy Reusable Lesson Format: Principal Component Analysis and Spectral Eigen-Decomposition

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Applied_Statistics / Multivariate_Statistical_Analysis / PCA_and_Factor_Analysis`  
**Lesson Format Type:** `principal_component_analysis_and_eigen_decomposition`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce **Principal Component Analysis (PCA)** (Karl Pearson 1901, Harold Hotelling 1933), formulate the variance maximization constrained optimization problem $\max_{\|\mathbf{w}\|=1} \mathbf{w}^T \mathbf{\Sigma} \mathbf{w}$, derive the eigenvector equation $\mathbf{\Sigma} \mathbf{w} = \lambda \mathbf{w}$ via Lagrange multipliers, establish orthogonality of components, and link PCA to Singular Value Decomposition (SVD).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | PCA Variance Maximization Formal Theorem Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Lagrange Multiplier Variance Maximization Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | PCA Geometry & Matrix Decomposition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | 2D Covariance Matrix First PC Angle Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Uncorrelated Transformed Variables Property Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the PCA Optimization Theorem: Let $\mathbf{x} \in \mathbb{R}^p$ be a random vector with covariance matrix $\mathbf{\Sigma} = \operatorname{Cov}(\mathbf{x}) \in \mathbb{R}^{p \times p}$. The $k$-th principal component is $Z_k = \mathbf{w}_k^T \mathbf{x}$, where loading vector $\mathbf{w}_k$ maximizes variance subject to unit norm and mutual orthogonality:
   $$\mathbf{w}_k = \operatorname{argmax}_{\|\mathbf{w}\|=1, \mathbf{w} \perp \mathbf{w}_1,\dots,\mathbf{w}_{k-1}} \operatorname{Var}(\mathbf{w}^T \mathbf{x}) = \mathbf{w}^T \mathbf{\Sigma} \mathbf{w}$$
   State Theorem: The optimal loading vectors $\mathbf{w}_1, \dots, \mathbf{w}_p$ are the orthonormal eigenvectors of $\mathbf{\Sigma}$ associated with ordered eigenvalues $\lambda_1 \ge \lambda_2 \ge \dots \ge \lambda_p \ge 0$, and $\operatorname{Var}(Z_k) = \lambda_k$. Components are pairwise uncorrelated ($\operatorname{Cov}(Z_j, Z_k) = 0$ for $j \ne k$).
2. **Slide 2 (`ordering`):** Provide 5 steps deriving $\mathbf{\Sigma} \mathbf{w}_1 = \lambda_1 \mathbf{w}_1$: (1) write objective to maximize variance $\mathbf{w}^T \mathbf{\Sigma} \mathbf{w}$ subject to $\|\mathbf{w}\|^2 = \mathbf{w}^T \mathbf{w} = 1$, (2) set up the Lagrangian: $\mathcal{L}(\mathbf{w}, \lambda) = \mathbf{w}^T \mathbf{\Sigma} \mathbf{w} - \lambda (\mathbf{w}^T \mathbf{w} - 1)$, (3) differentiate with respect to vector $\mathbf{w}$: $\nabla_{\mathbf{w}} \mathcal{L} = 2 \mathbf{\Sigma} \mathbf{w} - 2 \lambda \mathbf{w} = \mathbf{0}$, (4) simplify to standard matrix eigenvalue equation: $\mathbf{\Sigma} \mathbf{w} = \lambda \mathbf{w}$, (5) multiply on the left by $\mathbf{w}^T$: $\mathbf{w}^T \mathbf{\Sigma} \mathbf{w} = \lambda \mathbf{w}^T \mathbf{w} = \lambda$, showing that maximizing variance requires selecting the eigenvector corresponding to the MAXIMUM eigenvalue $\lambda_1$.
3. **Slide 3 (`matching`):** Pair 4 PCA matrix objects (Covariance Matrix $\mathbf{\Sigma}$, Eigenvector $\mathbf{w}_k$, Eigenvalue $\lambda_k$, Principal Component Score $Z_k = \mathbf{w}_k^T \mathbf{x}$) with their geometric roles.
4. **Slide 4 (`proof`):** Interactive derivation for $\mathbf{\Sigma} = \begin{bmatrix} 3 & 1 \\ 1 & 3 \end{bmatrix}$, showing eigenvalues $\lambda_1 = 4, \lambda_2 = 2$ and first principal component $\mathbf{w}_1 = \frac{1}{\sqrt{2}}[1, 1]^T$ along the $45^\circ$ diagonal.
5. **Slide 5 (`one_word`):** Plain-text recall of the statistical term describing the zero-covariance relationship between distinct principal components $Z_j$ and $Z_k$ ($\operatorname{Cov}(Z_j, Z_k) = 0$) (uncorrelated).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "principal_component_analysis_and_eigen_decomposition",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Principal Component Analysis (PCA)**\n• Let $\\mathbf{x} \\in \\mathbb{R}^p$ have covariance matrix $\\mathbf{\\Sigma} = \\operatorname{Cov}(\\mathbf{x})$.\n• **Variance Maximization Problem:** Find unit vector $\\mathbf{w}_1$ maximizing projection variance:\n$$\n\\max_{\\|\\mathbf{w}\\|=1} \\operatorname{Var}(\\mathbf{w}^T \\mathbf{x}) = \\mathbf{w}^T \\mathbf{\\Sigma} \\mathbf{w}\n$$\n• **Spectral Theorem Solution:** The optimal loading vectors $\\mathbf{w}_1, \\dots, \\mathbf{w}_p$ are the **orthonormal eigenvectors** of $\\mathbf{\\Sigma}$:\n$$\n\\mathbf{\\Sigma} \\mathbf{w}_k = \\lambda_k \\mathbf{w}_k, \\qquad \\lambda_1 \\ge \\lambda_2 \\ge \\dots \\ge \\lambda_p \\ge 0\n$$\n• **Properties of Principal Components $Z_k = \\mathbf{w}_k^T \\mathbf{x}$:**\n  1. $\\operatorname{Var}(Z_k) = \\lambda_k$ (variance equals eigenvalue).\n  2. $\\operatorname{Cov}(Z_j, Z_k) = 0$ for all $j \\ne k$ (**strictly uncorrelated**).\n  3. Total variance is preserved: $\\sum_{k=1}^p \\operatorname{Var}(Z_k) = \\sum_{k=1}^p \\lambda_k = \\operatorname{Tr}(\\mathbf{\\Sigma})$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps deriving the PCA eigenvector equation via Lagrange multipliers.",
      "orderItems": [
        "Formulate constrained optimization problem: maximize w^T Sigma w subject to w^T w = 1",
        "Construct the Lagrangian function: L(w, lambda) = w^T Sigma w - lambda * (w^T w - 1)",
        "Differentiate Lagrangian with respect to vector w: grad_w L = 2 * Sigma * w - 2 * lambda * w = 0",
        "Rearrange first-order condition into standard matrix eigenvalue equation: Sigma * w = lambda * w",
        "Pre-multiply by w^T to show variance Var(Z) = w^T Sigma w = lambda, proving max variance requires the largest eigenvalue lambda_1"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each PCA mathematical object to its geometric role.",
      "matchPairs": [
        { "left": "Eigenvector w_k (Loadings)", "right": "Direction cosines of the k-th principal axis in p-dimensional space" },
        { "left": "Eigenvalue lambda_k", "right": "Variance of the data points projected along the k-th principal axis" },
        { "left": "PC Score Z_k = w_k^T (x - mu)", "right": "Coordinate location of an individual observation on the new orthogonal axis" },
        { "left": "Total Trace Tr(Sigma)", "right": "Sum of original feature variances sum Var(X_i) = sum lambda_k" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Principal Components of 2D Symmetric Covariance Matrix",
      "interactiveSteps": [
        {
          "stepText": "Consider 2D covariance matrix Sigma = [[3, 1], [1, 3]]. The characteristic polynomial is det(Sigma - lambda I) = (3 - lambda)^2 - 1 = 0."
        },
        {
          "prompt": "What are the eigenvalues lambda_1 and lambda_2 in decreasing order?",
          "options": [
            { "text": "lambda_1 = 4 and lambda_2 = 2", "isCorrect": true },
            { "text": "lambda_1 = 3 and lambda_2 = 1", "isCorrect": false },
            { "text": "lambda_1 = 9 and lambda_2 = 1", "isCorrect": false },
            { "text": "lambda_1 = 5 and lambda_2 = 0", "isCorrect": false }
          ]
        },
        {
          "stepText": "For lambda_1 = 4, (Sigma - 4I)w = [[-1, 1], [1, -1]]w = 0 => w_1 = [1/sqrt(2), 1/sqrt(2)]^T, capturing 4/(4+2) = 66.7% of total variance along the 45-degree line!"
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What statistical adjective describes the relationship between any two distinct principal components Z_j and Z_k where Cov(Z_j, Z_k) = 0?",
      "blankAnswer": "uncorrelated"
    }
  ]
}
```
