# Duofy Reusable Lesson Format: The Metropolis-Hastings Algorithm and Detailed Balance

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Statistical_Inference / Bayesian_Statistics / MCMC_and_Gibbs_Sampling`  
**Lesson Format Type:** `metropolis_hastings_and_detailed_balance`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the **Metropolis-Hastings Algorithm** (Metropolis 1953, Hastings 1970), prove that the acceptance probability $\alpha(\theta, \theta^*) = \min\left(1, \frac{\pi(\theta^*)q(\theta \mid \theta^*)}{\pi(\theta)q(\theta^* \mid \theta)}\right)$ satisfies **Detailed Balance**, and explain how MCMC bypasses the intractable Bayesian evidence integral $p(y)$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Metropolis-Hastings Acceptance Probability Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Detailed Balance Preservation Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Symmetric Proposal Random Walk Metropolis Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Normalizing Constant Cancellation Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Initial Discarded Iterations Burning Phase Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Metropolis-Hastings algorithm for target distribution $\pi(\theta) = p(\theta \mid y) \propto p(y \mid \theta) p(\theta)$: (1) at state $\theta^{(t)}$, sample candidate $\theta^* \sim q(\theta^* \mid \theta^{(t)})$, (2) compute acceptance probability $\alpha(\theta, \theta^*) = \min\left(1, \frac{\pi(\theta^*) q(\theta \mid \theta^*)}{\pi(\theta) q(\theta^* \mid \theta)}\right)$, (3) draw $u \sim \operatorname{Uniform}(0, 1)$; if $u \le \alpha$, accept $\theta^{(t+1)} = \theta^*$, else reject $\theta^{(t+1)} = \theta^{(t)}$. State the Detailed Balance Equation: $\pi(\theta) T(\theta \to \theta^*) = \pi(\theta^*) T(\theta^* \to \theta)$ for transition kernel $T(\theta \to \theta^*) = q(\theta^* \mid \theta) \alpha(\theta, \theta^*)$.
2. **Slide 2 (`ordering`):** Provide 5 steps proving Detailed Balance for $\theta \ne \theta^*$: (1) assume without loss of generality that $\pi(\theta^*) q(\theta \mid \theta^*) \le \pi(\theta) q(\theta^* \mid \theta)$, (2) evaluate the forward acceptance: $\alpha(\theta, \theta^*) = \frac{\pi(\theta^*) q(\theta \mid \theta^*)}{\pi(\theta) q(\theta^* \mid \theta)} \le 1$, (3) evaluate the backward acceptance: $\alpha(\theta^*, \theta) = \min(1, \text{inverse}) = 1$, (4) compute forward transition flux: $\pi(\theta) T(\theta \to \theta^*) = \pi(\theta) q(\theta^* \mid \theta) \left( \frac{\pi(\theta^*) q(\theta \mid \theta^*)}{\pi(\theta) q(\theta^* \mid \theta)} \right) = \pi(\theta^*) q(\theta \mid \theta^*)$, (5) compute backward transition flux: $\pi(\theta^*) T(\theta^* \to \theta) = \pi(\theta^*) q(\theta \mid \theta^*) (1)$, verifying $\pi(\theta) T(\theta \to \theta^*) = \pi(\theta^*) T(\theta^* \to \theta)$.
3. **Slide 3 (`quiz`):** Test the Random Walk Metropolis special case: What happens when the proposal distribution is symmetric ($q(\theta^* \mid \theta) = q(\theta \mid \theta^*)$, such as $\theta^* \sim \mathcal{N}(\theta, \sigma^2)$)? (The proposal densities cancel out, simplifying the acceptance probability to the pure likelihood-prior ratio $\alpha = \min\left(1, \frac{\pi(\theta^*)}{\pi(\theta)}\right)$).
4. **Slide 4 (`proof`):** Interactive derivation showing that substituting unnormalized posterior $\pi(\theta) = \frac{\tilde{\pi}(\theta)}{Z}$ where $Z = \int \tilde{\pi}(\theta) d\theta$ yields $\frac{\pi(\theta^*)}{\pi(\theta)} = \frac{\tilde{\pi}(\theta^*)/Z}{\tilde{\pi}(\theta)/Z} = \frac{\tilde{\pi}(\theta^*)}{\tilde{\pi}(\theta)}$, proving that the normalizing constant $Z$ cancels out.
5. **Slide 5 (`one_word`):** Plain-text recall of the term for the initial period of MCMC iterations discarded while the chain converges to its stationary distribution (burn-in / warmup).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "metropolis_hastings_and_detailed_balance",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Metropolis-Hastings Algorithm and Detailed Balance**\n• To sample from an unnormalized Bayesian posterior $\\pi(\\mathbf{\\theta}) = p(\\mathbf{\\theta} \\mid \\mathbf{y}) \\propto p(\\mathbf{y} \\mid \\mathbf{\\theta}) p(\\mathbf{\\theta})$:\n• **The Metropolis-Hastings Step:**\n  1. Draw candidate $\\mathbf{\\theta}^* \\sim q(\\mathbf{\\theta}^* \\mid \\mathbf{\\theta}^{(t)})$ from proposal distribution $q$.\n  2. Compute the **Acceptance Probability $\\alpha$**:\n$$\n\\alpha(\\mathbf{\\theta}, \\mathbf{\\theta}^*) = \\min\\left( 1, \\; \\frac{\\pi(\\mathbf{\\theta}^*) q(\\mathbf{\\theta} \\mid \\mathbf{\\theta}^*)}{\\pi(\\mathbf{\\theta}) q(\\mathbf{\\theta}^* \\mid \\mathbf{\\theta})} \\right) = \\min\\left( 1, \\; \\frac{p(\\mathbf{y} \\mid \\mathbf{\\theta}^*) p(\\mathbf{\\theta}^*) q(\\mathbf{\\theta} \\mid \\mathbf{\\theta}^*)}{p(\\mathbf{y} \\mid \\mathbf{\\theta}) p(\\mathbf{\\theta}) q(\\mathbf{\\theta}^* \\mid \\mathbf{\\theta})} \\right)\n$$\n  3. Accept $\\mathbf{\\theta}^{(t+1)} = \\mathbf{\\theta}^*$ with probability $\\alpha$; otherwise retain previous state $\\mathbf{\\theta}^{(t+1)} = \\mathbf{\\theta}^{(t)}$.\n• **Detailed Balance:** Satisfies $\\pi(\\mathbf{\\theta}) T(\\mathbf{\\theta} \\to \\mathbf{\\theta}^*) = \\pi(\\mathbf{\\theta}^*) T(\\mathbf{\\theta}^* \\to \\mathbf{\\theta})$, guaranteeing $\\pi$ is the exact stationary distribution."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps establishing that Metropolis-Hastings transitions satisfy Detailed Balance.",
      "orderItems": [
        "Assume without loss of generality that pi(theta*) q(theta | theta*) <= pi(theta) q(theta* | theta)",
        "Evaluate the forward acceptance ratio: alpha(theta, theta*) = [pi(theta*) q(theta | theta*)] / [pi(theta) q(theta* | theta)] <= 1",
        "Evaluate the reverse acceptance ratio: alpha(theta*, theta) = min(1, 1 / alpha(theta, theta*)) = 1",
        "Calculate the forward flux: pi(theta) * q(theta* | theta) * alpha(theta, theta*) = pi(theta*) * q(theta | theta*)",
        "Calculate the reverse flux: pi(theta*) * q(theta | theta*) * 1, confirming exact equality pi(theta) T(theta -> theta*) = pi(theta*) T(theta* -> theta)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "When using a symmetric proposal distribution such as a Gaussian random walk q(theta* | theta) = N(theta, sigma^2), how does the Metropolis-Hastings acceptance probability simplify?",
      "options": [
        { "text": "The proposal densities cancel out because q(theta | theta*) = q(theta* | theta), leaving the pure posterior density ratio alpha = min(1, pi(theta*) / pi(theta)) (the standard Metropolis 1953 rule)", "isCorrect": true, "explanation": "Correct! When q is symmetric, q(theta | theta*) / q(theta* | theta) = 1, reducing the algorithm to the original Metropolis algorithm." },
        { "text": "The acceptance probability becomes 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The acceptance probability becomes 1 for all moves", "isCorrect": false, "explanation": "Incorrect: Downhill moves are still accepted with probability < 1." },
        { "text": "Proposals cannot be symmetric in MCMC", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Cancellation of the Intractable Marginal Evidence p(y)",
      "interactiveSteps": [
        {
          "stepText": "The exact Bayesian posterior is pi(theta) = p(y | theta) p(theta) / p(y), where the evidence integral p(y) = int p(y | theta) p(theta) dtheta is high-dimensional and intractable."
        },
        {
          "prompt": "Evaluate the ratio pi(theta*) / pi(theta) in the acceptance probability.",
          "options": [
            { "text": "[p(y | theta*) p(theta*) / p(y)] / [p(y | theta) p(theta) / p(y)] = [p(y | theta*) p(theta*)] / [p(y | theta) p(theta)]", "isCorrect": true },
            { "text": "p(y)^2", "isCorrect": false },
            { "text": "0", "isCorrect": false },
            { "text": "1 / p(y)", "isCorrect": false }
          ]
        },
        {
          "stepText": "Because p(y) cancels from numerator and denominator, MCMC computes exact posterior samples without EVER evaluating the intractable evidence integral!"
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What hyphenated term describes the initial sequence of MCMC samples that are discarded to allow the chain to reach its stationary distribution?",
      "blankAnswer": "burn-in"
    }
  ]
}
```
