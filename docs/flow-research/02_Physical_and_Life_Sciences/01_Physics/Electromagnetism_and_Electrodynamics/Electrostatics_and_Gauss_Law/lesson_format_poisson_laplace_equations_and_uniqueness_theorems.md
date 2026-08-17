# Duofy Reusable Lesson Format: Poisson/Laplace Equations and Uniqueness Theorems

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Electromagnetism_and_Electrodynamics / Electrostatics_and_Gauss_Law`  
**Lesson Format Type:** `poisson_laplace_equations_and_uniqueness_theorems`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through differential boundary value problems in electrostatics: formulate **Poisson's Equation ($\nabla^2 V = -\frac{\rho}{\epsilon_0}$)** and **Laplace's Equation ($\nabla^2 V = 0$)**, prove the **Mean Value Property** and **No Local Extrema Theorem** of harmonic functions, prove the **First Uniqueness Theorem** (Dirichlet boundary conditions) and **Second Uniqueness Theorem** (Neumann boundary conditions / conductors), and solve 2D Cartesian and 3D Spherical separation of variables.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Poisson/Laplace Equations & Uniqueness Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Proof of the First Uniqueness Theorem Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Boundary Condition Type & Mathematical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Laplace Harmonic Function Extrema Occurrence Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Earnshaw's Theorem on Stable Electrostatic Trapping Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the fundamental differential equations of electrostatic scalar potential $V(\mathbf{r})$ (where $\mathbf{E} = -\nabla V$):
   - **Poisson's Equation (General):**
     $$\nabla^2 V = -\frac{\rho}{\epsilon_0}$$
   - **Laplace's Equation (Charge-Free Regions, $\rho = 0$):**
     $$\nabla^2 V = 0$$
   - **Properties of Harmonic Functions (Solutions to Laplace's Equation):**
     1. **Mean Value Property:** $V(\mathbf{r})$ at any point equals the average value of $V$ over any surrounding sphere: $V(\mathbf{r}) = \frac{1}{4\pi R^2} \oint_{\text{sphere}} V \, dA$.
     2. **No Local Maxima or Minima:** Extrema can ONLY occur on the boundary surfaces!
   - **The First Uniqueness Theorem:** The solution to Poisson's equation $\nabla^2 V = -\rho/\epsilon_0$ in a volume $V$ is **uniquely determined** if the potential $V$ is specified on the entire boundary surface $\partial V$ (Dirichlet Boundary Conditions).
2. **Slide 2 (`ordering`):** Provide 5 steps proving the First Uniqueness Theorem: (1) suppose two distinct solutions $V_1$ and $V_2$ exist satisfying $\nabla^2 V_1 = -\rho/\epsilon_0$ and $\nabla^2 V_2 = -\rho/\epsilon_0$ with identical boundary values $V_1 = V_2 = V_{\text{bound}}$ on $\partial V$, (2) define the difference function $V_3 \equiv V_1 - V_2$, (3) observe that $V_3$ satisfies Laplace's equation $\nabla^2 V_3 = \nabla^2 V_1 - \nabla^2 V_2 = 0$ inside volume $V$, and $V_3 = 0$ on boundary $\partial V$, (4) apply vector identity $\nabla \cdot (V_3 \nabla V_3) = V_3 \nabla^2 V_3 + |\nabla V_3|^2 = |\nabla V_3|^2$ and integrate over $V$: $\iiint_V |\nabla V_3|^2 dV = \oint_{\partial V} V_3 \nabla V_3 \cdot d\mathbf{A} = 0$, (5) since the integrand $|\nabla V_3|^2 \ge 0$ is non-negative and integrates to 0, $\nabla V_3 = \mathbf{0} \implies V_3 = \text{const} = 0 \implies V_1 = V_2$ everywhere (Uniqueness proven!)!
3. **Slide 3 (`matching`):** Pair 4 boundary condition types (Dirichlet Boundary Condition, Neumann Boundary Condition, Mixed / Robin Condition, Grounded Conductor) with their mathematical constraints ($V(\mathbf{r})$ specified on boundary, Normal derivative $\frac{\partial V}{\partial n}$ specified, Linear combination $\alpha V + \beta \frac{\partial V}{\partial n}$ specified, $V = 0$ on conducting surface).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that by the maximum principle, solutions to Laplace's equation cannot have local extrema in the interior, so all maxima and minima must occur on the boundary. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Earnshaw's Theorem (Samuel Earnshaw, 1842): Why is it physically impossible to trap a charged particle in stable static equilibrium using ONLY electrostatic fields? (Because Laplace's equation $\nabla^2 V = \frac{\partial^2 V}{\partial x^2} + \frac{\partial^2 V}{\partial y^2} + \frac{\partial^2 V}{\partial z^2} = 0$ requires that the second derivatives cannot all be positive simultaneously; therefore, $V(\mathbf{r})$ can NEVER have a local 3D minimum in free space, so any electrostatic saddle point is unstable in at least one direction).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "poisson_laplace_equations_and_uniqueness_theorems",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Poisson/Laplace Equations and Uniqueness**\n• **Electrostatic Potential Equations:**\n$$\n\\nabla^2 V = -\\frac{\\rho}{\\epsilon_0} \\quad (\\text{Poisson's}), \\qquad \\nabla^2 V = 0 \\quad (\\text{Laplace's in charge-free region})\n$$\n• **Properties of Harmonic Solutions $\\nabla^2 V = 0$:**\n  - **Mean Value Property:** $V(\\mathbf{r}) = \\frac{1}{4\\pi R^2} \\oint_{\\text{sphere}} V \\, dA$.\n  - **No Local Extrema:** Extremum values occur strictly on the boundary $\\partial V$.\n• **The First Uniqueness Theorem:**\n  Specifying the potential $V$ on the bounding surface $\\partial V$ (**Dirichlet Boundary Conditions**) guarantees a **unique mathematical solution** $V(\\mathbf{r})$ throughout the interior!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the vector identity steps proving the First Uniqueness Theorem for Dirichlet boundary conditions.",
      "orderItems": [
        "Assume two different solutions V_1 and V_2 exist satisfying Poisson's equation with identical boundary values V_bound",
        "Define difference function V_3 = V_1 - V_2, which satisfies Laplace's equation Laplacian(V_3) = 0 and vanishes on the boundary (V_3 = 0 on dV)",
        "Apply the divergence identity: div(V_3 grad(V_3)) = V_3 Laplacian(V_3) + |grad(V_3)|^2 = |grad(V_3)|^2",
        "Apply Divergence Theorem over volume V: int_V |grad(V_3)|^2 dV = oint_{dV} V_3 grad(V_3) . dA = 0 (since V_3 = 0 on boundary)",
        "Since the integrand |grad(V_3)|^2 >= 0 is strictly non-negative and integrates to zero, grad(V_3) = 0 => V_1 = V_2 everywhere"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each boundary condition type to its mathematical definition.",
      "matchPairs": [
        { "left": "Dirichlet Boundary Condition", "right": "Potential V(r) is explicitly specified on the entire boundary surface dV" },
        { "left": "Neumann Boundary Condition", "right": "Normal derivative dV/dn (electric field E_perp) is specified on the boundary" },
        { "left": "Grounded Conducting Boundary", "right": "Dirichlet condition with potential fixed at V = 0 everywhere on the conductor" },
        { "left": "Isolated Conductor with Total Charge Q", "right": "Surface is an equipotential (V = const) with surface integral oint E . dA = Q / eps_0" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "For any solution to Laplace's equation in a charge-free volume, all local maxima and minima must occur on the ___ of the region.",
      "blankAnswer": "boundary",
      "blankDistractors": ["center", "interior", "origin"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the physical statement and proof of Earnshaw's Theorem (1842) in electrostatics?",
      "options": [
        { "text": "A charged particle CANNOT be held in stable static equilibrium by electrostatic forces alone, because Laplace's equation d²V/dx² + d²V/dy² + d²V/dz² = 0 requires that the curvature cannot be positive in all 3 directions simultaneously (forming a saddle point, not a potential well)", "isCorrect": true, "explanation": "Correct! Stable equilibrium requires a local minimum in potential energy (d^2V/dx^2 > 0, d^2V/dy^2 > 0, d^2V/dz^2 > 0). But in charge-free space, their sum is Laplacian(V) = 0, which makes a true 3D local minimum mathematically impossible." },
        { "text": "Electric charge can never be created or destroyed", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "All conductors must be grounded", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Electric fields cannot travel through glass", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
