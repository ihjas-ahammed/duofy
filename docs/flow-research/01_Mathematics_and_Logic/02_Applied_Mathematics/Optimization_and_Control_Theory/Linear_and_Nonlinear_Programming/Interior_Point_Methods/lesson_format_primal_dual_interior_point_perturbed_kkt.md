# Duofy Reusable Lesson Format: Primal-Dual Interior-Point Methods and the Perturbed KKT System

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Linear_and_Nonlinear_Programming / Interior_Point_Methods`  
**Lesson Format Type:** `primal_dual_interior_point_perturbed_kkt`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to formulate the **Perturbed KKT System** for Primal-Dual Interior-Point Methods, compute the **Surrogate Duality Gap** $\hat{\eta} = -\mathbf{f}(\mathbf{x})^T \mathbf{\lambda}$, set up the modified Newton linearization block matrix, and understand why primal-dual algorithms converge faster than standard barrier methods without strict inner centering.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Perturbed KKT System & Residual Vector Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Primal-Dual Linearization Block Matrix Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | KKT Perturbed Residual Term & Target Value Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Complementary Slackness Perturbation Parameter Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Primal-Dual vs Standard Barrier Method Superiority Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Perturbed KKT System for primal-dual IPM: Let $r_t(x, \lambda, \nu) = 0$ where $r_{\text{dual}} = \nabla f_0(x) + Df(x)^T \lambda + A^T \nu$, $r_{\text{cent}} = -\operatorname{diag}(\lambda) f(x) - (1/t)\mathbf{1}$, $r_{\text{pri}} = A x - b$. Define the Surrogate Duality Gap $\hat{\eta}(x, \lambda) = -f(x)^T \lambda = \sum_{i=1}^m -\lambda_i f_i(x)$. Parameter $t$ is set dynamically as $t = \mu m / \hat{\eta}$ (where $\mu > 1$). State the search direction: solve the modified Newton system $[J(x, \lambda, \nu)] [\Delta x; \Delta \lambda; \Delta \nu] = -r_t(x, \lambda, \nu)$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the Newton block Jacobian matrix: (1) block $(1, 1)$: $\nabla^2 f_0(x) + \sum \lambda_i \nabla^2 f_i(x)$, (2) block $(1, 2)$: $Df(x)^T$, (3) block $(1, 3)$: $A^T$, (4) block $(2, 1)$: $-\operatorname{diag}(\lambda) Df(x)$, (5) block $(2, 2)$: $-\operatorname{diag}(f(x))$, (6) block $(3, 1)$: $A$. Eliminate $\Delta \lambda$ to reduce the system to a symmetric quasi-definite KKT matrix solve.
3. **Slide 3 (`matching`):** Pair 4 primal-dual residuals ($r_{\text{dual}}$ Dual Infeasibility, $r_{\text{cent}}$ Centrality / Slackness Violation, $r_{\text{pri}}$ Primal Infeasibility, $\hat{\eta}$ Surrogate Duality Gap) with their exact vector formulas.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the perturbed complementary slackness replaces $\lambda_i f_i(x) = 0$ with $-\lambda_i f_i(x) = 1/t = \mu$. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking why Primal-Dual IPMs are vastly preferred in commercial solvers over the classic Barrier method: (Primal-dual methods do not require solving an inner optimization problem to high accuracy at each step; they take a single Newton step per iteration and adjust $t$ dynamically, converging superlinearly in 10–50 total iterations regardless of problem size).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "primal_dual_interior_point_perturbed_kkt",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Primal-Dual Interior-Point Methods and the Perturbed KKT System**\n• Primal-dual IPMs treat primal $(\\mathbf{x})$, dual $(\\mathbf{\\lambda})$, and equality $(\\mathbf{\\nu})$ variables as equal unknowns, solving the **Perturbed KKT System** $r_t(\\mathbf{x}, \\mathbf{\\lambda}, \\mathbf{\\nu}) = \\mathbf{0}$:\n$$\n\\begin{aligned}\n\\mathbf{r}_{\\text{dual}} &= \\nabla f_0(\\mathbf{x}) + D\\mathbf{f}(\\mathbf{x})^T \\mathbf{\\lambda} + A^T \\mathbf{\\nu} = \\mathbf{0} \\\\\n\\mathbf{r}_{\\text{cent}} &= -\\operatorname{diag}(\\mathbf{\\lambda}) \\mathbf{f}(\\mathbf{x}) - \\frac{1}{t}\\mathbf{1} = \\mathbf{0} \\\\\n\\mathbf{r}_{\\text{pri}} &= A\\mathbf{x} - \\mathbf{b} = \\mathbf{0}\n\\end{aligned}\n$$\n• **Surrogate Duality Gap:** $\\hat{\\eta}(\\mathbf{x}, \\mathbf{\\lambda}) = -\\mathbf{f}(\\mathbf{x})^T \\mathbf{\\lambda} = \\sum_{i=1}^m -\\lambda_i f_i(\\mathbf{x})$.\n• **Dynamic Centering Parameter:** Set $t = \\frac{\\mu m}{\\hat{\\eta}}$ at every single iteration."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Modified Newton Step Equation:**\n  $$\\begin{bmatrix} \\nabla^2 f_0 + \\sum \\lambda_i \\nabla^2 f_i & D\\mathbf{f}^T & A^T \\\\ -\\operatorname{diag}(\\mathbf{\\lambda}) D\\mathbf{f} & -\\operatorname{diag}(\\mathbf{f}) & 0 \\\\ A & 0 & 0 \\end{bmatrix} \\begin{bmatrix} \\Delta \\mathbf{x} \\\\ \\Delta \\mathbf{\\lambda} \\\\ \\Delta \\mathbf{\\nu} \\end{bmatrix} = -\\begin{bmatrix} \\mathbf{r}_{\\text{dual}} \\\\ \\mathbf{r}_{\\text{cent}} \\\\ \\mathbf{r}_{\\text{pri}} \\end{bmatrix}$$\n• **Block Elimination:** Eliminating $\\Delta \\mathbf{\\lambda} = -\\mathbf{f}^{-1} \\mathbf{r}_{\\text{cent}} - \\mathbf{f}^{-1} \\operatorname{diag}(\\mathbf{\\lambda}) D\\mathbf{f} \\Delta \\mathbf{x}$ collapses the system into a symmetric condensed KKT matrix!\n• **Primal-Dual Step Length:** Scale steps to preserve strict positivity: $\\alpha = 0.99 \\min(\\alpha_{\\max}^{\\text{pri}}, \\alpha_{\\max}^{\\text{dual}})$, where $\\mathbf{f}(\\mathbf{x} + \\alpha \\Delta \\mathbf{x}) < \\mathbf{0}$ and $\\mathbf{\\lambda} + \\alpha \\Delta \\mathbf{\\lambda} > \\mathbf{0}$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each primal-dual residual vector to its definition.",
      "matchPairs": [
        { "left": "Dual Residual r_dual", "right": "grad f_0(x) + Df(x)^T lambda + A^T nu (stationarity error)" },
        { "left": "Centrality Residual r_cent", "right": "-diag(lambda) f(x) - (1/t) 1 (perturbed complementary slackness error)" },
        { "left": "Primal Residual r_pri", "right": "A x - b (equality constraint feasibility error)" },
        { "left": "Surrogate Duality Gap", "right": "eta_hat = -f(x)^T lambda (measure of total complementarity)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the perturbed KKT system, the exact complementary slackness condition lambda_i f_i(x) = 0 is perturbed to -lambda_i f_i(x) = 1/t = ___.",
      "blankAnswer": "mu",
      "blankDistractors": ["zero", "infinity", "one"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why are Primal-Dual Interior-Point Methods overwhelmingly superior in practical efficiency compared to the standard Barrier Method?",
      "options": [
        { "text": "They take only ONE Newton step per iteration without requiring complete inner centering convergence, adjust t adaptively, and achieve superlinear convergence in 10-50 total steps", "isCorrect": true, "explanation": "Correct! Primal-dual methods follow the central path loosely rather than strictly, driving primal residuals, dual residuals, and the duality gap to zero simultaneously in very few total iterations." },
        { "text": "They do not use matrix factorizations", "isCorrect": false, "explanation": "Incorrect: They use Cholesky/KKT factorizations." },
        { "text": "They only work for linear programs", "isCorrect": false, "explanation": "Incorrect: They apply to SDPs, SOCPs, and general non-linear convex programs." },
        { "text": "They eliminate all dual variables", "isCorrect": false, "explanation": "Incorrect: They explicitly update primal and dual variables together." }
      ]
    }
  ]
}
```
