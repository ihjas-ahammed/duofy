# Duofy Reusable Lesson Format: Crank-Nicolson Implicit Heat Equation Solver

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing / Numerical_Solutions_of_Differential_Equations / Finite_Difference_Methods`  
**Lesson Format Type:** `crank_nicolson_implicit_heat_solver`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly formulate the **Crank-Nicolson Scheme** for the parabolic heat equation $u_t = \alpha u_{xx}$, assemble the tridiagonal matrix system $(I - \frac{r}{2}\delta_x^2) u^{n+1} = (I + \frac{r}{2}\delta_x^2) u^n$, and prove unconditional $A$-stability ($|G(\xi)| \le 1$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Crank-Nicolson Semi-Implicit Formulation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Tridiagonal Matrix Stencil Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Unconditional A-Stability Property Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Tridiagonal Main Diagonal Value Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Crank-Nicolson Asymptotic Accuracy Order Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Crank-Nicolson scheme (1947): Average the spatial second derivative at time levels $n$ and $n+1$: $\frac{u_j^{n+1} - u_j^n}{\Delta t} = \frac{\alpha}{2} \left( \frac{u_{j+1}^{n+1} - 2u_j^{n+1} + u_{j-1}^{n+1}}{\Delta x^2} + \frac{u_{j+1}^n - 2u_j^n + u_{j-1}^n}{\Delta x^2} \right)$. With mesh parameter $r = \frac{\alpha \Delta t}{\Delta x^2}$, this rearranges to: $-\frac{r}{2} u_{j-1}^{n+1} + (1 + r) u_j^{n+1} - \frac{r}{2} u_{j+1}^{n+1} = \frac{r}{2} u_{j-1}^n + (1 - r) u_j^n + \frac{r}{2} u_{j+1}^n$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) assemble LHS tridiagonal matrix $A = \operatorname{tridiag}(-\frac{r}{2}, 1+r, -\frac{r}{2})$, (2) assemble RHS tridiagonal matrix $B = \operatorname{tridiag}(\frac{r}{2}, 1-r, \frac{r}{2})$, (3) solve linear system $A u^{n+1} = B u^n$ in $\mathcal{O}(M)$ time via the Thomas algorithm (tridiagonal Gaussian elimination), (4) Von Neumann amplification: $G(\xi) = \frac{1 - 2r \sin^2(\xi/2)}{1 + 2r \sin^2(\xi/2)}$, which satisfies $|G(\xi)| < 1$ unconditionally for all $r > 0$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that Crank-Nicolson is unconditionally stable for any time step size. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the main diagonal entry $(1 + r)$ of the LHS matrix $A$ when mesh ratio $r = 1.5$ ($1 + 1.5 = 2.5$).
5. **Slide 5 (`quiz`):** Quiz asking: What is the asymptotic order of accuracy of the Crank-Nicolson method in both time and space? ($\mathcal{O}(\Delta t^2 + \Delta x^2)$, second-order in both time and space).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "crank_nicolson_implicit_heat_solver",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The Crank-Nicolson Method for the Heat Equation**\n• For $u_t = \\alpha u_{xx}$, the Crank-Nicolson scheme applies trapezoidal averaging:\n$$\n\\frac{u_j^{n+1} - u_j^n}{\\Delta t} = \\frac{\\alpha}{2} \\left( \\delta_x^2 u_j^{n+1} + \\delta_x^2 u_j^n \\right)\n$$\n• Letting $r = \\frac{\\alpha \\Delta t}{\\Delta x^2}$, the implicit stencil equation is:\n$$\n-\\frac{r}{2} u_{j-1}^{n+1} + (1 + r) u_j^{n+1} - \\frac{r}{2} u_{j+1}^{n+1} = \\frac{r}{2} u_{j-1}^n + (1 - r) u_j^n + \\frac{r}{2} u_{j+1}^n\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Matrix Formulation):** $A \\mathbf{u}^{n+1} = B \\mathbf{u}^n + \\mathbf{b}_{\\text{boundary}}$.\n• **Step 2 (LHS Tridiagonal Matrix):** Main diagonal is $(1 + r)$; sub- and super-diagonals are $-\\frac{r}{2}$ (strictly diagonally dominant).\n• **Step 3 (Linear Time Solution):** The tridiagonal system is solved in $\\mathcal{O}(N)$ operations using the Thomas Algorithm (TDMA).\n• **Step 4 (Von Neumann Amplification Factor):**\n  $$G(\\xi) = \\frac{1 - 2r \\sin^2(\\xi/2)}{1 + 2r \\sin^2(\\xi/2)} \\implies |G(\\xi)| < 1 \\quad \\forall r > 0$$\n  guaranteeing unconditional numerical stability."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "Because its amplification factor satisfies |G| <= 1 for every positive value of r, the Crank-Nicolson method is ___ stable.",
      "blankAnswer": "unconditionally",
      "blankDistractors": ["conditionally", "never", "partially"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the value of the main diagonal entry (1 + r) of the implicit Crank-Nicolson matrix when the diffusion mesh ratio is r = 1.5.",
      "numericAnswer": 2.5,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the global asymptotic order of accuracy of the Crank-Nicolson scheme in time and space?",
      "options": [
        { "text": "O(Delta t^2 + Delta x^2) — second-order accurate in BOTH time and space", "isCorrect": true, "explanation": "Correct! Trapezoidal time differencing yields O(Delta t^2) and central space differencing yields O(Delta x^2)." },
        { "text": "O(Delta t + Delta x^2) — first-order in time and second-order in space", "isCorrect": false, "explanation": "Incorrect: That is the accuracy of standard FTCS/BTCS Euler methods." },
        { "text": "O(Delta t + Delta x) — first-order in both", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "O(Delta t^4 + Delta x^4)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
