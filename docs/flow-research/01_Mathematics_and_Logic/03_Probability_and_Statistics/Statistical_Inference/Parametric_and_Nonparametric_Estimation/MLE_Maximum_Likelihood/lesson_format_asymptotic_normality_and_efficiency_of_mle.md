# Duofy Reusable Lesson Format: Asymptotic Normality and Efficiency of MLE

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Statistical_Inference / Parametric_and_Nonparametric_Estimation / MLE_Maximum_Likelihood`  
**Lesson Format Type:** `asymptotic_normality_and_efficiency_of_mle`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to evaluate the asymptotic properties of the **Maximum Likelihood Estimator**, prove **Consistency** ($\hat{\theta}_n \xrightarrow{p} \theta_0$) and **Asymptotic Normality** ($\sqrt{n}(\hat{\theta}_n - \theta_0) \xrightarrow{d} \mathcal{N}(0, I_1(\theta_0)^{-1})$), construct **Wald Confidence Intervals** ($\hat{\theta} \pm z_{\alpha/2} / \sqrt{I_n(\hat{\theta})}$), and evaluate the Delta Method.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Asymptotic Normality Theorem & Wald Interval Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Taylor Expansion Asymptotic Normality Proof Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Asymptotic Convergence Mode & Estimator Metric Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Uniform Distribution Support Boundary Regularity Failure Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 5** | Numerical Asymptotic Wald Margin of Error Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Asymptotic Normality Theorem for MLE: Under standard Cramér-Rao regularity conditions, as sample size $n \to \infty$: (1) Consistency: $\hat{\mathbf{\theta}}_n \xrightarrow{p} \mathbf{\theta}_0$, (2) Asymptotic Normality & Efficiency: $\sqrt{n}(\hat{\mathbf{\theta}}_n - \mathbf{\theta}_0) \xrightarrow{d} \mathcal{N}\left(\mathbf{0}, I_1(\mathbf{\theta}_0)^{-1}\right)$, (3) Asymptotic Wald $(1 - \alpha)$ Confidence Interval: $\hat{\theta} \pm z_{\alpha/2} \frac{1}{\sqrt{I_n(\hat{\theta})}} = \hat{\theta} \pm z_{\alpha/2} \frac{1}{\sqrt{n I_1(\hat{\theta})}}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 proof steps: (1) expand score $S_n(\hat{\theta}_n)$ via Taylor series around true $\theta_0$: $0 = S_n(\hat{\theta}_n) = S_n(\theta_0) + S_n'(\tilde{\theta})(\hat{\theta}_n - \theta_0)$, (2) rearrange terms: $\sqrt{n}(\hat{\theta}_n - \theta_0) = \frac{\frac{1}{\sqrt{n}} S_n(\theta_0)}{-\frac{1}{n} S_n'(\tilde{\theta})}$, (3) by Central Limit Theorem (CLT), numerator $\frac{1}{\sqrt{n}}\sum \frac{\partial \ln f(X_i)}{\partial \theta} \xrightarrow{d} \mathcal{N}(0, I_1(\theta_0))$, (4) by Law of Large Numbers (LLN), denominator $-\frac{1}{n} \sum \frac{\partial^2 \ln f(X_i)}{\partial \theta^2} \xrightarrow{p} I_1(\theta_0)$, (5) apply Slutsky's Theorem to conclude $\sqrt{n}(\hat{\theta}_n - \theta_0) \xrightarrow{d} \mathcal{N}(0, 1 / I_1(\theta_0))$.
3. **Slide 3 (`matching`):** Pair 4 asymptotic concepts (Consistency, Asymptotic Normality, Asymptotic Efficiency, Delta Method) with their mathematical definitions.
4. **Slide 4 (`quiz`):** Quiz on regularity condition failure for Uniform distribution $U(0, \theta)$: Why does $\hat{\theta}_{\text{MLE}} = \max(X_1, \dots, X_n)$ for $X_i \sim \operatorname{Uniform}(0, \theta)$ FAIL to have an asymptotically normal distribution? (The support $[0, \theta]$ depends directly on the parameter $\theta$, violating the derivative-integral interchange condition; the normalized error $n(\theta - \hat{\theta}_n) \xrightarrow{d} \operatorname{Exp}(1/\theta)$ follows an Exponential distribution, converging at rate $n$ rather than $\sqrt{n}$).
5. **Slide 5 (`numerical`):** Ask student: For a sample size $n = 100$ with estimated Fisher Information per observation $I_1(\hat{\theta}) = 4.0$ and critical value $z_{0.025} = 1.96$, what is the half-width margin of error $E = 1.96 / \sqrt{n I_1} = 1.96 / \sqrt{400} = 1.96 / 20 = 0.098$ rounded to two decimal places? (numeric answer: 0.10).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "asymptotic_normality_and_efficiency_of_mle",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Asymptotic Normality and Efficiency of the MLE**\nUnder Cramér regularity conditions, as sample size $n \\to \\infty$:\n• **Consistency:** $\\hat{\\mathbf{\\theta}}_n \\xrightarrow{p} \\mathbf{\\theta}_0$ (converges in probability to the true parameter).\n• **Asymptotic Normality:**\n$$\n\\sqrt{n}(\\hat{\\mathbf{\\theta}}_n - \\mathbf{\\theta}_0) \\xrightarrow{d} \\mathcal{N}\\left( \\mathbf{0}, \\; I_1(\\mathbf{\\theta}_0)^{-1} \\right)\n$$\n• **Asymptotic Efficiency:** The asymptotic variance of the MLE attains the **Cramér-Rao Lower Bound** ($1 / n I_1(\\theta_0)$), proving that no consistent estimator can achieve smaller asymptotic variance.\n• **Wald $(1-\\alpha)$ Confidence Interval:**\n$$\n\\hat{\\theta}_n \\pm z_{\\alpha/2} \\frac{1}{\\sqrt{n I_1(\\hat{\\theta}_n)}} = \\hat{\\theta}_n \\pm z_{\\alpha/2} \\frac{1}{\\sqrt{I_n(\\hat{\\theta}_n)}}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Taylor Expansion):** Expand the score around $\\theta_0$:\n  $$0 = S_n(\\hat{\\theta}_n) = S_n(\\theta_0) + S_n'(\\tilde{\\theta})(\\hat{\\theta}_n - \\theta_0)$$\n• **Step 2 (Rearrange):**\n  $$\\sqrt{n}(\\hat{\\theta}_n - \\theta_0) = \\frac{\\frac{1}{\\sqrt{n}} S_n(\\theta_0)}{-\\frac{1}{n} S_n'(\\tilde{\\theta})}$$\n• **Step 3 (Numerator via CLT):** Since $\\mathbb{E}[S_1] = 0$ and $\\operatorname{Var}(S_1) = I_1(\\theta_0)$, the numerator converges to $\\mathcal{N}(0, I_1(\\theta_0))$.\n• **Step 4 (Denominator via LLN):** $-\\frac{1}{n} S_n'(\\tilde{\\theta}) \\xrightarrow{p} -\\mathbb{E}[\\ell''(\\theta_0)] = I_1(\\theta_0)$.\n• **Step 5 (Slutsky's Theorem):** $\\frac{\\mathcal{N}(0, I_1)}{I_1} \\sim \\mathcal{N}(0, 1/I_1)$, establishing asymptotic normality!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each asymptotic property of maximum likelihood estimators to its mathematical description.",
      "matchPairs": [
        { "left": "Consistency", "right": "P(|theta_hat_n - theta_0| > eps) -> 0 as n -> infty" },
        { "left": "Asymptotic Normality", "right": "sqrt(n)(theta_hat_n - theta_0) -> N(0, I_1(theta_0)^{-1}) in distribution" },
        { "left": "Asymptotic Efficiency", "right": "Asymptotic variance achieves CRLB lower bound 1 / (n I_1)" },
        { "left": "Delta Method", "right": "sqrt(n)(g(theta_hat) - g(theta_0)) -> N(0, [g'(theta_0)]^2 / I_1)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "quiz",
      "content": "For i.i.d. observations X_1, ..., X_n ~ Uniform(0, theta), why does the MLE theta_hat = max(X_1, ..., X_n) FAIL to follow an asymptotic normal distribution?",
      "options": [
        { "text": "The support [0, theta] depends on the parameter theta, violating the regularity condition of derivative-integral interchange; the normalized error n(theta - theta_hat) converges to an EXPONENTIAL distribution at super-fast rate n", "isCorrect": true, "explanation": "Correct! Non-regular models where the boundary depends on theta have non-normal limiting distributions and converge at rate 1/n rather than 1/sqrt(n)." },
        { "text": "Because the maximum of a sample is always zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because uniform random variables are discrete", "isCorrect": false, "explanation": "Incorrect: Uniform is continuous." },
        { "text": "Because Fisher Information is infinite", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 5,
      "type": "numerical",
      "content": "For a sample of size n = 100 with estimated unit Fisher information I_1 = 4.0 and critical value z_{0.025} = 1.96, calculate the asymptotic 95% Wald margin of error E = 1.96 / sqrt(n * I_1) to two decimal places.",
      "numericAnswer": 0.10,
      "numericTolerance": 0.01
    }
  ]
}
```
