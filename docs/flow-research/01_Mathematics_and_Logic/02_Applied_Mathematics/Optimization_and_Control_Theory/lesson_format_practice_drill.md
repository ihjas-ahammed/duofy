# Duofy Reusable Lesson Format: Optimization & Control Theory - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for KKT conditions, gradient descent update rules, LTI controllability/observability matrices, and interactive convex optimization visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | KKT Conditions Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Optimization Method Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Convex Function Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Controllability Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Convex Optimization Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the gradient descent iteration update rule?",
      "blankAnswer": "x_{k+1} = x_k - α * ∇f(x_k) (where α > 0 is step size)"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Control & Optimization concept to its defining formula.",
      "matchPairs": [
        { "left": "Controllability Matrix C", "right": "[B  AB  A^2 B  ...  A^(n-1) B]" },
        { "left": "Observability Matrix O", "right": "[C; CA; CA^2; ...; CA^(n-1)]" },
        { "left": "Gradient Descent Step", "right": "x_{k+1} = x_k - α ∇f(x_k)" },
        { "left": "LQR Cost Function J", "right": "Integral of (x^T Q x + u^T R u) dt" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Which property guarantees that a twice-differentiable function $f(x)$ is **strictly convex**?",
      "options": [
        { "text": "Hessian matrix ∇²f(x) is Positive Definite (all eigenvalues λ_i > 0) everywhere", "isCorrect": true, "explanation": "Correct! Positive definite Hessian guarantees strict convexity and a unique global minimum." },
        { "text": "Gradient ∇f(x) = 0 everywhere", "isCorrect": false, "explanation": "Incorrect: That describes a constant function." },
        { "text": "Hessian matrix is negative definite", "isCorrect": false, "explanation": "Incorrect: That describes a strictly concave function." },
        { "text": "f(x) is linear", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What matrix C = [B AB ... A^(n-1)B] must have full rank n for an LTI system to be controllable?",
      "blankAnswer": "controllability"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Convex Bowl Gradient Descent",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Gradient Descent on Bowl f(x) = x²</h3><p>Step down gradient from x₀ = 4.0 with α = 0.4:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Take Step -> x₁ = 0.8</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! x₁ = 4.0 - 0.4*(8.0) = 0.8 rapidly approaches global minimum at x* = 0!'); };</script></div>"
    }
  ]
}
```
