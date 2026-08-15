# Duofy Reusable Lesson Format: Real Analysis & Measure Theory - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Real_Analysis_and_Measure_Theory`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students in $\epsilon$-$\delta$ limit bound scratchwork, Lebesgue integral calculations $\int f dm$, and $L^p$ norm evaluations $\|f\|_p = \left( \int |f|^p dm \right)^{1/p}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Epsilon-Delta / Integral Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Scratchwork Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Delta Bound Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Integral Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Lp Norm Inequality Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Epsilon-Delta Limit Bound Scratchwork**\nTo prove $\\lim_{x \\to a} f(x) = L$, we must find $\\delta(\\epsilon) > 0$ such that:\n$$\n0 < |x - a| < \\delta \\implies |f(x) - L| < \\epsilon\n$$\nWork backwards from $|f(x) - L|$ to bound terms and isolate $|x - a|$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Prove $\\lim_{x \\to 3} x^2 = 9$. Target $|x^2 - 9| = |x - 3||x + 3| < \\epsilon$.\n• **Step 2:** Assume initial bound $\\delta \\le 1 \\implies 2 < x < 4 \\implies 5 < x+3 < 7$.\n• **Step 3:** Bounded factor: $|x + 3| < 7$. Thus $|x^2 - 9| < 7 |x - 3|$.\n• **Step 4:** Set $7 |x - 3| < \\epsilon \\implies |x - 3| < \\epsilon / 7$. Choose $\\delta = \\min(1, \\epsilon/7)$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In epsilon-delta limit proofs for quadratic functions, we assume an initial bound delta <= 1 to restrict x to a local ___.",
      "blankAnswer": "neighborhood",
      "blankDistractors": ["sequence", "measure", "derivative"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the Lebesgue integral $\\int_0^1 x^2 \\, dm$ on $[0, 1]$.",
      "numericAnswer": 0.333,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Which fundamental inequality bounds the $L^1$ norm of a product of functions $\|f g\|_1 \\le \|f\|_p \|g\|_q$ for $1/p + 1/q = 1$?",
      "options": [
        { "text": "Hölder's Inequality", "isCorrect": true, "explanation": "Correct! Hölder's Inequality is the foundational tool for Lp spaces." },
        { "text": "Minkowski's Inequality", "isCorrect": false, "explanation": "Incorrect: Minkowski's Inequality is the triangle inequality for Lp spaces." },
        { "text": "Bessel's Inequality", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Markov's Inequality", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
