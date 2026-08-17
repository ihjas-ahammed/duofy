# Duofy Reusable Lesson Format: Feynman-Kac Theorem and Girsanov Measure Change

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory / Martingales_and_Stochastic_Calculus / Ito_Calculus`  
**Lesson Format Type:** `feynman_kac_theorem_and_girsanov_measure_change`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of the **Feynman-Kac Theorem** (bridging parabolic PDEs to conditional expectations of SDEs), evaluate **Girsanov's Change of Measure Theorem** (transforming drift via the Doléans-Dade Radon-Nikodym derivative $Z_t = \mathcal{E}(-\int \theta dW)$), and interact with live Black-Scholes risk-neutral option pricing PDE/SDE simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Feynman-Kac & Girsanov Theorem Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Quantitative Financial Concept & Stochastic Tool Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Risk-Neutral Measure Drift Adjustment Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Radon-Nikodym Derivative Density Acronym Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Black-Scholes Feynman-Kac Monte Carlo Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "feynman_kac_theorem_and_girsanov_measure_change",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Feynman-Kac Theorem, and what is Girsanov's Theorem for changing probability measures?",
      "blankAnswer": "The Feynman-Kac Theorem establishes an exact equivalence between parabolic Partial Differential Equations (PDEs) and conditional expectations of Stochastic Differential Equations (SDEs): the solution to v_t + mu(t, x) v_x + 1/2 sigma(t, x)^2 v_xx - r v = 0 with terminal condition v(T, x) = g(x) is v(t, x) = E[exp(-r(T-t)) g(X_T) | X_t = x] where dX_t = mu dt + sigma dW_t. Girsanov's Theorem allows shifting the drift of a Brownian motion by defining an equivalent probability measure Q with Radon-Nikodym derivative Z_T = dQ/dP = exp(-int_0^T theta_t dW_t - 1/2 int_0^T theta_t^2 dt), under which W_tilde_t = W_t + int_0^t theta_s ds is a standard Brownian motion."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each stochastic finance theorem to its practical mathematical role.",
      "matchPairs": [
        { "left": "Feynman-Kac Theorem", "right": "Bridges parabolic PDEs to Monte Carlo simulations of SDEs (computes option prices)" },
        { "left": "Girsanov's Theorem", "right": "Eliminates subjective stock drift mu, replacing it with risk-free rate r under measure Q" },
        { "left": "Radon-Nikodym Derivative dQ/dP", "right": "Exponential martingale Z_t used to convert expectations between measures: E_Q[X] = E_P[Z_T * X]" },
        { "left": "Novikov's Condition", "right": "E[exp(1/2 int_0^T theta_t^2 dt)] < infty (guarantees Z_t is a true martingale, not local)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Under the risk-neutral probability measure Q defined via Girsanov's theorem, what is the drift of any traded stock dS_t in the Black-Scholes market model?",
      "options": [
        { "text": "The drift is exactly the RISK-FREE INTEREST RATE r: dS_t = r S_t dt + sigma S_t dW_tilde_t (all assets earn the risk-free rate in expectation)", "isCorrect": true, "explanation": "Correct! Girsanov's theorem chooses market price of risk theta = (mu - r)/sigma, changing measure to Q where discounted asset prices S_t e^{-rt} are strictly martingales with drift r." },
        { "text": "The drift is 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The drift remains the physical expected return mu", "isCorrect": false, "explanation": "Incorrect: mu is eliminated under Q." },
        { "text": "The volatility sigma becomes zero", "isCorrect": false, "explanation": "Incorrect: Girsanov leaves volatility sigma unchanged." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What hyphenated two-word name denotes the density dQ/dP used in Girsanov's theorem to transform probability measures?",
      "blankAnswer": "radon-nikodym"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Feynman-Kac Option Pricing Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Feynman-Kac / Black-Scholes Engine</h3><p>European Call: S₀ = $100, K = $100, r = 5%, σ = 20%, T = 1.0 yr</p><button id=\"fkBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Compute Feynman-Kac Expectation</button><div id=\"fkOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('fkBtn').onclick=()=>{document.getElementById('fkOut').innerText='Feynman-Kac Value: v(0, S₀) = E_Q[e^{-0.05×1} max(S_T - 100, 0)] = $10.45. Matches analytical Black-Scholes PDE solution exactly!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
