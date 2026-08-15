# Duofy Reusable Lesson Format: Riemann Zeta Function - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Analytic_Number_Theory / Riemann_Zeta_Function`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof of **Riemann's Functional Equation** $\xi(s) = \xi(1-s)$ using the Jacobi Theta Function $\theta(\tau)$ and the Poisson Summation Formula, and derive **Euler's Product Formula**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Riemann's Completed Zeta Functional Equation Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Jacobi Theta Transformation Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Poisson Summation Self-Duality Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Euler Product Unique Factorization Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Gamma Function Factor Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Completed Riemann Zeta Function: $\xi(s) = \frac{1}{2} s(s-1) \pi^{-s/2} \Gamma(s/2) \zeta(s)$ is an entire function of order 1 satisfying the functional equation $\xi(s) = \xi(1 - s)$.
2. **Slide 2 (`ordering`):** Provide 5 steps of Riemann's proof: (1) express $\pi^{-s/2} \Gamma(s/2) \zeta(s) = \int_0^\infty x^{s/2 - 1} \omega(x) dx$ where $\omega(x) = \sum_{n=1}^\infty e^{-n^2 \pi x}$, (2) split the integral $\int_0^1 + \int_1^\infty$, (3) use the Jacobi theta transformation $\omega(1/x) = \sqrt{x} \omega(x) + \frac{1}{2}\sqrt{x} - \frac{1}{2}$ (from Poisson Summation), (4) change variables $x \to 1/x$ on $\int_0^1$ to obtain $\pi^{-s/2} \Gamma(s/2) \zeta(s) = \frac{1}{s(s-1)} + \int_1^\infty (x^{s/2 - 1} + x^{(1-s)/2 - 1}) \omega(x) dx$, (5) multiply by $\frac{1}{2} s(s-1)$ to produce $\xi(s)$, which is manifestly invariant under $s \leftrightarrow 1-s$.
3. **Slide 3 (`quiz`):** Test why the integral $\int_1^\infty (x^{s/2-1} + x^{(1-s)/2-1}) \omega(x) dx$ converges for *all* complex $s \in \mathbb{C}$ (because $\omega(x) = \mathcal{O}(e^{-\pi x})$ decays exponentially fast as $x \to \infty$).
4. **Slide 4 (`proof`):** Interactive derivation of Euler's product $\zeta(s) = \prod_p (1 - p^{-s})^{-1}$ by expanding geometric series $\sum_{k=0}^\infty p^{-ks}$ and applying the Fundamental Theorem of Arithmetic.
5. **Slide 5 (`one_word`):** Plain-text recall of the Greek letter naming the completed zeta function $\xi(s)$ (xi).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Riemann's Functional Equation**\nDefine the completed entire zeta function $\\xi(s)$ by:\n$$\n\\xi(s) = \\frac{1}{2} s(s - 1) \\pi^{-s/2} \\Gamma\\left(\\frac{s}{2}\\right) \\zeta(s)\n$$\nThen $\\xi(s)$ extends to an **entire function of order 1** on all of $\\mathbb{C}$, satisfying the reflection symmetry:\n$$\n\\xi(s) = \\xi(1 - s)\n$$\nEquivalently, $\\zeta(s) = 2^s \\pi^{s-1} \\sin\\left(\\frac{\\pi s}{2}\\right) \\Gamma(1 - s) \\zeta(1 - s)$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps of Riemann's derivation of the functional equation using theta functions.",
      "orderItems": [
        "Express pi^{-s/2} Gamma(s/2) zeta(s) as the Mellin transform integral int_0^infty x^{s/2 - 1} omega(x) dx, where omega(x) = sum_{n=1}^infty e^{-n^2 pi x}",
        "Split the integral into two regions: int_0^1 x^{s/2 - 1} omega(x) dx + int_1^infty x^{s/2 - 1} omega(x) dx",
        "Apply the Poisson Summation Jacobi theta identity: omega(1/x) = sqrt(x) omega(x) + (1/2) sqrt(x) - 1/2",
        "Substitute x -> 1/x on the [0, 1] integral to convert it to an integral over [1, infty), generating the pole terms 1/(s(s-1))",
        "Combine into pi^{-s/2} Gamma(s/2) zeta(s) = 1/(s(s-1)) + int_1^infty (x^{s/2 - 1} + x^{-s/2 - 1/2}) omega(x) dx, which is manifestly symmetric under s <-> 1-s"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the integral int_1^infty (x^{s/2 - 1} + x^{(1-s)/2 - 1}) omega(x) dx an ENTIRE function (analytic everywhere in C)?",
      "options": [
        { "text": "Because omega(x) = sum_{n=1}^infty e^{-n^2 pi x} decays exponentially fast as x -> infty (like e^{-pi x}), ensuring uniform absolute convergence for all complex s in C", "isCorrect": true, "explanation": "Correct! The exponential suppression e^{-pi x} overcomes any polynomial growth in x^{s/2-1}, making the integral entire." },
        { "text": "Because x is bounded between 0 and 1", "isCorrect": false, "explanation": "Incorrect: The domain of integration is [1, infty)." },
        { "text": "Because Gamma(s) is bounded", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because zeta(s) has no zeros", "isCorrect": false, "explanation": "Incorrect: zeta(s) has infinitely many zeros." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Euler's Product Formula",
      "interactiveSteps": [
        {
          "stepText": "For Re(s) > 1 and prime p, write the geometric series (1 - p^{-s})^{-1} = 1 + p^{-s} + p^{-2s} + p^{-3s} + ..."
        },
        {
          "prompt": "Multiplying this geometric series across all primes prod_{p} (1 - p^{-s})^{-1}, why does the expanded sum equal sum_{n=1}^infty n^{-s} = zeta(s)?",
          "options": [
            { "text": "By the Fundamental Theorem of Arithmetic, every integer n >= 1 factors uniquely as a product of prime powers n = prod p_i^{a_i}", "isCorrect": true },
            { "text": "Because all primes are odd", "isCorrect": false },
            { "text": "Because the sum of reciprocal primes diverges", "isCorrect": false },
            { "text": "Because s is real", "isCorrect": false }
          ]
        },
        {
          "stepText": "Thus prod_{p} (1 - p^{-s})^{-1} = sum_{n=1}^infty n^{-s} = zeta(s), proving Euler's Product Formula."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the Greek letter name for the completed zeta function xi(s) = (1/2) s (s-1) pi^{-s/2} Gamma(s/2) zeta(s)?",
      "blankAnswer": "xi"
    }
  ]
}
```
