# Duofy Reusable Lesson Format: Graph Theory - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Graph_Theory`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for graph invariants, tree edge counts ($E = V - 1$), Eulerian/Hamiltonian conditions, and interactive graph coloring visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Euler Planar Formula Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Graph Family Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Eulerian Circuit Degree Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Tree Edge Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Graph 3-Coloring Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Euler's Planar Graph Formula relating vertices V, edges E, and faces F?",
      "blankAnswer": "V - E + F = 2"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each graph term to its exact chromatic number chi(G).",
      "matchPairs": [
        { "left": "Bipartite Graph K_{m,n}", "right": "χ(G) = 2" },
        { "left": "Complete Graph K_n", "right": "χ(G) = n" },
        { "left": "Odd Cycle C_5", "right": "χ(G) = 3" },
        { "left": "Planar Graph (Four Color Theorem)", "right": "χ(G) <= 4" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the necessary and sufficient condition for a connected graph to contain an **Eulerian Circuit** (closed trail visiting every edge once)?",
      "options": [
        { "text": "Every vertex in the graph must have an EVEN degree", "isCorrect": true, "explanation": "Correct! Euler proved Eulerian circuit exists iff all vertex degrees are even." },
        { "text": "The graph must be a tree", "isCorrect": false, "explanation": "Incorrect: Trees have leaves of degree 1 (odd)." },
        { "text": "The graph must be planar", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The graph must be bipartite", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "How many edges E does a connected tree graph with V vertices have?",
      "blankAnswer": "V - 1"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Graph 3-Coloring Sandbox",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Graph Vertex Coloring</h3><p>Color triangle C₃ vertices (no 2 adjacent same color):</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Apply Colors (Red, Green, Blue)</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Complete graph K₃ requires χ(G) = 3 distinct colors!'); };</script></div>"
    }
  ]
}
```
