# Duofy Reusable Lesson Format: Algebraic Combinatorics - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Algebraic_Combinatorics`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for partition diagrams, hook length formulas, matroid independent set properties, and interactive Young Tableau insertion visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | RSK Symmetry Identity Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Matroid Type Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Hook Length Hook Product Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Tableau Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive RSK Bumping Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Hook Length Formula for the number f^lambda of SYTs of shape lambda?",
      "blankAnswer": "f^lambda = n! / prod_{(i,j) in lambda} h(i, j)"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each matroid family to its ground set E and independent sets I.",
      "matchPairs": [
        { "left": "Graphic Matroid", "right": "Ground set = Graph Edges, Independent sets = Forests (acyclic subgraphs)" },
        { "left": "Vector Matroid", "right": "Ground set = Vector space vectors, Independent sets = Linearly independent subsets" },
        { "left": "Uniform Matroid U_{k,n}", "right": "Ground set = n elements, Independent subsets = Subsets of size <= k" },
        { "left": "Transversal Matroid", "right": "Ground set = Bipartite graph vertices, Independent sets = Matchable subsets" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In RSK correspondence $\\sigma \\leftrightarrow (P, Q)$, what happens to the tableau pair when the permutation is inverted ($\\sigma^{-1}$)?",
      "options": [
        { "text": "The insertion and recording tableaux swap roles: σ⁻¹ <-> (Q, P)", "isCorrect": true, "explanation": "Correct! Reversing the permutation transposes the pair (P,Q) -> (Q,P)." },
        { "text": "The shape becomes transposed λ'", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Tableau P becomes empty", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Number of boxes doubles", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What structural object M = (E, I) generalizes linear independence in vector spaces and acyclicity in graphs?",
      "blankAnswer": "matroid"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive RSK Row Bumping Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>RSK Row Insertion</h3><p>Insert x = 1 into tableau row [2, 4]:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Bump 2 to Row 2 -> [1, 4]</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! x=1 replaces smallest larger element 2 in row 1, bumping 2 to row 2!'); };</script></div>"
    }
  ]
}
```
