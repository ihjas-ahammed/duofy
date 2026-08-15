# Duofy Reusable Lesson Format: Riemann Zeta Function - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Analytic_Number_Theory / Riemann_Zeta_Function`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of special zeta values ($\zeta(2), \zeta(4), \zeta(0), \zeta(-1)$), trivial vs non-trivial zero locations, critical line symmetries ($\xi(s) = \xi(1-s)$), and interactive critical line zero visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Completed Xi Symmetries Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Complex Domain Region & Zero Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Riemann Explicit Formula Primary Term Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Critical Strip Bound Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Critical Line Zero Oscilloscope Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the reflection symmetry of Riemann's completed zeta function xi(s)?",
      "blankAnswer": "xi(s) = xi(1 - s), where xi(s) = (1/2) s (s - 1) pi^{-s/2} Gamma(s/2) zeta(s)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each region of the complex plane to its zeta function zero status.",
      "matchPairs": [
        { "left": "Re(s) > 1", "right": "Zero-Free (Euler product converges absolutely)" },
        { "left": "Negative Even Integers {-2, -4, -6, ...}", "right": "Trivial Zeros (from Gamma poles / sine vanishing)" },
        { "left": "Critical Line Re(s) = 1/2", "right": "Conjectured location of ALL non-trivial zeros" },
        { "left": "The point s = 1", "right": "Unique simple pole with residue 1" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In Riemann's Explicit Formula psi(x) = x - sum_rho (x^rho / rho) - ..., where does the dominant term 'x' come from?",
      "options": [
        { "text": "The residue of the simple pole of -zeta'(s)/zeta(s) at s = 1", "isCorrect": true, "explanation": "Correct! By Cauchy's Residue Theorem, the simple pole of zeta(s) at s = 1 creates the residue term x^1 / 1 = x." },
        { "text": "The trivial zero at s = -2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The first prime p = 2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Euler's constant gamma", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "The region of the complex plane 0 < Re(s) < 1 containing all non-trivial zeros is called the critical ___.",
      "blankAnswer": "strip"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Critical Line Zero Visualizer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Riemann Zeta Zeros on Critical Line Re(s) = 1/2</h3><p>Compute imaginary heights γ of first 3 non-trivial zeros (1/2 + iγ):</p><button id=\"zeroBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate Zeros</button><div id=\"zeroOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('zeroBtn').onclick=()=>{document.getElementById('zeroOut').innerText='γ_1 ≈ 14.1347 | γ_2 ≈ 21.0220 | γ_3 ≈ 25.0109! All lie exactly on Re(s) = 0.5!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
