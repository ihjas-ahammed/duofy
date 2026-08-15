# Duofy Reusable Lesson Format: Banach and Hilbert Spaces - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Functional_Analysis / Banach_and_Hilbert_Spaces`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of dual spaces ($(\ell^p)^* \cong \ell^q$, $(L^p)^* \cong L^q$), Banach space core pillars (Hahn-Banach, Open Mapping, Closed Graph, Uniform Boundedness), and interactive Hilbert projection widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Dual Space Pairing Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Theorem & Core Consequence Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Closed Graph Theorem Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Complete Space Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Hilbert Space Projection Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the dual space of the Banach space ell^p for 1 < p < infinity, and how is it related to p?",
      "blankAnswer": "(ell^p)* is isometrically isomorphic to ell^q, where 1/p + 1/q = 1 (Holder conjugate)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each foundational theorem of functional analysis to its primary consequence.",
      "matchPairs": [
        { "left": "Hahn-Banach Theorem", "right": "Guarantees existence of non-trivial continuous linear functionals" },
        { "left": "Uniform Boundedness Principle", "right": "Pointwise boundedness of operators implies uniform norm boundedness" },
        { "left": "Open Mapping Theorem", "right": "Continuous linear bijections between Banach spaces have continuous inverses" },
        { "left": "Closed Graph Theorem", "right": "Linear operators with closed graphs between Banach spaces are bounded" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Under what condition does the Closed Graph Theorem guarantee that a linear operator T: X -> Y between Banach spaces is bounded?",
      "options": [
        { "text": "If whenever x_n -> x and Tx_n -> y, it follows that Tx = y (the graph is closed)", "isCorrect": true, "explanation": "Correct! A closed graph guarantees boundedness without needing to check all Cauchy sequences directly." },
        { "text": "If T is a compact operator", "isCorrect": false, "explanation": "Incorrect: Compactness is stronger than boundedness." },
        { "text": "If X is finite-dimensional", "isCorrect": false, "explanation": "Incorrect: It applies to all Banach spaces." },
        { "text": "If T has zero kernel", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What name is given to a complete normed vector space named after the Polish mathematician Stefan?",
      "blankAnswer": "banach"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Orthogonal Projection in Hilbert Space",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Orthogonal Projection H = M ⊕ M^⊥</h3><p>Click 'Project' to drop perpendicular onto subspace M:</p><button id=\"projBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Compute P_M(x)</button><div id=\"projOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('projBtn').onclick=()=>{document.getElementById('projOut').innerText='Projection P_M(x) found! ||x - P_M(x)|| is strictly minimized, with x - P_M(x) in M^⊥.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
