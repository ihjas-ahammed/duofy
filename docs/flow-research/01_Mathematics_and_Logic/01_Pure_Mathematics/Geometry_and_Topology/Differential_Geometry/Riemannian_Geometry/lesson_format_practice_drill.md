# Duofy Reusable Lesson Format: Riemannian Geometry - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Differential_Geometry / Riemannian_Geometry`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of Riemannian metric properties, Christoffel connection symmetries ($\Gamma_{ij}^k = \Gamma_{ji}^k$), curvature tensor contractions, and interactive geodesic curvature simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cartan-Hadamard Manifold Topology Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Manifold Metric & Sectional Curvature Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Christoffel Symbol Index Symmetry Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Geodesic Acceleration Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Hyperbolic Geodesic Arc Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "State the Cartan-Hadamard Theorem for complete simply connected Riemannian manifolds with non-positive sectional curvature K <= 0.",
      "blankAnswer": "The exponential map exp_p: T_p M -> M is a global diffeomorphism for every p in M, so M is diffeomorphic to Euclidean space R^n (and all higher homotopy groups pi_k(M) = 0 for k >= 2)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Riemannian manifold to its constant sectional curvature K.",
      "matchPairs": [
        { "left": "Standard n-Sphere S^n of radius R", "right": "K = +1/R^2 > 0 (Constant positive curvature)" },
        { "left": "Hyperbolic n-Space H^n", "right": "K = -1 (Constant negative curvature)" },
        { "left": "Euclidean Space R^n", "right": "K = 0 (Flat space)" },
        { "left": "Flat Torus T^n = R^n / Z^n", "right": "K = 0 (Locally isometric to Euclidean space)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why are the Christoffel symbols of the Levi-Civita connection always symmetric in their lower two indices: Gamma_{ij}^k = Gamma_{ji}^k?",
      "options": [
        { "text": "Because the Levi-Civita connection has zero torsion: T(d/dx^i, d/dx^j) = nabla_i d/dx^j - nabla_j d/dx^i - [d/dx^i, d/dx^j] = 0", "isCorrect": true, "explanation": "Correct! Since [d/dx^i, d/dx^j] = 0, the zero-torsion condition forces (Gamma_{ij}^k - Gamma_{ji}^k) d/dx^k = 0, so Gamma_{ij}^k = Gamma_{ji}^k." },
        { "text": "Because all metrics are constant", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the manifold has dimension 2", "isCorrect": false, "explanation": "Incorrect: Symmetry holds in all dimensions." },
        { "text": "Because g^{ij} = 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the name of a smooth curve on a Riemannian manifold whose covariant acceleration vector is identically zero along the curve?",
      "blankAnswer": "geodesic"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Hyperbolic Geodesic Visualizer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Hyperbolic Upper Half Plane Geodesic Arc</h3><p>Shoot geodesic from point (0, 1) with horizontal velocity:</p><button id=\"geoBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Trace Geodesic Path</button><div id=\"geoOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('geoBtn').onclick=()=>{document.getElementById('geoOut').innerText='Geodesic traced: Semicircle of radius 1 centered at origin (0, 0) meeting real axis y = 0 at (+-1, 0) orthogonally!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
