# Duofy Reusable Lesson Format: Topology of Euclidean Spaces - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Real_Analysis / Topology_of_Euclidean_Spaces`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of open vs closed vs compact sets, limit point testing, Heine-Borel theorem checks, connectedness properties, and interactive metric ball simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Heine-Cantor Uniform Continuity Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Subset & Topological Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Dense Subset Boundary Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Topological Invariant Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Metric Open Ball Explorer Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the conclusion of the Heine-Cantor Theorem for a continuous function f: K -> R^m defined on a compact metric space K?",
      "blankAnswer": "f is uniformly continuous on K (continuity on a compact set automatically upgrades to uniform continuity)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each subset of R to its topological property.",
      "matchPairs": [
        { "left": "[0, infty)", "right": "Closed and Unbounded (Not Compact)" },
        { "left": "{1/n | n in N} union {0}", "right": "Compact (Contains its only limit point 0)" },
        { "left": "{1/n | n in N}", "right": "Not Compact (Missing limit point 0)" },
        { "left": "The Cantor Middle-Thirds Set", "right": "Compact, Uncountable, and Totally Disconnected" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the boundary of the set of rational numbers Q in the real line R?",
      "options": [
        { "text": "The entire real line R (since every real interval contains both rationals and irrationals)", "isCorrect": true, "explanation": "Correct! cl(Q) = R and int(Q) = empty set, so boundary(Q) = R \\ empty set = R." },
        { "text": "The rational numbers Q", "isCorrect": false, "explanation": "Incorrect: cl(Q) = R, not Q." },
        { "text": "The irrational numbers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The empty set", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What topological property describes a space that cannot be partitioned into two disjoint non-empty open sets?",
      "blankAnswer": "connectedness"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Metric Ball Inspector",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Open Set Tester: U = (1, 5)</h3><p>Pick point x = 3.0 in U:</p><button id=\"ballBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Find Open Ball B_r(3) in U</button><div id=\"ballOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('ballBtn').onclick=()=>{document.getElementById('ballOut').innerText='Radius r = min(3-1, 5-3) = 2.0. Ball (1, 5) is completely inside U! Open set condition verified.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
