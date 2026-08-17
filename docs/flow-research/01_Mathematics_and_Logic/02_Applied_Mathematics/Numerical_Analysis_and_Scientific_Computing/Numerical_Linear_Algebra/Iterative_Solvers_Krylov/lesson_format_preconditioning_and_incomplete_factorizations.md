# Duofy Reusable Lesson Format: Preconditioning and Incomplete Factorizations

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing / Numerical_Linear_Algebra / Iterative_Solvers_Krylov`  
**Lesson Format Type:** `preconditioning_and_incomplete_factorizations`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Preconditioning Techniques** ($M^{-1} A x = M^{-1} b$), compare **Jacobi, ILU(0), Incomplete Cholesky, and Algebraic Multigrid (AMG)** preconditioners, understand eigenvalue clustering, and interact with live preconditioned convergence rate comparisons.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Preconditioner Definition & Spectral Clustering Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Preconditioner Family & Computational Cost Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Incomplete LU Zero Fill-in Pattern Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Multigrid Preconditioner Acronym Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Preconditioned vs Unpreconditioned CG Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "preconditioning_and_incomplete_factorizations",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the primary mathematical objective of applying a preconditioner M to a linear system Ax = b?",
      "blankAnswer": "To replace Ax = b with an equivalent system M^{-1}Ax = M^{-1}b whose coefficient matrix M^{-1}A has a much smaller condition number and tightly clustered eigenvalues near 1, accelerating Krylov convergence while keeping M easy to invert (solve Mz = r in O(n) flops)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each preconditioning technique to its algorithmic construction.",
      "matchPairs": [
        { "left": "Jacobi Preconditioner", "right": "M = diag(A) (trivial inversion, purely local scaling)" },
        { "left": "Incomplete LU (ILU(0))", "right": "Performs Gaussian elimination dropping all fill-in entries outside the sparsity pattern of A" },
        { "left": "Incomplete Cholesky (IC)", "right": "M = L L^T for SPD matrices with zero-fill or threshold dropping" },
        { "left": "Algebraic Multigrid (AMG)", "right": "Hierarchical coarse-grid corrections achieving O(N) mesh-independent convergence" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What does the '(0)' denote in the ILU(0) incomplete LU factorization algorithm?",
      "options": [
        { "text": "Zero fill-in: L and U are strictly restricted to have non-zero entries ONLY in the exact matrix positions where the original matrix A has non-zeros", "isCorrect": true, "explanation": "Correct! ILU(0) preserves the exact sparsity pattern of A, dropping every entry that would otherwise generate fill-in during elimination." },
        { "text": "Zero iterations required", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Zero diagonal elements", "isCorrect": false, "explanation": "Incorrect: Diagonals must be non-zero to invert." },
        { "text": "Zero error in the solution", "isCorrect": false, "explanation": "Incorrect: ILU(0) is an approximation." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What three-letter acronym denotes the hierarchical preconditioner that uses algebraic coarse grids to solve elliptic PDEs in linear O(N) time?",
      "blankAnswer": "amg"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Preconditioned Conjugate Gradient Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Preconditioned CG Convergence (κ = 10,000)</h3><p>Compare standard CG vs Incomplete Cholesky PCG:</p><button id=\"pcgBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Run Iterations</button><div id=\"pcgOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('pcgBtn').onclick=()=>{document.getElementById('pcgOut').innerText='Unpreconditioned CG: 450 iterations to reach 1e-6 | PCG with Incomplete Cholesky: 18 iterations! Condition number reduced from 10,000 to 2.4.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
