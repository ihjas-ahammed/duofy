# Duofy Reusable Lesson Format: Singular Integrals and Wavelets - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis / Singular_Integrals_and_Wavelets`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute the Hilbert transform of the box/indicator function $f(x) = \mathbf{1}_{[-1, 1]}(x)$, perform dyadic Haar wavelet decompositions on discrete/continuous signals, and verify BMO norms.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hilbert Transform of Box Function Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Principal Value Integration Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Logarithmic Singularity Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Haar Coefficient Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Logarithm BMO Membership Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the worked example: Compute $H(\mathbf{1}_{[-1, 1]})(x) = \frac{1}{\pi} \text{p.v.} \int_{-1}^1 \frac{1}{x - y} dy = \frac{1}{\pi}\ln\left|\frac{x+1}{x-1}\right|$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) set up integral $\frac{1}{\pi}\int_{-1}^1 \frac{dy}{x - y}$, (2) substitute $u = x - y \implies du = -dy$, (3) evaluate $[-\ln|u|]_{x+1}^{x-1} = \ln|x+1| - \ln|x-1|$, (4) obtain $Hf(x) = \frac{1}{\pi}\ln\left|\frac{x+1}{x-1}\right|$, showing jump discontinuities map to logarithmic singularities.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the Hilbert transform of a step function produces logarithmic singularities at the jump locations. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the Haar wavelet detail coefficient $d_0 = \int_0^1 f(x)\psi(x)dx$ for $f(x) = 4x$ where $\psi(x) = \mathbf{1}_{[0, 1/2)} - \mathbf{1}_{[1/2, 1)}$ ($d_0 = \int_0^{1/2} 4x dx - \int_{1/2}^1 4x dx = [2(1/4) - 0] - [2(1) - 2(1/4)] = 0.5 - 1.5 = -1.0$).
5. **Slide 5 (`quiz`):** Quiz asking why $f(x) = \ln|x|$ belongs to $\text{BMO}(\mathbb{R})$ even though it is unbounded and not in $L^\infty(\mathbb{R})$.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Hilbert Transform of the Box Function $f(x) = \\mathbf{1}_{[-1, 1]}(x)$**\nThe Cauchy principal value integral is:\n$$\nHf(x) = \\frac{1}{\\pi} \\text{p.v.} \\int_{-1}^1 \\frac{1}{x - y}\\,dy\n$$\nSubstitute $u = x - y$ ($du = -dy$):\n$$\nHf(x) = -\\frac{1}{\\pi} \\int_{x+1}^{x-1} \\frac{du}{u} = \\frac{1}{\\pi} [\\ln|u|]_{x-1}^{x+1} = \\frac{1}{\\pi} \\ln\\left|\\frac{x + 1}{x - 1}\\right|\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Integral Setup):** On $[-1, 1]$, $f(y) = 1$; outside, $f(y) = 0$.\n• **Step 2 (Evaluate Principal Value):** $\\lim_{\\epsilon \\to 0} [\\int_{-1}^{x-\\epsilon} \\frac{dy}{x-y} + \\int_{x+\\epsilon}^1 \\frac{dy}{x-y}] = \\ln|x+1| - \\ln|x-1|$.\n• **Step 3 (Singularity Appearance):** Near $x = \\pm 1$, $Hf(x)$ exhibits logarithmic blow-up $\\ln|x \\pm 1|$.\n• **Step 4 (Function Space Membership):** While $f \\in L^\\infty$, $Hf \\notin L^\\infty$; instead $Hf \\in \\text{BMO}(\\mathbb{R})$ (Bounded Mean Oscillation)."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The Hilbert transform of a function with jump discontinuities produces ___ singularities at the jump points.",
      "blankAnswer": "logarithmic",
      "blankDistractors": ["polynomial", "delta", "exponential"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Compute the Haar wavelet detail coefficient d_0 = int_0^1 (4x) psi(x) dx, where psi(x) = +1 on [0, 0.5) and -1 on [0.5, 1).",
      "numericAnswer": -1.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the unbounded function f(x) = ln|x| an element of the BMO (Bounded Mean Oscillation) space?",
      "options": [
        { "text": "The average oscillation (1/|I|) int_I |ln|x| - (ln|x|)_I| dx is uniformly bounded by a constant for all intervals I in R", "isCorrect": true, "explanation": "Correct! Logarithmic growth is slow enough that its mean deviation from its local average on any interval is uniformly bounded by a universal constant." },
        { "text": "Because ln|x| is bounded by 10", "isCorrect": false, "explanation": "Incorrect: ln|x| is unbounded as x -> 0 and x -> infinity." },
        { "text": "Because ln|x| is periodic", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because its derivative is zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
