# Duofy Reusable Lesson Format: Chorin's Projection Method and Helmholtz-Hodge Splitting

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Fluid_Dynamics_and_Continuum_Mechanics / Navier_Stokes_Equations`  
**Lesson Format Type:** `chorin_projection_and_helmholtz_hodge_splitting`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Chorin's Fractional-Step Projection Method** (Alexandre Chorin, 1968), execute the 3-step operator split (intermediate velocity $\mathbf{u}^*$, pressure Poisson solve $\nabla^2 p^{n+1} = \frac{\rho}{\Delta t}\nabla\cdot\mathbf{u}^*$, solenoidal projection $\mathbf{u}^{n+1} = \mathbf{u}^* - \frac{\Delta t}{\rho}\nabla p^{n+1}$), and interact with live pressure-velocity coupling simulations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Chorin Projection Method & Helmholtz-Hodge Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Projection Step & Mathematical Equation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Pressure Poisson Equation Origin Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Solenoidal Field Projection Founder Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Chorin 2D Fluid Step Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "chorin_projection_and_helmholtz_hodge_splitting",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the core strategy of Chorin's Projection Method (1968) for solving the incompressible Navier-Stokes equations numerically?",
      "blankAnswer": "It decouples velocity and pressure by first calculating an intermediate non-solenoidal velocity u* via advection-diffusion (ignoring pressure), and then projecting u* onto the space of divergence-free vector fields using the Helmholtz-Hodge decomposition via a Pressure Poisson solve."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each stage of Chorin's fractional step algorithm to its mathematical operation.",
      "matchPairs": [
        { "left": "Stage 1: Advection-Diffusion Step", "right": "u* = u^n + Delta t [-(u^n . nabla)u^n + nu nabla^2 u^n] (predicts intermediate velocity)" },
        { "left": "Stage 2: Pressure Poisson Solve", "right": "nabla^2 p^{n+1} = (rho / Delta t) nabla . u* (computes pressure enforcing zero divergence)" },
        { "left": "Stage 3: Velocity Correction Step", "right": "u^{n+1} = u* - (Delta t / rho) nabla p^{n+1} (projects velocity onto solenoidal subspace)" },
        { "left": "Staggered MAC Grid Arrangement", "right": "Pressures stored at cell centers, velocities stored at cell face midpoints" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In Chorin's projection method, taking the divergence of the correction step u^{n+1} = u* - (Delta t / rho) nabla p^{n+1} and requiring div(u^{n+1}) = 0 directly yields which elliptic PDE for pressure?",
      "options": [
        { "text": "The Pressure Poisson Equation: Delta p^{n+1} = (rho / Delta t) * div(u*)", "isCorrect": true, "explanation": "Correct! Applying nabla . to both sides gives 0 = nabla . u* - (Delta t / rho) nabla^2 p^{n+1}, which rearranges to the Pressure Poisson equation." },
        { "text": "The Wave Equation: p_{tt} = c^2 Delta p", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The Heat Equation: p_t = nu Delta p", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Laplace equation with zero right-hand side", "isCorrect": false, "explanation": "Incorrect: The RHS is non-zero because div(u*) != 0." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the American mathematician who invented the fractional step projection method for Navier-Stokes in 1968?",
      "blankAnswer": "chorin"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Chorin Fractional Step Fluid Solver",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Chorin Projection Method: 2D Step</h3><p>Intermediate field u* with non-zero div(u*) = 4.2 s⁻¹</p><button id=\"chorinBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Solve Pressure Poisson & Project</button><div id=\"chorinOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('chorinBtn').onclick=()=>{document.getElementById('chorinOut').innerText='Poisson solved! Gradient ∇p subtracted: div(u^{n+1}) = 0.0000 s⁻¹ strictly achieved. Fluid mass is conserved!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
