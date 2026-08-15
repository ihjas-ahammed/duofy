# Duofy Reusable Lesson Format: Category Theory - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Category_Theory`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for category theory definitions, universal property formulations, limit/colimit dualities, and interactive commutative diagram visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Yoneda Lemma Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Limit vs Colimit Dual Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Adjoint Functor Monad Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Naturality Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Commutative Diagram Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the natural isomorphism formula for Adjoint Functors L |- R?",
      "blankAnswer": "Hom_D(L(A), B) ≅ Hom_C(A, R(B))"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each categorical Limit to its dual Colimit.",
      "matchPairs": [
        { "left": "Product A × B", "right": "Coproduct A + B" },
        { "left": "Equalizer (Eq of f, g)", "right": "Coequalizer (Coeq of f, g)" },
        { "left": "Pullback (Fiber Product)", "right": "Pushout (Fiber Sum)" },
        { "left": "Terminal Object 1", "right": "Initial Object 0" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In functional programming (e.g. Haskell), what does a **Monad** represent?",
      "options": [
        { "text": "An endofunctor T equipped with unit return: A -> T A and bind (multiplication) join: T (T A) -> T A for sequencing side effects", "isCorrect": true, "explanation": "Correct! Monads in programming are formal monadic algebras encoding IO, state, and exceptions." },
        { "text": "A standard matrix array", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A loop counter", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A type error", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What term describes a family of morphisms η_A: F(A) -> G(A) making naturality squares commute for all f: A -> B?",
      "blankAnswer": "natural transformation"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Commutative Diagram Square",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Naturality Square Commutativity</h3><p>Verify η_B o F(f) = G(f) o η_A:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Check Path Equality</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Top-Right path equals Left-Bottom path: Square Commutes!'); };</script></div>"
    }
  ]
}
```
