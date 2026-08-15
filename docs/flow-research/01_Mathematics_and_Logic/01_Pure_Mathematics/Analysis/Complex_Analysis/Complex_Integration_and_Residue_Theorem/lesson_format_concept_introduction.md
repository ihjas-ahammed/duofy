# Duofy Reusable Lesson Format: Complex Integration and Residue Theorem - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis / Complex_Integration_and_Residue_Theorem`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the Cauchy Integral Theorem ($\oint f(z)dz = 0$), Laurent series expansions $f(z) = \sum a_n (z-z_0)^n$, the definition of the Residue as $\text{Res}(f, z_0) = a_{-1}$, and the Residue Theorem ($\oint_\gamma f(z)dz = 2\pi i \sum \text{Res}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Residue Theorem Formal Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Laurent Coefficient $a_{-1}$ Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Pole Order & Residue Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Residue Factor Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Enclosed Pole Integral Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Residue Theorem: $\oint_\gamma f(z)dz = 2\pi i \sum_{k=1}^m \text{Res}(f, z_k)$ for a positively oriented closed contour $\gamma$ enclosing isolated singularities $z_k$.
2. **Slide 2 (`concept_pieces`):** Deconstruct why $\oint (z-z_0)^n dz = 0$ for all $n \ne -1$, and $\oint \frac{1}{z-z_0} dz = 2\pi i$, making $a_{-1}$ the only surviving coefficient.
3. **Slide 3 (`matching`):** Pair 4 singularity types/residue formulas with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the contour integral equals $2\pi i$ times the sum of residues. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking to compute the contour integral $\oint_{|z|=2} \frac{1}{z - 1} dz = 2\pi i$.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: The Residue Theorem**\nLet $\\gamma$ be a positively oriented, simple closed curve in $\\mathbb{C}$, and let $f(z)$ be holomorphic inside and on $\\gamma$ except at finitely many isolated singularities $z_1, \\dots, z_k$ inside $\\gamma$.\nThen:\n$$\n\\oint_\\gamma f(z)\\,dz = 2\\pi i \\sum_{j=1}^k \\text{Res}(f, z_j)\n$$\nwhere $\\text{Res}(f, z_j) = a_{-1}$ is the coefficient of $(z - z_j)^{-1}$ in the Laurent series of $f$ around $z_j$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Laurent Series:** $f(z) = \\sum_{n=-\\infty}^\\infty a_n (z - z_0)^n$ near an isolated singularity $z_0$.\n• **The Power of $n=-1$:** For any integer $n \\ne -1$, $\\oint_{|z-z_0|=r} (z-z_0)^n dz = 0$ by exact anti-derivatives $\\frac{(z-z_0)^{n+1}}{n+1}$.\n• **The $1/z$ Anomaly:** For $n = -1$, parameterizing $z = z_0 + r e^{i\\theta}$ gives $\\oint \\frac{1}{z-z_0} dz = \\int_0^{2\\pi} \\frac{i r e^{i\\theta}}{r e^{i\\theta}} d\\theta = 2\\pi i$.\n• **Topological Filter:** The integral filters out all Laurent coefficients except the single residue $a_{-1}$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each pole condition to its standard residue formula.",
      "matchPairs": [
        { "left": "Simple Pole at z_0", "right": "lim_{z -> z_0} (z - z_0) f(z)" },
        { "left": "Quotient P(z)/Q(z) with Q(z_0)=0, Q'(z_0)!=0", "right": "P(z_0) / Q'(z_0)" },
        { "left": "Double Pole (m=2) at z_0", "right": "lim_{z -> z_0} d/dz [(z - z_0)^2 f(z)]" },
        { "left": "Essential Singularity (e.g. e^{1/z})", "right": "Coefficient a_{-1} of Laurent power series expansion" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The contour integral of a meromorphic function around a simple closed curve equals 2 pi i multiplied by the sum of all enclosed ___.",
      "blankAnswer": "residues",
      "blankDistractors": ["poles", "zeros", "derivatives"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Evaluate the contour integral I = oint_{|z| = 2} 1 / (z - 1) dz around the counterclockwise circle of radius 2 centered at the origin.",
      "options": [
        { "text": "2 pi i", "isCorrect": true, "explanation": "Correct! The pole at z = 1 lies inside |z| = 2 with residue 1, so the integral is 2*pi*i * 1 = 2*pi*i." },
        { "text": "0", "isCorrect": false, "explanation": "Incorrect: The pole z = 1 is inside the contour." },
        { "text": "pi i", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "4 pi i", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
