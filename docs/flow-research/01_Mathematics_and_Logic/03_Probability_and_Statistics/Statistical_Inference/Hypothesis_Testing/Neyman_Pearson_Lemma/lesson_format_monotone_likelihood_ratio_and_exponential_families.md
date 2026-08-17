# Duofy Reusable Lesson Format: Monotone Likelihood Ratio and Exponential Families

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Statistical_Inference / Hypothesis_Testing / Neyman_Pearson_Lemma`  
**Lesson Format Type:** `monotone_likelihood_ratio_and_exponential_families`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to verify the **Monotone Likelihood Ratio (MLR)** property for statistical distribution families, prove that all 1-parameter canonical **Exponential Families** $f(x \mid \theta) = h(x) \exp(\eta(\theta) T(x) - A(\theta))$ possess MLR in $T(x)$, and calculate power functions $\beta(\theta)$ analytically.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | MLR Definition & Exponential Family Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Exponential Family MLR Proof Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Distribution Family & MLR Sufficient Statistic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical Poisson UMP Critical Value Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Monotone Likelihood Ratio Verification Derivative Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of Monotone Likelihood Ratio: A family of parametric densities $\{f(x \mid \theta) \mid \theta \in \Theta \subseteq \mathbb{R}\}$ has MLR in statistic $T(x)$ if for any $\theta_1 < \theta_2$, the likelihood ratio $\frac{f(x \mid \theta_2)}{f(x \mid \theta_1)}$ is a non-decreasing function of $T(x)$. State Theorem for 1-parameter Exponential Families: If $f(x \mid \theta) = h(x) \exp(\eta(\theta) T(x) - A(\theta))$ where $\eta(\theta)$ is a strictly increasing function of $\theta$, then the family has strictly increasing MLR in $T(x)$.
2. **Slide 2 (`concept_pieces`):** Deconstruct: (1) form the ratio $\frac{f(x \mid \theta_2)}{f(x \mid \theta_1)} = \frac{h(x)\exp(\eta(\theta_2)T(x) - A(\theta_2))}{h(x)\exp(\eta(\theta_1)T(x) - A(\theta_1))}$, (2) simplify: $\exp\left( (\eta(\theta_2) - \eta(\theta_1)) T(x) - (A(\theta_2) - A(\theta_1)) \right)$, (3) since $\theta_2 > \theta_1$ and $\eta$ is strictly increasing, the slope $\eta(\theta_2) - \eta(\theta_1) > 0$ is strictly positive, (4) exponential of a positive constant times $T(x)$ is strictly increasing in $T(x)$, proving MLR!
3. **Slide 3 (`matching`):** Pair 4 common distributions (Normal $\mathcal{N}(\mu, \sigma_0^2)$, Poisson $\operatorname{Pois}(\lambda)$, Bernoulli $\operatorname{Bern}(p)$, Exponential $\operatorname{Exp}(\lambda)$) with their natural MLR statistics $T(X)$.
4. **Slide 4 (`numerical`):** Ask student: For $X \sim \operatorname{Pois}(\lambda)$, we test $H_0: \lambda \le 1.0$ vs $H_1: \lambda > 1.0$. What is the critical integer value $c$ such that $P(X \ge c \mid \lambda = 1.0) \le 0.05$ (using Poisson CDF values: $P(X \le 2) = 0.9197, P(X \le 3) = 0.9810 \implies P(X \ge 3) = 0.0803, P(X \ge 4) = 0.0190$)? The critical threshold for a non-randomized test of size $\le 0.05$ is $c = 4.0$ (numeric answer: 4.0).
5. **Slide 5 (`quiz`):** Quiz on Cauchy distribution failure: Why does the location-scale Cauchy distribution $f(x \mid \theta) = \frac{1}{\pi(1 + (x - \theta)^2)}$ FAIL to have the Monotone Likelihood Ratio property? (Because the ratio $\frac{1 + (x - \theta_1)^2}{1 + (x - \theta_2)^2} \to 1$ as $x \to \pm\infty$, meaning the likelihood ratio rises and falls, violating monotonicity).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "monotone_likelihood_ratio_and_exponential_families",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Monotone Likelihood Ratio (MLR) in Exponential Families**\n• **Definition:** A 1D parametric family $\\{f(\\mathbf{x} \\mid \\theta)\\}$ has **MLR in statistic $T(\\mathbf{x})$** if for any $\\theta_1 < \\theta_2$, the likelihood ratio:\n$$\n\\frac{f(\\mathbf{x} \\mid \\theta_2)}{f(\\mathbf{x} \\mid \\theta_1)} = g(T(\\mathbf{x}))\n$$\nis a non-decreasing (monotonic) function of $T(\\mathbf{x})$.\n• **Theorem (1-Parameter Exponential Families):**\n  Let $f(\\mathbf{x} \\mid \\theta) = h(\\mathbf{x}) \\exp\\left( \\eta(\\theta) T(\\mathbf{x}) - A(\\theta) \\right)$.\n  If $\\eta(\\theta)$ is a **strictly increasing** function of $\\theta$, then the family has strictly increasing MLR in $T(\\mathbf{X})$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Form Likelihood Ratio):**\n  $$\\frac{f(\\mathbf{x} \\mid \\theta_2)}{f(\\mathbf{x} \\mid \\theta_1)} = \\frac{h(\\mathbf{x}) e^{\\eta(\\theta_2)T(\\mathbf{x}) - A(\\theta_2)}}{h(\\mathbf{x}) e^{\\eta(\\theta_1)T(\\mathbf{x}) - A(\\theta_1)}}$$\n• **Step 2 (Cancel $h(\\mathbf{x})$):**\n  $$= \\exp\\left( [\\eta(\\theta_2) - \\eta(\\theta_1)] T(\\mathbf{x}) - [A(\\theta_2) - A(\\theta_1)] \\right)$$\n• **Step 3 (Sign of Coefficient):** Since $\\theta_2 > \\theta_1$ and $\\eta$ is strictly increasing, $\\Delta \\eta = \\eta(\\theta_2) - \\eta(\\theta_1) > 0$.\n• **Step 4 (Monotonicity Conclusion):** The exponent is a linear function of $T(\\mathbf{x})$ with strictly positive slope $\\Delta \\eta > 0$, guaranteeing that the ratio is strictly increasing in $T(\\mathbf{x})$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each standard distribution family to its natural MLR sufficient statistic T(X).",
      "matchPairs": [
        { "left": "Normal Mean N(mu, sigma_0^2)", "right": "T(X) = sum_{i=1}^n X_i (sample sum / sample mean)" },
        { "left": "Poisson Rate Pois(lambda)", "right": "T(X) = sum_{i=1}^n X_i (total count of events)" },
        { "left": "Bernoulli Success Probability Bern(p)", "right": "T(X) = sum_{i=1}^n X_i (total number of successes)" },
        { "left": "Normal Variance N(mu_0, sigma^2)", "right": "T(X) = sum_{i=1}^n (X_i - mu_0)^2" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "For X ~ Pois(lambda), testing H_0: lambda <= 1.0 vs H_1: lambda > 1.0. Given P(X >= 3 | lambda=1) = 0.0803 and P(X >= 4 | lambda=1) = 0.0190, what is the smallest integer threshold c for a non-randomized UMP test with size alpha <= 0.05?",
      "numericAnswer": 4.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the standard Cauchy distribution f(x | theta) = 1 / (pi * (1 + (x - theta)^2)) FAIL to possess the Monotone Likelihood Ratio property?",
      "options": [
        { "text": "As x -> +/- infty, the likelihood ratio f(x | theta_2) / f(x | theta_1) -> 1, meaning the ratio increases in the middle but bends back to 1 at infinity, violating global monotonicity", "isCorrect": true, "explanation": "Correct! Because Cauchy tails decay as 1/x^2, the ratio of two Cauchy densities is non-monotonic, meaning no standard one-sided UMP test exists." },
        { "text": "Because the Cauchy distribution has zero variance", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because theta cannot be negative", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because pi is irrational", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
