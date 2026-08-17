# Duofy Reusable Lesson Format: Andronov-Hopf Bifurcation and Limit Cycle Generation

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics / Dynamical_Systems_and_Chaos_Theory / Bifurcation_Theory`  
**Lesson Format Type:** `hopf_bifurcation_and_limit_cycle_generation`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mathematical proof and classification of the **Andronov-Hopf Bifurcation** in 2D systems, analyze the crossing of complex conjugate eigenvalues across the imaginary axis $\operatorname{Re}(\lambda(\mu_c)) = 0$, distinguish **Supercritical vs Subcritical** limit cycle generation, and compute the First Lyapunov Coefficient $l_1$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Andronov-Hopf Theorem & Polar Normal Form Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Polar Radial Decoupling Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Transversality Condition d(Re(lambda))/dmu Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Limit Cycle Radius R ~ sqrt(mu) Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Originating Periodic Orbit Mathematical Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Andronov-Hopf Bifurcation Theorem: Let $\dot{\mathbf{x}} = \mathbf{f}(\mathbf{x}, \mu)$ with equilibrium at $\mathbf{0}$. If the Jacobian $Df(\mathbf{0}, \mu)$ has a pair of complex conjugate eigenvalues $\lambda_{1, 2}(\mu) = \alpha(\mu) \pm i \omega(\mu)$ satisfying: (1) $\alpha(0) = 0, \omega(0) = \omega_0 > 0$ (imaginary axis crossing), (2) transversality $\alpha'(0) \ne 0$. In polar coordinates $(r, \theta)$, the normal form is: $\dot{r} = (\alpha'(0)\mu) r - a r^3, \dot{\theta} = \omega_0 + b r^2$. If $a > 0$, it is **Supercritical** (birth of stable limit cycle of radius $r^* = \sqrt{\alpha'(0)\mu/a}$ for $\mu > 0$). If $a < 0$, it is **Subcritical** (unstable cycle for $\mu < 0$).
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the normal form in polar coordinates: (1) transform the 2D Cartesian system $\dot{x} = \mu x - \omega y + f_1(x, y)$, $\dot{y} = \omega x + \mu y + f_2(x, y)$ to complex variable $z = x + i y$, (2) write $\dot{z} = (\mu + i\omega)z + N(z, \bar{z})$, (3) perform near-identity coordinate transformation to eliminate non-resonant quadratic and cubic terms, (4) retain resonant cubic term: $\dot{w} = (\mu + i\omega)w - (a + i b)|w|^2 w$, (5) substitute polar form $w = r e^{i\theta}$ to decouple amplitude and phase equations $\dot{r} = \mu r - a r^3$ and $\dot{\theta} = \omega - b r^2$.
3. **Slide 3 (`quiz`):** Test the role of the transversality condition $\left.\frac{d}{d\mu}\operatorname{Re}(\lambda(\mu))\right|_{\mu=0} \ne 0$: (It ensures that the eigenvalues cross the imaginary axis with non-zero speed, preventing degenerate tangential touching).
4. **Slide 4 (`proof`):** Interactive derivation showing that setting $\dot{r} = 0 \implies r(\mu - a r^2) = 0$ yields the non-zero stable limit cycle radius $r^* = \sqrt{\mu / a}$ for $\mu > 0$ when $a > 0$.
5. **Slide 5 (`one_word`):** Plain-text recall of the two-word term for an isolated periodic trajectory in phase space (limit-cycle / limit cycle).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hopf_bifurcation_and_limit_cycle_generation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Andronov-Hopf Bifurcation**\nLet $\\dot{\\mathbf{x}} = \\mathbf{f}(\\mathbf{x}, \\mu)$ in $\\mathbb{R}^2$ with fixed point at the origin. Suppose the Jacobian $J(\\mu)$ has eigenvalues:\n$$\n\\lambda_{1, 2}(\\mu) = \\alpha(\\mu) \\pm i \\omega(\\mu)\n$$\n• **Hopf Conditions:**\n  1. **Imaginary Crossing:** $\\alpha(0) = 0$ and $\\omega_0 = \\omega(0) > 0$.\n  2. **Transversality:** $\\alpha'(0) = \\left.\\frac{d}{d\\mu}\\operatorname{Re}(\\lambda)\\right|_{\\mu=0} > 0$ (eigenvalues cross with non-zero speed).\n• **Polar Normal Form:**\n$$\n\\dot{r} = \\mu r - a r^3, \\qquad \\dot{\\theta} = \\omega_0 + b r^2\n$$\n• **Supercritical ($a > 0$):** A stable spiral turns into an unstable spiral, shedding a **stable limit cycle** of radius $r^* = \\sqrt{\\mu / a}$ for $\\mu > 0$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps transforming a 2D planar system near a Hopf bifurcation into polar normal form.",
      "orderItems": [
        "Transform the 2D Cartesian real system (x_dot, y_dot) into a single complex differential equation for z = x + i y",
        "Write z_dot = (mu + i omega) z + N(z, conjugate(z)) incorporating all nonlinear terms",
        "Perform a near-identity coordinate transformation w = z + h(z, conjugate(z)) to eliminate non-resonant quadratic terms",
        "Retain the resonant cubic term to obtain the Poincaré-Dulac normal form: w_dot = (mu + i omega) w - (a + i b) |w|^2 w",
        "Substitute polar coordinates w = r e^{i theta} and separate real and imaginary parts to decouple into r_dot = mu r - a r^3 and theta_dot = omega - b r^2"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the physical mathematical necessity of the transversality condition d(Re(lambda))/dmu != 0 at mu = 0 in the Hopf bifurcation theorem?",
      "options": [
        { "text": "It guarantees that the complex conjugate eigenvalues strictly cross the imaginary axis with non-zero velocity, ruling out degenerate cases where eigenvalues merely touch and turn back", "isCorrect": true, "explanation": "Correct! Non-zero derivative ensures genuine crossing from the left half-plane (stability) to the right half-plane (instability)." },
        { "text": "It forces the frequency omega to be zero", "isCorrect": false, "explanation": "Incorrect: Frequency omega must be strictly non-zero." },
        { "text": "It prevents the system from having fixed points", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It requires the phase space to be 1-dimensional", "isCorrect": false, "explanation": "Incorrect: Hopf bifurcations require at least 2 dimensions." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Limit Cycle Radius Scaling r* ~ sqrt(mu)",
      "interactiveSteps": [
        {
          "stepText": "Consider the radial normal form equation dr/dt = mu r - a r^3 with a > 0. To find periodic limit cycle orbits, set dr/dt = 0."
        },
        {
          "prompt": "Factoring r (mu - a r^2) = 0 for mu > 0, what is the non-trivial radial equilibrium r*?",
          "options": [
            { "text": "r* = sqrt(mu / a)", "isCorrect": true },
            { "text": "r* = mu / a", "isCorrect": false },
            { "text": "r* = mu^2", "isCorrect": false },
            { "text": "r* = 0 only", "isCorrect": false }
          ]
        },
        {
          "stepText": "Linearizing about r*: d/dr(mu r - a r^3) at r* gives mu - 3a(mu/a) = -2mu < 0, proving that the limit cycle is exponentially stable."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What hyphenated term describes an isolated closed trajectory in phase space representing self-sustained periodic oscillation?",
      "blankAnswer": "limit-cycle"
    }
  ]
}
```
