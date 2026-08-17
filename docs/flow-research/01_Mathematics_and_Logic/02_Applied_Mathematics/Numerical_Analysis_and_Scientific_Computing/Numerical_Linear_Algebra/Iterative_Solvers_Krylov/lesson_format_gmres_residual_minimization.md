# Duofy Reusable Lesson Format: GMRES Algorithm and Least-Squares Residual Minimization

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing / Numerical_Linear_Algebra / Iterative_Solvers_Krylov`  
**Lesson Format Type:** `gmres_residual_minimization`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly evaluate the **GMRES (Generalized Minimal Residual)** algorithm (Saad & Schultz, 1986) for general non-symmetric matrices, transform the $n$-dimensional residual minimization into an $(m+1) \times m$ upper Hessenberg least-squares problem, and understand why Restarted GMRES($m$) is needed to control memory.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | GMRES Least-Squares Hessenberg Formulation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Givens Rotations QR Transformation | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Monotone Non-Increasing Residual Property Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Krylov Subspace Dimension Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Restarted GMRES Stagnation Tradeoff Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the GMRES formulation for general non-symmetric $A x = b$: At step $m$, find $x_m = x_0 + Q_m y \in x_0 + \mathcal{K}_m(A, r_0)$ that strictly minimizes the Euclidean norm of the residual $\|r_m\|_2 = \|b - A x_m\|_2$. Using the Arnoldi relation $A Q_m = Q_{m+1} \tilde{H}_m$, this reduces to the small $(m+1) \times m$ least-squares problem: $\min_{y \in \mathbb{R}^m} \|\|\beta e_1 - \tilde{H}_m y\|_2$ where $\beta = \|r_0\|_2$.
2. **Slide 2 (`concept_pieces`):** Deconstruct solving the Hessenberg least squares: (1) maintain QR factorization of $\tilde{H}_m$ using $m$ Givens plane rotations $G_k$, (2) apply $G_m$ to zero out the subdiagonal entry $h_{m+1, m}$, transforming $\tilde{H}_m$ into an $m \times m$ upper-triangular matrix $R_m$ and an extra row, (3) residual norm $\|r_m\|_2 = |\gamma_{m+1}|$ is available *for free* at each step without forming $x_m$, (4) solve $R_m y = \bar{g}_m$ by back-substitution only when the residual tolerance is satisfied, (5) compute final solution $x_m = x_0 + Q_m y$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that because each Krylov subspace contains the previous one, the GMRES residual norm is monotonically non-increasing. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the number of columns in the orthonormal Arnoldi basis $Q_m$ after $m = 15$ steps (numeric answer: 15.0).
5. **Slide 5 (`quiz`):** Quiz explaining why Restarted GMRES($m$) is practically used: (Because full GMRES requires storing all $m$ Arnoldi basis vectors and computing $\mathcal{O}(m^2 n)$ inner products; restarting after $m$ steps fixes memory and orthogonalization costs at the risk of possible stagnation).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "gmres_residual_minimization",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The GMRES Algorithm (Saad & Schultz, 1986)**\nFor general non-symmetric linear systems $A\\mathbf{x} = \\mathbf{b}$:\n• At step $m$, GMRES finds $\\mathbf{x}_m \\in \\mathbf{x}_0 + \\mathcal{K}_m(A, \\mathbf{r}_0)$ that **strictly minimizes the $L^2$ residual norm**:\n$$\n\\|\\mathbf{r}_m\\|_2 = \\|\\mathbf{b} - A\\mathbf{x}_m\\|_2 = \\min_{\\mathbf{x} \\in \\mathbf{x}_0 + \\mathcal{K}_m} \\|\\mathbf{b} - A\\mathbf{x}\\|_2\n$$\n• Using the Arnoldi relation $A Q_m = Q_{m+1} \\tilde{H}_m$ with $\\beta = \\|\\mathbf{r}_0\\|_2$, this transforms into a small $(m+1) \\times m$ **least-squares problem**:\n$$\n\\min_{\\mathbf{y} \\in \\mathbb{R}^m} \\|\\beta \\mathbf{e}_1 - \\tilde{H}_m \\mathbf{y}\\|_2\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Arnoldi Expansion):** Generate orthonormal column $\\mathbf{q}_{m+1}$ and new Hessenberg column $\\tilde{H}_{:, m}$.\n• **Step 2 (Givens Rotations):** Apply previous $m-1$ Givens plane rotations to column $m$, then compute a new rotation $G_m$ to eliminate subdiagonal entry $h_{m+1, m}$.\n• **Step 3 (Zero-Cost Residual Tracking):** The transformed RHS vector yields the exact residual norm $\\|\\mathbf{r}_m\\|_2 = |\\gamma_{m+1}|$ *without* calculating $\\mathbf{x}_m$!\n• **Step 4 (Backward Solve):** When $|\\gamma_{m+1}| < \\text{tol}$, solve the $m \\times m$ upper-triangular system $R_m \\mathbf{y} = \\mathbf{g}_{1:m}$ and construct $\\mathbf{x}_m = \\mathbf{x}_0 + Q_m \\mathbf{y}$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "Because the nested Krylov subspaces satisfy K_1 subset K_2 subset ... subset K_m, the residual norm ||r_m||_2 in full GMRES is monotonically ___.",
      "blankAnswer": "non-increasing",
      "blankDistractors": ["increasing", "oscillating", "divergent"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "How many orthonormal basis vectors are stored in the Arnoldi matrix Q_m after completing m = 15 iterations?",
      "numericAnswer": 15.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the Restarted GMRES(m) algorithm used in production engineering software instead of full GMRES?",
      "options": [
        { "text": "Full GMRES requires storing all m Arnoldi vectors and performing O(m^2 n) orthogonalization work per step, consuming prohibitive memory as m grows; restarting bounds memory to O(mn)", "isCorrect": true, "explanation": "Correct! As m increases, memory and orthogonalization costs grow quadratically. GMRES(m) clears the Krylov basis every m steps to cap memory, though it carries a risk of stagnation." },
        { "text": "Because GMRES only works for m <= 5", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Givens rotations fail for large m", "isCorrect": false, "explanation": "Incorrect: Givens rotations are unconditionally stable." },
        { "text": "Because restarting guarantees faster convergence on all matrices", "isCorrect": false, "explanation": "Incorrect: Restarting destroys Krylov history and can cause stagnation." }
      ]
    }
  ]
}
```
