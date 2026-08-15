# Duofy Reusable Lesson Format: Euclidean & Non-Euclidean Geometry - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Euclidean_and_Non_Euclidean_Geometry`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for curvature classifications ($K=0, K>0, K<0$), parallel line properties, spherical excess vs hyperbolic defect, and interactive Poincaré disk visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Geometry Comparison Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Geometric Metric Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Parallel Postulate Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Curvature Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Poincaré Disk Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the formula for the area of a hyperbolic triangle with angles α, β, γ?",
      "blankAnswer": "Area = π - (α + β + γ) (for curvature K = -1)"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each geometry to its characteristic metric element ds^2.",
      "matchPairs": [
        { "left": "Euclidean Plane", "right": "ds^2 = dx^2 + dy^2" },
        { "left": "Poincaré Upper Half-Plane", "right": "ds^2 = (dx^2 + dy^2) / y^2" },
        { "left": "Spherical Surface", "right": "ds^2 = dθ^2 + sin^2(θ) dφ^2" },
        { "left": "Poincaré Disk Model", "right": "ds^2 = 4 (dx^2 + dy^2) / (1 - (x^2+y^2))^2" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In spherical geometry, what play the role of 'straight lines' (geodesics)?",
      "options": [
        { "text": "Great circles (intersections of sphere with planes passing through center)", "isCorrect": true, "explanation": "Correct! Great circles are the shortest paths on a sphere." },
        { "text": "Small circles of constant latitude", "isCorrect": false, "explanation": "Incorrect: Latitudes except the equator are not geodesics." },
        { "text": "Straight line segments in 3D", "isCorrect": false, "explanation": "Incorrect: They leave the sphere surface." },
        { "text": "Parabolas", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What term describes the difference between 180° (π) and the sum of angles of a hyperbolic triangle?",
      "blankAnswer": "defect"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Poincaré Disk Geodesic Visualizer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Poincaré Disk Parallel Lines</h3><p>Select point P to draw multiple hyperparallel geodesics to line L:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Draw Hyperparallel Lines</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! In hyperbolic geometry, infinitely many non-intersecting parallel geodesics pass through P!'); };</script></div>"
    }
  ]
}
```
