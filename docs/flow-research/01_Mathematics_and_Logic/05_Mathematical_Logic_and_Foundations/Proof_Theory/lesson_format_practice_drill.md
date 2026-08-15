# Duofy Reusable Lesson Format: Proof Theory - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Proof_Theory`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for formal proof system rules, Curry-Howard logic-programming equivalences, Cut-elimination properties, and interactive proof tree visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cut Elimination Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Curry-Howard Mapping Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Gödel First Incompleteness Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Subformula Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Sequent Proof Tree Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Curry-Howard Isomorphism parallel for Proof Normalization?",
      "blankAnswer": "Program Evaluation / Beta Reduction"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Logic connective to its Curry-Howard Type theory partner.",
      "matchPairs": [
        { "left": "Conjunction A ∧ B", "right": "Pair / Product Type (A × B)" },
        { "left": "Disjunction A ∨ B", "right": "Sum / Either Type (A + B)" },
        { "left": "Implication A -> B", "right": "Function Type (A -> B)" },
        { "left": "True Top ⊤", "right": "Unit Type ()" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What property of Cut-Free proofs in Gentzen's Sequent Calculus guarantees that every formula in a proof tree is a component of the final conclusion?",
      "options": [
        { "text": "The Subformula Property", "isCorrect": true, "explanation": "Correct! Cut-elimination ensures proofs are analytic, containing only subformulas of the conclusion." },
        { "text": "The Compactness Property", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The Completeness Property", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The Recursion Property", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What structural rule in sequent calculus Γ, A ⊢ Δ introduces intermediate lemma formulas A that Cut-elimination removes?",
      "blankAnswer": "cut"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Sequent Proof Tree Builder",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Gentzen Sequent Calculus</h3><p>Apply Ax axiom rule to initial sequent A ⊢ A:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Apply Identity Axiom (Ax)</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! A ⊢ A is a valid identity leaf axiom in Sequent Calculus LK!'); };</script></div>"
    }
  ]
}
```
