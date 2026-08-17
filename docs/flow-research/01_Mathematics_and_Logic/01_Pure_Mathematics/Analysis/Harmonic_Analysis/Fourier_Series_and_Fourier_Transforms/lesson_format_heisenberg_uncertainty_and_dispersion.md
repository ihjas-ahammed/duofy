# Duofy Reusable Lesson Format: Heisenberg Uncertainty Principle and Dispersion

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis / Fourier_Series_and_Fourier_Transforms`  
**Lesson Format Type:** `heisenberg_uncertainty_and_dispersion`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly evaluate the **Heisenberg Uncertainty Principle** in harmonic analysis $\left(\int x^2 |f(x)|^2 dx\right) \left(\int \xi^2 |\hat{f}(\xi)|^2 d\xi\right) \ge \frac{\|f\|_2^4}{16\pi^2}$, derive Gaussian minimizers, and compute Fourier transforms of standard signals (boxcar, exponential decay, Lorentzian).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Heisenberg Uncertainty Inequality Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Cauchy-Schwarz Proof Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Gaussian Minimizer Uniqueness Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Variance Product Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Boxcar Transform Sinc Function Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the theorem: For any $f \in \mathcal{S}(\mathbb{R})$ normalized to $\|f\|_{L^2} = 1$: $\left(\int_{-\infty}^\infty x^2 |f(x)|^2 dx\right) \left(\int_{-\infty}^\infty \xi^2 |\hat{f}(\xi)|^2 d\xi\right) \ge \frac{1}{16\pi^2}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) use Plancherel to rewrite $\int \xi^2 |\hat{f}(\xi)|^2 d\xi = \frac{1}{4\pi^2} \int |f'(x)|^2 dx$, (2) apply integration by parts to the identity $1 = \int |f(x)|^2 dx = - \int x \frac{d}{dx}|f(x)|^2 dx = -2 \operatorname{Re} \int x f(x) \overline{f'(x)} dx$, (3) apply Cauchy-Schwarz: $1 \le 2 \left(\int x^2 |f(x)|^2 dx\right)^{1/2} \left(\int |f'(x)|^2 dx\right)^{1/2}$, (4) square both sides and divide by $4(4\pi^2)$ to obtain $\sigma_x^2 \sigma_\xi^2 \ge \frac{1}{16\pi^2}$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that equality in the Heisenberg uncertainty relation holds strictly if and only if the function is a Gaussian. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the minimal variance product $\sigma_x \sigma_\xi = \frac{1}{4\pi} \approx 0.0796$ (numeric answer 0.08).
5. **Slide 5 (`quiz`):** Quiz calculating the Fourier transform of the unit rectangular boxcar function $f(x) = \mathbf{1}_{[-1/2, 1/2]}(x)$: What is $\hat{f}(\xi)$? ($\hat{f}(\xi) = \int_{-1/2}^{1/2} e^{-2\pi i x \xi} dx = \frac{\sin(\pi \xi)}{\pi \xi} = \operatorname{sinc}(\xi)$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "heisenberg_uncertainty_and_dispersion",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The Heisenberg Uncertainty Principle in Harmonic Analysis**\nLet $f \\in \\mathcal{S}(\\mathbb{R})$ be a normalized signal ($\\int_{-\\infty}^\\infty |f(x)|^2 dx = 1$).\n• The product of the spatial variance $\\sigma_x^2$ and frequency variance $\\sigma_\\xi^2$ satisfies the fundamental lower bound:\n$$\n\\left( \\int_{-\\infty}^\\infty x^2 |f(x)|^2 \\, dx \\right) \\left( \\int_{-\\infty}^\\infty \\xi^2 |\\hat{f}(\\xi)|^2 \\, d\\xi \\right) \\ge \\frac{1}{16\\pi^2}\n$$\n• A signal cannot be simultaneously sharply localized in both time and frequency."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Plancherel on Derivatives):** $\\int \\xi^2 |\\hat{f}(\\xi)|^2 d\\xi = \\frac{1}{4\\pi^2} \\int |f'(x)|^2 dx$.\n• **Step 2 (Integration by Parts):**\n  $$1 = \\int_{-\\infty}^\\infty |f(x)|^2 dx = -\\int_{-\\infty}^\\infty x \\frac{d}{dx}|f(x)|^2 dx = -2 \\operatorname{Re} \\int_{-\\infty}^\\infty x f(x) \\overline{f'(x)} \\, dx$$\n• **Step 3 (Cauchy-Schwarz Inequality):**\n  $$1 \\le 2 \\left( \\int x^2 |f(x)|^2 dx \\right)^{1/2} \\left( \\int |f'(x)|^2 dx \\right)^{1/2}$$\n• **Step 4 (Final Bound):** Squaring yields $1 \\le 4 \\sigma_x^2 (4\\pi^2 \\sigma_\\xi^2) \\implies \\sigma_x^2 \\sigma_\\xi^2 \\ge \\frac{1}{16\\pi^2}$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In the Heisenberg uncertainty relation, equality sigma_x sigma_xi = 1/(4 pi) is achieved strictly if and only if the function f(x) is a ___.",
      "blankAnswer": "gaussian",
      "blankDistractors": ["sinusoid", "polynomial", "constant"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the minimal theoretical value of the uncertainty product sigma_x * sigma_xi = 1 / (4 * pi) to two decimal places.",
      "numericAnswer": 0.08,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the continuous Fourier transform F[f](xi) of the rectangular boxcar pulse f(x) = 1 for |x| <= 1/2 and 0 otherwise?",
      "options": [
        { "text": "sinc(xi) = sin(pi xi) / (pi xi)", "isCorrect": true, "explanation": "Correct! int_{-1/2}^{1/2} e^{-2pi i x xi} dx = [e^{-2pi i x xi} / (-2pi i xi)]_{-1/2}^{1/2} = (e^{pi i xi} - e^{-pi i xi}) / (2pi i xi) = sin(pi xi)/(pi xi)." },
        { "text": "cos(pi xi)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "e^{-pi xi^2}", "isCorrect": false, "explanation": "Incorrect: Gaussian transforms to Gaussian." },
        { "text": "1 / (1 + xi^2)", "isCorrect": false, "explanation": "Incorrect: 1/(1+xi^2) is the transform of exponential decay e^{-2pi|x|}." }
      ]
    }
  ]
}
```
