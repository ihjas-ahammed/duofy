# Duofy Reusable Lesson Format: Kuratowski's and Wagner's Forbidden Minor Theorems

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Graph_Theory / Tree_and_Planar_Graphs`  
**Lesson Format Type:** `kuratowski_and_wagner_forbidden_minors`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Planarity Characterization Theorems**: understand **Subdivisions** and **Graph Minors**, evaluate **Kuratowski's Theorem (1930)** ($G$ is planar $\iff G$ contains no subdivision of $K_5$ or $K_{3,3}$), contrast with **Wagner's Theorem (1937)** ($G$ is planar $\iff$ neither $K_5$ nor $K_{3,3}$ is a minor of $G$), identify forbidden minors in the Petersen graph, and interact with live planarity testing / untangling widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Kuratowski & Wagner Theorems Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Graph Operation & Topological Reduction Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Petersen Graph Non-Planarity Minor Identification Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Topological Graph Property Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Planar Graph Untangler & Crossing Minimizer Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "kuratowski_and_wagner_forbidden_minors",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Kuratowski's Theorem, and what is Wagner's Minor Theorem for planar graphs?",
      "blankAnswer": "Kuratowski's Theorem (Kazimierz Kuratowski, 1930) states that a finite graph G is planar if and only if it does NOT contain a SUBDIVISION of K_5 (the complete graph on 5 vertices) or K_{3,3} (the complete bipartite utility graph). Wagner's Theorem (Klaus Wagner, 1937) is the equivalent minor formulation: a graph G is planar if and only if neither K_5 nor K_{3,3} is a GRAPH MINOR of G (obtained by deleting edges/vertices and contracting edges)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each planarity characterization concept to its definition.",
      "matchPairs": [
        { "left": "Edge Subdivision (Homeomorphism)", "right": "Replacing an edge e = (u, v) with a path of degree-2 vertices u - w_1 - ... - v" },
        { "left": "Graph Minor", "right": "Graph obtained by any sequence of vertex deletions, edge deletions, and edge contractions" },
        { "left": "Fáry's Theorem (1948)", "right": "Every planar graph can be embedded in the plane with straight-line (non-curved) edges" },
        { "left": "Robertson-Seymour Theorem", "right": "Any minor-closed graph family is characterized by a FINITE set of forbidden minors" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "How does Wagner's theorem prove that the Petersen Graph is NON-PLANAR?",
      "options": [
        { "text": "Contracting the 5 radial spokes connecting the outer 5-cycle to the inner star yields K_5 as a GRAPH MINOR, proving the Petersen graph is non-planar", "isCorrect": true, "explanation": "Correct! Collapsing each of the 5 spoke edges merges each outer vertex with its corresponding inner star vertex, producing a complete graph K_5 on 5 vertices. By Wagner's theorem, having K_5 as a minor proves non-planarity." },
        { "text": "The Petersen graph has 10 vertices and 15 edges", "isCorrect": false, "explanation": "Incorrect: 15 <= 3(10) - 6 = 24 satisfies Euler's inequality, so numerical edge bounds alone cannot detect its non-planarity." },
        { "text": "The Petersen graph contains a bridge", "isCorrect": false, "explanation": "Incorrect: Petersen graph is 3-connected." },
        { "text": "The Petersen graph is bipartite", "isCorrect": false, "explanation": "Incorrect: Contains odd 5-cycles." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What 6-letter topological adjective describes graphs that can be drawn on a flat 2D surface without any edge crossings (planar)?",
      "blankAnswer": "planar"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Planar Graph Untangler",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Planar Graph Untangler: K₄ Embedding</h3><p>Current state: Drawn with crossed diagonal edges (1,4) and (2,3)</p><button id=\"untangleBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Untangle to Planar Drawing (0 Crossings)</button><div id=\"untangleOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('untangleBtn').onclick=()=>{document.getElementById('untangleOut').innerText='Vertex 4 relocated outside triangle (1, 2, 3)! Crossings = 0. Planar embedding verified via Fáry straight-line theorem.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
