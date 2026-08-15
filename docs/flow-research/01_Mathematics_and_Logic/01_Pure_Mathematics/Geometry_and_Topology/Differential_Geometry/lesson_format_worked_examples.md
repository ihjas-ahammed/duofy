# Duofy Reusable Lesson Format: Differential Geometry - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Differential_Geometry`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute First Fundamental Form $I = E du^2 + 2F du dv + G dv^2$, Christoffel symbols $\Gamma^k_{ij}$, Gaussian curvature $K$, and exterior derivatives $d\omega$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fundamental Form Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Fundamental Form Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Christoffel Symbol Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Gaussian Curvature Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Exterior Derivative Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**First Fundamental Form Coefficients**\nFor a parameterized surface $\\mathbf{r}(u, v)$, the First Fundamental Form coefficients are:\n$$\nE = \\langle \\mathbf{r}_u, \\mathbf{r}_u \\rangle, \\quad F = \\langle \\mathbf{r}_u, \\mathbf{r}_v \\rangle, \\quad G = \\langle \\mathbf{r}_v, \\mathbf{r}_v \\rangle\n$$\nSurface area element: $dA = \\sqrt{E G - F^2} \\, du \\, dv$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Parameterize sphere of radius $R$: $\\mathbf{r}(\\theta, \\phi) = (R \\sin\\theta \\cos\\phi, R \\sin\\theta \\sin\\phi, R \\cos\\theta)$.\n• **Step 2:** Partial derivatives: $\\mathbf{r}_\\theta = R(\\cos\\theta\\cos\\phi, \\cos\\theta\\sin\\phi, -\\sin\\theta)$ and $\\mathbf{r}_\\phi = R(-\\sin\\theta\\sin\\phi, \\sin\\theta\\cos\\phi, 0)$.\n• **Step 3:** Inner products: $E = \\|\\mathbf{r}_\\theta\\|^2 = R^2$, $F = \\langle \\mathbf{r}_\\theta, \\mathbf{r}_\\phi \\rangle = 0$, $G = \\|\\mathbf{r}_\\phi\\|^2 = R^2 \\sin^2\\theta$.\n• **Step 4:** Metric: $ds^2 = R^2 d\\theta^2 + R^2 \\sin^2\\theta d\\phi^2$. Area element: $dA = R^2 \\sin\\theta d\\theta d\\phi$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The Christoffel symbols Gamma^k_ij express partial derivatives of tangent frame vectors in terms of the metric tensor and its ___.",
      "blankAnswer": "derivatives",
      "blankDistractors": ["integrals", "determinant", "trace"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the Gaussian curvature $K$ of a sphere of radius $R = 2$.",
      "numericAnswer": 0.25,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the exterior derivative $d\\omega$ of 1-form $\\omega = x y \\, dx + x^2 \\, dy$?",
      "options": [
        { "text": "dω = x dy ∧ dx (or x dx ∧ dy)", "isCorrect": true, "explanation": "Correct! d(xy dx) = y dy ∧ dx; d(x² dy) = 2x dx ∧ dy. Sum = (2x - y) dx ∧ dy." },
        { "text": "dω = 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "dω = dx + dy", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "dω = x y dx dy", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
