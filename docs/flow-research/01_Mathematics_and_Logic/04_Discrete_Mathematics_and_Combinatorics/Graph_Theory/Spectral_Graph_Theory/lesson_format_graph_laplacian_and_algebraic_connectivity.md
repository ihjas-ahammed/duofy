# Duofy Reusable Lesson Format: The Graph Laplacian and Algebraic Connectivity

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Graph_Theory / Spectral_Graph_Theory`  
**Lesson Format Type:** `graph_laplacian_and_algebraic_connectivity`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the **Unnormalized Graph Laplacian** $\mathbf{L} = \mathbf{D} - \mathbf{A}$, derive the quadratic energy form $\mathbf{x}^T \mathbf{L} \mathbf{x} = \sum_{uv \in E} (x_u - x_v)^2$, prove that $\mathbf{L}$ is positive semi-definite ($0 = \mu_1 \le \mu_2 \le \dots \le \mu_n$), define the **Algebraic Connectivity / Fiedler Value $\mu_2(G)$** (Miroslav Fiedler, 1973), and characterize connected components as the null space of $\mathbf{L}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Graph Laplacian & Fiedler Value Algebraic Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Laplacian Quadratic Form x^T L x Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Laplacian Spectral Invariant & Graph Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical Fiedler Value for Complete Graph K_n Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Multiplicity of Zero Eigenvalue Component Count Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of the Graph Laplacian Matrix: $\mathbf{L} = \mathbf{D} - \mathbf{A} \in \mathbb{R}^{n \times n}$ where $\mathbf{D} = \operatorname{diag}(\deg(v_1), \dots, \deg(v_n))$ and $\mathbf{A}$ is the adjacency matrix. State Fundamental Laplacian Theorems:
   - Quadratic Energy Form: For any $\mathbf{x} \in \mathbb{R}^n$, $\mathbf{x}^T \mathbf{L} \mathbf{x} = \sum_{uv \in E} (x_u - x_v)^2 \ge 0$ (proving $\mathbf{L}$ is Positive Semi-Definite).
   - Spectrum: $0 = \mu_1 \le \mu_2 \le \dots \le \mu_n$, with $\mu_1 = 0$ associated with constant eigenvector $\mathbf{1}$.
   - Connected Components Theorem: The multiplicity of eigenvalue $0$ equals the number of connected components $c(G)$.
   - **Algebraic Connectivity (Fiedler Value $\mu_2$):** $\mu_2(G) = \min_{\mathbf{x} \perp \mathbf{1}, \mathbf{x} \ne \mathbf{0}} \frac{\mathbf{x}^T \mathbf{L} \mathbf{x}}{\mathbf{x}^T \mathbf{x}} > 0 \iff G \text{ is connected}$.
2. **Slide 2 (`ordering`):** Provide 5 steps proving $\mathbf{x}^T \mathbf{L} \mathbf{x} = \sum_{uv \in E} (x_u - x_v)^2$: (1) expand $\mathbf{x}^T \mathbf{L} \mathbf{x} = \mathbf{x}^T \mathbf{D} \mathbf{x} - \mathbf{x}^T \mathbf{A} \mathbf{x}$, (2) rewrite the diagonal term: $\mathbf{x}^T \mathbf{D} \mathbf{x} = \sum_{u \in V} \deg(u) x_u^2$, (3) rewrite the adjacency term: $\mathbf{x}^T \mathbf{A} \mathbf{x} = \sum_{u \in V} \sum_{v \in V} A_{uv} x_u x_v = 2 \sum_{uv \in E} x_u x_v$, (4) substitute $\deg(u) = \sum_{v \sim u} 1$ to rewrite $\sum_u \deg(u) x_u^2 = \sum_{uv \in E} (x_u^2 + x_v^2)$, (5) combine: $\sum_{uv \in E} (x_u^2 - 2 x_u x_v + x_v^2) = \sum_{uv \in E} (x_u - x_v)^2$, proving positive semi-definiteness!
3. **Slide 3 (`matching`):** Pair 4 Laplacian properties ($\mu_2(G) = 0$, $\mu_2(K_n) = n$, Fiedler Vector $\mathbf{v}_2$, $\sum \mu_i$) with their graph interpretations.
4. **Slide 4 (`numerical`):** Ask student: For the complete graph $K_5$ on 5 vertices, what is the exact value of the algebraic connectivity $\mu_2(K_5) = n = 5$? (numeric answer: 5).
5. **Slide 5 (`quiz`):** Quiz on the dimension of the null space $\ker(\mathbf{L})$: If the Graph Laplacian of a graph $G$ on 20 vertices has the eigenvalue $0$ with algebraic multiplicity $k = 4$, what does this reveal about graph $G$? (The graph $G$ consists of EXACTLY 4 disjoint connected components, since the indicator vector of each connected component $\mathbf{1}_{V_j}$ spans an independent dimension of the null space $\ker(\mathbf{L})$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "graph_laplacian_and_algebraic_connectivity",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Graph Laplacian and Algebraic Connectivity**\n• **The Unnormalized Graph Laplacian:**\n$$\n\\mathbf{L} = \\mathbf{D} - \\mathbf{A} \\in \\mathbb{R}^{n \\times n}\n$$\n• **Quadratic Energy Form:** For any signal vector $\\mathbf{x} \\in \\mathbb{R}^n$:\n$$\n\\mathbf{x}^T \\mathbf{L} \\mathbf{x} = \\sum_{uv \\in E} (x_u - x_v)^2 \\ge 0\n$$\n(Proves $\\mathbf{L}$ is **Symmetric Positive Semi-Definite** with eigenvalues $0 = \\mu_1 \\le \\mu_2 \\le \\dots \\le \\mu_n$).\n• **Nullspace and Connectivity:** $\\operatorname{dim}(\\ker(\\mathbf{L})) = c(G)$ (number of connected components).\n• **Algebraic Connectivity / Fiedler Value $\\mu_2(G)$ (Miroslav Fiedler, 1973):**\n$$\n\\mu_2(G) = \\min_{\\mathbf{x} \\perp \\mathbf{1}, \\, \\mathbf{x} \\ne \\mathbf{0}} \\frac{\\sum_{uv \\in E} (x_u - x_v)^2}{\\sum_u x_u^2} > 0 \\iff G \\text{ is connected}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps establishing the quadratic Dirichlet energy form of the Graph Laplacian.",
      "orderItems": [
        "Split the quadratic form into degree and adjacency terms: x^T L x = x^T D x - x^T A x",
        "Write out the degree matrix summation: x^T D x = sum_{u in V} deg(u) * x_u^2",
        "Write out the adjacency matrix summation: x^T A x = 2 * sum_{uv in E} x_u * x_v",
        "Replace degree by neighbor sums to rewrite sum deg(u) x_u^2 = sum_{uv in E} (x_u^2 + x_v^2)",
        "Combine terms over all edges: sum_{uv in E} (x_u^2 - 2 x_u x_v + x_v^2) = sum_{uv in E} (x_u - x_v)^2 >= 0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Laplacian spectral object to its graph theoretical meaning.",
      "matchPairs": [
        { "left": "Fiedler Value mu_2(G)", "right": "Algebraic connectivity measuring the robustness of graph connection" },
        { "left": "Fiedler Vector v_2", "right": "Eigenvector corresponding to mu_2; coordinates provide optimal 1D graph embedding" },
        { "left": "Complete Graph Laplacian mu_2(K_n)", "right": "n (with multiplicity n - 1; maximally connected)" },
        { "left": "Trace Tr(L) = sum mu_i", "right": "2 |E| = sum deg(v_i) (sum of vertex degrees)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the exact algebraic connectivity mu_2(K_5) for the complete graph on 5 vertices: mu_2(K_n) = n.",
      "numericAnswer": 5,
      "numericTolerance": 0
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "If the Graph Laplacian L of a 20-vertex graph has eigenvalue 0 with multiplicity k = 4, what does this prove about the graph topology?",
      "options": [
        { "text": "The graph consists of EXACTLY 4 disjoint connected components (the indicator vector 1_{V_i} of each component spans an independent nullspace dimension of L)", "isCorrect": true, "explanation": "Correct! Because x^T L x = sum (x_u - x_v)^2 = 0 requires x to be constant on every connected component, the dimension of ker(L) exactly equals the number of connected components." },
        { "text": "The graph contains 4 cycles", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The graph has chromatic number 4", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The graph is 4-regular", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
