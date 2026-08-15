# Duofy Reusable Lesson Format: Inner Product Spaces - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Linear_Algebra_and_Matrix_Theory / Inner_Product_Spaces`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for inner product axioms, Gram-Schmidt formula steps, function space inner products, and interactive vector projection visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Inner Product Axiom Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Function Space Inner Product Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Gram-Schmidt Step Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Norm Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Projection Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Cauchy-Schwarz Inequality?",
      "blankAnswer": "|<u, v>| <= ||u|| * ||v||"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each inner product space to its standard inner product definition.",
      "matchPairs": [
        { "left": "Euclidean Space R^n", "right": "<u, v> = u^T * v = sum(u_i * v_i)" },
        { "left": "Continuous Functions C[a,b]", "right": "<f, g> = Integral from a to b of f(x)g(x) dx" },
        { "left": "Complex Vector Space C^n", "right": "<u, v> = sum(u_i * conjugate(v_i))" },
        { "left": "Matrix Space M_{m x n}", "right": "<A, B> = Trace(A^T * B)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "If $\\mathbf{u}$ and $\\mathbf{v}$ are orthonormal vectors, what is $\\langle \\mathbf{u}, \\mathbf{v} \\rangle$?",
      "options": [
        { "text": "0", "isCorrect": true, "explanation": "Correct! Orthonormal implies orthogonal (<u, v> = 0) and unit length (||u|| = ||v|| = 1)." },
        { "text": "1", "isCorrect": false, "explanation": "Incorrect: <u, u> = 1, but <u, v> = 0 for distinct orthogonal vectors." },
        { "text": "-1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "2", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What term describes a set of vectors where every vector is orthogonal to every other vector and has unit length 1?",
      "blankAnswer": "orthonormal"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Vector Projection Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Vector Projection P_w(v)</h3><p>Adjust angle θ to 90 degrees to make projection equal 0:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Set θ = 90°</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! When θ = 90°, <u,v> = 0 and projection P_w(v) = 0!'); };</script></div>"
    }
  ]
}
```
