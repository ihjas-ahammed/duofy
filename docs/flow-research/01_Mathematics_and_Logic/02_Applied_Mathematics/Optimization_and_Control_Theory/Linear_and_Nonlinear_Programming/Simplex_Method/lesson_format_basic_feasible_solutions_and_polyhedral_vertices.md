# Duofy Reusable Lesson Format: Basic Feasible Solutions and Polyhedral Vertices

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Linear_and_Nonlinear_Programming / Simplex_Method`  
**Lesson Format Type:** `basic_feasible_solutions_and_polyhedral_vertices`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the standard form Linear Program, establish the geometric-algebraic equivalence between **Extreme Points / Vertices** of polyhedra and **Basic Feasible Solutions (BFS)** ($\mathbf{x}_B = B^{-1}\mathbf{b} \ge \mathbf{0}, \mathbf{x}_N = \mathbf{0}$), and prove the **Fundamental Theorem of Linear Programming**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Standard Form LP & BFS Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Geometric Vertex to Algebraic Basis Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Linear Programming Entity & Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Non-Basic Variable Value Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Fundamental Theorem Extreme Point Optimality Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Standard Form Linear Program: $\min \mathbf{c}^T \mathbf{x}$ subject to $A \mathbf{x} = \mathbf{b}, \mathbf{x} \ge \mathbf{0}$ where $A \in \mathbb{R}^{m \times n}$ with $\operatorname{rank}(A) = m$. Define a Basis $B$ as an $m \times m$ non-singular submatrix of $A$. Define a Basic Solution: $\mathbf{x}_B = B^{-1}\mathbf{b}$ (basic variables) and $\mathbf{x}_N = \mathbf{0}$ (non-basic variables). If $\mathbf{x}_B \ge \mathbf{0}$, $\mathbf{x}$ is a **Basic Feasible Solution (BFS)**. State Theorem: A vector $\mathbf{x}$ is an extreme point (vertex) of the polyhedron $P = \{\mathbf{x} \ge \mathbf{0} \mid A\mathbf{x} = \mathbf{b}\} \iff \mathbf{x}$ is a BFS.
2. **Slide 2 (`concept_pieces`):** Deconstruct: (1) partition of columns $A = [B \mid N]$ and variables $\mathbf{x} = [\mathbf{x}_B; \mathbf{x}_N]$, (2) setting $n - m$ non-basic variables to zero corresponds geometrically to intersecting $n - m$ active bounding hyperplanes $x_j = 0$, (3) solving $m$ linear equations $B \mathbf{x}_B = \mathbf{b}$ yields the unique intersection vertex, (4) non-degeneracy condition: $(x_B)_i > 0$ for all $i \in B$.
3. **Slide 3 (`matching`):** Pair 4 LP concepts (Basic Variables $\mathbf{x}_B$, Non-Basic Variables $\mathbf{x}_N$, Basis Matrix $B$, Extreme Point / Vertex) with their algebraic properties.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in every Basic Feasible Solution, all $n - m$ non-basic variables are set equal to zero. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question on the Fundamental Theorem of Linear Programming: If a non-empty linear programming problem bounded from below has an optimal solution, where is an optimum GUARANTEED to exist? (At least one optimal solution occurs at an extreme point / basic feasible solution of the feasible polyhedron).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "basic_feasible_solutions_and_polyhedral_vertices",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Standard Form Linear Programs and Basic Feasible Solutions (BFS)**\n• **Standard Form Linear Program:**\n$$\n\\min_{\\mathbf{x}} \\mathbf{c}^T \\mathbf{x} \\quad \\text{subject to} \\quad A \\mathbf{x} = \\mathbf{b}, \\quad \\mathbf{x} \\ge \\mathbf{0}\n$$\nwhere $A \\in \\mathbb{R}^{m \\times n}$ ($m \\le n$) has full row rank $m$.\n• **Basis Matrix $B$:** An $m \\times m$ invertible submatrix formed by choosing $m$ linearly independent columns of $A$.\n• **Basic Feasible Solution (BFS):** Partition $\\mathbf{x} = [\\mathbf{x}_B; \\mathbf{x}_N]$:\n$$\n\\mathbf{x}_B = B^{-1} \\mathbf{b} \\ge \\mathbf{0} \\quad (\\text{Basic Variables}), \\qquad \\mathbf{x}_N = \\mathbf{0} \\quad (\\text{Non-Basic Variables})\n$$\n• **Theorem (Equivalence of Vertices and BFS):** A point $\\mathbf{x}$ is an **extreme point (vertex)** of the polyhedron $P = \\{\\mathbf{x} \\ge \\mathbf{0} \\mid A\\mathbf{x} = \\mathbf{b}\\} \\iff \\mathbf{x}$ is a Basic Feasible Solution."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Algebraic-Geometric Duality:** In $\\mathbb{R}^n$, setting $n-m$ non-basic variables to zero ($x_j = 0$) activates $n-m$ bounding constraint hyperplanes.\n• **Vertex Intersection:** The remaining $m$ linear constraints $A\\mathbf{x} = \\mathbf{b}$ determine a single 0-dimensional point: the polyhedral vertex $\\mathbf{x}_B = B^{-1}\\mathbf{b}$.\n• **Finite Search Space:** The number of distinct basic solutions is bounded by the binomial coefficient $\\binom{n}{m} = \\frac{n!}{m!(n-m)!}$.\n• **Non-Degeneracy:** A BFS is non-degenerate if every basic variable is strictly positive ($(x_B)_i > 0$ for all $i=1,\\dots,m$)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each linear optimization concept to its mathematical role.",
      "matchPairs": [
        { "left": "Basic Variables x_B", "right": "m variables solved via x_B = B^{-1} b >= 0" },
        { "left": "Non-Basic Variables x_N", "right": "n - m variables explicitly fixed to zero (x_N = 0)" },
        { "left": "Basis Matrix B", "right": "m x m invertible submatrix of linearly independent columns of A" },
        { "left": "Extreme Point (Vertex)", "right": "Point that cannot be written as a convex combination of two other points in P" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In constructing a Basic Feasible Solution for an m x n standard form LP, exactly n - m non-basic variables are set equal to ___.",
      "blankAnswer": "zero",
      "blankDistractors": ["one", "infinity", "b"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What does the Fundamental Theorem of Linear Programming state for any non-empty, bounded linear program?",
      "options": [
        { "text": "If an optimal solution exists, at least one optimal solution is achieved at an EXTREME POINT (Basic Feasible Solution) of the feasible polyhedron", "isCorrect": true, "explanation": "Correct! Because the linear objective function c^T x is affine, its minimum over a compact convex polyhedron is always attained at one or more vertices." },
        { "text": "The optimal solution is always in the interior of the polytope", "isCorrect": false, "explanation": "Incorrect: Linear objectives never achieve unconstrained interior extrema." },
        { "text": "Linear programs never have solutions", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Every feasible point is an extreme point", "isCorrect": false, "explanation": "Incorrect: Only vertices are extreme points." }
      ]
    }
  ]
}
```
