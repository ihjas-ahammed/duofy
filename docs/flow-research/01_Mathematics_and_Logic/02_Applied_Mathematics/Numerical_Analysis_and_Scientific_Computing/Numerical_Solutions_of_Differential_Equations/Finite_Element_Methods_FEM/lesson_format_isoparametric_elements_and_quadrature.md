# Duofy Reusable Lesson Format: Isoparametric Mappings, Jacobians, and Gauss Quadrature

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing / Numerical_Solutions_of_Differential_Equations / Finite_Element_Methods_FEM`  
**Lesson Format Type:** `isoparametric_elements_and_quadrature`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Isoparametric Elements** (using the same shape functions $N_i(\xi, \eta)$ for geometry mapping $\mathbf{x}(\xi, \eta) = \sum N_i \mathbf{x}_i$ and solution interpolation $u(\xi, \eta) = \sum N_i u_i$), calculate the **Jacobian Matrix** $J$, execute **Gauss-Legendre Quadrature**, and interact with 2D quadrilateral mesh deformation simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Isoparametric Concept & Reference Element Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Element Family & Geometric Shape Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Jacobian Determinant Positivity Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Reference Coordinate Variable Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive 2D Mesh Quadrilateral Element Deformer Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "isoparametric_elements_and_quadrature",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the defining principle of an 'isoparametric' finite element formulation?",
      "blankAnswer": "The same set of basis shape functions N_i(xi, eta) is used to interpolate BOTH the physical geometry x(xi, eta) = sum N_i x_i and the field solution u(xi, eta) = sum N_i u_i from a standard reference element."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each finite element geometry to its standard reference domain and shape functions.",
      "matchPairs": [
        { "left": "Bilinear Quadrilateral (Q_1)", "right": "Square [-1, 1]^2 with 4 bilinear shape functions N_i = (1 +/- xi)(1 +/- eta)/4" },
        { "left": "Linear Triangle (P_1)", "right": "Unit triangle with barycentric area coordinates (xi, eta, 1 - xi - eta)" },
        { "left": "Quadratic Triangle (P_2)", "right": "6-node triangle with 3 vertex nodes and 3 mid-side nodes" },
        { "left": "Biquadratic Quadrilateral (Q_2)", "right": "9-node Lagrange or 8-node Serendipity element on [-1, 1]^2" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why must the determinant of the Jacobian matrix det(J) = det(partial(x, y) / partial(xi, eta)) be STRICTLY POSITIVE at every point within an isoparametric element?",
      "options": [
        { "text": "A positive det(J) > 0 ensures the geometric coordinate mapping is bijective and non-inverted (a non-positive determinant indicates element tangling or inside-out inverted mesh)", "isCorrect": true, "explanation": "Correct! If det(J) <= 0, the mapping from reference space to physical space folds over itself, causing severe singularities in gradient calculations." },
        { "text": "Because det(J) is always 1", "isCorrect": false, "explanation": "Incorrect: det(J) varies across distorted elements." },
        { "text": "Because negative areas are required in physics", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because quadrature requires zero determinants", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the German mathematician whose n-point quadrature rule integrates polynomials of degree up to 2n - 1 exactly?",
      "blankAnswer": "gauss"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Isoparametric Quadrilateral Mapping",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Isoparametric Reference Mapping</h3><p>Transforming Reference Square [-1, 1]^2 to Physical Quad:</p><button id=\"isoBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Compute det(J) at Center (0,0)</button><div id=\"isoOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('isoBtn').onclick=()=>{document.getElementById('isoOut').innerText='det(J) = 1.44 > 0! Element is valid, non-inverted, and ready for 2x2 Gauss-Legendre quadrature integration.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
