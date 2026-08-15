# Duofy Reusable Lesson Format: Differential Equations - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Differential_Equations_ODEs_and_PDEs`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through core ODE/PDE existence and boundary proofs: Picard-Lindelöf Existence & Uniqueness Theorem, Maximum Principle for Parabolic Equations, and d'Alembert's Derivation.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Picard-Lindelöf Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Picard Iteration Proof Strategy Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Lipschitz Condition Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Separation Proof Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Uniqueness Condition Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The Picard-Lindelöf Existence and Uniqueness Theorem**\nConsider initial value problem $\\frac{dy}{dt} = f(t, y)$ with $y(t_0) = y_0$.\nIf $f(t, y)$ is continuous and satisfies a **Lipschitz condition** in $y$ on a rectangle $R$:\n$$\n|f(t, y_1) - f(t, y_2)| \\le L |y_1 - y_2|\n$$\nthen there exists a unique local solution $y(t)$ on an interval $|t - t_0| \\le h$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove Picard-Lindelöf via Banach Fixed-Point Theorem.",
      "orderItems": [
        "Reformulate IVP as integral operator T(y)(t) = y_0 + ∫_{t_0}^t f(s, y(s)) ds.",
        "Equip C[t_0-h, t_0+h] with supremum metric d(y_1, y_2) = max |y_1(t) - y_2(t)|.",
        "Apply Lipschitz condition to bound d(T(y_1), T(y_2)) <= L h d(y_1, y_2).",
        "Choose h < 1 / L so that T is a strict contraction mapping.",
        "Apply Banach Fixed-Point Theorem to deduce unique fixed point y(t) = T(y)(t)."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What does the Maximum Principle state for solutions of the Heat Equation $u_t = u_{xx}$ on a bounded domain $\\Omega \\times [0, T]$?",
      "options": [
        { "text": "Maximum and minimum values of u occur on the parabolic boundary (t=0 or spatial boundary)", "isCorrect": true, "explanation": "Correct! Heat cannot create new internal temperature maxima over time." },
        { "text": "Maximum value occurs at center of domain", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "u must be constant", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Maximum value grows exponentially", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Separation of Variables for $u_t = c^2 u_{xx}$",
      "interactiveSteps": [
        { "stepText": "Assume product solution $u(x, t) = X(x) T(t)$. Substitute into $u_t = c^2 u_{xx}$." },
        {
          "prompt": "Dividing by $c^2 X(x) T(t)$ separates variables. What must both sides equal?",
          "options": [
            { "text": "A constant separation parameter -λ", "isCorrect": true },
            { "text": "Variable x", "isCorrect": false },
            { "text": "Variable t", "isCorrect": false },
            { "text": "0", "isCorrect": false }
          ]
        },
        { "stepText": "Yields spatial ODE $X'' + \\lambda X = 0$ and temporal ODE $T' + c^2 \\lambda T = 0$." }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What continuity condition |f(y1) - f(y2)| <= L |y1 - y2| guarantees uniqueness of ODE solutions?",
      "blankAnswer": "lipschitz"
    }
  ]
}
```
