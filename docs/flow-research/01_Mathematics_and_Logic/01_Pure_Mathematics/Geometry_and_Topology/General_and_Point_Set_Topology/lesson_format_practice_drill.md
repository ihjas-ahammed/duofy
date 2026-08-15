# Duofy Reusable Lesson Format: Point-Set Topology - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / General_and_Point_Set_Topology`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for topological definitions, separation axioms, compactness conditions, and interactive open neighborhood visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Continuity Definition Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Topological Property Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Connectedness Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Open Cover Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Neighborhood Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the topological definition of a compact space X?",
      "blankAnswer": "Every open cover of X has a finite subcover."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each topological space to its exact property classification.",
      "matchPairs": [
        { "left": "Sierpiński Space", "right": "T0 space that is NOT T1" },
        { "left": "Co-finite Topology on infinite set", "right": "T1 space that is NOT T2 (Hausdorff)" },
        { "left": "Metric Space (X, d)", "right": "Normal T4 space (and Hausdorff T2)" },
        { "left": "Discrete Topology", "right": "Every subset is both open and closed (clopen)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Is the continuous image of a connected topological space $X$ under $f: X \\to Y$ always connected?",
      "options": [
        { "text": "Yes, f(X) is always connected (Intermediate Value Theorem generalization)", "isCorrect": true, "explanation": "Correct! Connectedness is a topological property preserved under continuous maps." },
        { "text": "No, it becomes disconnected", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Only if Y is compact", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Only if f is injective", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What property describes a topological space X with a countable basis for its topology?",
      "blankAnswer": "second-countable"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Hausdorff Separation Visualizer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Hausdorff T₂ Separation</h3><p>Separate distinct points x and y by open neighborhoods U_x and U_y:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Shrink r < d(x,y)/2</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Choosing radii r < d(x,y)/2 creates disjoint open balls U_x ∩ U_y = ∅!'); };</script></div>"
    }
  ]
}
```
