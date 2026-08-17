# Duofy Reusable Lesson Format: Characteristic Functions and the Central Limit Theorem

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory / Measure_Theoretic_Probability/Limit_Theorems_LLN_and_CLT`  
**Lesson Format Type:** `characteristic_functions_and_central_limit_theorem`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Characteristic Functions** $\phi_X(t) = \mathbb{E}[e^{i t X}]$, evaluate **Lévy's Continuity Theorem** ($X_n \xrightarrow{d} X \iff \phi_{X_n}(t) \to \phi_X(t)$), execute the Taylor expansion proof of the **Lindeberg-Lévy Central Limit Theorem (CLT)** ($Z_n = \frac{\sqrt{n}(\bar{X}_n - \mu)}{\sigma} \xrightarrow{d} \mathcal{N}(0, 1)$), and interact with live CLT Galton board sum-of-random-variables simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Characteristic Function & Central Limit Theorem Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Probability Distribution & Characteristic Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | CLT Scaling Factor Sqrt(n) Normalization Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Standard Normal Characteristic Function Form Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Central Limit Theorem Galton Board Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "characteristic_functions_and_central_limit_theorem",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Characteristic Function phi_X(t), and how does Lévy's Continuity Theorem prove the Lindeberg-Lévy Central Limit Theorem (CLT)?",
      "blankAnswer": "The characteristic function phi_X(t) = E[exp(i*t*X)] is the Fourier-Stieltjes transform of the probability distribution. Lévy's Continuity Theorem states that X_n -> X in distribution if and only if phi_{X_n}(t) -> phi_X(t) pointwise for all t in R. For i.i.d. X_i with mean 0 and variance 1, the normalized sum Z_n = (sum X_i) / sqrt(n) has characteristic function phi_{Z_n}(t) = [phi_X(t/sqrt(n))]^n = [1 - t^2/(2n) + o(t^2/n)]^n -> exp(-t^2/2), which is the characteristic function of the Standard Normal distribution N(0, 1)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each probability distribution to its characteristic function phi(t) = E[e^{i t X}].",
      "matchPairs": [
        { "left": "Standard Normal N(0, 1)", "right": "exp(-1/2 * t^2) (Gaussian in Fourier domain)" },
        { "left": "Poisson Pois(lambda)", "right": "exp(lambda * (e^{i t} - 1))" },
        { "left": "Standard Cauchy(0, 1)", "right": "exp(-|t|) (non-differentiable at t = 0)" },
        { "left": "Bernoulli Bern(p)", "right": "(1 - p) + p * e^{i t}" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the sum S_n = sum_{i=1}^n (X_i - mu) divided by sqrt(n) * sigma in the Central Limit Theorem rather than n?",
      "options": [
        { "text": "Because Var(S_n) = n * sigma^2; dividing by sqrt(n) * sigma normalizes the variance to EXACTLY 1 for all n, preventing the distribution from collapsing to a point or exploding to infinity", "isCorrect": true, "explanation": "Correct! Dividing by n gives the sample mean (which collapses to variance sigma^2/n -> 0 by LLN), whereas dividing by sqrt(n) stabilizes the fluctuations at unit variance." },
        { "text": "Because n is too large to divide by", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the mean is zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because sqrt(n) is always an integer", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the French mathematician whose continuity theorem bridges characteristic function convergence to convergence in distribution (Lévy)?",
      "blankAnswer": "levy"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Central Limit Theorem Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Central Limit Theorem: Sum of Uniforms</h3><p>Uniform random variables U ~ [-1, 1] | Sum size: n = 12</p><button id=\"cltBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Sample 10,000 Normalized Sums</button><div id=\"cltOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('cltBtn').onclick=()=>{document.getElementById('cltOut').innerText='Generated 10,000 sums Z_12 = (∑ U_i) / (12 × 1/3)^{1/2}. Sample Mean: 0.002 | Sample Variance: 0.998. Histogram perfectly matches Gaussian bell curve N(0, 1)!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
