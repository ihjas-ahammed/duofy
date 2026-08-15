# Duofy Reusable Lesson Format: Curves and Surfaces in R3 - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Differential_Geometry / Curves_and_Surfaces_in_R3`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of Gaussian curvature signs across surface geometries, Frenet frame relations ($\frac{dT}{ds} = \kappa N$, $\frac{dB}{ds} = -\tau N$), Gauss-Bonnet total curvature integrals, and interactive surface curvature simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gauss-Bonnet Closed Surface Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Surface Geometry & Curvature Characteristics Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Planar Space Curve Torsion Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Shape Operator Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Surface Curvature Explorer Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "State the global Gauss-Bonnet formula for a compact oriented 2D surface M of genus g without boundary.",
      "blankAnswer": "iint_M K dA = 2pi chi(M) = 4pi (1 - g), where K is the Gaussian curvature and g is the number of holes."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each surface to its Gaussian (K) and Mean (H) curvature properties.",
      "matchPairs": [
        { "left": "Helicoid", "right": "H = 0 (Minimal surface with ruled geometry)" },
        { "left": "Sphere of radius a", "right": "K = 1/a^2 and H = 1/a (Constant positive curvatures)" },
        { "left": "Circular Cylinder", "right": "K = 0 and H = 1/(2R) (Flat developable surface)" },
        { "left": "Pseudosphere (Tractroid)", "right": "K = -1/a^2 (Constant negative curvature surface)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "A regular space curve alpha(s) lies completely in a flat 2D plane if and only if which Frenet quantity vanishes identically?",
      "options": [
        { "text": "Torsion tau(s) = 0 everywhere (the binormal vector B is constant)", "isCorrect": true, "explanation": "Correct! Torsion measures deviation from the osculating plane. tau = 0 <=> the curve is planar." },
        { "text": "Curvature kappa(s) = 0 everywhere", "isCorrect": false, "explanation": "Incorrect: kappa = 0 means the curve is a straight line." },
        { "text": "Speed ||alpha'(s)|| = 0", "isCorrect": false, "explanation": "Incorrect: Speed must be positive for a regular curve." },
        { "text": "Arc length s = 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the German mathematician whose shape operator S = -dn relates the First and Second Fundamental Forms?",
      "blankAnswer": "weingarten"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Surface Curvature Visualizer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Surface Point Type: Saddle Point (z = x² - y²)</h3><p>Principal Curvatures: k_1 = +2 (Cup Up), k_2 = -2 (Cup Down)</p><button id=\"curvBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Compute Curvatures</button><div id=\"curvOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('curvBtn').onclick=()=>{document.getElementById('curvOut').innerText='Gaussian K = k_1 * k_2 = (+2)(-2) = -4.0 (Hyperbolic)! Mean H = (2 - 2)/2 = 0 (Minimal)!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
