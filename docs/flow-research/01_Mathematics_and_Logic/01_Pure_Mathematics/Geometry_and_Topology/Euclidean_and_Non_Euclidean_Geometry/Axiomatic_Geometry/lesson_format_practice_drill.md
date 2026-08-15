# Duofy Reusable Lesson Format: Axiomatic Geometry - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Euclidean_and_Non_Euclidean_Geometry / Axiomatic_Geometry`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of Hilbert's axiom classifications (Incidence, Order, Congruence, Parallels, Continuity), neutral geometry valid theorems vs parallel-dependent theorems, Saccheri quadrilateral summit angle behaviors, and interactive axiomatic models.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Playfair's Axiom Equivalence Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Theorem Statement & Neutral Status Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Saccheri Summit Angle Hypothesis Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Plane Separation Axiom Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Hilbert Incidence Plane Model Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Playfair's Axiom, and what is its historical relationship to Euclid's 5th Postulate?",
      "blankAnswer": "Given a line l and a point P not on l, there exists at most one line through P parallel to l. It is logically equivalent to Euclid's 5th postulate within neutral geometry."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each geometric proposition to its validity in Neutral Geometry.",
      "matchPairs": [
        { "left": "Vertical angles are congruent", "right": "Valid in Neutral Geometry" },
        { "left": "Alternate interior angles are congruent for parallel lines", "right": "Requires Euclidean Parallel Postulate" },
        { "left": "Exterior Angle Theorem (angle ext > angle remote)", "right": "Valid in Neutral Geometry" },
        { "left": "Pythagorean Theorem a^2 + b^2 = c^2", "right": "Requires Euclidean Parallel Postulate" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In a Saccheri quadrilateral (base angles = 90 deg, vertical sides equal), what are the three historical hypotheses regarding summit angles C and D?",
      "options": [
        { "text": "Hypothesis of the Right Angle (Euclidean), Hypothesis of the Acute Angle (Hyperbolic), Hypothesis of the Obtuse Angle (Elliptic/Riemannian)", "isCorrect": true, "explanation": "Correct! Saccheri analyzed these three hypotheses; obtuse angles are ruled out in Archimedean neutral geometry, leaving acute (hyperbolic) and right (Euclidean)." },
        { "text": "All summit angles are always 45 degrees", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Summit angles must sum to 360 degrees", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The quadrilateral is not closed", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the German mathematician whose axiom states that a line entering a triangle through one side must exit through another?",
      "blankAnswer": "pasch"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive 4-Point Affine Plane Geometry Model",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Finite Incidence Model: 4 Points, 6 Lines</h3><p>Points: {A, B, C, D}. Lines: {AB, CD}, {AC, BD}, {AD, BC}</p><button id=\"modelBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Verify Playfair Parallelism</button><div id=\"modelOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('modelBtn').onclick=()=>{document.getElementById('modelOut').innerText='Line AB is parallel to line CD (no shared points). Line through point C parallel to AB is unique ({CD})! Playfair axiom holds in this 4-point model!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
