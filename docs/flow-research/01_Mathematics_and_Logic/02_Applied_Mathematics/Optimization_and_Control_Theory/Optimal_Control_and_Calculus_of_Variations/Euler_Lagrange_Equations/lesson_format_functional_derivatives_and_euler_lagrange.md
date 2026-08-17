# Duofy Reusable Lesson Format: Functional Derivatives and the Euler-Lagrange Equation

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Optimal_Control_and_Calculus_of_Variations / Euler_Lagrange_Equations`  
**Lesson Format Type:** `functional_derivatives_and_euler_lagrange`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the transition from functions to **Integral Functionals** $J[y] = \int_{x_1}^{x_2} L(x, y, y') dx$, derive the **Euler-Lagrange Necessary Condition** $\frac{d}{dx}\left(\frac{\partial L}{\partial y'}\right) - \frac{\partial L}{\partial y} = 0$ via the fundamental lemma of calculus of variations, and formulate natural boundary conditions.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Functional Variation & Euler-Lagrange Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Variational Integration by Parts Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Legendre Second Variation Condition Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Geodesic Straight Line on Euclidean Plane Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Free Boundary Natural Condition Derivative Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Calculus of Variations problem: Find a function $y \in C^2[x_1, x_2]$ with fixed endpoints $y(x_1) = y_1, y(x_2) = y_2$ that renders the functional $J[y] = \int_{x_1}^{x_2} L(x, y(x), y'(x)) dx$ stationary ($\delta J = 0$). State the Euler-Lagrange Equation: $\frac{d}{dx}\left(\frac{\partial L}{\partial y'}\right) - \frac{\partial L}{\partial y} = 0$. State the Natural Boundary Condition for free endpoints: $\left.\frac{\partial L}{\partial y'}\right|_{x_2} = 0$.
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the Euler-Lagrange equation: (1) let $y(x, \epsilon) = y(x) + \epsilon \eta(x)$ where $\eta(x_1) = \eta(x_2) = 0$, (2) differentiate the functional with respect to $\epsilon$: $\left.\frac{dJ}{d\epsilon}\right|_{\epsilon=0} = \int_{x_1}^{x_2} \left(\frac{\partial L}{\partial y}\eta + \frac{\partial L}{\partial y'}\eta'\right) dx$, (3) integrate the second term by parts: $\int_{x_1}^{x_2} \frac{\partial L}{\partial y'}\eta' dx = \left[\frac{\partial L}{\partial y'}\eta\right]_{x_1}^{x_2} - \int_{x_1}^{x_2} \frac{d}{dx}\left(\frac{\partial L}{\partial y'}\right)\eta dx$, (4) vanish the boundary term using $\eta(x_1) = \eta(x_2) = 0$, yielding $\delta J = \int_{x_1}^{x_2} \left(\frac{\partial L}{\partial y} - \frac{d}{dx}\frac{\partial L}{\partial y'}\right)\eta(x) dx = 0$, (5) invoke the Fundamental Lemma of Calculus of Variations to deduce $\frac{\partial L}{\partial y} - \frac{d}{dx}\left(\frac{\partial L}{\partial y'}\right) = 0$.
3. **Slide 3 (`quiz`):** Test the Legendre second variation condition for a local minimum: What condition must the integrand $L(x, y, y')$ satisfy to ensure $\delta^2 J \ge 0$? ($\frac{\partial^2 L}{\partial y'^2} \ge 0$ for all $x \in [x_1, x_2]$).
4. **Slide 4 (`proof`):** Interactive derivation showing that for Euclidean arc length $J[y] = \int_{x_1}^{x_2} \sqrt{1 + y'^2} dx$, $L = \sqrt{1 + y'^2}$ has $\frac{\partial L}{\partial y} = 0$ and $\frac{\partial L}{\partial y'} = \frac{y'}{\sqrt{1 + y'^2}} = C \implies y'(x) = m \implies y(x) = m x + b$ (straight line geodesic!).
5. **Slide 5 (`one_word`):** Plain-text recall of the mathematical term describing a function that maps a space of functions to the real numbers (functional).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "functional_derivatives_and_euler_lagrange",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Euler-Lagrange Equation in Calculus of Variations**\n• Let $J[y]$ be an **integral functional** defined on $C^2[x_1, x_2]$ with boundary conditions $y(x_1) = y_1, \\, y(x_2) = y_2$:\n$$\nJ[y] = \\int_{x_1}^{x_2} L(x, y(x), y'(x)) \\, dx\n$$\n• **Stationary Path Condition (First Variation $\\delta J = 0$):**\n$$\n\\frac{d}{dx}\\left( \\frac{\\partial L}{\\partial y'} \\right) - \\frac{\\partial L}{\\partial y} = 0\n$$\n• **Natural Boundary Condition:** If the endpoint $y(x_2)$ is free (unconstrained), the extremal path must satisfy:\n$$\n\\left. \\frac{\\partial L}{\\partial y'} \\right|_{x = x_2} = 0\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps deriving the Euler-Lagrange equation from delta J = 0.",
      "orderItems": [
        "Construct 1-parameter perturbed test paths y(x, eps) = y(x) + eps * eta(x) with eta(x_1) = eta(x_2) = 0",
        "Compute the first variation derivative: dJ/deps = int_{x_1}^{x_2} (partial L / partial y * eta + partial L / partial y' * eta') dx",
        "Apply integration by parts to the derivative term: int (partial L / partial y') eta' dx = [partial L / partial y' * eta]_{x_1}^{x_2} - int d/dx(partial L / partial y') eta dx",
        "Eliminate the boundary bracket since eta vanishes at fixed endpoints: eta(x_1) = eta(x_2) = 0",
        "Apply the Fundamental Lemma of Calculus of Variations to int (partial L / partial y - d/dx(partial L / partial y')) eta(x) dx = 0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the Legendre Necessary Condition on the second derivative of L to guarantee that an extremal path y(x) is a local MINIMUM of the functional J[y]?",
      "options": [
        { "text": "partial^2 L / partial (y')^2 >= 0 for all x in [x_1, x_2] (convexity of the Lagrangian with respect to velocity / slope y')", "isCorrect": true, "explanation": "Correct! Legendre's condition requires the second variation delta^2 J = int (L_yy eta^2 + 2 L_yy' eta eta' + L_y'y' (eta')^2) dx >= 0, which holds only if L_y'y' >= 0 everywhere." },
        { "text": "partial L / partial y = 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "partial^2 L / partial y^2 < 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "L must be independent of x", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Shortest Path on a Plane is a Straight Line",
      "interactiveSteps": [
        {
          "stepText": "To minimize the arc length functional J[y] = int_{x_1}^{x_2} sqrt(1 + y'^2) dx, the Lagrangian is L = sqrt(1 + y'^2)."
        },
        {
          "prompt": "Evaluate partial L / partial y and partial L / partial y'.",
          "options": [
            { "text": "partial L / partial y = 0 and partial L / partial y' = y' / sqrt(1 + y'^2)", "isCorrect": true },
            { "text": "partial L / partial y = 1", "isCorrect": false },
            { "text": "partial L / partial y' = 2 y'", "isCorrect": false },
            { "text": "partial L / partial y = y'", "isCorrect": false }
          ]
        },
        {
          "stepText": "Since partial L / partial y = 0, Euler-Lagrange gives d/dx(y' / sqrt(1 + y'^2)) = 0 => y' / sqrt(1 + y'^2) = C => y'(x) = m (constant slope), proving y(x) = mx + b is a straight line!"
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the mathematical noun for a mapping J[y] whose domain is a space of functions and whose range is the real numbers?",
      "blankAnswer": "functional"
    }
  ]
}
```
