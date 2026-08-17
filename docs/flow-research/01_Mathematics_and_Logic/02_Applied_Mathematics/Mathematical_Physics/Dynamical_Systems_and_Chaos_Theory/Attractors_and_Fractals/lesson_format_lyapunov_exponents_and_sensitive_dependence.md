# Duofy Reusable Lesson Format: Lyapunov Exponents, Sensitive Dependence, and the Kaplan-Yorke Conjecture

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics / Dynamical_Systems_and_Chaos_Theory / Attractors_and_Fractals`  
**Lesson Format Type:** `lyapunov_exponents_and_sensitive_dependence`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the definition and calculation of **Lyapunov Exponents** $\lambda = \lim_{t\to\infty} \frac{1}{t}\ln \frac{\|\delta(t)\|}{\|\delta_0\|}$, compute the **Lyapunov Time** $\tau_L = 1/\lambda_1$, establish the condition for deterministic chaos ($\lambda_1 > 0$), and evaluate the **Kaplan-Yorke (Lyapunov) Dimension** $D_{KY} = k + \frac{\sum_{i=1}^k \lambda_i}{|\lambda_{k+1}|}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Lyapunov Exponent & Kaplan-Yorke Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Logistic Map Lyapunov Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Zero Lyapunov Exponent Along Flow Direction Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Kaplan-Yorke Dimension Calculation Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Chaotic Hallmark Exponent Sign Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of the Maximal Lyapunov Exponent: $\lambda_1 = \lim_{t \to \infty} \frac{1}{t} \ln \frac{\|\delta \mathbf{x}(t)\|}{\|\delta \mathbf{x}_0\|}$, where separation grows as $\|\delta(t)\| \approx \|\delta_0\| e^{\lambda_1 t}$. A system is chaotic if and only if $\lambda_1 > 0$. State the Kaplan-Yorke Conjecture: The fractal dimension of the attractor is $D_{KY} = k + \frac{\sum_{i=1}^k \lambda_i}{|\lambda_{k+1}|}$, where $k$ is the maximum integer such that $\sum_{i=1}^k \lambda_i \ge 0$.
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the Lyapunov exponent for the 1D discrete map $x_{n+1} = f(x_n)$: (1) write separation $\delta x_n = x_n' - x_n$ after $n$ iterations, (2) linearize: $\delta x_n \approx \left(\prod_{j=0}^{n-1} f'(x_j)\right) \delta x_0$, (3) take the natural logarithm: $\ln \frac{|\delta x_n|}{|\delta x_0|} = \sum_{j=0}^{n-1} \ln |f'(x_j)|$, (4) divide by $n$ and take limit $n \to \infty$: $\lambda = \lim_{n \to \infty} \frac{1}{n} \sum_{j=0}^{n-1} \ln |f'(x_j)|$, (5) for an ergodic attractor with invariant measure $\mu$, evaluate as the spatial integral $\lambda = \int \ln |f'(x)| d\mu(x)$.
3. **Slide 3 (`quiz`):** Test why any continuous, non-equilibrium ODE system with a bounded attractor must have at least one Lyapunov exponent equal to ZERO: (Along the tangent direction of the flow trajectory, perturbations neither grow nor shrink exponentially because time shifts $x(t + \delta t)$ simply shift along the same invariant orbit, giving $\lambda = 0$).
4. **Slide 4 (`proof`):** Interactive derivation calculating the Kaplan-Yorke dimension for the Lorenz system with Lyapunov exponents $\lambda_1 = 0.9056, \lambda_2 = 0.0000, \lambda_3 = -14.5723$: $k=2$ since $\lambda_1 + \lambda_2 = 0.9056 \ge 0$, and $D_{KY} = 2 + \frac{0.9056}{|-14.5723|} = 2 + 0.0621 = 2.0621$.
5. **Slide 5 (`one_word`):** Plain-text recall of the mathematical sign (positive/negative) required of the largest Lyapunov exponent for a system to exhibit deterministic chaos (positive).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "lyapunov_exponents_and_sensitive_dependence",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Lyapunov Exponents and the Kaplan-Yorke Dimension**\n• For an initial perturbation $\\delta \\mathbf{x}_0$, the separation between nearby trajectories evolves as $\\|\\delta \\mathbf{x}(t)\\| \\approx \\|\\delta \\mathbf{x}_0\\| e^{\\lambda_1 t}$.\n• The **Maximal Lyapunov Exponent (MLE)** is:\n$$\n\\lambda_1 = \\lim_{t \\to \\infty} \\frac{1}{t} \\ln \\frac{\\|\\delta \\mathbf{x}(t)\\|}{\\|\\delta \\mathbf{x}_0\\|}\n$$\n• **The Definition of Chaos:** A bounded deterministic system is **chaotic** $\\iff \\lambda_1 > 0$.\n• **Kaplan-Yorke (Lyapunov) Dimension $D_{KY}$:** For ordered spectrum $\\lambda_1 \\ge \\lambda_2 \\ge \\dots \\ge \\lambda_n$:\n$$\nD_{KY} = k + \\frac{\\sum_{i=1}^k \\lambda_i}{|\\lambda_{k+1}|}, \\quad \\text{where } k = \\max \\left\\{ j \\;\\middle|\\; \\sum_{i=1}^j \\lambda_i \\ge 0 \\right\\}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical mathematical steps deriving the Lyapunov exponent for a 1D discrete iterated map x_{n+1} = f(x_n).",
      "orderItems": [
        "Express the n-th iterate of an infinitesimal perturbation: delta x_n = (df^n / dx)(x_0) * delta x_0",
        "Apply the chain rule to expand the derivative along the orbit: df^n/dx = prod_{j=0}^{n-1} f'(x_j)",
        "Take the natural logarithm of the product to convert it into a sum: ln |delta x_n / delta x_0| = sum_{j=0}^{n-1} ln |f'(x_j)|",
        "Divide by n and take the limit as n -> infty: lambda = lim_{n -> infty} (1/n) sum_{j=0}^{n-1} ln |f'(x_j)|",
        "By Birkhoff's Ergodic Theorem, replace the time average with the phase space integral lambda = int ln |f'(x)| dmu(x) against the invariant measure"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "For ANY continuous autonomous ODE system dx/dt = f(x) on an attractor that is NOT a fixed point, why is at least ONE Lyapunov exponent GUARANTEED to equal exactly zero (lambda = 0)?",
      "options": [
        { "text": "Perturbations directed tangent to the trajectory flow represent a pure time shift x(t + delta t), neither expanding nor contracting exponentially along the orbit", "isCorrect": true, "explanation": "Correct! Flow along the trajectory neither expands nor contracts in length, guaranteeing a zero exponent in the direction of the velocity vector." },
        { "text": "Because the system is linear", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because all Lyapunov exponents are zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the flow stops", "isCorrect": false, "explanation": "Incorrect: Non-equilibrium attractors never stop." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Kaplan-Yorke Dimension of the Lorenz Attractor",
      "interactiveSteps": [
        {
          "stepText": "The Lorenz attractor has Lyapunov exponents lambda_1 = +0.9056, lambda_2 = 0.0000, and lambda_3 = -14.5723."
        },
        {
          "prompt": "Identify the integer k such that sum_{i=1}^k lambda_i >= 0 but sum_{i=1}^{k+1} lambda_i < 0.",
          "options": [
            { "text": "k = 2 (since lambda_1 + lambda_2 = +0.9056 >= 0 and lambda_1 + lambda_2 + lambda_3 = -13.6667 < 0)", "isCorrect": true },
            { "text": "k = 1", "isCorrect": false },
            { "text": "k = 3", "isCorrect": false },
            { "text": "k = 0", "isCorrect": false }
          ]
        },
        {
          "stepText": "Substituting into D_{KY} = 2 + (0.9056 + 0) / |-14.5723| = 2 + 0.0621 = 2.0621, proving the attractor has a non-integer fractal dimension."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What mathematical sign (positive or negative) must the maximal Lyapunov exponent have for a system to be mathematically chaotic?",
      "blankAnswer": "positive"
    }
  ]
}
```
