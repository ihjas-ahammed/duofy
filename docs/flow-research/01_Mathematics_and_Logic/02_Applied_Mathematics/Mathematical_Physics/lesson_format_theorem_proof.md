# Duofy Reusable Lesson Format: Mathematical Physics - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through landmark mathematical physics proofs: Noether's Theorem (Symmetry $\implies$ Conservation Law), Spectral Theorem for Quantum Observables, and Liouville's Theorem in Phase Space.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Noether's Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Variational Invariance Proof Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Conserved Quantity Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Poisson Bracket Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Conserved Current Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Noether's Theorem**\nFor any continuous 1-parameter symmetry of the action functional $S[q] = \\int L(q, \\dot{q}, t) dt$, there exists a corresponding **conserved quantity** (constant of motion):\n$$\n\\frac{d}{dt} Q(q, \\dot{q}) = 0, \\quad Q = \\sum_{i} \\frac{\\partial L}{\\partial \\dot{q}_i} \\delta q_i - K\n$$\n*Time translation symmetry $\\implies$ Energy conservation; Spatial translation symmetry $\\implies$ Momentum conservation.*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove Noether's Theorem for field theories.",
      "orderItems": [
        "Consider continuous transformation ϕ -> ϕ + ε δϕ leaving Lagrangian L invariant up to divergence ∂_μ K^μ.",
        "Compute variation of Lagrangian δL = (∂L / ∂ϕ) δϕ + (∂L / ∂(∂_μ ϕ)) δ(∂_μ ϕ).",
        "Apply Euler-Lagrange equations ∂_μ (∂L / ∂(∂_μ ϕ)) = ∂L / ∂ϕ to substitute for ∂L / ∂ϕ.",
        "Rewrite variation as total divergence ∂_μ [ (∂L / ∂(∂_μ ϕ)) δϕ ] = ∂_μ K^μ.",
        "Define Noether current J^μ = (∂L / ∂(∂_μ ϕ)) δϕ - K^μ and conclude continuity equation ∂_μ J^μ = 0."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What conserved physical quantity corresponds to rotational symmetry (invariance under spatial rotations $SO(3)$)?",
      "options": [
        { "text": "Angular Momentum", "isCorrect": true, "explanation": "Correct! Rotational invariance implies angular momentum conservation." },
        { "text": "Linear Momentum", "isCorrect": false, "explanation": "Incorrect: Corresponds to spatial translation invariance." },
        { "text": "Total Energy", "isCorrect": false, "explanation": "Incorrect: Corresponds to time translation invariance." },
        { "text": "Electric Charge", "isCorrect": false, "explanation": "Incorrect: Corresponds to U(1) gauge symmetry." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Liouville's Theorem in Symplectic Geometry",
      "interactiveSteps": [
        { "stepText": "Let $\\omega = \\sum dq_i \\wedge dp_i$ be the symplectic form on phase space $M^{2n}$." },
        {
          "prompt": "What is the phase space volume form $\\Omega$?",
          "options": [
            { "text": "Ω = ω^n / n! (the n-th exterior power of ω)", "isCorrect": true },
            { "text": "Ω = ω", "isCorrect": false },
            { "text": "Ω = d H", "isCorrect": false },
            { "text": "Ω = 0", "isCorrect": false }
          ]
        },
        { "stepText": "Since Lie derivative $\\mathcal{L}_{X_H} \\omega = d(i_{X_H} \\omega) + i_{X_H} d\\omega = d(-dH) + 0 = 0$, Hamiltonian flow preserves phase space volume!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What continuity equation ∂_μ J^μ = 0 expresses conservation of Noether charges?",
      "blankAnswer": "continuity"
    }
  ]
}
```
