# Duofy Reusable Lesson Format: Krylov Subspaces and Arnoldi Iteration

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing / Numerical_Linear_Algebra / Iterative_Solvers_Krylov`  
**Lesson Format Type:** `krylov_subspaces_and_arnoldi_iteration`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the polynomial subspace framework of **Krylov Subspaces** $\mathcal{K}_m(A, b) = \operatorname{span}\{b, Ab, \dots, A^{m-1}b\}$, execute the **Arnoldi Iteration** to compute the Hessenberg reduction $A Q_m = Q_{m+1} \tilde{H}_m$, and compare Arnoldi vs Lanczos 3-term recurrence for symmetric matrices.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Krylov Subspace & Arnoldi Relation Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Modified Gram-Schmidt Arnoldi Step Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Krylov Algorithm & Matrix Symmetry Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Subspace Invariant Breakdown Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Lanczos 3-Term Tridiagonal Recurrence Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of the $m$-th Krylov subspace $\mathcal{K}_m(A, b) = \operatorname{span}\{b, Ab, A^2b, \dots, A^{m-1}b\} = \{p(A)b \mid p \in \mathcal{P}_{m-1}\}$. State the Arnoldi factorization relation: $A Q_m = Q_m H_m + h_{m+1, m} q_{m+1} e_m^T = Q_{m+1} \tilde{H}_m$, where $Q_m = [q_1, \dots, q_m]$ has orthonormal columns and $H_m$ is an $m \times m$ upper Hessenberg matrix.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps of Arnoldi: (1) start with $q_1 = b / \|b\|_2$, (2) for $j=1, \dots, m$, compute $v = A q_j$, (3) orthogonalize $v$ against all previous $q_i$ via Modified Gram-Schmidt: $h_{ij} = q_i^* v$, $v \leftarrow v - h_{ij} q_i$, (4) normalize $h_{j+1, j} = \|v\|_2, q_{j+1} = v / h_{j+1, j}$.
3. **Slide 3 (`matching`):** Pair 4 Krylov methods (Arnoldi Iteration, Lanczos Iteration, Conjugate Gradient, GMRES) with their target matrix structures and storage footprints.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that if $h_{j+1, j} = 0$, the Krylov subspace is invariant under A and the exact solution is found (lucky breakdown). Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking: When $A = A^*$ is Hermitian/Symmetric, why does the upper Hessenberg matrix $H_m$ collapse into a tridiagonal matrix $T_m$ (Lanczos 3-term recurrence)? ($H_m = Q_m^* A Q_m$ is both Hermitian and upper Hessenberg, which forces all entries with $|i - j| > 1$ to be zero).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "krylov_subspaces_and_arnoldi_iteration",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Krylov Subspaces and Arnoldi Iteration**\n• For $A \\in \\mathbb{C}^{n \\times n}$ and initial vector $\\mathbf{b} \\in \\mathbb{C}^n$, the **$m$-th Krylov Subspace** is:\n$$\n\\mathcal{K}_m(A, \\mathbf{b}) = \\operatorname{span}\\{\\mathbf{b}, A\\mathbf{b}, A^2\\mathbf{b}, \\dots, A^{m-1}\\mathbf{b}\\} = \\{p(A)\\mathbf{b} \\mid p \\in \\mathcal{P}_{m-1}\\}\n$$\n• **Arnoldi Iteration:** Constructs an orthonormal basis $\\{\\mathbf{q}_1, \\dots, \\mathbf{q}_m\\}$ of $\\mathcal{K}_m(A, \\mathbf{b})$ satisfying the fundamental relation:\n$$\nA Q_m = Q_m H_m + h_{m+1, m} \\mathbf{q}_{m+1} \\mathbf{e}_m^T = Q_{m+1} \\tilde{H}_m\n$$\nwhere $H_m = Q_m^* A Q_m$ is an $m \\times m$ **upper Hessenberg matrix** ($h_{ij} = 0$ for $i > j + 1$)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Initialize):** Set $\\mathbf{q}_1 = \\mathbf{b} / \\|\\mathbf{b}\\|_2$.\n• **Step 2 (Matrix-Vector Product):** At step $j$, compute the new trial direction $\\mathbf{v} = A \\mathbf{q}_j$.\n• **Step 3 (Modified Gram-Schmidt):** For $i = 1, \\dots, j$:\n  $$h_{ij} = \\mathbf{q}_i^* \\mathbf{v}, \\quad \\mathbf{v} \\leftarrow \\mathbf{v} - h_{ij} \\mathbf{q}_i$$\n• **Step 4 (Normalize):** Compute subdiagonal entry $h_{j+1, j} = \\|\\mathbf{v}\\|_2$. If $h_{j+1, j} > 0$, set $\\mathbf{q}_{j+1} = \\mathbf{v} / h_{j+1, j}$.\n• **Lucky Breakdown:** If $h_{j+1, j} = 0$, the subspace $\\mathcal{K}_j(A, \\mathbf{b})$ is an exact invariant subspace of $A$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Krylov subspace algorithm to its structural property.",
      "matchPairs": [
        { "left": "Arnoldi Iteration", "right": "Upper Hessenberg reduction for general non-symmetric matrices (full history)" },
        { "left": "Lanczos Iteration", "right": "Symmetric tridiagonal reduction with short 3-term recurrence" },
        { "left": "Conjugate Gradient (CG)", "right": "Energy norm minimization for Symmetric Positive Definite systems" },
        { "left": "GMRES", "right": "L2-residual norm minimization for general non-symmetric systems" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Arnoldi iteration, if the subdiagonal coefficient h_{j+1, j} evaluates to zero, the Krylov subspace is an exact ___ subspace of A (lucky breakdown).",
      "blankAnswer": "invariant",
      "blankDistractors": ["singular", "orthogonal", "divergent"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "When A is Hermitian (symmetric A = A*), why does Arnoldi's upper Hessenberg matrix H_m reduce to a tridiagonal matrix T_m (the Lanczos algorithm)?",
      "options": [
        { "text": "H_m = Q_m^* A Q_m is Hermitian, and any upper Hessenberg matrix that is also Hermitian must have zero entries everywhere outside the main diagonal and first sub/super-diagonals", "isCorrect": true, "explanation": "Correct! H_m is upper Hessenberg (h_{ij}=0 for i > j+1) and Hermitian (h_{ij} = conjugate(h_{ji})), forcing h_{ij} = 0 for j > i+1 as well, which leaves only 3 non-zero diagonals." },
        { "text": "Because Hermitian matrices have zero eigenvalues", "isCorrect": false, "explanation": "Incorrect: Eigenvalues are real and non-zero." },
        { "text": "Because Q_m is diagonal", "isCorrect": false, "explanation": "Incorrect: Q_m has orthogonal columns." },
        { "text": "Because the Krylov subspace dimension is always 3", "isCorrect": false, "explanation": "Incorrect: 3 refers to the 3-term recurrence." }
      ]
    }
  ]
}
```
