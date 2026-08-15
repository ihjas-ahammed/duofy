# Duofy Reusable Lesson Format: Real Analysis & Measure Theory - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Real_Analysis_and_Measure_Theory`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for modes of convergence ($L^p$ vs Almost Everywhere vs Uniform vs Measure), measure theory definitions, and interactive $\epsilon$-$\delta$ limit bound visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Convergence Mode Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Convergence Mode Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Dominated Convergence Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Lebesgue Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Epsilon-Delta Sandbox Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the defining condition for a sequence of functions (f_n) to converge Almost Everywhere (a.e.) to f?",
      "blankAnswer": "The set of points x where f_n(x) does NOT converge to f(x) has Lebesgue measure zero."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each mode of function convergence to its definition.",
      "matchPairs": [
        { "left": "Uniform Convergence", "right": "sup|f_n(x) - f(x)| -> 0 as n -> infinity" },
        { "left": "L^p Convergence", "right": "Integral |f_n - f|^p dm -> 0 as n -> infinity" },
        { "left": "Convergence in Measure", "right": "m({x : |f_n(x) - f(x)| > ε}) -> 0 for all ε > 0" },
        { "left": "Pointwise Convergence", "right": "f_n(x) -> f(x) for each x individually" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Does $L^1$ convergence $\\int |f_n - f| dm \\to 0$ imply pointwise convergence almost everywhere?",
      "options": [
        { "text": "Not necessarily pointwise a.e., but there exists a subsequence (f_n_k) that converges a.e.", "isCorrect": true, "explanation": "Correct! Standard counterexample is typing/sliding indicator blocks on [0,1]." },
        { "text": "Yes, always pointwise everywhere", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Yes, always uniform convergence", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "No, subsequence never converges", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the term for a continuous function defined on a compact interval [a, b] that maps sets of measure zero to sets of measure zero?",
      "blankAnswer": "absolutely"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Epsilon-Delta Limit Sandbox",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Epsilon-Delta Challenge</h3><p>Given ε = 0.1 for f(x)=2x at x=3, set δ ≤ 0.05:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Set δ = 0.05</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! |2x - 6| = 2|x - 3| < 2(0.05) = 0.1 = ε!'); };</script></div>"
    }
  ]
}
```
