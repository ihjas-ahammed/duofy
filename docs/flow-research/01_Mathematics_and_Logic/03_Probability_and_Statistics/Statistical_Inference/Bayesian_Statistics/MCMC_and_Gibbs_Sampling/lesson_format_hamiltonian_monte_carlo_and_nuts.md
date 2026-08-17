# Duofy Reusable Lesson Format: Hamiltonian Monte Carlo (HMC) and the No-U-Turn Sampler (NUTS)

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Statistical_Inference / Bayesian_Statistics / MCMC_and_Gibbs_Sampling`  
**Lesson Format Type:** `hamiltonian_monte_carlo_and_nuts`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to understand the physics-based geometry of **Hamiltonian Monte Carlo (HMC)** (Duane et al. 1987, Neal 2011), execute **Leapfrog Symplectic Integration** using gradient vector fields $\nabla_\theta \log p(\theta \mid y)$, understand how HMC eliminates random-walk diffusion in 10,000 dimensions, and explain the **No-U-Turn Sampler (NUTS / Stan)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hamiltonian Physics Formulation & Target Potential Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Leapfrog Symplectic Integration Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | MCMC Sampler Algorithm & Dimensionality Scaling Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Auxiliary Momentum Gaussian Distribution Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | NUTS Automatic Trajectory Stopping Criterion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Hamiltonian Monte Carlo formulation: Augment position parameters $\mathbf{\theta} \in \mathbb{R}^d$ with fictitious momentum variables $\mathbf{p} \sim \mathcal{N}(\mathbf{0}, \mathbf{M})$. Define the Hamiltonian total energy: $H(\mathbf{\theta}, \mathbf{p}) = U(\mathbf{\theta}) + K(\mathbf{p}) = -\log p(\mathbf{\theta} \mid \mathbf{y}) + \frac{1}{2} \mathbf{p}^T \mathbf{M}^{-1} \mathbf{p}$. The joint probability density is $p(\mathbf{\theta}, \mathbf{p}) \propto e^{-H(\mathbf{\theta}, \mathbf{p})} = p(\mathbf{\theta} \mid \mathbf{y}) \cdot \mathcal{N}(\mathbf{p} \mid \mathbf{0}, \mathbf{M})$. Hamilton's equations are: $\frac{d\mathbf{\theta}}{dt} = \frac{\partial H}{\partial \mathbf{p}} = \mathbf{M}^{-1}\mathbf{p}, \frac{d\mathbf{p}}{dt} = -\frac{\partial H}{\partial \mathbf{\theta}} = \nabla_{\mathbf{\theta}} \log p(\mathbf{\theta} \mid \mathbf{y})$.
2. **Slide 2 (`concept_pieces`):** Deconstruct a single step of the Leapfrog Symplectic Integrator of step size $\epsilon$: (1) half-step momentum update: $\mathbf{p}(t + \epsilon/2) = \mathbf{p}(t) + \frac{\epsilon}{2} \nabla_{\mathbf{\theta}} \log p(\mathbf{\theta}(t) \mid \mathbf{y})$, (2) full-step position update: $\mathbf{\theta}(t + \epsilon) = \mathbf{\theta}(t) + \epsilon \mathbf{M}^{-1} \mathbf{p}(t + \epsilon/2)$, (3) second half-step momentum update: $\mathbf{p}(t + \epsilon) = \mathbf{p}(t + \epsilon/2) + \frac{\epsilon}{2} \nabla_{\mathbf{\theta}} \log p(\mathbf{\theta}(t + \epsilon) \mid \mathbf{y})$, (4) accept/reject using energy difference: $\alpha = \min(1, \exp(-H(\mathbf{\theta}^*, \mathbf{p}^*) + H(\mathbf{\theta}, \mathbf{p})))$, which is close to 1 because symplectic integrators conserve phase space volume and nearly conserve total energy.
3. **Slide 3 (`matching`):** Pair 4 MCMC algorithms (Random Walk Metropolis, Gibbs Sampler, Hamiltonian Monte Carlo / HMC, No-U-Turn Sampler / NUTS) with their exploration mechanisms and scaling with dimension $d$.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the auxiliary momentum variables $\mathbf{p}$ in HMC are standardly sampled from a multivariate Gaussian distribution. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the No-U-Turn Sampler (NUTS / Hoffman & Gelman 2014): What is the core mechanism of NUTS that eliminates the need to hand-tune the trajectory length parameter $L$? (NUTS builds a recursive binary tree of leapfrog steps forward and backward in time, stopping automatically when the endpoints begin to fold back toward each other: $\frac{d}{dt}\|\mathbf{\theta}_{\text{end}} - \mathbf{\theta}_{\text{start}}\|^2 < 0$, preventing wasted computational cycles).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hamiltonian_monte_carlo_and_nuts",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Hamiltonian Monte Carlo (HMC) and Physics-Based Sampling**\n• **Augmented Phase Space:** Pair parameter $\\mathbf{\\theta} \\in \\mathbb{R}^d$ (position) with auxiliary momentum $\\mathbf{p} \\sim \\mathcal{N}(\\mathbf{0}, \\mathbf{M})$.\n• **The Hamiltonian Function:**\n$$\nH(\\mathbf{\\theta}, \\mathbf{p}) = U(\\mathbf{\\theta}) + K(\\mathbf{p}) = -\\log p(\\mathbf{\\theta} \\mid \\mathbf{y}) + \\frac{1}{2}\\mathbf{p}^T \\mathbf{M}^{-1} \\mathbf{p}\n$$\n• **Hamilton's Equations of Motion:**\n$$\n\\frac{d\\mathbf{\\theta}}{dt} = \\mathbf{M}^{-1}\\mathbf{p}, \\qquad \\frac{d\\mathbf{p}}{dt} = \\nabla_{\\mathbf{\\theta}} \\log p(\\mathbf{\\theta} \\mid \\mathbf{y})\n$$\n• **Why HMC Dominates:** Uses gradient forces $\\nabla_\\theta \\log p(\\theta \\mid y)$ to glide along frictionless energy contours, avoiding random-walk diffusion and scaling to thousands of parameters."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Leapfrog Symplectic Integrator Step (size $\\epsilon$):**\n• **Step 1 (Half-step momentum):** $\\mathbf{p}\\left(t + \\frac{\\epsilon}{2}\\right) = \\mathbf{p}(t) + \\frac{\\epsilon}{2} \\nabla_{\\mathbf{\\theta}} \\log p(\\mathbf{\\theta}(t) \\mid \\mathbf{y})$.\n• **Step 2 (Full-step position):** $\\mathbf{\\theta}(t + \\epsilon) = \\mathbf{\\theta}(t) + \\epsilon \\mathbf{M}^{-1} \\mathbf{p}\\left(t + \\frac{\\epsilon}{2}\\right)$.\n• **Step 3 (Half-step momentum):** $\\mathbf{p}(t + \\epsilon) = \\mathbf{p}\\left(t + \\frac{\\epsilon}{2}\\right) + \\frac{\\epsilon}{2} \\nabla_{\\mathbf{\\theta}} \\log p(\\mathbf{\\theta}(t + \\epsilon) \\mid \\mathbf{y})$.\n• **Step 4 (Metropolis Correction):** Accept with $\\alpha = \\min(1, e^{-H(\\mathbf{\\theta}^*, \\mathbf{p}^*) + H(\\mathbf{\\theta}, \\mathbf{p})})$ (typically $> 85\\%$ acceptance rate!)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each MCMC sampler to its exploration efficiency and dimension scaling.",
      "matchPairs": [
        { "left": "Random Walk Metropolis", "right": "Diffusion-limited random walk scaling as O(d^2) (fails in high dimensions)" },
        { "left": "Gibbs Sampling", "right": "Restricted to 1D conditional axes; stalls when parameters are strongly correlated" },
        { "left": "Hamiltonian Monte Carlo (HMC)", "right": "Gradient-guided trajectories scaling as O(d^{1/4}) (efficient in high dimensions)" },
        { "left": "No-U-Turn Sampler (NUTS / Stan)", "right": "Self-tuning recursive trajectory sampler that automatically stops before doubling back" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Hamiltonian Monte Carlo, the auxiliary fictitious momentum vector p is standardly sampled from a multivariate ___ distribution.",
      "blankAnswer": "gaussian",
      "blankDistractors": ["cauchy", "poisson", "uniform"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the key geometric stopping criterion used in the No-U-Turn Sampler (NUTS / Hoffman & Gelman 2014) to determine when to terminate trajectory expansion?",
      "options": [
        { "text": "It builds a recursive binary trajectory tree and stops as soon as the forward and backward ends begin moving toward each other: d/dt ||theta_plus - theta_minus||^2 < 0 (a 'U-turn')", "isCorrect": true, "explanation": "Correct! When the endpoints begin to approach each other, continuing to integrate would retrace previously explored phase space, so NUTS terminates and samples a state." },
        { "text": "It stops after exactly 1 step always", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It stops when the gradient is zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It stops when the user presses cancel", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
