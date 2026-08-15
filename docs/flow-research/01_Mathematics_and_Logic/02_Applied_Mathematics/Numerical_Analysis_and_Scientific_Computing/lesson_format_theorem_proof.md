# Duofy Reusable Lesson Format: Numerical Analysis - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through foundational proofs in numerical analysis: Quadratic Convergence of Newton's Method, von Neumann Stability Analysis for FTCS Heat Equation, and Lax Equivalence Theorem.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Newton Quadratic Convergence Theorem | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Taylor Expansion Proof Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | CFL Condition Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive von Neumann Stability Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Amplification Factor Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Quadratic Convergence of Newton-Raphson**\nLet $f \\in C^2[a, b]$ with simple root $r$ ($f(r) = 0, f'(r) \\neq 0$).\nIf initial guess $x_0$ is sufficiently close to $r$, the error $e_k = x_k - r$ satisfies:\n$$\n\\lim_{k \\to \\infty} \\frac{|e_{k+1}|}{|e_k|^2} = \\left| \\frac{f''(r)}{2 f'(r)} \\right| = C\n$$\nDoubling the number of correct decimal places at each iteration!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove quadratic convergence of Newton's Method.",
      "orderItems": [
        "Taylor expand f(r) = 0 around x_k: 0 = f(x_k) + (r - x_k) f'(x_k) + (1/2) (r - x_k)^2 f''(c_k).",
        "Divide equation by f'(x_k): 0 = f(x_k)/f'(x_k) - e_k + (1/2) e_k^2 f''(c_k)/f'(x_k).",
        "Substitute Newton update x_{k+1} = x_k - f(x_k)/f'(x_k), so e_{k+1} = x_k - f(x_k)/f'(x_k) - r.",
        "Combine terms to get e_{k+1} = (1/2) e_k^2 f''(c_k)/f'(x_k).",
        "Take absolute values and limits to conclude |e_{k+1}| / |e_k|^2 -> |f''(r) / (2 f'(r))|."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the Courant-Friedrichs-Lewy (CFL) stability condition for the explicit FTCS scheme for the 1D Heat Equation $u_t = \\alpha u_{xx}$ with spatial step $h$ and time step $k$?",
      "options": [
        { "text": "r = α k / h² ≤ 1/2", "isCorrect": true, "explanation": "Correct! If r > 1/2, round-off errors grow exponentially." },
        { "text": "r ≤ 1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "r ≥ 2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Unconditionally stable for all r", "isCorrect": false, "explanation": "Incorrect: That describes Backward Euler." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: von Neumann Amplification Factor $g(\\theta)$",
      "interactiveSteps": [
        { "stepText": "Substitute Fourier mode $U_j^n = g^n e^{i j \\theta}$ into FTCS heat scheme $U_j^{n+1} = U_j^n + r (U_{j+1}^n - 2 U_j^n + U_{j-1}^n)$." },
        {
          "prompt": "Simplifying yields amplification factor $g(\\theta) = 1 - 4r \\sin^2(\\theta / 2)$. For stability, what must $|g(\\theta)|$ satisfy?",
          "options": [
            { "text": "|g(θ)| ≤ 1 for all θ", "isCorrect": true },
            { "text": "|g(θ)| = 0", "isCorrect": false },
            { "text": "|g(θ)| > 1", "isCorrect": false },
            { "text": "|g(θ)| = ∞", "isCorrect": false }
          ]
        },
        { "stepText": "Since $-1 \\le 1 - 4r \\le 1 \\implies 4r \\le 2 \\implies r = \\frac{\\alpha k}{h^2} \\le \\frac{1}{2}$!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What factor g(θ) must satisfy |g(θ)| <= 1 in von Neumann stability analysis?",
      "blankAnswer": "amplification"
    }
  ]
}
```
