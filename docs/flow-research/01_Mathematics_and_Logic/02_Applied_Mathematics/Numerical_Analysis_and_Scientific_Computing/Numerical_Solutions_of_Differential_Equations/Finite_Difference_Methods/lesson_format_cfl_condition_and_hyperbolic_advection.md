# Duofy Reusable Lesson Format: CFL Condition, Upwind Differencing, and Hyperbolic Advection

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing / Numerical_Solutions_of_Differential_Equations / Finite_Difference_Methods`  
**Lesson Format Type:** `cfl_condition_and_hyperbolic_advection`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of the **Courant-Friedrichs-Lewy (CFL) Condition** ($C = \frac{a \Delta t}{\Delta x} \le 1$), compare **Upwind vs Lax-Friedrichs vs Lax-Wendroff** hyperbolic schemes, prevent numerical diffusion/dispersion, and interact with live advection wave simulations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CFL Domain of Dependence Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Hyperbolic Scheme & Characteristic Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Domain of Dependence Geometric Criterion Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Courant Number Symbol Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive 1D Hyperbolic Wave Simulation Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cfl_condition_and_hyperbolic_advection",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Courant-Friedrichs-Lewy (CFL) condition for hyperbolic wave and advection equations?",
      "blankAnswer": "The numerical domain of dependence must completely contain the physical (analytical) domain of dependence. For 1D advection u_t + a u_x = 0, this requires Courant number C = |a| * Delta t / Delta x <= 1."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each hyperbolic finite difference scheme to its numerical property.",
      "matchPairs": [
        { "left": "First-Order Upwind Differencing", "right": "Stable for C <= 1; introduces heavy artificial numerical diffusion (smearing)" },
        { "left": "Lax-Wendroff Second-Order Scheme", "right": "O(Delta t^2 + Delta x^2) accurate; introduces dispersive phase oscillations near shocks" },
        { "left": "Forward-Time Central-Space (FTCS)", "right": "Unconditionally unstable for pure advection (|G| > 1 always)" },
        { "left": "Lax-Friedrichs Scheme", "right": "Replaces u_j^n with average (u_{j+1}^n + u_{j-1}^n)/2 to stabilize explicit differencing" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What happens physically if a numerical simulation of the wave equation u_tt = c^2 u_xx violates the CFL condition (c * Delta t / Delta x > 1)?",
      "options": [
        { "text": "Physical waves propagate faster across the continuous domain than information can spread through the discrete grid stencil, causing exponential numerical instability and blowup", "isCorrect": true, "explanation": "Correct! When c Delta t / Delta x > 1, the physical characteristic lines lie outside the numerical cone of dependence, making convergence mathematically impossible." },
        { "text": "The simulation runs faster with higher precision", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The wave energy dissipates to zero immediately", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The scheme automatically becomes implicit", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the German-American mathematician who gave his name to the Courant-Friedrichs-Lewy condition alongside Kurt Friedrichs and Hans Lewy?",
      "blankAnswer": "courant"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive 1D Advection CFL Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>1D Hyperbolic Advection Solver</h3><p>Wave velocity a = 2.0 m/s | Grid dx = 0.1 m</p><button id=\"cflBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Set dt = 0.04s (C = 0.8)</button><div id=\"cflOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('cflBtn').onclick=()=>{document.getElementById('cflOut').innerText='Courant Number C = (2.0 * 0.04) / 0.1 = 0.80 <= 1.0! Upwind scheme is STABLE. Wave pulse translates smoothly.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
