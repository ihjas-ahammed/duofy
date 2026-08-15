# Duofy Reusable Lesson Format: Differential Geometry - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Differential_Geometry`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through foundational differential geometry proofs: Gauss's Theorema Egregium, Global Gauss-Bonnet Theorem ($\iint_M K dA = 2\pi \chi(M)$), and Generalized Stokes' Theorem ($\int_{\partial M} \omega = \int_M d\omega$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gauss-Bonnet Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Proof Strategy & Geodesic Curvature Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Euler Characteristic Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Stokes' Theorem Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Topological Invariant Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The Global Gauss-Bonnet Theorem**\nLet $M$ be a compact, orientable 2-dimensional Riemannian manifold (surface) without boundary:\n$$\n\\iint_M K \\, dA = 2\\pi \\chi(M)\n$$\nwhere $K$ is the Gaussian curvature and $\\chi(M) = 2 - 2g$ is the Euler characteristic of genus $g$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove the Local Gauss-Bonnet Theorem for a simple region R.",
      "orderItems": [
        "Triangulate region R into geodesic triangles.",
        "Apply Gauss-Bonnet formula for a single geodesic triangle T: ∬_T K dA + ∑ (π - α_i) = 2π.",
        "Sum over all triangles T in triangulation of R.",
        "Cancel interior angle turns using vertex summation V and edge count E.",
        "Combine terms to yield ∬_R K dA + ∫_∂R k_g ds = 2π χ(R)."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the total Gaussian curvature integral $\\iint_M K \, dA$ for any smoothly deformed 2-sphere ($S^2$, genus $g=0$)?",
      "options": [
        { "text": "4π (since χ(S²) = 2, 2π * 2 = 4π)", "isCorrect": true, "explanation": "Correct! Regardless of shape deformations, total integral of K over a sphere is always 4π." },
        { "text": "0", "isCorrect": false, "explanation": "Incorrect: That describes a torus (g=1)." },
        { "text": "2π", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "8π", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Generalized Stokes' Theorem $\\int_{\\partial M} \\omega = \\int_M d\\omega$",
      "interactiveSteps": [
        { "stepText": "Let $M$ be an $n$-dimensional oriented smooth manifold with boundary $\\partial M$, and $\\omega$ an $(n-1)$-form." },
        {
          "prompt": "Applying exterior derivative $d$ to $(n-1)$-form $\\omega$ yields what degree form $d\\omega$?",
          "options": [
            { "text": "n-form (top degree form on M)", "isCorrect": true },
            { "text": "(n-2)-form", "isCorrect": false },
            { "text": "1-form", "isCorrect": false },
            { "text": "0-form", "isCorrect": false }
          ]
        },
        { "stepText": "Integrating top-form $d\\omega$ over $M$ equals integration of $\\omega$ over boundary $\\partial M$, unifying Fundamental Theorem of Calculus, Green's, and Divergence Theorems!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What topological integer χ(M) = V - E + F connects surface curvature to its genus number?",
      "blankAnswer": "euler"
    }
  ]
}
```
