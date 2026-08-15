# Duofy Reusable Lesson Format: Singular Integrals and Wavelets - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis / Singular_Integrals_and_Wavelets`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of Calderón-Zygmund operator bounds ($L^p \to L^p$, weak-$(1, 1)$, $L^\infty \to \text{BMO}$), Haar wavelet scaling equations ($\phi(x) = \phi(2x) + \phi(2x-1)$), and interactive dyadic wavelet decomposition simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hilbert Transform Fourier Multiplier Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Operator Domain & Target Space Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Heisenberg Time-Frequency Wavelet Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Mean Oscillation Space Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Dyadic Wavelet Filter Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Fourier multiplier symbol m(xi) of the Hilbert transform H such that (Hf)^(xi) = m(xi) f^(xi)?",
      "blankAnswer": "m(xi) = -i sgn(xi), which rotates positive frequencies by -pi/2 (-90 deg) and negative frequencies by +pi/2 (+90 deg)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each domain space to the corresponding target space under a Calderón-Zygmund singular integral operator.",
      "matchPairs": [
        { "left": "L^p(R^n) for 1 < p < infty", "right": "L^p(R^n) (Strong Boundedness)" },
        { "left": "L^1(R^n)", "right": "L^{1, infty}(R^n) (Weak-Type (1, 1))" },
        { "left": "Real Hardy Space H^1(R^n)", "right": "L^1(R^n) (Atomic Decomposition)" },
        { "left": "L^infty(R^n)", "right": "BMO(R^n) (Bounded Mean Oscillation)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why are wavelets superior to traditional Fourier transforms for analyzing transient non-stationary signals (like audio spikes or image edges)?",
      "options": [
        { "text": "Wavelets have compact support in time and adaptively adjust their frequency resolution (narrow in time for high frequencies, wide in time for low frequencies)", "isCorrect": true, "explanation": "Correct! Dyadic scaling provides optimal multi-scale time-frequency localization without global sinusoidal leakage." },
        { "text": "Wavelets only work on polynomials", "isCorrect": false, "explanation": "Incorrect: Wavelets form bases for all of L^2." },
        { "text": "Wavelets have infinite bandwidth everywhere", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Wavelets eliminate the need for integrals", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What three-letter acronym denotes the space of functions of Bounded Mean Oscillation?",
      "blankAnswer": "bmo"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Haar Wavelet Multi-Scale Filter",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Signal: [4, 6, 10, 12]</h3><p>Click to compute 1-level Haar Wavelet Decomposition (Averages & Differences):</p><button id=\"haarBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Decompose Signal</button><div id=\"haarOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('haarBtn').onclick=()=>{document.getElementById('haarOut').innerText='Approximations: [(4+6)/2, (10+12)/2] = [5, 11] | Details: [(4-6)/2, (10-12)/2] = [-1, -1]!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
