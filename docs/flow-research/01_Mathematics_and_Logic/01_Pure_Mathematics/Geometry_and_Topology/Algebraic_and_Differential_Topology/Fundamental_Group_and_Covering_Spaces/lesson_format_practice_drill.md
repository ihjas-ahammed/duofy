# Duofy Reusable Lesson Format: Fundamental Group and Covering Spaces - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Algebraic_and_Differential_Topology / Fundamental_Group_and_Covering_Spaces`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of fundamental groups of standard spaces ($\pi_1(S^n) = 0$ for $n \ge 2$, $\pi_1(T^n) = \mathbb{Z}^n$), Galois covering correspondences, deck transformation actions, and interactive covering space unrolling simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Higher Sphere Fundamental Group Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Topological Space & Universal Cover Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Subgroup Index Covering Sheet Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Amalgamated Product Theorem Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Circle Unwrapping Covering Simulator | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the fundamental group pi_1(S^n) of the n-dimensional sphere for any n >= 2?",
      "blankAnswer": "pi_1(S^n) is the trivial group {0} (simply connected) for all n >= 2."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each base topological space X to its simply connected universal covering space.",
      "matchPairs": [
        { "left": "Circle S^1", "right": "Real Line R (Covering map t -> e^{2pi i t})" },
        { "left": "Torus T^2 = S^1 x S^1", "right": "Plane R^2" },
        { "left": "Real Projective Space RP^n (n >= 2)", "right": "Sphere S^n (Antipodal 2-sheeted cover)" },
        { "left": "Figure-Eight S^1 v S^1", "right": "Infinite 4-regular Cayley tree of F_2" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In the Galois correspondence of covering spaces, what does the index [pi_1(X) : H] of a subgroup H correspond to geometrically?",
      "options": [
        { "text": "The number of sheets (cardinality of every fiber p^{-1}(x)) of the covering space p: X_H -> X", "isCorrect": true, "explanation": "Correct! An index-k subgroup corresponds to an exact k-sheeted covering space." },
        { "text": "The topological dimension of X", "isCorrect": false, "explanation": "Incorrect: The dimension is unchanged." },
        { "text": "The number of connected components of X", "isCorrect": false, "explanation": "Incorrect: X is assumed connected." },
        { "text": "The Euler characteristic", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "Whose hyphenated theorem computes the fundamental group of a union of open sets using free products with amalgamation?",
      "blankAnswer": "van kampen"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Covering Space Unroller",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Covering Space: p: R -> S^1 (t -> e^{2πit})</h3><p>Current Point in R: <span id=\"rPt\" style=\"color:#38bdf8; font-weight:bold;\">t = 0.00</span></p><button id=\"liftBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Wind +1 Loop around S^1</button><script>let t=0; document.getElementById('liftBtn').onclick=()=>{t += 1; document.getElementById('rPt').innerText='t = ' + t.toFixed(2) + ' (Lifts loop to integer level ' + t + ')'; if(t===3 && window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
