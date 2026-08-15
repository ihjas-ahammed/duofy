# Duofy Reusable Lesson Format: Fluid Dynamics - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Fluid_Dynamics_and_Continuum_Mechanics`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through core derivations in fluid mechanics: Bernoulli's Principle along streamlines, Kelvin's Circulation Theorem, and Cauchy's Stress Tensor derivation.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bernoulli's Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Euler Equation Integration Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Irrotational Circulation Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Streamline Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Stagnation Pressure Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Bernoulli's Equation along a Streamline**\nFor steady, inviscid, incompressible fluid flow under gravity:\n$$\np + \\frac{1}{2} \\rho u^2 + \\rho g z = \\text{constant}\n$$\n*Dynamic pressure $\\frac{1}{2}\\rho u^2$ plus static pressure $p$ plus hydrostatic pressure $\\rho g z$ remains conserved along any streamline.*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to derive Bernoulli's Equation from Euler's Equation.",
      "orderItems": [
        "Start with Euler's equation for inviscid flow: (u · ∇)u = - (1/ρ) ∇p - g k_hat.",
        "Use vector identity (u · ∇)u = ∇(1/2 |u|^2) - u × (∇ × u).",
        "Substitute vector identity into Euler's equation: ∇(1/2 |u|^2 + p/ρ + g z) = u × ω.",
        "Take inner product with differential line element ds along a streamline (ds || u).",
        "Since (u × ω) · ds = 0 along streamline, conclude ∇(1/2 |u|^2 + p/ρ + g z) · ds = 0, yielding constant sum."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What does **Kelvin's Circulation Theorem** state for inviscid, barotropic fluid flow under conservative body forces?",
      "options": [
        { "text": "Circulation Γ = ∮ u · ds around a closed material contour remains constant in time (dΓ/dt = 0)", "isCorrect": true, "explanation": "Correct! Inviscid, barotropic flows preserve circulation around closed material loops." },
        { "text": "Viscosity is always infinite", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Pressure is constant everywhere", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Velocity is zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Cauchy's Stress Tensor Symmetry $\\boldsymbol{\\sigma} = \\boldsymbol{\\sigma}^T$",
      "interactiveSteps": [
        { "stepText": "Consider conservation of angular momentum on a small fluid element of size $dx dy dz$." },
        {
          "prompt": "Requiring zero net torque as element volume shrinks $dV \\to 0$ forces stress tensor components $\\sigma_{xy}$ and $\\sigma_{yx}$ to be ___?",
          "options": [
            { "text": "Equal (σ_xy = σ_yx)", "isCorrect": true },
            { "text": "Zero", "isCorrect": false },
            { "text": "Opposite in sign", "isCorrect": false },
            { "text": "Infinite", "isCorrect": false }
          ]
        },
        { "stepText": "Thus the Cauchy Stress Tensor is symmetric: $\\boldsymbol{\\sigma} = \\boldsymbol{\\sigma}^T$, eliminating internal body couples!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What physical quantity Γ = ∮ u · ds represents the line integral of velocity around a closed contour?",
      "blankAnswer": "circulation"
    }
  ]
}
```
