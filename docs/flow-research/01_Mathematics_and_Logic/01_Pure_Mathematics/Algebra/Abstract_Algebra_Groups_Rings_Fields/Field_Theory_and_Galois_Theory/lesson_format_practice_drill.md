# Duofy Reusable Lesson Format: Field & Galois Theory - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Abstract_Algebra_Groups_Rings_Fields / Field_Theory_and_Galois_Theory`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for Galois group structures, extension degree calculations, dual lattice subfield-subgroup correspondences, and interactive field extension visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Galois Group Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Galois Group & Field Extension Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Separability / Normality Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Degree / Automorphism Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Dual Lattice Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Galois group Gal(Q(√2)/Q)?",
      "blankAnswer": "Z₂ (Cyclic group of order 2 with non-trivial automorphism √2 ↦ -√2)"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each field extension over Q to its exact Galois group.",
      "matchPairs": [
        { "left": "Q(√2, √3) / Q", "right": "Z₂ × Z₂ (Klein 4-group)" },
        { "left": "Splitting field of x³ - 2 over Q", "right": "S₃ (Symmetric group of order 6)" },
        { "left": "Q(e^(2πi/5)) / Q", "right": "Z₄ (Cyclic group of order 4)" },
        { "left": "Q(√2) / Q", "right": "Z₂ (Cyclic group of order 2)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Which extension of Q is NOT normal over Q?",
      "options": [
        { "text": "Q(∛2)", "isCorrect": true, "explanation": "Correct! Minimal polynomial x³-2 has complex roots ∛2 e^(2πi/3) not in Q(∛2) ⊂ R." },
        { "text": "Q(√2)", "isCorrect": false, "explanation": "Normal: degree 2 extension containing both ±√2." },
        { "text": "Q(i)", "isCorrect": false, "explanation": "Normal: contains both ±i." },
        { "text": "Q(√2, √3)", "isCorrect": false, "explanation": "Normal extension." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What name is given to an element whose field extension K = F(a) generates the entire field K?",
      "blankAnswer": "primitive"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Galois Lattice Diagram",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Dual Lattice Matcher</h3><p>Select subfield H corresponding to subfield Q(√2):</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Gal(K/Q(√2))</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Subfield Q(√2) maps to fixed subgroup Gal(K/Q(√2))!'); };</script></div>"
    }
  ]
}
```
