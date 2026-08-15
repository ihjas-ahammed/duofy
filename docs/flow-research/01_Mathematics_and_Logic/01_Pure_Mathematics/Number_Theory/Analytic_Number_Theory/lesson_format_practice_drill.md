# Duofy Reusable Lesson Format: Analytic Number Theory - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Analytic_Number_Theory`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for Dirichlet series properties, Möbius function values, prime counting estimates, and interactive critical line zero visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Prime Number Theorem Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Arithmetic Function Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Riemann Zeta Pole Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Zeta Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Critical Line Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Prime Number Theorem formula for the prime counting function pi(x)?",
      "blankAnswer": "pi(x) ~ x / ln(x) as x -> infinity"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each arithmetic function to its generating Dirichlet series.",
      "matchPairs": [
        { "left": "Constant function 1(n) = 1", "right": "Riemann Zeta Function ζ(s)" },
        { "left": "Möbius function μ(n)", "right": "1 / ζ(s)" },
        { "left": "Euler Totient φ(n)", "right": "ζ(s - 1) / ζ(s)" },
        { "left": "Divisor Count d(n)", "right": "ζ(s)^2" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What are the **trivial zeros** of the Riemann Zeta Function $\\zeta(s)$?",
      "options": [
        { "text": "The negative even integers s = -2, -4, -6, ...", "isCorrect": true, "explanation": "Correct! Funtional equation implies ζ(s) = 0 for all negative even integers." },
        { "text": "The positive even integers s = 2, 4, 6", "isCorrect": false, "explanation": "Incorrect: ζ(2n) = π^(2n) * positive constants." },
        { "text": "All odd integers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "s = 1", "isCorrect": false, "explanation": "Incorrect: s = 1 is a pole, not a zero." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What name is given to the vertical line Re(s) = 1/2 in the complex plane where all non-trivial zeros of ζ(s) are conjectured to lie?",
      "blankAnswer": "critical"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Riemann Critical Line Inspector",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Critical Line Re(s) = 1/2</h3><p>Inspect first non-trivial zero s = 1/2 + i t:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Set t = 14.1347</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! First non-trivial zero occurs at s = 1/2 + 14.1347 i!'); };</script></div>"
    }
  ]
}
```
