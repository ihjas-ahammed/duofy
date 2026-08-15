# Duofy Reusable Lesson Format: Elliptic, Parabolic, and Hyperbolic PDEs - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Differential_Equations_ODEs_and_PDEs / Elliptic_Parabolic_Hyperbolic_PDEs`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the derivation of the **Canonical Coordinate Reduction** for hyperbolic PDEs ($u_{\xi\eta} = 0$) using characteristic ODEs, and prove the **Weak Maximum Principle** for elliptic equations ($\Delta u \ge 0$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Canonical Reduction & Maximum Principle Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Characteristic Coordinate Reduction Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Hessian Maximum Principle Justification | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | d'Alembert Formula Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Characteristic Curve Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Maximum Principle for Harmonic Functions: If $\Delta u = 0$ on bounded domain $\Omega$, then $\max_{\bar{\Omega}} u = \max_{\partial \Omega} u$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof of the Maximum Principle: (1) let $u_\epsilon(x, y) = u(x, y) + \epsilon(x^2 + y^2)$ with $\epsilon > 0$, (2) compute $\Delta u_\epsilon = \Delta u + 4\epsilon = 4\epsilon > 0$, (3) show $u_\epsilon$ cannot have an interior local maximum since at a maximum $\Delta u_\epsilon = u_{xx} + u_{yy} \le 0$, (4) deduce $\max_{\bar{\Omega}} u_\epsilon = \max_{\partial \Omega} u_\epsilon$, (5) let $\epsilon \to 0$ to conclude $\max_{\bar{\Omega}} u = \max_{\partial \Omega} u$.
3. **Slide 3 (`quiz`):** Test why at an interior local maximum $(x_0, y_0)$, the Laplacian $\Delta u = u_{xx} + u_{yy} \le 0$.
4. **Slide 4 (`proof`):** Interactive derivation integrating the canonical form $u_{\xi\eta} = 0$ to obtain d'Alembert's formula $u(x, t) = f(x - ct) + g(x + ct)$.
5. **Slide 5 (`one_word`):** Plain-text recall of the name of the formula for 1D wave equation solutions (d'Alembert).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Weak Maximum Principle for Harmonic Functions**\nLet $\\Omega \\subset \\mathbb{R}^2$ be a bounded open domain, and let $u \\in C^2(\\Omega) \\cap C(\\bar{\\Omega})$ satisfy Laplace's equation:\n$$\n\\Delta u = u_{xx} + u_{yy} = 0 \\quad \\text{in } \\Omega\n$$\nThen the maximum and minimum values of $u$ on the closed domain $\\bar{\\Omega}$ are achieved on the **boundary** $\\partial \\Omega$:\n$$\n\\max_{\\bar{\\Omega}} u(x, y) = \\max_{\\partial \\Omega} u(x, y) \\quad \\text{and} \\quad \\min_{\\bar{\\Omega}} u(x, y) = \\min_{\\partial \\Omega} u(x, y)\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the proof steps for the Weak Maximum Principle of harmonic functions.",
      "orderItems": [
        "Define the perturbed auxiliary function u_eps(x, y) = u(x, y) + eps * (x^2 + y^2) for eps > 0",
        "Compute the Laplacian: Delta u_eps = Delta u + 4 eps = 0 + 4 eps = 4 eps > 0 in Omega",
        "Suppose u_eps had an interior maximum at (x_0, y_0); then (u_eps)_{xx} <= 0 and (u_eps)_{yy} <= 0, so Delta u_eps <= 0, a contradiction",
        "Conclude that u_eps must attain its maximum on the boundary: max_{bar{Omega}} u_eps = max_{dOmega} u_eps",
        "Take the limit as eps -> 0 to deduce max_{bar{Omega}} u = max_{dOmega} u"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "At an interior local maximum point (x_0, y_0) of a smooth function u(x, y), what sign must the pure second partial derivatives u_{xx} and u_{yy} have?",
      "options": [
        { "text": "Both u_{xx} <= 0 and u_{yy} <= 0, which implies Delta u = u_{xx} + u_{yy} <= 0", "isCorrect": true, "explanation": "Correct! By the second derivative test in multivariable calculus, concave-down curvature at a maximum requires non-positive second pure derivatives." },
        { "text": "Both u_{xx} > 0 and u_{yy} > 0", "isCorrect": false, "explanation": "Incorrect: Positive second derivatives correspond to a local minimum." },
        { "text": "u_{xx} + u_{yy} = 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "u_{xx} = -u_{yy}", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: d'Alembert Formula for the 1D Wave Equation",
      "interactiveSteps": [
        {
          "stepText": "The 1D wave equation u_{tt} - c^2 u_{xx} = 0 factors as (d/dt - c d/dx)(d/dt + c d/dx)u = 0."
        },
        {
          "prompt": "Under the characteristic coordinate change xi = x - ct and eta = x + ct, the wave equation simplifies to which canonical PDE?",
          "options": [
            { "text": "u_{xi eta} = 0", "isCorrect": true },
            { "text": "u_{xi xi} + u_{eta eta} = 0", "isCorrect": false },
            { "text": "u_eta = u_{xi xi}", "isCorrect": false },
            { "text": "u_{xi} = 0", "isCorrect": false }
          ]
        },
        {
          "stepText": "Integrating u_{xi eta} = 0 yields u(xi, eta) = f(xi) + g(eta) = f(x - ct) + g(x + ct) (d'Alembert solution)."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the name of the French mathematician who formulated the general traveling wave solution u(x,t) = f(x-ct) + g(x+ct)?",
      "blankAnswer": "dalembert"
    }
  ]
}
```
