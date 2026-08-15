# Duofy Reusable Lesson Format: Continuity, Compactness, and Connectedness - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / General_and_Point_Set_Topology / Continuity_Compactness_Connectedness`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of compactness preservation under continuous maps, separation axioms ($T_0 \to T_4$), Tychonoff product compactness, connectedness criteria, and interactive topological separation simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Tietze Extension Theorem Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Separation Axiom & Characteristic Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Tychonoff Infinite Product Topology Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Extreme Value Theorem Bound Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Urysohn Continuous Function Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Tietze Extension Theorem for normal topological spaces?",
      "blankAnswer": "Any continuous real-valued function f: A -> [a, b] defined on a closed subset A of a normal space X can be continuously extended to a function F: X -> [a, b] on the entire space X."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each separation axiom to its topological definition.",
      "matchPairs": [
        { "left": "T_1 Space (Fréchet)", "right": "Every singleton point {x} is a closed set" },
        { "left": "T_2 Space (Hausdorff)", "right": "Any two distinct points have disjoint open neighborhoods" },
        { "left": "T_3 Space (Regular + T_1)", "right": "Every point and disjoint closed set have disjoint open neighborhoods" },
        { "left": "T_4 Space (Normal + T_1)", "right": "Any two disjoint closed sets have disjoint open neighborhoods" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the infinite product of unit intervals [0, 1]^I compact under the Product Topology, but NOT under the Box Topology?",
      "options": [
        { "text": "Tychonoff's Theorem guarantees compactness for the product topology (finite restrictions), whereas the box topology has far too many open sets, allowing infinite covers without finite subcovers", "isCorrect": true, "explanation": "Correct! The box topology is strictly finer than the product topology and fails to be compact for infinite products." },
        { "text": "[0, 1] is not compact", "isCorrect": false, "explanation": "Incorrect: [0, 1] is compact." },
        { "text": "Because the product is uncountable", "isCorrect": false, "explanation": "Incorrect: Tychonoff holds for arbitrary uncountable index sets I in the product topology." },
        { "text": "Because box topology has no open sets", "isCorrect": false, "explanation": "Incorrect: Box topology has more open sets than product topology." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "A continuous function from a compact topological space to the real line is guaranteed to achieve its global maximum and minimum because its image is compact and therefore ___.",
      "blankAnswer": "bounded"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Urysohn Separating Function Explorer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Normal Space Separation</h3><p>Closed Set A (Target 0.0) | Closed Set B (Target 1.0)</p><button id=\"uryBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Construct Urysohn Map f(x)</button><div id=\"uryOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('uryBtn').onclick=()=>{document.getElementById('uryOut').innerText='Urysohn function constructed: f(x) is continuous with f(A) = 0.0 and f(B) = 1.0 everywhere!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
