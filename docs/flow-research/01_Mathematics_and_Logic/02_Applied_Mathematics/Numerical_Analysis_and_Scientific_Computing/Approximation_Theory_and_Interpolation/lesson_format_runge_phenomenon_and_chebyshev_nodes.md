# Duofy Reusable Lesson Format: Runge Phenomenon and Chebyshev Node Distribution

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing / Approximation_Theory_and_Interpolation`  
**Lesson Format Type:** `runge_phenomenon_and_chebyshev_nodes`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the failure of high-degree polynomial interpolation on equispaced grids (**Runge's Phenomenon**), define the **Chebyshev Nodes** $x_k = \cos(\frac{2k-1}{2n}\pi)$, and prove how boundary clustering minimizes the nodal polynomial norm $\|\prod (x - x_k)\|_\infty = 2^{1-n}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Interpolation Error & Chebyshev Nodes Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Nodal Polynomial Minimization Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Node Type & Error Growth Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Boundary Density Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Runge Function Complex Poles Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the polynomial interpolation error theorem $f(x) - p_n(x) = \frac{f^{(n+1)}(\xi)}{(n+1)!} \omega_{n+1}(x)$ where $\omega_{n+1}(x) = \prod_{k=0}^n (x - x_k)$. State Chebyshev's Theorem: On $[-1, 1]$, the monic polynomial of degree $n$ with the smallest infinity norm is $2^{1-n} T_n(x)$, whose zeros are the Chebyshev nodes $x_k = \cos\left(\frac{2k-1}{2n}\pi\right)$ ($k=1, \dots, n$).
2. **Slide 2 (`concept_pieces`):** Deconstruct Runge's test function $f(x) = \frac{1}{1 + 25x^2}$, equispaced nodal polynomial growth near edges $\pm 1$, Chebyshev circle projection geometry ($x_k$ is the horizontal projection of $n$ equispaced points on the upper semicircle), and logarithmic Lebesgue constant growth $\Lambda_n = \frac{2}{\pi}\ln n + \mathcal{O}(1)$.
3. **Slide 3 (`matching`):** Pair 4 grid types (Equispaced Nodes, Chebyshev Zeros, Chebyshev Extrema / Gauss-Lobatto, Random Points) with their Lebesgue constant asymptotic growth.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Chebyshev nodes cluster near the boundaries/endpoints of the interval to suppress wild edge oscillations. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question explaining why Runge's function $f(x) = \frac{1}{1 + 25x^2}$ diverges under equispaced interpolation: (Because $f(z)$ has complex poles at $z = \pm 0.2 i$, which lie inside the Bernstein convergence ellipse of the equispaced grid).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "runge_phenomenon_and_chebyshev_nodes",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Polynomial Interpolation Error and Chebyshev Nodes**\n• The error of interpolating $f(x) \\in C^{n+1}[a, b]$ at $n+1$ nodes is:\n$$\nf(x) - p_n(x) = \\frac{f^{(n+1)}(\\xi)}{(n+1)!} \\prod_{k=0}^n (x - x_k)\n$$\n• **Chebyshev's Minimax Theorem:** The monic polynomial of degree $n$ that minimizes $\\max_{x \\in [-1, 1]} |\\omega_n(x)|$ is $\\frac{1}{2^{n-1}} T_n(x)$ with minimal bound $\\frac{1}{2^{n-1}}$.\n• **Chebyshev Nodes (Roots of $T_n$):**\n$$\nx_k = \\cos\\left( \\frac{2k - 1}{2n} \\pi \\right), \\quad k = 1, 2, \\dots, n\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Runge's Counterexample (1901):** Interpolating $f(x) = \\frac{1}{1 + 25x^2}$ on equispaced nodes causes catastrophic divergence at the edges (error $\\to \\infty$ as $n \\to \\infty$).\n• **The Edge Clustering Cure:** Chebyshev nodes are the projections onto the $x$-axis of equally spaced points on the unit semicircle, naturally clustering near the endpoints $\\pm 1$.\n• **Lebesgue Constant Growth:**\n  - Equispaced: $\\Lambda_n \\sim \\frac{2^n}{e n \\ln n}$ (Exponential explosion!)\n  - Chebyshev: $\\Lambda_n = \\frac{2}{\\pi} \\ln n + \\mathcal{O}(1)$ (Slow logarithmic growth!).\n• **Spectral Convergence:** For any analytic function, Chebyshev interpolation converges exponentially fast."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each interpolation grid to its Lebesgue constant asymptotic growth rate.",
      "matchPairs": [
        { "left": "Equispaced Nodes", "right": "Exponential growth ~ 2^n / (e n ln n) causing Runge divergence" },
        { "left": "Chebyshev Roots / Extrema", "right": "Logarithmic growth ~ (2/pi) ln(n) (near-optimal stability)" },
        { "left": "Extended Chebyshev Nodes", "right": "Absolute optimal minimal Lebesgue constant on [-1, 1]" },
        { "left": "Random Uniform Nodes", "right": "Severe ill-conditioning and high variance divergence" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Chebyshev nodes completely prevent the Runge phenomenon because their spatial density clusters heavily near the ___ of the interval.",
      "blankAnswer": "boundaries",
      "blankDistractors": ["center", "origin", "midpoint"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the underlying complex-analytic reason why Runge's function f(x) = 1 / (1 + 25x^2) diverges under high-degree equispaced polynomial interpolation?",
      "options": [
        { "text": "f(z) possesses complex poles at z = +/- 0.2 i, which lie INSIDE the equispaced divergence region (the Bernstein ellipse of convergence does not enclose [-1, 1])", "isCorrect": true, "explanation": "Correct! Runge's function has simple poles at +/- i/5. The equispaced convergence region requires analyticity inside a specific lemniscate; since 0.2 < 0.5255, the poles cause divergence." },
        { "text": "Because 1 / (1 + 25x^2) is not continuous on [-1, 1]", "isCorrect": false, "explanation": "Incorrect: It is infinitely smooth and real-analytic on [-1, 1]." },
        { "text": "Because polynomial degrees cannot exceed 5", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because derivatives at x = 0 are infinite", "isCorrect": false, "explanation": "Incorrect: All derivatives at 0 are finite." }
      ]
    }
  ]
}
```
