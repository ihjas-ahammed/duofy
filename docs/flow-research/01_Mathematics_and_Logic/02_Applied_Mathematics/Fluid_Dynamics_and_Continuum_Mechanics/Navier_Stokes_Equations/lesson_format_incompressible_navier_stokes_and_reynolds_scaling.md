# Duofy Reusable Lesson Format: Incompressible Navier-Stokes and Reynolds Scaling

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Fluid_Dynamics_and_Continuum_Mechanics / Navier_Stokes_Equations`  
**Lesson Format Type:** `incompressible_navier_stokes_and_reynolds_scaling`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the physical and mathematical conservation laws of the **Incompressible Navier-Stokes Equations**, nondimensionalize the system using characteristic scales $U, L$, and analyze the asymptotic behavior at low ($Re \ll 1$, Stokes creep) vs high ($Re \gg 1$, Euler turbulence) **Reynolds numbers**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Navier-Stokes Equations & Incompressibility Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Nondimensionalization & Force Balance Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Flow Regime & Reynolds Number Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Incompressibility Solenoidal Velocity Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Pressure Lagrange Multiplier Incompressibility Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Incompressible Navier-Stokes momentum equation $\rho (\partial_t \mathbf{u} + (\mathbf{u} \cdot \nabla)\mathbf{u}) = -\nabla p + \mu \nabla^2 \mathbf{u} + \mathbf{f}$ and continuity equation $\nabla \cdot \mathbf{u} = 0$. State the dimensionless equation $\partial_{t^*} \mathbf{u}^* + (\mathbf{u}^* \cdot \nabla^*)\mathbf{u}^* = -\nabla^* p^* + \frac{1}{Re} \nabla^{*2} \mathbf{u}^*$, where the Reynolds number is $Re = \frac{\rho U L}{\mu} = \frac{U L}{\nu}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct terms: (1) material derivative $\frac{D\mathbf{u}}{Dt} = \partial_t \mathbf{u} + (\mathbf{u}\cdot\nabla)\mathbf{u}$ represents fluid parcel acceleration, (2) $-\nabla p$ represents isotropic compressive stresses, (3) $\nu \nabla^2 \mathbf{u}$ represents momentum diffusion by molecular viscosity, (4) $\nabla \cdot \mathbf{u} = 0$ acts as a kinematic constraint ensuring volume conservation.
3. **Slide 3 (`matching`):** Pair 4 flow regimes ($Re \ll 1$ Creeping Stokes flow, $Re \approx 100$ Laminar vortex shedding, $Re \approx 2000$ Laminar-turbulent transition in pipes, $Re > 10^6$ Fully developed turbulent flow) with their physical descriptions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the continuity equation for an incompressible fluid requires the velocity vector field to have zero divergence (solenoidal). Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking: What is the physical mathematical role of the pressure $p$ in incompressible fluid mechanics? (Pressure is NOT determined by a thermodynamic equation of state; it acts as a Lagrange multiplier that enforces the kinematic constraint $\nabla \cdot \mathbf{u} = 0$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "incompressible_navier_stokes_and_reynolds_scaling",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Incompressible Navier-Stokes Equations**\nFor a Newtonian fluid with constant density $\\rho$ and dynamic viscosity $\\mu$ (kinematic viscosity $\\nu = \\mu/\\rho$):\n$$\n\\begin{aligned}\n\\partial_t \\mathbf{u} + (\\mathbf{u} \\cdot \\nabla)\\mathbf{u} &= -\\frac{1}{\\rho}\\nabla p + \\nu \\nabla^2 \\mathbf{u} + \\mathbf{f} \\quad (\\text{Momentum Conservation}) \\\\\n\\nabla \\cdot \\mathbf{u} &= 0 \\quad (\\text{Incompressible Mass Conservation})\n\\end{aligned}\n$$\n• **Nondimensionalization (Reynolds Number $Re = \\frac{U L}{\\nu}$):**\n$$\n\\partial_{t^*} \\mathbf{u}^* + (\\mathbf{u}^* \\cdot \\nabla^*)\\mathbf{u}^* = -\\nabla^* p^* + \\frac{1}{Re} \\nabla^{*2} \\mathbf{u}^*\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Material Derivative $\\frac{D\\mathbf{u}}{Dt}$:** $\\partial_t \\mathbf{u} + (\\mathbf{u} \\cdot \\nabla)\\mathbf{u}$ captures local rate of change plus nonlinear convective transport.\n• **Viscous Diffusion $\\nu \\nabla^2 \\mathbf{u}$:** Dissipates kinetic energy into heat and spreads vorticity smoothly across shear layers.\n• **Low Reynolds ($Re \\ll 1$):** Stokes creeping flow; nonlinear inertia is negligible and the equation becomes linear: $-\\nabla p + \\mu \\nabla^2 \\mathbf{u} = 0$.\n• **High Reynolds ($Re \\gg 1$):** Convective inertia dominates, producing boundary layers, vortex separation, and turbulent cascades."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Reynolds number regime to its characteristic fluid behavior.",
      "matchPairs": [
        { "left": "Re << 1 (Stokes Creeping Flow)", "right": "Time-reversible linear flow dominated by viscous damping (e.g. micro-organisms)" },
        { "left": "Re ~ 100", "right": "Laminar periodic vortex shedding (von Kármán vortex street)" },
        { "left": "Re ~ 2300", "right": "Critical transition threshold from laminar to turbulent pipe flow" },
        { "left": "Re > 10^6 (Fully Turbulent Flow)", "right": "Chaotic multi-scale eddy cascade obeying Kolmogorov -5/3 spectrum" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "For an incompressible fluid, conservation of mass dictates that the velocity vector field must have zero ___ at every point in the domain.",
      "blankAnswer": "divergence",
      "blankDistractors": ["curl", "gradient", "circulation"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the true mathematical role of the pressure term p in the incompressible Navier-Stokes equations?",
      "options": [
        { "text": "Pressure acts as a Lagrange multiplier that instantaneously adjusts throughout the entire domain to strictly enforce the incompressibility constraint div(u) = 0", "isCorrect": true, "explanation": "Correct! In incompressible flow, pressure is not calculated from an equation of state like p = rho R T; it is determined by the constraint nabla . u = 0 via the pressure Poisson equation." },
        { "text": "Pressure is always zero in all fluids", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Pressure is only a boundary force", "isCorrect": false, "explanation": "Incorrect: Pressure varies throughout the entire fluid volume." },
        { "text": "Pressure is equal to fluid temperature", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
