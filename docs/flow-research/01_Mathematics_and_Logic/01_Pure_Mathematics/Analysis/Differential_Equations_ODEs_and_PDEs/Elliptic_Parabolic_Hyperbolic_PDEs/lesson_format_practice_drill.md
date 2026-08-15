# Duofy Reusable Lesson Format: Elliptic, Parabolic, and Hyperbolic PDEs - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Differential_Equations_ODEs_and_PDEs / Elliptic_Parabolic_Hyperbolic_PDEs`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid discriminant evaluations ($B^2 - 4AC$), recognition of canonical boundary condition requirements (Dirichlet vs Cauchy), maximum principle checks, and interactive PDE wave/diffusion simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Boundary Condition Requirements Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | PDE Equation & Canonical Type Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Domain of Dependence Wave Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Characteristic Slope Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Wave Propagation Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "Why does the Laplace equation u_{xx} + u_{yy} = 0 require boundary conditions on a closed boundary rather than initial Cauchy conditions?",
      "blankAnswer": "Because elliptic equations model equilibrium; Cauchy initial value problems for Laplace's equation are ill-posed in the sense of Hadamard (unstable to high-frequency perturbations)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each partial differential equation to its exact PDE type.",
      "matchPairs": [
        { "left": "u_{xx} + 2u_{xy} + u_{yy} = 0", "right": "Parabolic (B^2 - 4AC = 4 - 4 = 0)" },
        { "left": "4u_{xx} + 5u_{xy} + u_{yy} = 0", "right": "Hyperbolic (B^2 - 4AC = 25 - 16 = 9 > 0)" },
        { "left": "3u_{xx} + u_{xy} + 2u_{yy} = 0", "right": "Elliptic (B^2 - 4AC = 1 - 24 = -23 < 0)" },
        { "left": "u_{tt} - c^2 u_{xx} = 0", "right": "Hyperbolic Wave Equation" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In the 1D wave equation u_{tt} = c^2 u_{xx}, what geometric region in the xt-plane represents the domain of dependence of a point (x_0, t_0)?",
      "options": [
        { "text": "The triangular region between the backward characteristic lines x - ct = x_0 - c t_0 and x + ct = x_0 + c t_0 on the initial line t = 0", "isCorrect": true, "explanation": "Correct! Information travels at speed c, so only the initial interval [x_0 - c t_0, x_0 + c t_0] affects the solution at (x_0, t_0)." },
        { "text": "The entire upper half-plane t >= 0", "isCorrect": false, "explanation": "Incorrect: Propagation speed is finite, not infinite." },
        { "text": "A circle of radius c t_0", "isCorrect": false, "explanation": "Incorrect: Characteristics in 1D space + 1D time form a characteristic triangle." },
        { "text": "Only the single point (x_0, 0)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What term describes the curves along which information and discontinuities propagate in hyperbolic equations?",
      "blankAnswer": "characteristics"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Wave vs Diffusion Speed Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Wave (Finite Speed) vs Heat (Infinite Speed)</h3><div id=\"pdeDisplay\" style=\"padding:12px; background:#1e293b; border-radius:8px; margin:15px 0; font-size:16px;\">Status: Pulse injected at x = 0, t = 0</div><button id=\"simBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Simulate Propagation</button><div id=\"simOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('simBtn').onclick=()=>{document.getElementById('simOut').innerText='Wave: Sharp wavefront reaches x = ct at finite time t. Heat: Immediate exponential decay across all x!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
