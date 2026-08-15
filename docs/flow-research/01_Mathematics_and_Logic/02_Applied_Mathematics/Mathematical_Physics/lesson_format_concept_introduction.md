# Duofy Reusable Lesson Format: Mathematical Physics - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Symplectic Geometry $(M, \omega)$, Quantum Hilbert Space $H$, Self-Adjoint Observables, Schrödinger Time Evolution $i\hbar \frac{\partial \psi}{\partial t} = H \psi$, and General Relativity Spacetime Geometry.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Mathematical Physics & Formulation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Classical vs Quantum vs Relativity Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Physics Formalism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Poisson Bracket Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Self-Adjoint Observable Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Mathematical Formulations of Physics**\n1. **Classical Phase Space:** Symplectic manifold $(M, \\omega)$ with closed non-degenerate 2-form $\\omega = \\sum dq_i \\wedge dp_i$.\n2. **Quantum State Space:** Complex Hilbert space $\\mathcal{H}$. Physical observables are **self-adjoint operators** $A = A^\\dagger$.\n$$\ni\\hbar \\frac{\\partial \\psi}{\\partial t} = H \\psi, \\quad \\langle A \\rangle = \\langle \\psi, A \\psi \\rangle\n$$\n3. **General Relativity:** 4D Pseudo-Riemannian Spacetime $(M, g_{\\mu\\nu})$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Symplectic Geometry:** Hamilton's equations $\\dot{q}_i = \\frac{\\partial H}{\\partial p_i}, \\dot{p}_i = -\\frac{\\partial H}{\\partial q_i}$ describe vector fields $X_H$ preserving 2-form $\\omega$.\n• **Poisson Brackets:** $\{f, g\} = \\sum \\left(\\frac{\\partial f}{\\partial q_i} \\frac{\\partial g}{\\partial p_i} - \\frac{\\partial f}{\\partial p_i} \\frac{\\partial g}{\\partial q_i}\\right)$. Time evolution: $\\frac{df}{dt} = \\{f, H\\}$.\n• **Quantum Commutators:** Canonical quantization replaces Poisson brackets with operator commutators: $[A, B] = A B - B A = i \\hbar \\{f, g\\}$.\n• **Einstein Field Equations:** $R_{\\mu\\nu} - \\frac{1}{2} R g_{\\mu\\nu} + \\Lambda g_{\\mu\\nu} = \\frac{8\\pi G}{c^4} T_{\\mu\\nu}$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each physical theory to its exact mathematical framework.",
      "matchPairs": [
        { "left": "Hamiltonian Mechanics", "right": "Symplectic Manifold (M, ω) and Poisson Brackets" },
        { "left": "Quantum Mechanics", "right": "Complex Hilbert Space H and Self-Adjoint Operators" },
        { "left": "General Relativity", "right": "4D Pseudo-Riemannian Manifold with Lorentzian signature (-,+,+,+)" },
        { "left": "Quantum Field Theory QFT", "right": "Feynman Path Integral ∫ Dϕ e^(i S[ϕ] / ħ)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In quantum mechanics, physical observables must be represented by linear operators that are ___.",
      "blankAnswer": "self-adjoint",
      "blankDistractors": ["unitary", "compact", "projection"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why must quantum mechanical observables be self-adjoint operators $A = A^\dagger$?",
      "options": [
        { "text": "The Spectral Theorem guarantees that self-adjoint operators have real eigenvalues (measurable measurement outcomes)", "isCorrect": true, "explanation": "Correct! Real eigenvalues ensure physical measurements yield real numbers." },
        { "text": "Because non-self-adjoint operators cannot act on vectors", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because energy is always negative", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because probabilities must sum to 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
