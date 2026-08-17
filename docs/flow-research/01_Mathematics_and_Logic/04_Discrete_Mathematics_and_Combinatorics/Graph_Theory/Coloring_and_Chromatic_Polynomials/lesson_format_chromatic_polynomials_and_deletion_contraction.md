# Duofy Reusable Lesson Format: Chromatic Polynomials and Deletion-Contraction

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Graph_Theory / Coloring_and_Chromatic_Polynomials`  
**Lesson Format Type:** `chromatic_polynomials_and_deletion_contraction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute the **Chromatic Polynomial** $P(G, k)$ (George Birkhoff, 1912): master the **Deletion-Contraction Recurrence** $P(G, k) = P(G \setminus e, k) - P(G / e, k)$, derive canonical closed forms for trees ($k(k-1)^{n-1}$), cycles ($(k-1)^n + (-1)^n(k-1)$), and complete graphs ($k_{(n)}$), and extract topological properties from polynomial coefficients.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Chromatic Polynomial & Deletion-Contraction Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Cycle C_n Chromatic Polynomial Inductive Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Graph Family & Closed Chromatic Polynomial Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical 3-Coloring Count for C_4 Cycle Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Coefficient of k^{n-1} and Edge Count Invariant Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of the Chromatic Polynomial $P(G, k)$: The number of proper $k$-vertex-colorings of simple graph $G = (V, E)$ with $|V| = n$ and $|E| = m$. State the Fundamental Deletion-Contraction Recurrence: For any edge $e = uv \in E$:
   $$P(G, k) = P(G \setminus e, k) - P(G / e, k)$$
   where $G \setminus e$ is edge deletion (vertices $u, v$ may have same or different colors) and $G / e$ is edge contraction (merging $u$ and $v$, forcing identical colors). State Invariant Properties: (1) Degree of $P(G, k)$ is $n = |V|$, (2) Leading coefficient is $1$, (3) Second coefficient is $-m = -|E|$, (4) Constant term is $0$ ($P(G, 0) = 0$), (5) Smallest positive integer with $P(G, k) > 0$ is the chromatic number $\chi(G)$.
2. **Slide 2 (`ordering`):** Provide 5 steps proving $P(C_n, k) = (k-1)^n + (-1)^n(k-1)$ by induction on $n$: (1) pick any edge $e$ on $n$-cycle $C_n$, (2) delete edge $e$: $C_n \setminus e$ is the path tree $P_n$ on $n$ vertices with chromatic polynomial $P(P_n, k) = k(k-1)^{n-1}$, (3) contract edge $e$: $C_n / e$ merges the two endpoints, creating the $(n-1)$-cycle $C_{n-1}$, (4) apply deletion-contraction: $P(C_n, k) = P(P_n, k) - P(C_{n-1}, k) = k(k-1)^{n-1} - P(C_{n-1}, k)$, (5) substitute inductive hypothesis $P(C_{n-1}, k) = (k-1)^{n-1} + (-1)^{n-1}(k-1)$ to obtain $P(C_n, k) = (k-1)[(k-1)^{n-1}] - (-1)^{n-1}(k-1) = (k-1)^n + (-1)^n(k-1)$!
3. **Slide 3 (`matching`):** Pair 4 graph types (Tree on $n$ vertices, Complete Graph $K_n$, Cycle $C_n$, Empty Graph $\overline{K}_n$) with their exact chromatic polynomials.
4. **Slide 4 (`numerical`):** Ask student: For a 4-cycle graph $C_4$, calculate the number of proper colorings using $k = 3$ colors: $P(C_4, 3) = (3-1)^4 + (-1)^4(3-1) = 2^4 + 1(2) = 16 + 2 = 18$ (numeric answer: 18).
5. **Slide 5 (`quiz`):** Quiz on the second coefficient of the chromatic polynomial: In any graph $G$ with $n$ vertices and $m$ edges, what is the exact coefficient of $k^{n-1}$ in $P(G, k) = k^n + a_{n-1} k^{n-1} + \dots$? ($a_{n-1} = -m = -|E|$; the negative of the number of edges, as proven by applying deletion-contraction on all edges).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "chromatic_polynomials_and_deletion_contraction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Chromatic Polynomials and Deletion-Contraction**\n• **The Chromatic Polynomial $P(G, k)$ (George Birkhoff, 1912):**\n  Evaluates the exact number of proper $k$-vertex-colorings of simple graph $G$.\n• **The Deletion-Contraction Recurrence (Fundamental Engine):** For any edge $e = uv \\in E$:\n$$\nP(G, k) = P(G \\setminus e, k) - P(G / e, k)\n$$\n  - **$G \\setminus e$ (Edge Deletion):** Counts colorings without restriction on $u$ and $v$.\n  - **$G / e$ (Edge Contraction):** Subtracts forbidden colorings where $u$ and $v$ share the same color.\n• **Algebraic Invariants of $P(G, k) = k^n - m k^{n-1} + \\dots$:**\n  1. $\\deg P(G, k) = n = |V|$.\n  2. Leading coefficient is strictly $+1$.\n  3. Linear coefficient of $k^{n-1}$ is **$-|E|$** (negative of edge count).\n  4. $\\chi(G) = \\min\\{k \\in \\mathbb{N}^+ \\mid P(G, k) > 0\\}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps establishing the chromatic polynomial of the n-cycle C_n via deletion-contraction.",
      "orderItems": [
        "Select an arbitrary edge e on the n-cycle C_n",
        "Delete edge e: the deleted graph C_n \\setminus e is a path tree P_n on n vertices with polynomial k(k-1)^{n-1}",
        "Contract edge e: the contracted graph C_n / e collapses the two endpoints to form the (n-1)-cycle C_{n-1}",
        "Write the deletion-contraction recurrence: P(C_n, k) = k(k-1)^{n-1} - P(C_{n-1}, k)",
        "Solve recurrence by induction: P(C_n, k) = (k-1)^n + (-1)^n * (k-1)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each graph to its exact chromatic polynomial P(G, k).",
      "matchPairs": [
        { "left": "Any Tree T_n on n vertices", "right": "k * (k - 1)^{n-1} (independent of tree topology)" },
        { "left": "Complete Graph K_n", "right": "k * (k - 1) * (k - 2) * ... * (k - n + 1) = k_{(n)}" },
        { "left": "Cycle Graph C_n", "right": "(k - 1)^n + (-1)^n * (k - 1)" },
        { "left": "Empty Graph with n vertices", "right": "k^n (each vertex chosen independently from k colors)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the number of proper 3-colorings of a 4-cycle graph C_4: P(C_4, 3) = (3 - 1)^4 + (-1)^4 * (3 - 1).",
      "numericAnswer": 18,
      "numericTolerance": 0
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In any simple graph G with n vertices and m edges, what topological quantity does the coefficient of k^{n-1} in the chromatic polynomial P(G, k) represent?",
      "options": [
        { "text": "-m (the negative of the total number of edges |E| in the graph)", "isCorrect": true, "explanation": "Correct! Expanding P(G, k) = k^n - |E| k^{n-1} + ... proves that the second coefficient is invariant and strictly encodes the negative edge count -|E|." },
        { "text": "+m (the positive edge count)", "isCorrect": false, "explanation": "Incorrect: Coefficients alternate in sign." },
        { "text": "The number of connected components", "isCorrect": false, "explanation": "Incorrect: That is encoded by the power of the lowest non-zero term." },
        { "text": "The maximum degree Delta", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
