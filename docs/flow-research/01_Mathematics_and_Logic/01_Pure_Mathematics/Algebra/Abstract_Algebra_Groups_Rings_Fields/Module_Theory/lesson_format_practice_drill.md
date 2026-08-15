# Duofy Reusable Lesson Format: Module Theory - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Abstract_Algebra_Groups_Rings_Fields / Module_Theory`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for module definitions, vector space vs module comparisons, invariant factor rules, and interactive module exact sequence visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Module Concept Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Module Property Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Exact Sequence / Torsion Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Anvil / Torsion Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Exact Sequence Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is a Torsion Submodule Tor(M)?",
      "blankAnswer": "The set of all elements m ∈ M such that r * m = 0 for some non-zero scalar r ∈ R."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each R-module to its exact classification.",
      "matchPairs": [
        { "left": "Z^3 over Z", "right": "Free Z-module of rank 3" },
        { "left": "Z_7 over Z", "right": "Torsion Z-module of rank 0" },
        { "left": "Q over Z", "right": "Torsion-free Z-module that is NOT free" },
        { "left": "F[x] over F[x]", "right": "Free F[x]-module of rank 1" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In a Short Exact Sequence $0 \\to A \\xrightarrow{f} B \\xrightarrow{g} C \\to 0$, what does exactness at $B$ imply?",
      "options": [
        { "text": "Image(f) = Kernel(g)", "isCorrect": true, "explanation": "Correct! Exactness at B means the image of incoming map f equals the kernel of outgoing map g." },
        { "text": "f is surjective", "isCorrect": false, "explanation": "Incorrect: Exactness at A means f is injective." },
        { "text": "g is injective", "isCorrect": false, "explanation": "Incorrect: Exactness at C means g is surjective." },
        { "text": "A is isomorphic to C", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What property describes an element m in an R-module M for which r * m = 0 for some non-zero scalar r?",
      "blankAnswer": "torsion"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Short Exact Sequence Splitting Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Short Exact Sequence 0 → A → B → C → 0</h3><p>Select condition for sequence to split: B ≅ A ⊕ C</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">C is Free R-module</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! By Splitting Lemma, if C is free, the exact sequence splits!'); };</script></div>"
    }
  ]
}
```
