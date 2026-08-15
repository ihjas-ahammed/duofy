# Duofy Reusable Lesson Format: Complex Integration and Residue Theorem - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis / Complex_Integration_and_Residue_Theorem`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to evaluate improper real integrals like $\int_{-\infty}^\infty \frac{1}{x^2 + 1} dx$ and $\int_{-\infty}^\infty \frac{1}{x^4 + 1} dx$ using semicircular contours in the upper half-plane and residue summation at poles.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Contour Integration Strategy Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step $\int_{-\infty}^\infty \frac{1}{x^4+1} dx$ Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Semicircular Arc Vanishing Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Real Integral Evaluation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Jordan's Lemma Fourier Integral Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the formula for real rational integrals: $\int_{-\infty}^\infty \frac{P(x)}{Q(x)} dx = 2\pi i \sum_{\text{Im}(z_k)>0} \text{Res}\left(\frac{P}{Q}, z_k\right)$ where $\deg Q \ge \deg P + 2$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps of computing $\int_{-\infty}^\infty \frac{1}{x^2+1} dx$: (1) poles at $z = \pm i$, (2) only $z = i$ is in upper half-plane, (3) $\text{Res}(f, i) = \lim_{z \to i} (z-i)\frac{1}{(z-i)(z+i)} = \frac{1}{2i}$, (4) $I = 2\pi i \cdot \frac{1}{2i} = \pi$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the ML inequality bounds the semicircle integral to 0 as radius $R \to \infty$. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute $\int_{-\infty}^\infty \frac{1}{x^2 + 1} dx = \pi \approx 3.14159$.
5. **Slide 5 (`quiz`):** Quiz testing the Fourier integral $\int_{-\infty}^\infty \frac{\cos x}{x^2 + 1} dx = \text{Re}\left(2\pi i \cdot \text{Res}\left(\frac{e^{iz}}{z^2+1}, i\right)\right) = \frac{\pi}{e}$.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Evaluating Real Integrals via the Residue Theorem**\nFor real rational functions $f(x) = \\frac{P(x)}{Q(x)}$ with no real poles and $\\deg(Q) \\ge \\deg(P) + 2$:\n$$\n\\int_{-\\infty}^\\infty \\frac{P(x)}{Q(x)}\\,dx = 2\\pi i \\sum_{\\text{Im}(z_k) > 0} \\text{Res}(f, z_k)\n$$\nIntegrate $f(z)$ over a closed contour $\\Gamma_R = [-R, R] \\cup C_R$ (upper semicircle of radius $R$). As $R \\to \\infty$, $\\int_{C_R} f(z)\\,dz \\to 0$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Find Poles):** For $f(z) = \\frac{1}{z^2 + 1}$, poles solve $z^2 + 1 = 0 \\implies z = \\pm i$.\n• **Step 2 (Select Upper Half-Plane Poles):** Only $z_1 = +i$ has $\\text{Im}(z) > 0$.\n• **Step 3 (Calculate Residue):** $\\text{Res}(f, i) = \\left.\\frac{1}{\\frac{d}{dz}(z^2+1)}\\right|_{z=i} = \\frac{1}{2i} = -\\frac{i}{2}$.\n• **Step 4 (Multiply by $2\\pi i$):** $\\int_{-\\infty}^\\infty \\frac{1}{x^2+1}\\,dx = 2\\pi i \\left(\\frac{1}{2i}\\right) = \\pi$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "By the ML-inequality, the integral of 1/(z^2+1) along the semicircular arc C_R of radius R approaches ___ as R approaches infinity.",
      "blankAnswer": "zero",
      "blankDistractors": ["pi", "infinity", "one"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the exact value of the integral int_{-infty}^infty 1 / (x^2 + 1) dx to 2 decimal places.",
      "numericAnswer": 3.14,
      "numericTolerance": 0.02
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the value of the oscillatory integral int_{-infty}^infty cos(x) / (x^2 + 1) dx evaluated using Jordan's Lemma?",
      "options": [
        { "text": "pi / e", "isCorrect": true, "explanation": "Correct! Integrate e^{iz}/(z^2+1) on the upper semicircle. Residue at z=i is e^{-1}/(2i), so the integral is 2*pi*i * e^{-1}/(2i) = pi/e." },
        { "text": "pi * e", "isCorrect": false, "explanation": "Incorrect: e is in the denominator." },
        { "text": "2 pi", "isCorrect": false, "explanation": "Incorrect: Does not account for exponential damping e^{-1}." },
        { "text": "0", "isCorrect": false, "explanation": "Incorrect: cos(x)/(x^2+1) is an even positive function near 0." }
      ]
    }
  ]
}
```
