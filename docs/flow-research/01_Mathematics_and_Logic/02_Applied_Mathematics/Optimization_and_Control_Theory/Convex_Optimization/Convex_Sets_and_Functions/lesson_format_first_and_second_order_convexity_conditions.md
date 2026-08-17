# Duofy Reusable Lesson Format: First- and Second-Order Convexity Conditions

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Convex_Optimization / Convex_Sets_and_Functions`  
**Lesson Format Type:** `first_and_second_order_convexity_conditions`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through differential characterizations of **Convex Functions**, prove the **First-Order Tangent Underestimator Condition** ($f(y) \ge f(x) + \nabla f(x)^T(y - x)$), prove the **Second-Order Positive Semidefinite Hessian Condition** ($\nabla^2 f(x) \succeq 0$), and verify convexity of classic multi-variable objectives (e.g., Log-Sum-Exp, Quadratic forms).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Jensen's Inequality & Differential Conditions Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | 1D Restriction Proof of 1st-Order Condition Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Strict Convexity Positive Definite Hessian Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Log-Sum-Exp Hessian Cauchy-Schwarz Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Function Epigraph Geometric Set Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Jensen's Inequality: $f: C \to \mathbb{R}$ on convex domain $C$ is convex $\iff f(\theta x + (1-\theta)y) \le \theta f(x) + (1-\theta)f(y)$ for all $\theta \in [0, 1]$. State the First-Order Condition: If $f$ is differentiable, $f$ is convex $\iff f(y) \ge f(x) + \nabla f(x)^T(y - x)$ for all $x, y \in \operatorname{dom} f$. State the Second-Order Condition: If $f$ is twice differentiable, $f$ is convex $\iff \nabla^2 f(x) \succeq 0$ (positive semidefinite Hessian matrix) for all $x \in \operatorname{dom} f$.
2. **Slide 2 (`ordering`):** Provide 5 steps proving the First-Order condition from definition of convexity: (1) restrict $f$ to the 1D line $g(t) = f(x + t(y - x))$ for $t \in [0, 1]$, (2) by convexity, $g(t) = g(t \cdot 1 + (1-t) \cdot 0) \le t g(1) + (1-t) g(0)$, (3) rearrange terms: $\frac{g(t) - g(0)}{t} \le g(1) - g(0)$, (4) take the limit as $t \to 0^+$: $g'(0) = \lim_{t \to 0^+} \frac{g(t) - g(0)}{t} \le g(1) - g(0)$, (5) evaluate $g'(0) = \nabla f(x)^T(y - x)$ and $g(1) - g(0) = f(y) - f(x)$ to conclude $f(y) \ge f(x) + \nabla f(x)^T(y - x)$.
3. **Slide 3 (`quiz`):** Test the second-order condition: What does $\nabla^2 f(x) \succ 0$ (strictly positive definite Hessian) on an open convex domain imply? ($f$ is strictly convex, and any local minimum is the unique global minimum).
4. **Slide 4 (`proof`):** Interactive derivation showing that the Log-Sum-Exp function $f(x) = \log(\sum_{i=1}^n e^{x_i})$ has Hessian $\nabla^2 f(x) = \operatorname{diag}(z) - z z^T$ with $z_i = \frac{e^{x_i}}{\sum e^{x_k}}$, which satisfies $v^T \nabla^2 f(x) v = \sum z_i v_i^2 - (\sum z_i v_i)^2 \ge 0$ by Cauchy-Schwarz / Jensen, proving convexity.
5. **Slide 5 (`one_word`):** Plain-text recall of the geometric set of points lying above the graph of a function: $\operatorname{epi} f = \{(x, t) \mid f(x) \le t\}$ (epigraph).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "first_and_second_order_convexity_conditions",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Differential Characterizations of Convex Functions**\nLet $f: C \\subseteq \\mathbb{R}^n \\to \\mathbb{R}$ on a convex domain $C$.\n• **Jensen's Inequality (0-th Order Definition):**\n$$\nf(\\theta \\mathbf{x} + (1-\\theta)\\mathbf{y}) \\le \\theta f(\\mathbf{x}) + (1-\\theta)f(\\mathbf{y}) \\quad \\forall \\theta \\in [0, 1]\n$$\n• **First-Order Condition ($C^1$ Differentiable):** $f$ is convex $\\iff$ the affine tangent hyperplane is a **global underestimator** everywhere:\n$$\nf(\\mathbf{y}) \\ge f(\\mathbf{x}) + \\nabla f(\\mathbf{x})^T (\\mathbf{y} - \\mathbf{x}) \\quad \\forall \\mathbf{x}, \\mathbf{y} \\in C\n$$\n• **Second-Order Condition ($C^2$ Twice Differentiable):** $f$ is convex $\\iff$ its Hessian matrix is **Positive Semidefinite** everywhere:\n$$\n\\nabla^2 f(\\mathbf{x}) \\succeq 0 \\quad \\forall \\mathbf{x} \\in C\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps deriving the first-order condition f(y) >= f(x) + grad f(x)^T (y - x) from the definition of convexity.",
      "orderItems": [
        "Restrict f to the 1D line segment g(t) = f(x + t(y - x)) for t in [0, 1]",
        "Apply the definition of convexity: g(t) <= (1 - t) g(0) + t g(1)",
        "Subtract g(0) and divide both sides by t > 0: (g(t) - g(0)) / t <= g(1) - g(0)",
        "Take the limit as t -> 0^+ to obtain the directional derivative: g'(0) <= g(1) - g(0)",
        "Apply the multivariate chain rule to evaluate g'(0) = grad f(x)^T (y - x) and conclude f(y) >= f(x) + grad f(x)^T (y - x)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the primary optimization consequence if a twice-differentiable function f has a STRICTLY positive definite Hessian (nabla^2 f(x) succ 0) on its entire convex domain?",
      "options": [
        { "text": "f is strictly convex, guaranteeing that if a stationary point grad f(x*) = 0 exists, x* is the UNIQUE strict global minimum", "isCorrect": true, "explanation": "Correct! Strict positive definiteness of the Hessian guarantees strict convexity, ruling out multiple or flat global minima." },
        { "text": "f has no minimum", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "f is concave", "isCorrect": false, "explanation": "Incorrect: Concavity requires negative semidefinite Hessian." },
        { "text": "f is unbounded below", "isCorrect": false, "explanation": "Incorrect: Strict convexity creates bowl-like growth." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Convexity of the Log-Sum-Exp Function f(x) = log(sum_{k=1}^n e^{x_k})",
      "interactiveSteps": [
        {
          "stepText": "Let z_i = e^{x_i} / (sum_{k=1}^n e^{x_k}) be the softmax probability distribution (z_i > 0, sum z_i = 1). The gradient is grad f(x) = z."
        },
        {
          "prompt": "Computing the Hessian matrix nabla^2 f(x) = diag(z) - z z^T, how do we prove v^T (nabla^2 f(x)) v >= 0 for any test vector v?",
          "options": [
            { "text": "v^T nabla^2 f(x) v = sum z_i v_i^2 - (sum z_i v_i)^2 = Var_z(v) >= 0 (variance is always non-negative!)", "isCorrect": true },
            { "text": "Because all diagonal entries are negative", "isCorrect": false },
            { "text": "Because z = 0", "isCorrect": false },
            { "text": "By setting all x_i = 0", "isCorrect": false }
          ]
        },
        {
          "stepText": "Since the quadratic form equals statistical variance Var_z(v) >= 0, nabla^2 f(x) is positive semidefinite for all x, proving f is convex."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the mathematical term for the geometric set of points lying on or above the graph of a real-valued function: epi(f) = {(x, t) | f(x) <= t}?",
      "blankAnswer": "epigraph"
    }
  ]
}
```
