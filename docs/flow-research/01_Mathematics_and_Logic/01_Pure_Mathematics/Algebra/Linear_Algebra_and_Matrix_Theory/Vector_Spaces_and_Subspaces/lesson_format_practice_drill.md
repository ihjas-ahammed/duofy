# Duofy Reusable Lesson Format: Vector Spaces & Subspaces - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Linear_Algebra_and_Matrix_Theory / Vector_Spaces_and_Subspaces`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for matrix subspace definitions, rank-nullity calculations, orthogonal complement pairings, and interactive vector span visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Basis Definition Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Subspace Orthogonality Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Linear Independence Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Rank Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Vector Span Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Rank-Nullity Theorem formula for an m × n matrix A?",
      "blankAnswer": "Rank(A) + Nullity(A) = n (number of columns)"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each matrix subspace to its orthogonal complement.",
      "matchPairs": [
        { "left": "Nullspace N(A)", "right": "Row Space C(A^T) in R^n" },
        { "left": "Left Nullspace N(A^T)", "right": "Column Space C(A) in R^m" },
        { "left": "Row Space C(A^T)", "right": "Nullspace N(A) in R^n" },
        { "left": "Column Space C(A)", "right": "Left Nullspace N(A^T) in R^m" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Which condition guarantees that a set of $n$ vectors in $\\mathbb{R}^n$ forms a valid basis?",
      "options": [
        { "text": "The matrix formed by vectors as columns has non-zero determinant det(A) ≠ 0", "isCorrect": true, "explanation": "Correct! Non-zero determinant implies full rank n, hence linearly independent and spanning." },
        { "text": "All vectors are positive", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The vectors are orthogonal to the x-axis", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The sum of vectors is zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What term describes the maximum number of linearly independent columns in a matrix?",
      "blankAnswer": "rank"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive 2D Vector Span Visualizer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>2D Vector Span</h3><p>Adjust linear combination c1 * v1 + c2 * v2 to reach target (3, 4)</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Set c1=3, c2=4</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Non-collinear vectors v1=(1,0) and v2=(0,1) span all of R²!'); };</script></div>"
    }
  ]
}
```
