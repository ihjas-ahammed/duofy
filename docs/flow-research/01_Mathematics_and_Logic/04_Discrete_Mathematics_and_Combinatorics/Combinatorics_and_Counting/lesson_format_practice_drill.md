# Duofy Reusable Lesson Format: Combinatorics & Counting - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Combinatorics_and_Counting`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for Binomial coefficient formulas, Catalan sequence numbers ($1, 1, 2, 5, 14, 42, 132, \dots$), derangement counts, and interactive valid parentheses visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Binomial Identity Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Counting Formula Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Pigeonhole Principle Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Sequence Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Catalan Parentheses Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the formula for Catalan numbers C_n?",
      "blankAnswer": "C_n = (1 / (n + 1)) * (2n choose n)"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each n value to its exact Catalan number C_n.",
      "matchPairs": [
        { "left": "n = 0", "right": "C_0 = 1" },
        { "left": "n = 1", "right": "C_1 = 1" },
        { "left": "n = 2", "right": "C_2 = 2" },
        { "left": "n = 3", "right": "C_3 = 5" },
        { "left": "n = 4", "right": "C_4 = 14" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "How many people must be in a room to guarantee that at least two of them were born in the same month?",
      "options": [
        { "text": "13 people (by Pigeonhole Principle, 13 items into 12 months guarantees ≥ 2)", "isCorrect": true, "explanation": "Correct! PHP: 13 > 12 months, so at least 2 share a month." },
        { "text": "12 people", "isCorrect": false, "explanation": "Incorrect: All 12 could have different birth months." },
        { "text": "24 people", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "365 people", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What term describes a permutation of items such that no element appears in its original position?",
      "blankAnswer": "derangement"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Catalan Parentheses Matcher",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Valid Parentheses (n=2)</h3><p>Select valid parenthesization string:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">(()) and ()()</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! C₂ = 2 valid parenthesizations: (()) and ()()!'); };</script></div>"
    }
  ]
}
```
