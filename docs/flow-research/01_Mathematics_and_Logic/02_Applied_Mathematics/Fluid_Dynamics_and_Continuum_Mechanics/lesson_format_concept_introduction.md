# Duofy Reusable Lesson Format: Fluid Dynamics - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Fluid_Dynamics_and_Continuum_Mechanics`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the Continuity Equation ($\nabla \cdot \mathbf{u} = 0$), Navier-Stokes Equations, Reynolds Number ($Re = \frac{\rho U L}{\mu}$), and Potential Flow Theory.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Navier-Stokes & Continuity Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Inertial vs Viscous Force Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Dimensionless Number Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Incompressibility Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | High Reynolds Turbulence Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Navier-Stokes & Continuity Equations**\nFor an incompressible Newtonian fluid of density $\\rho$ and dynamic viscosity $\\mu$:\n$$\n1.\\ \\text{Continuity (Mass): } \\nabla \\cdot \\mathbf{u} = 0\n$$\n$$\n2.\\ \\text{Navier-Stokes (Momentum): } \\rho \\left( \\frac{\\partial \\mathbf{u}}{\\partial t} + (\\mathbf{u} \\cdot \\nabla) \\mathbf{u} \\right) = -\\nabla p + \\mu \\nabla^2 \\mathbf{u} + \\mathbf{f}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Material Derivative:** $\\frac{D \\mathbf{u}}{D t} = \\frac{\\partial \\mathbf{u}}{\\partial t} + (\\mathbf{u} \\cdot \\nabla) \\mathbf{u}$ includes unsteady change + convective acceleration.\n• **Reynolds Number ($Re = \\frac{\\rho U L}{\\mu}$):** Ratio of inertial forces to viscous forces. $Re \\ll 1 \\implies$ Laminar Stokes flow; $Re \\gg 1 \\implies$ Turbulent flow.\n• **Incompressibility:** Constant density $\\frac{D\\rho}{Dt} = 0 \\implies \\nabla \\cdot \\mathbf{u} = 0$.\n• **Potential Flow:** Irrotational flow (vorticity $\\boldsymbol{\\omega} = \\nabla \\times \\mathbf{u} = \\mathbf{0}$) allows velocity potential $\\mathbf{u} = \\nabla \\Phi$ with $\\nabla^2 \\Phi = 0$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each dimensionless fluid number to its physical force ratio.",
      "matchPairs": [
        { "left": "Reynolds Number (Re)", "right": "Inertial Forces / Viscous Forces (Turbulence threshold)" },
        { "left": "Mach Number (Ma)", "right": "Flow Velocity / Speed of Sound (Compressibility threshold)" },
        { "left": "Froude Number (Fr)", "right": "Inertial Forces / Gravitational Forces (Free-surface waves)" },
        { "left": "Weber Number (We)", "right": "Inertial Forces / Surface Tension Forces (Droplet formation)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "For an incompressible fluid, the divergence of the velocity vector field grad dot u is equal to ___.",
      "blankAnswer": "0",
      "blankDistractors": ["1", "rho", "mu"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What happens to the flow regime around an obstacle when the Reynolds number $Re$ increases from $1$ to $10^6$?",
      "options": [
        { "text": "Flow transitions from smooth laminar creeping flow to unsteady, turbulent vortex shedding", "isCorrect": true, "explanation": "Correct! High Re means inertial forces dominate, creating turbulent boundary layer separation." },
        { "text": "Flow becomes completely stationary", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Viscous forces become dominant", "isCorrect": false, "explanation": "Incorrect: Viscous forces dominate at low Re." },
        { "text": "Density becomes zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
