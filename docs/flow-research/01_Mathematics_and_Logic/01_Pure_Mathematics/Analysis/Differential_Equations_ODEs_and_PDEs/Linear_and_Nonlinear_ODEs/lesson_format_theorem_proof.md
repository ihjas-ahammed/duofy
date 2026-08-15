# Duofy Reusable Lesson Format: Linear and Nonlinear ODEs - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Differential_Equations_ODEs_and_PDEs / Linear_and_Nonlinear_ODEs`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof and application of **Lyapunov's Direct Stability Theorem** and **Dulac's Negative Criterion** for ruling out periodic orbits in planar dynamical systems.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Lyapunov Direct Stability Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Energy Decay Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Total Time Derivative Justification | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Dulac's Criterion Divergence Interactive Proof | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Planar Limit Cycle Theorem Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Lyapunov's Stability Theorem: Let $\mathbf{x}^* = \mathbf{0}$. If there exists a $C^1$ function $V(\mathbf{x}) > 0$ for $\mathbf{x} \ne \mathbf{0}$ ($V(\mathbf{0}) = 0$) such that $\dot{V}(\mathbf{x}) = \nabla V \cdot \mathbf{f}(\mathbf{x}) \le 0$, then $\mathbf{0}$ is stable. If $\dot{V}(\mathbf{x}) < 0$, it is asymptotically stable.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof: (1) let $B_r$ be a ball around the origin, (2) define $m = \min_{\partial B_r} V(\mathbf{x}) > 0$, (3) choose open neighborhood $U = \{\mathbf{x} \in B_r \mid V(\mathbf{x}) < m\}$, (4) show $\dot{V} \le 0 \implies V(\mathbf{x}(t)) \le V(\mathbf{x}_0) < m$, so $\mathbf{x}(t)$ never leaves $U \subset B_r$, (5) conclude Lyapunov stability ($\forall \epsilon > 0, \exists \delta > 0$).
3. **Slide 3 (`quiz`):** Test why the chain rule gives $\dot{V} = \frac{\partial V}{\partial x} \dot{x} + \frac{\partial V}{\partial y} \dot{y} = \nabla V \cdot \mathbf{f}$.
4. **Slide 4 (`proof`):** Interactive derivation of Dulac's Criterion applying Green's Theorem to show $\oint (\beta f dy - \beta g dx) = \iint \nabla \cdot (\beta \mathbf{f}) dA \ne 0$ along any periodic orbit.
5. **Slide 5 (`one_word`):** Plain-text recall of the theorem characterizing planar limit cycles (Poincaré-Bendixson).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Lyapunov's Direct Stability Method**\nLet $\\mathbf{x}^* = \\mathbf{0}$ be an equilibrium point of $\\dot{\\mathbf{x}} = \\mathbf{f}(\\mathbf{x})$.\nLet $V: U \\to \\mathbb{R}$ be a continuously differentiable function such that:\n1. $V(\\mathbf{0}) = 0$ and $V(\\mathbf{x}) > 0$ for all $\\mathbf{x} \\in U \\setminus \\{\\mathbf{0}\\}$ (positive definite).\n2. $\\dot{V}(\\mathbf{x}) = \\nabla V(\\mathbf{x}) \\cdot \\mathbf{f}(\\mathbf{x}) = \\frac{\\partial V}{\\partial x}\\dot{x} + \\frac{\\partial V}{\\partial y}\\dot{y} \\le 0$ for all $\\mathbf{x} \\in U$.\nThen $\\mathbf{0}$ is **Lyapunov stable**. If $\\dot{V}(\\mathbf{x}) < 0$ strictly for $\\mathbf{x} \\ne \\mathbf{0}$, $\\mathbf{0}$ is **asymptotically stable**."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps demonstrating Lyapunov stability via positive definite energy functions.",
      "orderItems": [
        "Let B_r be a closed ball of radius r inside domain U, and let m = min_{||x|| = r} V(x) > 0",
        "Define the sub-level set U_m = {x in B_r | V(x) < m}, which contains an open ball B_delta around the origin",
        "For any trajectory starting at x_0 in B_delta, integrate the derivative: V(x(t)) = V(x_0) + int_0^t dV/dt ds <= V(x_0) < m",
        "Because V(x(t)) < m for all t >= 0, the trajectory x(t) can never reach the boundary ||x|| = r",
        "Conclude that for every eps > 0 there exists delta > 0 such that ||x_0|| < delta implies ||x(t)|| < eps for all t >= 0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does dot(V) < 0 strictly imply that trajectories must approach the origin as t -> infinity?",
      "options": [
        { "text": "V(x(t)) is strictly decreasing and bounded below by 0, forcing x(t) to the minimum of V at the origin by LaSalle's Invariance Principle", "isCorrect": true, "explanation": "Correct! Energy continuously drains until the system reaches the global minimum V(0) = 0." },
        { "text": "Because V(x) must blow up to infinity", "isCorrect": false, "explanation": "Incorrect: V(x(t)) decreases, it does not blow up." },
        { "text": "Because all solutions become periodic", "isCorrect": false, "explanation": "Incorrect: Strict decrease of V rules out periodic orbits." },
        { "text": "Because the Jacobian matrix is zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Dulac's Criterion Ruling Out Periodic Orbits",
      "interactiveSteps": [
        {
          "stepText": "Suppose a periodic orbit C = dD encloses a region D in a simply connected domain."
        },
        {
          "prompt": "By Green's Theorem, oint_C [beta f dy - beta g dx] = iint_D [d(beta f)/dx + d(beta g)/dy] dA. Since C is a trajectory with dx = f dt, dy = g dt, what is the value of the line integral?",
          "options": [
            { "text": "0, because beta f(g dt) - beta g(f dt) = 0 identically along the trajectory", "isCorrect": true },
            { "text": "2 pi", "isCorrect": false },
            { "text": "1", "isCorrect": false },
            { "text": "infinity", "isCorrect": false }
          ]
        },
        {
          "stepText": "If div(beta f) does not change sign and is non-zero, the double integral is non-zero, contradicting 0 = 0 and ruling out periodic orbits."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What famous theorem establishes that bounded planar trajectories with no fixed points must converge to a limit cycle?",
      "blankAnswer": "poincare-bendixson"
    }
  ]
}
```
