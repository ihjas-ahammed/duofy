# Duofy Reusable Lesson Format: Newton Decrement and the Sequential Barrier Method

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Linear_and_Nonlinear_Programming / Interior_Point_Methods`  
**Lesson Format Type:** `newton_decrement_and_barrier_method`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the algorithmic cycle of the **Barrier Method (Path-Following)**, calculate the **Newton Decrement** $\lambda(\mathbf{x}) = \sqrt{\nabla f(\mathbf{x})^T (\nabla^2 f(\mathbf{x}))^{-1} \nabla f(\mathbf{x})}$, establish the stopping criterion $\lambda(\mathbf{x})^2 / 2 \le \epsilon_{\text{Newton}}$, and analyze the outer scaling parameter $\mu \in [10, 100]$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Barrier Method Algorithm & Newton Decrement Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Outer-Loop Barrier Method Execution Cycle Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Newton Decrement Affine Invariance Property Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Total Outer Iteration Count Complexity Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Centering Step Inner Optimization Solver Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Barrier Method algorithm: Given strictly feasible $x_0$, initial $t = t^{(0)} > 0$, scaling factor $\mu > 1$ (typically $\mu \in [10, 100]$), and tolerance $\epsilon > 0$. Repeat: (1) Centering step: Compute $x^*(t)$ by minimizing $t f_0 + \phi$ starting from current $x$, (2) Update $x \leftarrow x^*(t)$, (3) Stopping criterion: if $m/t < \epsilon$, STOP; else (4) Increase $t \leftarrow \mu t$. Define the Newton Decrement: $\lambda(x) = \sqrt{\nabla f_t(x)^T (\nabla^2 f_t(x))^{-1} \nabla f_t(x)}$. It satisfies $f_t(x) - \inf f_t \approx \frac{1}{2}\lambda(x)^2$ and serves as the affine-invariant stopping criterion $\lambda(x)^2 / 2 \le \epsilon_{\text{Newton}}$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the outer/inner loop: (1) set initial $t > 0$ and strictly feasible $x \in \operatorname{int}\mathcal{D}$, (2) perform inner Newton iterations with backtracking line search to solve the unconstrained/equality centering subproblem, (3) check inner convergence using the Newton decrement $\lambda(x)^2 \le 2 \epsilon_{\text{inner}}$, (4) check global outer convergence: test if duality gap $m/t < \epsilon_{\text{tol}}$, (5) if not converged, increase barrier multiplier $t \leftarrow \mu t$ and use current $x^*(t)$ as warm-start for next centering phase.
3. **Slide 3 (`quiz`):** Test why the Newton decrement $\lambda(x)$ is superior to the gradient norm $\|\nabla f(x)\|_2$ as a stopping criterion: (Because $\lambda(x)$ is strictly AFFINE INVARIANT: coordinate transformations $y = T x$ leave $\lambda(y) = \lambda(x)$ unchanged, and $\lambda(x)^2/2$ directly estimates the suboptimality gap $f(x) - p^*$).
4. **Slide 4 (`proof`):** Interactive derivation calculating the number of outer barrier iterations $N_{\text{outer}} = \lceil \frac{\log(m / (t_0 \epsilon_{\text{tol}}))}{\log \mu} \rceil$ required to achieve tolerance $\epsilon_{\text{tol}}$.
5. **Slide 5 (`one_word`):** Plain-text recall of the surname of Sir Isaac who invented the second-order optimization method used in the inner centering loop (Newton).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "newton_decrement_and_barrier_method",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The Barrier Method and the Newton Decrement**\n• **The Barrier Method (Boyd Algorithm 11.1):**\n  1. **Centering Step:** Compute $\\mathbf{x}^*(t) = \\operatorname{argmin} (t f_0(\\mathbf{x}) + \\phi(\\mathbf{x}))$ via Newton's method.\n  2. **Update Iterate:** $\\mathbf{x} \\leftarrow \\mathbf{x}^*(t)$.\n  3. **Stopping Criterion:** Quit if $m/t < \\epsilon_{\\text{tol}}$.\n  4. **Increase Barrier Multiplier:** $t \\leftarrow \\mu t$ (typically $\\mu \\in [10, 100]$).\n• **The Newton Decrement $\\lambda(\\mathbf{x})$:**\n$$\n\\lambda(\\mathbf{x}) = \\sqrt{\\nabla f_t(\\mathbf{x})^T \\left( \\nabla^2 f_t(\\mathbf{x}) \\right)^{-1} \\nabla f_t(\\mathbf{x})}\n$$\n• **Properties:** Affine-invariant measure of proximity to the central path; $\\frac{1}{2}\\lambda(\\mathbf{x})^2$ directly estimates suboptimality $f_t(\\mathbf{x}) - \\inf f_t$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed across outer and inner loops of the Barrier Method.",
      "orderItems": [
        "Initialize strictly feasible point x_0 in int(D), initial multiplier t = t_0 > 0, and factor mu > 1",
        "Execute inner damped Newton iterations with backtracking line search on objective t f_0 + phi",
        "Terminate inner centering loop when Newton decrement satisfies lambda(x)^2 / 2 <= eps_Newton",
        "Evaluate outer termination condition: check if global duality gap m/t < eps_tol",
        "If not converged, multiply t <- mu * t and warm-start next inner centering step at current iterate"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the Newton decrement lambda(x) used as the standard stopping criterion in second-order interior-point solvers rather than the Euclidean gradient norm ||grad f(x)||_2?",
      "options": [
        { "text": "lambda(x) is completely AFFINE INVARIANT (unchanged under coordinate scalings y = T x) and lambda(x)^2 / 2 rigorously estimates the suboptimality gap f(x) - p*", "isCorrect": true, "explanation": "Correct! Gradient norms depend on arbitrary coordinate units and ill-conditioning, whereas the Newton decrement is an invariant metric in the Hessian Riemannian geometry." },
        { "text": "Because lambda(x) is always negative", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Hessians cannot be computed", "isCorrect": false, "explanation": "Incorrect: lambda(x) explicitly uses the Hessian." },
        { "text": "Because gradient norms are always zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Exact Formula for Total Outer Barrier Steps",
      "interactiveSteps": [
        {
          "stepText": "At step k, the barrier multiplier is t_k = t_0 * mu^k, giving duality gap m / (t_0 * mu^k). We stop when m / (t_0 * mu^k) <= eps_tol."
        },
        {
          "prompt": "Solving for k, what is the exact number of outer centering steps required?",
          "options": [
            { "text": "k = ceil( log(m / (t_0 * eps_tol)) / log(mu) )", "isCorrect": true },
            { "text": "k = m * eps_tol", "isCorrect": false },
            { "text": "k = mu^m", "isCorrect": false },
            { "text": "k = t_0 / eps_tol", "isCorrect": false }
          ]
        },
        {
          "stepText": "For m = 100, t_0 = 1, eps_tol = 10^{-6}, and mu = 20: k = ceil(log(10^8) / log(20)) = ceil(18.42 / 2.99) = 7 outer steps!"
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the surname of the English physicist and mathematician whose iterative second-order optimization method solves the inner centering step?",
      "blankAnswer": "newton"
    }
  ]
}
```
