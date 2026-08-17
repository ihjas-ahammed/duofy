# Duofy Reusable Lesson Format: Incidence Matrices and Algebraic Graph Representations

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Linear_and_Nonlinear_Data_Structures / Graphs_and_Adjacency_Representations`  
**Lesson Format Type:** `incidence_matrices_and_algebraic_graph_representations`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the algebraic linear algebra formulations, vertex-edge incident relationships, and spectral graph theory connections of Incidence Matrices and the Graph Laplacian (Norman Biggs, *Algebraic Graph Theory*; Chris Godsil & Gordon Royle; Thomas H. Cormen et al. CLRS Chapter 22): master the **Incidence Matrix ($B \in \mathbb{R}^{|V| \times |E|}$)** where rows represent vertices and columns represent edges, formulate the **Directed Orientation Rules ($B[v][e] = -1$ if $e = (v, w)$ leaves $v$, $+1$ if $e = (u, v)$ enters $v$, $0$ otherwise)** and undirected binary rules, prove the foundational **Laplacian Factorization Theorem ($\mathbf{L = B \cdot B^T = D - A}$)** where $D$ is the diagonal degree matrix and $A$ is the adjacency matrix, and evaluate algebraic Kirchhoff Matrix-Tree applications.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Incidence Matrix Structure, Orientation Signs, & Laplacian Factorization Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Construction of a Directed Incidence Matrix Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Algebraic Graph Entity & Linear Algebra Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Sum of All Column Entries in Any Directed Incidence Matrix Column (0) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Derivation Connecting the Incidence Matrix to the Graph Laplacian Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Incidence Matrices & Graph Laplacian (Biggs; Godsil & Royle; CLRS):
   - **The Incidence Matrix ($B \in \mathbb{R}^{|V| \times |E|}$):**
     - Dimensions: $|V|$ rows (vertices) by $|E|$ columns (edges).
     - **Directed Graph Sign Invariant:** For edge $e_k = (u, v)$ (directed from $u \to v$):
       $$\mathbf{B[w][e_k] = \begin{cases} -1 & w = u \ (\text{Tail / Source}) \\ +1 & w = v \ (\text{Head / Target}) \\ 0 & \text{otherwise} \end{cases}}$$
     - **Column Sum Invariant:** Every column has exactly one $-1$ and one $+1 \implies \mathbf{\sum_{v} B[v][e] = 0}$!
   - **The Graph Laplacian ($L \in \mathbb{R}^{|V| \times |V|}$):**
     $$\mathbf{L = B \cdot B^T = D - A}$$
     - Where $D = \text{diag}(\text{deg}(v_1), \dots, \text{deg}(v_n))$ and $A$ is the Adjacency Matrix.
   - **Kirchhoff's Matrix Tree Theorem:** Any cofactor of $L$ equals the exact number of spanning trees in $G$!
2. **Slide 2 (`ordering`):** Provide 5 steps of constructing a directed incidence matrix: (1) determine total number of vertices V and edges E, allocating a V x E grid initialized to zeros, (2) index the edges from 0 to E - 1 in a fixed order, (3) for edge k = (u, v), set entry B[u][k] = -1 representing the source/tail vertex, (4) set entry B[v][k] = +1 representing the destination/head vertex, (5) leave all other rows in column k as 0, repeating for all E edges to finalize the incidence matrix B!
3. **Slide 3 (`matching`):** Pair 4 algebraic graph concepts (Incidence Matrix B (V x E), Graph Laplacian L = B * B^T, Column Sum = 0, Kirchhoff's Matrix-Tree Theorem) with their mathematical definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the sum of entries in any column of a directed incidence matrix is always 0. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the derivation proving $L = B B^T = D - A$: Why does multiplying the directed incidence matrix $B$ by its transpose $B^T$ yield the Graph Laplacian matrix $L = D - A$? (Because the diagonal entry $(B B^T)[u][u] = \sum_e B[u][e]^2$ sums $1^2$ for every incident edge, giving **vertex degree $D[u][u]$**; while the off-diagonal entry $(B B^T)[u][v] = \sum_e B[u][e] B[v][e]$ equals **$-1$ if an edge connects $u$ and $v$ (since one is $+1$ and other is $-1$), yielding $-A[u][v]$**; thus $B B^T = D - A$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "incidence_matrices_and_algebraic_graph_representations",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Incidence Matrices & The Graph Laplacian**\n• **Directed Incidence Matrix ($B \\in \\mathbb{R}^{|V| \\times |E|}$):**\n$$\n\\mathbf{B[w][e_k] = \\begin{cases} -1 & w = u \\ (\\text{Source / Tail}) \\\\ +1 & w = v \\ (\\text{Target / Head}) \\\\ 0 & \\text{otherwise} \\end{cases} \\qquad \\mathbf{\\sum_{v \\in V} B[v][e] = 0}}\n$$\n• **The Graph Laplacian Factorization ($L \\in \\mathbb{R}^{|V| \\times |V|}$):**\n$$\n\\mathbf{L = B \\cdot B^T = D - A}\n$$\n  - $D$: Diagonal Degree Matrix ($D[u][u] = \\text{deg}(u)$).\n  - $A$: Adjacency Matrix ($A[u][v] = 1$ if edge exists).\n• **Kirchhoff's Matrix Tree Theorem:** Any cofactor of $L$ counts **exact spanning trees**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of constructing the directed Incidence Matrix B for a graph G = (V, E).",
      "orderItems": [
        "Count vertices |V| and edges |E|, allocating a zero-initialized matrix grid of dimension |V| x |E|",
        "Enumerate all |E| directed edges in an indexed sequence from column 0 up to column |E| - 1",
        "For edge k = (u, v), write -1 in row u at column k representing the outgoing source tail",
        "For edge k = (u, v), write +1 in row v at column k representing the incoming destination head",
        "Verify each column contains exactly one -1 and one +1 with column sum equal to 0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each algebraic graph theory term to its exact mathematical identity.",
      "matchPairs": [
        { "left": "Incidence Matrix B", "right": "|V| x |E| matrix representing relationships between vertices and edges with entries in {-1, 0, +1}" },
        { "left": "Graph Laplacian L = B * B^T", "right": "Symmetric positive semi-definite matrix defined as D - A capturing diffusion and spectral properties" },
        { "left": "Zero Column Sum Property", "right": "Algebraic invariant where sum of all elements in any edge column equals (-1) + (+1) = 0" },
        { "left": "Kirchhoff Matrix-Tree Theorem", "right": "Formula proving any cofactor determinant of Laplacian L equals total spanning tree count" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In any directed incidence matrix, the sum of all entries in any individual column is always equal to ___.",
      "blankAnswer": "0",
      "blankDistractors": ["1", "2", "-1"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What algebraic derivation proves that the matrix product B * B^T of a directed incidence matrix B with its transpose is identical to the Graph Laplacian matrix L = D - A?",
      "options": [
        { "text": "For diagonal entries, (B * B^T)[u][u] sums (-1)^2 or (+1)^2 for every edge incident to vertex u, which equals the vertex degree D[u][u]; for off-diagonal entries (u != v), the product B[u][e]*B[v][e] is non-zero only when edge e connects u and v (producing (-1)*(+1) = -1), which equals -A[u][v]; therefore B * B^T = D - A", "isCorrect": true, "explanation": "Correct! This is the fundamental algebraic link connecting incidence matrices and spectral graph theory (Norman Biggs, Algebraic Graph Theory). Let $B$ be a $|V| \\times |E|$ directed incidence matrix. The $(u, v)$-th entry of the product matrix $L = B B^T$ is given by the dot product of row $u$ and row $v$ of $B$: $(B B^T)[u][v] = \\sum_{e=1}^{|E|} B[u][e] B[v][e]$. 1. Diagonal Elements ($u = v$): $(B B^T)[u][u] = \\sum_{e=1}^{|E|} (B[u][e])^2$. For every edge $e$ incident to vertex $u$, $B[u][e]$ is either $+1$ or $-1$, so $(B[u][e])^2 = 1$. For all non-incident edges, $B[u][e] = 0$. The sum is exactly equal to the total number of incident edges (the degree of $u$), which matches $D[u][u]$! 2. Off-Diagonal Elements ($u \\ne v$): $(B B^T)[u][v] = \\sum_{e=1}^{|E|} B[u][e] B[v][e]$. If there is an edge $e$ connecting $u$ and $v$, one endpoint has $B[u][e] = -1$ and the other has $B[v][e] = +1$, so their product is $(-1)(+1) = -1$. If no edge connects $u$ and $v$, the product is 0 for all edges. Thus, $(B B^T)[u][v] = -1$ if $(u, v) \\in E$ and $0$ otherwise, which exactly equals $-A[u][v]$. Combining diagonal and off-diagonal results: $B B^T = D - A = L$ (The Graph Laplacian)." },
        { "text": "Because all matrices multiplied by their transpose become identity matrices", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because incidence matrices have zero determinant", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because graph theory algorithms ignore diagonal elements", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
