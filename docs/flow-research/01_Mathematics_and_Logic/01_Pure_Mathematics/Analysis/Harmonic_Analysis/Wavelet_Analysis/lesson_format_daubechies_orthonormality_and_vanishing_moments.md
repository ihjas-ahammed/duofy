# Duofy Reusable Lesson Format: Daubechies Wavelets, Orthonormality, and Vanishing Moments

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis / Wavelet_Analysis`  
**Lesson Format Type:** `daubechies_orthonormality_and_vanishing_moments`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mathematical construction and proof of **Daubechies Wavelets**, their compact support of length $2N - 1$, the trigonometric polynomial scaling condition $|m_0(\xi)|^2 + |m_0(\xi + \pi)|^2 = 1$, and the role of $N$ vanishing moments ($\int t^p \psi(t) dt = 0$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Daubechies Filter Scaling Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Spectral Factorization & Scaling Filter Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Vanishing Moments Polynomial Annihilation Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Haar vs Daubechies db2 Filter Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Moment Annihilation Integral Property Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Daubechies Construction Theorem: For every integer $N \ge 1$, there exists a unique compactly supported scaling function $\phi$ of support $[0, 2N - 1]$ and corresponding wavelet $\psi$ with $N$ vanishing moments ($\int t^p \psi(t) dt = 0$ for $p = 0, 1, \dots, N-1$), whose scaling transfer function $m_0(\xi) = \frac{1}{\sqrt{2}} \sum h_k e^{-ik\xi}$ satisfies $|m_0(\xi)|^2 + |m_0(\xi + \pi)|^2 = 1$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof of Daubechies construction via spectral factorization: (1) set $P(y) = \sum_{k=0}^{N-1} \binom{N-1+k}{k} y^k$ where $y = \sin^2(\xi/2)$, (2) verify the Bézout identity $(1 - y)^N P(y) + y^N P(1-y) = 1$, (3) define $|m_0(\xi)|^2 = \cos^{2N}(\xi/2) P(\sin^2(\xi/2))$, (4) apply Riesz Spectral Factorization Lemma to extract a causal trigonometric polynomial $m_0(\xi) = \left(\frac{1 + e^{-i\xi}}{2}\right)^N Q(e^{-i\xi})$ with real filter coefficients $h_k$, (5) take inverse Fourier transform to obtain the compactly supported scaling function $\phi(t)$ and mother wavelet $\psi(t)$.
3. **Slide 3 (`quiz`):** Test why $N$ vanishing moments implies that smooth functions (polynomials of degree $< N$) have exactly zero wavelet detail coefficients $\langle f, \psi_{j, k} \rangle = 0$.
4. **Slide 4 (`proof`):** Interactive derivation showing the exact 4 filter coefficients for the Daubechies db2 wavelet: $h_0 = \frac{1+\sqrt{3}}{4\sqrt{2}}$, $h_1 = \frac{3+\sqrt{3}}{4\sqrt{2}}$, $h_2 = \frac{3-\sqrt{3}}{4\sqrt{2}}$, $h_3 = \frac{1-\sqrt{3}}{4\sqrt{2}}$.
5. **Slide 5 (`one_word`):** Plain-text recall of the mathematical term describing the integral property $\int t^p \psi(t) dt = 0$ (vanishing).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "daubechies_orthonormality_and_vanishing_moments",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Daubechies Compactly Supported Wavelets**\nFor any integer $N \\ge 1$, there exists an orthonormal wavelet $\\psi \\in L^2(\\mathbb{R})$ such that:\n1. **Compact Support:** $\\operatorname{supp}(\\psi) = [1 - N, N]$ and $\\operatorname{supp}(\\phi) = [0, 2N - 1]$.\n2. **$N$ Vanishing Moments:**\n$$\n\\int_{-\\infty}^\\infty t^p \\psi(t) \\, dt = 0 \\quad \\text{for } p = 0, 1, \\dots, N - 1\n$$\n3. **Quadrature Mirror Condition:** The low-pass filter transfer function $m_0(\\xi) = \\frac{1}{\\sqrt{2}} \\sum_{k=0}^{2N-1} h_k e^{-ik\\xi}$ satisfies $|m_0(\\xi)|^2 + |m_0(\\xi + \\pi)|^2 = 1$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps constructing Daubechies filters via Riesz spectral factorization.",
      "orderItems": [
        "Formulate the polynomial P(y) = sum_{k=0}^{N-1} binom{N-1+k}{k} y^k where y = sin^2(xi/2)",
        "Prove the Bézout identity (1 - y)^N P(y) + y^N P(1 - y) = 1, ensuring the sum of squared filter responses equals 1",
        "Express the target magnitude as |m_0(xi)|^2 = cos^{2N}(xi/2) P(sin^2(xi/2))",
        "Apply the Riesz Factorization Lemma to extract an analytic trigonometric polynomial m_0(xi) = ((1 + e^{-i xi})/2)^N Q(e^{-i xi}) with real coefficients",
        "Compute the inverse Fourier transform to obtain the compact filter coefficients h_0, ..., h_{2N-1} that generate phi(t) and psi(t)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "If a wavelet psi has N vanishing moments, what is the wavelet detail coefficient <f, psi_{j, k}> for any polynomial signal f(t) = c_0 + c_1 t + ... + c_{N-1} t^{N-1} of degree strictly less than N?",
      "options": [
        { "text": "0 identically (the wavelet completely annihilates polynomials of degree < N, producing maximum sparsity)", "isCorrect": true, "explanation": "Correct! Since int t^p psi(t) dt = 0 for all p < N, any linear combination of powers t^p integrates to exactly 0 against the wavelet." },
        { "text": "N!", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Infinity", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: The Four Daubechies db2 Filter Coefficients",
      "interactiveSteps": [
        {
          "stepText": "For N = 2 (db2), we require 4 filter coefficients h_0, h_1, h_2, h_3 satisfying orthonormality sum h_k^2 = 1, sum h_k h_{k+2} = 0, sum h_k = sqrt(2), and vanishing moment sum (-1)^k k h_k = 0."
        },
        {
          "prompt": "Solving this algebraic system yields which exact value for the leading coefficient h_0?",
          "options": [
            { "text": "h_0 = (1 + sqrt(3)) / (4 * sqrt(2))", "isCorrect": true },
            { "text": "h_0 = 1/2", "isCorrect": false },
            { "text": "h_0 = 0", "isCorrect": false },
            { "text": "h_0 = 1", "isCorrect": false }
          ]
        },
        {
          "stepText": "The complete 4-tap filter is h = (1+sqrt(3), 3+sqrt(3), 3-sqrt(3), 1-sqrt(3)) / (4 sqrt(2)), generating the celebrated db2 fractal wavelet."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the adjective describing the property where all moments of a wavelet up to order N - 1 evaluate to zero?",
      "blankAnswer": "vanishing"
    }
  ]
}
```
