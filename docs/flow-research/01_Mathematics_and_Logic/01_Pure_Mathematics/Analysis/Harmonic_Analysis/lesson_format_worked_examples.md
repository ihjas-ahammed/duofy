# Duofy Reusable Lesson Format: Harmonic Analysis - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute Gaussian Fourier Transforms $\mathcal{F}\{e^{-a x^2}\}$, evaluate Fourier series coefficients $\hat{f}(n)$, and calculate spatial convolutions $(f * g)(x)$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gaussian Transform Formula Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Square Completion Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Gaussian Invariance Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Fourier Coefficient Computation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Transform Symmetry Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Fourier Transform of a Gaussian**\nFor $f(x) = e^{-\\pi x^2}$, its Fourier transform is an eigenfunction of $\\mathcal{F}$:\n$$\n\\hat{f}(\\xi) = \\int_{-\\infty}^\\infty e^{-\\pi x^2} e^{-2\\pi i x \\xi} \\, dx = e^{-\\pi \\xi^2}\n$$\nThe Gaussian is its own Fourier transform!"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Combine exponent: $-\\pi x^2 - 2\\pi i x \\xi = -\\pi (x^2 + 2i x \\xi)$.\n• **Step 2:** Complete the square: $x^2 + 2i x \\xi = (x + i\\xi)^2 + \\xi^2$.\n• **Step 3:** $\\hat{f}(\\xi) = e^{-\\pi \\xi^2} \\int_{-\\infty}^\\infty e^{-\\pi (x + i\\xi)^2} dx$.\n• **Step 4:** Shift contour in complex plane (Cauchy's Theorem) $\\implies \\int_{-\\infty}^\\infty e^{-\\pi u^2} du = 1$. Thus $\\hat{f}(\\xi) = e^{-\\pi \\xi^2}$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The Gaussian function e^(-π x²) is an eigenfunction of the Fourier transform with eigenvalue equal to ___.",
      "blankAnswer": "one",
      "blankDistractors": ["zero", "pi", "two"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the fundamental Fourier series coefficient $a_0 = \\frac{1}{2\\pi} \\int_{-\\pi}^\\pi x^2 \\, dx$.",
      "numericAnswer": 3.2898,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "If $f(x)$ is a real and even function ($f(-x) = f(x)$), what property does its Fourier transform $\\hat{f}(\\xi)$ possess?",
      "options": [
        { "text": "f_hat(ξ) is also real and even", "isCorrect": true, "explanation": "Correct! Real and even functions transform to real and even spectra." },
        { "text": "f_hat(ξ) is purely imaginary", "isCorrect": false, "explanation": "Incorrect: Real and odd functions transform to purely imaginary spectra." },
        { "text": "f_hat(ξ) = 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "f_hat(ξ) is complex", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
