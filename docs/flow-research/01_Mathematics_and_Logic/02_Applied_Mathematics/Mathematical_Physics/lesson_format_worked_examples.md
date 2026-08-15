# Duofy Reusable Lesson Format: Mathematical Physics - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute Poisson Brackets $\{f, g\}$, solve Quantum Harmonic Oscillator creation/annihilation operator equations $[a, a^\dagger] = 1$, and compute Christoffel symbols $\Gamma^\lambda_{\mu\nu}$ for metric tensors.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Quantum Operator / Poisson Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Operator Algebra Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Commutator Relation Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Energy Eigenvalue Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Symplectic Matrix Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Quantum Harmonic Oscillator Ladder Operators**\nExpress Hamiltonian $H = \\frac{p^2}{2m} + \\frac{1}{2} m \\omega^2 x^2$ using creation ($a^\\dagger$) and annihilation ($a$) operators:\n$$\na = \\sqrt{\\frac{m\\omega}{2\\hbar}} \\left(x + \\frac{i p}{m\\omega}\\right), \\quad a^\\dagger = \\sqrt{\\frac{m\\omega}{2\\hbar}} \\left(x - \\frac{i p}{m\\omega}\\right)\n$$\nCommutator relation: $[a, a^\\dagger] = 1$. Hamiltonian: $H = \\hbar \\omega \\left(a^\\dagger a + \\frac{1}{2}\\right)$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Compute $[a, a^\\dagger] = \\frac{m\\omega}{2\\hbar} \\left[x + \\frac{ip}{m\\omega}, x - \\frac{ip}{m\\omega}\\right]$.\n• **Step 2:** Expand commutator using linearity: $[x, -ip/m\\omega] + [ip/m\\omega, x]$.\n• **Step 3:** Use canonical commutator $[x, p] = i \\hbar$.\n• **Step 4:** $-i(i\\hbar)/m\\omega + i(i\\hbar)/m\\omega \\implies \\frac{2 \\hbar}{m\\omega} \\cdot \\frac{m\\omega}{2\\hbar} = 1$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The canonical quantum commutator between position x and momentum p is [x, p] = i * ___.",
      "blankAnswer": "ħ",
      "blankDistractors": ["1", "0", "c"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the zero-point ground state energy $E_0 = \\frac{1}{2} \\hbar \\omega$ of a quantum harmonic oscillator with $\\hbar \\omega = 4.0$ eV.",
      "numericAnswer": 2.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the value of the Poisson bracket $\{x^2, p\}$ in classical phase space?",
      "options": [
        { "text": "2x", "isCorrect": true, "explanation": "Correct! {x², p} = (∂(x²)/∂x)(∂p/∂p) - (∂(x²)/∂p)(∂p/∂x) = (2x)(1) - 0 = 2x." },
        { "text": "x²", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "2p", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
