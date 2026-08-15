# Duofy Reusable Lesson Format: Differential Equations - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Differential_Equations_ODEs_and_PDEs`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for PDE classifications (Elliptic/Parabolic/Hyperbolic), d'Alembert wave formulas, matrix exponential rules, and interactive PDE heat/wave visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Canonical PDE Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | PDE Method Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Boundary Condition Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted PDE Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Wave/Heat Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is d'Alembert's formula for the 1D Wave Equation u_tt = c^2 u_xx with initial u(x,0)=g(x) and u_t(x,0)=0?",
      "blankAnswer": "u(x, t) = (1/2) [g(x - c t) + g(x + c t)]"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each PDE solution method to its primary application.",
      "matchPairs": [
        { "left": "Separation of Variables", "right": "Bounded domains with homogeneous boundary conditions" },
        { "left": "Method of Characteristics", "right": "First-order quasilinear PDEs and hyperbolic conservation laws" },
        { "left": "Fourier Transform", "right": "Unbounded domains x ∈ (-∞, ∞)" },
        { "left": "Green's Functions", "right": "Inhomogeneous linear PDEs L u = f" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What boundary condition specifies the value of the derivative $\\frac{\\partial u}{\\partial n} = g(x)$ on the boundary $\\partial \\Omega$?",
      "options": [
        { "text": "Neumann Boundary Condition", "isCorrect": true, "explanation": "Correct! Dirichlet specifies values of u; Neumann specifies normal derivative." },
        { "text": "Dirichlet Boundary Condition", "isCorrect": false, "explanation": "Incorrect: Dirichlet specifies values of u." },
        { "text": "Robin Boundary Condition", "isCorrect": false, "explanation": "Incorrect: Robin is a linear combination of u and derivative." },
        { "text": "Cauchy Boundary Condition", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What name is given to the characteristic curves x ± c t along which wave solutions propagate unchanged?",
      "blankAnswer": "characteristics"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive 1D Heat Equation Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>1D Heat Diffusion</h3><p>Observe heat dissipation over time t:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Evolve t -> ∞</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Parabolic heat equation smooths all sharp gradients as t -> ∞!'); };</script></div>"
    }
  ]
}
```
