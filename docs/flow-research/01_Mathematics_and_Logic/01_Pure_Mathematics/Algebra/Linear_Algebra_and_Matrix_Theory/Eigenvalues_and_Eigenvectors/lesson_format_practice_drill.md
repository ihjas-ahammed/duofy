# Duofy Reusable Lesson Format: Eigenvalues & Eigenvectors - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Linear_Algebra_and_Matrix_Theory / Eigenvalues_and_Eigenvectors`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for matrix trace/determinant eigenvalue shortcuts, eigenspace dimensions, and interactive eigenvalue transformation visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Eigenvalue Equation Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Matrix Type Eigenvalue Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Algebraic vs Geometric Multiplicity Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Matrix Trace Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Transformation Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the relationship between the determinant det(A) and the eigenvalues λ_i of matrix A?",
      "blankAnswer": "det(A) equals the product of all eigenvalues: det(A) = λ₁ * λ₂ * ... * λₙ"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each matrix class to its eigenvalue property.",
      "matchPairs": [
        { "left": "Real Symmetric Matrix (A = A^T)", "right": "All eigenvalues are real; orthogonal eigenvectors" },
        { "left": "Skew-Symmetric Matrix (A = -A^T)", "right": "Eigenvalues are purely imaginary or zero" },
        { "left": "Orthogonal Matrix (Q^T Q = I)", "right": "Eigenvalues have absolute value |λ| = 1" },
        { "left": "Nilpotent Matrix (A^k = 0)", "right": "All eigenvalues are 0" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the relationship between algebraic multiplicity $a_i$ and geometric multiplicity $g_i$ of an eigenvalue?",
      "options": [
        { "text": "1 ≤ geometric multiplicity g_i ≤ algebraic multiplicity a_i", "isCorrect": true, "explanation": "Correct! Eigenspace dimension is at least 1 and at most the root multiplicity in characteristic polynomial." },
        { "text": "g_i > a_i always", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "g_i = a_i + 1 always", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "g_i = 0 always", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What matrix property equals the sum of its diagonal entries and also equals the sum of its eigenvalues?",
      "blankAnswer": "trace"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Eigenvector Scaling Visualizer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Eigenvector Scaling Simulator</h3><p>Adjust vector direction until A * v remains parallel to v:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Align to (1, 1)</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Vector (1, 1) is an eigenvector scaled by λ = 5!'); };</script></div>"
    }
  ]
}
```
