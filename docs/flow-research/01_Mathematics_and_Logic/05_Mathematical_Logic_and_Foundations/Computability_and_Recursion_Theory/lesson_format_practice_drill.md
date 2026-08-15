# Duofy Reusable Lesson Format: Computability Theory - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Computability_and_Recursion_Theory`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for computability definitions, Rice's theorem application conditions, Turing degree jumps ($0, 0', 0''$), and interactive Turing Machine step simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Halting Problem Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Reducibility & Degrees Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Post's Problem Priority Method Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Quine Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Turing Machine Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the formal definition of the Halting Set K?",
      "blankAnswer": "K = { e in N | phi_e(e) halts }"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Turing degree to its representative undecidable problem.",
      "matchPairs": [
        { "left": "Degree 0", "right": "Decidable / Computable sets (e.g. Even numbers)" },
        { "left": "Degree 0'", "right": "The Halting Problem K" },
        { "left": "Degree 0''", "right": "The Finiteness Problem { e | Dom(phi_e) is finite }" },
        { "left": "Degree 0'''", "right": "The Totality Problem { e | phi_e is total computable }" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What was **Post's Problem** (1944) in recursion theory?",
      "options": [
        { "text": "Does there exist an r.e. Turing degree strictly between 0 and 0'? (0 <_T A <_T 0')", "isCorrect": true, "explanation": "Correct! Solved by Friedberg and Muchnik in 1956 using the Priority Method." },
        { "text": "Is P = NP?", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Are all Turing machines finite?", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Does 0 = 1?", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What term describes a program that takes no input and outputs an exact copy of its own source code?",
      "blankAnswer": "quine"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive 3-State Busy Beaver Turing Machine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Busy Beaver Simulator</h3><p>Step Turing Machine tape `[1, 1, 1, 0, ...]`:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Step TM State -> HALT</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Busy Beaver BB(3) writes 6 1s before halting!'); };</script></div>"
    }
  ]
}
```
