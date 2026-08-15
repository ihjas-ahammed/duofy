# Duofy Reusable Lesson Format: Fluid Dynamics - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Fluid_Dynamics_and_Continuum_Mechanics`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for Navier-Stokes equations, Reynolds number thresholds, Bernoulli pressure drop relations, and interactive streamline visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Continuity Equation Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Fluid Flow Type Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Boundary Layer Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Vorticity Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Venturi Streamline Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Bernoulli's equation formula along a streamline for steady incompressible flow?",
      "blankAnswer": "p + (1/2) ρ u^2 + ρ g z = constant"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each fluid flow model to its defining mathematical assumption.",
      "matchPairs": [
        { "left": "Incompressible Flow", "right": "Divergence grad · u = 0 (Constant density)" },
        { "left": "Irrotational Flow", "right": "Vorticity ω = grad × u = 0 (Velocity u = grad Φ)" },
        { "left": "Stokes Creeping Flow", "right": "Reynolds number Re << 1 (Inertial terms (u·grad)u neglected)" },
        { "left": "Boundary Layer Flow", "right": "High Re flow where viscous forces concentrate in thin wall region" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What happens to fluid pressure $p$ in a Venturi tube when fluid flows from a wide pipe section into a narrow constriction (higher velocity $u$)?",
      "options": [
        { "text": "Pressure decreases (Venturi Effect via Bernoulli's Principle)", "isCorrect": true, "explanation": "Correct! Increased kinetic energy (1/2 ρ u²) requires decreased static pressure p." },
        { "text": "Pressure increases", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Pressure remains unchanged", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Density doubles", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What term describes the curl of the velocity vector field ω = curl u measuring local fluid rotation?",
      "blankAnswer": "vorticity"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Venturi Tube Flow Visualizer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Venturi Effect Simulator</h3><p>Constrict pipe diameter to observe velocity u rise and pressure p drop:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Constrict Diameter 50%</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Continuity forces u to quadruple, driving static pressure p down!'); };</script></div>"
    }
  ]
}
```
