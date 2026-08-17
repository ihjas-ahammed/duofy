# Duofy Reusable Lesson Format: Fourier Coefficients and Fejér Summability

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis / Fourier_Series_and_Fourier_Transforms`  
**Lesson Format Type:** `fourier_coefficients_and_fejer_summability`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Fourier Series on the torus $\mathbb{T} = \mathbb{R}/\mathbb{Z}$, the Dirichlet kernel $D_N(x)$ and Gibbs phenomenon, and prove **Fejér's Theorem** (Cesàro arithmetic means $\sigma_N f(x) = (f * F_N)(x)$ converge uniformly for all continuous periodic functions).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fourier Series & Fejér Kernel Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Approximate Identity & Cesàro Smoothing Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Summability Kernel & Integral Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Fejér Kernel Positivity Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Gibbs Phenomenon Overshoot Percentage Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of Fourier coefficients $\hat{f}(n) = \int_0^1 f(x) e^{-2\pi i n x} dx$, the Dirichlet partial sum $S_N f = f * D_N$, the Fejér kernel $F_N(x) = \frac{1}{N} \left(\frac{\sin(N\pi x)}{\sin(\pi x)}\right)^2$, and Fejér's Theorem ($\sigma_N f \to f$ uniformly for $f \in C(\mathbb{T})$).
2. **Slide 2 (`concept_pieces`):** Deconstruct Dirichlet kernel failure ($L^1$ norm $\|D_N\|_1 \sim \frac{4}{\pi^2}\ln N \to \infty$), Fejér kernel as a non-negative approximate identity ($F_N \ge 0$, $\int F_N = 1$, concentration near 0), and resolution of point-wise divergence.
3. **Slide 3 (`matching`):** Pair 4 kernels (Dirichlet $D_N$, Fejér $F_N$, Poisson $P_r$, Gaussian Heat $H_t$) with their mathematical definitions and positivity properties.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that unlike the oscillatory Dirichlet kernel, the Fejér kernel is strictly non-negative everywhere. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking what the asymptotic overshoot percentage of the Gibbs phenomenon is near a jump discontinuity ($\approx 8.95\% \approx 9\%$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fourier_coefficients_and_fejer_summability",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Fourier Series and Fejér Summability**\nFor a 1-periodic function $f \\in L^1(\\mathbb{T})$:\n• **Fourier Coefficients:** $\\hat{f}(n) = \\int_0^1 f(x) e^{-2\\pi i n x} \\, dx$.\n• **Dirichlet Partial Sums:** $S_N f(x) = \\sum_{n=-N}^N \\hat{f}(n) e^{2\\pi i n x} = (f * D_N)(x)$.\n• **Fejér Mean (Cesàro Average):**\n$$\n\\sigma_N f(x) = \\frac{1}{N} \\sum_{k=0}^{N-1} S_k f(x) = (f * F_N)(x), \\quad F_N(x) = \\frac{1}{N} \\left( \\frac{\\sin(N\\pi x)}{\\sin(\\pi x)} \\right)^2\n$$\n• **Fejér's Theorem:** If $f \\in C(\\mathbb{T})$ is continuous, $\\sigma_N f \\to f$ **uniformly** on $\\mathbb{T}$ as $N \\to \\infty$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Failure of the Dirichlet Kernel:** $D_N(x) = \\frac{\\sin((2N+1)\\pi x)}{\\sin(\\pi x)}$ oscillates between positive and negative; its $L^1$-norm $\\|D_N\\|_1 \\sim \\frac{4}{\\pi^2}\\ln N \\to \\infty$ (Lebesgue constants).\n• **Gibbs Phenomenon:** Partial sums $S_N f$ overshoot jump discontinuities by approximately $8.95\\%$.\n• **Fejér Approximate Identity:** $F_N(x) \\ge 0$ everywhere, $\\int_0^1 F_N(x) dx = 1$, and for any $\\delta > 0$, $\\int_\\delta^{1-\\delta} F_N(x) dx \\to 0$.\n• **Density of Trigonometric Polynomials:** Fejér's Theorem immediately proves the Weierstrass Approximation Theorem on the circle."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each periodic kernel to its characteristic property.",
      "matchPairs": [
        { "left": "Dirichlet Kernel D_N(x)", "right": "Signed oscillatory kernel with unbounded L1 norm ~ ln(N)" },
        { "left": "Fejér Kernel F_N(x)", "right": "Non-negative Cesàro kernel with ||F_N||_1 = 1 (approximate identity)" },
        { "left": "Poisson Kernel P_r(theta)", "right": "Harmonic extension kernel inside the unit disk r < 1" },
        { "left": "Weierstrass Heat Kernel H_t(x)", "right": "Gaussian convolution kernel solving the periodic heat equation" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Unlike the signed Dirichlet kernel, the Fejér kernel is strictly ___ at all points on the real line.",
      "blankAnswer": "non-negative",
      "blankDistractors": ["negative", "divergent", "unbounded"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the approximate percentage overshoot exhibited by the Fourier partial sums S_N f near a jump discontinuity (the Gibbs Phenomenon)?",
      "options": [
        { "text": "Approximately 8.95% (about 9% of the jump height)", "isCorrect": true, "explanation": "Correct! The overshoot integral (2/pi) int_0^pi (sin t / t) dt - 1 approx 0.08949 (approx 8.95%) persists for all N -> infty." },
        { "text": "50%", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "0% (no overshoot occurs)", "isCorrect": false, "explanation": "Incorrect: Overshoot strictly occurs for Fourier partial sums." },
        { "text": "100%", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
