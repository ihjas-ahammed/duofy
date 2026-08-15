# Duofy Reusable Lesson Format: Euclidean & Non-Euclidean Geometry - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Euclidean_and_Non_Euclidean_Geometry`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through foundational geometric proofs: Girard's Theorem for Spherical Triangles, Hyperbolic Angle Defect Area Theorem, and Beltrami-Klein Model Isomorphism.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Girard's Spherical Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Proof Strategy & Lune Area Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Spherical Excess Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Hyperbolic Area Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Angle Excess Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Girard's Theorem for Spherical Triangles**\nOn a sphere of radius $R$, the area of a spherical triangle with interior angles $\\alpha, \\beta, \\gamma$ (in radians) is given by:\n$$\n\\text{Area}(T) = R^2 (\\alpha + \\beta + \\gamma - \\pi)\n$$\nThe quantity $E = \\alpha + \\beta + \\gamma - \\pi$ is called the **spherical excess**."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove Girard's Theorem using spherical lunes.",
      "orderItems": [
        "Construct great circles containing the 3 sides of the spherical triangle T.",
        "Identify 3 pairs of antipodal lunes L_α, L_β, L_γ with areas 4 R² α, 4 R² β, 4 R² γ.",
        "Sum of lune areas covers the entire sphere surface area 4π R² plus 4 times area(T).",
        "Equation: 2(Area(L_α) + Area(L_β) + Area(L_γ)) - 4 Area(T) = 4π R².",
        "Simplify 4 R² (α + β + γ) - 4 Area(T) = 4π R² to yield Area(T) = R² (α + β + γ - π)."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What happens to the area of a hyperbolic triangle as its interior angles $\\alpha, \\beta, \\gamma \\to 0$ (an ideal triangle)?",
      "options": [
        { "text": "The area approaches a maximum finite value π (for K = -1)", "isCorrect": true, "explanation": "Correct! Ideal hyperbolic triangles have maximum finite area Area = π - (0+0+0) = π." },
        { "text": "The area approaches infinity", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The area approaches 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The area is negative", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Hyperbolic Metric Element in Upper Half-Plane",
      "interactiveSteps": [
        { "stepText": "In the Poincaré Upper Half-Plane model $\\mathbb{H}^2 = \\{ (x, y) \\in \\mathbb{R}^2 \\mid y > 0 \\}$, the Riemannian metric is $ds^2 = \\frac{dx^2 + dy^2}{y^2}$." },
        {
          "prompt": "What is the area element $dA$ in this model?",
          "options": [
            { "text": "dA = (1 / y²) dx dy", "isCorrect": true },
            { "text": "dA = dx dy", "isCorrect": false },
            { "text": "dA = y² dx dy", "isCorrect": false },
            { "text": "dA = (1 / y) dx dy", "isCorrect": false }
          ]
        },
        { "stepText": "Integrating $dA = \\frac{dx dy}{y^2}$ over ideal hyperbolic triangles yields exact area $\\pi - (\\alpha + \\beta + \\gamma)$!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the term for the quantity E = α + β + γ - π in spherical geometry?",
      "blankAnswer": "excess"
    }
  ]
}
```
