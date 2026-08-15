# Duofy Reusable Lesson Format: Functional Analysis - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Functional_Analysis`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for space classifications (Banach vs Hilbert), dual space identities, operator norm properties, and interactive Hilbert space projection visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Riesz Representation Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Function Space Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Operator Compactness Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Functional Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Hilbert Projection Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the continuous dual space of L^p[a,b] for 1 < p < ∞?",
      "blankAnswer": "L^q[a,b] where 1/p + 1/q = 1"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each space to its dual space identity.",
      "matchPairs": [
        { "left": "(ℓ^1)*", "right": "ℓ^∞" },
        { "left": "(c_0)*", "right": "ℓ^1" },
        { "left": "(H)* for Hilbert space H", "right": "H (Self-dual by Riesz Representation)" },
        { "left": "(L^1)*", "right": "L^∞" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the defining property of a Compact Operator $T: X \\to Y$?",
      "options": [
        { "text": "It maps bounded sets in X into relatively compact sets in Y", "isCorrect": true, "explanation": "Correct! Every bounded sequence (x_n) has a subsequence such that (T x_n_k) converges in Y." },
        { "text": "It is invertible", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Its kernel is {0}", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Its norm is 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What name is given to a complete normed vector space?",
      "blankAnswer": "banach"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Hilbert Space Projection Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Hilbert Space Projection P_M(x)</h3><p>Select point x₀ on closed convex set M that minimizes ||x - x₀||:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Minimize distance ||x - x₀||</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Hilbert Space Projection Theorem guarantees unique closest point x₀ in closed convex M!'); };</script></div>"
    }
  ]
}
```
