# Duofy Reusable Lesson Format: Dimension Theory - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Commutative_Algebra / Dimension_Theory`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid recall and discrimination speed for dimension classifications across different ring families (Fields, PIDs, Polynomial rings, Local Noetherian rings), height-coheight identities, and interactive prime ideal chain visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Dimension Flashcard Recall | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Ring & Krull Dimension Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Catenary & Altitude Discrimination Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Ring Classification Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Prime Chain Lattice | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Krull dimension of any Principal Ideal Domain (PID) that is not a field?",
      "blankAnswer": "1, because all non-zero prime ideals are maximal, yielding the longest chain (0) ⊊ (p)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each commutative ring to its exact Krull dimension.",
      "matchPairs": [
        { "left": "C[x, y, z]", "right": "Dimension 3" },
        { "left": "Z", "right": "Dimension 1" },
        { "left": "Q", "right": "Dimension 0" },
        { "left": "R[x, y] / (x^2 + y^2 - 1)", "right": "Dimension 1" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "A ring R is called catenary if for any two prime ideals p ⊊ q:",
      "options": [
        { "text": "All saturated chains of prime ideals between p and q have the same length", "isCorrect": true, "explanation": "Correct! Catenary rings ensure that dimension behaves consistently along all maximal chains." },
        { "text": "The ring has finite Krull dimension", "isCorrect": false, "explanation": "Incorrect: Having finite dimension is necessary but not sufficient for catenarity." },
        { "text": "Every ideal is principal", "isCorrect": false, "explanation": "Incorrect: Catenarity is a property of prime ideal chains, not ideal generation." },
        { "text": "The ring is local and Artinian", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What property describes a ring where all saturated prime ideal chains between any two primes have equal length?",
      "blankAnswer": "catenary"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Krull Dimension Chain Explorer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Prime Chain in k[x, y]</h3><p>Click nodes to ascend the maximal chain (0) ⊂ (x) ⊂ (x, y)</p><div style=\"display:flex; gap:10px; margin:15px 0;\"><button id=\"b0\" style=\"padding:8px 16px; background:#334155; color:white; border:none; border-radius:6px; cursor:pointer;\">(0) [Dim 2]</button><button id=\"b1\" style=\"padding:8px 16px; background:#334155; color:white; border:none; border-radius:6px; cursor:pointer;\">(x) [Dim 1]</button><button id=\"b2\" style=\"padding:8px 16px; background:#334155; color:white; border:none; border-radius:6px; cursor:pointer;\">(x, y) [Dim 0]</button></div><div id=\"out\" style=\"color:#10b981; font-weight:bold;\"></div><script>let s=0; document.getElementById('b0').onclick=()=>{s=1;document.getElementById('b0').style.background='#2563eb';};document.getElementById('b1').onclick=()=>{if(s===1){s=2;document.getElementById('b1').style.background='#2563eb';}};document.getElementById('b2').onclick=()=>{if(s===2){document.getElementById('b2').style.background='#10b981';document.getElementById('out').innerText='Chain length = 2 => dim k[x,y] = 2!';if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');}};</script></div>"
    }
  ]
}
```
