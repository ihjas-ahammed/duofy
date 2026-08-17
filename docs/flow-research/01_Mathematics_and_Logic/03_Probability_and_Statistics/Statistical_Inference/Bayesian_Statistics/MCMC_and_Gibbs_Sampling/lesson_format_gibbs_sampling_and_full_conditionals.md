# Duofy Reusable Lesson Format: Gibbs Sampling and Full Conditional Distributions

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Statistical_Inference / Bayesian_Statistics / MCMC_and_Gibbs_Sampling`  
**Lesson Format Type:** `gibbs_sampling_and_full_conditionals`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the derivation and mechanics of **Gibbs Sampling** (Geman & Geman 1984, Gelfand & Smith 1990), prove why sampling from **Full Conditionals** $p(\theta_j \mid \mathbf{\theta}_{-j}, \mathbf{y})$ yields an acceptance probability of $\alpha \equiv 1$ (100% acceptance), and construct a Gibbs sampler for conjugate hierarchical models (e.g. Normal mean and variance).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gibbs Sampling & Full Conditional Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Full Conditional Extraction from Joint Density Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Why Gibbs Acceptance Probability is Exactly 1 Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Normal-Inverse-Gamma Hierarchy Full Conditional Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Unconditional Acceptance Percentage Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Gibbs Sampling Algorithm: To sample from joint distribution $p(\theta_1, \dots, \theta_d \mid \mathbf{y})$, iterate through $j = 1, \dots, d$: sample $\theta_j^{(t+1)} \sim p(\theta_j \mid \theta_1^{(t+1)}, \dots, \theta_{j-1}^{(t+1)}, \theta_{j+1}^{(t)}, \dots, \theta_d^{(t)}, \mathbf{y})$. State the Full Conditional rule: $p(\theta_j \mid \mathbf{\theta}_{-j}, \mathbf{y}) \propto p(\mathbf{\theta}, \mathbf{y})$ viewed strictly as a function of $\theta_j$ holding all other variables constant.
2. **Slide 2 (`ordering`):** Provide 5 steps deriving full conditional distributions from a graphical model / joint density: (1) write down the complete joint distribution $p(\mathbf{\theta}, \mathbf{y}) = p(\mathbf{y} \mid \mathbf{\theta}) \prod p(\theta_k)$, (2) to find full conditional $p(\theta_j \mid \mathbf{\theta}_{-j}, \mathbf{y})$, drop all factors in the joint probability that do NOT contain $\theta_j$, (3) absorb dropped factors into the proportionality constant $C$, (4) algebraically manipulate the remaining terms into the recognizable kernel of a standard probability distribution (e.g. Normal, Gamma, Inverse-Gamma), (5) extract updated conjugate hyperparameters for direct random number generation.
3. **Slide 3 (`quiz`):** Test why Gibbs sampling has an acceptance probability of $\alpha = 1$: (Because the proposal distribution $q(\theta_j^* \mid \mathbf{\theta}) = p(\theta_j^* \mid \mathbf{\theta}_{-j}, \mathbf{y})$ exactly matches the target conditional distribution, so the MH ratio $\frac{p(\theta_j^*, \mathbf{\theta}_{-j}) p(\theta_j \mid \mathbf{\theta}_{-j})}{p(\theta_j, \mathbf{\theta}_{-j}) p(\theta_j^* \mid \mathbf{\theta}_{-j})} = \frac{p(\mathbf{\theta}_{-j}) p(\theta_j^* \mid \mathbf{\theta}_{-j}) p(\theta_j \mid \mathbf{\theta}_{-j})}{p(\mathbf{\theta}_{-j}) p(\theta_j \mid \mathbf{\theta}_{-j}) p(\theta_j^* \mid \mathbf{\theta}_{-j})} \equiv 1$).
4. **Slide 4 (`proof`):** Interactive derivation for $y_i \sim \mathcal{N}(\mu, \sigma^2)$ with prior $\mu \sim \mathcal{N}(\mu_0, \sigma_0^2)$, showing the full conditional $p(\mu \mid \sigma^2, \mathbf{y}) \sim \mathcal{N}\left( \frac{\mu_0/\sigma_0^2 + n\bar{y}/\sigma^2}{1/\sigma_0^2 + n/\sigma^2}, \frac{1}{1/\sigma_0^2 + n/\sigma^2} \right)$.
5. **Slide 5 (`one_word`):** Plain-text recall of the numerical acceptance percentage achieved on every step of a pure Gibbs sampler (100 / one-hundred / 100%).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "gibbs_sampling_and_full_conditionals",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Gibbs Sampling and Full Conditional Distributions**\n• For a parameter vector $\\mathbf{\\theta} = (\\theta_1, \\dots, \\theta_d)^T$ with target posterior $p(\\mathbf{\\theta} \\mid \\mathbf{y})$:\n• **The Gibbs Sampling Algorithm (Geman & Geman 1984):**\n  At iteration $t+1$, update each scalar parameter sequentially by drawing directly from its **Full Conditional Distribution**:\n$$\n\\theta_j^{(t+1)} \\sim p\\left( \\theta_j \\;\\middle|\\; \\theta_1^{(t+1)}, \\dots, \\theta_{j-1}^{(t+1)}, \\, \\theta_{j+1}^{(t)}, \\dots, \\theta_d^{(t)}, \\, \\mathbf{y} \\right)\n$$\n• **Core Property:** Gibbs sampling is a special case of Metropolis-Hastings where the acceptance probability is **identically 100% ($\\alpha \\equiv 1$)** on every single step!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical mathematical steps to derive a parameter's full conditional distribution from the joint posterior.",
      "orderItems": [
        "Write out the full joint density expression p(theta_1, ..., theta_d, y) = p(y | theta) * prod p(theta_k)",
        "Isolate target parameter theta_j and drop all multiplicative terms in the joint density that do not contain theta_j",
        "Group the remaining terms into an unnormalized kernel: p(theta_j | theta_{-j}, y) prop f(theta_j)",
        "Complete the square or match functional exponents to identify the standard conjugate distribution family",
        "Extract the updated posterior hyperparameters to generate exact independent samples in the Gibbs loop"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the Metropolis-Hastings acceptance probability alpha ALWAYS EXACTLY EQUAL TO 1 in a Gibbs sampler?",
      "options": [
        { "text": "The proposal distribution q(theta_j* | theta) is chosen to be the EXACT full conditional distribution p(theta_j* | theta_{-j}, y), which causes the target density ratio and proposal density ratio to cancel out to 1 identically", "isCorrect": true, "explanation": "Correct! Since p(theta) = p(theta_j | theta_{-j}) p(theta_{-j}), the MH ratio evaluates to [p(theta_j* | theta_{-j}) p(theta_{-j}) * p(theta_j | theta_{-j})] / [p(theta_j | theta_{-j}) p(theta_{-j}) * p(theta_j* | theta_{-j})] = 1." },
        { "text": "Because all proposals are zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because parameters are completely independent in all models", "isCorrect": false, "explanation": "Incorrect: Gibbs handles highly correlated parameters." },
        { "text": "Because the prior distribution is uniform", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Gaussian Mean Full Conditional p(mu | sigma^2, y)",
      "interactiveSteps": [
        {
          "stepText": "Let y_1, ..., y_n ~ N(mu, sigma^2) with prior mu ~ N(mu_0, sigma_0^2). The joint density is prop exp( -1/(2 sigma_0^2) (mu - mu_0)^2 - 1/(2 sigma^2) sum (y_i - mu)^2 )."
        },
        {
          "prompt": "Expanding and completing the square in mu, what distribution family and precision (1/Var) are obtained?",
          "options": [
            { "text": "Gaussian N(mu_post, sigma_post^2) with precision 1/sigma_post^2 = 1/sigma_0^2 + n/sigma^2", "isCorrect": true },
            { "text": "Gamma distribution", "isCorrect": false },
            { "text": "Inverse-Chi-Square", "isCorrect": false },
            { "text": "Uniform distribution", "isCorrect": false }
          ]
        },
        {
          "stepText": "The updated posterior mean is mu_post = (mu_0 / sigma_0^2 + n y_bar / sigma^2) / (1 / sigma_0^2 + n / sigma^2), which can be sampled instantaneously in the Gibbs cycle."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the numerical percentage of candidate moves accepted in a pure Gibbs sampling algorithm (write as 100)?",
      "blankAnswer": "100"
    }
  ]
}
```
