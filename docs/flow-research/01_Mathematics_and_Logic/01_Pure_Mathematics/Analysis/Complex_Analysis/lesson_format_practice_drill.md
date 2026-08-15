# Duofy Reusable Lesson Format: Complex Analysis - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for Cauchy-Riemann equations, residue formulas, singularity classifications, and interactive contour deformation visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cauchy's Theorem Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Singularity Classification Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Harmonic Conjugate Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Residue Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Contour Deformation Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Cauchy's Integral Formula for f(z₀)?",
      "blankAnswer": "f(z₀) = (1 / 2πi) ∮ [f(z) / (z - z₀)] dz"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each complex function to its singularity type at z = 0.",
      "matchPairs": [
        { "left": "sin(z) / z", "right": "Removable Singularity at z = 0" },
        { "left": "1 / z^3", "right": "Pole of Order 3 at z = 0" },
        { "left": "e^(1/z)", "right": "Essential Singularity at z = 0" },
        { "left": "ln(z)", "right": "Branch Point Singularity at z = 0" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "If $u(x,y) = x^2 - y^2$, what is its harmonic conjugate $v(x,y)$ such that $f(z) = u + iv$ is holomorphic?",
      "options": [
        { "text": "v(x,y) = 2xy + C", "isCorrect": true, "explanation": "Correct! du/dx = 2x = dv/dy and du/dy = -2y = -dv/dx yields v = 2xy + C." },
        { "text": "v(x,y) = x² + y²", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "v(x,y) = -2xy", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "v(x,y) = x - y", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What complex analysis term describes a function that is holomorphic everywhere on the entire complex plane C?",
      "blankAnswer": "entire"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Contour Deformation Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Contour Rubber-Band Deformation</h3><p>Deform contour γ around pole z = i without crossing it:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Deform to Circle r=0.5</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Deforming contour without crossing poles preserves ∮ f(z) dz = 2πi Res(f, i)!'); };</script></div>"
    }
  ]
}
```
