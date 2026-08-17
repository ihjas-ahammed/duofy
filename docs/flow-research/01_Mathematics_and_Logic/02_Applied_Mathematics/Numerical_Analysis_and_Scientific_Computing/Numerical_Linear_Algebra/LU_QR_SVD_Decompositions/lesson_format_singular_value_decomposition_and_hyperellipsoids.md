# Duofy Reusable Lesson Format: Singular Value Decomposition and Hyperellipsoid Geometry

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing / Numerical_Linear_Algebra / LU_QR_SVD_Decompositions`  
**Lesson Format Type:** `singular_value_decomposition_and_hyperellipsoids`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly evaluate the geometric and algebraic properties of the **Singular Value Decomposition (SVD)** $A = U \Sigma V^T$, calculate the mapping of the unit ball to a hyper-ellipsoid with principal semi-axes $\sigma_i u_i$, evaluate the condition number $\kappa(A) = \sigma_{\max}/\sigma_{\min}$, and compute Moore-Penrose pseudoinverses $A^+$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | SVD Geometry & Hyper-Ellipsoid Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step 2x2 SVD Hand Calculation Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | SVD Singular Values Non-Negativity Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Condition Number Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Moore-Penrose Pseudoinverse SVD Representation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the full SVD Theorem: For any $A \in \mathbb{R}^{m \times n}$ of rank $r$, $A = U \Sigma V^T = \sum_{j=1}^r \sigma_j u_j v_j^T$, where $U \in \mathbb{R}^{m \times m}$ and $V \in \mathbb{R}^{n \times n}$ are orthogonal, and $\Sigma = \operatorname{diag}(\sigma_1, \dots, \sigma_p)$ with $\sigma_1 \ge \sigma_2 \ge \dots \ge \sigma_r > 0$. Geometrically, $A$ maps the unit sphere $\{x \mid \|x\|_2 = 1\}$ to an ellipsoid whose principal axes have lengths $\sigma_j$ in directions $u_j$.
2. **Slide 2 (`concept_pieces`):** Deconstruct computing SVD for $A = \begin{bmatrix} 3 & 0 \\ 0 & -2 \end{bmatrix}$: (1) compute $A^T A = \begin{bmatrix} 9 & 0 \\ 0 & 4 \end{bmatrix}$, (2) singular values are square roots of eigenvalues: $\sigma_1 = \sqrt{9} = 3, \sigma_2 = \sqrt{4} = 2$, (3) right singular vectors (eigenvectors of $A^T A$): $v_1 = [1, 0]^T, v_2 = [0, 1]^T$, (4) left singular vectors $u_j = \frac{1}{\sigma_j} A v_j$: $u_1 = [1, 0]^T, u_2 = [0, -1]^T$, yielding full decomposition $A = \begin{bmatrix} 1 & 0 \\ 0 & -1 \end{bmatrix} \begin{bmatrix} 3 & 0 \\ 0 & 2 \end{bmatrix} \begin{bmatrix} 1 & 0 \\ 0 & 1 \end{bmatrix}$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that singular values are strictly non-negative real numbers arranged in descending order. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the condition number $\kappa(A) = \sigma_{\max} / \sigma_{\min}$ for a matrix with singular values $\sigma_1 = 120.0, \sigma_2 = 15.0, \sigma_3 = 3.0$ (numeric answer: $120.0 / 3.0 = 40.0$).
5. **Slide 5 (`quiz`):** Quiz calculating the Moore-Penrose pseudoinverse $A^+$ using SVD: What is $A^+$ in terms of $U, \Sigma, V$? ($A^+ = V \Sigma^+ U^T$, where $\Sigma^+$ inverts all non-zero singular values $\sigma_j^{-1}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "singular_value_decomposition_and_hyperellipsoids",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The Singular Value Decomposition (SVD)**\nFor any real matrix $A \\in \\mathbb{R}^{m \\times n}$ of rank $r$:\n$$\nA = U \\Sigma V^T = \\sum_{j=1}^r \\sigma_j \\mathbf{u}_j \\mathbf{v}_j^T\n$$\n• $U \\in \\mathbb{R}^{m \\times m}$ and $V \\in \\mathbb{R}^{n \\times n}$ are orthogonal matrices ($U^T U = I, V^T V = I$).\n• $\\Sigma = \\operatorname{diag}(\\sigma_1, \\sigma_2, \\dots, \\sigma_r, 0, \\dots)$ contains the **singular values** $\\sigma_1 \\ge \\sigma_2 \\ge \\dots \\ge \\sigma_r > 0$.\n• **Geometric Image of the Unit Ball:** $A$ maps the unit sphere $\\{\\mathbf{x} \\mid \\|\\mathbf{x}\\|_2 = 1\\}$ into a **hyper-ellipsoid** in $\\mathbb{R}^m$ with principal semi-axes $\\sigma_j \\mathbf{u}_j$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Matrix:** $A = \\begin{bmatrix} 3 & 0 \\\\ 0 & -2 \\end{bmatrix}$.\n• **Step 1 (Gram Matrix):** $A^T A = \\begin{bmatrix} 9 & 0 \\\\ 0 & 4 \\end{bmatrix}$.\n• **Step 2 (Singular Values):** $\\sigma_1 = \\sqrt{9} = 3, \\, \\sigma_2 = \\sqrt{4} = 2$.\n• **Step 3 (Right Singular Vectors $V$):** Normalized eigenvectors of $A^T A$: $\\mathbf{v}_1 = [1, 0]^T, \\, \\mathbf{v}_2 = [0, 1]^T$.\n• **Step 4 (Left Singular Vectors $U$):** $\\mathbf{u}_1 = \\frac{A \\mathbf{v}_1}{\\sigma_1} = [1, 0]^T, \\, \\mathbf{u}_2 = \\frac{A \\mathbf{v}_2}{\\sigma_2} = [0, -1]^T$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "By mathematical definition, all singular values sigma_i of any matrix are strictly real and ___ numbers.",
      "blankAnswer": "non-negative",
      "blankDistractors": ["negative", "complex", "integer"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the 2-norm condition number kappa(A) = sigma_max / sigma_min for a matrix whose singular values are sigma_1 = 120.0, sigma_2 = 15.0, and sigma_3 = 3.0.",
      "numericAnswer": 40.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Given the SVD A = U Sigma V^T, what is the exact algebraic formula for the Moore-Penrose Pseudoinverse A^+?",
      "options": [
        { "text": "A^+ = V Sigma^+ U^T, where Sigma^+ replaces each non-zero singular value sigma_i with its reciprocal 1 / sigma_i and transposes the matrix", "isCorrect": true, "explanation": "Correct! A^+ = V Sigma^+ U^T satisfies all four Moore-Penrose conditions (AA^+A = A, A^+AA^+ = A^+, (AA^+)^T = AA^+, (A^+A)^T = A^+A)." },
        { "text": "A^+ = U Sigma^+ V^T", "isCorrect": false, "explanation": "Incorrect: The order of U and V must be reversed." },
        { "text": "A^+ = (U Sigma V^T)^{-1}", "isCorrect": false, "explanation": "Incorrect: Rectangular matrices cannot be standardly inverted." },
        { "text": "A^+ = V Sigma V^T", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
