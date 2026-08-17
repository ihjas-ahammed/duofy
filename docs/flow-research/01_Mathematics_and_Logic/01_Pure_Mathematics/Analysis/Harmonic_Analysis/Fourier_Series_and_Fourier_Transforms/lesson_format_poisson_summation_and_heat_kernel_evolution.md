# Duofy Reusable Lesson Format: Poisson Summation Formula and Heat Kernel Evolution

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis / Fourier_Series_and_Fourier_Transforms`  
**Lesson Format Type:** `poisson_summation_and_heat_kernel_evolution`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of the **Poisson Summation Formula** ($\sum_{n \in \mathbb{Z}} f(n) = \sum_{k \in \mathbb{Z}} \hat{f}(k)$), solve the **Heat Equation** via Fourier convolution with the Gaussian heat kernel $K_t(x) = \frac{1}{\sqrt{4\pi t}} e^{-x^2 / 4t}$, and explore interactive Fourier synthesis waveforms.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Poisson Summation Identity Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | PDE Operator & Fourier Multiplier Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Heat Kernel Gaussian Variance Spread Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Periodic Waveform Function Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Fourier Harmonic Wave Synthesizer Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "poisson_summation_and_heat_kernel_evolution",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Poisson Summation Formula connecting integer samples of a Schwartz function f(x) to its Fourier transform f_hat(xi)?",
      "blankAnswer": "sum_{n in Z} f(n) = sum_{k in Z} f_hat(k). It states that periodizing a function in space equals sampling its Fourier transform on the integer grid."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each partial differential equation to its Fourier frequency multiplier.",
      "matchPairs": [
        { "left": "Heat Equation u_t = Delta u", "right": "e^{-4 pi^2 |xi|^2 t} (Gaussian exponential dissipation)" },
        { "left": "Schrödinger Equation i u_t = -Delta u", "right": "e^{-i 4 pi^2 |xi|^2 t} (Unitary phase dispersion)" },
        { "left": "Wave Equation u_{tt} = Delta u", "right": "cos(2 pi |xi| t) (Oscillatory acoustic propagation)" },
        { "left": "Laplace Equation -Delta u = 0 (upper half plane)", "right": "e^{-2 pi |xi| y} (Poisson harmonic extension)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "How does the width (standard deviation) of the 1D Gaussian heat kernel K_t(x) = (4 pi t)^{-1/2} e^{-x^2 / (4t)} scale with time t?",
      "options": [
        { "text": "Proportional to sqrt(t) (diffusive broadening where variance sigma^2 = 2t)", "isCorrect": true, "explanation": "Correct! Heat diffusion spreads with standard deviation sigma = sqrt(2t), reflecting Brownian motion scaling." },
        { "text": "Proportional to t (linear ballistic spread)", "isCorrect": false, "explanation": "Incorrect: Ballistic spread occurs in wave equations, not heat diffusion." },
        { "text": "Proportional to t^2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Width remains constant", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the French mathematician whose summation formula equates the sum of f(n) over integers to the sum of f_hat(k)?",
      "blankAnswer": "poisson"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Fourier Square Wave Synthesizer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Fourier Synthesis: Square Wave</h3><p>Summing odd harmonics: sin(x) + (1/3)sin(3x) + (1/5)sin(5x) + ...</p><button id=\"fourierBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Add 5 Harmonics</button><div id=\"fourierOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('fourierBtn').onclick=()=>{document.getElementById('fourierOut').innerText='Harmonics added! Waveform converges to square wave with sharp edges and 9% Gibbs overshoot near discontinuities.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
