# Duofy Reusable Lesson Format: Hyperbolic and Elliptic Geometry - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Euclidean_and_Non_Euclidean_Geometry / Hyperbolic_and_Elliptic_Geometry`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of constant curvature properties, Poincaré Disk / Half-Plane geodesic shapes, spherical excess / hyperbolic defect calculations, and interactive Poincaré disk tessellation simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hyperbolic Law of Cosines Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Non-Euclidean Model & Metric Signature Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Triply Right-Angled Spherical Octant Area Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Boundary Horizon Point Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Poincaré Disk Geodesic Arc Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Hyperbolic Law of Cosines relating side lengths a, b, c and opposite angle C in H^2?",
      "blankAnswer": "cosh(c) = cosh(a) cosh(b) - sinh(a) sinh(b) cos(C)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each non-Euclidean model to its defining line/metric feature.",
      "matchPairs": [
        { "left": "Poincaré Disk Model", "right": "Conformal unit disk where geodesics are circular arcs orthogonal to the boundary" },
        { "left": "Klein-Beltrami Model", "right": "Non-conformal disk where geodesics are straight Euclidean chords" },
        { "left": "Poincaré Upper Half Plane", "right": "Conformal upper half plane y > 0 with metric ds^2 = (dx^2 + dy^2)/y^2" },
        { "left": "Riemann Sphere S^2", "right": "Lines are great circles with positive constant Gaussian curvature" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "On a unit sphere (R = 1), what is the area of an octant triangle whose three angles are all right angles (pi/2, pi/2, pi/2)?",
      "options": [
        { "text": "pi/2 (approx 1.57), since Area = 1^2 * (pi/2 + pi/2 + pi/2 - pi) = 3pi/2 - pi = pi/2", "isCorrect": true, "explanation": "Correct! 8 such octants cover the entire sphere of area 4pi: 8 * (pi/2) = 4pi." },
        { "text": "pi", "isCorrect": false, "explanation": "Incorrect: pi is the area of a hemisphere quadrant." },
        { "text": "4 pi", "isCorrect": false, "explanation": "Incorrect: 4 pi is the total sphere area." },
        { "text": "0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What adjective describes a hyperbolic triangle whose vertices all lie on the boundary circle at infinity?",
      "blankAnswer": "ideal"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Poincaré Disk Geodesic Visualizer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Poincaré Disk (Unit Disk |z| &lt; 1)</h3><p>Draw a hyperbolic geodesic between two boundary points (-1, 0) and (0, 1):</p><button id=\"diskBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Construct Orthogonal Geodesic</button><div id=\"diskOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('diskBtn').onclick=()=>{document.getElementById('diskOut').innerText='Geodesic constructed: Circular arc orthogonal to unit circle at (-1, 0) and (0, 1) passing through the interior!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
