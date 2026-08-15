# Duofy Reusable Lesson Format: Set Theory & Axiomatics - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Set_Theory_and_Axiomatics`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for ZFC axioms, ordinal/cardinal orderings, Continuum Hypothesis statements, and interactive transfinite ordinal clock visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cantor's Theorem Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | ZFC Equivalent Axiom Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Continuum Hypothesis Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Transfinite Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Ordinal Sequence Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the relation between set A and its power set P(A) cardinality?",
      "blankAnswer": "|A| < |P(A)| = 2^{|A|}"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Set Theory concept to its independence or consistency result.",
      "matchPairs": [
        { "left": "Gödel (1938)", "right": "Proved CH is CONSISTENT with ZF using Constructible Universe L" },
        { "left": "Cohen (1963)", "right": "Proved ~CH is CONSISTENT with ZFC using Forcing technique" },
        { "left": "Cantor (1874)", "right": "Proved real numbers R are uncountably infinite (|R| > |N|)" },
        { "left": "Zermelo (1904)", "right": "Proved Well-Ordering Theorem using Axiom of Choice" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the **Continuum Hypothesis (CH)** assertion?",
      "options": [
        { "text": "2^{aleph_0} = aleph_1 (there is no cardinal size strictly between aleph_0 and c)", "isCorrect": true, "explanation": "Correct! CH asserts the cardinality of R is the immediate successor of N." },
        { "text": "2^{aleph_0} = aleph_0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "AC is false", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "R is countable", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What transfinite set construction omega = {0, 1, 2, ...} represents the smallest limit ordinal?",
      "blankAnswer": "omega"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Ordinal Sequence Inspector",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Transfinite Ordinals</h3><p>Step past infinity to first limit ordinal ω = {0, 1, 2, ...}:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Step to ω + 1</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Ordinal ω + 1 = {0, 1, 2, ..., ω} has a maximum element ω!'); };</script></div>"
    }
  ]
}
```
