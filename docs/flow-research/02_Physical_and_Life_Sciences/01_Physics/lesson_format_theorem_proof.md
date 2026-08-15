# Duofy Reusable Lesson Format: Physics - Theorem & Proof Derivation

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through landmark physics derivations: Electromagnetic Wave Equation from Maxwell's Equations, Hamilton's Principle of Least Action $\delta S = 0$, and Equipartition Theorem.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Electromagnetic Wave Derivation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Maxwell Vacuum Derivation Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Speed of Light Identity Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Least Action Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Action Functional Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Derivation of Electromagnetic Wave Equation**\nIn a vacuum (charge density $\\rho = 0$, current density $\\mathbf{J} = \\mathbf{0}$), Maxwell's equations yield 3D wave equations for $\\mathbf{E}$ and $\\mathbf{B}$:\n$$\n\\nabla^2 \\mathbf{E} - \\mu_0 \\epsilon_0 \\frac{\\partial^2 \\mathbf{E}}{\\partial t^2} = \\mathbf{0}, \\quad \\nabla^2 \\mathbf{B} - \\mu_0 \\epsilon_0 \\frac{\\partial^2 \\mathbf{B}}{\\partial t^2} = \\mathbf{0}\n$$\nWave propagation speed is $c = \\frac{1}{\\sqrt{\\mu_0 \\epsilon_0}} \\approx 3 \\times 10^8 \\text{ m/s}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to derive the E-field wave equation in vacuum.",
      "orderItems": [
        "Take curl of Faraday's Law: ∇ × (∇ × E) = ∇ × (- ∂B/∂t).",
        "Use vector identity ∇ × (∇ × E) = ∇(∇ · E) - ∇² E on left-hand side.",
        "Apply Gauss's Law in vacuum (∇ · E = 0) so LHS simplifies to - ∇² E.",
        "Exchange derivatives on RHS: - ∂(∇ × B)/∂t.",
        "Substitute Ampère-Maxwell Law in vacuum (∇ × B = μ_0 ε_0 ∂E/∂t) into RHS to obtain ∇² E = μ_0 ε_0 ∂²E/∂t²."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the speed of light $c$ expressed in terms of vacuum permittivity $\\epsilon_0$ and permeability $\\mu_0$?",
      "options": [
        { "text": "c = 1 / sqrt(μ_0 ε_0)", "isCorrect": true, "explanation": "Correct! Maxwell derived c = 1/√(μ_0 ε_0), proving light is an electromagnetic wave." },
        { "text": "c = μ_0 ε_0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "c = sqrt(μ_0 / ε_0)", "isCorrect": false, "explanation": "Incorrect: That is the wave impedance Z_0." },
        { "text": "c = 1 / (μ_0 ε_0)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Hamilton's Principle of Least Action $\\delta S = 0$",
      "interactiveSteps": [
        { "stepText": "Vary action $S[q] = \\int_{t_1}^{t_2} L(q, \\dot{q}, t) dt$ with fixed endpoints $\\delta q(t_1) = \\delta q(t_2) = 0$." },
        {
          "prompt": "Integrating by parts $\\int \\frac{\\partial L}{\\partial \\dot{q}} \\frac{d(\\delta q)}{dt} dt$ yields what term?",
          "options": [
            { "text": "- ∫ d/dt (∂L / ∂q_dot) δq dt", "isCorrect": true },
            { "text": "0", "isCorrect": false },
            { "text": "∫ (∂L / ∂q) dt", "isCorrect": false },
            { "text": "∞", "isCorrect": false }
          ]
        },
        { "stepText": "Requiring $\\delta S = 0$ for arbitrary $\\delta q(t)$ forces Euler-Lagrange equation $\\frac{d}{dt}\\left(\\frac{\\partial L}{\\partial \\dot{q}}\\right) - \\frac{\\partial L}{\\partial q} = 0$!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What scalar integral S = integral L dt represents the quantity minimized along physical trajectories?",
      "blankAnswer": "action"
    }
  ]
}
```
