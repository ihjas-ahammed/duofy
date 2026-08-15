# Duofy Reusable Lesson Format: Prime Number Theorem - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Analytic_Number_Theory / Prime_Number_Theorem`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the non-vanishing proof of $\zeta(1+it) \ne 0$ via the Mertens trigonometric identity $3 + 4\cos\theta + \cos 2\theta \ge 0$, and derive **Newman's Analytic Tauberian Theorem** connecting $\Phi(s)$ to the convergence of $\int_1^\infty \frac{\psi(x)-x}{x^2} dx$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Non-Vanishing $\zeta(1+it) \ne 0$ Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Mertens Identity Zero Contradiction Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Simple Pole Limit Exponent Balance Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Newman Contour Integration Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Prime Counting Integrand Function Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Non-Vanishing Theorem (Hadamard / de la Vallée Poussin): The Riemann zeta function has no zeros on the line $\operatorname{Re}(s) = 1$: $\zeta(1 + it) \ne 0$ for all real $t \ne 0$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof using Mertens' identity: (1) use the trigonometric identity $3 + 4\cos\theta + \cos(2\theta) = 2(1+\cos\theta)^2 \ge 0$, (2) for $\sigma > 1$, consider product $P(\sigma) = \zeta(\sigma)^3 |\zeta(\sigma + it)|^4 |\zeta(\sigma + 2it)|$, (3) take logarithms to get $\ln P(\sigma) = \sum_{p, m} \frac{1}{m p^{m\sigma}} [3 + 4\cos(mt\ln p) + \cos(2mt\ln p)] \ge 0$, which forces $P(\sigma) \ge 1$, (4) assume $\zeta(1+it) = 0$ with order $\mu \ge 1$; as $\sigma \to 1^+$, $\zeta(\sigma) \sim \frac{1}{\sigma-1}$, $|\zeta(\sigma+it)|^4 \le C(\sigma-1)^{4\mu}$, and $|\zeta(\sigma+2it)| = \mathcal{O}(1)$, (5) multiply terms: $P(\sigma) \le C' (\sigma-1)^{4\mu - 3} \to 0$ as $\sigma \to 1^+$ (since $4\mu \ge 4 > 3$), contradicting $P(\sigma) \ge 1$.
3. **Slide 3 (`quiz`):** Test why the power balance $4\mu - 3 > 0$ forces $P(\sigma) \to 0$, creating the contradiction with $P(\sigma) \ge 1$.
4. **Slide 4 (`proof`):** Interactive derivation of Newman's Tauberian contour integral bounding $\int_0^T f(t) dt - g(0)$ via Cauchy's Theorem on a modified D-shaped contour.
5. **Slide 5 (`one_word`):** Plain-text recall of the hyphenated name of the Belgian mathematician who proved PNT and bounded the error term (de la Vallée Poussin / Poussin).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Non-Vanishing of the Zeta Function on $\\operatorname{Re}(s) = 1$**\nThe Riemann zeta function $\\zeta(s)$ satisfies:\n$$\n\\zeta(1 + it) \\ne 0 \\quad \\text{for all real } t \\in \\mathbb{R}\n$$\n*(This non-vanishing is the central analytical engine powering the Prime Number Theorem $\\pi(x) \\sim \\frac{x}{\\ln x}$).*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps proving zeta(1+it) != 0 via Mertens' trigonometric identity.",
      "orderItems": [
        "Recall the non-negative trigonometric identity: 3 + 4 cos(theta) + cos(2 theta) = 2(1 + cos theta)^2 >= 0",
        "Construct the auxiliary function P(sigma) = zeta(sigma)^3 * |zeta(sigma + it)|^4 * |zeta(sigma + 2it)| for sigma > 1",
        "Take logarithms using Euler products: ln P(sigma) = sum_{p, m} (1 / m p^{m sigma}) [3 + 4 cos(m t ln p) + cos(2 m t ln p)] >= 0, implying P(sigma) >= 1",
        "Assume zeta(1 + it) = 0 with multiplicity mu >= 1; then as sigma -> 1+, zeta(sigma) ~ 1/(sigma-1) and |zeta(sigma + it)|^4 <= C (sigma - 1)^{4 mu}",
        "Calculate the limit as sigma -> 1+: P(sigma) <= C' (sigma - 1)^{4 mu - 3}; since 4 mu >= 4, the limit is 0, which directly contradicts P(sigma) >= 1"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does the power of (sigma - 1) in P(sigma) <= C' (sigma - 1)^{4 mu - 3} force a contradiction with P(sigma) >= 1?",
      "options": [
        { "text": "Because the simple pole of zeta(sigma)^3 contributes (sigma-1)^{-3}, while the zero of order mu in |zeta(sigma+it)|^4 contributes (sigma-1)^{4 mu}, yielding a net positive exponent 4 mu - 3 >= 1 that goes to 0 as sigma -> 1+", "isCorrect": true, "explanation": "Correct! 4 zeros (exponent 4) overcome the 3 poles (exponent -3), forcing the product to 0 as sigma -> 1+, which contradicts P(sigma) >= 1." },
        { "text": "Because 3 + 4 + 1 = 8", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because zeta(s) is discontinuous", "isCorrect": false, "explanation": "Incorrect: zeta is meromorphic." },
        { "text": "Because primes are finite", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Newman's Analytic Tauberian Theorem",
      "interactiveSteps": [
        {
          "stepText": "Let f(t) be bounded and g(z) = int_0^infty f(t) e^{-zt} dt for Re(z) > 0, analytically continuable to Re(z) >= 0."
        },
        {
          "prompt": "Using Cauchy's Theorem on a semicircular contour of radius R, what does Newman's modified kernel e^{zT} (1 + z^2/R^2) prove about int_0^T f(t) dt as T -> infty?",
          "options": [
            { "text": "int_0^infty f(t) dt converges and equals g(0)", "isCorrect": true },
            { "text": "int_0^infty f(t) dt diverges to infinity", "isCorrect": false },
            { "text": "g(0) is always zero", "isCorrect": false },
            { "text": "f(t) must be constant", "isCorrect": false }
          ]
        },
        {
          "stepText": "Applying this to f(t) = psi(e^t) e^{-t} - 1 proves int_1^infty (psi(x) - x)/x^2 dx converges, which immediately implies psi(x) ~ x."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the single-word surname of the French mathematician who independently proved the Prime Number Theorem in 1896 alongside de la Vallée Poussin?",
      "blankAnswer": "hadamard"
    }
  ]
}
```
