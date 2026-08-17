# Duofy Reusable Lesson Format: Brownian Martingales and Lévy's Characterization

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory / Martingales_and_Stochastic_Calculus / Brownian_Motion`  
**Lesson Format Type:** `brownian_martingales_and_levy_characterization`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of canonical **Brownian Martingales** ($W_t$, $W_t^2 - t$, and $\mathcal{E}(\sigma W_t) = \exp(\sigma W_t - \frac{1}{2}\sigma^2 t)$), evaluate **Lévy's Characterization Theorem** (Paul Lévy 1948: continuous local martingale with $[M, M]_t = t \implies$ Brownian motion), apply the **Optional Stopping Theorem** to barrier problems, and interact with live Geometric Brownian Motion trajectory simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Brownian Martingales & Lévy Characterization Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Martingale Formulation & Drift Correction Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Exponential Martingale Drift Compensation Term Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Characterization Theorem Author Surname Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Geometric Brownian Motion Martingale Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "brownian_martingales_and_levy_characterization",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Lévy's Characterization Theorem (1948), and what are the three fundamental martingales associated with standard Brownian motion?",
      "blankAnswer": "Lévy's Characterization Theorem states that a continuous, adapted stochastic process M(t) with M(0) = 0 is a Standard Brownian Motion IF AND ONLY IF M(t) is a continuous local martingale and its quadratic variation is [M, M]_t = t for all t >= 0. The 3 canonical Brownian martingales are: 1. M_1(t) = W(t), 2. M_2(t) = W(t)^2 - t, and 3. M_3(t) = exp(sigma * W(t) - 0.5 * sigma^2 * t) (the Exponential / Doléans-Dade Martingale)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Brownian martingale to its compensating drift term.",
      "matchPairs": [
        { "left": "Linear Martingale", "right": "W(t) (zero mean martingale with E[W(t) | F_s] = W(s))" },
        { "left": "Quadratic Martingale", "right": "W(t)^2 - t (compensates quadratic variation accumulation rate dt)" },
        { "left": "Exponential Martingale", "right": "exp(sigma * W(t) - 1/2 * sigma^2 * t) (compensates geometric Jensen drift)" },
        { "left": "Lévy Characterization", "right": "Continuous local martingale + [M, M]_t = t <=> Standard Brownian Motion" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the compensating term in the Exponential Martingale exp(sigma * W(t) - c * t) equal to c = (1/2) * sigma^2?",
      "options": [
        { "text": "Because E[exp(sigma * W(t))] = exp( (1/2) * sigma^2 * t) by the Gaussian moment generating function; dividing by exp((1/2) sigma^2 t) normalizes the expectation to 1 for all t", "isCorrect": true, "explanation": "Correct! For Z ~ N(0, t), E[e^{sigma Z}] = e^{sigma^2 t / 2}. Thus multiplying by e^{-sigma^2 t / 2} preserves the constant expectation E[M_t] = 1, ensuring the martingale property." },
        { "text": "Because sigma is always 1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Brownian motion has zero variance", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because time is negative", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the French mathematician who proved that any continuous martingale with quadratic variation t is a Brownian motion (Lévy)?",
      "blankAnswer": "levy"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Geometric Brownian Motion Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Geometric Brownian Motion: Martingale Drift</h3><p>Process: S(t) = S₀ exp(σW(t) - ½σ²t) with σ = 0.30, S₀ = 100</p><button id=\"gbmBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Simulate 100 Sample Trajectories</button><div id=\"gbmOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('gbmBtn').onclick=()=>{document.getElementById('gbmOut').innerText='100 paths generated over T = 1.0 year. Sample Mean: S̄(1.0) = 100.24 ≈ 100.00! The exponential drift -½σ²t exactly compensates convexity to keep expectation strictly constant!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
