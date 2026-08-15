# Duofy Reusable Lesson Format: Functional Analysis - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Functional_Analysis`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute operator norms $\|T\| = \sup_{\|x\|=1} \|T x\|$, evaluate continuous linear functionals in dual spaces $X^*$, compute spectra $\sigma(T)$ of shift operators, and verify Riesz representations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Operator Norm Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Norm Computation Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Dual Space Representation Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Operator Norm Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Spectrum / Resolvent Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Operator Norm Calculation**\nFor a linear operator $T: X \\to Y$ between normed spaces, the **operator norm** is defined as:\n$$\n\\|T\\| = \\sup_{x \\neq 0} \\frac{\\|T x\\|_Y}{\\|x\\|_X} = \\sup_{\\|x\\|_X = 1} \\|T x\\|_Y\n$$\nIf $\|T\| < \\infty$, $T$ is bounded and continuous."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Consider left shift operator $T: \\ell^2 \\to \\ell^2$ defined by $T(x_1, x_2, x_3, \\dots) = (x_2, x_3, \\dots)$.\n• **Step 2:** $\|T x\|_2^2 = \\sum_{i=2}^\\infty |x_i|^2 \\le \\sum_{i=1}^\\infty |x_i|^2 = \|x\|_2^2$.\n• **Step 3:** Taking square roots $\\implies \|T x\|_2 \\le 1 \\cdot \|x\|_2 \\implies \|T\| \\le 1$.\n• **Step 4:** Test unit vector $x = (0, 1, 0, 0, \\dots) \\implies T x = (1, 0, 0, \\dots)$ with $\|T x\|_2 = 1$. Thus $\|T\| = 1$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "According to the Riesz Representation Theorem for Hilbert space H, every continuous linear functional f in H* can be written uniquely as f(x) = <x, ___>.",
      "blankAnswer": "y",
      "blankDistractors": ["0", "x", "1"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Compute the operator norm $\|T\|$ of integral operator $T: C[0, 1] \\to C[0, 1]$ given by $T f(x) = \\int_0^x f(t) dt$ under supremum norm.",
      "numericAnswer": 1.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the spectrum $\\sigma(T)$ of a compact linear operator $T$ on an infinite-dimensional Hilbert space?",
      "options": [
        { "text": "At most countable set of eigenvalues, with 0 as the only possible accumulation point", "isCorrect": true, "explanation": "Correct! Compact operators generalize finite-dimensional matrices." },
        { "text": "Entire complex plane C", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Empty set", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Real numbers only", "isCorrect": false, "explanation": "Incorrect: Unless T is also self-adjoint." }
      ]
    }
  ]
}
```
