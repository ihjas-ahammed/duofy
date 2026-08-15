# Duofy Reusable Lesson Format: Number Fields and Rings of Integers - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Algebraic_Number_Theory / Number_Fields_and_Rings_of_Integers`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of Dedekind domain prime behavior (split, inert, ramified), quadratic field discriminant calculations ($\Delta_K = d$ vs $4d$), Dirichlet unit rank computations ($r + s - 1$), and interactive prime ideal factorization simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Prime Ramification Discriminant Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Quadratic Field & Discriminant $\Delta_K$ Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Imaginary Quadratic Field Unit Group Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Ring Classification Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Dedekind-Kummer Prime Splitting Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "Which rational primes p ramify (have repeated prime ideal factors p = p_1^2 ...) in the ring of integers O_K of a number field K?",
      "blankAnswer": "A prime p ramifies in O_K if and only if p divides the field discriminant Delta_K (Dedekind's Discriminant Theorem)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each quadratic field Q(sqrt{d}) to its fundamental field discriminant Delta_K.",
      "matchPairs": [
        { "left": "Q(i) with d = -1", "right": "Delta_K = -4 (since -1 = 3 mod 4 => 4d)" },
        { "left": "Q(sqrt{-3}) with d = -3", "right": "Delta_K = -3 (since -3 = 1 mod 4 => d)" },
        { "left": "Q(sqrt{5}) with d = 5", "right": "Delta_K = 5 (since 5 = 1 mod 4 => d)" },
        { "left": "Q(sqrt{2}) with d = 2", "right": "Delta_K = 8 (since 2 = 2 mod 4 => 4d)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "For which imaginary quadratic field Q(sqrt{-d}) (d > 0) does the group of units O_K^* contain SIX elements (mu_6)?",
      "options": [
        { "text": "Q(sqrt{-3}) (the Eisenstein integers Z[omega] where omega = e^{2pi i / 3})", "isCorrect": true, "explanation": "Correct! Q(sqrt{-3}) has 6 units (+-1, +-omega, +-omega^2). Q(i) has 4 units (+-1, +-i), and all other imaginary quadratic fields have only 2 units (+-1)." },
        { "text": "Q(i)", "isCorrect": false, "explanation": "Incorrect: Q(i) has exactly 4 units." },
        { "text": "Q(sqrt{-5})", "isCorrect": false, "explanation": "Incorrect: Q(sqrt{-5}) has only 2 units (+-1)." },
        { "text": "Q(sqrt{-7})", "isCorrect": false, "explanation": "Incorrect: Q(sqrt{-7}) has 2 units." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the German mathematician whose named domains feature unique factorization of non-zero ideals into prime ideals?",
      "blankAnswer": "dedekind"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Prime Splitting in Z[i]",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Prime Splitting in Gaussian Integers Z[i]</h3><p>Select a rational prime p:</p><div style=\"display:flex; gap:10px; margin:15px 0;\"><button id=\"p2\" style=\"padding:8px 16px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">p = 2</button><button id=\"p5\" style=\"padding:8px 16px; background:#334155; color:white; border:none; border-radius:6px; cursor:pointer;\">p = 5 (1 mod 4)</button><button id=\"p7\" style=\"padding:8px 16px; background:#334155; color:white; border:none; border-radius:6px; cursor:pointer;\">p = 7 (3 mod 4)</button></div><div id=\"primeOut\" style=\"color:#38bdf8; font-weight:bold;\">p = 2: Ramified! (2) = (1+i)^2</div><script>document.getElementById('p2').onclick=()=>{document.getElementById('primeOut').innerText='p = 2: RAMIFIED! (2) = (1+i)^2 with norm 2.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');}; document.getElementById('p5').onclick=()=>{document.getElementById('primeOut').innerText='p = 5 (1 mod 4): SPLIT! (5) = (2+i)(2-i) into two distinct prime ideals.';}; document.getElementById('p7').onclick=()=>{document.getElementById('primeOut').innerText='p = 7 (3 mod 4): INERT! (7) remains a prime ideal in Z[i].';};</script></div>"
    }
  ]
}
```
