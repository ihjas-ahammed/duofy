# Duofy Reusable Lesson Format: Euclidean & Non-Euclidean Geometry - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Euclidean_and_Non_Euclidean_Geometry`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute spherical triangle areas using Girard's formula, calculate hyperbolic distances in the Poincaré Upper Half-Plane $d(z_1, z_2) = 2 \\operatorname{arsinh} \\left( \\frac{|z_1 - z_2|}{2 \\sqrt{y_1 y_2}} \\right)$, and evaluate angle defects.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Spherical / Hyperbolic Distance Formula | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Distance Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Metric Tensor Component Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Spherical Area Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Ideal Triangle Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Spherical Triangle Area Calculation**\nFor a spherical triangle on a sphere of radius $R = 1$ with angles $\\alpha, \\beta, \\gamma$ in degrees:\n$$\n\\text{Area} = \\left( \\frac{\\alpha + \\beta + \\gamma - 180^\\circ}{180^\\circ} \\right) \\pi\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Consider a trirectangular spherical triangle with $\\alpha = 90^\\circ, \\beta = 90^\\circ, \\gamma = 90^\\circ$ on unit sphere $R=1$.\n• **Step 2:** Angle sum $= 90^\\circ + 90^\\circ + 90^\\circ = 270^\\circ$.\n• **Step 3:** Spherical excess $E = 270^\\circ - 180^\\circ = 90^\\circ = \\pi / 2$ radians.\n• **Step 4:** $\\text{Area} = 1^2 \\times (\\pi / 2) = \\pi / 2$, which is exactly $1/8$ of full sphere surface $4\\pi$!"
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In the Poincaré upper half-plane model, the hyperbolic distance between vertical points (0, y1) and (0, y2) equals |ln(y2 / ___)|.",
      "blankAnswer": "y1",
      "blankDistractors": ["y2", "x1", "1"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the area of a spherical triangle on a unit sphere ($R=1$) with angles $\\alpha = 100^\\circ, \\beta = 100^\\circ, \\gamma = 100^\\circ$ (in units of $\\pi$).",
      "numericAnswer": 0.6667,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the curvature $K$ of the Poincaré Disk model of hyperbolic geometry?",
      "options": [
        { "text": "Constant negative curvature K = -1", "isCorrect": true, "explanation": "Correct! Hyperbolic geometry has uniform negative curvature -1." },
        { "text": "Constant positive curvature K = +1", "isCorrect": false, "explanation": "Incorrect: That describes spherical geometry." },
        { "text": "Zero curvature K = 0", "isCorrect": false, "explanation": "Incorrect: That describes Euclidean geometry." },
        { "text": "Variable curvature depending on position", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
