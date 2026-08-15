# Duofy Reusable Lesson Format: Topological Spaces and Basis - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / General_and_Point_Set_Topology / Topological_Spaces_and_Basis`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of basis condition checks, topology comparison tests (finer vs coarser), countability hierarchy classifications, quotient gluing topologies, and interactive topology basis simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Subbasis Generation Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Topology Property & Countability Hierarchy Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Quotient Topology Circle Gluing Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Dense Countable Set Property Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Basis Intersection Verifier Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the difference between a Basis B and a Subbasis S for a topological space?",
      "blankAnswer": "A basis B generates open sets via arbitrary unions. A subbasis S is any collection covering X whose finite intersections form a basis for the topology."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each topological countability/density condition to its definition.",
      "matchPairs": [
        { "left": "First-Countable Space", "right": "Every point x has a countable local neighborhood basis" },
        { "left": "Second-Countable Space", "right": "The entire topology has a countable basis B" },
        { "left": "Separable Space", "right": "Contains a countable dense subset (like Q in R)" },
        { "left": "Lindelöf Space", "right": "Every open cover has a countable subcover" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Consider the interval [0, 1] with the quotient identification 0 ~ 1 identifying both endpoints. What topological space is the quotient [0, 1]/~ homeomorphic to?",
      "options": [
        { "text": "The circle S^1 = {z in C | |z| = 1}", "isCorrect": true, "explanation": "Correct! Gluing the two endpoints of a line segment produces the 1-dimensional circle S^1 with the standard quotient topology." },
        { "text": "The open interval (0, 1)", "isCorrect": false, "explanation": "Incorrect: S^1 is compact, while (0, 1) is not." },
        { "text": "A figure-eight space", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The real projective plane", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What adjective describes a topological space that contains a countable dense subset?",
      "blankAnswer": "separable"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Topology Basis Verifier",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Basis Axiom 2 Tester</h3><p>Intersecting intervals: B_1 = (1, 5) and B_2 = (3, 7). Point x = 4.0</p><button id=\"basisBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Find Basis Element B_3</button><div id=\"basisOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('basisBtn').onclick=()=>{document.getElementById('basisOut').innerText='B_1 ∩ B_2 = (3, 5). Choose B_3 = (3.5, 4.5) containing x = 4! Basis intersection axiom verified.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
