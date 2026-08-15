# Duofy Reusable Lesson Format: Algebraic Number Theory - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Algebraic_Number_Theory`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for quadratic field discriminants $d_K$, ideal class numbers $h_K$, unit group ranks, and interactive prime ideal splitting visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Dedekind Domain Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Quadratic Discriminant Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Fundamental Unit Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Ideal Class Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Prime Splitting Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the formula for Dirichlet's Unit Theorem rank of units in number field K?",
      "blankAnswer": "Rank = r₁ + r₂ - 1 (where r₁ is real embeddings, r₂ is complex conjugate pairs)"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each quadratic number field to its exact discriminant d_K.",
      "matchPairs": [
        { "left": "Q(i) with d = -1", "right": "d_K = -4" },
        { "left": "Q(√-3) with d = -3", "right": "d_K = -3 (d ≡ 1 mod 4)" },
        { "left": "Q(√5) with d = 5", "right": "d_K = 5 (d ≡ 1 mod 4)" },
        { "left": "Q(√2) with d = 2", "right": "d_K = 8 (4d)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the fundamental unit $\\epsilon$ of the real quadratic field $\\mathbb{Q}(\\sqrt{2})$?",
      "options": [
        { "text": "ε = 1 + √2 (norm N(1 + √2) = 1² - 2 = -1)", "isCorrect": true, "explanation": "Correct! (1+√2)(√2-1) = 1, generating all units ±(1+√2)^k." },
        { "text": "ε = 2 + √2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "ε = 1 + 2√2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "ε = √2", "isCorrect": false, "explanation": "Incorrect: √2 is not a unit in Z[√2]." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What name is given to an integral domain in which every non-zero ideal factors uniquely into prime ideals?",
      "blankAnswer": "dedekind"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Prime Ideal Splitting Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Prime Splitting in Z[i]</h3><p>Select prime p ≡ 1 mod 4 (e.g. p = 13):</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">13 = (3+2i)(3-2i)</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Primes p ≡ 1 mod 4 split into two conjugate prime ideals in Z[i]!'); };</script></div>"
    }
  ]
}
```
