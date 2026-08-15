# Duofy Reusable Lesson Format: Numerical Analysis - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for matrix factorization rules (LU, QR, SVD), ODE integration orders, numerical stability conditions, and interactive root-finding visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Condition Number Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Matrix Factorization Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | ODE Stiffness Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Factorization Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Newton Root Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the formula for Newton-Raphson iteration x_{k+1}?",
      "blankAnswer": "x_{k+1} = x_k - f(x_k) / f'(x_k)"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each numerical matrix factorization to its structure.",
      "matchPairs": [
        { "left": "LU Decomposition", "right": "A = L U (Lower triangular L with 1s, Upper triangular U)" },
        { "left": "QR Decomposition", "right": "A = Q R (Orthogonal Q, Upper triangular R)" },
        { "left": "Singular Value Decomposition (SVD)", "right": "A = U Σ V^T (Orthogonal U, V, Diagonal singular values Σ)" },
        { "left": "Cholesky Decomposition", "right": "A = L L^T (For Symmetric Positive-Definite matrices A)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why are **implicit ODE solvers** (like Backward Euler) required when integrating stiff differential equations?",
      "options": [
        { "text": "Implicit solvers possess large or unconditional stability regions, avoiding tiny step-size constraints", "isCorrect": true, "explanation": "Correct! Explicit solvers explode unless step-size h is restricted by fastest decay scale." },
        { "text": "Explicit solvers are too slow to evaluate", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Implicit solvers require no matrix inverses", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Stiff equations have no solutions", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What theorem states that for a well-posed PDE initial value problem, a consistent difference scheme is convergent if and only if it is stable?",
      "blankAnswer": "lax"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Newton-Raphson Visualizer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Newton-Raphson Root Finding</h3><p>Click to iterate tangent line x_1 = 1.0 - f(1.0)/f'(1.0):</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Iterate to x₁ = 1.5</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Tangent line at x₀=1 intersects x-axis at x₁=1.5!'); };</script></div>"
    }
  ]
}
```
