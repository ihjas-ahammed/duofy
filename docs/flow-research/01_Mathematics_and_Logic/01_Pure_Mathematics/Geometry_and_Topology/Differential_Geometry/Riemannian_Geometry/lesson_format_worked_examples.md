# Duofy Reusable Lesson Format: Riemannian Geometry - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Differential_Geometry / Riemannian_Geometry`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute Christoffel symbols $\Gamma_{ij}^k$, write the geodesic differential equations, and compute the constant negative sectional/Gaussian curvature of the **Poincaré Upper Half Plane** $\mathbb{H}^2$ ($g = \frac{dx^2 + dy^2}{y^2}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Poincaré Upper Half Plane Metric Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Christoffel Symbol Computation Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Non-Zero Christoffel Coefficient Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Sectional Curvature Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Poincaré Geodesic Semicircle Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the metric of the Poincaré Upper Half Plane $\mathbb{H}^2 = \{(x, y) \in \mathbb{R}^2 \mid y > 0\}$: $g = \frac{1}{y^2} dx^2 + \frac{1}{y^2} dy^2$, so $g_{11} = g_{22} = y^{-2}$, $g_{12} = 0$, $g^{11} = g^{22} = y^2$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) metric derivatives: $\partial_y g_{11} = \partial_y g_{22} = -2y^{-3}$, and all $\partial_x g_{ij} = 0$, (2) compute $\Gamma_{12}^1 = \Gamma_{21}^1 = \frac{1}{2} g^{11}(\partial_y g_{11}) = \frac{1}{2} y^2 (-2y^{-3}) = -1/y$, (3) compute $\Gamma_{11}^2 = -\frac{1}{2} g^{22}(\partial_y g_{11}) = -\frac{1}{2} y^2(-2y^{-3}) = 1/y$, and $\Gamma_{22}^2 = -1/y$, (4) Curvature tensor calculation gives Gaussian/Sectional curvature $K = -1$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the Christoffel symbol $\Gamma_{11}^2$ is equal to positive one over y. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to evaluate the constant Gaussian/sectional curvature $K$ of $\mathbb{H}^2$ ($K = -1.0$).
5. **Slide 5 (`quiz`):** Quiz asking: What are the geodesics in the Poincaré Upper Half Plane $\mathbb{H}^2$? (Vertical straight lines and semicircles orthogonal to the real axis $y = 0$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Computing Christoffel Symbols for the Poincaré Upper Half Plane $\\mathbb{H}^2$**\nThe hyperbolic metric on $\\mathbb{H}^2 = \\{(x, y) \\in \\mathbb{R}^2 \\mid y > 0\\}$ is:\n$$\ng = \\frac{dx^2 + dy^2}{y^2} \\implies g_{ij} = \\begin{pmatrix} y^{-2} & 0 \\\\ 0 & y^{-2} \\end{pmatrix}, \\quad g^{ij} = \\begin{pmatrix} y^2 & 0 \\\\ 0 & y^2 \\end{pmatrix}\n$$\nWe will compute the connection coefficients $\\Gamma_{ij}^k = \\frac{1}{2} g^{k\\ell}(\\partial_i g_{j\\ell} + \\partial_j g_{i\\ell} - \\partial_\\ell g_{ij})$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Metric Derivatives):** $\\frac{\\partial g_{11}}{\\partial y} = -2y^{-3}$, $\\frac{\\partial g_{22}}{\\partial y} = -2y^{-3}$. All $x$-derivatives $\\partial_x g_{ij} = 0$.\n• **Step 2 (Evaluate $\\Gamma_{ij}^1$):**\n  $$\\Gamma_{12}^1 = \\Gamma_{21}^1 = \\frac{1}{2} g^{11} \\frac{\\partial g_{11}}{\\partial y} = \\frac{1}{2} (y^2)(-2y^{-3}) = -\\frac{1}{y}, \\quad \\Gamma_{11}^1 = \\Gamma_{22}^1 = 0$$\n• **Step 3 (Evaluate $\\Gamma_{ij}^2$):**\n  $$\\Gamma_{11}^2 = -\\frac{1}{2} g^{22} \\frac{\\partial g_{11}}{\\partial y} = -\\frac{1}{2}(y^2)(-2y^{-3}) = +\\frac{1}{y}, \\quad \\Gamma_{22}^2 = -\\frac{1}{y}, \\quad \\Gamma_{12}^2 = 0$$\n• **Step 4 (Sectional Curvature):** Riemann tensor contraction yields constant negative sectional curvature $K = -1$ everywhere."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In the Poincaré Upper Half Plane metric g = (dx^2 + dy^2)/y^2, the Christoffel symbol Gamma_{11}^2 is positive one over ___.",
      "blankAnswer": "y",
      "blankDistractors": ["x", "y^2", "zero"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "What is the exact constant sectional curvature K of the Poincaré Upper Half Plane H^2?",
      "numericAnswer": -1.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What are the unparametrized geodesics (shortest paths) in the Poincaré Upper Half Plane H^2?",
      "options": [
        { "text": "Vertical lines x = c and circular arcs whose centers lie on the boundary line y = 0", "isCorrect": true, "explanation": "Correct! Geodesics in the hyperbolic half-plane are straight vertical rays and semicircles meeting the horizon y = 0 perpendicularly." },
        { "text": "Arbitrary Euclidean straight lines y = mx + c", "isCorrect": false, "explanation": "Incorrect: Euclidean straight lines are not geodesics in hyperbolic geometry (except vertical ones)." },
        { "text": "Horizontal lines y = c", "isCorrect": false, "explanation": "Incorrect: Horizontal lines are horocycles, not geodesics." },
        { "text": "Parabolas", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
