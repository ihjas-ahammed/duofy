# Duofy Reusable Lesson Format: Optimization & Control Theory - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through foundational optimization proofs: KKT Necessary Conditions via Hyperplane Separation Theorem, Strong Duality under Slater's Condition, and Pontryagin's Maximum Principle in Optimal Control.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | KKT Optimality & Strong Duality Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Convex Separation Proof Strategy Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Slater's Condition Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive LQR Riccati Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Duality Gap Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Strong Duality & Slater's Condition**\nFor a convex optimization problem $\\min f(x)$ s.t. $g_i(x) \\le 0, A x = b$:\n$$\nf(x^*) = g(\\lambda^*, \\nu^*)\n$$\nIf there exists a strictly feasible point $x$ (Slater's Condition: $g_i(x) < 0$), then **Strong Duality** holds: the optimal duality gap is **zero**."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove Strong Duality using Hyperplane Separation.",
      "orderItems": [
        "Define convex set A = {(u, v, t) | ∃ x: g_i(x) ≤ u_i, h_j(x) = v_j, f(x) ≤ t}.",
        "Observe that (0, 0, p*) lies on boundary of convex set A, where p* is primal optimal value.",
        "Apply Separating Hyperplane Theorem to construct non-zero vector (λ, ν, μ) separating (0, 0, p*) from A.",
        "Show μ > 0 by convexity and Slater's condition to normalize μ = 1.",
        "Deduce Lagrangian Dual Function g(λ, ν) = p*, proving zero duality gap."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is Pontryagin's Maximum Principle in Optimal Control for cost $J = \\int L(x, u, t) dt$?",
      "options": [
        { "text": "Optimal control u*(t) maximizes the Hamiltonian H(x, u, λ, t) = λ^T f(x, u, t) - L(x, u, t) at each instant", "isCorrect": true, "explanation": "Correct! Pontryagin proves optimal u*(t) maximizes pointwise Hamiltonian H." },
        { "text": "Control u(t) must be zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Cost J is infinite", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "System must be non-linear", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: LQR Optimal State Feedback Gain",
      "interactiveSteps": [
        { "stepText": "For LTI system $\\dot{x} = A x + B u$ with quadratic cost $J = \\int (x^T Q x + u^T R u) dt$, assume value function $V(x) = x^T P x$." },
        {
          "prompt": "Minimizing Hamiltonian $H = x^T Q x + u^T R u + 2 x^T P (A x + B u)$ over $u$ yields optimal gain $u^*(t) = -K x$ where $K = $?",
          "options": [
            { "text": "K = R⁻¹ B^T P", "isCorrect": true },
            { "text": "K = P B", "isCorrect": false },
            { "text": "K = R B^T", "isCorrect": false },
            { "text": "K = A P", "isCorrect": false }
          ]
        },
        { "stepText": "Substituting $u^* = -R^{-1} B^T P x$ back into HJB yields Continuous-Time Algebraic Riccati Equation (CARE): $A^T P + P A - P B R^{-1} B^T P + Q = 0$!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What term describes the difference between optimal primal objective f(x*) and optimal dual objective g(λ*, ν*)?",
      "blankAnswer": "gap"
    }
  ]
}
```
