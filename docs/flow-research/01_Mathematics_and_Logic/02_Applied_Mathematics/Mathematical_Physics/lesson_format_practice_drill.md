# Duofy Reusable Lesson Format: Mathematical Physics - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for physical observables, Poisson brackets, energy spectrum formulas, and interactive quantum state visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Canonical Quantization Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Classical vs Quantum Operator Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | General Relativity Metric Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Noether Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Quantum Wavefunction Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the canonical commutation relation between position x and momentum p in Quantum Mechanics?",
      "blankAnswer": "[x, p] = i * ħ"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each classical physical quantity to its quantum operator representation.",
      "matchPairs": [
        { "left": "Position x", "right": "Position operator x (multiplication by x)" },
        { "left": "Momentum p", "right": "Differential operator -i ħ (d / dx)" },
        { "left": "Energy H", "right": "Hamiltonian operator H = - (ħ^2 / 2m) d^2/dx^2 + V(x)" },
        { "left": "Angular Momentum L_z", "right": "Differential operator -i ħ (∂ / ∂φ)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What spacetime metric $ds^2$ describes the vacuum geometry outside a static, spherically symmetric massive body of mass $M$ in General Relativity?",
      "options": [
        { "text": "Schwarzschild Metric: ds² = -(1 - 2GM/r c²) c² dt² + (1 - 2GM/r c²)⁻¹ dr² + r² dΩ²", "isCorrect": true, "explanation": "Correct! The Schwarzschild solution is the exact spherical vacuum metric." },
        { "text": "Minkowski Metric", "isCorrect": false, "explanation": "Incorrect: Minkowski describes flat spacetime." },
        { "text": "Kerr Metric", "isCorrect": false, "explanation": "Incorrect: Kerr describes a rotating mass." },
        { "text": "FLRW Metric", "isCorrect": false, "explanation": "Incorrect: FLRW describes expanding universe." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What geometric 2-form ω = sum dq_i ∧ dp_i equips phase space with Poisson brackets in classical mechanics?",
      "blankAnswer": "symplectic"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Quantum State Superposition Visualizer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Quantum Particle in a Box</h3><p>Select ground state n=1 wavefunction ψ₁(x) = √(2/L) sin(π x / L):</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Set n = 1 (Ground State)</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Ground state n=1 has energy E₁ = π² ħ² / (2m L²) with 0 nodes inside box!'); };</script></div>"
    }
  ]
}
```
