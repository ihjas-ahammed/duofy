# Duofy Reusable Lesson Format: Complex Analysis - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute complex residues $\text{Res}(f, z_0)$ at simple and higher-order poles, evaluate contour integrals $\oint_\gamma f(z) dz$, and compute real integrals $\int_{-\infty}^\infty \dots dx$ using semicircular contours.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Residue Formula Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Pole & Residue Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Simple Pole Limit Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Residue / Integral Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Real Integral Contour Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Residue Formula for Pole of Order $k$**\nIf $f(z)$ has a pole of order $k$ at $z = z_0$, its residue is calculated as:\n$$\n\\text{Res}(f, z_0) = \\frac{1}{(k-1)!} \\lim_{z \\to z_0} \\frac{d^{k-1}}{dz^{k-1}} \\left[ (z - z_0)^k f(z) \\right]\n$$\nFor a simple pole ($k=1$), $\\text{Res}(f, z_0) = \\lim_{z \\to z_0} (z - z_0) f(z)$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Compute $\\oint_C \\frac{1}{z^2 + 1} dz$ where $C$ is circle $|z - i| = 1$.\n• **Step 2:** Factor denominator $z^2 + 1 = (z - i)(z + i)$. Poles at $z = i$ and $z = -i$.\n• **Step 3:** Only $z = i$ lies inside $C$. Calculate simple pole residue $\\text{Res}(f, i) = \\lim_{z \\to i} (z - i)\\frac{1}{(z-i)(z+i)} = \\frac{1}{2i}$.\n• **Step 4:** Integral value $= 2\\pi i \\times \\text{Res}(f, i) = 2\\pi i \\left(\\frac{1}{2i}\\right) = \\pi$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "For a simple pole at z0 of rational function f(z) = P(z)/Q(z) with Q'(z0) != 0, the residue equals P(z0) divided by ___.",
      "blankAnswer": "Q'(z0)",
      "blankDistractors": ["Q(z0)", "P'(z0)", "2pi"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the real integral $\\int_{-\\infty}^\\infty \\frac{1}{x^2 + 1} \\, dx$ using residue integration.",
      "numericAnswer": 3.14159,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "When evaluating $\\int_{-\\infty}^\\infty \\frac{\\cos x}{x^2 + a^2} dx$, why do we replace $\\cos x$ with $e^{i z}$ on the upper semicircular contour?",
      "options": [
        { "text": "|e^(iz)| = e^(-y) decays exponentially on upper half-plane y > 0, ensuring Jordan's Lemma applies", "isCorrect": true, "explanation": "Correct! |cos z| grows exponentially, but e^(iz) decays rapidly for y > 0." },
        { "text": "Because cos x is not integrable", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because e^(iz) has no poles", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because residues equal 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
