# Duofy Reusable Lesson Format: Ideals and Primary Decomposition - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Commutative_Algebra / Ideals_and_Primary_Decomposition`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of associated primes ($\text{Ass}(R/I)$), zero-divisor unions ($\mathcal{Z}(R/I) = \bigcup \mathfrak{p}_i$), and interactive primary intersection widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Primary vs Prime Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Ideal & Primary Decomposition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Zero-Divisor & Annihilator Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Primary Property Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Ideal Intersection Simulator | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the relationship between the set of zero-divisors of R/I and the associated primes of R/I in a Noetherian ring?",
      "blankAnswer": "The set of zero-divisors of R/I is equal to the exact union of all associated prime ideals in Ass(R/I)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each ideal in k[x, y] to its minimal primary decomposition.",
      "matchPairs": [
        { "left": "(x^2, xy)", "right": "(x) ∩ (x^2, y)" },
        { "left": "(xy)", "right": "(x) ∩ (y)" },
        { "left": "(x^2, y^3)", "right": "(x^2, y^3) is already (x, y)-primary" },
        { "left": "(x^2, xy, xz)", "right": "(x) ∩ (x^2, y, z)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "If I = q_1 ∩ ... ∩ q_k is a minimal primary decomposition in a Noetherian ring R, when is a prime ideal p in Ass(R/I) called an isolated (minimal) prime?",
      "options": [
        { "text": "When p does not strictly contain any other prime ideal in Ass(R/I)", "isCorrect": true, "explanation": "Correct! Minimal (isolated) primes are minimal elements with respect to inclusion in Ass(R/I)." },
        { "text": "When p is a maximal ideal of R", "isCorrect": false, "explanation": "Incorrect: An isolated prime does not have to be maximal (e.g. (x) in k[x, y])." },
        { "text": "When p = (0)", "isCorrect": false, "explanation": "Incorrect: Isolated primes can be non-zero." },
        { "text": "When the primary component is non-unique", "isCorrect": false, "explanation": "Incorrect: Isolated primary components are unique; embedded ones are not." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What mathematical term describes the unique ideal consisting of all elements whose power eventually lands in ideal I?",
      "blankAnswer": "radical"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Monomial Ideal Decomposition Explorer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Decompose (x^2, xy)</h3><p>Select components to reconstruct I = (x^2, xy):</p><div style=\"display:flex; gap:10px; margin:15px 0;\"><button id=\"c1\" style=\"padding:8px 16px; background:#334155; color:white; border:none; border-radius:6px; cursor:pointer;\">(x) [Minimal Line]</button><button id=\"c2\" style=\"padding:8px 16px; background:#334155; color:white; border:none; border-radius:6px; cursor:pointer;\">(x^2, y) [Embedded Point]</button></div><button id=\"check\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Compute Intersection ∩</button><div id=\"out\" style=\"margin-top:10px; color:#10b981; font-weight:bold;\"></div><script>let s1=false, s2=false; document.getElementById('c1').onclick=()=>{s1=!s1;document.getElementById('c1').style.background=s1?'#059669':'#334155';};document.getElementById('c2').onclick=()=>{s2=!s2;document.getElementById('c2').style.background=s2?'#059669':'#334155';};document.getElementById('check').onclick=()=>{if(s1 && s2){document.getElementById('out').innerText='(x) ∩ (x^2, y) = (x^2, xy)! Correct minimal primary decomposition.';if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');}else{document.getElementById('out').innerText='Select both components!';}};</script></div>"
    }
  ]
}
```
