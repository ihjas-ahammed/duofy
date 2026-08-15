# Duofy Reusable Lesson Format: Harmonic Analysis - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for Fourier transform identities, convolution rules, Parseval energy formulas, and interactive spectrum visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fourier Transform Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Transform Identity Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Uncertainty Principle Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Frequency Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Spectrum Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Plancherel's Theorem formula for L^2 functions?",
      "blankAnswer": "Integral |f(x)|^2 dx = Integral |f_hat(ξ)|^2 dξ"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each spatial function to its Fourier transform pair.",
      "matchPairs": [
        { "left": "Gaussian e^(-π x^2)", "right": "e^(-π ξ^2) (Self-dual)" },
        { "left": "Box function 1_[-1/2, 1/2](x)", "right": "Sinc function sin(π ξ) / (π ξ)" },
        { "left": "Dirac Delta δ(x)", "right": "Constant function 1" },
        { "left": "Exponential e^(-a |x|)", "right": "Lorentzian 2a / (a^2 + 4π^2 ξ^2)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What mathematical operation in the time domain corresponds to point-wise multiplication in the frequency domain?",
      "options": [
        { "text": "Convolution (f * g)(x)", "isCorrect": true, "explanation": "Correct! Fourier transform converts spatial convolution into frequency multiplication." },
        { "text": "Differentiation", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Integration", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Translation", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What term describes the mathematical transform that replaces sine waves with localized wave packets capturing time and frequency simultaneously?",
      "blankAnswer": "wavelet"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Frequency Spectrum Visualizer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Time vs Frequency Spectrum</h3><p>Select frequency f = 440 Hz to generate pure tone e^(2πi * 440 t):</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Set f = 440 Hz (Concert A)</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! A pure sinusoid concentrates all spectral energy into a single spike at f = 440 Hz!'); };</script></div>"
    }
  ]
}
```
