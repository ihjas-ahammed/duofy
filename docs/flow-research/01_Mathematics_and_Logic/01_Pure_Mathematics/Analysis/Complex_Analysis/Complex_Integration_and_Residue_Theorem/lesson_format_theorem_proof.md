# Duofy Reusable Lesson Format: Complex Integration and Residue Theorem - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis / Complex_Integration_and_Residue_Theorem`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof of the **Cauchy Integral Formula** and the **Residue Theorem** via deformation of contours, cross-cuts, and small circular expansions around isolated singularities.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cauchy's Integral Formula Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Contour Deformation & Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Cross-Cut Cancellation Justification | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Residue Theorem Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Singularity Order Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Cauchy Integral Formula: $f(z_0) = \frac{1}{2\pi i} \oint_\gamma \frac{f(z)}{z - z_0} dz$ for $z_0$ inside $\gamma$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof: (1) let $\gamma$ enclose $z_0$, (2) shrink contour to small circle $C_\epsilon = \{z_0 + \epsilon e^{i\theta}\}$, (3) apply Cauchy-Goursat theorem on the region between $\gamma$ and $C_\epsilon$, (4) write $\oint_{C_\epsilon} \frac{f(z)}{z-z_0} dz = \oint \frac{f(z_0)}{z-z_0} dz + \oint \frac{f(z)-f(z_0)}{z-z_0} dz$, (5) evaluate first term to $2\pi i f(z_0)$ and bound second term to 0 as $\epsilon \to 0$.
3. **Slide 3 (`quiz`):** Test why the integral along cross-cuts connecting outer and inner contours cancels out.
4. **Slide 4 (`proof`):** Interactive derivation proving that higher derivatives satisfy $f^{(n)}(z_0) = \frac{n!}{2\pi i} \oint_\gamma \frac{f(z)}{(z - z_0)^{n+1}} dz$.
5. **Slide 5 (`one_word`):** Plain-text recall of the name of the series expansion with negative powers (Laurent).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Cauchy's Integral Formula**\nLet $f$ be holomorphic inside and on a simple, positively oriented closed contour $\\gamma$.\nFor any point $z_0$ strictly inside $\\gamma$:\n$$\nf(z_0) = \\frac{1}{2\\pi i} \\oint_\\gamma \\frac{f(z)}{z - z_0}\\,dz\n$$\nMore generally, for all $n \\ge 1$, $f$ is infinitely complex differentiable with:\n$$\nf^{(n)}(z_0) = \\frac{n!}{2\\pi i} \\oint_\\gamma \\frac{f(z)}{(z - z_0)^{n+1}}\\,dz\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps in proving Cauchy's Integral Formula via circular deformation.",
      "orderItems": [
        "By Cauchy-Goursat Theorem, replace the arbitrary contour gamma with a small circle C_eps: z = z_0 + eps * e^{i theta}",
        "Split the integrand: f(z)/(z - z_0) = f(z_0)/(z - z_0) + [f(z) - f(z_0)]/(z - z_0)",
        "Evaluate the first integral: oint_{C_eps} f(z_0)/(z - z_0) dz = f(z_0) * (2 pi i)",
        "Use continuity of f at z_0 to bound |f(z) - f(z_0)| < delta for small eps, showing the second integral is bounded by 2 pi delta",
        "Take the limit as eps -> 0 (delta -> 0) to conclude oint_gamma f(z)/(z - z_0) dz = 2 pi i f(z_0)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why can an arbitrary contour gamma enclosing an isolated singularity be replaced by a small circle C_eps around that singularity?",
      "options": [
        { "text": "The function is holomorphic in the region between gamma and C_eps, so introducing cross-cuts creates a simply connected domain where the net integral is zero", "isCorrect": true, "explanation": "Correct! Cauchy's theorem applied to the multi-connected region shows oint_gamma = oint_{C_eps} since cross-cuts traversed in opposite directions cancel." },
        { "text": "Because all closed curves in the plane are circles", "isCorrect": false, "explanation": "Incorrect: Closed curves can have arbitrary non-circular shapes." },
        { "text": "Because the function f is constant", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the length of gamma is equal to the length of C_eps", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: The n-th Derivative Formula",
      "interactiveSteps": [
        {
          "stepText": "Differentiating under the integral sign: d/dz_0 [ (z - z_0)^{-1} ] = (z - z_0)^{-2}."
        },
        {
          "prompt": "Differentiating n times with respect to z_0, what factor appears in the numerator of f^{(n)}(z_0)?",
          "options": [
            { "text": "n! (factorial of n)", "isCorrect": true },
            { "text": "2^n", "isCorrect": false },
            { "text": "n", "isCorrect": false },
            { "text": "1 / n!", "isCorrect": false }
          ]
        },
        {
          "stepText": "Thus f^{(n)}(z_0) = (n! / 2pi i) oint_gamma f(z) / (z - z_0)^{n+1} dz, confirming that holomorphic functions are smooth (C^infty)."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the name of the two-sided power series expansion around an isolated singularity containing both positive and negative powers?",
      "blankAnswer": "laurent"
    }
  ]
}
```
