# Duofy Reusable Lesson Format: Euclidean & Non-Euclidean Geometry - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Euclidean_and_Non_Euclidean_Geometry`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Euclidean Geometry, Hyperbolic Geometry ($K < 0$, Poincaré Disk model), and Spherical Geometry ($K > 0$) by contrasting parallel line behavior and triangle angle sums.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Parallel Postulate & Geometry Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Curvature & Angle Sum Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Three Geometries Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Angle Defect Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Hyperbolic Line Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Euclid's Fifth Postulate (Parallel Postulate)**\nGiven a line $L$ and a point $P$ not on $L$:\n1. **Euclidean Geometry ($K = 0$):** Exactly **one** line through $P$ is parallel to $L$.\n2. **Hyperbolic Geometry ($K < 0$):** Infinitely **many** lines through $P$ are parallel to $L$.\n3. **Spherical Geometry ($K > 0$):** **No** parallel lines exist (all geodesics intersect)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Euclidean:** Triangle angles sum to $\\alpha + \\beta + \\gamma = 180^\\circ$.\n• **Hyperbolic:** Triangle angles sum to $< 180^\\circ$. Angle defect $\\text{Area} \\propto \\pi - (\\alpha + \\beta + \\gamma)$.\n• **Spherical:** Triangle angles sum to $> 180^\\circ$. Angle excess $\\text{Area} = R^2 (\\alpha + \\beta + \\gamma - \\pi)$.\n• **Poincaré Disk Model:** Geodesics are circular arcs orthogonal to the boundary circle."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each geometry to its triangle angle sum property.",
      "matchPairs": [
        { "left": "Euclidean Geometry", "right": "Angle sum ALWAYS equals 180°" },
        { "left": "Hyperbolic Geometry", "right": "Angle sum ALWAYS less than 180° (defect proportional to area)" },
        { "left": "Spherical Geometry", "right": "Angle sum ALWAYS greater than 180° (excess proportional to area)" },
        { "left": "Poincaré Half-Plane", "right": "Geodesics are vertical rays and semicircles orthogonal to real axis" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In hyperbolic geometry, the area of a triangle is directly proportional to its angle ___.",
      "blankAnswer": "defect",
      "blankDistractors": ["excess", "bisector", "sum"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In the Poincaré Disk model of hyperbolic geometry, what do 'lines' (geodesics) look like?",
      "options": [
        { "text": "Circular arcs that intersect the boundary disk at right angles (90°)", "isCorrect": true, "explanation": "Correct! Hyperbolic geodesics are orthogonal circular arcs to the boundary." },
        { "text": "Straight lines only", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Chords of the boundary circle", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Parabolas", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
