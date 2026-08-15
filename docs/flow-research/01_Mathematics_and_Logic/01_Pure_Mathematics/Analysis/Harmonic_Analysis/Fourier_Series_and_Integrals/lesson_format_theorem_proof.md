# Duofy Reusable Lesson Format: Fourier Series and Integrals - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis / Fourier_Series_and_Integrals`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof of **Fejér's Theorem** using positive approximate identities (Fejér kernel $F_N \ge 0$) and prove **Plancherel's Theorem** for the Schwartz class $\mathcal{S}(\mathbb{R})$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fejér's Theorem Formal Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Fejér Kernel Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Approximate Identity Kernel Positivity Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Plancherel Isometry Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Summability Mean Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Fejér's Theorem: If $f \in C(\mathbb{T})$ is a continuous $2\pi$-periodic function, its Cesàro Fourier means $\sigma_N(f)(x) = \frac{1}{N}\sum_{k=0}^{N-1} S_k(f)(x) = (f * F_N)(x)$ converge **uniformly** to $f(x)$ as $N \to \infty$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof: (1) express $\sigma_N(f)(x) - f(x) = \frac{1}{2\pi}\int_{-\pi}^\pi [f(x-t) - f(x)] F_N(t) dt$, (2) use uniform continuity of $f$ on compact $\mathbb{T}$ to bound $|f(x-t) - f(x)| < \epsilon/2$ for $|t| < \delta$, (3) split integral into $|t| < \delta$ and $\delta \le |t| \le \pi$, (4) bound the first integral by $(\epsilon/2) \frac{1}{2\pi}\int F_N dt = \epsilon/2$, (5) bound the second integral using $F_N(t) \le \frac{1}{N \sin^2(\delta/2)} \to 0$ as $N \to \infty$, making the total error $< \epsilon$.
3. **Slide 3 (`quiz`):** Test why the Fejér kernel $F_N(t) = \frac{1}{N}\frac{\sin^2(Nt/2)}{\sin^2(t/2)} \ge 0$ succeeds as an approximate identity whereas the Dirichlet kernel $D_N(t)$ fails.
4. **Slide 4 (`proof`):** Interactive derivation showing $\int \hat{f}(\xi)\overline{\hat{g}(\xi)} d\xi = \int f(x)\overline{g(x)} dx$ by Fubini's theorem on the Schwartz space.
5. **Slide 5 (`one_word`):** Plain-text recall of the Italian mathematician who invented the $(C, 1)$ arithmetic average summability method (Cesàro).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Fejér's Theorem (Uniform Summability)**\nLet $f \\in C(\\mathbb{T})$ be a continuous $2\\pi$-periodic function.\nDefine the Cesàro means of the partial sums $\\sigma_N(f)(x) = \\frac{1}{N} \\sum_{k=0}^{N-1} S_k(f)(x) = (f * F_N)(x)$, where the **Fejér kernel** is:\n$$\nF_N(t) = \\frac{1}{N} \\left( \\frac{\\sin(Nt/2)}{\\sin(t/2)} \\right)^2 \\ge 0\n$$\nThen $\\sigma_N(f)(x)$ converges **uniformly** to $f(x)$ on $[-\\pi, \\pi]$ as $N \\to \\infty$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps demonstrating uniform convergence via the Fejér kernel.",
      "orderItems": [
        "Write the difference using (1/2pi) int_{-pi}^pi F_N(t) dt = 1: sigma_N(f)(x) - f(x) = (1/2pi) int_{-pi}^pi [f(x-t) - f(x)] F_N(t) dt",
        "By uniform continuity of f, choose delta > 0 such that |f(x-t) - f(x)| < eps/2 whenever |t| < delta",
        "Split the integral into the central region |t| < delta and the tail region delta <= |t| <= pi",
        "Bound the central integral by (eps/2) * (1/2pi) int F_N dt = eps/2",
        "Bound the tail integral using F_N(t) <= 1 / [N sin^2(delta/2)], which vanishes as N -> infty, making total error < eps uniformly"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does the Fejér kernel F_N(t) succeed as a good summability kernel while the Dirichlet kernel D_N(t) fails?",
      "options": [
        { "text": "F_N(t) is strictly non-negative (F_N >= 0), making its L^1 norm identically 1 for all N, whereas the L^1 norm of D_N grows as (4/pi^2) ln N -> infinity", "isCorrect": true, "explanation": "Correct! Positivity ensures ||F_N||_{L^1} = 1, satisfying the crucial condition for an approximate identity." },
        { "text": "F_N(t) is a polynomial", "isCorrect": false, "explanation": "Incorrect: F_N is a trigonometric quotient." },
        { "text": "F_N(t) is identically zero outside [-1, 1]", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "F_N(t) has no derivatives", "isCorrect": false, "explanation": "Incorrect: F_N is smooth." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Plancherel Isometry on Schwartz Space S(R)",
      "interactiveSteps": [
        {
          "stepText": "For f, g in S(R), consider the inner product <f_hat, g_hat> = int f_hat(xi) conj(g_hat(xi)) dxi."
        },
        {
          "prompt": "Substituting f_hat(xi) = int f(x) e^{-2pi i x xi} dx and applying Fubini's theorem to invert the order of integration, what simplifies?",
          "options": [
            { "text": "int f(x) conj(int g_hat(xi) e^{2pi i x xi} dxi) dx = int f(x) conj(g(x)) dx = <f, g>", "isCorrect": true },
            { "text": "0", "isCorrect": false },
            { "text": "||f||_{L^1} ||g||_{L^1}", "isCorrect": false },
            { "text": "int f(x) g(x) dx / 2pi", "isCorrect": false }
          ]
        },
        {
          "stepText": "Thus ||f_hat||_{L^2} = ||f||_{L^2}, extending uniquely to an isometric isomorphism on all of L^2(R)."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the surname of the Italian mathematician who introduced the arithmetic mean method used in Fejér's theorem?",
      "blankAnswer": "cesaro"
    }
  ]
}
```
