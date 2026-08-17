# Duofy Reusable Lesson Format: Likelihood Function, Log-Likelihood, and Score Equations

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Statistical_Inference / Parametric_and_Nonparametric_Estimation / MLE_Maximum_Likelihood`  
**Lesson Format Type:** `likelihood_function_and_score_equations`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the formulation of the **Likelihood Function** $L(\theta \mid \mathbf{x}) = \prod f(x_i \mid \theta)$ and **Log-Likelihood** $\ell(\theta) = \sum \ln f(x_i \mid \theta)$, evaluate the **Score Function** $S(\theta) = \nabla \ell(\theta)$, prove that the expected score is zero ($\mathbb{E}[S(\theta)] = 0$), and calculate analytical MLEs for exponential families.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Likelihood & Score Equation Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Expected Score Zero Identity Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Functional Invariance Property of MLE Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Normal Variance MLE Analytical Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Score Function Identity Expectation Value Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of the Likelihood function for independent identically distributed (i.i.d.) data $X_1, \dots, X_n \sim f(x \mid \theta)$: $L(\theta \mid \mathbf{x}) = \prod_{i=1}^n f(x_i \mid \theta)$. Define the Log-Likelihood function $\ell(\theta) = \ln L(\theta \mid \mathbf{x}) = \sum_{i=1}^n \ln f(x_i \mid \theta)$. Define the Score function $S(\theta) = \frac{\partial \ell(\theta)}{\partial \theta}$. The Maximum Likelihood Estimator (MLE) $\hat{\theta}_{\text{MLE}}$ satisfies the score equation $S(\hat{\theta}) = 0$ (with second derivative $\ell''(\hat{\theta}) < 0$).
2. **Slide 2 (`ordering`):** Provide 5 steps proving that the expected score is zero ($\mathbb{E}_\theta[S(\theta)] = 0$): (1) start from the total probability normalization identity $\int f(x \mid \theta) dx = 1$, (2) differentiate both sides with respect to $\theta$: $\frac{\partial}{\partial \theta} \int f(x \mid \theta) dx = \frac{\partial}{\partial \theta}(1) = 0$, (3) swap derivative and integral (by Leibniz rule under regularity): $\int \frac{\partial f(x \mid \theta)}{\partial \theta} dx = 0$, (4) rewrite the integrand using the log derivative identity $\frac{\partial f}{\partial \theta} = f(x \mid \theta) \frac{\partial \ln f(x \mid \theta)}{\partial \theta}$, (5) express as an expectation: $\int \left(\frac{\partial \ln f(x \mid \theta)}{\partial \theta}\right) f(x \mid \theta) dx = \mathbb{E}_\theta\left[ \frac{\partial \ln f(X \mid \theta)}{\partial \theta} \right] = 0$.
3. **Slide 3 (`quiz`):** Test the Functional Invariance Property of MLE (Zehm's Theorem): If $\hat{\theta}$ is the MLE of parameter $\theta$, what is the MLE of transformed quantity $g(\theta) = e^{2\theta}$? ($\widehat{g(\theta)} = g(\hat{\theta}) = e^{2\hat{\theta}}$).
4. **Slide 4 (`proof`):** Interactive derivation for $X_1, \dots, X_n \sim \mathcal{N}(\mu, \sigma^2)$, setting $\frac{\partial \ell}{\partial \sigma^2} = -\frac{n}{2\sigma^2} + \frac{1}{2\sigma^4}\sum (x_i - \mu)^2 = 0 \implies \hat{\sigma}^2_{\text{MLE}} = \frac{1}{n}\sum_{i=1}^n (x_i - \bar{x})^2$ (showing that MLE produces the biased $1/n$ divisor rather than $1/(n-1)$).
5. **Slide 5 (`one_word`):** Plain-text recall of the expected numerical value of the score function $\mathbb{E}_\theta[S(\theta)]$ (zero).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "likelihood_function_and_score_equations",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: The Likelihood Function and Score Equations**\n• For i.i.d. observations $\\mathbf{x} = (x_1, \\dots, x_n)$ drawn from density $f(x \\mid \\theta)$:\n• **The Likelihood & Log-Likelihood Functions:**\n$$\nL(\\theta \\mid \\mathbf{x}) = \\prod_{i=1}^n f(x_i \\mid \\theta), \\qquad \\ell(\\theta) = \\ln L(\\theta \\mid \\mathbf{x}) = \\sum_{i=1}^n \\ln f(x_i \\mid \\theta)\n$$\n• **The Score Function:** Gradient of the log-likelihood:\n$$\nS(\\theta) = \\frac{\\partial \\ell(\\theta)}{\\partial \\theta} = \\sum_{i=1}^n \\frac{\\partial \\ln f(x_i \\mid \\theta)}{\\partial \\theta}\n$$\n• **The Maximum Likelihood Estimator (MLE):** Parameter value $\\hat{\\theta}_{\\text{MLE}}$ satisfying the first-order stationarity condition:\n$$\nS(\\hat{\\theta}) = 0 \\quad \\text{with} \\quad \\left. \\frac{\\partial^2 \\ell}{\\partial \\theta^2} \\right|_{\\hat{\\theta}} < 0\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps establishing that the expected score is identically zero: E_theta[S(theta)] = 0.",
      "orderItems": [
        "Start with the fundamental probability normalization identity: int f(x | theta) dx = 1",
        "Differentiate both sides with respect to parameter theta: d/dtheta int f(x | theta) dx = d/dtheta (1) = 0",
        "Interchange differentiation and integration by regularity: int [partial f(x | theta) / partial theta] dx = 0",
        "Apply the logarithmic derivative trick: partial f / partial theta = f(x | theta) * [partial ln f(x | theta) / partial theta]",
        "Recognize the definition of mathematical expectation: int [partial ln f(x | theta) / partial theta] f(x | theta) dx = E_theta[S_1(theta)] = 0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the Functional Invariance Property (Zehm's Theorem) of Maximum Likelihood Estimators?",
      "options": [
        { "text": "If theta_hat is the MLE of theta, then for ANY function g(theta), the MLE of g(theta) is simply g(theta_hat): widehat{g(theta)} = g(theta_hat)", "isCorrect": true, "explanation": "Correct! Unlike unbiased estimators, MLEs possess functional invariance under any transformation, even non-linear or non-invertible mappings." },
        { "text": "MLEs are only invariant under linear transformations", "isCorrect": false, "explanation": "Incorrect: Invariance holds for all functions." },
        { "text": "g(theta_hat) is always an unbiased estimator of g(theta)", "isCorrect": false, "explanation": "Incorrect: Invariance applies to likelihood maximization, not unbiasedness." },
        { "text": "Invariance holds only for normal distributions", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Maximum Likelihood Estimator of Normal Variance sigma^2",
      "interactiveSteps": [
        {
          "stepText": "For X_1, ..., X_n ~ N(mu, sigma^2), the log-likelihood is ell(mu, sigma^2) = -n/2 ln(2 pi) - n/2 ln(sigma^2) - 1/(2 sigma^2) sum (x_i - mu)^2."
        },
        {
          "prompt": "Differentiating with respect to v = sigma^2 and setting to zero, what is the resulting score equation?",
          "options": [
            { "text": "-n / (2 v) + 1 / (2 v^2) sum (x_i - mu)^2 = 0", "isCorrect": true },
            { "text": "-n / v = 0", "isCorrect": false },
            { "text": "sum (x_i - mu) = 0", "isCorrect": false },
            { "text": "v = n", "isCorrect": false }
          ]
        },
        {
          "stepText": "Multiplying by 2 v^2 / n yields sigma_hat^2_MLE = (1/n) sum_{i=1}^n (x_i - x_bar)^2, illustrating that the MLE is slightly biased with divisor n rather than n-1."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the numerical expected value of the score function E_theta[S(theta)] under the true parameter theta?",
      "blankAnswer": "zero"
    }
  ]
}
```
