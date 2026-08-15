# Duofy Reusable Lesson Format: Canonical Forms - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Linear_Algebra_and_Matrix_Theory / Canonical_Forms_Jordan_and_Rational`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for Jordan block definitions, companion matrix rules, invariant factor vs elementary divisor relationships, and interactive Jordan block visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Jordan Block Definition Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Polynomial & Canonical Form Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Invariant Factor Divisibility Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Block Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Jordan Block Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What entries appear on the superdiagonal of a Jordan block J_k(λ)?",
      "blankAnswer": "Ones (1s)"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each canonical form concept to its structural property.",
      "matchPairs": [
        { "left": "Jordan Block J_k(λ)", "right": "Upper triangular with λ on diagonal and 1s above" },
        { "left": "Companion Matrix C(x^2 + a x + b)", "right": "[[0, -b], [1, -a]]" },
        { "left": "Elementary Divisors", "right": "Determine Jordan Canonical Form" },
        { "left": "Invariant Factors", "right": "Determine Rational Canonical Form" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "If the minimal polynomial of matrix $A$ equals its characteristic polynomial $m(x) = p(x)$, what can be said about its Rational Canonical Form?",
      "options": [
        { "text": "It consists of a single companion matrix C(p(x))", "isCorrect": true, "explanation": "Correct! When m(x) = p(x), there is only 1 invariant factor, so RCF is C(p(x))." },
        { "text": "It is a zero matrix", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It has no companion blocks", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It is strictly diagonal", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the term for a square block with 1s on subdiagonal and negated coefficients in the final column?",
      "blankAnswer": "companion"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Jordan Block Builder",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Jordan Block J₂(5)</h3><p>Select superdiagonal entry value:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">1</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Superdiagonal entries in Jordan blocks are always 1!'); };</script></div>"
    }
  ]
}
```
