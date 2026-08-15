# Duofy Reusable Lesson Format: Analytic Continuation - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis / Analytic_Continuation`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recall of Schwarz reflection formulas ($f(z) = \overline{f(\overline{z})}$), branch point orders ($z=0$ for $z^{1/n}$), Riemann surface sheet numbers, and interactive branch path simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Schwarz Reflection Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Function & Analytic Continuation Domain Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Riemann Surface Sheet Count Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Singularity Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Multi-Sheet Winding Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the formula for the Schwarz reflection principle extending a holomorphic function across the real line?",
      "blankAnswer": "f(z) = conj(f(conj(z))) for z in the lower half-plane, where conj denotes complex conjugation."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each function/series to its maximal domain of analytic continuation.",
      "matchPairs": [
        { "left": "sum_{n=0}^infty z^n", "right": "C \\ {1} (extended via 1/(1-z))" },
        { "left": "sum_{n=1}^infty (-1)^{n-1} z^n / n", "right": "Cut plane C \\ (-infty, -1] (extended via ln(1+z))" },
        { "left": "sum_{n=0}^infty z^{2^n}", "right": "Open unit disk |z| < 1 (unit circle is a natural boundary)" },
        { "left": "sum_{n=0}^infty z^n / n!", "right": "Entire complex plane C (extended via e^z)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "How many sheets does the Riemann surface of the function f(z) = z^{1/3} have over the punctured complex plane C \\ {0}?",
      "options": [
        { "text": "3 sheets (looping 3 times around z = 0 returns to the initial value)", "isCorrect": true, "explanation": "Correct! Each loop contributes e^{2*pi*i / 3}, so exactly 3 loops are needed to return to the starting branch." },
        { "text": "1 sheet", "isCorrect": false, "explanation": "Incorrect: z^{1/3} is a 3-valued function, not single-valued." },
        { "text": "Infinitely many sheets", "isCorrect": false, "explanation": "Incorrect: ln(z) has infinitely many sheets, but z^{1/3} has only 3." },
        { "text": "2 sheets", "isCorrect": false, "explanation": "Incorrect: 2 sheets is for sqrt(z)." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What term describes a special point around which analytic continuation along a closed loop alters the value of a multi-valued function?",
      "blankAnswer": "branch"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Riemann Surface Winding Explorer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Winding for w = sqrt(z)</h3><p>Current Sheet: <span id=\"sheetNum\" style=\"color:#38bdf8; font-weight:bold;\">Sheet 1 (w = +1)</span></p><button id=\"loopBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Loop 360° around 0</button><script>let s=1; document.getElementById('loopBtn').onclick=()=>{s = (s===1?2:1); document.getElementById('sheetNum').innerText = s===1?'Sheet 1 (w = +1)':'Sheet 2 (w = -1)'; if(s===2 && window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
