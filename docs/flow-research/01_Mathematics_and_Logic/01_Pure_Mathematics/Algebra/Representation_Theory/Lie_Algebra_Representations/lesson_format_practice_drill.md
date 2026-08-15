# Duofy Reusable Lesson Format: Lie Algebra Representations - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Representation_Theory / Lie_Algebra_Representations`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recall of $\mathfrak{sl}_2(\mathbb{C})$ weight string distributions, Clebsch-Gordan decompositions, polynomial differential operator actions, and interactive ladder operator simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Weight String Symmetry Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Highest Weight & Weight String Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Differential Operator Realization Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Clebsch-Gordan Rule Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Ladder Operator Simulation Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the complete set of weights of the irreducible sl_2(C) representation V_3 (dimension 4)?",
      "blankAnswer": "{3, 1, -1, -3} (four 1-dimensional weight spaces, symmetric around 0)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each sl_2(C) irreducible representation to its dimension and weight string.",
      "matchPairs": [
        { "left": "V_0 (Trivial)", "right": "Dimension 1, Weights: {0}" },
        { "left": "V_1 (Standard 2D)", "right": "Dimension 2, Weights: {1, -1}" },
        { "left": "V_2 (Adjoint 3D)", "right": "Dimension 3, Weights: {2, 0, -2}" },
        { "left": "V_4", "right": "Dimension 5, Weights: {4, 2, 0, -2, -4}" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In the polynomial realization of sl_2(C) on C[x, y]_n, which differential operator corresponds to the raising operator e?",
      "options": [
        { "text": "e = x (d/dy)", "isCorrect": true, "explanation": "Correct! e(x^{n-k} y^k) = k x^{n-k+1} y^{k-1}, which increases the power of x and decreases the power of y (raising weight by +2)." },
        { "text": "e = y (d/dx)", "isCorrect": false, "explanation": "Incorrect: y(d/dx) is the lowering operator f." },
        { "text": "e = x (d/dx) - y (d/dy)", "isCorrect": false, "explanation": "Incorrect: That is the Cartan element h." },
        { "text": "e = d^2/dxdy", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What formula in quantum mechanics and representation theory decomposes the tensor product of two angular momentum representations?",
      "blankAnswer": "clebsch-gordan"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive sl_2(C) Weight Ladder Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>V_2 Weight Ladder (Weights: 2, 0, -2)</h3><div id=\"ladder\" style=\"padding:12px 24px; background:#1e293b; border-radius:8px; margin:15px 0; font-size:20px; font-weight:bold; color:#38bdf8;\">Current Weight: +2 (v_0)</div><div style=\"display:flex; gap:10px;\"><button id=\"fBtn\" style=\"padding:8px 16px; background:#ef4444; color:white; border:none; border-radius:6px; cursor:pointer;\">Apply Lowering f (-2)</button><button id=\"eBtn\" style=\"padding:8px 16px; background:#10b981; color:white; border:none; border-radius:6px; cursor:pointer;\">Apply Raising e (+2)</button></div><div id=\"status\" style=\"margin-top:10px; color:#fbbf24;\"></div><script>let w=2; document.getElementById('fBtn').onclick=()=>{if(w>-2){w-=2; document.getElementById('ladder').innerText='Current Weight: '+(w>0?'+'+w:w); document.getElementById('status').innerText=''; if(w===-2){document.getElementById('status').innerText='Reached lowest weight -2! f annihilates here.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');}}else{document.getElementById('status').innerText='f v_2 = 0 (annihilated!)';}}; document.getElementById('eBtn').onclick=()=>{if(w<2){w+=2; document.getElementById('ladder').innerText='Current Weight: '+(w>0?'+'+w:w); document.getElementById('status').innerText='';}else{document.getElementById('status').innerText='e v_0 = 0 (highest weight!)';}};</script></div>"
    }
  ]
}
```
