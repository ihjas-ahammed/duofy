# Duofy Reusable Lesson Format: Differential Geometry - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Differential_Geometry`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for Gaussian vs Mean curvature formulas, Gauss-Bonnet topological invariants, exterior form wedge products ($dx \wedge dy = -dy \wedge dx$), and interactive surface curvature visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gaussian Curvature Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Differential Form Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Geodesic Property Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Form Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Surface Curvature Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Gauss-Bonnet Theorem formula for a compact surface M without boundary?",
      "blankAnswer": "Integral K dA = 2π χ(M) = 2π (2 - 2g)"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each exterior calculus property to its rule.",
      "matchPairs": [
        { "left": "Wedge Anti-commutativity", "right": "dx ∧ dy = - dy ∧ dx" },
        { "left": "Nilpotent Derivative", "right": "d(d ω) = d^2 ω = 0" },
        { "left": "Exact Differential Form", "right": "ω = d η for some (k-1)-form η" },
        { "left": "Closed Differential Form", "right": "d ω = 0" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is a **Minimal Surface** in differential geometry?",
      "options": [
        { "text": "A surface with Mean Curvature H = 0 everywhere (minimizes surface area for boundary)", "isCorrect": true, "explanation": "Correct! Minimal surfaces (like soap films) have zero mean curvature H = (k₁ + k₂)/2 = 0." },
        { "text": "A surface with zero area", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A surface with K = 0", "isCorrect": false, "explanation": "Incorrect: That describes developable surfaces." },
        { "text": "A sphere", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What property describes differential form ω if d(ω) = 0?",
      "blankAnswer": "closed"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Surface Curvature Visualizer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Gaussian Curvature K Inspector</h3><p>Select surface type:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Saddle Surface (K < 0)</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Saddle surfaces have opposite principal curvatures k1 > 0 and k2 < 0, yielding K = k1 * k2 < 0!'); };</script></div>"
    }
  ]
}
```
