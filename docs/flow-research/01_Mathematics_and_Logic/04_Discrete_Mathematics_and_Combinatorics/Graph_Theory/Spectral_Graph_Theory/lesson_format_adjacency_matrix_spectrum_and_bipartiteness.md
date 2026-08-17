# Duofy Reusable Lesson Format: Adjacency Matrix Spectrum and Bipartiteness

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Graph_Theory / Spectral_Graph_Theory`  
**Lesson Format Type:** `adjacency_matrix_spectrum_and_bipartiteness`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the **Adjacency Matrix Spectrum** $\operatorname{Spec}(\mathbf{A}) = \{\lambda_1 \ge \lambda_2 \ge \dots \ge \lambda_n\}$ of a simple undirected graph, apply the **Perron-Frobenius Theorem** to prove that the largest eigenvalue $\lambda_1 = d$ for $d$-regular connected graphs, prove that a graph is **Bipartite** if and only if its adjacency spectrum is symmetric around zero ($\lambda \in \operatorname{Spec}(\mathbf{A}) \implies -\lambda \in \operatorname{Spec}(\mathbf{A})$), and evaluate closed-form spectra for complete and cycle graphs.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Adjacency Matrix Spectrum & Perron-Frobenius Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Bipartite Spectrum Symmetry Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Graph Topology & Adjacency Spectrum Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Adjacency Matrix Trace Sum of Eigenvalues Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Smallest Eigenvalue -d and Bipartiteness Criterion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of the Adjacency Spectrum of an undirected simple graph $G$: The eigenvalues $\lambda_1 \ge \lambda_2 \ge \dots \ge \lambda_n$ of the real symmetric adjacency matrix $\mathbf{A} \in \{0, 1\}^{n \times n}$. State Fundamental Spectral Theorems:
   - Real Eigenvalues: All eigenvalues $\lambda_i \in \mathbb{R}$ with orthogonal eigenvectors.
   - Trace Properties: $\sum_{i=1}^n \lambda_i = \operatorname{Tr}(\mathbf{A}) = 0$, and $\sum_{i=1}^n \lambda_i^2 = \operatorname{Tr}(\mathbf{A}^2) = 2|E|$, and $\sum \lambda_i^3 = \operatorname{Tr}(\mathbf{A}^3) = 6 \times (\text{# of triangles } K_3)$.
   - Perron-Frobenius for Graphs: For a connected $d$-regular graph, $\lambda_1 = d$ has multiplicity 1 with positive eigenvector $\mathbf{1} = [1, \dots, 1]^T$, and $|\lambda_i| \le d$ for all $i$.
   - Bipartite Symmetry Theorem: $G$ is bipartite $\iff \operatorname{Spec}(\mathbf{A})$ is symmetric about $0$ ($\lambda_i = -\lambda_{n-i+1}$ for all $i$).
2. **Slide 2 (`ordering`):** Provide 5 steps proving that bipartite graphs have symmetric spectra: (1) let $G = (V_1 \cup V_2, E)$ be bipartite, so its adjacency matrix is 2-block: $\mathbf{A} = \begin{bmatrix} \mathbf{0} & \mathbf{B} \\ \mathbf{B}^T & \mathbf{0} \end{bmatrix}$, (2) let $\mathbf{v} = [\mathbf{x}, \mathbf{y}]^T$ be an eigenvector with eigenvalue $\lambda$: $\mathbf{A} \mathbf{v} = \lambda \mathbf{v}$, (3) expand the block matrix equations: $\mathbf{B} \mathbf{y} = \lambda \mathbf{x}$ and $\mathbf{B}^T \mathbf{x} = \lambda \mathbf{y}$, (4) construct the sign-flipped vector $\mathbf{u} = [\mathbf{x}, -\mathbf{y}]^T$, (5) evaluate $\mathbf{A} \mathbf{u} = \begin{bmatrix} -\mathbf{B} \mathbf{y} \\ \mathbf{B}^T \mathbf{x} \end{bmatrix} = \begin{bmatrix} -\lambda \mathbf{x} \\ \lambda \mathbf{y} \end{bmatrix} = -\lambda \begin{bmatrix} \mathbf{x} \\ -\mathbf{y} \end{bmatrix} = -\lambda \mathbf{u}$, proving that $-\lambda$ is also an eigenvalue of $\mathbf{A}$ with eigenvector $\mathbf{u}$!
3. **Slide 3 (`matching`):** Pair 4 graphs (Complete Graph $K_n$, Cycle Graph $C_n$, Complete Bipartite $K_{n, n}$, Star Graph $K_{1, n-1}$) with their adjacency spectrum eigenvalues.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the sum of all adjacency matrix eigenvalues $\sum \lambda_i = \operatorname{Tr}(\mathbf{A})$ is identically zero for simple graphs with no self-loops. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the spectral test for bipartiteness in $d$-regular graphs: For a connected $d$-regular graph $G$, what does the existence of smallest eigenvalue $\lambda_n = -d$ imply about the graph structure? ($G$ is BIPARTITE; by the Perron-Frobenius theorem, $\lambda_n = -d$ occurs if and only if the graph contains no odd cycles and is 2-colorable).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "adjacency_matrix_spectrum_and_bipartiteness",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Adjacency Matrix Spectrum and Bipartiteness**\n• **Adjacency Spectrum $\\operatorname{Spec}(\\mathbf{A})$:** Eigenvalues $\\lambda_1 \\ge \\lambda_2 \\ge \\dots \\ge \\lambda_n \\in \\mathbb{R}$ of the symmetric adjacency matrix $\\mathbf{A}$.\n• **Trace Invariant Identities:**\n  - $\\sum_{i=1}^n \\lambda_i = \\operatorname{Tr}(\\mathbf{A}) = 0$ (no self-loops).\n  - $\\sum_{i=1}^n \\lambda_i^2 = \\operatorname{Tr}(\\mathbf{A}^2) = 2|E|$.\n  - $\\sum_{i=1}^n \\lambda_i^3 = \\operatorname{Tr}(\\mathbf{A}^3) = 6 \\times (\\text{Number of Triangles } K_3)$.\n• **Perron-Frobenius for $d$-Regular Graphs:** $\\lambda_1 = d$ (with all-ones eigenvector $\\mathbf{1}$), and $|\\lambda_i| \\le d$ for all $i$.\n• **Bipartite Spectral Symmetry Theorem:**\n$$\nG \\text{ is Bipartite} \\iff \\lambda \\in \\operatorname{Spec}(\\mathbf{A}) \\implies -\\lambda \\in \\operatorname{Spec}(\\mathbf{A})\n$$\n(The spectrum is perfectly symmetric around 0!)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps establishing that every bipartite graph has a symmetric adjacency spectrum.",
      "orderItems": [
        "Partition the bipartite vertex set into parts V_1 and V_2, giving block matrix A = [[0, B], [B^T, 0]]",
        "Let v = [x, y]^T be an eigenvector of A with eigenvalue lambda: A v = lambda v",
        "Expand block matrix multiplication to obtain system: B y = lambda x and B^T x = lambda y",
        "Construct test vector u = [x, -y]^T with opposite signs on the second bipartite partition",
        "Evaluate matrix-vector product A u = [-B y, B^T x]^T = [-lambda x, lambda y]^T = -lambda [x, -y]^T = -lambda u, proving -lambda is an eigenvalue"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each graph family to its exact adjacency spectrum Spec(A).",
      "matchPairs": [
        { "left": "Complete Graph K_n", "right": "{n - 1 (mult 1), -1 (mult n-1)}" },
        { "left": "Cycle Graph C_n", "right": "{2 cos(2 pi k / n) for k = 0, 1, ..., n-1}" },
        { "left": "Complete Bipartite K_{n, n}", "right": "{+n (mult 1), 0 (mult 2n-2), -n (mult 1)}" },
        { "left": "Star Graph K_{1, n-1}", "right": "{+sqrt(n-1), 0 (mult n-2), -sqrt(n-1)}" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Because simple graphs have no self-loops, the sum of all eigenvalues sum_{i=1}^n lambda_i = Tr(A) is identically equal to ___.",
      "blankAnswer": "zero",
      "blankDistractors": ["one", "two", "infinity"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "For a connected d-regular graph G, what does the presence of the eigenvalue lambda_n = -d prove about the graph?",
      "options": [
        { "text": "The graph is strictly BIPARTITE (it contains no odd cycles and can be properly 2-colored)", "isCorrect": true, "explanation": "Correct! In a d-regular graph, the spectral radius is d. By Perron-Frobenius theory, lambda = -d is an eigenvalue if and only if the graph is bipartite." },
        { "text": "The graph is disconnected", "isCorrect": false, "explanation": "Incorrect: Multiplicity of +d indicates connectivity, not -d." },
        { "text": "The graph is a tree", "isCorrect": false, "explanation": "Incorrect: Trees with d > 2 are not regular." },
        { "text": "The graph is planar", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
