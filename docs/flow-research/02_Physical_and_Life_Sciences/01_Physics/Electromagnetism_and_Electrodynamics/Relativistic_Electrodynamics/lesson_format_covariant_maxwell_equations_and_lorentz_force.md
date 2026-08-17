# Duofy Reusable Lesson Format: Covariant Maxwell Equations and Lorentz Force

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Electromagnetism_and_Electrodynamics / Relativistic_Electrodynamics`  
**Lesson Format Type:** `covariant_maxwell_equations_and_lorentz_force`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the manifestly covariant formulation of electrodynamics: formulate the inhomogeneous Maxwell equation **$\partial_\mu F^{\mu\nu} = \mu_0 J^\nu$** (reproducing Gauss's Law and the Ampère-Maxwell Law), formulate the homogeneous Maxwell equation **$\partial_\mu \tilde{F}^{\mu\nu} = 0$** (reproducing Gauss for B and Faraday's Law), derive the **Relativistic Lorentz Four-Force Law ($\frac{dP^\mu}{d\tau} = q F^{\mu\nu} U_\nu$)**, and formulate the **Symmetric Energy-Momentum Stress Tensor ($T^{\mu\nu}$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Covariant Maxwell Equations & Lorentz Four-Force Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Expansion of d_mu F^{mu nu} = mu_0 J^nu Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Covariant Equation & Classical Vector Law Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Relativistic Lorentz Force 4-Velocity Lower Index Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Conservation of Charge as Implication of Tensor Antisymmetry Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Manifestly Covariant Maxwell Equations (Hermann Minkowski, 1908):
   - **1. Inhomogeneous Maxwell Equations ($\nu = 0, 1, 2, 3$):**
     $$\partial_\mu F^{\mu\nu} = \mu_0 J^\nu$$
     - $\nu = 0 \implies \nabla \cdot \mathbf{E} = \frac{\rho}{\epsilon_0}$ (Gauss's Law).
     - $\nu = 1, 2, 3 \implies \nabla \times \mathbf{B} - \frac{1}{c^2}\frac{\partial\mathbf{E}}{\partial t} = \mu_0 \mathbf{J}$ (Ampère-Maxwell Law).
   - **2. Homogeneous Maxwell Equations (Bianchi Identity):**
     $$\partial_\mu \tilde{F}^{\mu\nu} = 0 \iff \partial_\lambda F_{\mu\nu} + \partial_\mu F_{\nu\lambda} + \partial_\nu F_{\lambda\mu} = 0$$
     - $\nu = 0 \implies \nabla \cdot \mathbf{B} = 0$ (No magnetic monopoles).
     - $\nu = 1, 2, 3 \implies \nabla \times \mathbf{E} + \frac{\partial\mathbf{B}}{\partial t} = \mathbf{0}$ (Faraday's Law).
   - **Relativistic Lorentz Four-Force:**
     $$\frac{dP^\mu}{d\tau} = q F^{\mu\nu} U_\nu = \gamma \left( \frac{\mathbf{F}\cdot\mathbf{v}}{c}, \mathbf{F} \right)$$
2. **Slide 2 (`ordering`):** Provide 5 steps expanding $\partial_\mu F^{\mu 0} = \mu_0 J^0$: (1) write 4-divergence sum: $\partial_0 F^{00} + \partial_1 F^{10} + \partial_2 F^{20} + \partial_3 F^{30} = \mu_0 J^0$, (2) substitute diagonal $F^{00} = 0$, (3) substitute $F^{10} = -F^{01} = -(-E_x/c) = E_x/c$, etc., (4) evaluate spatial derivatives: $\frac{\partial(E_x/c)}{\partial x} + \frac{\partial(E_y/c)}{\partial y} + \frac{\partial(E_z/c)}{\partial z} = \frac{1}{c}(\nabla \cdot \mathbf{E})$, (5) equate to $\mu_0 J^0 = \mu_0 (c\rho) = \frac{\rho}{\epsilon_0 c} \implies \nabla \cdot \mathbf{E} = \frac{\rho}{\epsilon_0}$ (Gauss's Law derived!)!
3. **Slide 3 (`matching`):** Pair 4 covariant equations ($\partial_\mu F^{\mu 0} = \mu_0 J^0$, $\partial_\mu F^{\mu i} = \mu_0 J^i$, $\partial_\mu \tilde{F}^{\mu 0} = 0$, $\partial_\mu \tilde{F}^{\mu i} = 0$) with their classical 3D vector laws.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in the relativistic Lorentz force law dP^mu/dtau = q F^{mu nu} U_nu, the 4-velocity U has a lower (covariant) index. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on how charge conservation is guaranteed automatically by covariant Maxwell equations: Why does $\partial_\mu F^{\mu\nu} = \mu_0 J^\nu$ mathematically GUARANTEE the continuity equation $\partial_\nu J^\nu = 0$? (Because taking the 4-divergence $\partial_\nu(\partial_\mu F^{\mu\nu}) = \mu_0 \partial_\nu J^\nu$; the LHS is the contraction of a symmetric differential operator $\partial_\nu \partial_\mu$ with an antisymmetric tensor $F^{\mu\nu}$, which is IDENTICALLY ZERO, proving $\partial_\nu J^\nu = 0$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "covariant_maxwell_equations_and_lorentz_force",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Covariant Maxwell Equations and Lorentz Four-Force**\n• **The Inhomogeneous Maxwell Equation:**\n$$\n\\partial_\\mu F^{\\mu\\nu} = \\mu_0 J^\\nu \\qquad (\\text{Gauss's Law } + \\text{ Ampère-Maxwell Law})\n$$\n• **The Homogeneous Maxwell Equation:**\n$$\n\\partial_\\mu \\tilde{F}^{\\mu\\nu} = 0 \\qquad (\\text{Gauss for B } + \\text{ Faraday's Law})\n$$\n• **Relativistic Lorentz Four-Force Law:**\n$$\n\\frac{dP^\\mu}{d\\tau} = q F^{\\mu\\nu} U_\\nu = \\gamma \\left( \\frac{\\mathbf{F} \\cdot \\mathbf{v}}{c}, \\, \\mathbf{F}_{\\text{3D}} \\right)\n$$\n  *(Unifies mechanical work rate $\\mathbf{F}\\cdot\\mathbf{v}$ and 3D Lorentz force $\\mathbf{F} = q(\\mathbf{E} + \\mathbf{v}\\times\\mathbf{B})$ into a single 4-vector!).*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the tensor expansion steps proving d_mu F^{mu 0} = mu_0 J^0 recovers Gauss's Law.",
      "orderItems": [
        "Write the 4-divergence sum for index nu = 0: d_0 F^{00} + d_1 F^{10} + d_2 F^{20} + d_3 F^{30} = mu_0 J^0",
        "Set diagonal element F^{00} = 0 and substitute spatial tensor elements F^{10} = E_x/c, F^{20} = E_y/c, F^{30} = E_z/c",
        "Express spatial derivatives as a 3D divergence: d_1(E_x/c) + d_2(E_y/c) + d_3(E_z/c) = (1/c) * div(E)",
        "Substitute the temporal four-current component: mu_0 J^0 = mu_0 * (c * rho) = rho / (eps_0 * c)",
        "Multiply across by c to arrive at Gauss's Law in matter-free space: div(E) = rho / eps_0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each covariant Maxwell equation component to its 3D vector law.",
      "matchPairs": [
        { "left": "d_mu F^{mu 0} = mu_0 J^0", "right": "Gauss's Law: div(E) = rho / eps_0" },
        { "left": "d_mu F^{mu i} = mu_0 J^i", "right": "Ampère-Maxwell Law: curl(B) - (1/c^2) dE/dt = mu_0 J" },
        { "left": "d_mu tilde{F}^{mu 0} = 0", "right": "Gauss's Law for Magnetism: div(B) = 0" },
        { "left": "d_mu tilde{F}^{mu i} = 0", "right": "Faraday's Law of Induction: curl(E) + dB/dt = 0" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the relativistic Lorentz four-force equation dP^mu/dtau = q F^{mu nu} U_nu, the index on four-velocity U is a ___ covariant index.",
      "blankAnswer": "lower",
      "blankDistractors": ["upper", "squared", "contravariant"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How do the Covariant Maxwell Equations mathematically guarantee local conservation of electric charge (d_nu J^nu = 0)?",
      "options": [
        { "text": "Taking the 4-divergence d_nu(d_mu F^mu nu) = mu_0 d_nu J^nu; because d_nu d_mu is SYMMETRIC while F^mu nu is ANTISYMMETRIC, their contraction vanishes identically (0 = mu_0 d_nu J^nu => d_nu J^nu = 0)", "isCorrect": true, "explanation": "Correct! Contraction of any symmetric differential operator d_mu d_nu with an antisymmetric tensor F^mu nu is identically zero. Thus, Maxwell's field equations mathematically require exact charge conservation." },
        { "text": "Charge conservation is an unproven assumption", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because light has zero charge", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because all four-potentials are zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
