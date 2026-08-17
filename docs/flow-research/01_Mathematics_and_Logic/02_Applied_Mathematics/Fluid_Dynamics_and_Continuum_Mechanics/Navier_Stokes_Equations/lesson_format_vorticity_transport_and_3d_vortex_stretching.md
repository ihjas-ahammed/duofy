# Duofy Reusable Lesson Format: Vorticity Dynamics and 3D Vortex Stretching

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Fluid_Dynamics_and_Continuum_Mechanics / Navier_Stokes_Equations`  
**Lesson Format Type:** `vorticity_transport_and_3d_vortex_stretching`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to evaluate the **Vorticity Transport Equation** $\partial_t \mathbf{\omega} + (\mathbf{u}\cdot\nabla)\mathbf{\omega} = (\mathbf{\omega}\cdot\nabla)\mathbf{u} + \nu \nabla^2 \mathbf{\omega}$, understand the physical mechanism of **3D Vortex Stretching** ($(\mathbf{\omega}\cdot\nabla)\mathbf{u}$), evaluate the **Beale-Kato-Majda (BKM) blowup criterion**, and compute vorticity fields.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Vorticity Equation & Vortex Stretching Formulation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Vortex Stretching Mechanism Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Vorticity Vector Curl Property Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical 2D Vorticity Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Beale-Kato-Majda (BKM) Regularity Criterion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of vorticity $\mathbf{\omega} = \nabla \times \mathbf{u}$. Taking the curl of the Navier-Stokes momentum equations yields the Vorticity Transport Equation: $\partial_t \mathbf{\omega} + (\mathbf{u} \cdot \nabla)\mathbf{\omega} = (\mathbf{\omega} \cdot \nabla)\mathbf{u} + \nu \nabla^2 \mathbf{\omega}$. Emphasize that in 2D, $\mathbf{\omega} = (0, 0, \omega_z)$ is perpendicular to the plane of motion, so the vortex stretching term $(\mathbf{\omega} \cdot \nabla)\mathbf{u} \equiv 0$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 physical steps of 3D vortex stretching: (1) if a vortex filament aligned along the $z$-axis experiences positive strain $\partial u_z / \partial z > 0$, the filament is stretched along $z$, (2) by incompressibility ($\partial u_x/\partial x + \partial u_y/\partial y + \partial u_z/\partial z = 0$), the cross-sectional area $A$ of the vortex tube must shrink, (3) by Kelvin's Circulation Theorem ($\Gamma = \omega A = \text{const}$), shrinking area $A \to 0$ forces vorticity $\omega \to \infty$ (conservation of angular momentum / spinning ice skater effect), (4) this creates intense, localized vortex filaments and drives energy cascade in 3D turbulence.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that vorticity is defined as the mathematical curl of the fluid velocity vector field. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the scalar vorticity $\omega_z = \frac{\partial v}{\partial x} - \frac{\partial u}{\partial y}$ for velocity field $u(x, y) = -3y, v(x, y) = 4x$ (numeric answer: $4 - (-3) = 7.0$).
5. **Slide 5 (`quiz`):** Quiz on the Beale-Kato-Majda (BKM, 1984) theorem: What condition on vorticity guarantees that a smooth 3D Euler or Navier-Stokes solution does not develop a singularity up to time $T$? ($\int_0^T \|\mathbf{\omega}(t)\|_{L^\infty} dt < \infty$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "vorticity_transport_and_3d_vortex_stretching",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The Vorticity Transport Equation and 3D Vortex Stretching**\n• The **vorticity** vector field is defined as $\\mathbf{\\omega} = \\nabla \\times \\mathbf{u}$.\n• Taking the curl of the incompressible Navier-Stokes momentum equation yields:\n$$\n\\partial_t \\mathbf{\\omega} + (\\mathbf{u} \\cdot \\nabla)\\mathbf{\\omega} = (\\mathbf{\\omega} \\cdot \\nabla)\\mathbf{u} + \\nu \\nabla^2 \\mathbf{\\omega}\n$$\n• **The Vortex Stretching Term $(\\mathbf{\\omega} \\cdot \\nabla)\\mathbf{u}$:**\n  - In **2D Flow:** $\\mathbf{\\omega} = (0, 0, \\omega_z)$ is perpendicular to flow, so $(\\mathbf{\\omega} \\cdot \\nabla)\\mathbf{u} \\equiv 0$.\n  - In **3D Flow:** Velocity gradients can stretch vortex tubes, amplifying vorticity locally without bound."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Extensional Strain):** Consider a vortex filament aligned along the $z$-axis experiencing tensile stretching $\\frac{\\partial u_z}{\\partial z} > 0$.\n• **Step 2 (Incompressible Cross-Section Contraction):** Since $\\nabla \\cdot \\mathbf{u} = 0$, stretching along $z$ forces the tube cross-sectional area $A$ to shrink.\n• **Step 3 (Kelvin's Circulation Invariance):** Circulation $\\Gamma = \\oint \\mathbf{u} \\cdot d\\mathbf{r} = \\int \\mathbf{\\omega} \\cdot d\\mathbf{A} \\approx \\omega A$ is conserved in inviscid flow.\n• **Step 4 (Vorticity Amplification):** As $A \\to 0$, $\\omega = \\Gamma / A \\to \\infty$ (like a spinning figure skater pulling in their arms), cascading kinetic energy to Kolmogorov dissipation scales."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The fluid vorticity vector field omega is defined mathematically as the ___ of the velocity vector field u.",
      "blankAnswer": "curl",
      "blankDistractors": ["divergence", "gradient", "laplacian"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the scalar 2D vorticity omega_z = dv/dx - du/dy for the velocity field u(x, y) = -3y and v(x, y) = 4x.",
      "numericAnswer": 7.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the Beale-Kato-Majda (BKM, 1984) blowup criterion for 3D incompressible fluid flow on a time interval [0, T]?",
      "options": [
        { "text": "A smooth solution ceases to exist at t = T (develops a finite-time blowup singularity) if and only if the time-integral of the maximum vorticity diverges: int_0^T ||omega(t)||_infty dt = infty", "isCorrect": true, "explanation": "Correct! The BKM theorem proves that vorticity accumulation is the sole mechanism responsible for potential singularity formation in 3D incompressible Euler/Navier-Stokes." },
        { "text": "A singularity forms if pressure reaches 1 atmosphere", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A singularity forms if Reynolds number equals 100", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Singularities never form under any conditions", "isCorrect": false, "explanation": "Incorrect: While unproven for Navier-Stokes, BKM is the criterion." }
      ]
    }
  ]
}
```
