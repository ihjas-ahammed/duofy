# Duofy Reusable Lesson Format: Harmonic Analysis - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Fourier Series, Fourier Transforms $\hat{f}(\xi) = \int f(x) e^{-2\pi i x \xi} dx$, Plancherel Energy Conservation, and Convolution $(f * g)(x)$ as time-frequency duality mappings.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fourier Transform Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Time-Frequency Duality Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Transform Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Convolution Property Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Plancherel Energy Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Fourier Transform**\nFor $f \\in L^1(\\mathbb{R}^n)$, its **Fourier Transform** $\\hat{f}: \\mathbb{R}^n \\to \\mathbb{C}$ is defined as:\n$$\n\\hat{f}(\\xi) = \\int_{\\mathbb{R}^n} f(x) e^{-2\\pi i x \\cdot \\xi} \\, dx\n$$\nInverse Transform: $f(x) = \\int_{\\mathbb{R}^n} \\hat{f}(\\xi) e^{2\\pi i x \\cdot \\xi} \\, d\\xi$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Time-Frequency Duality:** Converts signals from spatial/time domain $x$ into frequency spectrum $\\xi$.\n• **Derivative Property:** Transforms derivatives into algebraic multiplication: $\\widehat{f'}(\\xi) = 2\\pi i \\xi \\hat{f}(\\xi)$.\n• **Convolution Theorem:** $\\widehat{(f * g)}(\\xi) = \\hat{f}(\\xi) \\cdot \\hat{g}(\\xi)$.\n• **Plancherel / Parseval:** Energy is conserved between domains: $\|f\|_{L^2}^2 = \|\\hat{f}\|_{L^2}^2$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Fourier Transform property to its mathematical frequency formula.",
      "matchPairs": [
        { "left": "Derivative f'(x)", "right": "2πi ξ f_hat(ξ)" },
        { "left": "Convolution (f * g)(x)", "right": "f_hat(ξ) * g_hat(ξ)" },
        { "left": "Shift f(x - a)", "right": "e^(-2πi a ξ) * f_hat(ξ)" },
        { "left": "Scaling f(a x)", "right": "(1 / |a|) * f_hat(ξ / a)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Fourier Transform converts spatial convolution into simple algebraic ___ in the frequency domain.",
      "blankAnswer": "multiplication",
      "blankDistractors": ["addition", "integration", "differentiation"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What does the Heisenberg Uncertainty Principle in Harmonic Analysis state about a function $f(x)$ and its Fourier transform $\\hat{f}(\\xi)$?",
      "options": [
        { "text": "They cannot both be sharply localized (Var(x) * Var(ξ) ≥ 1 / (4π))", "isCorrect": true, "explanation": "Correct! Narrow time signals require wide frequency bands." },
        { "text": "They are identical", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Both integrals must equal 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "f(x) must be a polynomial", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
