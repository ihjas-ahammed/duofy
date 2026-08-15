# Duofy Reusable Lesson Format: Algebraic & Differential Topology - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Algebraic_and_Differential_Topology`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for fundamental groups $\pi_1(X)$, Betti numbers $b_k$, homology definition identities ($\partial^2 = 0$), and interactive hole counting visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Homology Formula Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Homology Group Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Homotopy Equivalence Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Hole Count Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Hole Counting Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the definition of the k-th Homology Group H_k(X)?",
      "blankAnswer": "H_k(X) = Ker(∂_k) / Im(∂_{k+1}) (k-Cycles modulo k-Boundaries)"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each topological space to its non-zero Homology Groups.",
      "matchPairs": [
        { "left": "Sphere S^2", "right": "H_0 ≅ Z, H_1 = 0, H_2 ≅ Z" },
        { "left": "Torus T^2", "right": "H_0 ≅ Z, H_1 ≅ Z^2, H_2 ≅ Z" },
        { "left": "Circle S^1", "right": "H_0 ≅ Z, H_1 ≅ Z, H_k = 0 for k > 1" },
        { "left": "Möbius Strip", "right": "Homotopy equivalent to S^1 (H_0 ≅ Z, H_1 ≅ Z)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does the punctured plane $\\mathbb{R}^2 \\setminus \\{(0,0)\\}$ have fundamental group $\\pi_1 \\cong \\mathbb{Z}$?",
      "options": [
        { "text": "It deformation retracts onto the unit circle S¹", "isCorrect": true, "explanation": "Correct! Shrinking R² \\ {(0,0)} onto S¹ preserves fundamental group Z." },
        { "text": "Because R² is compact", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because (0,0) is open", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because it has no loops", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What term describes a continuous deformation between two continuous maps f, g: X -> Y?",
      "blankAnswer": "homotopy"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Topological Hole Counter",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Betti Number Inspector</h3><p>Select space with b1 = 2 1D tunnels:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Torus T² (or S¹ ∨ S¹)</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! Torus T² has b1 = 2 independent 1D loops around its hole and handle!'); };</script></div>"
    }
  ]
}
```
