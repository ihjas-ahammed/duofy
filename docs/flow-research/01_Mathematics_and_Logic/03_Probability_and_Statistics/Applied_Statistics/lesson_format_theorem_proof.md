# Duofy Reusable Lesson Format: Applied Statistics - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Applied_Statistics`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through core applied statistics derivations: Gauss-Markov Theorem (minimizing variance among linear unbiased estimators), Normal Equations for OLS, and PCA Variance Maximization.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gauss-Markov Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Variance Minimization Proof Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Homoscedasticity Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive PCA Eigenvector Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | OLS Unbiasedness Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The Gauss-Markov Theorem**\nConsider linear model $\\mathbf{y} = X \\boldsymbol{\\beta} + \\boldsymbol{\\epsilon}$ with $E[\\boldsymbol{\\epsilon}] = \\mathbf{0}$ and $\\text{Var}(\\boldsymbol{\\epsilon}) = \\sigma^2 I_n$.\nFor any linear combination $c^T \\boldsymbol{\\beta}$, the OLS estimator $c^T \\hat{\\boldsymbol{\\beta}}_{\\text{OLS}}$ has the **smallest variance** among all linear unbiased estimators:\n$$\n\\text{Var}(c^T \\hat{\\boldsymbol{\\beta}}_{\\text{OLS}}) \\le \\text{Var}(c^T \\tilde{\\boldsymbol{\\beta}})\n$$\nwhere $\\tilde{\\boldsymbol{\\beta}} = C \\mathbf{y}$ is any other linear unbiased estimator."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove the Gauss-Markov Theorem.",
      "orderItems": [
        "Let β_tilde = C y = ( (X^T X)^(-1) X^T + D ) y be an arbitrary linear estimator.",
        "Require unbiasedness E[β_tilde] = β: E[ ( (X^T X)^(-1) X^T + D ) (X β + ε) ] = β + D X β = β.",
        "Conclude matrix D must satisfy D X = 0 for unbiasedness.",
        "Compute covariance matrix Var(β_tilde) = σ² ( (X^T X)^(-1) X^T + D ) ( (X^T X)^(-1) X^T + D )^T.",
        "Expand product using D X = 0: Var(β_tilde) = σ² (X^T X)^(-1) + σ² D D^T = Var(β_hat_OLS) + σ² D D^T.",
        "Since D D^T is positive semi-definite, Var(c^T β_tilde) ≥ Var(c^T β_hat_OLS), proving BLUE."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What regression assumption is violated when the error variance $\\text{Var}(\\epsilon_i) = \\sigma_i^2$ is not constant across all observations (**Heteroscedasticity**)?",
      "options": [
        { "text": "Homoscedasticity assumption is violated, making OLS no longer the minimum-variance BLUE estimator", "isCorrect": true, "explanation": "Correct! Heteroscedasticity invalidates Gauss-Markov; Weighted Least Squares (WLS) should be used." },
        { "text": "Linearity is violated", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Unbiasedness is lost", "isCorrect": false, "explanation": "Incorrect: OLS remains unbiased, but loses efficiency." },
        { "text": "Sample size becomes 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: PCA Eigenvector Derivation",
      "interactiveSteps": [
        { "stepText": "We wish to maximize variance $\\text{Var}(u^T X) = u^T \\Sigma u$ subject to unit norm $u^T u = 1$." },
        {
          "prompt": "Set up Lagrangian $L(u, \\lambda) = u^T \\Sigma u - \\lambda (u^T u - 1)$. Setting $\\nabla_u L = 0$ yields what matrix eigenvalue equation?",
          "options": [
            { "text": "Σ u = λ u", "isCorrect": true },
            { "text": "Σ u = 0", "isCorrect": false },
            { "text": "u^T u = λ", "isCorrect": false },
            { "text": "Σ = I", "isCorrect": false }
          ]
        },
        { "stepText": "Thus principal components are the eigenvectors of sample covariance matrix $\\Sigma$, ordered by largest eigenvalue $\\lambda$!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What acronym describes OLS as the Best Linear Unbiased Estimator?",
      "blankAnswer": "blue"
    }
  ]
}
```
