# Duofy Reusable Lesson Format: Cauchy-Riemann Equations - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis / Cauchy_Riemann_Equations`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the derivation of the **Cauchy-Riemann Equations** from the difference quotient limit approaching along horizontal vs. vertical directions, and the proof of the sufficiency theorem under $C^1$ continuity of partial derivatives.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Complex Differentiability Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Horizontal vs Vertical Limit Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Directional Path Equivalence Justification | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Harmonic Conjugacy Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Laplace Operator Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Theorem: If $f(z) = u + iv$ is complex differentiable at $z_0$, then $u_x, u_y, v_x, v_y$ exist and satisfy $u_x = v_y$ and $u_y = -v_x$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof: (1) write limit $f'(z_0) = \lim_{\Delta z \to 0} \frac{f(z_0 + \Delta z) - f(z_0)}{\Delta z}$, (2) approach along real axis ($\Delta z = \Delta x$), yielding $f'(z_0) = u_x + i v_x$, (3) approach along imaginary axis ($\Delta z = i \Delta y$), yielding $f'(z_0) = \frac{u_y + i v_y}{i} = v_y - i u_y$, (4) equate real and imaginary parts, (5) conclude $u_x = v_y$ and $u_y = -v_x$.
3. **Slide 3 (`quiz`):** Test why equating the two limits forces $u_x = v_y$ and $u_y = -v_x$.
4. **Slide 4 (`proof`):** Interactive derivation showing that mixed partial derivatives $u_{x y} = u_{y x}$ imply $u_{x x} + u_{y y} = 0$ (harmonicity).
5. **Slide 5 (`one_word`):** Plain-text recall of the name of the differential equation $\nabla^2 u = 0$ (Laplace).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Necessity of the Cauchy-Riemann Equations**\nLet $f(z) = u(x, y) + i v(x, y)$ be complex differentiable at $z_0 = x_0 + i y_0$.\nThen the first partial derivatives of $u$ and $v$ exist at $(x_0, y_0)$ and satisfy:\n$$\nu_x = v_y \\quad \\text{and} \\quad u_y = -v_x\n$$\nMoreover, the complex derivative equals $f'(z_0) = u_x(x_0, y_0) + i v_x(x_0, y_0)$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps deriving the Cauchy-Riemann equations from the limit definition.",
      "orderItems": [
        "Express the complex derivative as the limit f'(z_0) = lim_{Δz -> 0} [f(z_0 + Δz) - f(z_0)] / Δz",
        "Set Δz = Δx (real path), and compute the limit as Δx -> 0 to obtain f'(z_0) = u_x(x_0, y_0) + i v_x(x_0, y_0)",
        "Set Δz = i Δy (pure imaginary path), and compute the limit as Δy -> 0 to obtain f'(z_0) = (1/i)(u_y + i v_y) = v_y - i u_y",
        "Since f is complex differentiable, these two directional limits must be equal: u_x + i v_x = v_y - i u_y",
        "Equate real and imaginary parts separately to conclude u_x = v_y and v_x = -u_y (u_y = -v_x)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is (1/i)(u_y + i v_y) equal to v_y - i u_y?",
      "options": [
        { "text": "Multiplying numerator and denominator by -i yields -i u_y - i^2 v_y = v_y - i u_y", "isCorrect": true, "explanation": "Correct! Since 1/i = -i and -i * i = 1, (1/i)(u_y + i v_y) = -i u_y + v_y = v_y - i u_y." },
        { "text": "Because 1/i = 1", "isCorrect": false, "explanation": "Incorrect: 1/i = -i." },
        { "text": "Because u and v are constant", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because u_y = 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Harmonicity of Real and Imaginary Parts",
      "interactiveSteps": [
        {
          "stepText": "Assume f = u + iv is holomorphic with C^2 continuous second partial derivatives."
        },
        {
          "prompt": "Differentiating u_x = v_y with respect to x gives u_{xx} = v_{yx}. Differentiating u_y = -v_x with respect to y gives u_{yy} = -v_{xy}. What is u_{xx} + u_{yy} by Clairaut's theorem (v_{yx} = v_{xy})?",
          "options": [
            { "text": "u_{xx} + u_{yy} = v_{yx} - v_{xy} = 0 (Laplace's equation)", "isCorrect": true },
            { "text": "u_{xx} + u_{yy} = 2 v_{xy}", "isCorrect": false },
            { "text": "u_{xx} + u_{yy} = 1", "isCorrect": false },
            { "text": "u_{xx} + u_{yy} is undefined", "isCorrect": false }
          ]
        },
        {
          "stepText": "Thus, the real part u(x, y) of any holomorphic function satisfies Laplace's equation nabla^2 u = 0."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the name of the second-order partial differential equation nabla^2 u = 0 satisfied by both u and v?",
      "blankAnswer": "laplace"
    }
  ]
}
```
