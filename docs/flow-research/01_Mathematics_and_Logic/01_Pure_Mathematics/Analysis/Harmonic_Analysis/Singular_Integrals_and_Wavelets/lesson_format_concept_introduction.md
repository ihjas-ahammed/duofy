# Duofy Reusable Lesson Format: Singular Integrals and Wavelets - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis / Singular_Integrals_and_Wavelets`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the Hilbert Transform as the prototypical singular integral operator with Fourier multiplier $-i \operatorname{sgn}(\xi)$, define the Calderón-Zygmund decomposition ($f = g + b$), and explain Multiresolution Analysis (MRA) for wavelet bases.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hilbert Transform & CZ Operator Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Time-Frequency Localization Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Operator & Harmonic Space Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Bad Function Mean Zero Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Hilbert Transform Square Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of the Hilbert transform $Hf(x) = \frac{1}{\pi} \text{p.v.} \int_{-\infty}^\infty \frac{f(y)}{x - y} dy$ and its Fourier multiplier $\widehat{Hf}(\xi) = -i \operatorname{sgn}(\xi)\hat{f}(\xi)$.
2. **Slide 2 (`concept_pieces`):** Deconstruct cancellation symmetry in principal value integrals, CZ good/bad decomposition, BMO space, and MRA dyadic scaling $\psi_{j, k}(x) = 2^{j/2}\psi(2^j x - k)$.
3. **Slide 3 (`matching`):** Pair 4 concepts (Hilbert transform, Calderón-Zygmund operator, Haar wavelet, BMO space) with their core mathematical descriptions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that each component of the bad function in CZ decomposition has integral equal to zero. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking what operator $H^2 = H \circ H$ equals on $L^2(\mathbb{R})$ ($H^2 = -I$, negative identity).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: The Hilbert Transform and Singular Integrals**\nThe **Hilbert Transform** on $\\mathbb{R}$ is the singular integral operator defined by the Cauchy principal value:\n$$\nHf(x) = \\frac{1}{\\pi} \\lim_{\\epsilon \\to 0^+} \\int_{|x-y| > \\epsilon} \\frac{f(y)}{x - y}\\,dy\n$$\nIn the frequency domain, it acts as the Fourier multiplier:\n$$\n\\widehat{Hf}(\\xi) = -i \\operatorname{sgn}(\\xi) \\hat{f}(\\xi)\n$$\nSince $|-i\\operatorname{sgn}(\\xi)| = 1$, $H$ is a unitary isometry on $L^2(\\mathbb{R})$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Kernel Cancellation:** The kernel $1/x$ is not locally integrable; its integral converges only because the anti-symmetric positive and negative parts cancel out.\n• **Calderón-Zygmund Decomposition:** Decomposes any $L^1$ function $f = g + b$ into a bounded \"good\" part $g$ and a localized \"bad\" part $b = \\sum b_k$ with $\\int b_k dx = 0$.\n• **BMO Space:** Bounded Mean Oscillation represents the true target space for singular integrals acting on $L^\\infty$.\n• **Wavelet Bases:** Unlike global Fourier sinusoids, wavelets $\\psi_{j,k}(x) = 2^{j/2}\\psi(2^j x - k)$ are compactly localized in both time and frequency."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each harmonic analysis tool to its fundamental property.",
      "matchPairs": [
        { "left": "Hilbert Transform H", "right": "Fourier multiplier operator with m(xi) = -i sgn(xi)" },
        { "left": "Calderón-Zygmund Operator", "right": "Bounded on L^p for 1 < p < infty and weak-type (1, 1)" },
        { "left": "BMO Space", "right": "Dual space of the real Hardy space H^1" },
        { "left": "Haar Wavelet", "right": "Piecewise constant orthonormal basis of L^2(R)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Calderón-Zygmund decomposition f = g + b, the bad component b_k on each dyadic cube has average value equal to ___.",
      "blankAnswer": "zero",
      "blankDistractors": ["one", "infinity", "alpha"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the result of applying the Hilbert transform twice in succession, H^2 = H(H(f)), on L^2(R)?",
      "options": [
        { "text": "H^2 = -I (negative of the identity operator)", "isCorrect": true, "explanation": "Correct! In the frequency domain, (-i sgn(xi))^2 = (-i)^2 sgn^2(xi) = -1 for all xi != 0, so H^2 = -I." },
        { "text": "H^2 = I (identity operator)", "isCorrect": false, "explanation": "Incorrect: (-i)^2 = -1, not +1." },
        { "text": "H^2 = 0", "isCorrect": false, "explanation": "Incorrect: H is invertible." },
        { "text": "H^2 = d/dx", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
