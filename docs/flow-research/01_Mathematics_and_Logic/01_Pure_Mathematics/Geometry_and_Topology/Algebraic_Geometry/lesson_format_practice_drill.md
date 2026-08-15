# Duofy Reusable Lesson Format: Algebraic Geometry - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Algebraic_Geometry`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for Geometry-Algebra Duality dictionary terms, Nullstellensatz identities, Zariski open/closed definitions, and interactive elliptic curve addition visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Nullstellensatz Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Geometry-Algebra Dictionary Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Scheme Spec Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Ring Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Elliptic Curve Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Nullstellensatz formula for I(V(I)) over algebraically closed field k?",
      "blankAnswer": "I(V(I)) = sqrt(I) (the radical of ideal I)"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each algebraic variety property to its ring condition.",
      "matchPairs": [
        { "left": "Irreducible Variety", "right": "Prime Ideal P" },
        { "left": "Point in Affine Variety", "right": "Maximal Ideal m" },
        { "left": "Projective Variety", "right": "Homogeneous Ideal I in k[x0, ..., xn]" },
        { "left": "Function Field k(V)", "right": "Fraction Field of Coordinate Ring k[V]" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In an elliptic curve equation $y^2 = x^3 + a x + b$ over field $k$, what condition on discriminant $\\Delta = -16(4a^3 + 27b^2)$ guarantees the curve is **smooth** (non-singular)?",
      "options": [
        { "text": "Discriminant Δ ≠ 0", "isCorrect": true, "explanation": "Correct! Δ ≠ 0 guarantees distinct roots and no singular cusps or nodes." },
        { "text": "Discriminant Δ = 0", "isCorrect": false, "explanation": "Incorrect: Δ = 0 creates a singular point (cusp or node)." },
        { "text": "a = 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "b = 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What term describes a ringed space (X, O_X) locally isomorphic to Spec R for commutative rings R?",
      "blankAnswer": "scheme"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Elliptic Curve Group Law",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Elliptic Curve Point Addition P + Q = R</h3><p>Draw secant line through P and Q on y^2 = x^3 - x + 1 to find third intersection R':</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Reflect R' across x-axis to get R</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Point addition P + Q on elliptic curves reflects the 3rd intersection R\' across x-axis!'); };</script></div>"
    }
  ]
}
```
