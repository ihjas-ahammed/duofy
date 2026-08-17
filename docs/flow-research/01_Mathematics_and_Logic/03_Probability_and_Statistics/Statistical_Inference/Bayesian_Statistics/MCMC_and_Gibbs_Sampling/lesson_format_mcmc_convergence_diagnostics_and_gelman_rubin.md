# Duofy Reusable Lesson Format: MCMC Convergence Diagnostics and the Gelman-Rubin Statistic

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Statistical_Inference / Bayesian_Statistics / MCMC_and_Gibbs_Sampling`  
**Lesson Format Type:** `mcmc_convergence_diagnostics_and_gelman_rubin`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **MCMC Convergence Diagnostics**, calculate the **Gelman-Rubin Potential Scale Reduction Factor** $\hat{R} = \sqrt{\frac{\widehat{\operatorname{Var}}(\theta)}{W}}$, compute **Effective Sample Size (ESS)** $N_{\text{eff}} = \frac{N}{1 + 2\sum \rho_k}$, detect chain sticking and non-stationarity, and interact with live multi-chain convergence traceplot simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gelman-Rubin R-hat & Effective Sample Size Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Diagnostic Metric & Assessment Purpose Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Gelman-Rubin Multi-Chain Convergence Threshold Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Autocorrelation Corrected Sample Size Acronym Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Multi-Chain Traceplot & R-Hat Monitor Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "mcmc_convergence_diagnostics_and_gelman_rubin",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Gelman-Rubin diagnostic (R-hat), and how does it determine whether multiple MCMC chains have converged to the target posterior?",
      "blankAnswer": "R-hat compares the between-chain variance B (dispersion among M independent parallel chains) to the within-chain variance W (average variance inside individual chains): R-hat = sqrt(Var_hat(theta) / W) where Var_hat = ((N-1)/N) W + (1/N) B. At convergence, B -> 0 and Var_hat -> W, forcing R-hat -> 1.00. Values of R-hat < 1.01 indicate that all chains have mixed thoroughly and forgotten their initial conditions."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each MCMC diagnostic metric to its statistical meaning.",
      "matchPairs": [
        { "left": "Gelman-Rubin Statistic (R-hat)", "right": "Measures variance between vs within parallel chains (target: R-hat < 1.01)" },
        { "left": "Effective Sample Size (ESS)", "right": "Estimates equivalent number of independent draws: N_eff = N / (1 + 2 sum rho_k)" },
        { "left": "Autocorrelation Time (tau_int)", "right": "Number of lag steps required for Markov chain samples to become decorrelated" },
        { "left": "Divergent Transitions (HMC)", "right": "Indicates energy conservation breakdown near high-curvature posterior regions" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Four parallel MCMC chains for a regression parameter report R-hat = 1.35 and ESS = 24 after 2,000 iterations per chain. What is the correct diagnostic interpretation?",
      "options": [
        { "text": "The chains have NOT converged (R-hat >> 1.01); the chains are trapped in separate local modes or have not finished their warmup, making posterior estimates unreliable", "isCorrect": true, "explanation": "Correct! R-hat = 1.35 indicates that between-chain variance is much larger than within-chain variance. The chains have not mixed, requiring longer warmup, reparameterization, or more tuning." },
        { "text": "The chains have converged perfectly", "isCorrect": false, "explanation": "Incorrect: Convergence requires R-hat < 1.01." },
        { "text": "The model is proven to be true", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "R-hat is irrelevant when ESS is positive", "isCorrect": false, "explanation": "Incorrect: Both R-hat and ESS are essential." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What three-letter acronym denotes the effective sample size N_eff that measures the number of uncorrelated posterior draws?",
      "blankAnswer": "ess"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive MCMC Convergence Monitor",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>MCMC Multi-Chain Convergence Diagnostic</h3><p>Running 4 Parallel Chains (2,000 post-warmup iterations)</p><button id=\"mcmcBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate R-hat & ESS</button><div id=\"mcmcOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('mcmcBtn').onclick=()=>{document.getElementById('mcmcOut').innerText='Diagnostic Results: R̂ = 1.002 (< 1.01) | ESS_bulk = 3,420 | Zero divergent transitions. All 4 chains have mixed and converged to the stationary posterior!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
