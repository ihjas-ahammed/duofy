# Duofy Reusable Lesson Format: Statistical Inference - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Statistical_Inference`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through foundational inference proofs: Neyman-Pearson Lemma, Rao-Blackwell Variance Reduction Theorem, and Cramér-Rao Inequality Proof.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Rao-Blackwell Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Conditional Variance Proof Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Minimal Sufficient Statistic Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Neyman-Pearson Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Variance Reduction Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The Rao-Blackwell Theorem**\nLet $h(X)$ be an unbiased estimator of $\\theta$, and $T(X)$ a **sufficient statistic** for $\\theta$.\nDefine the conditioned estimator $\\phi(T) = E[h(X) \\mid T(X)]$. Then:\n$$\nE[\\phi(T)] = \\theta \\quad \\text{and} \\quad \\text{Var}(\\phi(T)) \\le \\text{Var}(h(X))\n$$\nConditioning an unbiased estimator on a sufficient statistic strictly decreases (or preserves) variance!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove the Rao-Blackwell Theorem using Law of Total Variance.",
      "orderItems": [
        "Let ϕ(T) = E[h(X) | T]. Use Law of Total Expectation: E[ϕ(T)] = E[E[h(X) | T]] = E[h(X)] = θ.",
        "Apply Law of Total Variance to estimator h(X): Var(h(X)) = E[Var(h(X) | T)] + Var(E[h(X) | T]).",
        "Substitute ϕ(T) into equation: Var(h(X)) = E[Var(h(X) | T)] + Var(ϕ(T)).",
        "Since conditional variance Var(h(X) | T) ≥ 0, its expectation E[Var(h(X) | T)] ≥ 0.",
        "Conclude Var(ϕ(T)) ≤ Var(h(X)), proving variance reduction."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What does the Lehmann-Scheffé Theorem add to Rao-Blackwell when $T(X)$ is a **complete** sufficient statistic?",
      "options": [
        { "text": "ϕ(T) = E[h(X) | T] is the UNIQUE Uniformly Minimum Variance Unbiased Estimator (UMVUE)", "isCorrect": true, "explanation": "Correct! Completeness guarantees uniqueness of the optimal UMVUE estimator." },
        { "text": "Variance becomes zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Fisher Information becomes negative", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Sample size becomes infinite", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Cauchy-Schwarz for Cramér-Rao Bound",
      "interactiveSteps": [
        { "stepText": "Consider unbiased estimator $T(X)$ with $E_\theta[T(X)] = \\theta$. Differentiate w.r.t. $\\theta$: $\\int T(x) \\frac{\\partial f(x;\\theta)}{\\partial \\theta} dx = 1$." },
        {
          "prompt": "Rewrite derivative using score function $S = \\frac{\\partial \\ln f(x;\\theta)}{\\partial \\theta}$: $\\text{Cov}(T, S) = $?",
          "options": [
            { "text": "1", "isCorrect": true },
            { "text": "0", "isCorrect": false },
            { "text": "θ", "isCorrect": false },
            { "text": "n", "isCorrect": false }
          ]
        },
        { "stepText": "Applying Cauchy-Schwarz $|\\text{Cov}(T, S)|^2 \\le \\text{Var}(T) \\text{Var}(S)$ yields $\\text{Var}(T) \\ge \\frac{1}{I(\\theta)}$!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What property of a sufficient statistic T guarantees that E[g(T)] = 0 for all θ implies g(T) = 0 a.s.?",
      "blankAnswer": "complete"
    }
  ]
}
```
