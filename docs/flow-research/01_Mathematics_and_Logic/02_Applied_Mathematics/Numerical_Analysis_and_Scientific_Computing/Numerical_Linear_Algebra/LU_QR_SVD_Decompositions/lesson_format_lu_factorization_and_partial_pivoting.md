# Duofy Reusable Lesson Format: LU Factorization and Partial Pivoting

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing / Numerical_Linear_Algebra / LU_QR_SVD_Decompositions`  
**Lesson Format Type:** `lu_factorization_and_partial_pivoting`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the matrix factorization representation of Gaussian elimination $P A = L U$, explain why row swaps (**Partial Pivoting**) prevent catastrophic floating-point growth, and compute $L$ and $U$ triangular factors.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | $PA = LU$ Factorization & Triangular Solvers Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Multiplier Matrix Elimination & Pivot Growth Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Triangular Solver & Computational Complexity Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Partial Pivoting Element Selection Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Catastrophic Small Pivot Division Failure Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Gaussian elimination as matrix factorization $P A = L U$, where $P$ is a permutation matrix, $L$ is unit lower-triangular with $|L_{ij}| \le 1$, and $U$ is upper-triangular. State the two-step solution of $A x = b$: forward substitution $L y = P b$ ($\mathcal{O}(n^2)$), then backward substitution $U x = y$ ($\mathcal{O}(n^2)$). Total factorization cost is $\frac{2}{3}n^3$ flops.
2. **Slide 2 (`concept_pieces`):** Deconstruct elementary elimination matrices $M_k = I - m_k e_k^T$, construction of multipliers $m_{ik} = a_{ik}^{(k)} / a_{kk}^{(k)}$, partial pivoting rule (swap row $k$ with row $i \ge k$ maximizing $|a_{ik}^{(k)}|$ to ensure $|m_{ik}| \le 1$), and growth factor $\rho = \frac{\max |u_{ij}|}{\max |a_{ij}|}$.
3. **Slide 3 (`matching`):** Pair 4 matrix solver stages (LU Factorization, Forward Substitution, Backward Substitution, Cholesky $LL^T$) with their exact flop counts.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that partial pivoting swaps rows to place the element of largest absolute value on the diagonal pivot. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question showing how eliminating $\begin{bmatrix} 10^{-20} & 1 \\ 1 & 1 \end{bmatrix}$ without pivoting results in catastrophic roundoff error ($x_2 = 1, x_1 = 0$ instead of $x_1 = 1, x_2 = 1$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "lu_factorization_and_partial_pivoting",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: $PA = LU$ Factorization and Triangular Solvers**\n• Any non-singular matrix $A \\in \\mathbb{R}^{n \\times n}$ can be factored as:\n$$\nP A = L U\n$$\nwhere $P$ is a **permutation matrix**, $L$ is **unit lower-triangular** ($L_{ii} = 1, |L_{ij}| \\le 1$), and $U$ is **upper-triangular**.\n• **Solving $Ax = b$ in Two Triangular Steps:**\n  1. **Forward Substitution:** Solve $L y = P b$ in $\\mathcal{O}(n^2)$ flops.\n  2. **Backward Substitution:** Solve $U x = y$ in $\\mathcal{O}(n^2)$ flops.\n• **Computational Cost:** Factoring $A$ takes $\\frac{2}{3}n^3 + \\mathcal{O}(n^2)$ floating-point operations."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Elimination Matrices:** Column $k$ is cleared by multiplying $A$ by $M_k = I - \\mathbf{m}_k \\mathbf{e}_k^T$, where multipliers are $m_{ik} = a_{ik} / a_{kk}$.\n• **The Need for Pivoting:** If $|a_{kk}|$ is tiny, $m_{ik} \\gg 1$, multiplying rounding errors exponentially into subsequent rows.\n• **Partial Pivoting Algorithm:** At step $k$, scan the subdiagonal column entries and swap row $k$ with row $p = \\operatorname{argmax}_{i \\ge k} |a_{ik}^{(k)}|$.\n• **Guaranteed Multiplier Bound:** Partial pivoting strictly guarantees that all multipliers satisfy $|L_{ij}| = |m_{ij}| \\le 1$, ensuring backward stability."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each linear solver algorithm to its exact leading flop count.",
      "matchPairs": [
        { "left": "LU Factorization with Partial Pivoting", "right": "(2/3) n^3 flops" },
        { "left": "Cholesky Factorization LL^T (for SPD matrices)", "right": "(1/3) n^3 flops (half the cost of LU)" },
        { "left": "Forward or Backward Triangular Substitution", "right": "n^2 flops (O(n^2) linear time relative to matrix size)" },
        { "left": "Explicit Matrix Inversion A^{-1}", "right": "2 n^3 flops (3x slower and numerically inferior to LU solve)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In partial pivoting, rows are swapped at each step to ensure that the pivot element on the diagonal has the largest possible ___ value in its column.",
      "blankAnswer": "absolute",
      "blankDistractors": ["minimum", "positive", "signed"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does solving the system [[10^{-20}, 1], [1, 1]] [x_1, x_2]^T = [1, 2]^T without pivoting fail catastrophically in standard 64-bit IEEE double precision?",
      "options": [
        { "text": "The multiplier m_{21} = 1 / 10^{-20} = 10^{20} causes 1 - 10^{20} to round to -10^{20}, completely annihilating the second equation's original coefficients (loss of significance)", "isCorrect": true, "explanation": "Correct! Dividing by 10^{-20} creates an enormous multiplier that dwarfs the existing coefficients, destroying accuracy. Pivoting swaps rows to divide by 1 instead." },
        { "text": "Because the matrix is singular with determinant 0", "isCorrect": false, "explanation": "Incorrect: The determinant is 10^{-20} - 1 approx -1 != 0." },
        { "text": "Because lower triangular matrices cannot be inverted", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because 10^{-20} is an imaginary number", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
