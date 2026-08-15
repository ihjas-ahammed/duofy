# Duofy Reusable Lesson Format: Physics - Concept Introduction

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Maxwell's Equations, Lagrangian Mechanics ($L = T - V$), Schrödinger Wave Equation ($i\hbar \frac{\partial \psi}{\partial t} = H\psi$), and Statistical Partition Functions ($Z = \sum e^{-\beta E_i}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Pillars of Physics & Maxwell Equations Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Action, Wavefunction & Partition Function Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Physics Pillar Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Speed of Light Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Quantum Superposition Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Maxwell's Equations of Electromagnetism**\n1. **Gauss's Law (Electric):** $\\nabla \\cdot \\mathbf{E} = \\frac{\\rho}{\\epsilon_0}$\n2. **Gauss's Law (Magnetic):** $\\nabla \\cdot \\mathbf{B} = 0$ (No magnetic monopoles)\n3. **Faraday's Law:** $\\nabla \\times \\mathbf{E} = -\\frac{\\partial \\mathbf{B}}{\\partial t}$\n4. **Ampère-Maxwell Law:** $\\nabla \\times \\mathbf{B} = \\mu_0 \\mathbf{J} + \\mu_0 \\epsilon_0 \\frac{\\partial \\mathbf{E}}{\\partial t}$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Lagrangian Mechanics ($L = T - V$):** Euler-Lagrange equations $\\frac{d}{dt}\\left(\\frac{\\partial L}{\\partial \\dot{q}_i}\\right) - \\frac{\\partial L}{\\partial q_i} = 0$ enforce stationary action $\\delta S = 0$.\n• **Schrödinger Equation:** $i \\hbar \\frac{\\partial \\psi}{\\partial t} = -\\frac{\\hbar^2}{2m} \\nabla^2 \\psi + V \\psi$ governs quantum probability amplitude $\\psi(x,t)$.\n• **Partition Function ($Z = \\sum e^{-\\beta E_i}$):** Central quantity in statistical mechanics; free energy $F = -k_B T \\ln Z$.\n• **Special Relativity:** Speed of light $c = \\frac{1}{\\sqrt{\\epsilon_0 \\mu_0}}$ is invariant in all inertial frames."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each physical law to its primary equation.",
      "matchPairs": [
        { "left": "Gauss's Law for Magnetism", "right": "grad · B = 0 (No magnetic monopoles)" },
        { "left": "Schrödinger Equation", "right": "i ħ ∂ψ/∂t = H ψ" },
        { "left": "Euler-Lagrange Equation", "right": "d/dt(∂L/∂q_dot) - ∂L/∂q = 0" },
        { "left": "Helmholtz Free Energy F", "right": "F = - k_B T ln Z" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In classical Lagrangian mechanics, the Lagrangian L is defined as kinetic energy T minus ___ energy V.",
      "blankAnswer": "potential",
      "blankDistractors": ["total", "thermal", "magnetic"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why did James Clerk Maxwell add the **displacement current term** $\\mu_0 \\epsilon_0 \\frac{\\partial \\mathbf{E}}{\\partial t}$ to Ampère's Law?",
      "options": [
        { "text": "To satisfy charge conservation (divergence of curl is zero) and predict electromagnetic waves propagating at speed c", "isCorrect": true, "explanation": "Correct! Maxwell's addition completed electromagnetic wave theory." },
        { "text": "To make gravity negative", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because electric fields are scalar", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "To eliminate magnetic fields", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
