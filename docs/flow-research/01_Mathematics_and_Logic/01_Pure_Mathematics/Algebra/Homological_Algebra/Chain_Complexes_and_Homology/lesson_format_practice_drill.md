# Duofy Reusable Lesson Format: Chain Complexes and Homology - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Homological_Algebra / Chain_Complexes_and_Homology`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid recall and discrimination speed for homology groups of canonical topological spaces ($S^n$, Torus $T^2$, Mobius band, Klein bottle), Euler characteristic identities, and interactive chain homotopy widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Euler Characteristic Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Space & Homology Group Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Chain Homotopy Invariance Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Boundary Map Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Cycle vs Boundary Explorer | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Euler-Poincaré formula relating chain complex ranks to homology group ranks?",
      "blankAnswer": "The alternating sum of chain ranks equals the alternating sum of Betti numbers: sum (-1)^n rank(C_n) = sum (-1)^n rank(H_n(C))."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each topological space to its first homology group H_1.",
      "matchPairs": [
        { "left": "Circle S^1", "right": "H_1 = Z" },
        { "left": "Torus T^2 = S^1 x S^1", "right": "H_1 = Z x Z" },
        { "left": "2-Sphere S^2", "right": "H_1 = 0" },
        { "left": "Real Projective Plane RP^2", "right": "H_1 = Z / 2Z" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "If two chain maps f, g : C_* -> D_* are chain homotopic (f ≃ g), what is the relationship between their induced maps on homology?",
      "options": [
        { "text": "H_n(f) = H_n(g) for all n", "isCorrect": true, "explanation": "Correct! Chain homotopic maps induce identical homomorphisms on all homology groups." },
        { "text": "H_n(f) = - H_n(g)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "H_n(f) and H_n(g) are mutually orthogonal", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Their composition is zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What geometric term is used for a chain c satisfying d(c) = 0?",
      "blankAnswer": "cycle"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Cycle vs Boundary Demonstrator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Cycles Z_n vs Boundaries B_n</h3><p>Click to test whether a closed loop is filled (boundary) or hollow (non-trivial homology cycle):</p><div style=\"display:flex; gap:10px; margin:15px 0;\"><button id=\"hollowBtn\" style=\"padding:8px 16px; background:#334155; color:white; border:none; border-radius:6px; cursor:pointer;\">Hollow Loop (H_1 != 0)</button><button id=\"filledBtn\" style=\"padding:8px 16px; background:#334155; color:white; border:none; border-radius:6px; cursor:pointer;\">Filled Disk (H_1 = 0)</button></div><div id=\"res\" style=\"color:#38bdf8; font-weight:bold;\"></div><script>document.getElementById('hollowBtn').onclick=()=>{document.getElementById('res').innerText='Cycle is NOT a boundary -> [c] generates H_1 = Z!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');}; document.getElementById('filledBtn').onclick=()=>{document.getElementById('res').innerText='Cycle is a boundary of 2-disk -> [c] = 0 in H_1!';};</script></div>"
    }
  ]
}
```
