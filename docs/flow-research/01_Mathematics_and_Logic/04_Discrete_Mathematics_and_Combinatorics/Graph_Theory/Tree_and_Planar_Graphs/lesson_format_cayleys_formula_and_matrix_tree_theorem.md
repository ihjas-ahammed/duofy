# Duofy Reusable Lesson Format: Cayley's Tree Formula and the Matrix Tree Theorem

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Graph_Theory / Tree_and_Planar_Graphs`  
**Lesson Format Type:** `cayleys_formula_and_matrix_tree_theorem`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the enumeration of spanning trees: derive **Cayley's Tree Formula (1889)** ($T_n = n^{n-2}$) as a direct corollary of Prüfer's bijection, formulate **Kirchhoff's Matrix Tree Theorem (1847)** ($\tau(G) = \det(\mathbf{L}_{ii})$ via the Graph Laplacian $\mathbf{L} = \mathbf{D} - \mathbf{A}$), and compute spanning trees for general multi-graphs and bipartite graphs.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cayley's Formula & Matrix Tree Theorem Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step 3x3 Laplacian Matrix Cofactor Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Graph Family & Number of Spanning Trees Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical Spanning Tree Count T_4 via Cayley's Formula | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Laplacian Zero Eigenvalue & Spanning Tree Formula Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Cayley's Tree Formula (Arthur Cayley, 1889): The number of distinct labelled trees on $n$ vertices (or spanning trees of the complete graph $K_n$) is:
   $$\tau(K_n) = n^{n-2}$$
   State Kirchhoff's Matrix Tree Theorem (Gustav Kirchhoff, 1847): Let $G$ be a loopless graph with Degree Matrix $\mathbf{D} = \operatorname{diag}(\deg(v_1), \dots, \deg(v_n))$ and Adjacency Matrix $\mathbf{A}$. The **Graph Laplacian** is $\mathbf{L} = \mathbf{D} - \mathbf{A}$. The number of spanning trees $\tau(G)$ is equal to **any cofactor** of $\mathbf{L}$:
   $$\tau(G) = \det(\mathbf{L}_{ii}) = (-1)^{i+j} \det(\mathbf{L}_{ij}) = \frac{1}{n} \prod_{k=2}^n \mu_k$$
   where $\mu_2, \dots, \mu_n$ are the non-zero eigenvalues of $\mathbf{L}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct Matrix Tree Theorem for triangle $K_3$: (1) write degree matrix $\mathbf{D} = \operatorname{diag}(2, 2, 2)$ and adjacency matrix $\mathbf{A} = \begin{bmatrix} 0 & 1 & 1 \\ 1 & 0 & 1 \\ 1 & 1 & 0 \end{bmatrix}$, (2) compute Laplacian $\mathbf{L} = \mathbf{D} - \mathbf{A} = \begin{bmatrix} 2 & -1 & -1 \\ -1 & 2 & -1 \\ -1 & -1 & 2 \end{bmatrix}$, (3) delete row 1 and column 1 to form reduced minor $\mathbf{L}_{11} = \begin{bmatrix} 2 & -1 \\ -1 & 2 \end{bmatrix}$, (4) compute determinant: $\det(\mathbf{L}_{11}) = (2)(2) - (-1)(-1) = 4 - 1 = 3$, (5) verify $\tau(K_3) = 3^{3-2} = 3^1 = 3$ spanning trees!
3. **Slide 3 (`matching`):** Pair 4 graphs (Complete Graph $K_n$, Cycle Graph $C_n$, Complete Bipartite $K_{m,n}$, Star Graph $K_{1, n-1}$) with their spanning tree counts ($n^{n-2}$, $n$, $m^{n-1} n^{m-1}$, $1$).
4. **Slide 4 (`numerical`):** Ask student: Using Cayley's formula $\tau(K_n) = n^{n-2}$, calculate the exact number of labelled trees on $n = 4$ vertices: $\tau(K_4) = 4^{4-2} = 4^2 = 16$ (numeric answer: 16).
5. **Slide 5 (`quiz`):** Quiz on the Laplacian eigenvalue formula for spanning trees: For a connected graph $G$ with $n$ vertices and Laplacian eigenvalues $0 = \mu_1 < \mu_2 \le \dots \le \mu_n$, why does $\tau(G) = \frac{1}{n} \prod_{k=2}^n \mu_k$? (Because the characteristic polynomial of $\mathbf{L}$ is $p(\lambda) = \lambda \prod_{k=2}^n (\lambda - \mu_k)$; evaluating the derivative $p'(0) = \prod_{k=2}^n (-\mu_k)$ and applying the cofactor expansion identity yields $\tau(G) = \frac{1}{n} \mu_2 \dots \mu_n$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cayleys_formula_and_matrix_tree_theorem",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Cayley's Formula and Kirchhoff's Matrix Tree Theorem**\n• **Cayley's Tree Formula (Arthur Cayley, 1889):**\n  The number of labelled trees on $n$ vertices is exactly:\n$$\n\\tau(K_n) = n^{n - 2}\n$$\n  *(Corollary of Prüfer's length-$(n-2)$ sequence bijection!).*\n• **Kirchhoff's Matrix Tree Theorem (1847):**\n  Let $\\mathbf{L} = \\mathbf{D} - \\mathbf{A}$ be the **Graph Laplacian Matrix**:\n$$\nL_{ij} = \\begin{cases} \\deg(v_i) & \\text{if } i = j \\\\ -1 & \\text{if } v_i \\sim v_j \\\\ 0 & \\text{otherwise} \\end{cases}\n$$\n• **Spanning Tree Count Formula:** The number of spanning trees $\\tau(G)$ equals **any cofactor** of $\\mathbf{L}$:\n$$\n\\tau(G) = \\det(\\mathbf{L}_{ii}) = \\frac{1}{n} \\prod_{k=2}^n \\mu_k\n$$\nwhere $0 = \\mu_1 < \\mu_2 \\le \\dots \\le \\mu_n$ are the eigenvalues of $\\mathbf{L}$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Construct Laplacian):** For triangle $K_3$, each vertex has degree 2:\n  $$\\mathbf{L} = \\begin{bmatrix} 2 & -1 & -1 \\\\ -1 & 2 & -1 \\\\ -1 & -1 & 2 \\end{bmatrix}$$\n• **Step 2 (Delete Row & Column 1):** Remove row 1 and column 1 to form minor $\\mathbf{L}_{11}$:\n  $$\\mathbf{L}_{11} = \\begin{bmatrix} 2 & -1 \\\\ -1 & 2 \\end{bmatrix}$$\n• **Step 3 (Evaluate Determinant):** $\\det(\\mathbf{L}_{11}) = (2)(2) - (-1)(-1) = 4 - 1 = \\mathbf{3}$.\n• **Step 4 (Verify Cayley):** $\\tau(K_3) = 3^{3-2} = 3^1 = \\mathbf{3}$ spanning trees!\n• **Step 5 (Independence of Choice):** Deleting ANY row/column produces the identical determinant $\\tau(G) = 3$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each graph to its exact number of spanning trees tau(G).",
      "matchPairs": [
        { "left": "Complete Graph K_n", "right": "n^{n-2} (Cayley's formula)" },
        { "left": "Cycle Graph C_n", "right": "n (removing any one of the n edges leaves a spanning path)" },
        { "left": "Complete Bipartite K_{m, n}", "right": "m^{n-1} * n^{m-1}" },
        { "left": "Star Graph K_{1, n-1}", "right": "1 (the graph is already a tree)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Using Cayley's formula tau(K_n) = n^{n-2}, calculate the number of labelled spanning trees of the complete graph K_4 on 4 vertices: tau(K_4) = 4^{4-2}.",
      "numericAnswer": 16,
      "numericTolerance": 0
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the Laplacian matrix L always singular (det(L) = 0 with smallest eigenvalue mu_1 = 0)?",
      "options": [
        { "text": "Because every row of L sums to EXACTLY ZERO (the all-ones vector 1 = [1, 1, ..., 1]^T is an eigenvector with eigenvalue 0: L * 1 = 0)", "isCorrect": true, "explanation": "Correct! Since each diagonal entry L_{ii} = deg(v_i) equals the sum of off-diagonal absolute values, L * 1 = 0. Hence det(L) = 0, necessitating the deletion of one row and column to extract spanning trees." },
        { "text": "Because all graphs contain cycles", "isCorrect": false, "explanation": "Incorrect: L is singular even for trees." },
        { "text": "Because degrees are negative", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because eigenvalues cannot be positive", "isCorrect": false, "explanation": "Incorrect: mu_2, ..., mu_n are strictly positive for connected graphs." }
      ]
    }
  ]
}
```
