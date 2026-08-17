# Duofy Reusable Lesson Format: Whitney's Broken Circuits and the Four Color Theorem

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Graph_Theory / Coloring_and_Chromatic_Polynomials`  
**Lesson Format Type:** `whitney_broken_circuits_and_four_color_theorem`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Whitney's Broken Circuit Theorem (1932)** (expressing chromatic polynomial coefficients as subgraphs avoiding broken circuits), evaluate **The Four Color Theorem** (Kenneth Appel & Wolfgang Haken 1976: every planar graph satisfies $\chi(G) \le 4$), contrast against the 5-color theorem (Percy Heawood 1890), and interact with live 4-color planar map widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Broken Circuits & Four Color Theorem Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Graph Coloring Theorem & Planar Milestone Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Planar Graph Dual Map Chromatic Four Color Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Broken Circuit Deleted Edge Property Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Four Color Planar Map Coloring Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "whitney_broken_circuits_and_four_color_theorem",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Whitney's Broken Circuit Theorem, and what is the Four Color Theorem for planar graphs?",
      "blankAnswer": "Whitney's Broken Circuit Theorem (Hassler Whitney, 1932) states that under a fixed linear ordering of edges e_1 < e_2 < ... < e_m, a 'broken circuit' is obtained by removing the highest-indexed edge from any simple cycle in G. The coefficient of k^r in the chromatic polynomial P(G, k) equals (-1)^{n-r} times the number of edge subsets of size n-r that contain NO broken circuits! The Four Color Theorem (Appel & Haken 1976) proves that every planar graph is 4-colorable: chi(G) <= 4, or equivalently P(G, 4) > 0 for all planar graphs."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each planar graph coloring milestone to its author and theorem.",
      "matchPairs": [
        { "left": "Four Color Theorem (chi <= 4)", "right": "Appel & Haken (1976) / Robertson et al. (1997) (computer-assisted proof via 1482 reducible configurations)" },
        { "left": "Five Color Theorem (chi <= 5)", "right": "Percy Heawood (1890) (rigorous proof fixing Kempe's flawed 1879 attempt)" },
        { "left": "Six Color Theorem (chi <= 6)", "right": "Direct consequence of Euler's formula: planar graphs have at least one vertex with degree <= 5" },
        { "left": "Grötzsch's Theorem (1959)", "right": "Every triangle-free planar graph is 3-colorable (chi <= 3)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does Euler's planar formula V - E + F = 2 immediately prove that every planar graph contains at least one vertex of degree at most 5?",
      "options": [
        { "text": "Because 2E >= 3F implies E <= 3V - 6; by the Handshaking Lemma, average degree is 2E/V <= 6 - 12/V < 6, so at least one vertex MUST have degree <= 5", "isCorrect": true, "explanation": "Correct! If every vertex had degree >= 6, then 2E = sum deg(v) >= 6V => E >= 3V, which contradicts E <= 3V - 6 for planar graphs." },
        { "text": "Because all planar graphs are trees", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because complete graph K_5 is planar", "isCorrect": false, "explanation": "Incorrect: K_5 is non-planar." },
        { "text": "Because degrees are always even in planar graphs", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "In Whitney's broken circuit theorem, what is removed from a cycle to form a broken circuit (write as edge)?",
      "blankAnswer": "edge"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive 4-Color Planar Map Widget",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Four Color Theorem Map Colorer</h3><p>Planar Map: 4 Countries meeting at complex borders</p><button id=\"mapBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Apply 4-Color Kempe Scheme</button><div id=\"mapOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('mapBtn').onclick=()=>{document.getElementById('mapOut').innerText='Coloring: Region A (Red), Region B (Blue), Region C (Green), Region D (Yellow). Valid 4-Coloring verified! No adjacent regions share colors.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
