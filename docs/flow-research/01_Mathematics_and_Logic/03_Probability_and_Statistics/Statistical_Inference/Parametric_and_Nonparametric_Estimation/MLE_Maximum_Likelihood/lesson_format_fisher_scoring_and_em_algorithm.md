# Duofy Reusable Lesson Format: Fisher Scoring and the Expectation-Maximization (EM) Algorithm

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Statistical_Inference / Parametric_and_Nonparametric_Estimation / MLE_Maximum_Likelihood`  
**Lesson Format Type:** `fisher_scoring_and_em_algorithm`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of numerical optimization algorithms for MLE: **Fisher Scoring** ($\theta^{(t+1)} = \theta^{(t)} + [I(\theta^{(t)})]^{-1} S(\theta^{(t)})$) and the **Expectation-Maximization (EM) Algorithm** (Dempster, Laird, & Rubin, 1977) for latent variable models and mixture distributions, and interact with live Gaussian Mixture Model EM clustering simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | EM Algorithm & Fisher Scoring Strategy Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Numerical Estimation Algorithm & Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | EM Monotonic Log-Likelihood Ascent Property Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted EM Algorithm First Step Initial Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive 2-Component GMM EM Clustering Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fisher_scoring_and_em_algorithm",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are the two alternating steps of the Expectation-Maximization (EM) Algorithm (1977) for maximizing likelihood in the presence of latent / missing variables Z?",
      "blankAnswer": "1. E-Step (Expectation): Compute the expected complete log-likelihood Q(theta | theta^(t)) = E_{Z | X, theta^(t)} [log L_c(theta | X, Z)] under the current parameter estimates theta^(t). 2. M-Step (Maximization): Update parameter estimates by maximizing the Q function: theta^(t+1) = argmax_theta Q(theta | theta^(t)). By Jensen's inequality, the observed log-likelihood is GUARANTEED to increase monotonically at every iteration: ell(theta^(t+1)) >= ell(theta^(t))."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each numerical MLE optimization algorithm to its operational formula.",
      "matchPairs": [
        { "left": "Newton-Raphson Iteration", "right": "theta^{(t+1)} = theta^{(t)} - [nabla^2 ell(theta^{(t)})]^{-1} S(theta^{(t)}) (uses empirical Hessian)" },
        { "left": "Fisher Scoring Method", "right": "theta^{(t+1)} = theta^{(t)} + [I_n(theta^{(t)})]^{-1} S(theta^{(t)}) (replaces Hessian with expected Fisher Information)" },
        { "left": "EM Algorithm E-Step", "right": "Q(theta | theta^{(t)}) = sum_{z} P(z | x, theta^{(t)}) log P(x, z | theta) (computes posterior responsibilities)" },
        { "left": "EM Algorithm M-Step", "right": "theta^{(t+1)} = argmax_theta Q(theta | theta^{(t)}) (closed-form weighted MLE update)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What mathematical guarantee is provided by Jensen's inequality for every iteration of the Expectation-Maximization (EM) algorithm?",
      "options": [
        { "text": "The observed data log-likelihood is MONOTONICALLY NON-DECREASING: ell(theta^{(t+1)}) >= ell(theta^{(t)}) on every single iteration", "isCorrect": true, "explanation": "Correct! Because Q(theta | theta_t) acts as a minorizing surrogate function tangent to ell(theta) at theta_t, maximizing Q strictly increases (or keeps constant) the true observed log-likelihood." },
        { "text": "The algorithm is guaranteed to find the global optimum on all non-convex surfaces", "isCorrect": false, "explanation": "Incorrect: EM can get trapped in local maxima or saddle points." },
        { "text": "The parameters converge in exactly 1 step", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The latent variables become zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "In the EM algorithm, what word does the letter 'E' represent in the E-step?",
      "blankAnswer": "expectation"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Gaussian Mixture Model EM Solver",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Gaussian Mixture Model: EM Iteration</h3><p>2-Component Mixture: Initial μ₁ = -1.0, μ₂ = +1.0</p><button id=\"emBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Execute E-Step & M-Step</button><div id=\"emOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('emBtn').onclick=()=>{document.getElementById('emOut').innerText='E-step: Soft responsibilities γ(z_{ik}) calculated. M-step: Updated means μ₁* = -2.14, μ₂* = +3.82. Log-likelihood increased from -412.5 to -328.1!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
