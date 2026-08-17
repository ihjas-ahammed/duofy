# Duofy Reusable Lesson Format: Van der Waerden's Theorem and Arithmetic Progressions

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Combinatorics_and_Counting / Ramsey_Theory`  
**Lesson Format Type:** `van_der_waerden_and_arithmetic_progressions`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Arithmetic Ramsey Theory**: evaluate **Van der Waerden's Theorem (1927)** (guaranteeing monochromatic $k$-term arithmetic progressions $a, a+d, \dots, a+(k-1)d$ in any $r$-coloring of integers), contrast with **Szemerédi's Theorem (1975)** (density analogue for subsets with positive upper density), explore the **Erdős-Szekeres Theorem**, and interact with live monochromatic progression search widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Van der Waerden & Szemerédi Theorems Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Arithmetic Combinatorics Theorem & Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Erdős-Szekeres Monotonic Subsequence Bound Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Van der Waerden Number Notation Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Van der Waerden Monochromatic AP Explorer Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "van_der_waerden_and_arithmetic_progressions",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Van der Waerden's Theorem, and how does Szemerédi's Theorem strengthen it?",
      "blankAnswer": "Van der Waerden's Theorem (1927) states that for any positive integers r and k, there exists an integer W(r, k) such that ANY r-coloring of the integers {1, 2, ..., W(r, k)} MUST contain a monochromatic k-term Arithmetic Progression (AP) a, a+d, a+2d, ..., a+(k-1)d. Szemerédi's Theorem (Endre Szemerédi, 1975) is the massive density generalization: ANY subset of integers A subseteq N with positive upper density limsup |A cap {1,...,N}| / N > 0 contains arbitrarily long arithmetic progressions, regardless of coloring!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each arithmetic Ramsey theorem to its core mathematical result.",
      "matchPairs": [
        { "left": "Van der Waerden's Theorem W(r, k)", "right": "Any r-coloring of {1,...,W(r,k)} contains a monochromatic k-term AP" },
        { "left": "Szemerédi's Theorem (1975)", "right": "Every integer subset of positive upper density contains arbitrarily long APs" },
        { "left": "Green-Tao Theorem (2004)", "right": "The prime numbers contain arbitrarily long arithmetic progressions" },
        { "left": "Erdős-Szekeres Theorem (1935)", "right": "Every sequence of length n^2 + 1 contains a monotonic subsequence of length n+1" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "By the Erdős-Szekeres Theorem, what is the MINIMUM length of a numerical sequence guaranteed to contain an increasing OR decreasing subsequence of length 5?",
      "options": [
        { "text": "17 (since (5-1)^2 + 1 = 4^2 + 1 = 16 + 1 = 17)", "isCorrect": true, "explanation": "Correct! The Erdős-Szekeres theorem states that a sequence of length (r-1)(s-1) + 1 contains an increasing subsequence of length r or decreasing of length s. For r = s = 5, length = (4)(4) + 1 = 17." },
        { "text": "25", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "10", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "9", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What hyphenated mathematical term denotes a sequence of numbers with constant difference a, a+d, a+2d (write as arithmetic-progression)?",
      "blankAnswer": "arithmetic-progression"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Van der Waerden AP Finder",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Van der Waerden W(2, 3) = 9</h3><p>Coloring {1, ..., 9} with 2 colors (Red/Blue)</p><button id=\"vdwBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Check Extremal Coloring: RRBBRRBB</button><div id=\"vdwOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('vdwBtn').onclick=()=>{document.getElementById('vdwOut').innerText='Coloring {1..8} = RRBBRRBB avoids 3-term APs. Adding element 9: if Red => {1, 5, 9} is Red AP (d=4). If Blue => {7, 8, 9} is Blue AP (d=1). Monochromatic 3-term AP is mathematically unavoidable at N=9!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
