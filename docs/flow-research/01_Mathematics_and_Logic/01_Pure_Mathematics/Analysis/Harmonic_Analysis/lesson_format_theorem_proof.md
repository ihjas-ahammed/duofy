# Duofy Reusable Lesson Format: Harmonic Analysis - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through core Fourier analysis proofs: Plancherel/Parseval Theorem ($\|f\|_{L^2} = \|\hat{f}\|_{L^2}$), Convolution Theorem, and Poisson Summation Formula.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Plancherel / Parseval Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Proof Strategy & Inner Product Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Isometry & Extension Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Heat Equation Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Plancherel Isometry Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Plancherel / Parseval Theorem**\nFor any function $f \\in L^1(\\mathbb{R}^n) \\cap L^2(\\mathbb{R}^n)$, its Fourier transform $\\hat{f} \\in L^2(\\mathbb{R}^n)$ satisfies:\n$$\n\\int_{\\mathbb{R}^n} |f(x)|^2 \\, dx = \\int_{\\mathbb{R}^n} |\\hat{f}(\\xi)|^2 \\, d\\xi\n$$\nThe Fourier transform extends uniquely to a unitary isometry $\\mathcal{F}: L^2(\\mathbb{R}^n) \\to L^2(\\mathbb{R}^n)$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove Plancherel's Theorem for Schwartz functions S(R).",
      "orderItems": [
        "Let f, g be Schwartz functions in S(R). Express <f_hat, g_hat> as a double integral.",
        "Fubini Theorem: Swap integration order to get ∫ f_hat(ξ) conjugate(g_hat(ξ)) dξ = ∫ f(x) [∫ conjugate(g_hat(ξ)) e^(2πi x ξ) dξ] dx.",
        "Recognize inner integral as inverse Fourier transform of conjugate(g_hat), which equals conjugate(g(x)).",
        "Conclude <f_hat, g_hat> = <f, g> for all Schwartz functions.",
        "Set g = f to obtain ||f_hat||_L2^2 = ||f||_L2^2 and extend to L^2 by density."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What does the Convolution Theorem $\\widehat{(f * g)} = \\hat{f} \\cdot \\hat{g}$ imply for solving partial differential equations?",
      "options": [
        { "text": "Differential operators become simple multiplication, allowing exact solutions via inverse transform", "isCorrect": true, "explanation": "Correct! Fourier transforms convert linear differential equations into algebraic equations." },
        { "text": "PDEs become non-linear", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Integrals become zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Solutions become discontinuous", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Derivation: Solving 1D Heat Equation $u_t = u_{xx}$",
      "interactiveSteps": [
        { "stepText": "Apply spatial Fourier transform to $u_t = u_{xx}$ with $\\hat{u}(\\xi, t) = \\mathcal{F}_x\\{u(x,t)\\}$." },
        {
          "prompt": "Using $\\mathcal{F}\\{u_{xx}\\} = (2\\pi i \\xi)^2 \\hat{u} = -4\\pi^2 \\xi^2 \\hat{u}$, what is the resulting ODE for $\\hat{u}_t$?",
          "options": [
            { "text": "d/dt u_hat(ξ, t) = -4π² ξ² u_hat(ξ, t)", "isCorrect": true },
            { "text": "d/dt u_hat(ξ, t) = 2πi ξ u_hat(ξ, t)", "isCorrect": false },
            { "text": "d/dt u_hat(ξ, t) = 0", "isCorrect": false },
            { "text": "d/dt u_hat(ξ, t) = u_hat(ξ, t)", "isCorrect": false }
          ]
        },
        { "stepText": "Solving ODE yields $\\hat{u}(\\xi, t) = \\hat{u}_0(\\xi) e^{-4\\pi^2 \\xi^2 t}$. Inverse transform yields Gaussian heat kernel convolution!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What mathematical term describes a linear operator that preserves inner products and norms (||F f|| = ||f||)?",
      "blankAnswer": "isometry"
    }
  ]
}
```
